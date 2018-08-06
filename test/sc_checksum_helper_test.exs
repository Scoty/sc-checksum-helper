defmodule ScChecksumHelperTest do
  use ExUnit.Case
  doctest ScChecksumHelper

  test "get timestamp" do
    assert ScChecksumHelper.get_current_timestamp() != nil
  end

  test "valid checksum v4" do
    sc_request = %ScRequest{secret_key: "s3cr3t"}
    params = %{total_amount: "1", item_name: "item1", timestamp: "2018-08-06.13:36:28"}
    version = :v4

    assert ScChecksumHelper.get_link!(sc_request, params, version) ==
             "https://secure.safecharge.com
             ?item_name=item1
             &timestamp=2018-08-06.13%3A36%3A28
             &total_amount=1
             &version=4.0.0
             &checksum=909292fe5fac1258b76555e8d1252c2caaca049dd4a42aa600e921ac7d4e3c18"
             |> String.replace(~r/\r|\n| /, "")
  end
end
