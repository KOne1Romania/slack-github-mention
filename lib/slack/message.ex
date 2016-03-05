defmodule Slack.Message do
  alias Slack.Message
  import ShortMaps

  @author_struct %{name: nil, link: nil, icon: nil}
  @body_struct %{title: nil, tile_link: nil, text: nil, thumb_url: nil}

  @opaque t :: %Message{}
  defstruct [:text, :channel, author: @author_struct, body: @body_struct]

  defimpl Poison.Encoder do
    def encode(~m{text channel author body}a, options) do
      Poison.Encoder.encode(%{
        text: text,
        channel: channel,
        attachments: [%{
          color: "good",
          author_name: author.name,
          author_link: author.link,
          author_icon: author.icon,
          title: body.title,
          title_link: body.title_link,
          text: body.text,
          thumb_url: body.thumb_url,
        }]
      }, options)
    end
  end
end
