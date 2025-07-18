-- shadenote.lua
-- Convert \begin{note}...\end{note} and \begin{example}...\end{example}
-- into Pandoc divs with appropriate classes (HTML only)

local function extract_env_content(raw_latex, env_name)
	-- Match the content inside \begin{env_name}...\end{env_name}
	local pattern = "\\begin{" .. env_name .. "}(.-)\\end{" .. env_name .. "}"
	return raw_latex:match(pattern)
end

function RawBlock(el)
	if FORMAT:match("html") then
		-- Check for note environment
		local note_content = extract_env_content(el.text, "note")
		if note_content then
			-- Parse the content as LaTeX to preserve formatting
			local parsed_blocks = pandoc.read(note_content, "latex").blocks
			return pandoc.Div(parsed_blocks, { class = "note" })
		end

		-- Check for example environment
		local example_content = extract_env_content(el.text, "example")
		if example_content then
			-- Parse the content as LaTeX to preserve formatting
			local parsed_blocks = pandoc.read(example_content, "latex").blocks
			return pandoc.Div(parsed_blocks, { class = "example" })
		end
	end
	return nil
end
