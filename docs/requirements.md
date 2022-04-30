## Requirements

- R1. Users can view information about the food menus and establishments for the remaining days of the week.  
- R2. Users can rate and comment on a meal per mealtime.  
- R3. Users can remove previously submitted feedback  
- R4. Users can vote anonymously if they choose.  
- R5. The system must prevent vote fraud.  
- R6. Users can receive a recommendation based on their preferences and previous user feedback.  

### Use case model 


 <p align="center" justify="center">
  <img src="../images/UseCaseView.png">
</p>

|||
| --- | --- |
| *Name* | Choose a meal |
| *Actor* | Authenticated User | 
| *Description* | Allow the user to look through the menus, the user can search by establishments |
| *Preconditions* | The user wants information about the meal options at FEUP. |
| *Postconditions* | The user receives information about the content of the meal. |
| *Normal flow* | 1. The user opens the application.<br> 2.The user selects an establishment. <br> 3. The user selects 1 menu from the available.<br> 4. If wanted, the user can leave a rating and a comment.<br> |
| *Alternative flows and exceptions* | 1. [Establishment closed] If, in step 2 the user selects an establishment that is closed the system displays an error and makes the user go back to step 2. |

|||
| --- | --- |
| *Name* | Get a recommendation |
| *Actor* | Authenticated User | 
| *Description* | The user gets recommended a meal considering his choice and other users feedback |
| *Preconditions* | The user wants the best possible option considering his preference |
| *Postconditions* | The user gets a menu from an establishment with the highest rating according to his choice. |
| *Normal flow* | 1. The user opens the application.<br> 2. The user clicks the recommendation button.<br> 3.The user inputs his preference(meat,fish,etc.). <br> 4.The user receives a menu recommendation.<br>  5. If wanted, the user can leave a rating and a comment.  |
| *Alternative flows and exceptions* | 1. [Everything closed] If, in step 2 of the normal flow all establishments are closed the user receives a warning message |


|||
| --- | --- |
| *Name* | Leave a Rating |
| *Actor* | Authenticated User |
| *Description* | Thue user can rate from 1 to 5 starts the meal. |
| *Preconditions* | The user wants to give his opinion on the experience. |
| *Postconditions* | After rating the meal, anyone can look it up. |
| *Normal flow* | 1. The user opens the applications. <br> 2. The user selects an establishment. <br> 3. The user selects one menu from the available <br> 4. The user leaves a rating |
| *Alternative flow and exceptions* | 1. [Leave a comment] After step 4, the user can comment on his experience. <br>  2. [Gets a Recommendation] In step 2, the user can click the recommendations button. Then the user inputs his preference. After that the user receives a menu recommendations and leaves a rating.|

|||
| --- | --- |
| *Name* | Read a Comment |
| *Actor* | Authenticated User | 
| *Description* | Allow the user to read comments about a specific meal |
| *Preconditions* | The user is interested in the other's opinion about a meal |
| *Postconditions* | The user has a better knowledge about the quality of a meal |
| *Normal flow* | 1. The user opens the application.<br> 2.The user selects an establishment. <br> 3. The user selects 1 menu from the available.<br> 4. The user can scroll through the comments to read them. |
| *Alternative flows and exceptions* | 1. [Recommendation] If, in step 2 the user selects the recommendation button, he is then presented with meals. By selecting one menu, the user can read the comments.<br> 2. [No Comments] If in step 4 of the normal flow there are no comments on that menu, it presents the user with a message saying "There are no comments yet.". |

### Domain model

 <p align="center" justify="center">
  <img src="../images/DomainModel.png"/>
</p>
