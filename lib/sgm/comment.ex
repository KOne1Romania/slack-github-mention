defmodule SGM.Comment do
  alias SGM.Comment

  defstruct body: "", html_url: "", user_avatar_url: "", commit_id: ""
  @opaque t :: %Comment{
    body: String.t,
    html_url: String.t,
    user_avatar_url: String.t,
    commit_id: String.t
  }

  def from_github_event(%{comment: comment}) do
    comment_map =
      comment
      |> Map.take([:body, :html_url, :commit_id])
      |> Map.put_new(:user_avatar_url, comment.user.avatar_url)
    struct(Comment, comment_map)
  end
end
