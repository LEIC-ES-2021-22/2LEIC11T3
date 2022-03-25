
## Requirements

- R1. Users can view information about the food menus and establishments for the remaining days of the week.  
- R2. Users can rate and comment on a meal per mealtime.  
- R3. Users can remove previously submitted feedback  
- R4. Users can vote anonymously if they choose.  
- R5. The system must prevent vote fraud.  
- R6. Users can receive a recommendation based on their preferences and previous user feedback.  


### Use case model 

Create a use-case diagram in UML with all high-level use cases possibly addressed by your module, to clarify the context and boundaries of your application.

Give each use case a concise, results-oriented name. Use cases should reflect the tasks the user needs to be able to accomplish using the system. Include an action verb and a noun. 

Example:
 <p align="center" justify="center">
  <img src="https://github.com/LEIC-ES-2021-22/2LEIC11T3/blob/main/images/UseCaseView.png"/>
</p>

|||
| --- | --- |
| *Name* | Choose a meal |
| *Actor* |  User | 
| *Description* | Allow the user to look through the menus, the user can search by establishments |
| *Preconditions* | - The user wants information about the meal options at FEUP. |
| *Postconditions* | - The user receives information about the content of the meal. |
| *Normal flow* | 1. The user opens the application.<br> 2. The user clicks the establishments button.<br> 3.The user selects an establishment. <br> 4. The user selects 1 menu from the available.<br> 5. If wanted, the user can leave a rating and a comment.<br> 
| *Alternative flows and exceptions* | 1. [Establishment closed] If, in step 3 the user selects an establishment that is closed the system displays an error and makes the user go back to step 3. |

|||
| --- | --- |
| *Name* | Get a recommendation |
| *Actor* |  User | 
| *Description* | The user gets recommended a meal considering his choice and other users feedback |
| *Preconditions* | - The user wants the best possible option considering his preference |
| *Postconditions* | - The user gets a menu from an establishment with the highest rating according to his choice. |
| *Normal flow* | 1. The user opens the application.<br> 2. The user clicks the recommendation button.<br> 3.The user inputs his preference(meat,fish,etc.). <br> 4.The user receives a menu recommendation.<br>  5. If wanted, the user can leave a rating and a comment.  |
| *Alternative flows and exceptions* | 1. [Everything closed] If, in step 2 of the normal flow all establishments are closed the user receives a warning message |


### User stories
The user stories should be created as GitHub issues. Therefore, this section will *not* exist in your report, it is here only to explain how you should describe the requirements of the product as **user stories**. 

A user story is a description of desired functionality told from the perspective of the user or customer. A starting template for the description of a user story is 

*As a < user role >, I want < goal > so that < reason >.*

User stories should be created and described as [Issues](https://github.com/LEIC-ES-2021-22/templates/issues) in GitHub with the label "user story". See how to in the video [Creating a Product Backlog of User Stories for Agile Development using GitHub](https://www.youtube.com/watch?v=m8ZxTHSKSKE).

You should name the issue with the text of the user story, and, in the "comments" field, add any relevant notes, the image(s) of the user interface mockup(s) (see below) and the acceptance test scenarios (see below). 

**INVEST in good user stories**. 
You may add more details after, but the shorter and complete, the better. In order to decide if the user story is good, please follow the [INVEST guidelines](https://xp123.com/articles/invest-in-good-stories-and-smart-tasks/).

**User interface mockups**.
After the user story text, you should add a draft of the corresponding user interfaces, a simple mockup or draft, if applicable.

**Acceptance tests**.
For each user story you should write also the acceptance tests (textually in [Gherkin](https://cucumber.io/docs/gherkin/reference/)), i.e., a description of scenarios (situations) that will help to confirm that the system satisfies the requirements addressed by the user story.

**Value and effort**.
At the end, it is good to add a rough indication of the value of the user story to the customers (e.g. [MoSCoW](https://en.wikipedia.org/wiki/MoSCoW_method) method) and the team should add an estimation of the effort to implement it, for example, using t-shirt sizes (XS, S, M, L, XL).



### Domain model

To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module. 
Also provide a short textual description of each class. 

Example:
 <p align="center" justify="center">
  <img src="https://github.com/LEIC-ES-2021-22/templates/blob/main/images/DomainModel.png"/>
</p>
