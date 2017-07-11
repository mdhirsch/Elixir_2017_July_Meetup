defmodule HelloWithReply do
  
  def hello do
		receive do
			{sender, user} -> send sender, {self(), "Hello #{user}"}
	  end
	  hello()
	end
  
end