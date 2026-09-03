require('vim._core.ui2').enable({
    enable = true,
    msg = {
        ---@type 'cmd'|'msg' Default message target, either in the
        --- cmdline or in a separate ephemeral message window.
        ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
        --- or table mapping |ui-messages| kinds and triggers to a target.
        targets = 'msg',
        -- Cmdline: Also used for 'showcmd', 'showmode', 'ruler', and messages by default.
        ---@type vim._core.ui2.cmdline
        cmd = {          -- Options related to messages in the cmdline window.
            height = 0.5 -- Maximum height while expanded for messages beyond 'cmdheight'.
        },
        -- Dialog window: shows modal prompts that expect user input.
        dialog = {        -- Options related to dialog window.
            height = 0.5, -- Maximum height.
        },
        -- Message window: shows ephemeral messages useful for 'cmdheight' == 0.
        ---@type vim._core.ui2.messages
        msg = {             -- Options related to msg window.
            height = 0.5,   -- Maximum height.
            timeout = 4000, -- Time a message is visible in the message window.
        },
        -- Pager window: shows |:messages| and certain messages that are never "collapsed".
        pager = {       -- Options related to message window.
            height = 1, -- Maximum height.
        },
    },
})
