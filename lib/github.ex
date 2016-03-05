defmodule Github do
  @callback user_emails(uname :: String.t) :: [String.t]

  defmacro __using__(domain) do
    quote do
      @behaviour unquote(__MODULE__)

      @domain unquote(domain)

      def user_email_name(uname) do
        __MODULE__.user_emails(uname)
        |> Enum.find(&String.ends_with? &1, "@#{@domain}")
        |> String.split("@")
        |> hd
      end
    end
  end
end
