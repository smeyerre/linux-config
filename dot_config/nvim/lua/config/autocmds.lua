-- Create augroups for organization
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- COMMENTED OUT: Molten autocmds not behaving well with current codebase
-- To re-enable, uncomment the sections below
--[[
-- Molten notebook initialization group
local molten_init = augroup('MoltenInit', { clear = true })

-- Automatic output handling Configuration
-- automatically import output chunks from a jupyter notebook
-- tries to find a kernel that matches the kernel in the jupyter notebook
-- falls back to a kernel that matches the name of the active venv (if any)
local function imb(e)
    vim.schedule(function()
        local kernels = vim.fn.MoltenAvailableKernels()
        local kernel_name = nil

        -- First try to get kernel from file
        local file = io.open(e.file, "r")
        if file then
            local ok, metadata = pcall(function()
                return vim.json.decode(file:read("*all"))["metadata"]
            end)
            file:close()

            if ok and metadata and metadata.kernelspec then
                kernel_name = metadata.kernelspec.name
            end
        end

        -- If no kernel found in file, try virtual env
        if not kernel_name or not vim.tbl_contains(kernels, kernel_name) then
            local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
            if venv ~= nil then
                kernel_name = string.match(venv, "/.+/(.+)")
            end
        end

        -- If we found a valid kernel, use it
        if kernel_name and vim.tbl_contains(kernels, kernel_name) then
            vim.cmd(("MoltenInit %s"):format(kernel_name))
        else
            -- Otherwise, prompt user to select a kernel
            vim.ui.select(kernels, {
                prompt = "Select a kernel for this notebook:",
                format_item = function(item) return item end,
            }, function(choice)
                if choice then
                    vim.cmd(("MoltenInit %s"):format(choice))
                end
            end)
        end

        -- Import outputs regardless of kernel status
        vim.cmd("MoltenImportOutput")
    end)
end

-- Molten notebook initialization
-- Import outputs on file open
autocmd("BufAdd", {
    group = molten_init,
    pattern = { "*.ipynb" },
    callback = imb,
})
-- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
autocmd("BufEnter", {
    group = molten_init,
    pattern = { "*.ipynb" },
    callback = function(e)
        if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
            imb(e)
        end
    end,
})

-- Molten output export group
local molten_export = augroup('MoltenExport', { clear = true })

-- Export outputs on save
-- This export, in conjunction with the jupytext conversion, can make saving lag the editor for ~500ms, so autosave plugins can cause a bad experience.
autocmd("BufWritePre", {
    group = molten_export,
    pattern = { "*.ipynb" },
    callback = function()
        if require("molten.status").initialized() == "Molten" then
            pcall(vim.cmd, "MoltenExportOutput!")
        end
    end
})

-- Molten settings management group
local molten_settings = augroup('MoltenSettings', { clear = true })

-- Change Molten settings for Python files (show output in float, not virtual text)
autocmd("BufEnter", {
    group = molten_settings,
    pattern = "*.py",
    callback = function(e)
        if string.match(e.file, ".otter.") then
            return
        end
        if require("molten.status").initialized() == "Molten" then
            vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
            vim.fn.MoltenUpdateOption("virt_text_output", false)
        else
            vim.g.molten_virt_lines_off_by_1 = false
            vim.g.molten_virt_text_output = false
        end
    end,
})

-- Reset Molten settings for notebook files (show output as virtual text)
autocmd("BufEnter", {
    group = molten_settings,
    pattern = { "*.qmd", "*.md", "*.ipynb" },
    callback = function(e)
        if string.match(e.file, ".otter.") then
            return
        end
        if require("molten.status").initialized() == "Molten" then
            vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
            -- vim.fn.MoltenUpdateOption("virt_text_output", true)
          else
            vim.g.molten_virt_lines_off_by_1 = true
            -- vim.g.molten_virt_text_output = true
          end
    end,
})
--]]

