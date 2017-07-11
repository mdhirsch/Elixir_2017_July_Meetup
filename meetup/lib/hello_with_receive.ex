defmodule HelloWithReceive do
  
  def hello do
		receive do
			{_, user} -> IO.puts "Hello, #{user}"
	  end
	end
  
end
