function grep --wraps=/usr/bin/rg --description 'alias grep=/usr/bin/rg'
  /usr/bin/rg $argv
        
end
