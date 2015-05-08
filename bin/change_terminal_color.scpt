on run argv
	tell application "Terminal" 
		repeat with x from 1 to (count of windows)
			try
			repeat with y from 1 to (count of (tabs of window x))
				if tty of tab y of window x equals (item 2 of argv) then
					set current settings of tab y of window x to first settings set whose name is (item 1 of argv)
				end if
			end repeat
			end try
		end repeat
	end tell
end run