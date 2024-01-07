local cmake_tools_config = function()

    require("cmake-tools").setup {
        cmake_command = "cmake",                                          -- this is used to specify cmake command pathss
        ctest_command = "ctest",                                          -- this is used to specify ctest command path
        cmake_regenerate_on_save = false,                                 -- auto generate when save CMakeLists.txt
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
        cmake_build_options = {},                                         -- this will be passed when invoke `CMakeBuild`
        -- support macro expansion:
        --       ${kit}
        --       ${kitGenerator}
        --       ${variant:xx}
        cmake_build_directory = "cmake-build-${variant:buildType}", -- this is used to specify generate directory for cmake, allows macro expansion, relative to vim.loop.cwd()
        cmake_soft_link_compile_commands = true,       -- this will automatically make a soft link from compile commands file to project root dir
        cmake_compile_commands_from_lsp = false,       -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
        cmake_kits_path = nil,                         -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
        cmake_variants_message = {
            short = { show = true },                   -- whether to show short message
            long = { show = true, max_length = 40 },   -- whether to show long message
        },
        cmake_dap_configuration = {                    -- debug settings for cmake
            name = "cpp",
            type = "codelldb",
            request = "launch",
            stopOnEntry = true,
            runInTerminal = true,
            console = "integratedTerminal",
        },
        cmake_executor = {     -- executor to use
            name = "overseer", -- name of the executor
            opts = {},         -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
            default_opts = {   -- a list of default and possible values for executors
                overseer = {
                    new_task_opts = {
                        strategy = {
                            "terminal",
                            direction = "horizontal",
                            autos_croll = true,
                            quit_on_exit = "success"
                        }
                    }, -- options to pass into the `overseer.new_task` command
                    on_new_task = function(task)
                        require("overseer").open(
                            { enter = false, direction = "bottom" }
                        )
                    end, -- a function that gets overseer.Task when it is created, before calling `task:start`
                },
            },
        },
        cmake_runner = {       -- runner to use
            name = "overseer", -- name of the runner
            opts = {},         -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
            default_opts = {   -- a list of default and possible values for runners
                overseer = {
                    new_task_opts = {
                        strategy = {
                            "terminal",
                            direction = "horizontal",
                            autos_croll = true,
                            quit_on_exit = "success"
                        }
                    },   -- options to pass into the `overseer.new_task` command
                    on_new_task = function(task)
                    end, -- a function that gets overseer.Task when it is created, before calling `task:start`
                },
            },
        },
        cmake_notifications = {
            runner = { enabled = false },
            executor = { enabled = false },
            spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
            refresh_rate_ms = 100, -- how often to iterate icons
        },
    }
end

return {
    "Civitasv/cmake-tools.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/overseer.nvim"
    },
    config = cmake_tools_config,
}
