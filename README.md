<img src="./readme/templates/title.svg"/>

<br><br>

<!-- project philosophy -->
<img src="./readme/templates/project_philosophy.svg"/>

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
<img src="./readme/templates/tech_stacks.svg"/>

###  The following are the technologies I used to build Bound Harmony:

- This project uses the [Flutter app development framework](https://flutter.dev/). Flutter is a cross-platform hybrid app development platform which allows us to use a single codebase for apps on mobile, desktop, and the web. As for managing the state of the app, I used Provider.
  <br><br>
- The admin panel is done using [React.js](https://react.dev/). React.js is a JavaScript library for building single-page applications out of individual pieces called components.
<br><br>
- The backend is handled using [Laravel](https://laravel.com/). Laravel is a PHP web application framework that follows the Model-View-Controller (MVC) architectural pattern. With features like Eloquent ORM and artisan command-line tools, Laravel facilitates development and supports modern, feature-rich web applications.
<br><br>
- For managing the database schemas and establishing relational connections between tables, I used [MySQL](https://www.mysql.com/), a relational database management system. MySQL ensures efficient data storage and retrieval, complementing Laravel's capabilities for seamless and reliable web application development.
<br><br>
- In the Advice section, I integrated [openAi](https://platform.openai.com/docs/introduction). In order to make the advice personalized, survey responses are handled in the backend and are summarized before being sent to the api, you can read more about prompt handling in the Prompt Engineering section. I also used [Laravel's OpenAi Library](https://github.com/openai-php/laravel), which is open source and helps with handling the openAi api.
<br><br>
- In the Suggestions section, I used Google's [Google Places Api](https://developers.google.com/maps/documentation/places/web-service/search-nearby) nearby-search. The Google Places Api has a database with over 200 million places, categorized into types and sections. So, I took advantage of this categorization, in correlation with the user's survey responses, to dynamically get the places that best suites each user.   
<br><br>

### Mockup Examples
<!-- UI UX -->
<img src="./readme/templates/UIUX.svg"/>

> I designed Bound Harmony using wireframes and mockups, iterating on the design until I reached the ideal layout for easy navigation and a seamless user experience.
>
<br><br>

| Survey Screen | Suggestions screen | Advice Screen | 
| ---| ---| ---|
| ![Survey](./readme/screenshots/survey.png) | ![Date](./readme/screenshots/suggestions.png) | ![Survey](./readme/screenshots/advice.png) | 


Check more of my Mockups on [figma](https://www.figma.com/file/TSZRJHG6RUwk7BSmmw0xqp/Final-Project-WireFrame?type=design&node-id=20-6&mode=design&t=tO7JOSC5rfTelpo4-0).
<br><br>

<!-- Database Design -->

<img src="./readme/templates/dbdesign.svg"/>

![Database](./readme/screenshots/database.png)

<br><br>

<!-- Implementation -->
<img src="./readme/templates/implementation.svg"/>

### User Screens (Mobile)

| OnBoarding Screen | Register screen | Setup screen | Succesful Setup screen  |
| ---| ---| ---| ---|
| ![OnBoarding](./readme/screenshots/OnBoarding.jpeg) | ![Register](./readme/screenshots/SignUp.jpeg) | ![Setup](./readme/screenshots/Setup.jpeg) | ![SetupSuccess](./readme/screenshots/SetupSucess.jpeg) |
| Surveys screen | Suggestion screen (Landing) | Advice Screen |  Profile Screen |
| ![SetupSuccess](./readme/screenshots/Surveys.jpeg) | ![SuggestionLanding](./readme/screenshots/Suggestions.jpeg) | ![DateBuilder](./readme/screenshots/Advice.jpeg) | ![BondingActivities](./readme/screenshots/Profile.jpeg) |
| Inside Surveys | Inside Suggestions | Incoming Requests screen | My Partners screen | 
| ![CouplesSurvey](./readme/screenshots/Personal-survey.jpeg) | ![Dates](./readme/screenshots/DateBuilder.jpeg) | ![IncomingRequestsScreen](./readme/screenshots/Incoming-Requests-with-req.jpeg) | ![MyPartnersInRelationship](./readme/screenshots/MyPartners-with-current.jpeg) |
| Survey Complete | User Not Connected | Survey Not Complete | User Already Connected |
| ![PersonalSurveyComplete](./readme/screenshots/PersonalSurvey-responses-saved.jpeg) | ![MyPartnersSingleNoHistory](./readme/screenshots/MyPartnersEmpty.jpeg) | ![SuggestionsAlert2](./readme/screenshots/incomplete-survey.jpeg)| ![SuggestionsAlert2](./readme/screenshots/Incoming-request-in-a-real.jpeg)


### Demo

| Login-Setup | Incoming Requests | Couple's Survey |
| --- | --- | --- |
| <img src="./readme/gifs/login_Setup.gif" width="200" height="450">| <img src="./readme/gifs/IncomingRequests.gif" width="200" height="450"> | <img src="./readme/gifs/survey_response.gif" width="200" height="450"> | 
| Date Suggestions | Personalized Advice | Disconnect from Partner |
| <img src="./readme/gifs/dates.gif" width="200" height="450"> | <img src="./readme/gifs/advice.gif" width="200" height="450"> | <img src="./readme/gifs/disconnect.gif" width="200" height="450"> |

### Admin Screens (Web)

> To keep track of all incoming inputs, the admin page displays a summary of the users' behavior and the total number of times each survey response option was chosen. 

| Login screen  | Dashboard Screen |
| ---| ---|
| ![Landing](./readme/screenshots/admin_signin.png) | ![fsdaf](./readme/screenshots/dashboard.png) | 
| Users Screen | Survey Responses |
| ![Landing](./readme/screenshots/users.png) | ![fsdaf](./readme/screenshots/surveyResponses.png) |

<br><br>

### Flutter App

<video src="https://github.com/MarcDagher/Bound-Harmony/assets/120271000/5e24ff97-ed39-429a-b542-ffdb2b55c0ff" height="400" width="250">



### React Admin

https://github.com/MarcDagher/Bound-Harmony/assets/120271000/ce09dbe9-84bf-4235-994d-bbfb34eb0e97   

<br><br>

<!-- Prompt Engineering -->
<img src="./readme/templates/prompt_engineering.svg"/>

###  OpenAi Prompt Configuration:

To make the user's experience in the application more pleasant and entertaining, I used the data inputted from the surveys to make the responses personalized. Since the surveys are about interests, I created helper functions to summarize and label the user's interests. Then, I added the result into the AI's system prompt. 
The system prompt is divided into 6 parts: 
- Description: Describes the identity of the AI.
- Purpose: Describes the goal of the AI and its functionality.
- Tone Of Speech: Describes the choice of words and their semantics.
- End Statements: Describes how the AI will finish it's response.
- Removals: Specifies what to remove from the response.
- Our Interests or My Interests: Depending on whether the user is single or not, this final part is a list of keywords, derived by the summary of the user's survey responses, which is added to make sure the AI knows who the user is and what the user might want.

Here is a screenshot of the Ai's basic configuration:

<img src="./readme/prompt_engineering/base.png"/>

Depending on the user's conditions, the prompt will slightly differ. This is what the final prompt of a user who's connected to a partner will look like:

<img src="./readme/prompt_engineering/added.png"/>
  
<br><br>

<!-- Machine Learning -->
<img src="./readme/templates/machine_learning.svg"/>

### Cleaning Data and Training Models:

Since the theme of the app revolves around interests and relationships, I conducted a survey that received responses from 132 participants. The survey primarily targeted individual interests and perspectives on the respondents' relationships.

<img src="./readme/screenshots/google_survey.png" width="100%" />
<br></br>
Machine learning, a subset of AI, involves developing models that enable computers to learn from data, make predictions, and enhance performance on specific tasks without explicit programming. To train the model, I followed these steps:

- Cleaned, renamed, and reorganized the survey data using Pandas and NumPy. Pandas and NumPy are Python libraries employed for data manipulation and analysis, providing data structures like DataFrames and supporting large, multi-dimensional arrays.
Below is a snippet of the first few columns of the new and cleaned dataframe:

<img src="./readme/machine_learning/dataframe.png"/>

- Specified the attributes of the dataframe and the classification label. The classification label is the value to be predicted. In our case the classification label is "in_a_relationship", which is the very last column of the table. Attributes are the list of data (or the columns) which will be used by the model to make the correlation and predict the classification label.
  
- Visualized, assessed data cleanliness, and analyzed patterns with potential logical correlations. For this task, I utilized Weka, a versatile and user-friendly visual data mining and machine learning software.
The image below displays the cleaned data before feeding it into the model for training.
<br></br>
<img src="./readme/machine_learning/model_1_weka_2.png"/>

- Before moving on to data testing, it's noteworthy that the dataset shows nearly equal distribution, with 50% of respondents falling on each side of the data spectrum, making it a relatively balanced dataset.
  
- To assess the data's capabilities, a classification approach is adopted. Classification involves, stating to the model the label to be predicted, "in_a_relationship.". This label represents the likelihood that a user, based on their set of interests, is in a relationship.

- The model is then automatically trained on Weka using cross-validation. Cross-validation is a training technique which repeats a set of attributes multiple times and in a randomized way, in order to make the model's learning more diverse.
The following results are from the trained model on Weka:

<br></br>
<img src="./readme/machine_learning/model_1_weka_1.png"/>
<br></br>

We observe that the model accurately predicts the correct answer 58% of the time, but also shows errors 45% of the time. The model's training implementation involved Pandas, NumPy, and Sklearn. A DecisionTree technique was used, enabling the model to navigate its path to the correct answer by making one choice at a time. 

- To train the model using python, I specified to the model what it should use as attributes and what it will be predicting, the classification label. The following snippet shows the code representing the description, to the model, of the attributes and the class label.

<img src="./readme/machine_learning/attributes.png"/>
<br></br>

- Using Sklearn to split the data and divide it into a training set and a testing set. The following snippet shows the method which extracts 20% of the datframe as a testing set. 

<img src="./readme/machine_learning/splitting.png"/>
<br></br>

- Training the model using cross-validation, where the training set and the testing set were shuffled 10 times to enhance the model's learning diversity.
- Using a DecisionTree algorithm to predict the classification label.
- Giving the model a list of survey responses representing multiple users.
- Plotting the result and exporting it as a graph.

<img src="./readme/machine_learning/training.png"/>
<br></br>

- In the previous snippet, the model was given 4 lists of answers. The 2 values shown at the end of the snippet, below the code, represent the Model's prediction for each list of answers and the val_score, which is the average success for of the model's answers. According to the val_score, this model correctly predicts the relationship status of the user 52% of the time. The following image is the graph which represents a DecisionTree the model used to come up with the   correct predictions.

<img src="./readme/machine_learning/model_1_100.png"/>

- Based on the model's analysis, individuals who identify themselves as spiritual are more likely to be in a relationship. Following the paths, to the right of the root box and down to its end leaves, we see a number of bright orange-colored boxes, symbolizing a person in a relationship. This path represents the correlation that the model identified between a user's interest and the likelihood of them being in a relationship.

<br><br>
<!-- AWS Deployment -->
<img src="./readme/templates/AWS.svg"/>

###  Take Advantage of AWS' Integration:

While developing Bound Harmony's Laravel server locally, I chose to enhance accessibility by hosting the APIs on AWS, making them publicly available. AWS is a cloud computing platform provided by Amazon that offers a diverse range of scalable cloud services. The process of deployment included:
- Creating and configuring an instance.
- Installing Apache, MariaDb, and PHP.
- Creating a Database and a User.
- Installing Composer and Git.
- Cloning my Laravel server from my Github repo and downloading Laravel.
- Granting user all access and change laravel's permission files.
- Creating Laravel's environment (.env, generate key, change DB name, username, and password)
- Creating an Apache configuration file that will point the server to serve the files provided by Laravel instead of the default Apache page.

Here are the AWS deployment commands I used to deploy my Laravel server:

1. Update Amazon Linux 2023 Packages:

   ```sh
   sudo dnf update
   ```
2. Install LAMP Stack (Linux, Apache, MySQL, PHP):

   ```sh
   sudo dnf install httpd mariadb*-server php php-mysqlnd
   ```
3. Start and Enable the Apache and MariaDB Services:

   ```sh
   sudo systemctl enable --now httpd
   sudo systemctl enable --now mariadb
   ```
4. LogIn to MySWL and CREATE Database:

   ```sh
    sudo mysql
    CREATE DATABASE yourdb;
    CREATE USER 'youruser'@'localhost' IDENTIFIED BY 'password';
    GRANT ALL ON yourdb.* to 'youruser'@'localhost';
    FLUSH PRIVILEGES;
    quit;
   ```
 5. Install PHP Composer for Laravel on Amazon Linux 2023:

    ```sh
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
    sudo chmod +x /usr/local/bin/composer
    ```
6. Clone the Laravel Project:

   ```sh
   cd /var/www
   sudo dnf install git -y
   sudo git clone RepoLink
   ```
 7. Give Permission to Your Current to Access the Laravel Folder:

    ```sh
    cd /var/www/RepoNameLaravel
    sudo chown -R $USER /var/www/laravel
    ```
8. Install Laravel on Amazon Linux 2023:

   ```sh
   composer install
   sudo chown -R apache.apache /var/www/laravel
   sudo chmod -R 755 /var/www/laravel
   sudo chmod -R 777 /var/www/laravel/storage
   ```
 9. Create the Laravel Environment Configuration File:

    ```sh
    sudo cp .env.example .env
    sudo php artisan key:generate
    sudo nano .env
    ```
10. Go to the Database Section and Change the Values:

    ```sh
    Database Name
    Database Username
    Database Password 
    Save the file using Ctrl+O, hit the Enter key, and then exit the file using Ctrl+X.
    ```
11. Apache Configuration for PHP Laravel App:

    ```sh
    sudo nano /etc/httpd/conf.d/laravel.conf
    ```
12. Add the Following Lines:
   
```sh
     <VirtualHost *:80>
        ServerName laravel.example.com
        DocumentRoot /var/www/laravel/public 

        <Directory /var/www/laravel>
               AllowOverride All
        </Directory>
     </VirtualHost>
   ```
13. Restart the Apache:

    ```sh
    sudo systemctl restart httpd
    ```
14. Get Access to Your IP:
    ```sh
    curl ipinfo.io
    ```
    You will receive a list of details about your server. 'ip' is the IP adress of your new server. You can access it in the url of your browser.

NOTE: To access Laravel's Server APIs, use the following IP address: 15.188.8.50/api
NOTE: In Advice screen and Suggestions screen, you might not receive the desired response because they depend on OpenAi's api key and Google Places' api key, which might be deactivated by the time you test the api end-points. 
<br><br>

<!-- Unit Testing -->
<img src="./readme/templates/unit_testing.svg"/>

###  Precision in Development:

- The number one reason for chaos and errors during development is insufficient testing. For this reason, Unit Testing has proven to be one of the best ways to address this issue. By adopting the AAA (Arrange - Act - Assert) approach, Unit Testing effectively minimizes the chances of encountering errors in our projects during development or after production. 
The following screenchot illustrates a snippet of the test results implemented in my application.

<img src="./readme/unit_testing/UnitTesting.png"/>

<br><br>

<!-- How to run -->
<img src="./readme/templates/how_to_run.svg"/>

### Prerequisites:

1. Install [Flutter SDK](https://docs.flutter.dev/get-started/install)
   
2. Install [Composer](https://getcomposer.org/)
 
   ```sh
   composer install
   ```
3. npm

   ```sh
   npm install npm@latest -g
   ```
   <br></br>
> To set up Bound Harmony locally, follow these steps:

Clone the repo
   
   ```sh
   git clone https://github.com/MarcDagher/Bound-Harmony.git
   ```

### To Run the Admin Web App

1. Go to react_app_admin directory

     ```sh
     cd react_app_admin
     ```

 2. Install npm packages

    ```sh
    npm install
    ```
3. Run the react app

   ```sh
   npm start
   ```
Note: Inside your React app, make sure your BaseUrl, inside public/source/configurations/request_function.js, is set to your current local host server. By default, it is set to the AWS server.
   <br></br>
### To Start the Laravel Server on LocalHost

1. Go to laravel_bh directory

     ```sh
     cd laravel_bh
     ```

2. Rename your '.env.example' file to '.env'

3. Open your new .env file and make the necessary changes (App name, app key, database name...)

4. Generate an application key:

   ```sh
   php artisan key:generate
   ```

5. Inside your .env file add your OPENAI_API_KEY and GOOGLE_PLACES_API_KEY <br><br>Note: Advice Screen and Suggestions Screen need these 2 keys.

6. Get Migrations

   ```sh
   php artisan migrate
   ```
7. Seed Database: You can go to database/seeders/DatabaseSeeder and uncomment the lines you want to seed in the order they are written. 

   ```sh
   php artisan db:seed
   ```
8. Run Server:
    
     ```sh
     php artisan serve
     ```
<br></br>
## To Run the Flutter App

1. Go to flutter_app directory

     ```sh
     cd flutter_app
     ```
2. Install pub packages

     ```sh
     flutter pub get
     ```
3. Run flutter_app

     ```sh
     flutter run
     ```
Note: Inside your Flutter app, make sure your BaseUrl, inside lib/configurations/request.configuration.dart, is set to your current local host server. By default, it is set to the AWS server.

Now, you should be able to run Bound Harmony locally and explore its features :) :rocket:
