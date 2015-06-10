require 'open-uri'

class GithubChecker
  def initialize(source_url)
    @source_url   = source_url
    @api_endpoint = 'https://api.github.com/repos'
    @repo         = @source_url ? parse_repo : nil
    @repo_data    = @repo ? request_repo_data : nil
  end

  # Returns number of stars on GitHub repo or zero if repo doesn't exist
  def check_stars
    @repo_data ? @repo_data['stargazers_count'] : 0
  end

  # Returns description GitHub repo or zero if repo doesn't exist
  def check_description
    @repo_data ? @repo_data['description'] : nil
  end

private

  # Returns the name of Github repo in :owner/:name format
  def parse_repo
    matches = @source_url.match github_regexp
    return nil unless matches
    owner = matches[:owner]
    name  = matches[:name]
    "#{owner}/#{name}"
  end

  # Return a regular express for matching GitHub repo URLs
  def github_regexp
    %r{
      \A(https?:\/\/(w{3}\.)?)? # protocol and www optional at start
      github\.com\/             # domain name
      (?<owner>[\w\-\.]+)\/     # owner of repo
      (?<name>[\w\-\.]+)\/?\z   # name of repo at end
    }x
  end

  # Returns JSON data for repo from GitHub API
  def request_repo_data
    # "Authentication" => Figaro.env.github_access_token
    JSON.parse open("#{@api_endpoint}/#{@repo}").read
  end
end
