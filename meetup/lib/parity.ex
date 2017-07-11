defmodule Parity do
  @moduledoc false
  
  def even_parity do
    receive do
      {sender, _, _, 0} ->
      	IO.puts "returning even"
      	send sender, {:even}
      {sender, even_pid, odd_pid, n} ->
#      	IO.puts "even: computing #{n}"
      	send odd_pid, {sender, even_pid, odd_pid, n-1}
    end
    even_parity()
  end
  
  def odd_parity do
    receive do
      {sender, _, _, 0} ->
      	IO.puts "returning odd"
      	send sender, {:odd}
      {sender, even_pid, odd_pid, n} ->
#      	IO.puts "odd: computing #{n}"
      	send even_pid, {sender, even_pid, odd_pid, n-1}
    end
    odd_parity()
  end
  
  def compute_parity(n, even_pid, odd_pid) do
    send even_pid, {self(), even_pid, odd_pid, n}
		receive do
			{parity} -> 
				"Result is #{inspect(parity)}"
		end
  end
  
  def compute(even_pid, odd_pid, n) do
		IO.puts inspect :timer.tc(Parity, :compute_parity, [n, even_pid, odd_pid])
  end
  
end