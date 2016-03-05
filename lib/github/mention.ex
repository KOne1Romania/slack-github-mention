defmodule Github.Mention do
  alias Github.{Mention, Comment}

  @user_struct %{avatar_url: nil, login: nil, html_url: nil}
  @comment_struct %{html_url: nil, commit_id: nil, body: nil, user: @user_struct}

  @opaque t :: %Mention{}
  defstruct comment: @comment_struct

  def from_github_json(json) do
    Poison.decode!(json, as: %Mention{}, keys: :atoms!)
  end
end
