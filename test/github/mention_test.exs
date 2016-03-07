defmodule Github.MentionTest do
  use ExUnit.Case
  alias Github.{Mention, Comment, User, Issue}

  test "commit event parses correctly" do
    commit_mention = %Mention{
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
    github_commit_json = """
    {
      "action": "__irrelevant__",
      "comment": {
        "html_url": "#{commit_mention.comment.html_url}",
        "user": {
          "gravatar_id": "__irrelevant__",
          "avatar_url": "#{commit_mention.comment.user.avatar_url}",
          "html_url": "#{commit_mention.comment.user.html_url}",
          "login": "#{commit_mention.comment.user.login}"
        },
        "commit_id": "#{commit_mention.comment.commit_id}",
        "body": "#{commit_mention.comment.body}"
      }
    }
    """

    assert Mention.from_github_json(github_commit_json) == commit_mention
  end

  test "issue event parses correctly" do
    issue_mention = %Mention{
      issue: %Issue{
        title: "Some issue"
      },
      comment: %Comment{
        body: "some comment with @mention",
        html_url: "https://github.com/org/repo/issues/1#issuecomment-16497684",
        user: %User{
          avatar_url: "https://avatars.githubusercontent.com/u/123?v=3",
          login: "zaboco",
          html_url: "https://github.com/zaboco"
        }
      }
    }
    github_issue_json = """
    {
      "action": "__irrelevant__",
      "issue": {
        "title": "#{issue_mention.issue.title}"
      },
      "comment": {
        "html_url": "#{issue_mention.comment.html_url}",
        "user": {
          "gravatar_id": "__irrelevant__",
          "avatar_url": "#{issue_mention.comment.user.avatar_url}",
          "html_url": "#{issue_mention.comment.user.html_url}",
          "login": "#{issue_mention.comment.user.login}"
        },
        "body": "#{issue_mention.comment.body}"
      }
    }
    """

    assert Mention.from_github_json(github_issue_json) == issue_mention
  end
end
