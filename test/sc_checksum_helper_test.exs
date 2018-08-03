defmodule ScChecksumHelperTest do
  use ExUnit.Case
  doctest ScChecksumHelper

  test "valid checksum" do
    sc_request = %ScRequest{secret_key: 123}
    params = %{}
    version = :v4

    assert ScChecksumHelper.get_link!(sc_request, params, version) == "asd"
  end
end
