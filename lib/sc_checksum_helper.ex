defmodule ScChecksumHelper do
  @moduledoc """
  This module contain function which generate payment requests to the SafeCharge servers.
  """
  # This will enable us to test the private functions.
  # Note that testing private function is BAD, as we are testing implementation details not behaviour!
  @compile if Mix.env == :test, do: :export_all

  @doc """
  This function generate a request to the SafeCharge Servers. It raises an exception if the parameters are not valid.
  """
  @type sc_request :: %ScRequest{secret_key: String.t(), algorithm: atom(), charset: atom(), server_url: String.t()}
  @spec get_link!(sc_request, map(), atom()) :: String.t()
  def get_link!(sc_request, params, version) do
    validate_request!(params)
    case version do
      :v4 -> get_v4_link(sc_request, params)
      :v3 -> get_v3_link(sc_request, params)
      _ -> raise "Unknown request version"
    end
  end

  defp validate_request!(params) do
    # add validation
    if (params == nil) do
      raise "Missing required parameters!"
    end
  end

  defp get_v4_link(sc_request, params) do
    Map.put(params, :version, "4.0.0")
    Map.put_new(params, :time_stamp, get_current_timestamp())
    checksum = calculate_v4_checksum(sc_request, params)
    build_url(sc_request, params, checksum)
  end

  defp get_v3_link(sc_request, params) do
    Map.put(params, :version, "3.0.0")
    Map.put_new(params, :time_stamp, get_current_timestamp())
    checksum = calculate_v3_checksum(sc_request, params)
    build_url(sc_request, params, checksum)
  end

  defp calculate_v4_checksum(sc_request, params) do
    params
    |> Enum.sort
    |> Enum.map(fn {k, v} -> "#{k}#{v}" end)
    |> Enum.concat([sc_request.secret_key])
    |> Enum.join
    |> (&:crypto.hash(sc_request.algorithm, &1)).()
    |> Base.encode16(case: :lower)
  end

  defp calculate_v3_checksum(sc_request, params) do
    "Implement me!"
  end

  defp build_url(sc_request, params, checksum) do
    sc_request.server_url <> "?" <> URI.encode_query(params) <> "&checksum=" <> checksum
  end

  defp get_current_timestamp() do
    Timex.now
    |> Timex.format!("{YYYY}-{0M}-{0D}.{h24}:{0m}:{0s}")
    # may be we should use :strftime, as the default formater syntax is DSL for Timex...
  end

end
