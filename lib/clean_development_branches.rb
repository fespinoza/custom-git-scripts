class CleanDevelopmentBranches
  attr_reader :base_branch

  @@output = $stdout

  def self.output
    @@output
  end

  def self.usage
    <<-EXPLANATION
  Usage: git clean-development-branches [base-branch]

  [base-branch]: the stable branch of development (default: master)

  Deletes all the branches that were merged into `base-branch`
EXPLANATION
  end

  def initialize(base_branch)
    @base_branch = base_branch
  end

  def call
    execute_in_base_branch do
      development_branches.each { |branch| system("git branch -d #{branch}") }
    end
  end

  private

  def execute_in_base_branch
    if in_base_branch?
      yield
    else
      system("git checkout #{base_branch}")
      yield
      system('git checkout -')
    end
  end

  def development_branches
    `git branch --merged`
      .split("\n")
      .map(&:strip)
      .reject { |e| e.match(/\s?#{base_branch}/) }
  end

  def in_base_branch?
    current_branch == base_branch
  end

  def current_branch
    `git rev-parse --abbrev-ref HEAD`.chomp
  end
end
