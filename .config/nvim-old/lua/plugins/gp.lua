return {
  {
    "robitx/gp.nvim",
    config = function()
      local conf = {
        log_sensitive = true,
        default_command_agent = "FirstMate",
        default_chat_agent = "FirstMate",
        providers = {
          first_mate = {
            endpoint = "https://language-model-platform.ai-prod.bd-prod-1.kraken.zone/v1/chat/completions",
            secret = "",
          },
        },
        agents = {
          { name = "CodeGPT4o", disable = true },
          { name = "CodeGPT4o-mini", disable = true },
          {
            name = "FirstMate",
            provider = "first_mate",
            chat = true,
            command = true,
            -- string with model name or table with model name and parameters
            model = {
              model = "meta-llama/Meta-Llama-3.1-70B-Instruct",
              temperature = 0.01,
              top_p = 0.9,
              max_tokens = 4096,
            },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "Act as a world class Senior Software Engineer. Your job is to help with all software engineering tasks. You follow best practices in all programming languages, and you always provide working code. In response to questions/requests - Output code without descriptions, unless it is important and/or complex. Make it easy to copy and paste. Consider other possibilities to achieve the result, do not be limited by the prompt.",
          },
        },
        hooks = {
          -- example of adding command which writes unit tests for the selected code
          UnitTests = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please respond by writing table driven unit tests for the code above."
            local agent = gp.get_command_agent()
            gp.Prompt(params, gp.Target.enew, agent, template)
          end,

          -- example of adding command which explains the selected code
          Explain = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please respond by explaining the code above."
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.popup, agent, template)
          end,
          -- example of usig enew as a function specifying type for the new buffer
          CodeReview = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please analyze for code smells and suggest improvements."
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.enew("markdown"), agent, template)
          end,

          FixErrorAtCursor = function(gp, params)
            local bufnr = vim.api.nvim_get_current_buf()
            local cursor_line, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
            cursor_line = cursor_line - 1 -- Convert to 0-based index

            local diagnostics = vim.diagnostic.get(bufnr)

            local cursor_diagnostic = nil
            for _, diagnostic in ipairs(diagnostics) do
              if
                diagnostic.lnum == cursor_line
                and diagnostic.col <= cursor_col
                and cursor_col <= diagnostic.end_col
              then
                cursor_diagnostic = diagnostic
                break
              end
            end

            if not cursor_diagnostic then
              print("No diagnostic found at cursor position")
              return
            end

            local error_message = string.format(
              "Error at Line %d: %s [%s]. Source: %s\n",
              cursor_diagnostic.lnum + 1,
              cursor_diagnostic.message,
              cursor_diagnostic.code or "N/A",
              cursor_diagnostic.source or "N/A"
            )

            -- Select the entire range of the error
            vim.api.nvim_win_set_cursor(0, { cursor_diagnostic.lnum + 1, cursor_diagnostic.col })
            vim.cmd("normal! v")
            vim.api.nvim_win_set_cursor(0, { cursor_diagnostic.end_lnum + 1, cursor_diagnostic.end_col })

            local selected_text = vim.fn.getline(cursor_diagnostic.lnum + 1, cursor_diagnostic.end_lnum + 1)
            local selection = table.concat(selected_text, "\n")

            local template = "Having following from {{filename}}:\n\n"
              .. "```lua\n"
              .. selection
              .. "\n```\n\n"
              .. "Error found at the cursor:\n"
              .. error_message
              .. "Please respond by fixing the error above."
              .. "\n\nRespond exclusively with the snippet that should replace the selection above."

            local agent = gp.get_command_agent()
            gp.logger.info("Fixing error at cursor with agent: " .. agent.name)

            gp.Prompt(
              params,
              gp.Target.rewrite,
              agent,
              template,
              nil, -- command will run directly without any prompting for user input
              nil -- no predefined instructions
            )
          end,

          FixErrors = function(gp, params)
            local bufnr = vim.api.nvim_get_current_buf()
            local diagnostics = vim.diagnostic.get(bufnr)

            if #diagnostics == 0 then
              print("No diagnostics found in the buffer")
              return
            end

            local selected_text = vim.fn.getline(1, "$")
            local selection = table.concat(selected_text, "\n")

            local error_messages = {}
            for _, diagnostic in ipairs(diagnostics) do
              local error_message = string.format(
                "Error at Line %d: %s [%s]. Source: %s\n",
                diagnostic.lnum,
                diagnostic.message,
                diagnostic.code or "N/A",
                diagnostic.source or "N/A"
              )
              table.insert(error_messages, error_message)
            end

            local error_messages_str = table.concat(error_messages, "\n")

            local template = "Having following from {{filename}}:\n\n"
              .. "```lua\n"
              .. selection
              .. "\n```\n\n"
              .. "Errors found in the buffer:\n"
              .. error_messages_str
              .. "Please respond by appending the fix after the selection above."

            local agent = gp.get_command_agent()
            gp.logger.info("Fixing errors with agent: " .. agent.name)

            gp.Prompt(
              params,
              gp.Target.append,
              agent,
              template,
              nil, -- command will run directly without any prompting for user input
              nil -- no predefined instructions
            )
          end,
        },
      }
      require("gp").setup(conf)

      local function keymapOptions(desc)
        return {
          noremap = true,
          silent = true,
          nowait = true,
          desc = "GPT prompt " .. desc,
        }
      end

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
      -- Chat commands
      vim.keymap.set({ "n", "i" }, "<C-g>c", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
      vim.keymap.set({ "n", "i" }, "<C-g>t", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
      vim.keymap.set({ "n", "i" }, "<C-g>f", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

      vim.keymap.set("v", "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
      vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
      vim.keymap.set("v", "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

      vim.keymap.set({ "n", "i" }, "<C-g><C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
      vim.keymap.set({ "n", "i" }, "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
      vim.keymap.set({ "n", "i" }, "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

      vim.keymap.set("v", "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
      vim.keymap.set("v", "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit"))
      vim.keymap.set("v", "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions("Visual Chat New tabnew"))

      -- Prompt commands
      vim.keymap.set({ "n", "i" }, "<C-g>r", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
      vim.keymap.set({ "n", "i" }, "<C-g>a", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
      vim.keymap.set({ "n", "i" }, "<C-g>b", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

      vim.keymap.set("v", "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
      vim.keymap.set("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
      vim.keymap.set("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
      vim.keymap.set("v", "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

      vim.keymap.set({ "n", "i" }, "<C-g>gp", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
      vim.keymap.set({ "n", "i" }, "<C-g>ge", "<cmd>GpEnew<cr>", keymapOptions("GpEnew"))
      vim.keymap.set({ "n", "i" }, "<C-g>gn", "<cmd>GpNew<cr>", keymapOptions("GpNew"))
      vim.keymap.set({ "n", "i" }, "<C-g>gv", "<cmd>GpVnew<cr>", keymapOptions("GpVnew"))
      vim.keymap.set({ "n", "i" }, "<C-g>gt", "<cmd>GpTabnew<cr>", keymapOptions("GpTabnew"))

      vim.keymap.set("v", "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))
      vim.keymap.set("v", "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual GpEnew"))
      vim.keymap.set("v", "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", keymapOptions("Visual GpNew"))
      vim.keymap.set("v", "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions("Visual GpVnew"))
      vim.keymap.set("v", "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions("Visual GpTabnew"))

      vim.keymap.set({ "n", "i" }, "<C-g>x", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))
      vim.keymap.set("v", "<C-g>x", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

      vim.keymap.set({ "n", "i", "v", "x" }, "<C-g>s", "<cmd>GpStop<cr>", keymapOptions("Stop"))
      vim.keymap.set({ "n", "i", "v", "x" }, "<C-g>n", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))
    end,
  },
}
