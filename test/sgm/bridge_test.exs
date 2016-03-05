defmodule SGM.BridgeTest do
  use ExUnit.Case
  alias SGM.Bridge
  alias Github.Mention
  alias Slack.Message

  @commit_short_sha "a75531c"
  @comment %{
    body: "some comment with @gh_user",
    html_url: "https://github.com/org/repo/commit/sha#commitcomment-16497684",
    commit_id: "#{@commit_short_sha}444b329da5e4ba248ff12b9bfea9a77a5",
    user: %{
      avatar_url: "https://avatars.githubusercontent.com/u/123?v=3",
      login: "zaboco",
      html_url: "https://github.com/zaboco"
    }
  }

  @mentioned_user "slack_user"

  @message %Message{
    text: Bridge.statics(:commit).headline,
    channel: "@#{@mentioned_user}",
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

  test "mention_to_message" do
    mention = %Mention{comment: @comment}
    assert Bridge.mention_to_message(mention, @mentioned_user) == @message
  end

end
