<img src="./readme/title1.svg"/>

<br><br>

<!-- project philosophy -->
<img src="./readme/title2.svg"/>

> A mobile app for connecting lovers together and assisting them through a fun and harmonious relationship.
>
> Bound Harmony first requires the users, who probably are in a relationship, to connect their accounts and fill a survey. To make their relationship smoother, Bound Harmony will provide the couple with date suggestions and bonding activities. To make it even better, our cupid will be ready to give advice at any time!

### User Stories

- As a user, I like to spend quality time with my partner. So, I want suggestions for places and activities that suit our interests.
- As a user, I want recommendations for cozy cafes or quiet spots where my partner and I can have meaningful conversations.
- As a user, I want to have access to good relationship and personal advice to help me in my self-development journey.
- As a user, I'd like suggestions for weekend getaways that align me and my partner's shared interests, creating memorable experiences for both of us.
- As a user, I want suggestions for nice and creative gifts, so that I will have a platform for inspiration.
- As a user, I want to explore new hobbies or activities with my partner, so I'm looking for suggestions that join both our interests.
- As a user, I want recommendations for fun and unique date night ideas to keep our relationship exciting.
<br><br>

<!-- Prototyping -->
<img src="./readme/title3.svg"/>

> I designed Bound Harmony using wireframes and mockups, iterating on the design until I reached the ideal layout for easy navigation and a seamless user experience.

### Wireframes
| Login screen  | Register screen |  Landing screen |
| ---| ---| ---|
| ![Landing](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) |

### Mockups
| Home screen  | Menu Screen | Order Screen |
| ---| ---| ---|
| ![Landing](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) |

<br><br>

<!-- Implementation -->
<img src="./readme/title4.svg"/>

> Using the wireframes and mockups as a guide, I implemented the Bound Harmony app with the following features:

### User Screens (Mobile)
| OnBoarding Screen | Login screen  | Register screen | Setup screen |
| ---| ---| ---| ---|
| ![OnBoarding](./readme/screenshots/OnBoarding.jpeg) | ![Login](./readme/screenshots/LogIn.jpeg) | ![Register](./readme/screenshots/SignUp.jpeg) | ![Setup](./readme/screenshots/Setup.jpeg) |
| Successful Setup screen | Suggestion screen (Landing) | Date Builder Screen |  Bonding Activities Screen |
| ![SetupSuccess](./readme/screenshots/SetupSucess.jpeg) | ![SuggestionLanding](./readme/screenshots/Suggestions.jpeg) | ![DateBuilder](./readme/screenshots/DateBuilder.jpeg) | ![BondingActivities](./readme/screenshots/BondingActivities.jpeg) |
| Suggestions Screen alert 1 | Suggestions Screen alert 2 | Surveys Screen | Personal Survey Screen | 
| ![SuggestionsAlert1](./readme/screenshots/Datebuilder-connected-and-personal-survey.jpeg) | ![SuggestionsAlert2](./readme/screenshots/Date-Builder-partner's-CS.jpeg) | ![Surveys](./readme/screenshots/Surveys.jpeg) | ![PersonalSurvey](./readme/screenshots/Personal-survey.jpeg) |
| Couples Survey Screen | Personal Survey complete | Couples Survey complete | Advice screen |
| ![CouplesSurvey](./readme/screenshots/CouplesSurvey.jpeg) | ![PersonalSurveyComplete](./readme/screenshots/PersonalSurvey-responses-saved.jpeg) | ![CouplesSurveyComplete](./readme/screenshots/CS-responses-saved.jpeg) | ![Advice](./readme/screenshots/Advice.jpeg) |
| Profile screen | Incoming Requests alert 1 | Incoming Requests screen | Suggestions Screen alert 2 |
| ![Profile](./readme/screenshots/Profile.jpeg) | ![IncomingRequestsAlert1](./readme/screenshots/Incoming-NoPartner.jpeg) | ![IncomingRequestsScreen](./readme/screenshots/Incoming-Requests-with-req.jpeg) | ![SuggestionsAlert2](./readme/screenshots/Incoming-request-in-a-real.jpeg) |
| My Partners screen (single) | My Partners (in a relationship) | My Partners (single + no history) |
| ![MyPartnersSingle](./readme/screenshots/MyPartners-history-with-no-current.jpeg) | ![MyPartnersInRelationship](./readme/screenshots/MyPartners-with-current.jpeg) | ![MyPartnersSingleNoHistory](./readme/screenshots/MyPartnersEmpty.jpeg) |



### Admin Screens (Web)
| Login screen  | Register screen |  Landing screen |
| ---| ---| ---|
| ![Landing](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) |
| Home screen  | Menu Screen | Order Screen |
| ![Landing](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) |

<br><br>

<!-- Tech stack -->
<img src="./readme/title5.svg"/>

###  Bound Harmony is built using the following technologies:

- This project uses the [Flutter app development framework](https://flutter.dev/). Flutter is a cross-platform hybrid app development platform which allows us to use a single codebase for apps on mobile, desktop, and the web.
- For persistent storage (database), the app uses the [Hive](https://hivedb.dev/) package which allows the app to create a custom storage schema and save it to a local database.
- To send local push notifications, the app uses the [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) package which supports Android, iOS, and macOS.
  - 🚨 Currently, notifications aren't working on macOS. This is a known issue that we are working to resolve!
- The app uses the font ["Work Sans"](https://fonts.google.com/specimen/Work+Sans) as its main font, and the design of the app adheres to the material design guidelines.

<br><br>

<!-- How to run -->
<img src="./readme/title6.svg"/>

> To set up Bound Harmony locally, follow these steps:

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* npm
  ```sh
  npm install npm@latest -g
  ```

### Installation

_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo
   ```sh
   git clone https://github.com/your_username_/Project-Name.git
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Enter your API in `config.js`
   ```js
   const API_KEY = 'ENTER YOUR API';
   ```

Now, you should be able to run Bound Harmony locally and explore its features.
