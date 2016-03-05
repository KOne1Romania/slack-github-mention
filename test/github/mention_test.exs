defmodule Github.MentionTest do
  use ExUnit.Case
  alias Github.Mention

  @fields %{
    comment: %{
      body: "some comment with @mention",
      html_url: "https://github.com/org/repo/commit/sha#commitcomment-16497684",
      commit_id: "a75531c444b329da5e4ba248ff12b9bfea9a77a5",
      user: %{
        avatar_url: "https://avatars.githubusercontent.com/u/123?v=3",
        login: "zaboco",
        html_url: "https://github.com/zaboco"
      }
    }
  }

  @github_json """
  {
    "comment": {
      "html_url": "#{@fields.comment.html_url}",
      "user": {
        "avatar_url": "#{@fields.comment.user.avatar_url}",
        "html_url": "#{@fields.comment.user.html_url}",
        "login": "#{@fields.comment.user.login}"
      },
      "commit_id": "#{@fields.comment.commit_id}",
      "body": "#{@fields.comment.body}"
    }
  }
  """

  test "parser correctly" do
    assert Mention.from_github_json(@github_json) == struct(Mention, @fields)
  end
end
