defmodule HelloPhoenix.SubmissionChannel do
  use Phoenix.Channel

  def join("submissions:submit", _auth_msg, socket) do
    {:ok, socket}
  end

  def handle_in("submission:new", %{"code" => code}, socket) do
    spawn(__MODULE__, :evaluate, [socket, code])
    {:noreply, socket}
  end

  def evaluate(socket, code) do
    py_eval = :global.whereis_name :producer
    send py_eval, {:evaluate, self, code}
    receive do
      {:done, result} ->
        Phoenix.Channel.push socket, "submission:done", %{result: result}
    end
  end
end
