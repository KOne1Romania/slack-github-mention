defmodule SGM.BridgeTest do
  use ExUnit.Case
  alias SGM.Bridge
  alias Github.Mention
  alias Github.InMemory, as: GithubClient
  alias Slack.Message

  @commit_short_sha "a75531c"
  @comment %{
    body: "some comment with @gh_user and @gh_user2",
    html_url: "https://github.com/org/repo/commit/sha#commitcomment-16497684",
    commit_id: "#{@commit_short_sha}444b329da5e4ba248ff12b9bfea9a77a5",
    user: %{
      avatar_url: "https://avatars.githubusercontent.com/u/123?v=3",
      login: "zaboco",
      html_url: "https://github.com/zaboco"
    }
  }

  @mentioned_users ["slack_user", "slack_user2"]

  test "mention_to_messages makes messages for all mentioned users" do
    mention = %Mention{comment: @comment}
    expected_messages = Enum.map(@mentioned_users, &message_for/1)
    assert Bridge.mention_to_messages(mention, GithubClient, GithubClient.domain) == expected_messages
  end

  test "mention_to_messages makes no message if no user was mentioned" do
    bare_comment = %{@comment | body: "no mention in this comment"}
    pseudo_mention = %Mention{comment: bare_comment}
    assert Bridge.mention_to_messages(pseudo_mention, nil, "") == []
  end

  defp message_for(mentioned_user) do
    %Message{
      text: Bridge.statics(:commit).headline,
      channel: "@#{mentioned_user}",
      author: %{
        name: @comment.user.login,
        link: @comment.user.html_url,
        icon: @comment.user.avatar_url
      },
      body: %{
        title: "Commit @#{@commit_short_sha}",
        title_link: @comment.html_url,
        text: @comment.body,
        thumb_url: Bridge.statics(:commit).thumb_url
      }
    }
  end

end
