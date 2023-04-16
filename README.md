# Honeywell Assessment iOS

![Honeywell](./assets/Honeywell.png 'Honeywell')

## Welcome to the iOS Engineer Assessment!

We are glad to know that you are here 🥳 <br/>
In this step is time to show us what you got!

### Objective

The goal of this assessment is to create a simple iOS Application that displays a list of the available Pokémon from the [PokéAPI](https://pokeapi.com/) service. <br/>
Each Pokémon on the list should be able to have a single view to show more details about each one. <br/>
Consider the case of no internet connection, to only show the local data we got the last time we used the app. <br/>
To successfully complete this assessment, you will need to implement a good design pattern and follow design principles.

### Instructions

- Design the application's UI, ensuring it follows design principles and is easy to use. This will involve designing a list view to display items.
- Use a good design pattern to organize your codebase. This will involve creating separate classes and functions for different features of your application.
- Test your application thoroughly to ensure that it is functioning as expected. This will involve checking the internet connection, details of single Pokémon, and that the application is visually appealing and easy to use.
- Optimize the performance of your application to ensure that it runs smoothly on a range of iPhone devices.
- Update the [INSTRUCTIONS.md](./INSTRUCTIONS.md) file with a little guide on how to run the app or any special considerations such as third-party dependencies.

### Requirements

- User interface
  - **Main view** (named Pokédex)
    - Search input for the user to enter a Pokémon id or name.
    - Single display area for the list of all the Pokémon
  - **Detail view** (to show the details of a Pokémon)
    - Image container
    - Container to show the id and name of the Pokémon
    - Preferred clean template to reveal details of a Pokémon
    - Available only if there is an active internet connection
- Functionality
  - Implement the functionality to fetch a list of Pokémon, the data should be paginated with a page size of 15 items per request; when the user reaches the end of the list, the app should request the next page of the list
  - Display the results of the Pokémon list on the display area inside the main view
  - Implement the functionality to fetch the data of a single Pokémon
  - When the user selects a Pokémon from the list of the **main view**, the app should change to the detail view with the information about them
  - The **detail view** show should have a back button to show again the list of all the Pokémon
  - When the user writes a valid id or name of Pokémon on the search bar and presses the enter key on the keyboard, the app should show the detailed view of the Pokémon; emulating that the user has selected it from the main list.
  - If there is no internet connection, the app should show the last list of Pokémon we got the last time we used the app
  - If there is no internet connection, the app should disable the option to show the details of a single Pokémon
- Presenting information
  - [**Main View**] Each item of the list should display:
    - Name of Pokémon
    - Id of Pokémon
    - Image of Pokémon (nice to have)
  - [**Detail view**] The detail view for a single Pokémon should display:
    - Image of Pokémon
    - Id
    - Name
    - Abilities
    - Type
    - Height
    - Weight
    - Health
    - Attack
    - Defense
    - Special attack
    - Special defense
    - Speed
- Error handling
  - Implement error handling to manage incorrect Pokémon id, Pokémon name, or any API errors

### Hints

- Endpoint to request a single Pokémon

  ```
  [GET] https://pokeapi.co/api/v2/pokemon/{id or name}/
  ```

- Pokémon image could be found it on the Pokémon data model

  ```JSON
  "pokemon": {
      ...
      "sprites": {
          ...
          "front_default": "path-to-image"
          ...
      },
      ...
  }
  ```

- PokéAPI page [here](https://pokeapi.co/)
- PokéAPI docs [here](https://pokeapi.co/docs/v2#info)

### Considerations

- Please **fork** this repo with the next format
  - Name-LastName-Role, ie: John-Smith-iOSadvanced
- Commit as much as you want, and remember to show good practices.
- Once you got the final commit, push it with the title `last commit: Pokedex iOS App`
- Do **NOT** create a pull request, you will be evaluated based on your final commit.
- Try to code as clean as possible. Think of it as if you were tasked in real life.
- **Go beyond!** we greatly encourage you to go the extra mile and be bold about proposing <br/>

**Good luck with your assessment 🍀**
