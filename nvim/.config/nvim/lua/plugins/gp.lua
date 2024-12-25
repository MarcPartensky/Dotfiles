return {
    "robitx/gp.nvim",
    config = function()
        local conf = {
            -- For customization, refer to Install > Configuration in the Documentation/Readme
            agents = {
                {
                    name = "ChatGPT3-5",
                    disable = true,
                },
                {
                    name = "MyCustomAgent",
                    provider = "copilot",
                    chat = true,
                    command = true,
                    model = { model = "gpt-4-turbo" },
                    system_prompt = "Answer any query with just: Sure thing..",
                },
            },
        }
        require("gp").setup(conf)

        -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
    end,
}
