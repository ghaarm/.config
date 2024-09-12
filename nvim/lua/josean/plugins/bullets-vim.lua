-- -- -- https://github.com/bullets-vim/bullets.vim
--
-- return {
--   "bullets-vim/bullets.vim",
--   config = function()
--     vim.cmd([[
--     let g:bullets_enabled_file_types = ['markdown', 'text', 'gitcommit', 'scratch']
--     let g:bullets_enable_in_empty_buffers = 0 " Plugin nicht aktivieren, wenn der Buffer leer ist
--     let g:bullets_delete_last_bullet_if_empty = 1 " Letztes Bullet löschen, wenn leer
--     let g:bullets_line_spacing = 2 " Anzahl der Leerzeilen zwischen Bullets
--     let g:bullets_pad_right = 1 " Zusätzliches Padding, damit alles in einer Spalte ist
--     let g:bullets_auto_indent_after_colon = 1 " Automatisches Einrücken nach Doppelpunkt
--     let g:bullets_renumber_on_change = 1 " Nummerierung bei Änderungen erneuern
--     let g:bullets_checkbox_markers = ' .oOX'
-- ]])
--   end
-- }
--
return {
  "bullets-vim/bullets.vim",
  config = function()
    vim.cmd([[
    let g:bullets_enabled_file_types = ['markdown', 'text', 'gitcommit', 'scratch']
    let g:bullets_enable_in_empty_buffers = 0 " Plugin nicht aktivieren, wenn der Buffer leer ist
    let g:bullets_delete_last_bullet_if_empty = 1 " Letztes Bullet löschen, wenn leer
    let g:bullets_line_spacing = 2 " Anzahl der Leerzeilen zwischen Bullets
    let g:bullets_pad_right = 1 " Zusätzliches Padding, damit alles in einer Spalte ist
    let g:bullets_auto_indent_after_colon = 1 " Automatisches Einrücken nach Doppelpunkt
    let g:bullets_renumber_on_change = 1 " Nummerierung bei Änderungen erneuern
    let g:bullets_checkbox_markers = ' .oOX'

    " Hier füge diese Zeilen hinzu, um das Verhalten von `o` in den genannten Dateitypen zu ändern
    augroup BulletMappings
      autocmd!
      autocmd FileType markdown,text,gitcommit nnoremap <buffer> o o<Esc>
      autocmd FileType markdown,text,gitcommit nnoremap <buffer> O O<Esc>
    augroup END
    ]])
  end
}
