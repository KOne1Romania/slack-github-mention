defmodule SlackGithubMention.MentionTest do
  use ExUnit.Case
  alias SlackGithubMention.{Mention, Comment}

  @comment %Comment{
    body: "mentioning @a and @b",
    html_url: "html_url",
    user_avatar_url: "user_avatar_url",
    commit_id: "commit_id"
  }

  test "all_from_comment parses mentions from comment body" do
    assert Mention.all_from_comment(@comment) == [
      %Mention{comment: @comment, username: "a"},
      %Mention{comment: @comment, username: "b"}
    ]
  end
end
