defmodule SlackGithubMention.Mention do
  alias SlackGithubMention.{Comment, Mention}

  defstruct comment: %Comment{}, username: ""
  @type t :: %Mention{comment: Comment.t, username: String.t}

  @mention_pattern ~r/@(\w+)/

  @doc """
  Parses comment body and creates a mention for each found username
  """
  @spec all_from_comment(Comment.t) :: [Mention.t]
  def all_from_comment(comment) do
    Regex.scan(@mention_pattern, comment.body, capture: :all_but_first)
    |> Enum.map(fn [username] ->
      %Mention{comment: comment, username: username}
    end)
  end
end
