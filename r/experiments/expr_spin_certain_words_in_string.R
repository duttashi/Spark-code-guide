
# Question: Write a function that takes in a string of one or more words, and returns the same string, but with all five or more letter words reversed (Just like the name of this Kata). Strings passed in will consist of only letters and spaces. Spaces will be included only when more than one word is present.

# Examples: spinWords( "Hey fellow warriors" ) => returns "Hey wollef sroirraw" spinWords( "This is a test") => returns "This is a test" spinWords( "This is another test" )=> returns "This is rehtona test"

# This question was asked on Codewars website.

# PROGRAM LOGIC
# --------------------
# Declare two empty lists called list_str_to_words and list_spin_words.
# split the string into words on basis of spaces and save to a list_str_to_words.

# Iterate over the list and count the character length of each word.
# If the word length is greater than 5 then reverse the word and write to list_spin_words
# if the word length is not greater tha 5, add the word to list_spin_words
# ---------------------
some_string = "Jack and Jill went up the hill to fetch a pail of water!"
list_str_to_words= vector(mode = "list")
list_spin_words = vector(mode = "list")

spin_words<- function(some_string){
  
  # split the string into words 
  list_str_to_words = strsplit(some_string,"\\s+")[[1]]
  
  # loop through the list of words
  count = 0
  for (i in list_str_to_words) {
    # check words greater or less than a given length
    if(nchar(i)>3){
      
      # note: paste() helps by removing the space between characters
      rev_str<- paste(rev(strsplit(i,"")[[1]]),collapse="")
      #print(rev_str)
      
      # assign the reversed string to a list
      list_spin_words <- append(list_spin_words,rev_str)
      } # end-if
    else{
      list_spin_words <- append(list_spin_words,i)
    }
    
    
    } # end-for
  # print(list_spin_words)
  return(list_spin_words)
  } # end-function

# call the function
my_spin_words<-paste(spin_words(some_string), collapse = " ")
print(my_spin_words)
