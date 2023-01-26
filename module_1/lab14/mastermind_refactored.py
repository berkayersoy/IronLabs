from getpass import getpass
colors = ['yellow', 'blue', 'red', 'green', 'white', 'black']
game = True
print('Welcome to 🅼🅰🆂🆃🅴🆁🅼🅸🅽🅳!')

while game:
  print('Here is your list of colors you may choose from: YELLOW, BLUE, RED, GREEN, WHITE, BLACK')
  codemaker = getpass('Codemaker, type 4 colors from the list with a space between each one, be careful with duplicates ❤️ :')
  enigma = codemaker.lower().split()
  invalid_color=False

  #If statement checks for duplicates and if length is 4.
  if len(enigma)!=len(set(enigma)) or len(enigma)!=4:
    print("You have to input 4 colors divided by a space and no duplicates!")
    continue

  #For loop and if statement below checks if the codebreaker inputs are all valid colors.
  for i in range(4):
      if enigma[i] not in colors:
        print(enigma[i] + ' is not an allowed color')
        invalid_color=True
        break
  
  if invalid_color==True:
    continue


  #We use this turn variable to count turns and as a counter to break the while loop.
  turn = 1
  while turn <= 12:
    codebreaker = input('Codebreaker, make a guess:')
    guess = codebreaker.lower().split()
    response = []
    invalid_color=False

    #If statement checks for duplicates and if length is 4.
    if len(guess)!=len(set(guess)) or len(guess)!=4:
      print("You have to input 4 colors divided by a space and no duplicates!")
      continue

    #For loop and if statement below checks if the codebreaker inputs are all valid colors.
    for i in range(4):
      if guess[i] not in colors:
        print(guess[i] + ' is not an allowed color')
        invalid_color=True
        break

    if invalid_color==True:
      continue

    #We compare the guess to enigma to provide feedback.
    for i in range(4):
      if guess[i] == enigma[i]:
        response.append('🔴')
      elif guess[i] in enigma:
        response.append('⚪')
      else:
        response.append('✖️')


    #We increment turn by 1 every loop to count the turns.
    turn += 1

    #Checking if guess is matching the enigma.
    if guess==enigma:
      print('Congratulations 🎉🎉🎉🎉🎉')
      print("You have guessed it in",turn-1,"turns.")
      break
    
    #Printing the hint for the user.
    print(guess,' '.join(response))

  if turn == 13:
    print("You couldn't find it in 12 turns. What a pity! Codebreaker you lost!!!")

  if input('Do you want to play again? ').lower()== 'yes':
    game = True;
  else:
    print('See you next time 🚀🚀🚀🚀')
    game = False;