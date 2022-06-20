" https://stackoverflow.com/a/6496995
fun! StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if exists('b:noStripWhitespace')
        return
    endif
    %s/\s\+$//e
endfun

autocmd! BufWritePre * call StripTrailingWhitespace()
