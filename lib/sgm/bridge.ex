defmodule SGM.Bridge do
  import ShortMaps
  alias Github.Mention
  alias Slack.Message

  @mention_pattern ~r/@([^\s]+)/

  @spec mention_to_messages(Mention.t, Github.t, String.t) :: [Message.t]
  def mention_to_messages(~m{%Mention comment}a = mention, github_client, domain) do
    extract_mentioned_names(comment.body)
    |> Enum.map(&github_client.user_email_name &1, domain)
    |> Enum.map(&mention_to_message mention, &1)
  end

  def extract_mentioned_names(text) do
    Regex.scan(@mention_pattern, text, capture: :all_but_first)
    |> List.flatten
  end

  @spec mention_to_message(Mention.t, String.t) :: Message.t
  def mention_to_message(~m{%Mention comment}a, mentioned_user) do
    ~m{body html_url commit_id user}a = comment
    %Message{
      text: statics(:commit).headline,
      channel: "@#{mentioned_user}",
      author: %{
        name: user.login,
        link: user.html_url,
        icon: user.avatar_url
      },
      body: %{
        title: "Commit @#{String.slice commit_id, 0, 7}",
        title_link: html_url,
        text: body,
        thumb_url: statics(:commit).thumb_url
      }
    }
  end

  def statics(mention_type) do
    Application.get_env(:sgm, :data)[mention_type]
  end
end
