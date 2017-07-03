defmodule Parity do
  @moduledoc false
  
  def even_parity do
    receive do
      {sender, _, _, 0} ->
      	IO.puts "returning even"
      	send sender, {:even}
      {sender, _, odd_pid, n} ->
#      	IO.puts("not zero")
      	send odd_pid, {sender, self(), odd_pid, n-1}
      {sender, foo} ->
      	IO.puts("default #{foo}")
      _ -> IO.puts("whatever")
    end
    even_parity()
  end
  
  def odd_parity do
    receive do
      {sender, _, _, 0} ->
      	IO.puts "returning odd"
      	send sender, {:odd}
      {sender, even_pid, odd_pid, n} ->
#      	IO.puts("not zero")
      	send even_pid, {sender, even_pid, self(), n-1}
      {sender, foo} ->
      	IO.puts("default #{foo}")
      _ -> IO.puts("whatever")
    end
    odd_parity()
  end
  
#    {:odd} ->
#    	IO.puts("odd")
#    {:even} ->
#    	IO.puts("even")
#  end

end