return {
    {
        "huggingface/hfcc.nvim",
        opts = {
            -- cf Setup
            -- api_token = "", -- cf Install paragraph
            model = "bigcode/starcoder", -- can be a model ID or an http(s) endpoint
            query_params = {
                max_new_tokens = 60,
                temperature = 0.2,
                top_p = 0.95,
                stop_token = "<|endoftext|>",
            },
            -- set this if the model supports fill in the middle
            fim = {
                enabled = true,
                prefix = "<fim_prefix>",
                middle = "<fim_middle>",
                suffix = "<fim_suffix>",
            },
        },
    },
}
