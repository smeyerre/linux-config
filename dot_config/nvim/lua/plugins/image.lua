return {
  {
    '3rd/image.nvim',
    opts = {
      backend = "kitty",
      processor = "magick_rock",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        html = { enabled = false },
        css = { enabled = false },
      },
      -- max_width = 200, -- tweak to preference
      -- max_height = 24, -- ^
      max_width = 300,
      max_height = 36,
      max_width_window_percentage = math.huge,
      max_height_window_percentage = math.huge, -- this is necessary for a good experience
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
    }
  }
}
