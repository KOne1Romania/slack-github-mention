defmodule SGM.CommentTest do
  use ExUnit.Case
  alias SGM.Comment

  @fields %{
    body: "some comment with @mention",
    html_url: "https://github.com/Kalon/repo/commit/sha#commitcomment-16497684",
    user_avatar_url: "https://avatars.githubusercontent.com/u/123?v=3",
    commit_id: "a75531c444b329da5e4ba248ff12b9bfea9a77a5"
  }
  @github_event_partial_string """
  {
    "comment": {
      "html_url": "#{@fields.html_url}",
      "user": {
        "avatar_url": "#{@fields.user_avatar_url}"
      },
      "commit_id": "#{@fields.commit_id}",
      "body": "#{@fields.body}"
    }
  }
  """

  test "from_github_event (commit)" do
    actual = Comment.from_github_event github_event_partial
    expected = struct(Comment, @fields)
    assert actual == expected
  end

  defp github_event_partial do
    {:ok, data} = Poison.decode @github_event_partial_string, keys: :atoms!
    data
  end
end
