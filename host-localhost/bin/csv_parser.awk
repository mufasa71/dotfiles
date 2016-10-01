BEGIN {
  FPAT = "[^,]*|\"[^\"]*"
}

function format(input, limit, output, input_l, words, word_l, total_l, i)
{
  input_l = length(input)
  output = ""
  if (input_l > limit) {
    word_l = split(input, words, " ")
    total_l = 0
    for ( i = 0; i <= word_l; i++ ) {
      total_l += length(words[i])
      if ( total_l >= limit ) {
        words[i] = words[i] "\n"
        total_l = 0
      }
      output = output " " words[i]
    }
  } else {
    output = input
  }
  return output
}

NR > 1 { print "@"$3; print format($4, 20) }
