return {
    "skywind3000/asynctasks.vim",
    config = function()

        -- Add runner 'tmux_custom'
        vim.cmd [[
            function! s:run_tmux_custom(opts)

                let cmds = []
                let cmds += [ 'cd ' . a:opts.cwd ]
                let cmds += [ a:opts.cmd ]

                " Concatenate cmds with ';' separator
                let text = shellescape(join(cmds, ';'))

                " Shell interpreting of concatenated cmds; echo each cmd with '-x'; keep pane open with 'read'
                let command = '"sh -x -c ' . text . '; read"'

                " Use separate pane to execute shell command without change of focus
                call system('tmux split-window -p 10 ' . command . '\; last-pane')

            endfunction

            let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
            let g:asyncrun_runner.tmux_custom = function('s:run_tmux_custom')
         ]]
    end
}
