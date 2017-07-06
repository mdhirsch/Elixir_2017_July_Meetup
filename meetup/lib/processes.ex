defmodule Processes do
  @moduledoc false
  
  def count(next_pid) do
    receive do
      n ->
      	send next_pid, n+1
    end
  end
  
  def create_processes(0, pid) do
  	IO.puts "done creating pids"
    pid
  end
  
  def create_processes(n, pid) do
    next_pid = spawn Processes, :count, [pid]
    create_processes(n-1, next_pid)
  end
  
  def run(n) do
    start_pid = create_processes(n, self())
    send start_pid, 0
    receive do
      n ->
        IO.puts "count is #{n}"
    end
  end
  
  
  def time_running(n) do
		IO.puts inspect :timer.tc(Processes, :run, [n])
  end
end