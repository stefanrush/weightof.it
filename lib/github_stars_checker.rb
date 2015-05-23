require 'open-uri'

class GithubStarsChecker
  def initialize(source_url)
    @source_url    = source_url
    @api_endpoint  = 'https://api.github.com/repos'
    @github_regexp = %r{
      \A(https?:\/\/(w{3}\.)?)? # protocol and www optional at start
      github\.com\/             # domain name
      (?<owner>[\w\-\.]+)\/     # owner of repo
      (?<name>[\w\-\.]+)\/?\z   # name of repo at end
    }x
  end

  def check_stars
    stars = 0
    if is_github_repo? @source_url
      repo  = parse_repo(@source_url)
      stars = number_of_stars(repo)
    end
    stars
  end

private
  
  def is_github_repo?(url)
    url =~ @github_regexp
  end

  def parse_repo(url)
    matches = url.match @github_regexp
    owner   = matches[:owner]
    name    = matches[:name]
    "#{owner}/#{name}"
  end

  def number_of_stars(repo)
    repo_data = open("#{@api_endpoint}/#{repo}").read
    JSON.parse(repo_data)['stargazers_count']
  end
end
