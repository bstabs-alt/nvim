require("ineednrg.remap")
require("ineednrg.set")
require("ineednrg.plugins")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_user_command("GitBlameLine", function()
	local line_number = vim.fn.line(".") -- Get curr line numb. See :h line()
	local filename = vim.api.nvim_buf_get_name(0)
	print(vim.system({ "git", "blame", "-L", line_number .. ",+1", filename }):wait().stdout)
end, { desc = "Print the git blame for the current line" })

vim.cmd("packadd! nohlsearch")

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("UIEnter", {
	callback = function()
		vim.o.clipboard = "unnamedplus"
	end,
})

-- Highlight when yanking (copying) text -- Try with `yap`
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank()
	end,
})

-- vertical help - [:vert h <keyword>]
--autocmd("FileType", {})

Fcitx5state = vim.system({ "fcitx5-remote" }):wait().stdout:sub(1, 1)
autocmd("InsertLeave", {
	desc = "Inactivate IME mode",
	pattern = "*",
	callback = function()
		Fcitx5state = vim.system({ "fcitx5-remote" }):wait().stdout:sub(1, 1)
		vim.system({ "fcitx5-remote", "-c" })
	end,
})
autocmd("InsertEnter", {
	desc = "Reactivate IME mode",
	pattern = "*",
	callback = function()
		print("InsertEnter: ", Fcitx5state)
		if Fcitx5state == "2" then
			vim.system({ "fcitx5-remote", "-o" })
		end
	end,
})

autocmd("LspAttach", {
	group = augroup("nrg.lsp", {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

		if client:supports_method("textDocument/implementation") then
			vim.keymap.set("n", "gd", vim.lsp.buf.definition)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
		end

		if
			not client:supports_method("textDocument/willSaveWaitUntil")
			and client:supports_method("textDocument/formatting")
		then
			autocmd("BufWritePre", {
				group = augroup("nrg.lsp", { clear = false }),
				buffer = ev.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})
