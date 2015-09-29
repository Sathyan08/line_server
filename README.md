# About
-----

This application establishes a simple API that returns lines from a text file.  Although the two sample files are small, I designed this system to scale well for both the size of the file and the number of users submitting get requests to retrieve information from the API.

I was asked to build a server that would respond to HTTP GET requests such that a request formatted as "/lines/:id" would return a line number equal to the id number in the request.


### How to run this system.

To use this application, you should first clone a copy of this repository from GitHub.

    git init
    git clone https://github.com/Sathyan08/line_server


After that, you may want to add a text file to the application so that you can retrieve lines of text using this application.  You can add the text file to the /db/data folder.

If you do not have redis installed, you should install it before running this app.  You can use Homebrew to install Redis.

```
brew install redis
```
If you do not have Homebrew installed, you can follow the instructions to install Redis on Mac OS X found at: [I'm an inline-style link]( jasdeep.ca/2012/05/installing-redis-on-mac-os-x ).

You should also install PostgresSQL if you do not have it.  You can find instructions on how to install PostgresSQL on Mac OS X at [I'm an inline-style link]( www.codefellows.org/blog/three-battle-tested-ways-to-install-postgresql )

Next, navigate to the root directory and input:

```
bash run.sh FILE_NAME
```

The FILE_NAME should be the exact name of the text file that you want to use, including the extension at the end.  For example, you could input `bash run.sh sample_file.txt` to use the sample file that I included with this repository.

# Questions.
-------------

### 1.  How does this system work?

This system preprocesses the text file using ruby scripts and saves the each line's line number and text to a PostgresSQL database.  After that, it caches each line into a Redis key-value store.  It uses Rails 4.2's API functionality to return line numbers in response to GET requests.  The application will retrieve these lines of text from the Redis cache rather than the database.

### 2. How will your system perform with a 1 GB file? a 10 GB file? a 100 GB file?

The application should do well with the 1 GB file and the 10 GB file, provided that the Redis server has access to adequate RAM.  Anyone running this application could use a server that has more than enough memory to store the entire file in the cache while leaving enough RAM to run other functions that the server needs as well as run the rest of the application code.

The application, in its current state, may not be able to handle a 100 GB file because most servers cannot cache a file of that size and leave enough RAM for the other functions that the server must perform to run the application.  The application would slow down significantly because it would start to use the disk to access more memory, and the disk's memory is much slower than the RAM.

At that point, anyone running this application would probably need to spread the data of the file across multiple Redis servers.  Someone would need to modify the controller to identify which Redis instance that it should try to retrieve the data from.

### 3. How will your system perform with 100 users? 10,000 users? 1,000,000 users?

This application should scale well as the number of users increases.  It can retrieve data for the users quickly because it stores the data as a hash stored in volatile memory, which means that it should be able to respond to user responses quickly.  If necessary, anyone using this application could probably scale this application horizontally by adding more servers to process requests and make requests for information from the Redis server.

### 4. What documentation, websites, papers, etc did you consult in doing this assignment?

I researched Stack Overflow to learn more about Redis and Memcached, which were the two technologies that I initially considered when I first started working on this project.  I also used Stack Overflow to learn how to specify the status to send when rendering json in a Rails API.

I consulted Brewhouse.io on how to use service objects to keep models thin in Rails apps.  [I'm an inline-style link]( brewhouse.io/blog/2014/04/30/gourmet-service-objects.html )

I used Site Point to learn how to incorporate Redis into a Rails application.  You can find the specific article that I referenced at [I'm an inline-style link]( www.sitepoint.com/introduction-to-using-redis-with-rails ).

I watched the Railscast episode on Memcached to review how to incorporate Memcached into a Rails app, even though I ultimately decided to use Redis for this project.  [I'm an inline-style link]( railscasts.com/episodes/380-memcached-dalli )

### 5. What third-party libraries or other tools does the system user?  How did you choose each library or framework that you used?

This application uses Rails 4.2, a Postgres SQL database, and a Redis server for caching.

I used Rails 4.2 because I am familiar with it, and I was able to produce this project in about 2 despite the fact that I had not used Redis in any of my projects before.  I wanted to finish this project in a timely manner, so I stuck with the framework that I was most familiar with.

I decided to use Redis for caching in order to improve the performance of this application.  The tech community seems to agree that Redis performs quickly and is excellent at allowing users to utilize a variety of data structures.  I decided to represent the different lines of the text file as elements of an array, and I was able to use this data structure easily using Redis.  Morever, I decided that I wanted to use Redis because I could change the data structure that I used to respond to queries if I needed to respond to other types of requests for information or analyze the data in another way.  Redis would be the most flexible if I wanted to expand the scope of the project.

I decided to include a Postgres Sql database as well.  Redis should be able to store most text files in memory, but I would have problems with truly enormous files because Redis relies on volatile memory, which is expensive.  Past a certain point, the file would no longer fit into a single Redis instance, and it might be better to store the data in a standard database.  Moreover, I used Postgres to further validate the data extracted from the file.  I also believe that it may be useful to keep the Postgres database in case I chose to add a schema to this project later.  For example, I could keep track of which file each line of text came from if I chose to extract lines from multiple text files in a future version of this application.

### 6. How long did you spend on this exercise? If you had unlimited more time to spend on this, how would you spend it and how would you prioritize each item?

I spent about 2.5 hours on this project between coding and research.  If I had unlimited time, I would focus on the following:

  - A. I would stop using a global variable, and I would find some way to store the Redis store as an object.  I feel like the global variable makes the system fragile because variables are easily overwritten.

  - B.  I would create an ORM to retrieve information from my Redis store and design a consistent, easy to use interface for it so that I could easily adapt it if the needs of project expanded or changed.

  - C.  I would create rake tasks and jobs to help maintain the application.  For example, I would create a task to clear the Redis store in case I wanted to change what data to include in it.

  - D.  I would refactor the service objects to have a more easily understandable interface.  Right now, the service objects are namespaced within the "Line" class, but they accept "requests" which are actually only id numbers.  I should have created an interface / design where the class that placed the service object within is parameter that I enter into the .call method.  For example, I should have handled exceptions in a service object called `Param::IdentifyError.call(params)` and I should have called the status code service object `Param::IdentifyResponseStatus.call(params)`.  This way, developers who work on this project can intuitively know how to use the service objects without looking them up to see each object's interface.

  - E.  I would extract more of the logic used in the ruby scripts that I used to load and cache the data into service objects.  This way, I could use those objects in other contexts.  For example, I could use create multiple Redis stores, each one representing a different file.  If I used objects to generate redis stores, I could create a job that processes files asynchronously after users uploaded them.

  I would start with A and stop using the global variable if possible.  I want to make sure my system is robust before moving onto other tasks.

  Next, I would do C because developing these tools will ultimately make it easier and less time consuming to maintain and modify the system, which will ultimately save time in the long run.

  I would then refactor the code to create more consistent interfaces and extract more logic into the service objects.  This will allow me to expand on the application's functionality more easily because I will find it easier

  I would do B last.  I would only need to develop the ORM to expand on the features of the application because the system that I have right now does an adequate job of handling current requirements of the app.  Moreover, I would need to spend a lot of time developing a robust and intuitive ORM.  I would possibly spend a lot of time on this aspect of the project for no reason, which is why I would do that last.

  ### 7.  If you were to critique your code, what would you have to say about it?

  As mentioned in my previous answer (no. 6), I feel that I missed some opportunities to design better, more intuitive objects with consistent interfaces.  Moreover, I could have extracted more logic into objects in order to make my code more modular and reuseable.

  I also feel that the show action on the LineController is still a little too busy, and I wish I could extract more logic into the objects.  I include two boolean checks to see when to generate custom exceptions or custom status codes.  I did this for performance reasons because I did not want to devote resources to create additional objects when it was not necessary.  Nonetheless, I feel like including these boolean checks on the controller may create problems down the road because it feels like each object should contain all of its own logic.  In this case, it feels wrong to have some of the logic regarding exceptions and status codes on the controller and some of that logic in the service objects.
