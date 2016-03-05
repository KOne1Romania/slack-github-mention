defmodule Slack.MessageTest do
  use ExUnit.Case
  alias Slack.Message

  @fields %{
    text: "Mention",
    channel: "@slackbot",
    author: %{
      name: "zaboco",
      link: "gh/zaboco",
      icon: "gh/icons/zaboco"
    },
    body: %{
      title: "Commit @1234567",
      title_link: "gh/commits/1234567",
      text: "Comment on the commit @slackbot",
      thumb_url: "gh/icons/commit"
    }
  }

  @message_json """
  {
    "text": "#{@fields.text}",
    "channel": "#{@fields.channel}",
    "attachments": [
      {
        "color": "good",
        "author_name": "#{@fields.author.name}",
        "author_link": "#{@fields.author.link}",
        "author_icon": "#{@fields.author.icon}",
        "title": "#{@fields.body.title}",
        "title_link": "#{@fields.body.title_link}",
        "text": "#{@fields.body.text}",
        "thumb_url": "#{@fields.body.thumb_url}"
      }
    ]
  }
  """

  test "encode" do
    message = struct(Message, @fields)
    assert same_jsons(Poison.encode!(message), @message_json)
  end

  defp same_jsons(json_a, json_b) do
    [a, b] = Enum.map([json_a, json_b], &Poison.decode!/1)
    a == b
  end
end
