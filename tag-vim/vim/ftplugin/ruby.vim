" rspec
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader><Leader>a :call RunAllSpecs()<CR>

if executable('bin/rspec')
  let g:rspec_command = '!bin/rspec {spec}'
end


