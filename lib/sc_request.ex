defmodule ScRequest do
  @moduledoc false

  @enforce_keys [:secret_key]
  defstruct [:secret_key, algorithm: :sha256, charset: :utf8, server_url: "https://secure.safecharge.com"]

end
