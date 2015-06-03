## Objectives
### Learning Objectives
After completing this assignment, you should understand:
* How to generate tables and connect to them from Ruby
* Persisting data using your own models
* Using ActiveRecord objects alongside plain ol' Ruby objects (POROs)

### Performance Objectives
After completing this assignment, you be able to effectively use
* db:migrate
* Managing data using where, new, create, save, &c

## Details
Use either my tic-tac-toe object solution or your own previous implementation as a starting point for the game play logic.

### Deliverables
A link to a repo:
* Based on our skeleton project
* Running ruby play.rb should play a single game.

## Normal Mode
* After each game is over, save a record of who played and who won.
* Display each players win-loss records before starting a game.

## Hard Mode
Add an option for displaying a leaderboard with the winningest players ranked (this can be a separate script, or an option in the play script).