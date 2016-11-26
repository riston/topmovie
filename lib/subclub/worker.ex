
defmodule Subclub.Worker do
    require Logger
    use GenServer

    def start_link do
        GenServer.start_link(__MODULE__, %{count: 0})
    end

    def init(state) do
        schedule_work()
        {:ok, state}
    end

    def handle_info(:work, state) do
        Logger.info("Running scraper #{state.count}")

        Subclub.MovieListScraper.start()
        |> Subclub.MovieListScraper.insert

        # Reschedule work again
        schedule_work()
        count = state.count
        state = %{state | :count => count + 1}
        {:noreply, state}
    end

    defp schedule_work() do
        Process.send_after(self(), :work, 60 * 10 * 1000)
    end
end
