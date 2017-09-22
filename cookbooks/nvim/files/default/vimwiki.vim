" gem install vimwiki_markdown
"

let g:vimwiki_list = [{
          \ 'path': '~/Dropbox/vimwiki/data', 
          \ 'template_path': '~/Dropbox/vimwiki/templates/',
          \ 'template_default': 'default',
          \ 'syntax': 'markdown', 
          \ 'ext': '.md',
          \ 'path_html': '~/Dropbox/vimwiki/site_html/', 
          \ 'custom_wiki2html': 'vimwiki_markdown',
          \ 'template_ext': '.tpl',
          \ 'auto_export': 0}] " experiment with turning this on

