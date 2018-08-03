defmodule ScChecksumHelper do
  @moduledoc """
  This module contain function which generate payment requests to the SafeCharge servers.
  """

  @doc """
  This function generate a request to the SafeCharge Servers. It raises an exception if the parameters are not valid.
  """
  @type sc_request :: %ScRequest{secret_key: String.t(), algorithm: atom(), charset: atom(), serverUrl: String.t()}
  @spec get_link!(sc_request, map(), atom()) :: String.t()
  def get_link!(sc_request, params, version) do
    case version do
      :v4 -> get_v4_link(sc_request, params)
      :v3 -> get_v3_link(sc_request, params)
      _ -> raise "Unknown request version"
    end
  end

  def get_link!(_, _, _) do
    raise "Invalid arguments!"
  end

  defp get_v4_link(sc_request, params) do
    Map.put(params, :version, "4.0.0")
    get_link_common(sc_request, params)
  end

  defp get_v3_link(sc_request, params) do
    Map.put(params, :version, "3.0.0")
    get_link_common(sc_request, params)
  end

  defp get_link_common(sc_request, params) do
    Map.put_new(params, :time_stamp, get_current_timestamp())
    Map.put(params, :secret_key, sc_request.secret_key)
    Enum.each(params, fn {k, v} -> Atom.to_string(k) <> v  end)
    |> Enum.reduce(fn s -> :crypto.hash(sc_request.algorithm, s) end)
  end

  defp get_current_timestamp() do
    Timex.local
    |> Timex.format!("{YYYY}-{MM}-{DD}.{HH}:{mm}:{ss}")
  end

end
