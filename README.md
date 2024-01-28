<img src="./readme/title.svg"/>

<br><br>

<!-- project philosophy -->
<img src="./readme/project_philosophy.svg"/>

> A mobile app for connecting lovers together and assisting them through a fun and harmonious relationship.
>
> Bound Harmony first requires the users, who probably are in a relationship, to connect their accounts and fill a survey. To make their relationship smoother, Bound Harmony will provide the couple with date suggestions and bonding activities. To make it even better, our cupid will be ready to give advice at any time!

### User Stories
- As a user, I want recommendations for fun and romantic date night ideas to keep our relationship exciting.
- As a user, I'd like suggestions for weekend getaways that align me and my partner's shared interests, creating memorable experiences for both of us.
- As a user, I want personalized advice to enhance both my personal journey and my relationship.

### Admin Stories
- As an admin, I want to monitor users' behavior within the application to understand their preferences and interests.
- As an admin, I want to be able to manage user accounts by deleting or restoring accounts.
- As an admin, I want to see the most common responses to my surveys, so that I can use this data to enhance my app.
<br><br>

<!-- Tech stack -->
<img src="./readme/tech_stacks.svg"/>

###  The following are the technologies I used to build Bound Harmony:

- This project uses the [Flutter app development framework](https://flutter.dev/). Flutter is a cross-platform hybrid app development platform which allows us to use a single codebase for apps on mobile, desktop, and the web.
  <br><br>
- The admin panel is done using [React.js](https://react.dev/). React.js is a JavaScript library for building single-page applications out of individual pieces called components.
<br><br>
- The backend is handled using [Laravel](https://laravel.com/). Laravel is a PHP web application framework that follows the Model-View-Controller (MVC) architectural pattern. With features like Eloquent ORM and artisan command-line tools, Laravel facilitates development and supports modern, feature-rich web applications.
<br><br>
- For managing the database schemas and establishing relational connections between tables, I used [MySQL](https://www.mysql.com/), a relational database management system. MySQL ensures efficient data storage and retrieval, complementing Laravel's capabilities for seamless and reliable web application development.
<br><br>
- In the Advice section, I integrated [openAi](https://platform.openai.com/docs/introduction). In order to make the advice personalized, survey responses are handled in the backend and are summarized before being sent to the api, you can read more about prompt handling in the Prompt Engineering section. I also used [Laravel's OpenAi Library](https://github.com/openai-php/laravel), which is open source and helps with handling the openAi api.
<br><br>
- In the Suggestions section, I used Google's [Google Places Api](https://developers.google.com/maps/documentation/places/web-service/search-nearby) nearby-search. The Google Places Api has a database with over 200 million places, categorized into types and sections. So, I took advantage of this categorization, in correlation with the user's survey responses, to get the places that best suites each user.   
<br><br>
- The app uses the font ["Nunito"](https://fonts.google.com/specimen/Work+Sans) as its main font, and the design of the app adheres to the material design guidelines.
<br><br>

### Mockups
<!-- UI UX -->
<img src="./readme/UIUX.svg"/>

> I designed Bound Harmony using wireframes and mockups, iterating on the design until I reached the ideal layout for easy navigation and a seamless user experience.
>
> Project Figma design [figma](https://www.figma.com/file/TSZRJHG6RUwk7BSmmw0xqp/Final-Project-WireFrame?type=design&node-id=20-6&mode=design&t=tO7JOSC5rfTelpo4-0)
<br><br>

| Survey Screen | Suggestions screen | Advice Screen | 
| ---| ---| ---|
| ![Survey](./readme/screenshots/figma-survey.png) | ![Date](./readme/screenshots/figma-date.png) | ![Survey](./readme/screenshots/figma-advice.png) | 

<br><br>

<!-- Database Design -->
<img src="./readme/dbdesign.svg"/>
### Architecting Data Excellence: Innovative Database Design Strategies:

![OnBoarding](./readme/screenshots/OnBoarding.jpeg)

<!-- Implementation -->
<img src="./readme/implementation.svg"/>

| OnBoarding Screen | Register screen | Setup screen | Succesful Setup screen  |
| ---| ---| ---| ---|
| ![OnBoarding](./readme/screenshots/OnBoarding.jpeg) | ![Register](./readme/screenshots/SignUp.jpeg) | ![Setup](./readme/screenshots/Setup.jpeg) | ![SetupSuccess](./readme/screenshots/SetupSucess.jpeg) |
| Surveys screen | Suggestion screen (Landing) | Advice Screen |  Profile Screen |
| ![SetupSuccess](./readme/screenshots/Surveys.jpeg) | ![SuggestionLanding](./readme/screenshots/Suggestions.jpeg) | ![DateBuilder](./readme/screenshots/Advice.jpeg) | ![BondingActivities](./readme/screenshots/Profile.jpeg) |
| Inside Surveys | Inside Suggestions | Incoming Requests screen | My Partners screen | 
| ![CouplesSurvey](./readme/screenshots/CouplesSurvey.jpeg) | ![Dates](./readme/screenshots/DateBuilder.jpeg) | ![IncomingRequestsScreen](./readme/screenshots/Incoming-Requests-with-req.jpeg) | ![MyPartnersInRelationship](./readme/screenshots/MyPartners-with-current.jpeg) |
| Survey Complete | User Not Connected | Survey Not Complete | User Already Connected |
| ![PersonalSurveyComplete](./readme/screenshots/PersonalSurvey-responses-saved.jpeg) | ![MyPartnersSingleNoHistory](./readme/screenshots/MyPartnersEmpty.jpeg) | ![SuggestionsAlert2](./readme/screenshots/incomplete-survey.jpeg)| ![SuggestionsAlert2](./readme/screenshots/Incoming-request-in-a-real.jpeg)

<br><br>

### User Screens (Mobile)
| Sign Up | Login-Setup | Profile Customization | 
| --- | --- | --- |
| <img src="./readme/gifs/signUp.gif" width="230" height="450"> | <img src="./readme/gifs/login_Setup.gif" width="230" height="450"> | <img src="./readme/gifs/ProfileCustomization.gif" width="230" height="450">
| Incoming Requests | Personal Survey | Couple's Survey |
| <img src="./readme/gifs/IncomingRequests.gif" width="230" height="450"> | <img src="./readme/gifs/PersonalSurvey.gif" width="230" height="450"> | <img src="./readme/gifs/CoupleSurvey.gif" width="230" height="450"> | 
| Date Suggestions | Bonding Activities Suggestions | Personalized Advice |
| <img src="./readme/gifs/dates.gif" width="230" height="450"> | <img src="./readme/gifs/bonding.gif" width="230" height="450"> | <img src="./readme/gifs/advice.gif" width="230" height="450"> |
| Disconnect from Partner |
| <img src="./readme/gifs/disconnect.gif" width="230" height="450"> |

> To keep track of all the inputs coming into the app, the admin page displays a summary of the users' behavior and their responses to each survey. 

### Admin Screens (Web)
| Login screen  | Dashboard Screen |
| ---| ---|
| ![Landing](./readme/screenshots/admin_signin.png) | ![fsdaf](./readme/screenshots/dashboard.png) | 
| Users Screen | Survey Responses |
| ![Landing](./readme/screenshots/users.png) | ![fsdaf](./readme/screenshots/surveyResponses.png) |
<br><br>

<!-- How to run -->
<img src="./readme/how_to_run.svg"/>

> To set up Bound Harmony locally, follow these steps:

### Prerequisites

* npm
  ```sh
  npm install npm@latest -g
  ```

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/MarcDagher/Bound-Harmony.git
   ```
2. Install [Composer](https://getcomposer.org/)
   ```sh
   composer install
   ```
3. Rename your '.env.example' file to '.env'
<br><br>
4. Open your new .env file and make the necessary changes (App name, app key, database name...)
<br><br>
5. Generate an application key:
   ```sh
   php artisan key:generate
   ```
6. Get Migrations
   ```sh
   php artisan migrate
   ```
7. Seed Database
   ```sh
   php artisan db:seed
   ```
8. Install NPM packages
   ```sh
   npm install
   ```
9. Install [Flutter SDK](https://docs.flutter.dev/get-started/install)
<br><br>
10. Go to flutter_app directory
     ```sh
     cd flutter_app
     ```
11. Install pub packages
     ```sh
     flutter pub get
     ```
12. Run flutter_app 
     ```sh
     flutter run
     ```

Now, you should be able to run Bound Harmony locally and explore its features :) :rocket:
