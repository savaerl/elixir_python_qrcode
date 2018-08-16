#lib/elixir_python_qrcode.ex
defmodule ElixirPythonQrcode do
  @moduledoc """
  Documentation for ElixirPythonQrcode.
  """
  alias ElixirPythonQrcode.Helper

  def encode(data, file_path) do
    call_python(:qrcode, :encode, [data, file_path])
  end

  def decode(file_path) do
    :io.format("~nfile_path for decode: ~p~n", [file_path])
    x = call_python(:qrcode, :decode, [file_path])
    :io.format("~nresponse for python: ~p~n", [x])
    x
  end

  def decode_credit_card(image_arr, reference) do
    call_python(:ocr_template_match, :decode_credit_card, [image_arr, reference])
  end

  defp default_instance() do
    #Load all modules in our priv/python directory
    path = [:code.priv_dir(:elixir_python_qrcode), "python"]
          |> Path.join()
    Helper.python_instance(to_charlist(path))
  end

  # wrapper function to call python functions using
  # default python instance
  defp call_python(module, function, args \\ []) do
    default_instance()
    |> Helper.call_python(module, function, args)
  end
end
