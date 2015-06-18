class GithubChecker
  include HTTParty
  base_uri 'https://api.github.com/repos'

  # Accepts source code URL for GitHub repo
  def initialize(source_url)
    @source_url    = source_url
    @token         = Figaro.env.github_access_token
    @github_regexp = %r{
      \A(https?:\/\/(w{3}\.)?)? # protocol and www optional at start
      github\.com\/             # domain name
      (?<owner>[\w\-\.]+)\/     # owner of repo
      (?<name>[\w\-\.]+)\/?\z   # name of repo at end
    }x

    @repo      = @source_url ? parse_repo        : nil
    @repo_data = @repo       ? request_repo_data : nil
  end

  # Returns description GitHub repo or nil if repo doesn't exist
  def check_description
    @repo_data ? @repo_data['description'] : nil
  end

  # Returns number of stars on GitHub repo or zero if repo doesn't exist
  def check_stars
    @repo_data ? @repo_data['stargazers_count'] : 0
  end

private

  # Returns the name of Github repo in :owner/:name format
  def parse_repo
    matches = @source_url.match @github_regexp
    return unless matches
    owner = matches[:owner]
    name  = matches[:name]
    "#{owner}/#{name}"
  end

  # Returns JSON data for repo from GitHub API
  def request_repo_data
    self.class.get("/#{@repo}", headers: {
      'Authorization' => "token #{@token}",
      'User-Agent'    => 'stefanrush/weightof.it'
    })
  end
end
