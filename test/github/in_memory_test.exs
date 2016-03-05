defmodule Github.InMemoryTest do
  use ExUnit.Case

  alias Github.InMemory

  test "user_email_name" do
    assert InMemory.user_email_name("gh_user", InMemory.domain) == "slack_user"
  end

end
