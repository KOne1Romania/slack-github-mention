defmodule Github.User do
  defstruct avatar_url: nil, login: nil, html_url: nil
end

defmodule Github.Comment do
  defstruct html_url: nil, commit_id: nil, body: nil, user: %Github.User{}
end

defmodule Github.Mention do
  alias Github.{Mention, Comment}

  @opaque t :: %Mention{}
  defstruct comment: %Comment{}

  def from_github_json(json) do
    Poison.decode!(json, as: %Mention{})
  end
end
