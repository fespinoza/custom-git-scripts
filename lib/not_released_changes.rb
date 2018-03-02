class NotReleasedChanges
  attr_reader :base_ref, :current_ref

  @@output = $stdout

  def self.print_usage
    @@output.puts "Usage: git not-released [base-ref] [current-ref](optional)"
  end

  def initialize(base_ref, current_ref)
    @base_ref    = base_ref
    @current_ref = current_ref
  end

  def print_formatted_change_list
    formatted_change_list.each do |commit_title|
      @@output.puts commit_title
    end
  end

  private

  LOG_FORMAT = '- %cn: %s%n%w(80, 2, 2)%b'
  GITHUB_MERGE_COMMIT_FORMAT = /Merge pull request (?<pr_number>#\d+) .*/
  MERGE_BRANCH_COMMIT_FORMAT = /Merge branch '.*' into .*/

  def formatted_change_list
    parsed_merge_commits.map do |pair|
      format_merge_commit(pair.first, pair.last)
    end
  end

  def parsed_merge_commits
    merge_commits_not_merged_into_base_ref
      .split('- ')
      .reject(&:empty?)
      .reject { |line| line.match(MERGE_BRANCH_COMMIT_FORMAT) }
      .map { |e| e.split("\n") }
  end

  def format_merge_commit(github_commit_title, commit_title)
    pr_number = pull_request_number_for(github_commit_title)
    "- #{pr_number}: #{commit_title.strip}"
  end

  def merge_commits_not_merged_into_base_ref
    `git log --merges #{base_ref}..#{current_ref} --format='#{LOG_FORMAT}'`
  end

  def pull_request_number_for(github_commit_title)
    md = github_commit_title.match(GITHUB_MERGE_COMMIT_FORMAT)
    md[:pr_number] if md
  end
end
