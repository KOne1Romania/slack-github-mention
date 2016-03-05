defmodule Github.MentionTest do
  use ExUnit.Case
  alias Github.{Mention, Comment, User}

  @mention %Mention{
    comment: %Comment{
      body: "some comment with @mention",
      html_url: "https://github.com/org/repo/commit/sha#commitcomment-16497684",
      commit_id: "a75531c444b329da5e4ba248ff12b9bfea9a77a5",
      user: %User{
        avatar_url: "https://avatars.githubusercontent.com/u/123?v=3",
        login: "zaboco",
        html_url: "https://github.com/zaboco"
      }
    }
  }

  @github_json """
  {
    "actions": "__irrelevant__",
    "comment": {
      "html_url": "#{@mention.comment.html_url}",
      "user": {
        "gravatar_id": "__irrelevant__",
        "avatar_url": "#{@mention.comment.user.avatar_url}",
        "html_url": "#{@mention.comment.user.html_url}",
        "login": "#{@mention.comment.user.login}"
      },
      "commit_id": "#{@mention.comment.commit_id}",
      "body": "#{@mention.comment.body}"
    }
  }
  """

  test "parser correctly" do
    assert Mention.from_github_json(@github_json) == @mention
  end
end
