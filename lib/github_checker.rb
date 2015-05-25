require 'open-uri'

class GithubChecker
  def initialize(source_url)
    @source_url   = source_url
    @api_endpoint = 'https://api.github.com/repos'
    @repo         = parse_repo
    @repo_data    = @repo ? JSON.parse(request_repo_data) : nil
  end

  def check_stars
    @repo_data ? @repo_data['stargazers_count'] : 0
  end

  def check_description
    @repo_data ? @repo_data['description'] : nil
  end

private

  def parse_repo
    matches = @source_url.match github_regexp
    return nil unless matches
    owner   = matches[:owner]
    name    = matches[:name]
    "#{owner}/#{name}"
  end

  def github_regexp
    %r{
      \A(https?:\/\/(w{3}\.)?)? # protocol and www optional at start
      github\.com\/             # domain name
      (?<owner>[\w\-\.]+)\/     # owner of repo
      (?<name>[\w\-\.]+)\/?\z   # name of repo at end
    }x
  end

  def request_repo_data
    open("#{@api_endpoint}/#{@repo}").read
  end
end
