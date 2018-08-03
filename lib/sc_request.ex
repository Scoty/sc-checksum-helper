defmodule ScRequest do
  @moduledoc false

  @enforce_keys [:secret_key]
  defstruct [:secret_key, algorithm: :sha256, charset: :utf8, serverUrl: "https://secure.safecharge.com"]

end
