# Drexel Prerequisite Parser
A lexical parser to make a dependency trees out of Drexel University Prerequisites 
    
    
Drexel university classes like most other universitys have prerequisites. The problem is that those prereqs have other preqs and it becomes very tedious to see what classes you need to take a class. couple this with the fact that preqs just come as a very complicated string and it can be very dificult to understand. The point of this project is to try and    
    
    1) create a parser that will parse a prereq string for a specific class    
    2) link that graph to the other classes creating a whole dependency tree of classes     
    3) create some sort of visual method of viewing the tree
    4) make sure to get around the weird race conditions of the string.    


Most strings are pretty easy and formated like this    
AADM 650 [Min Grade: C]    
ACCT 111 [Min Grade: D] or ACCT 115 [Min Grade: D]    
ACCT 115 [Min Grade: C] and ACCT 116 [Min Grade: C]    
BUSN 501 [Min Grade: C] or (BUSN 505 [Min Grade: C] and BUSN 506 [Min Grade: C])    
BMES 460 [Min Grade: D] and BMES 461 [Min Grade: D] and BMES 471 [Min Grade: D] and BMES 472 [Min Grade: D]    
    

This can be parsed using a similar method to parsing an inorder math problem ex: (1 * (2 + 3))    
using parens as a gropuing method and operators (and, or) to split classes.   

Most classes have simple prereqs like above but some can get very complicated, although shouldnt be an issue for the parser:

(TDEC 115 [Min Grade: D] and ECES 302 [Min Grade: D] and ECES 304 [Min Grade: D] and BMES 325 [Min Grade: D] and BMES 326 [Min Grade: D]) or PHYS 201 [Min Grade: D] and (BIO 203 [Min Grade: D] or BMES 235 [Min Grade: D]) and (MATH 311 [Min Grade: D] or BMES 310 [Min Grade: D]) and (TDEC 222 [Min Grade: D] or ENGR 231 [Min Grade: D]) and ENGR 232 [Min Grade: D]     
     

The problem occours with many weird cases which have been found 

ARTS 511 \[Min Grade: C\] (Can be taken Concurrently)
//wait this has parens but not for grouping classes? thats going to mess things up but i can get around it

ARTS 713 \[Min Grade: C\] (Can be taken Concurrently)ARTS 703 [Min Grade: C]
//wait this one is missing a word, shouldnt there be an 'and', or 'or' in there. Theres not even a space so parsing will be annoying


BIO 122 \[Min Grade: D\] (Can be taken Concurrently) or BIO 141 [Min Grade: D]
//hmm when its cuncurrent but has an 'or' it does put the word in there

BIO 500 \[Min Grade: C\], BMES 501 \[Min Grade: C\] (Can be taken Concurrently)
//wait, where did this comma come from. Since when do you use commas to seperate. Maybe its only for ones with the (cuncurrent) thing

or FASH 629 [Min Grade: B], FASH 251 [Min Grade: C] or FASH 629 [Min Grade: B]
//This one just starts of with an or, and has a random comma. And the first and last class are the same!

ECE 201 \Min Grade: D\] (Can be taken Concurrently)(BMES 222 [Min Grade: D] or BIO 201 [Min Grade: D]) and (TDEC 231 [Min Grade: D] or ENGR 103 [Min Grade: D])
//Tthis one has the cucurrent parens but has more parens right after with no space 


CHEM 253 \[Min Grade: D\] (Can be taken Concurrently)(CHEM 230 [Min Grade: D] and CHEM 242 [Min Grade: D]) or CHEC 352 [Min Grade: D])
//are you kidding me this one just has a trailing ')' that doesnt match with anything

CS 171 [Min Grade: D], PHYS 105 [Min Grade: D]
//wait this one just has a comma and its not special. what does the comma mean!