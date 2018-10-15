## Hybrid-tweaked
It's the [hybrid terminal theme][hybrid-link], with some ANSI bright/normal colors
"corrected".

The linked version has bright/normal swapped, ie., the bright colors are darker
than their normal counterparts. It's a pretty good theme, but that idiosyncrasy
interferes with some of my more general configs.

fyi you can swap all bright/normal colors for a stock macOS Terminal theme with this:
```vim
" temporarily rename all the bright colors
:%s/\(<key>\)ANSIBright\(.*<\/key>\)/\1PLACEHOLDER\2/g
" rename all old normal to bright
:%s/\(<key>ANSI\)\(.*Color<\/key>\)/\1Bright\2/g
" rename old bright to normal
:%s/\(<key>\)PLACEHOLDER\(.*<\/key>\)/\1ANSIBright\2/g
```


[hybrid-link]: https://github.com/lysyi3m/macos-terminal-themes/blob/master/schemes/Hybrid.terminal
