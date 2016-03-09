defmodule Github.User do
  defstruct avatar_url: nil, login: nil, html_url: nil
end

defmodule Github.Comment do
  defstruct html_url: nil, commit_id: nil, body: nil, user: %Github.User{}
end

defmodule Github.Issue do
  defstruct title: nil
end

defmodule Github.Mention do
  alias Github.{Mention, Comment, Issue}

  @opaque t :: %Mention{}
  defstruct comment: %Comment{}, issue: %Issue{}

  def from_github_json(json) do
    Poison.decode!(json, as: %Mention{})
  end

  @spec type(Mention.t) :: :comment | :issue
  def type(%Mention{issue: %Issue{}}), do: :comment
  def type(%Mention{issue: _}), do: :issue

end
