defmodule ScChecksumHelperTest do
  use ExUnit.Case
  doctest ScChecksumHelper

  test "get timestamp" do
    assert ScChecksumHelper.get_current_timestamp() != nil
  end

  test "valid checksum v4" do
    sc_request = %ScRequest{secret_key: "s3cr3t"}
    params = %{total_amount: "1", item_name: "item1"}
    version = :v4

    assert ScChecksumHelper.get_link!(sc_request, params, version) ==
             "https://secure.safecharge.com?item_name=item1&total_amount=1&checksum=9a19621aac30c7b153172f2eee61ece86508d0a99b1b809040c2f479a838748f"
  end
end
