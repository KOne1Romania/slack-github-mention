defmodule Github.InMemory do
  use Github

  def user_emails(gh_uname) do
    emails = Application.get_env(:sgm, :github_client).emails
    emails[gh_uname]
  end

  def domain do
    Application.get_env(:sgm, :domain)
  end
end
