CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(30) UNIQUE NOT NULL
    CHECK (LENGTH(username) > 3),
	email VARCHAR(70) UNIQUE NOT NULL
    CHECK (LENGTH(email) > 3),
	creation_date TIMESTAMP WITH TIME ZONE NOT NULL
	DEFAULT(NOW()),
	is_active BOOLEAN
);

CREATE TABLE categories(
	category_id SERIAL PRIMARY KEY,
	name VARCHAR(40) UNIQUE NOT NULL,
	creation_date TIMESTAMP WITH TIME ZONE NOT NULL
	DEFAULT(NOW())
);

INSERT INTO users (username, email, creation_date, is_active) VALUES
('printfKing', 'ninja@gmail.com', '2012-09-15 14:30:00', true),
('bugslayer', 'master@bytes.com', '2015-07-10 09:45:23', true),
('scriptWizard', 'wizard@scripts.net', '2018-03-05 18:20:42', true),
('debugQueen', 'queenofdebugging@yahoo.com', '2010-12-01 21:12:56', false),
('bugHunter', 'hackerman@gmail.com', '2016-11-20 11:25:17', false),
('bitJuggler', 'juggler@bits.org', '2014-08-17 16:55:39', false),
('loopGuru', 'guru@loops.com', '2013-05-12 07:40:21', false),
('syntaxError', 'error@syntax.io', '2019-10-08 13:15:34', false),
('asyncMaster', 'masterofasync@hotmail.com', '2020-04-25 03:48:02', false),
('nullPointer', 'pointer@null.org', '2017-06-30 22:05:14', true),
('pythoneer', 'pythoneer@gmail.com', '2011-08-27 17:09:03', true),
('htmlCoder', 'kidhacker@yahoo.com', '2014-02-14 08:36:27', true),
('perlGuru', 'guru@perl.org', '2013-09-09 12:55:10', true),
('error404', 'wizard@php.net', '2016-07-04 19:20:45', false),
('codeJuggler', 'juggler@code.io', '2018-11-29 14:18:37', true),
('bugzilla', 'master@java.com', '2010-03-22 11:30:59', true),
('rubyNinja', 'ninja@ruby.org', '2017-12-16 06:45:22', true),
('goGopher', 'gopher@golang.net', '2019-05-11 23:55:14', true),
('cSharpPro', 'pro@csharp.io', '2022-01-01 08:00:01', true),
('javascriptFan', 'fan@javascript.com', '2015-10-26 15:28:49', false),
('rustHacker', 'hacker@rust.org', '2016-04-19 10:10:10', true),
('swiftWizard', 'wizard@swift.net', '2018-09-13 12:40:00', true),
('pythonista', 'pythonista@gmail.com', '2011-05-08 20:17:57', true),
('codeGuru', 'guru@code.org', '2013-08-03 02:37:25', true),
('haskellHacker', 'hacker@haskell.io', '2015-03-27 09:53:12', true),
('javaScripter', 'scripter@javascript.com', '2017-10-20 16:24:08', false),
('goMaster', 'master@go.net', '2019-12-15 18:59:56', true),
('rubyist', 'rubyist@hotmail.com', '2014-06-10 22:42:39', true),
('cSharpNinja', 'ninja@csharp.io', '2016-01-05 11:11:11', true),
('pythonLover', 'lover@python.org', '2018-06-30 03:33:33', true);

INSERT INTO categories (name, creation_date) VALUES
  ('Java', '2010-04-15 09:32:18'),
  ('Angular', '2011-09-23 15:12:45'),
  ('Spring', '2012-06-30 11:25:03'),
  ('Git', '2013-03-12 17:40:21'),
  ('PostgreSQL', '2014-08-07 08:21:36'),
  ('TypeScript', '2015-11-19 14:53:52'),
  ('React', '2016-07-26 20:39:05'),
  ('Docker', '2017-02-18 12:15:29'),
  ('Kubernetes', '2018-05-03 18:47:44'),
  ('GraphQL', '2019-10-11 09:58:53'),
  ('Python', '2020-09-05 16:02:17'),
  ('Machine Learning', '2021-04-29 21:11:39'),
  ('DevOps', '2022-01-22 13:26:54'),
  ('Cloud Computing', '2022-09-17 07:35:12'),
  ('Cybersecurity', '2023-03-07 10:44:28');

  CREATE TABLE posts (
	post_id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL,
	CONSTRAINT fk_user_id 
		FOREIGN KEY (user_id) 
		REFERENCES users(user_id),
	category_id INTEGER NOT NULL,
	CONSTRAINT fk_category_id
		FOREIGN KEY (category_id)
		REFERENCES categories(category_id),
	title VARCHAR(50) NOT NULL
	CHECK (LENGTH(title) < 51
		  AND LENGTH(title) > 0),
	content TEXT NOT NULL
	CHECK (LENGTH(content) > 0),
	view_count INTEGER DEFAULT 0,
	creation_date TIMESTAMP WITH TIME ZONE NOT NULL
	DEFAULT(NOW()),
	is_published BOOLEAN
);

CREATE TABLE comments(
	comment_id SERIAL PRIMARY KEY,
	post_id INTEGER NOT NULL,
	FOREIGN KEY (post_id) REFERENCES posts(post_id),
	user_id INTEGER,
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	comment TEXT NOT NULL
	CHECK (LENGTH(comment) > 0),
	creation_date TIMESTAMP WITH TIME ZONE NOT NULL
	DEFAULT(NOW()),
	is_confirmed BOOLEAN
);

--1
  INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    1, -- Category ID for Java
    'Exception Handling in Java', -- Title of the blog post
    'Exception handling is an essential part of writing robust Java applications. In Java, exceptions are used to handle various types of errors and unexpected situations that may occur during program execution.

    There are three main components of Java exception handling: try, catch, and finally blocks. The try block contains the code that may throw an exception. The catch block is used to catch and handle the exceptions thrown by the try block. Finally, the finally block is executed regardless of whether an exception is thrown or caught.

    Here is an example that demonstrates how to use exception handling in Java:

    ```java
    public class ExceptionHandlingExample {
        public static void main(String[] args) {
            try {
                int result = divide(10, 0);
                System.out.println("Result: " + result);
            } catch (ArithmeticException e) {
                System.out.println("An arithmetic exception occurred: " + e.getMessage());
            } finally {
                System.out.println("Finally block executed.");
            }
        }

        public static int divide(int dividend, int divisor) {
            return dividend / divisor;
        }
    }
    ```

    In this example, the `divide` method attempts to divide two numbers. If the divisor is zero, an `ArithmeticException` is thrown. The catch block catches the exception and displays an error message. Finally, the finally block is executed, regardless of whether an exception is thrown or not.

    Exception handling allows you to gracefully handle errors and prevent your application from crashing. It provides a way to handle exceptional situations and recover from them.

    Overall, exception handling is an important aspect of Java programming. By properly handling exceptions, you can make your code more robust and reliable.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--2
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    15, -- Category ID for DevOps
    'Continuous Integration & Continuous Deployment', -- Title of the blog post
    'DevOps is an approach that combines software development (Dev) and IT operations (Ops) to improve the software delivery process. Continuous Integration and Continuous Deployment (CI/CD) are key practices in DevOps that enable teams to deliver software rapidly and reliably. In this blog post, we will explore advanced concepts and best practices for achieving CI/CD.

    1. Continuous Integration (CI):
    Continuous Integration is the practice of frequently integrating code changes into a shared repository. It involves automating the build and testing of applications whenever new code is committed. CI ensures that all changes are tested and integrated early, preventing the accumulation of integration issues. Key aspects of CI include using version control, automating builds, and running automated tests.

    2. Continuous Deployment (CD):
    Continuous Deployment extends CI by automatically deploying code changes to production or staging environments after successful testing. It enables teams to deliver software quickly and frequently to end-users. CD relies on automation, infrastructure as code, and deployment pipelines to ensure consistent and reliable deployments. It involves automating the entire deployment process, including provisioning infrastructure, configuring environments, and deploying applications.

    3. Deployment Pipelines:
    Deployment pipelines are a series of automated stages through which code changes flow, from development to production. They define the steps and checks involved in the deployment process, including building, testing, and deploying applications. A well-designed deployment pipeline incorporates automated testing, code analysis, and approval gates to ensure quality and security at each stage. It provides visibility into the progress and status of deployments.

    4. Infrastructure as Code (IaC):
    Infrastructure as Code is a practice of managing and provisioning infrastructure resources using code and declarative definitions. IaC tools, such as Terraform or AWS CloudFormation, enable teams to define and version infrastructure resources as code. With IaC, infrastructure changes can be treated as code changes, undergo CI/CD, and be deployed alongside application code changes. This approach ensures consistency, repeatability, and scalability of infrastructure.

    Implementing CI/CD requires a combination of tools, automation, and cultural changes within organizations. It involves adopting practices like version control, automated testing, code reviews, and collaboration. It also requires a focus on monitoring, feedback loops, and continuous improvement to ensure the reliability and quality of software.

    By embracing advanced DevOps practices like CI/CD, teams can deliver software faster, with improved quality, and respond to changing requirements more effectively. Continuous integration and deployment become the foundation for efficient software development and release processes.

    Explore CI/CD tools, frameworks, and best practices to streamline your software delivery pipeline and elevate your DevOps practices to the next level!', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--3
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    2, -- Category ID for Angular
    'Angular Pipes', -- Title of the blog post
    'Angular pipes are a powerful feature that allows you to transform and format data in Angular applications. Pipes can be used to modify the appearance or behavior of data before displaying it in the template.

    There are various built-in pipes available in Angular, such as `DatePipe`, `UpperCasePipe`, `LowerCasePipe`, `CurrencyPipe`, and `DecimalPipe`. Additionally, you can create custom pipes to suit your specific requirements.

    Here is an example that demonstrates how to use Angular pipes:

    ```html
    <!-- Displaying a formatted date -->
    <p>Current date: {{ currentDate | date }}</p>

    <!-- Displaying uppercase and lowercase text -->
    <p>Uppercase: {{ text | uppercase }}</p>
    <p>Lowercase: {{ text | lowercase }}</p>

    <!-- Formatting currency and decimal numbers -->
    <p>Price: {{ price | currency }}</p>
    <p>Rating: {{ rating | number: "1.1-2" }}</p>
    ```

    In this example, the `date` pipe is used to format the `currentDate` variable as a readable date. The `uppercase` and `lowercase` pipes are used to transform the `text` variable into uppercase and lowercase, respectively. The `currency` pipe is used to format the `price` variable as a currency value, and the `number` pipe is used to format the `rating` variable with one integer digit, one decimal digit, and a minimum of two maximum decimal digits.

    Angular pipes provide a convenient way to manipulate and display data in Angular applications. They can significantly simplify your code by handling data transformations directly in the template.

    Remember that pipes are pure functions, which means they don''t modify the original data. Instead, they return a modified version of the data for display purposes.

    Overall, Angular pipes are an essential feature that empowers you to transform and format data seamlessly in your Angular applications.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--4
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    5, -- Category ID for PostgreSQL
    'PostgreSQL Cursors', -- Title of the blog post
    'PostgreSQL cursors are a powerful feature that allows you to efficiently fetch and manipulate result sets in your database queries. Cursors provide a way to iterate over a query result step-by-step, rather than retrieving the entire result set at once.

    Cursors are particularly useful when dealing with large result sets or when you need to process data in a batch-wise manner. They allow you to control the retrieval of rows, fetch them in smaller chunks, and perform operations on each row individually.

    Here is an example that demonstrates how to use PostgreSQL cursors:

    ```sql
    -- Declare a cursor
    DECLARE my_cursor CURSOR FOR
        SELECT column1, column2
        FROM my_table
        WHERE condition;

    -- Open the cursor
    OPEN my_cursor;

    -- Fetch and process rows
    LOOP
        FETCH NEXT FROM my_cursor INTO variable1, variable2;

        EXIT WHEN NOT FOUND;

        -- Perform operations on the fetched row
        -- ...

    END LOOP;

    -- Close the cursor
    CLOSE my_cursor;
    ```

    In this example, we declare a cursor named `my_cursor` that selects specific columns from `my_table` based on a condition. We open the cursor, fetch rows one by one using `FETCH NEXT`, and process each row within the loop. Once all rows have been processed, we close the cursor.

    PostgreSQL cursors offer flexibility and control over result set retrieval, allowing you to optimize memory usage and improve performance when working with large datasets. They enable you to fetch and process data in smaller portions, reducing the memory footprint and avoiding unnecessary resource consumption.

    Remember to close the cursor after you''re done to release associated resources properly.

    Overall, PostgreSQL cursors are a valuable tool for efficiently handling large result sets and performing operations on individual rows in a controlled manner.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--5
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    1, -- Category ID for Java
    'Java Lambdas', -- Title of the blog post
    'Java lambdas are a powerful feature introduced in Java 8 that simplifies functional programming in Java. Lambdas enable you to write more concise and expressive code by treating functions as first-class citizens.

    A lambda expression is an anonymous function that can be used as a method argument or assigned to a variable. It allows you to write inline functions without the need to define a separate class or interface implementation.

    Here is an example that demonstrates how to use Java lambdas:

    ```java
    // Sorting a list using lambdas
    List<String> names = Arrays.asList("John", "Alice", "Bob", "David");

    // Sort names in ascending order
    names.sort((name1, name2) -> name1.compareTo(name2));

    // Iterate over the sorted list
    names.forEach(name -> System.out.println(name));
    ```

    In this example, we have a list of names that we want to sort in ascending order. Instead of creating a separate `Comparator` implementation, we use a lambda expression as the argument to the `sort` method. The lambda expression `(name1, name2) -> name1.compareTo(name2)` defines the comparison logic. We then iterate over the sorted list using the `forEach` method and a lambda expression to print each name.

    Java lambdas provide a concise syntax for writing functional-style code in Java. They simplify the usage of functional interfaces and enable more expressive and readable code. Lambdas are especially useful when working with collections, streams, and functional programming concepts like map, filter, and reduce.

    Remember that lambdas are based on functional interfaces, which are single-method interfaces. Lambdas can be used wherever a functional interface is expected.

    Overall, Java lambdas are a valuable addition to the Java programming language, making functional programming more accessible and enhancing the expressiveness of your code.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--6
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    1, -- Category ID for Java
    'Java CompletableFuture', -- Title of the blog post
    'Java CompletableFuture is an advanced feature introduced in Java 8 that simplifies asynchronous and concurrent programming in Java. It provides a powerful way to perform non-blocking and parallel computations, enabling you to write highly efficient and responsive applications.

    CompletableFuture represents a result of an asynchronous computation and supports composing, combining, and chaining multiple asynchronous operations. It allows you to express complex asynchronous workflows in a clear and concise manner.

    Here is an example that demonstrates how to use Java CompletableFuture:

    ```java
    // Performing an asynchronous task with CompletableFuture
    CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> {
        // Simulating a time-consuming task
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return "Hello, CompletableFuture!";
    });

    // Executing a callback when the task completes
    future.thenAccept(result -> System.out.println("Result: " + result));

    // Continue executing other tasks while waiting for the CompletableFuture to complete
    System.out.println("Do something else...");

    // Wait for the CompletableFuture to complete
    future.join();
    ```

    In this example, we use `CompletableFuture.supplyAsync` to asynchronously execute a time-consuming task that returns a string. We then attach a callback using `thenAccept` to print the result when the task completes. While waiting for the CompletableFuture to complete, we can continue executing other tasks concurrently. Finally, we use `join` to wait for the CompletableFuture to finish before exiting the program.

    Java CompletableFuture provides a wide range of methods to handle exceptions, apply transformations, compose multiple CompletableFutures, and perform various other operations on asynchronous tasks. It offers exceptional flexibility and control over concurrent and asynchronous programming in Java.

    Remember to handle exceptions appropriately when working with CompletableFuture and to choose an appropriate executor for parallel execution if needed.

    Overall, Java CompletableFuture is a powerful tool for writing efficient and responsive applications that leverage asynchronous and concurrent programming paradigms.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--7
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    3, -- Category ID for Spring
    'Spring JpaRepository', -- Title of the blog post
    'Spring JpaRepository is a powerful feature provided by Spring Data JPA that simplifies database operations in Spring Boot applications. It offers a high-level abstraction over the underlying data access layer, allowing you to perform CRUD (Create, Read, Update, Delete) operations on entities with minimal boilerplate code.

    JpaRepository provides a set of pre-defined methods for common database operations, such as saving, updating, deleting, and querying entities. It also supports the creation of custom queries using method name conventions or the `@Query` annotation.

    Here is an example that demonstrates how to use Spring JpaRepository:

    ```java
    public interface UserRepository extends JpaRepository<User, Long> {
        List<User> findByFirstName(String firstName);
    }
    ```

    In this example, we define a `UserRepository` interface that extends `JpaRepository` and specifies the entity type (`User`) and the ID type (`Long`). With this interface, we automatically inherit methods like `save`, `findById`, `delete`, and more for CRUD operations. We can also define custom query methods like `findByFirstName` to retrieve users based on their first name.

    Spring JpaRepository handles common database operations transparently, providing a simplified and consistent API for data access. It integrates seamlessly with Spring Boot, automatically generating the necessary database queries based on method names or custom query annotations.

    Remember to configure the database connection and entity mappings appropriately in your Spring Boot application, as well as define the appropriate dependencies in your project''s Maven or Gradle configuration.

    Overall, Spring JpaRepository is a valuable component in Spring Boot applications, significantly reducing the effort required for database operations and allowing you to focus more on application logic and business requirements.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--8
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    6, -- Category ID for TypeScript
    'TypeScript Decorators', -- Title of the blog post
    'TypeScript decorators are an advanced feature that allows you to add metadata and functionality to your classes, methods, properties, and other declarations. Decorators provide a way to modify the behavior of existing code without directly modifying the code itself.

    Decorators are functions that can be applied to classes, methods, or properties using the `@` symbol. They can be used for a variety of purposes, such as adding logging, validation, authorization, or other cross-cutting concerns to your code.

    Here is an example that demonstrates how to use TypeScript decorators:

    ```typescript
    // Logging decorator
    function log(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
        const originalMethod = descriptor.value;

        descriptor.value = function (...args: any[]) {
            console.log(`Calling ${propertyKey} with arguments: ${args}`);

            // Call the original method
            const result = originalMethod.apply(this, args);

            console.log(`Method ${propertyKey} returned: ${result}`);

            return result;
        };

        return descriptor;
    }

    // Decorated class
    class Example {
        @log
        greet(name: string) {
            return `Hello, ${name}!`;
        }
    }

    // Create an instance and call the decorated method
    const example = new Example();
    example.greet("John");
    ```

    In this example, we define a `log` decorator that adds logging functionality to a method. The decorator intercepts the method call, logs the arguments, calls the original method, logs the result, and returns the result. We then apply the `log` decorator to the `greet` method of the `Example` class.

    TypeScript decorators enable you to separate cross-cutting concerns from the core logic of your code. They allow you to enhance existing code with additional functionality without modifying it directly. Decorators can be used for a wide range of use cases, such as logging, caching, profiling, and more.

    Remember to enable the `experimentalDecorators` flag in your TypeScript configuration file (tsconfig.json) to use decorators.

    Overall, TypeScript decorators provide a powerful way to extend and modify the behavior of your code, adding metadata and cross-cutting functionality. They contribute to building modular, maintainable, and reusable TypeScript applications.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--9
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    2, -- Category ID for Angular
    'Angular Routing', -- Title of the blog post
    'Angular Routing is a powerful feature that allows you to create dynamic and responsive single-page applications. It enables you to navigate between different views or components without reloading the entire page, providing a smooth and seamless user experience.

    With Angular Routing, you can define routes for different URLs and associate them with corresponding components. Each route represents a distinct view or page within your application. You can navigate between routes using links or programmatically using the Angular Router service.

    Here is an example that demonstrates how to use Angular Routing:

    ```typescript
    // app-routing.module.ts
    import { NgModule } from ''@angular/core'';
    import { Routes, RouterModule } from ''@angular/router'';
    import { HomeComponent } from ''./home.component'';
    import { AboutComponent } from ''./about.component'';

    const routes: Routes = [
        { path: '''', component: HomeComponent },
        { path: ''about'', component: AboutComponent },
    ];

    @NgModule({
        imports: [RouterModule.forRoot(routes)],
        exports: [RouterModule]
    })
    export class AppRoutingModule { }

    // app.component.html
    <nav>
        <a routerLink="/">Home</a>
        <a routerLink="/about">About</a>
    </nav>
    <router-outlet></router-outlet>
    ```

    In this example, we define two routes in the `Routes` array: the empty path corresponds to the `HomeComponent`, and the "/about" path corresponds to the `AboutComponent`. We import `RouterModule` and `Routes` from `@angular/router` and configure the routes in the `AppRoutingModule`. We also use the `routerLink` directive to create links for navigation in the `app.component.html` template, and the `router-outlet` directive to render the corresponding component for the active route.

    Angular Routing provides additional features like route parameters, query parameters, child routes, route guards, and lazy loading. It allows you to build complex navigation flows and handle different scenarios in your application.

    Remember to configure the base href in your index.html file and import the `AppRoutingModule` in your app module.

    Overall, Angular Routing is a fundamental aspect of building modern web applications with Angular. It enables the creation of dynamic and responsive single-page applications, providing seamless navigation and a better user experience.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--10
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    8, -- Category ID for Docker
    'Docker: Introduction to Containerization', -- Title of the blog post
    'Docker is an open-source platform that enables you to automate the deployment and management of applications within lightweight, isolated containers. Containers provide a consistent and reproducible environment for running software, making it easier to develop, deploy, and scale applications.

    Here are the key concepts and steps to get started with Docker:

    1. Install Docker: Start by installing Docker on your system. Docker provides installation packages for various operating systems, including Windows, macOS, and Linux.

    2. Build a Docker Image: A Docker image is a lightweight, standalone executable package that includes everything needed to run a piece of software. You can create a Docker image by writing a Dockerfile, which contains instructions for building the image. The Dockerfile specifies the base image, dependencies, and commands to run. Use the `docker build` command to build the image.

    3. Run a Docker Container: Once you have a Docker image, you can create and run a container based on that image. A container is an instance of an image that is running as a separate process on the host system. Use the `docker run` command to start a container from an image. You can specify various options, such as port mappings, environment variables, and volume mounts.

    4. Manage Docker Containers: Docker provides commands to manage containers. You can use the `docker ps` command to list running containers, `docker start` and `docker stop` commands to start and stop containers, and `docker rm` command to remove containers.

    5. Dockerize an Application: Dockerizing an application involves packaging the application and its dependencies into a Docker image. This enables you to create a portable and self-contained environment for running the application. Follow best practices for Dockerizing applications, such as using lightweight base images, minimizing layers, and properly configuring the application inside the container.

    Docker provides many additional features and concepts, such as Docker volumes, networks, and orchestration tools like Docker Compose and Kubernetes. These enable you to manage storage, networking, and deployment of multi-container applications.

    Getting started with Docker opens up a world of possibilities for developing and deploying applications. It simplifies the process of creating consistent environments and improves the scalability and portability of your applications.

    Refer to the official Docker documentation and online resources for more in-depth tutorials and examples.

    Start your containerization journey with Docker and unlock the benefits of modern application development and deployment!', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--11
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    14, -- Category ID for Cloud Computing
    'AWS EC2, RDS, and Route 53', -- Title of the blog post
    'AWS (Amazon Web Services) offers a wide range of services that enable businesses to build and operate scalable and resilient cloud infrastructure. In this blog post, we will explore three essential services: EC2, RDS, and Route 53.

    1. Amazon EC2 (Elastic Compute Cloud):
    Amazon EC2 is a web service that provides resizable compute capacity in the cloud. It allows you to provision virtual servers, known as EC2 instances, with various operating systems and configurations. EC2 offers flexibility, scalability, and control over your compute resources. You can easily scale up or down based on your application needs and pay only for the resources you use.

    2. Amazon RDS (Relational Database Service):
    Amazon RDS is a managed database service that simplifies the setup, operation, and scaling of relational databases in the cloud. It supports popular database engines like MySQL, PostgreSQL, Oracle, and SQL Server. RDS automates administrative tasks such as backups, software patching, and database scaling. It provides high availability, durability, and performance for your database workloads.

    3. Amazon Route 53:
    Amazon Route 53 is a scalable and highly available domain name system (DNS) web service. It provides reliable and cost-effective domain registration, DNS routing, and health checking for your applications. Route 53 allows you to manage the DNS records for your domain names and route traffic to resources like EC2 instances, load balancers, or S3 buckets. It offers advanced features like latency-based routing, DNS failover, and geo-targeting.

    Together, EC2, RDS, and Route 53 form a robust foundation for building scalable and reliable cloud infrastructure. You can leverage EC2 to deploy and manage virtual servers, RDS to handle your relational database workloads, and Route 53 to manage DNS and route traffic to your applications.

    AWS provides comprehensive documentation, tutorials, and best practices for these services. It''s essential to understand the capabilities and configurations of each service to design and deploy a well-architected cloud infrastructure.

    By utilizing EC2, RDS, and Route 53 effectively, businesses can achieve cost optimization, scalability, and high availability for their cloud-based applications and services.

    Start exploring AWS services and leverage the power of cloud computing to transform your infrastructure and accelerate your business!', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--12
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    2, -- Category ID for Angular
    'Reactive Forms with FormArrays and Dynamic Form', -- Title of the blog post
    'Reactive forms in Angular provide a powerful way to handle form inputs and validations. While basic reactive forms are straightforward, mastering advanced features like FormArrays and dynamic form controls can be challenging. In this blog post, we will dive into the world of advanced reactive forms in Angular.

    1. FormArrays:
    FormArrays allow you to manage an array of form controls dynamically. You can add or remove form controls dynamically, handle form validation across multiple controls, and track changes in the array. Learn how to use FormArrays to create dynamic form elements like repeating sections, lists, or complex form structures.

    2. Dynamic Form Controls:
    Dynamic form controls enable you to generate form controls dynamically based on data or user interactions. You can dynamically add or remove form controls, change form control properties, and handle validations. This advanced technique is useful when building dynamic forms where the structure or number of form controls varies based on user input or external data.

    3. Form Group Nesting:
    Nesting form groups allows you to create complex forms with hierarchical structures. Learn how to nest form groups within form groups and manage interdependent form controls. This technique is especially helpful when building forms with nested components or when dealing with complex data models.

    4. Custom Validators:
    Create custom validators to enforce complex validation rules beyond the built-in validators. Learn how to implement custom validation functions and integrate them into your reactive forms. Custom validators are useful when you need to validate input based on specific business rules or when the built-in validators are not sufficient.

    Mastering advanced reactive forms in Angular requires a solid understanding of reactive forms fundamentals. Once you are comfortable with basic form controls and validations, exploring FormArrays, dynamic form controls, form group nesting, and custom validators will empower you to build complex and dynamic forms in Angular.

    Experiment with different scenarios, explore official Angular documentation, and study real-world examples to deepen your knowledge. The more you practice and experiment, the better you will become at leveraging advanced reactive forms in your Angular applications.

    Unlock the full potential of reactive forms with FormArrays, dynamic form controls, and advanced techniques, and elevate your Angular development skills to the next level!', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--13
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    6, -- Category ID for TypeScript
    'Understanding Generics & Advanced Type Annotations', -- Title of the blog post
    'TypeScript provides powerful features to enhance the static typing capabilities of JavaScript. Generics and advanced type annotations are key features that enable developers to write more reusable and type-safe code. In this blog post, we will explore Generics and advanced type annotations in TypeScript.

    1. Generics:
    Generics allow you to create reusable code components that work with different types. They provide a way to define functions, classes, and interfaces that can operate on a range of types, making your code more flexible and maintainable. Learn how to use type parameters, constraint types, and type inference to leverage the full potential of Generics.

    2. Advanced Type Annotations:
    TypeScript supports advanced type annotations that go beyond basic types like string or number. Advanced type annotations include union types, intersection types, conditional types, mapped types, and more. Discover how to use these advanced annotations to express complex relationships between types, create type guards, perform type narrowing, and handle conditional logic based on types.

    3. Type Inference:
    TypeScript''s type inference mechanism automatically deduces the types of variables based on their initialization values and usage. Understanding how type inference works and leveraging it effectively can significantly reduce the need for explicit type annotations and make your code more concise and readable. Learn how to take advantage of TypeScript''s intelligent type inference system.

    4. Type Safety and Error Prevention:
    TypeScript''s static type checking helps catch potential errors at compile-time, providing early feedback and preventing runtime errors. Discover how Generics and advanced type annotations contribute to type safety and error prevention in TypeScript. Leverage the type system to catch common mistakes, improve code quality, and enhance maintainability.

    By mastering Generics and advanced type annotations in TypeScript, you can write more expressive, reusable, and type-safe code. These features enable you to build robust and maintainable applications, catching errors at compile-time and providing a better development experience.

    Dive into TypeScript''s documentation, explore real-world examples, and practice applying Generics and advanced type annotations to different scenarios. The more you experiment and gain hands-on experience, the more proficient you will become in leveraging these powerful features of TypeScript.

    Elevate your TypeScript skills by understanding and effectively utilizing Generics and advanced type annotations!', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--14
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    11, -- Category ID for Python
    'Python''s Advantages over Others', -- Title of the blog post
    'Python is a versatile and widely-used programming language that offers numerous advantages over other languages. Whether you are a beginner or an experienced developer, understanding the unique strengths of Python can greatly benefit your coding journey. In this blog post, we will explore some of the key advantages of Python over other programming languages.

    1. Readability and Simplicity:
    Python''s syntax is designed to be highly readable and intuitive, making it easier to write and understand code. Its clean and consistent syntax, along with significant indentation, promotes code readability. Python''s simplicity allows developers to express ideas in fewer lines of code, resulting in improved productivity and reduced development time.

    2. Versatility and Flexibility:
    Python''s versatility is one of its major strengths. It supports various programming paradigms, including procedural, object-oriented, and functional programming styles. Python''s extensive standard library and third-party packages provide a vast ecosystem for diverse application development, ranging from web development and scientific computing to data analysis and machine learning.

    3. Extensive Community and Support:
    Python has a thriving and active community of developers, which translates to abundant resources, documentation, and libraries. The community''s support and collaboration foster continuous learning and improvement. Python''s popularity ensures a wealth of online tutorials, forums, and open-source projects, making it easy to find solutions and gain insights from experienced developers.

    4. Integration and Interoperability:
    Python''s ability to seamlessly integrate with other languages and platforms makes it a valuable tool in many development scenarios. It can be easily embedded in existing applications or used as a scripting language for automation tasks. Python''s interoperability allows developers to leverage the strengths of other languages and frameworks while enjoying the simplicity and readability of Python.

    5. Rapid Prototyping and Development:
    Python''s dynamic typing and interpreted nature enable rapid prototyping and iterative development. Its fast feedback loop facilitates quick experimentation and testing of ideas. Python''s extensive libraries and frameworks, such as Django and Flask, provide robust foundations for building scalable web applications with minimal effort.

    Python''s advantages extend beyond these points, with strong community-driven development, cross-platform compatibility, and excellent support for scientific computing and data analysis. Understanding and harnessing Python''s strengths can unlock new possibilities and enhance your development experience.

    Embrace Python''s simplicity, versatility, and extensive community to accelerate your coding journey and enjoy the countless advantages it offers over other programming languages!

    Explore Python''s official documentation, engage in the community, and work on real-world projects to experience the true power of Python.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--15
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    12, -- Category ID for Machine Learning
    'CNN for Image Classification', -- Title of the blog post
    'Convolutional Neural Networks (CNNs) are powerful deep learning models widely used for image classification tasks. In this blog post, we will dive into the world of CNNs and explore how to build and train a CNN for image classification in Python.

    1. Dataset Preparation:
    First, we need to prepare our dataset. Download a labeled image dataset for the task at hand, such as the CIFAR-10 or MNIST dataset. Preprocess the data by normalizing pixel values and splitting it into training and testing sets.

    2. Model Architecture:
    Define the architecture of the CNN using popular deep learning frameworks like TensorFlow or Keras. A typical CNN consists of convolutional layers, pooling layers, and fully connected layers. Experiment with different layer configurations, activation functions, and regularization techniques to achieve optimal performance.

    3. Model Compilation and Training:
    Compile the model by specifying the loss function, optimizer, and evaluation metrics. Train the model using the training dataset and adjust hyperparameters like learning rate and batch size. Monitor the training process and analyze metrics such as accuracy and loss to assess model performance.

    4. Model Evaluation and Testing:
    Evaluate the trained model using the testing dataset to assess its generalization capabilities. Calculate metrics like accuracy, precision, and recall to measure the model''s performance on unseen data. Visualize the results and analyze misclassified samples for further improvement.

    Here''s a code snippet demonstrating the creation of a simple CNN model using Keras:

    ```python
    from keras.models import Sequential
    from keras.layers import Conv2D, MaxPooling2D, Flatten, Dense

    # Create a sequential model
    model = Sequential()

    # Add convolutional layers
    model.add(Conv2D(32, (3, 3), activation=''relu'', input_shape=(32, 32, 3)))
    model.add(MaxPooling2D(pool_size=(2, 2)))

    # Flatten the feature maps
    model.add(Flatten())

    # Add fully connected layers
    model.add(Dense(128, activation=''relu''))
    model.add(Dense(num_classes, activation=''softmax''))

    # Compile the model
    model.compile(loss=''categorical_crossentropy'', optimizer=''adam'', metrics=[''accuracy''])
    ```

    This code snippet demonstrates the creation of a CNN model with a single convolutional layer, max pooling, and fully connected layers. Adjust the architecture based on your specific task and dataset.

    Building and training CNNs for image classification is a fundamental skill in the field of machine learning. Experiment with different architectures, datasets, and hyperparameters to improve your models and achieve higher accuracy.

    Dive into deep learning libraries, explore research papers, and participate in online competitions to further enhance your understanding of CNNs and machine learning.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--16
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    4, -- Category ID for Git
    'Rebase Strategies for a Clean Commit History', -- Title of the blog post
    'Git is a powerful version control system that offers advanced features to maintain a clean and organized commit history. One such feature is Git rebase, which allows you to modify and rearrange commits to create a more coherent and logical history. In this blog post, we will explore advanced Git rebase strategies to achieve a clean commit history.

    1. Interactive Rebase:
    Interactive rebase is a versatile feature that enables you to interactively modify commits during the rebase process. Use the following command to initiate an interactive rebase:

    ```bash
    git rebase -i <commit>
    ```

    The `-i` flag stands for interactive, and `<commit>` represents the commit from which you want to start the rebase. This command opens an interactive editor where you can pick, squash, edit, or reorder commits. This allows you to combine small and related commits, split larger commits into smaller ones, or even rewrite commit messages.

    2. Rebase with Autosquash:
    Autosquash is a convenient feature that automates the process of squashing or fixingup commits during a rebase. To use autosquash, enable it in your Git configuration by running:

    ```bash
    git config --global rebase.autosquash true
    ```

    Once autosquash is enabled, you can simply run `git rebase -i` as usual. Git will automatically apply the appropriate fixup or squash commands based on commit messages prefixed with `fixup!` or `squash!`. This eliminates the need to manually edit the interactive rebase file, saving time and effort.

    3. Rebase onto a Different Branch:
    By default, Git rebase applies commits onto the upstream branch. However, you can rebase your commits onto a different branch using the following command:

    ```bash
    git rebase --onto <new_base> <old_base>
    ```

    `<new_base>` represents the branch you want to rebase onto, and `<old_base>` represents the commit from which you want to start the rebase. This is useful when you need to transplant a branch''s commits onto a different base branch, effectively changing the branch''s parent.

    These advanced Git rebase strategies allow you to shape and polish your commit history, resulting in a more readable and coherent timeline of changes. However, be cautious when modifying shared branches, as rebasing can alter commit hashes and cause conflicts for collaborators.

    Explore the Git documentation, experiment with different rebase strategies, and practice on personal or feature branches to gain confidence and proficiency in maintaining a clean commit history using Git rebase.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--16
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    9, -- Category ID for Kubernetes
    'Getting Started with Deployments and Services', -- Title of the blog post
    'Kubernetes is a powerful container orchestration platform that simplifies the deployment and management of containerized applications. In this blog post, we will explore the basics of Kubernetes deployments and services, two fundamental concepts for running applications in Kubernetes.

    1. Deployments:
    Deployments are a declarative way to define and manage application deployments in Kubernetes. They provide a higher-level abstraction for managing replica sets and pods. Here is an example of a basic deployment YAML file:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: my-app
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: my-app
      template:
        metadata:
          labels:
            app: my-app
        spec:
          containers:
          - name: my-app-container
            image: my-app-image:latest
            ports:
            - containerPort: 8080
    ```

    In this example, we define a deployment named "my-app" with three replicas. The deployment ensures that the specified number of pods (replicas) are always running, allowing for scalability and resilience. Adjust the container image and ports based on your application''s requirements.

    2. Services:
    Services enable networking and load balancing within a Kubernetes cluster. They provide a stable endpoint for accessing a group of pods. Here is an example of a basic service YAML file:

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: my-app-service
    spec:
      selector:
        app: my-app
      ports:
      - protocol: TCP
        port: 80
        targetPort: 8080
    ```

    In this example, we define a service named "my-app-service" that selects pods with the label "app: my-app". The service exposes port 80, which is internally mapped to the container port 8080. This allows other services or external users to access the pods through the service''s stable endpoint.

    Deployments and services are essential building blocks in Kubernetes for managing and networking containerized applications. By utilizing these concepts, you can achieve scalability, fault tolerance, and efficient service discovery within your Kubernetes cluster.

    Dive into Kubernetes documentation, explore advanced deployment and service configurations, and start deploying your applications with confidence in the Kubernetes ecosystem.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--17
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    1, -- Category ID for Java
    'Java Streams', -- Title of the blog post
    'Java Streams provide a powerful and expressive way to process and transform data in Java. They offer functional-style operations that enable you to perform operations such as filtering, mapping, and reducing on collections of data. In this blog post, we will explore Java Streams and their usage with practical examples.

    1. Filtering with Streams:
    Filtering is a common operation when working with data. Streams provide a filter() method that takes a Predicate as an argument and returns a new Stream containing only the elements that match the specified condition. Here is an example of filtering strings that start with the letter "A":

    ```java
    List<String> strings = Arrays.asList("Apple", "Banana", "Avocado", "Cherry");
    List<String> filteredStrings = strings.stream()
                                          .filter(s -> s.startsWith("A"))
                                          .collect(Collectors.toList());
    ```

    In this example, the stream is filtered to include only the strings that start with "A". The filtered strings are collected into a new list.

    2. Mapping with Streams:
    Mapping allows you to transform elements in a stream into another form. Streams provide a map() method that takes a Function as an argument and returns a new Stream containing the results of applying the specified function to each element. Here is an example of mapping a list of integers to their square values:

    ```java
    List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);
    List<Integer> squaredNumbers = numbers.stream()
                                          .map(n -> n * n)
                                          .collect(Collectors.toList());
    ```

    In this example, each number in the stream is squared using the map() operation. The squared numbers are collected into a new list.

    3. Reducing with Streams:
    Reducing is the process of combining elements in a stream into a single value. Streams provide a reduce() method that takes a BinaryOperator as an argument and returns an Optional representing the reduced value. Here is an example of reducing a list of integers to their sum:

    ```java
    List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);
    Optional<Integer> sum = numbers.stream()
                                    .reduce((a, b) -> a + b);
    ```

    In this example, the reduce() operation adds all the numbers in the stream together, resulting in the sum of the numbers.

    Java Streams provide a concise and efficient way to process and transform data. By leveraging the power of functional-style operations, you can write cleaner and more expressive code for data manipulation in Java.

    Dive into the Java documentation, explore additional Stream operations, and apply Streams to real-world data processing scenarios to unlock the full potential of Java Streams.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--18
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    2, -- Category ID for Angular
    'Angular Reactive Forms', -- Title of the blog post
    'Angular provides powerful features for building forms, and one of the most powerful options is Reactive Forms. Reactive Forms offer a reactive and flexible approach to form handling with features like dynamic form controls and validation. In this blog post, we will explore how to use Reactive Forms in Angular with practical examples.

    1. Creating a Reactive Form:
    To create a Reactive Form, you need to import the necessary Angular modules and use the FormBuilder service. Here is an example of creating a simple login form with email and password fields:

    ```typescript
    import { Component } from ''@angular/core'';
    import { FormBuilder, FormGroup, Validators } from ''@angular/forms'';

    @Component({
      selector: ''app-login'',
      template: `
        <form [formGroup]="loginForm" (submit)="onSubmit()">
          <input formControlName="email" placeholder="Email" />
          <input formControlName="password" placeholder="Password" type="password" />
          <button type="submit">Login</button>
        </form>
      `
    })
    export class LoginComponent {
      loginForm: FormGroup;

      constructor(private formBuilder: FormBuilder) {
        this.loginForm = this.formBuilder.group({
          email: ['', [Validators.required, Validators.email]],
          password: ['', Validators.required]
        });
      }

      onSubmit() {
        // Handle form submission
      }
    }
    ```

    In this example, the login form is created using the FormBuilder service. The form controls are defined with initial values and validation rules using the formBuilder.group() method.

    2. Dynamic Form Controls:
    Reactive Forms allow you to dynamically add or remove form controls based on user actions. Here is an example of adding a "Remember Me" checkbox dynamically to the login form:

    ```typescript
    import { Component } from ''@angular/core'';
    import { FormBuilder, FormGroup, Validators } from ''@angular/forms'';

    @Component({
      selector: ''app-login'',
      template: `
        <form [formGroup]="loginForm" (submit)="onSubmit()">
          <!-- Existing form controls -->
          <div *ngIf="showRememberMe">
            <input formControlName="rememberMe" type="checkbox" />
            <label for="rememberMe">Remember Me</label>
          </div>
          <button type="submit">Login</button>
        </form>
      `
    })
    export class LoginComponent {
      loginForm: FormGroup;
      showRememberMe: boolean = false;

      constructor(private formBuilder: FormBuilder) {
        this.loginForm = this.formBuilder.group({
          email: ['', [Validators.required, Validators.email]],
          password: ['', Validators.required],
          rememberMe: false
        });
      }

      toggleRememberMe() {
        this.showRememberMe = !this.showRememberMe;
        if (this.showRememberMe) {
          this.loginForm.addControl(''rememberMe'', this.formBuilder.control(false));
        } else {
          this.loginForm.removeControl(''rememberMe'');
        }
      }

      onSubmit() {
        // Handle form submission
      }
    }
    ```

    In this example, the "Remember Me" checkbox is added or removed dynamically based on the value of the `showRememberMe` property. The `toggleRememberMe()` method is used to add or remove the control from the form.

    3. Form Validation:
    Reactive Forms provide built-in validation capabilities for validating user input. Angular offers various validators, such as required, minLength, maxLength, and custom validators. Here is an example of adding validation to the email field:

    ```typescript
    import { Component } from ''@angular/core'';
    import { FormBuilder, FormGroup, Validators } from ''@angular/forms'';

    @Component({
      selector: ''app-login'',
      template: `
        <form [formGroup]="loginForm" (submit)="onSubmit()">
          <input formControlName="email" placeholder="Email" />
          <div *ngIf="loginForm.get(''email'').hasError(''required'')">
            Email is required.
          </div>
          <div *ngIf="loginForm.get(''email'').hasError(''email'')">
            Invalid email format.
          </div>
          <!-- Other form controls and validation messages -->
          <button type="submit">Login</button>
        </form>
      `
    })
    export class LoginComponent {
      loginForm: FormGroup;

      constructor(private formBuilder: FormBuilder) {
        this.loginForm = this.formBuilder.group({
          email: ['', [Validators.required, Validators.email]],
          password: ['', Validators.required]
        });
      }

      onSubmit() {
        // Handle form submission
      }
    }
    ```

    In this example, the `Validators.required` and `Validators.email` validators are applied to the email field. The validation messages are displayed conditionally based on the presence of errors.

    By leveraging Reactive Forms in Angular, you can build dynamic and validated forms that provide a great user experience. Explore more features of Reactive Forms, such as form arrays and custom validation, to enhance your form-building capabilities in Angular.

    Dive into the Angular documentation, experiment with different form scenarios, and build robust forms in your Angular applications using Reactive Forms.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--19
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    3, -- Category ID for Spring
    'Building RESTful APIs with Spring Boot', -- Title of the blog post
    'Spring Boot and Spring Data JPA provide a powerful combination for building RESTful APIs in Java. With Spring Boot, you can quickly create a production-ready API with minimal configuration. Spring Data JPA simplifies database operations by providing an easy-to-use interface for working with databases. In this blog post, we will explore how to build RESTful APIs using Spring Boot and Spring Data JPA.

    1. Setting Up a Spring Boot Project:
    To get started, you need to set up a Spring Boot project. You can use Spring Initializr (https://start.spring.io/) or your preferred IDE to create a new Spring Boot project. Once you have the project set up, you can add the necessary dependencies, such as spring-boot-starter-web and spring-boot-starter-data-jpa, to build RESTful APIs and work with databases.

    2. Creating a REST Controller:
    In Spring Boot, you can create a REST controller to define API endpoints and handle HTTP requests. Here is an example of a simple REST controller for managing books:

    ```java
    @RestController
    @RequestMapping("/api/books")
    public class BookController {
      
      @Autowired
      private BookRepository bookRepository;

      @GetMapping
      public List<Book> getAllBooks() {
        return bookRepository.findAll();
      }

      @PostMapping
      public Book createBook(@RequestBody Book book) {
        return bookRepository.save(book);
      }

      // Other CRUD operations and request mappings
      
    }
    ```

    In this example, the `BookController` class is annotated with `@RestController` to indicate that it''s a REST controller. The `@RequestMapping` annotation specifies the base path for the API endpoints. The `BookRepository` interface is autowired to handle database operations. The `getAllBooks()` method returns all books, and the `createBook()` method creates a new book by saving it to the database.

    3. Working with Spring Data JPA:
    Spring Data JPA simplifies database operations by providing an abstraction layer on top of JPA (Java Persistence API). You can define repository interfaces that extend the `JpaRepository` interface to perform CRUD operations. Here is an example of a repository interface for the `Book` entity:

    ```java
    public interface BookRepository extends JpaRepository<Book, Long> {
      // Custom query methods
    }
    ```

    In this example, the `BookRepository` interface extends `JpaRepository<Book, Long>`, where `Book` is the entity class and `Long` is the type of the primary key. Spring Data JPA automatically generates the necessary queries based on method names, and you can also define custom query methods.

    Spring Boot and Spring Data JPA provide a powerful foundation for building RESTful APIs with database integration. By leveraging these frameworks, you can quickly develop scalable and robust APIs in Java.

    Explore the Spring Boot and Spring Data JPA documentation, experiment with different endpoints and database operations, and build your own RESTful APIs using the power of Spring.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--20
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    4, -- Category ID for Git
    'Managing Branches and Merging in Git', -- Title of the blog post
    'Git provides powerful features for managing branches and merging changes. Branching allows you to work on different features or bug fixes in isolation, while merging combines the changes from different branches. In this blog post, we will explore how to effectively manage branches and perform merges in Git.

    1. Creating a New Branch:
    To create a new branch, you can use the `git branch` command followed by the branch name. For example, to create a branch called `feature/new-feature`, you can run the following command:

    ```
    git branch feature/new-feature
    ```

    This creates a new branch based on the current branch you''re on.

    2. Switching to a Branch:
    You can switch to a different branch using the `git checkout` command followed by the branch name. For example, to switch to the `feature/new-feature` branch, you can run the following command:

    ```
    git checkout feature/new-feature
    ```

    This allows you to start working on the new feature branch.

    3. Merging Branches:
    To merge changes from one branch into another, you can use the `git merge` command. For example, let''s say you want to merge the `feature/new-feature` branch into the `main` branch. First, switch to the `main` branch using `git checkout main`, and then run the merge command as follows:

    ```
    git merge feature/new-feature
    ```

    Git will attempt to merge the changes from the `feature/new-feature` branch into the `main` branch. If there are any conflicts, Git will prompt you to resolve them.

    4. Resolving Merge Conflicts:
    Merge conflicts occur when Git is unable to automatically merge changes from different branches. When conflicts arise, Git marks the conflicting areas in the affected files. You can manually resolve the conflicts by editing the files to choose the desired changes. Once the conflicts are resolved, you can continue the merge process using `git add` to stage the resolved files and `git commit` to complete the merge.

    5. Deleting Branches:
    After merging a branch, you may want to delete it. You can use the `git branch -d` command followed by the branch name to delete a branch. For example, to delete the `feature/new-feature` branch after merging, run the following command:

    ```
    git branch -d feature/new-feature
    ```

    This removes the branch from your local repository.

    Managing branches and performing merges efficiently is crucial for collaborative development and version control in Git. By mastering these concepts, you can effectively organize your codebase and streamline the process of integrating changes.

    Explore Git documentation, practice branching and merging scenarios, and leverage the power of Git for efficient collaboration and code management.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--21
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    5, -- Category ID for PostgreSQL
    'Performing Advanced Query Operations in PostgreSQL', -- Title of the blog post
    'PostgreSQL is a powerful relational database management system that offers advanced query capabilities for handling complex data operations. In this blog post, we will explore some advanced query operations in PostgreSQL, along with examples.

    1. Subqueries:
    Subqueries in PostgreSQL allow you to nest one query within another. They can be used in various scenarios, such as filtering data based on a subquery result or performing calculations using subquery results. Here is an example of using a subquery to find employees with the highest salary:

    ```sql
    SELECT employee_name, salary
    FROM employees
    WHERE salary = (
        SELECT MAX(salary)
        FROM employees
    );
    ```

    This query retrieves the employee name and salary from the `employees` table where the salary is equal to the maximum salary obtained from the subquery.

    2. Window Functions:
    Window functions in PostgreSQL provide a way to perform calculations across a set of rows that are related to the current row. They can be used to calculate running totals, rank rows based on certain criteria, and more. Here is an example of using a window function to calculate the total sales amount per product category:

    ```sql
    SELECT product_category, product_name, sales_amount,
        SUM(sales_amount) OVER (PARTITION BY product_category) AS total_sales
    FROM sales;
    ```

    This query calculates the total sales amount per product category by using the `SUM` window function along with the `PARTITION BY` clause.

    3. Common Table Expressions (CTEs):
    CTEs in PostgreSQL allow you to define temporary result sets that can be referenced multiple times within a query. They help improve query readability and simplify complex queries. Here is an example of using a CTE to find the average salary per department:

    ```sql
    WITH avg_salary AS (
        SELECT department_id, AVG(salary) AS average_salary
        FROM employees
        GROUP BY department_id
    )
    SELECT department_id, average_salary
    FROM avg_salary;
    ```

    This query defines a CTE named `avg_salary` that calculates the average salary per department in the `employees` table. The result of the CTE is then used in the subsequent `SELECT` statement to retrieve the department ID and average salary.

    These are just a few examples of the advanced query operations that PostgreSQL offers. By leveraging subqueries, window functions, and common table expressions, you can perform complex data manipulations and analysis in PostgreSQL.

    Explore the PostgreSQL documentation, practice writing advanced queries, and unlock the full potential of PostgreSQL for your data operations.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--22
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    7, -- Category ID for React
    'Handling Forms in React with Controlled Components', -- Title of the blog post
    'Forms are an essential part of web applications, and React provides a powerful way to handle form inputs using controlled components. In this blog post, we will explore how to manage form state and handle user input in React using controlled components.

    1. Setting Up the Form Component:
    Start by creating a form component in React. Use the `useState` hook to manage the form state and track changes to the input fields. Here is an example of a basic form component:

    ```jsx
    import React, { useState } from ''react'';

    function FormComponent() {
        const [formData, setFormData] = useState({
            name: '',
            email: '',
            message: ''
        });

        const handleInputChange = (event) => {
            const { name, value } = event.target;
            setFormData((prevState) => ({
                ...prevState,
                [name]: value
            }));
        };

        const handleSubmit = (event) => {
            event.preventDefault();
            // Perform form submission logic here
        };

        return (
            <form onSubmit={handleSubmit}>
                <input
                    type="text"
                    name="name"
                    value={formData.name}
                    onChange={handleInputChange}
                />
                <input
                    type="email"
                    name="email"
                    value={formData.email}
                    onChange={handleInputChange}
                />
                <textarea
                    name="message"
                    value={formData.message}
                    onChange={handleInputChange}
                ></textarea>
                <button type="submit">Submit</button>
            </form>
        );
    }

    export default FormComponent;
    ```

    The `formData` state holds the values of the input fields. The `handleInputChange` function updates the state when the user types in the input fields. The `handleSubmit` function is triggered when the form is submitted.

    2. Handling Form Submission:
    Inside the `handleSubmit` function, you can perform any form submission logic, such as sending data to a server or performing client-side validation. For brevity, the logic is omitted in this example.

    3. Rendering the Form Component:
    To use the form component, simply import and render it in a parent component:

    ```jsx
    import React from ''react'';
    import FormComponent from ''./FormComponent'';

    function App() {
        return (
            <div>
                <h1>Form Example</h1>
                <FormComponent />
            </div>
        );
    }

    export default App;
    ```

    By rendering the `FormComponent`, you have a functional form in your React application.

    Controlled components in React provide a straightforward and declarative way to handle form inputs. They keep the form state in sync with the user''s input, making it easier to manage and validate form data.

    Experiment with controlled components, explore form validation libraries, and build robust forms in your React applications.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--23
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    8, -- Category ID for Docker
    'Docker Networking with Advanced Configurations', -- Title of the blog post
    'Docker provides powerful networking capabilities to connect containers and enable communication between them. In this blog post, we will explore advanced networking configurations in Docker, including network modes, container-to-container communication, and multi-host networking.

    1. Network Modes:
    Docker supports different network modes that define how containers communicate with each other and the host system. The default network mode is the bridge network, which allows containers to communicate with each other using IP addresses. Other network modes include host network, overlay network, and macvlan network. Here is an example of creating a container with a custom network:

    ```bash
    docker network create mynetwork
    docker run --network=mynetwork mycontainer
    ```

    This example creates a custom network named `mynetwork` and runs a container within that network.

    2. Container-to-Container Communication:
    Docker provides various options for container-to-container communication, such as linking containers, using DNS service discovery, and exposing ports. Linking containers allows one container to access services provided by another container. DNS service discovery enables containers to discover and communicate with each other using their container names. Exposing ports allows containers to expose specific ports for communication. Here is an example of linking containers:

    ```bash
    docker run --name db -e POSTGRES_PASSWORD=pass -d postgres
    docker run --name app --link db:db -d myapp
    ```

    In this example, the `app` container is linked to the `db` container using the `--link` flag, allowing the `app` container to access the database service provided by the `db` container.

    3. Multi-Host Networking:
    Docker also supports multi-host networking for deploying containers across multiple hosts. This enables container communication and load balancing across hosts. Docker Swarm, the native orchestration tool in Docker, provides networking features for multi-host deployments. Here is an example of deploying a service with multi-host networking:

    ```bash
    docker swarm init
    docker network create --driver overlay mynetwork
    docker service create --replicas 3 --name myservice --network=mynetwork myimage
    ```

    This example initializes a Docker Swarm, creates an overlay network named `mynetwork`, and deploys a service with three replicas using that network.

    These are just a few examples of advanced networking configurations in Docker. By understanding and utilizing Docker''s networking capabilities, you can create complex container architectures and enable seamless communication between containers.

    Dive deeper into Docker''s networking documentation, experiment with different network configurations, and master the art of networking in Docker.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--24
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    9, -- Category ID for Kubernetes
    'Kubernetes StatefulSets and Persistent Volumes', -- Title of the blog post
    'Kubernetes provides powerful capabilities for managing stateful applications using StatefulSets and Persistent Volumes. In this blog post, we will explore the usage of StatefulSets and Persistent Volumes in Kubernetes to deploy and manage stateful applications.

    1. StatefulSets:
    StatefulSets are designed for running stateful applications in Kubernetes. They provide guarantees for ordered deployment, scaling, and deletion of pods, enabling stable network identities and persistent storage for each pod. Here is an example of creating a StatefulSet:

    ```yaml
    apiVersion: apps/v1
    kind: StatefulSet
    metadata:
      name: myapp
    spec:
      replicas: 3
      serviceName: myapp
      selector:
        matchLabels:
          app: myapp
      template:
        metadata:
          labels:
            app: myapp
        spec:
          containers:
            - name: myapp
              image: myapp:latest
    ```

    This example creates a StatefulSet named `myapp` with three replicas. Each pod within the StatefulSet is guaranteed to have a unique network identity and stable hostname.

    2. Persistent Volumes:
    Persistent Volumes (PVs) provide a way to persist data in Kubernetes. They decouple storage from the lifecycle of a pod, allowing data to persist even if the pod is terminated. PVs can be dynamically provisioned or statically created. Here is an example of defining a Persistent Volume and Persistent Volume Claim:

    ```yaml
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: myvolume
    spec:
      capacity:
        storage: 10Gi
      accessModes:
        - ReadWriteOnce
      persistentVolumeReclaimPolicy: Retain
      storageClassName: my-storage-class
      hostPath:
        path: /data/myvolume

    ---

    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: myvolume-claim
    spec:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 10Gi
      storageClassName: my-storage-class
    ```

    In this example, we define a Persistent Volume named `myvolume` with a storage capacity of 10GB and a Persistent Volume Claim named `myvolume-claim` that requests 10GB of storage.

    By leveraging StatefulSets and Persistent Volumes, you can run and manage stateful applications in Kubernetes with guaranteed ordering, stable network identities, and persistent storage.

    Dive deeper into StatefulSets and Persistent Volumes documentation, experiment with deploying stateful applications, and unlock the full potential of stateful workloads in Kubernetes.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--25
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    10, -- Category ID for GraphQL
    'Introduction to GraphQL and Querying Data', -- Title of the blog post
    'GraphQL is a query language and runtime that simplifies data fetching and manipulation in APIs. In this blog post, we will introduce the basics of GraphQL and demonstrate how to query data using GraphQL.

    1. What is GraphQL?
    GraphQL is an open-source query language for APIs and a runtime for executing queries with your existing data. It provides a flexible approach to requesting and manipulating data, allowing clients to specify exactly what data they need in a single request.

    2. Querying Data with GraphQL:
    In GraphQL, data is queried using a query language that resembles the structure of the data you want to retrieve. Let''s consider a simple example where we have a "users" endpoint and we want to retrieve a user''s name and email. Here''s a GraphQL query for that:

    ```graphql
    query {
      user {
        name
        email
      }
    }
    ```

    This query specifies that we want to retrieve the "name" and "email" fields from the "user" object.

    3. Query Variables:
    GraphQL supports query variables, which allow you to pass dynamic values to your queries. This is useful when you need to retrieve data based on user input or specific conditions. Here''s an example of using query variables in a GraphQL query:

    ```graphql
    query GetUser($userId: ID!) {
      user(id: $userId) {
        name
        email
      }
    }
    ```

    In this query, the "userId" variable is used to fetch a user by their ID. The actual value for the "userId" variable is passed when executing the query.

    4. Mutations:
    GraphQL also supports mutations, which allow you to modify data on the server. Mutations are similar to queries but are used for creating, updating, or deleting data. Here''s an example of a mutation to create a new user:

    ```graphql
    mutation {
      createUser(name: "John", email: "john@example.com") {
        id
        name
        email
      }
    }
    ```

    This mutation creates a new user with the specified "name" and "email" fields and returns the ID, name, and email of the created user.

    By understanding the basics of GraphQL and how to query data using GraphQL, you can leverage its power to efficiently retrieve and manipulate data from your APIs.

    Dive deeper into GraphQL documentation, explore more advanced features, and revolutionize the way you interact with APIs using GraphQL.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--26
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    11, -- Category ID for Python
    'Python Decorators and Function Wrappers', -- Title of the blog post
    'Python decorators are a powerful feature that allows you to modify or enhance the behavior of functions or classes. In this blog post, we will dive into Python decorators and explore how they can be used to create function wrappers with practical examples.

    1. Understanding Decorators:
    Decorators in Python are functions that take another function as input and extend or modify its behavior without explicitly modifying the original function''s source code. They provide a clean and elegant way to add functionality to functions or classes.

    2. Creating a Simple Decorator:
    Let''s start with a simple example of creating a decorator that logs the execution time of a function. Here''s an implementation of a `@timing` decorator:

    ```python
    import time

    def timing(func):
        def wrapper(*args, **kwargs):
            start_time = time.time()
            result = func(*args, **kwargs)
            end_time = time.time()
            print(f"Execution time: {end_time - start_time} seconds")
            return result
        return wrapper

    @timing
    def my_function():
        # Function code goes here
        pass
    ```

    By using the `@timing` decorator, we can automatically log the execution time of any function we decorate with it.

    3. Decorating Functions with Arguments:
    Decorators can also be used with functions that accept arguments. Here''s an example of creating a decorator that ensures a function is called with specific arguments:

    ```python
    def validate_args(expected_args):
        def decorator(func):
            def wrapper(*args, **kwargs):
                if args != expected_args:
                    raise ValueError("Invalid arguments!")
                return func(*args, **kwargs)
            return wrapper
        return decorator

    @validate_args((1, 2, 3))
    def my_function(a, b, c):
        # Function code goes here
        pass
    ```

    In this example, the `@validate_args` decorator checks if the arguments passed to the function match the expected arguments.

    Python decorators provide a powerful way to modify or extend the behavior of functions or classes. By understanding decorators and function wrappers, you can write more flexible and reusable code in Python.

    Dive deeper into decorators documentation, explore advanced use cases, and take your Python programming skills to the next level.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--27
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    12, -- Category ID for Machine Learning
    'GANs and DCGANs', -- Title of the blog post
    'Generative Adversarial Networks (GANs) are a class of machine learning models that are used for generating new data samples that resemble a given training dataset. In this blog post, we will explore the concepts of GANs and focus on Deep Convolutional GANs (DCGANs), which are specifically designed for generating realistic images.

    1. Introduction to GANs:
    GANs consist of two main components: a generator network and a discriminator network. The generator network learns to generate synthetic samples, while the discriminator network learns to distinguish between real and fake samples. Through an adversarial training process, the generator and discriminator networks compete with each other, gradually improving the quality of generated samples.

    2. Deep Convolutional GANs (DCGANs):
    DCGANs are a variant of GANs that utilize deep convolutional neural networks (CNNs) in both the generator and discriminator networks. The use of CNNs enables DCGANs to capture spatial features in images, resulting in more realistic image generation. We will discuss the architecture of DCGANs and how they differ from traditional GANs.

    3. Training DCGANs:
    Training DCGANs involves optimizing the generator and discriminator networks simultaneously. We will cover the training process and provide code examples using popular machine learning libraries such as TensorFlow or PyTorch. You will learn about key techniques such as mini-batch training, loss functions, and optimization strategies.

    4. Generating Realistic Images:
    We will showcase the power of DCGANs by generating realistic images in various domains, such as handwritten digits, faces, or even generating new artwork. You will see how DCGANs can capture intricate details and generate high-quality samples.

    Although GANs and DCGANs are challenging topics in machine learning, understanding them opens up exciting possibilities for creative applications and image generation.

    Dive deeper into GANs and DCGANs documentation, explore advanced techniques, and unleash your creativity with generative models.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--28
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    13, -- Category ID for DevOps
    'CI/CD with Jenkins and Kubernetes', -- Title of the blog post
    'Continuous Integration and Continuous Deployment (CI/CD) is a critical aspect of modern DevOps practices. In this blog post, we will explore how to set up a CI/CD pipeline using Jenkins and Kubernetes, enabling the automation of build, test, and deployment processes.

    1. Introduction to CI/CD:
    CI/CD is a software development approach that focuses on frequent integration of code changes and automated deployment to production environments. It aims to improve the speed, quality, and reliability of software releases. We will discuss the benefits of CI/CD and its importance in DevOps workflows.

    2. Setting up Jenkins:
    Jenkins is a popular open-source automation server that is widely used for CI/CD. We will guide you through the installation and configuration of Jenkins, including the setup of necessary plugins and agents for building and testing applications.

    3. Building and Testing with Jenkins:
    We will demonstrate how to create Jenkins pipelines that handle the build and test stages of the CI/CD process. You will learn about defining build scripts, configuring automated tests, and incorporating code quality checks.

    4. Deploying to Kubernetes:
    Kubernetes is a powerful container orchestration platform that simplifies the management and scaling of containerized applications. We will show you how to integrate Jenkins with Kubernetes to automate the deployment of applications to Kubernetes clusters. You will see examples of deploying Docker containers, managing namespaces, and scaling deployments.

    5. Monitoring and Rollbacks:
    Monitoring the CI/CD pipeline and handling rollbacks in case of issues is crucial for ensuring the stability of production environments. We will discuss best practices for monitoring and implementing rollback mechanisms using Jenkins and Kubernetes.

    By mastering CI/CD with Jenkins and Kubernetes, you can streamline your software development process and achieve faster and more reliable deployments.

    Dive deeper into Jenkins and Kubernetes documentation, explore advanced techniques, and take your DevOps skills to the next level.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--29
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    1, -- Category ID for Java
    'Java Memory Management and Garbage Collection', -- Title of the blog post
    'Java Memory Management and Garbage Collection are complex topics that every Java developer needs to understand in order to write efficient and high-performance applications. In this blog post, we will delve into the intricacies of Java memory management and the garbage collection process.

    1. Introduction to Java Memory Management:
    We will start by explaining the basics of Java memory management, including the different memory areas in the Java Virtual Machine (JVM) such as the stack and heap. You will learn how Java manages memory allocation and deallocation.

    2. Garbage Collection Algorithms:
    Java employs various garbage collection algorithms to reclaim memory occupied by unused objects. We will explore different garbage collection algorithms, such as Mark and Sweep, Copying, and Generational, and discuss their strengths and weaknesses.

    3. Tuning Garbage Collection:
    Java provides options for tuning the garbage collection process to optimize memory usage and application performance. We will cover advanced topics like garbage collector selection, heap size configuration, and tuning garbage collection parameters.

    4. Memory Leaks and Performance Issues:
    Memory leaks can significantly impact the performance and stability of Java applications. We will discuss common causes of memory leaks and provide examples of how to detect and fix memory leaks in your code.

    5. Memory Profiling and Analysis:
    Profiling tools like VisualVM and Java Mission Control can help you analyze memory usage and identify performance bottlenecks. We will showcase how to use these tools to monitor memory consumption, track object allocations, and optimize memory usage.

    By understanding Java memory management and garbage collection, you can write more efficient and robust Java applications, ensuring optimal memory usage and performance.

    Dive deeper into Java memory management documentation, explore advanced techniques, and master the intricacies of memory optimization in Java.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--30
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    1, -- Category ID for Java
    'Multithreading and Concurrency in Java', -- Title of the blog post
    'Multithreading and concurrency are complex concepts in Java that allow you to write programs that can perform multiple tasks simultaneously and efficiently. In this blog post, we will dive into the intricacies of multithreading and concurrency in Java.

    1. Introduction to Multithreading:
    We will start by explaining the basics of multithreading, including creating and managing threads in Java. You will learn how to create threads using the Thread class and the Runnable interface, and explore thread synchronization mechanisms.

    2. Thread Synchronization:
    Thread synchronization is essential when multiple threads access shared resources concurrently. We will discuss synchronization techniques such as synchronized blocks, locks, and atomic variables to ensure thread safety and prevent race conditions.

    3. Concurrent Collections:
    Java provides a set of concurrent collections that are designed to be thread-safe and efficient for concurrent programming. We will explore classes like ConcurrentHashMap, ConcurrentLinkedQueue, and CountDownLatch, and demonstrate how to use them in multithreaded applications.

    4. Thread Pools:
    Creating and managing threads manually can be inefficient and resource-intensive. We will introduce the concept of thread pools and demonstrate how to use the Executor framework to create and manage thread pools effectively.

    5. Advanced Concurrency Topics:
    We will cover advanced concurrency topics like thread interruption, volatile variables, concurrent programming pitfalls, and best practices for writing concurrent code.

    By mastering multithreading and concurrency in Java, you can build highly efficient and scalable applications that can leverage the power of modern hardware and utilize resources effectively.

    Dive deeper into Java concurrency documentation, explore advanced techniques, and unlock the full potential of multithreading in Java.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--31
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    1, -- Category ID for Java
    'Reflection and Dynamic Proxy in Java', -- Title of the blog post
    'Reflection and Dynamic Proxy are advanced features in Java that allow you to inspect and manipulate classes, methods, and objects dynamically at runtime. In this blog post, we will explore the power and complexities of reflection and dynamic proxy in Java.

    1. Introduction to Reflection:
    We will start by explaining the basics of reflection, including obtaining class information, accessing fields and methods dynamically, and creating objects dynamically. You will learn how to use the java.lang.reflect package to perform reflective operations.

    2. Advanced Reflection Techniques:
    Reflection goes beyond basic class inspection. We will delve into advanced reflection techniques such as invoking private methods, accessing private fields, and working with annotations using reflection.

    3. Dynamic Proxy:
    Dynamic Proxy is a powerful feature that allows you to create proxy objects dynamically at runtime. We will explore how to create dynamic proxies using the java.lang.reflect.Proxy class and leverage them for method interception and customization.

    4. Reflection Performance and Limitations:
    Reflection can be slower compared to normal method invocations. We will discuss the performance implications of using reflection and techniques to mitigate the impact. Additionally, we will explore the limitations and security considerations of reflection.

    5. Practical Use Cases and Best Practices:
    We will showcase practical use cases where reflection and dynamic proxy can be applied, such as building generic frameworks, implementing dependency injection containers, and creating extensible systems. We will also cover best practices and design patterns for using reflection effectively.

    By mastering reflection and dynamic proxy in Java, you can build flexible and extensible applications that can adapt and modify their behavior dynamically at runtime.

    Dive deeper into Java reflection and dynamic proxy documentation, explore advanced techniques, and unlock the full potential of runtime introspection in Java.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--32
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    7, -- Category ID for Angular
    'Reactive Forms and Form Validation in Angular', -- Title of the blog post
    'Reactive Forms and Form Validation are complex topics in Angular that are crucial for building robust and user-friendly forms. In this blog post, we will explore the intricacies of reactive forms and demonstrate how to implement form validation in Angular applications.

    1. Introduction to Reactive Forms:
    We will start by explaining the concept of reactive forms in Angular, including how to create form controls, form groups, and form arrays. You will learn how to bind form controls to user input and react to changes using observables.

    2. Form Validation:
    Form validation is essential for ensuring data integrity and providing a good user experience. We will cover different types of form validation, including built-in validators, custom validators, asynchronous validation, and cross-field validation.

    3. Error Handling and Displaying Validation Messages:
    We will explore various techniques to handle form errors and display validation messages to users. This includes using template-driven validation messages, reactive form directives, and dynamic error message generation.

    4. Form Control Customization:
    Angular provides powerful features for customizing form controls and their behavior. We will demonstrate how to disable form controls, set default values, implement conditional validation, and create custom form control components.

    5. Form Submission and Handling:
    Completing the form submission process involves handling form data, performing data validation, and triggering appropriate actions. We will guide you through the form submission process, including form reset, form submission handling, and handling form data in your application.

    By mastering reactive forms and form validation in Angular, you can build complex and interactive forms that provide a seamless user experience and ensure data integrity.

    Dive deeper into Angular documentation, explore advanced techniques, and elevate your form-building skills in Angular.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--33
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    7, -- Category ID for Angular
    'Custom Structural Directives in Angular', -- Title of the blog post
    'Custom Structural Directives are powerful and complex features in Angular that allow you to modify the DOM structure based on certain conditions. In this blog post, we will explore the intricacies of custom structural directives and demonstrate how to create and use them in Angular applications.

    1. Introduction to Structural Directives:
    We will start by explaining the concept of structural directives in Angular, including the *ngIf and *ngFor directives. You will learn how these built-in directives modify the DOM based on conditions and iterate over collections.

    2. Creating a Custom Structural Directive:
    We will dive into creating a custom structural directive from scratch. You will learn how to define the directive using the @Directive decorator, implement the necessary logic using the TemplateRef and ViewContainerRef, and apply the directive to elements in your templates.

    3. Advanced Techniques:
    We will cover advanced techniques for custom structural directives, including working with input properties, passing context data, and handling changes to the directive inputs. Additionally, we will explore the lifecycle hooks available for structural directives.

    4. Directive Host Binding:
    Directive host binding allows you to bind properties or listen to events on the host element of a directive. We will demonstrate how to leverage host binding to modify the behavior and appearance of elements targeted by the custom structural directive.

    5. Practical Use Cases:
    We will showcase practical use cases where custom structural directives can be applied, such as creating conditional rendering directives, building complex template layouts, and enabling dynamic component rendering.

    By mastering custom structural directives in Angular, you can extend the capabilities of Angular''s template syntax and create reusable and flexible components for manipulating the DOM structure.

    Dive deeper into Angular documentation, explore advanced techniques, and unlock the full potential of custom structural directives in Angular.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--34
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    7, -- Category ID for Angular
    'Angular Animation', -- Title of the blog post
    'Angular Animation is a powerful feature that allows you to create engaging and interactive user experiences in your Angular applications. In this blog post, we will explore the intricacies of Angular Animation and demonstrate how to implement animations in Angular.

    1. Introduction to Angular Animation:
    We will start by explaining the fundamentals of Angular Animation, including the Animation API, keyframes, easing functions, and state-based animations. You will learn how to configure animations at the component level.

    2. Animation Transitions:
    Animation transitions enable smooth and controlled animations between different states of your application. We will cover the transition metadata, transition triggers, and transition states. You will learn how to define animations for enter, leave, and change transitions.

    3. Animation Timelines:
    Animation timelines allow you to orchestrate multiple animations together. We will explore how to create animation sequences, parallel animations, and animation groups. You will learn how to synchronize and coordinate complex animations.

    4. Animation Triggers and States:
    Animation triggers and states provide dynamic control over animations based on user interactions and component state changes. We will demonstrate how to define animation triggers, use them with template expressions, and apply different animations based on component state.

    5. Practical Use Cases:
    We will showcase practical use cases where Angular Animation can be applied, such as animating component transitions, creating interactive user interfaces, and adding visual feedback to user actions.

    By mastering Angular Animation, you can elevate the user experience of your Angular applications and create visually appealing and engaging interfaces.

    Dive deeper into Angular documentation, explore advanced animation techniques, and unlock the full potential of Angular Animation in your applications.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);
--35
INSERT INTO posts (user_id, category_id, title, content, view_count, creation_date, is_published)
VALUES (
    (SELECT FLOOR(RANDOM() * 25) + 1), -- Random user_id between 1 and 25
    6, -- Category ID for TypeScript
    'Exploring Advanced TypeScript Features', -- Title of the blog post
    'TypeScript is a powerful superset of JavaScript that provides additional static typing and advanced features to enhance your development experience. In this blog post, we will dive deep into advanced TypeScript features and demonstrate how they can be leveraged in real-world scenarios.

    1. Advanced Types:
    TypeScript offers various advanced types that go beyond the basics. We will explore features like union types, intersection types, type guards, conditional types, mapped types, and keyof operator. Detailed code examples will showcase how these advanced types can be used to write more expressive and type-safe code.

    2. Generics:
    Generics enable the creation of reusable components and functions that work with different types. We will delve into generics in TypeScript, covering generic functions, generic classes, and constraints. You will learn how to write generic code and leverage type inference to maximize flexibility and type safety.

    3. Decorators:
    Decorators provide a way to modify classes, methods, or properties at runtime. We will explore how decorators work in TypeScript, including class decorators, method decorators, and property decorators. Code examples will demonstrate how decorators can be used to add functionality, perform validation, and implement aspect-oriented programming.

    4. Advanced Module System:
    TypeScript''s module system offers advanced features like namespace aliases, default exports, and module augmentation. We will dive into these features and showcase how to organize and structure your code using modules. You will learn how to leverage module resolution and configure the module loader.

    5. Advanced Compiler Configurations:
    TypeScript provides a rich set of compiler options to fine-tune your compilation process. We will explore advanced compiler configurations, including targetting specific ECMAScript versions, strict type checking, code optimization, and incremental compilation. Detailed code examples will demonstrate how to set up and customize the TypeScript compiler.

    By mastering these advanced TypeScript features, you can write more robust, maintainable, and scalable code, taking full advantage of TypeScript''s static typing and advanced capabilities.

    Dive deeper into TypeScript documentation, experiment with advanced features, and level up your TypeScript skills in real-world projects.', -- Content of the blog post
    FLOOR(RANDOM() * 1000000), -- Random view count between 0 and 1000000
    TIMESTAMP '2011-06-20 23:39:32' + (RANDOM() * (NOW() - TIMESTAMP '2011-06-20 23:39:32')), -- Random creation date between 2011-06-20 23:39:32 and current date/time
    true -- is_published is set to true
);


-------------------------

INSERT INTO comments (post_id, user_id, comment, creation_date, is_confirmed)
VALUES
    (1, 2, 'Great post!', '2021-06-20 23:39:32', true),
    (1, 4, 'I learned a lot from this.', '2019-11-15 10:27:51', true),
    (2, 6, 'Nice explanation.', '2017-08-04 18:12:03', true),
    (2, 8, 'Could be more detailed.', '2016-02-28 09:45:17', true),
    (3, 10, 'Java is my favorite programming language.', '2018-06-10 14:23:55', true),
    (3, 12, 'This helped me solve a problem I had.', '2016-09-29 21:17:04', true),
    (4, 14, 'Git is so powerful!', '2022-03-19 07:56:29', true),
    (4, 16, 'I struggle with Git commands.', '2017-02-09 16:38:52', true),
    (5, 18, 'PostgreSQL is my go-to database.', '2020-08-22 11:59:03', true),
    (5, 20, 'I prefer MySQL over PostgreSQL.', '2017-04-07 13:42:11', true),
    (6, 22, 'TypeScript is the future.', '2019-01-12 19:30:45', true),
    (6, 24, 'I find TypeScript confusing.', '2016-07-03 08:14:22', true),
    (7, 26, 'React is amazing!', '2021-01-05 15:47:16', true),
    (7, 28, 'I struggle with React hooks.', '2018-01-18 22:10:57', true),
    (8, 1, 'Docker makes deployment easy.', '2019-03-27 16:53:28', true),
    (8, 3, 'I prefer using VMs instead of containers.', '2017-09-11 10:05:46', true),
    (9, 5, 'Kubernetes is a game-changer.', '2020-11-20 09:14:39', true),
    (9, 7, 'I find Kubernetes configuration complex.', '2018-04-04 17:29:08', true),
    (10, 9, 'GraphQL simplifies API development.', '2019-06-15 12:37:02', true),
    (10, 13, 'I prefer REST over GraphQL.', '2017-11-30 08:56:21', true),
    (11, 15, 'Python is my favorite language for scripting.', '2021-09-25 14:20:01', true),
    (11, 17, 'Python indentation annoys me.', '2019-02-08 19:08:47', true),
    (12, 19, 'Machine Learning is fascinating!', '2020-03-13 10:43:59', true),
    (12, 21, 'I struggle with understanding ML algorithms.', '2017-06-26 17:51:33', true),
    (13, 23, 'DevOps culture is important for successful projects.', '2018-09-30 22:07:14', true),
    (13, 25, 'I find DevOps tools overwhelming.', '2016-03-14 11:35:22', true),
    (14, 27, 'Cloud Computing is the future of IT.', '2021-05-07 08:19:59', true),
    (14, 29, 'I prefer on-premises infrastructure over the cloud.', '2018-07-23 16:28:44', true),
    (15, 2, 'Cybersecurity is crucial in today''s digital world.', '2020-10-01 13:54:07', true),
    (15, 4, 'I don''t understand the hype around cybersecurity.', '2017-03-18 21:07:33', true),
    (16, 6, 'Nice post!', '2021-07-17 09:16:22', true),
    (16, 8, 'Could be more in-depth.', '2019-12-07 18:29:48', true),
    (17, 10, 'Thanks for sharing!', '2018-07-21 14:58:55', true),
    (17, 12, 'I''ve seen better explanations.', '2016-11-02 23:41:13', true),
    (18, 14, 'I love this topic!', '2022-04-24 06:33:09', true),
    (18, 16, 'Not enough code examples.', '2017-09-12 15:17:28', true),
    (19, 18, 'Very informative.', '2020-09-08 12:44:51', true),
    (19, 20, 'I didn''t learn anything new.', '2017-05-03 10:56:32', true),
    (20, 22, 'Keep up the good work!', '2019-02-28 17:23:27', true),
    (20, 24, 'I expected more from this post.', '2016-08-15 09:07:55', true),
    (21, 26, 'This helped me a lot.', '2021-03-15 21:35:41', true),
    (21, 28, 'Could have been more detailed.', '2018-03-29 10:51:18', true),
    (22, 1, 'I''m impressed!', '2019-05-12 14:02:37', true),
    (22, 3, 'Not what I was looking for.', '2017-10-02 22:18:24', true),
    (23, 5, 'This post changed my perspective.', '2020-12-19 09:41:52', true),
    (23, 7, 'I disagree with some points in this post.', '2018-05-05 17:06:37', true),
    (24, 9, 'Great explanation.', '2019-08-23 12:17:59', true),
    (24, 13, 'Could be more organized.', '2017-01-06 08:36:45', true),
    (25, 15, 'I learned something new.', '2022-01-29 11:24:52', true),
    (25, 17, 'Not clear enough.', '2019-04-13 17:49:36', true),
    (26, 19, 'Interesting topic!', '2020-07-05 08:55:17', true),
    (26, 21, 'I''ve read better posts on this subject.', '2017-09-18 15:19:09', true),
    (27, 23, 'Well written!', '2018-11-15 19:37:04', true),
    (27, 25, 'Lacks practical examples.', '2016-04-30 13:52:28', true),
    (28, 27, 'I''m grateful for this post.', '2021-06-09 10:08:17', true),
    (28, 29, 'Too basic for my taste.', '2018-08-25 17:12:39', true),
    (29, 2, 'This post saved me a lot of time.', '2021-01-31 15:59:06', true),
    (29, 4, 'Not enough depth.', '2019-02-14 23:20:48', true),
    (30, 6, 'Thanks for sharing your insights.', '2017-08-28 09:41:22', true),
    (30, 8, 'I expected more from this post.', '2016-02-11 16:02:17', true),
    (31, 10, 'I love this blog!', '2018-07-23 11:19:08', true),
    (31, 12, 'Could have been more engaging.', '2016-11-08 19:39:52', true),
    (32, 14, 'Very well explained.', '2022-03-28 08:26:17', true),
    (32, 16, 'Not clear enough for me.', '2017-02-16 16:59:43', true),
    (33, 18, 'Informative and concise.', '2020-08-13 11:44:02', true),
    (33, 20, 'This post didn''t provide anything new.', '2017-03-30 13:27:54', true),
    (34, 22, 'Well done!', '2019-01-04 18:03:31', true),
    (34, 24, 'Too basic for my level.', '2016-06-24 09:50:17', true);

INSERT INTO comments (post_id, user_id, comment, creation_date, is_confirmed)
VALUES
    (1, 2, 'I told my computer a joke, but it didn''t laugh. I guess it didn''t find it byte-ful.', '2021-06-20 23:39:32', true),
    (1, 4, 'Why do programmers prefer dark mode? Because light attracts bugs!', '2019-11-15 10:27:51', true),
    (2, 6, 'I asked the computer to make me a sandwich. It said, "Sorry, I''m a byte-oriented machine, I can''t make sandwiches."', '2017-08-04 18:12:03', true),
    (2, 8, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2016-02-28 09:45:17', true),
    (3, 10, 'Why did the Java developer go broke? Because he lost his cache!', '2018-06-10 14:23:55', true),
    (3, 12, 'A SQL query walks into a bar, walks up to two tables, and asks... "Can I join you?"', '2016-09-29 21:17:04', true),
    (4, 14, 'Why did the developer go broke? Because he couldn''t find a byte to eat!', '2022-03-19 07:56:29', true),
    (4, 16, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2017-02-09 16:38:52', true),
    (5, 18, 'Why did the database administrator leave his wife? She had one too many one-to-many relationships!', '2020-08-22 11:59:03', true),
    (5, 20, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2017-04-07 13:42:11', true),
    (6, 22, 'Why did the TypeScript developer spend all his money? Because he wanted type rich!', '2019-01-12 19:30:45', true),
    (6, 24, 'I asked the computer to make me a sandwich. It said, "Sorry, I''m a byte-oriented machine, I can''t make sandwiches."', '2016-07-03 08:14:22', true),
    (7, 26, 'Why did the React component go to therapy? Because it had too many issues to render!', '2021-01-05 15:47:16', true),
    (7, 28, 'Why do programmers prefer dark mode? Because light attracts bugs!', '2018-01-18 22:10:57', true),
    (8, 1, 'Why did the container go to therapy? Because it had too many issues to deploy!', '2019-03-27 16:53:28', true),
    (8, 3, 'Why did the programmer quit his job? Because he didn''t get arrays!', '2017-09-11 10:05:46', true),
    (9, 5, 'Why did the Kubernetes developer get kicked out of the party? He kept crashing the pods!', '2020-12-01 08:24:59', true),
    (9, 7, 'I told my computer a joke, but it didn''t laugh. I guess it didn''t find it byte-ful.', '2018-05-20 17:33:10', true),
    (10, 9, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2022-02-08 11:17:24', true),
    (10, 13, 'Why did the Python developer go broke? Because he lost his py(th)!', '2017-01-03 07:59:37', true),
    (11, 15, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2020-11-11 14:48:56', true),
    (11, 17, 'Why did the GraphQL developer go broke? Because he couldn''t find any valid queries!', '2018-03-01 20:30:21', true),
    (12, 19, 'Why did the machine learning algorithm go to therapy? It had too many deep issues!', '2022-05-17 09:01:40', true),
    (12, 21, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2017-08-30 16:49:02', true),
    (13, 23, 'Why did the DevOps engineer get kicked out of the party? He couldn''t stop automating the drinks!', '2018-10-14 10:45:11', true),
    (13, 25, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2016-04-01 18:57:29', true),
    (14, 27, 'Why did the cloud server break up with the database? It wasn''t a good match, noSQL.', '2021-05-14 07:30:17', true),
    (14, 29, 'Why do programmers prefer dark mode? Because light attracts bugs!', '2018-07-07 15:41:04', true),
    (15, 2, 'Why did the cybersecurity expert bring a ladder to work? To scale the firewall!', '2020-10-12 12:18:23', true),
    (15, 4, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2017-03-26 19:22:39', true),
    (16, 6, 'Why did the programmer go broke? Because he couldn''t find a byte to eat!', '2021-07-25 09:56:02', true),
    (16, 8, 'Why did the Angular developer go broke? Because all his projects were in beta!', '2019-12-19 17:03:49', true),
    (17, 10, 'Why did the programmer wear eyeglasses? Because he couldn''t C# without them!', '2018-07-07 13:15:24', true),
    (17, 12, 'Why do programmers prefer dark mode? Because light attracts bugs!', '2016-10-21 22:37:11', true),
    (18, 14, 'Why did the programmer go broke? Because he couldn''t find a byte to eat!', '2022-04-30 05:49:08', true),
    (18, 16, 'Why did the Git developer go broke? Because he lost his HEAD!', '2017-02-15 09:58:37', true),
    (19, 18, 'Why did the PostgreSQL developer go broke? Because he lost all his relations!', '2020-07-18 16:22:51', true),
    (19, 20, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2017-02-10 21:08:14', true),
    (20, 22, 'Why did the programmer go broke? Because he couldn''t find a byte to eat!', '2019-01-21 10:33:57', true),
    (20, 24, 'Why did the React developer get in trouble with the law? Because he left his components unmounted!', '2016-07-09 18:56:20', true),
    (21, 26, 'Why did the Docker container go to therapy? Because it had too many issues to deploy!', '2020-12-05 15:14:49', true),
    (21, 28, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2018-02-18 22:05:36', true),
    (22, 1, 'Why did the Kubernetes developer go broke? Because he kept crashing the pods!', '2019-04-01 11:42:27', true),
    (22, 3, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2017-08-01 10:35:59', true),
    (23, 5, 'Why did the Python developer go broke? Because he lost his py(th)!', '2021-01-09 09:24:18', true),
    (23, 7, 'Why do programmers prefer dark mode? Because light attracts bugs!', '2018-05-24 19:18:47', true),
    (24, 9, 'Why did the Java developer go broke? Because he lost his cache!', '2022-02-05 14:37:52', true),
    (24, 13, 'Why did the database administrator leave his wife? She had one too many one-to-many relationships!', '2016-12-08 21:51:06', true),
    (25, 15, 'Why did the Git developer go broke? Because he lost his HEAD!', '2020-11-02 08:59:44', true),
    (25, 17, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2017-03-08 17:14:12', true),
    (26, 19, 'Why did the programmer go broke? Because he couldn''t find a byte to eat!', '2022-03-24 07:45:27', true),
    (26, 21, 'Why did the Angular developer go broke? Because all his projects were in beta!', '2017-09-18 12:20:51', true),
    (27, 23, 'Why did the programmer wear eyeglasses? Because he couldn''t C# without them!', '2018-11-11 19:37:04', true),
    (27, 25, 'Why do programmers prefer dark mode? Because light attracts bugs!', '2016-04-26 22:02:29', true),
    (28, 27, 'Why did the machine learning algorithm go to therapy? It had too many deep issues!', '2021-04-05 09:12:17', true),
    (28, 29, 'Why did the React component go to therapy? Because it had too many issues to render!', '2018-07-15 15:34:55', true),
    (29, 2, 'Why did the DevOps engineer get kicked out of the party? He couldn''t stop automating the drinks!', '2020-09-10 10:27:22', true),
    (29, 4, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2017-03-05 18:29:39', true),
    (30, 6, 'Why did the cloud server break up with the database? It wasn''t a good match, noSQL.', '2022-01-15 06:10:33', true),
    (30, 8, 'Why did the TypeScript developer spend all his money? Because he wanted type rich!', '2019-11-27 17:48:56', true),
    (31, 10, 'Why did the cybersecurity expert bring a ladder to work? To scale the firewall!', '2018-06-29 14:53:01', true),
    (31, 12, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2016-10-04 21:11:15', true),
    (32, 14, 'Why did the programmer go broke? Because he couldn''t find a byte to eat!', '2021-12-19 09:29:49', true),
    (32, 16, 'Why did the GraphQL developer go broke? Because he couldn''t find any valid queries!', '2018-02-27 19:28:23', true),
    (33, 18, 'Why did the machine learning algorithm go to therapy? It had too many deep issues!', '2022-07-28 07:37:57', true),
    (33, 20, 'Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!', '2017-10-03 22:44:14', true),
    (34, 22, 'Why did the Docker container go to therapy? Because it had too many issues to deploy!', '2021-03-09 15:25:36', true),
    (34, 24, 'Why did the programmer quit his job? Because he didn''t get arrays!', '2016-09-03 10:07:58', true);

INSERT INTO comments (post_id, user_id, comment, creation_date, is_confirmed) VALUES
    (1, 2, 'Programming is so hard, I feel like I''m stuck in an infinite loop!', '2023-03-14 09:28:43', true),
    (1, 4, 'Why does Java have to be so verbose? It''s like writing a novel for a simple task.', '2022-12-01 16:05:22', true),
    (2, 6, 'Angular, oh Angular... Why must you make my head spin with all your complex configurations?', '2023-01-20 11:59:14', true),
    (2, 8, 'I''ve been debugging a Spring application for hours, and I still can''t find that elusive bug!', '2022-09-05 18:42:37', true),
    (3, 10, 'Git, the source of my constant headaches. I never know which branch is up-to-date!', '2023-04-02 14:17:59', true),
    (3, 12, 'Why does Git have so many commands that sound like a secret code? It feels like I''m hacking into my own codebase!', '2022-11-15 21:30:46', true),
    (4, 14, 'PostgreSQL, my nemesis! Why must you be so picky about data types and constraints?', '2023-02-18 10:12:01', true),
    (4, 16, 'I spent hours troubleshooting a PostgreSQL query, only to find out I missed a single semicolon!', '2022-10-10 19:04:23', true),
    (5, 18, 'Why must TypeScript constantly remind me of all the potential errors I could make? It''s like living in constant fear!', '2023-05-27 13:55:18', true),
    (5, 20, 'TypeScript, the strict teacher of programming. One small mistake, and it won''t let me compile!', '2022-08-07 22:39:51', true),
    (6, 22, 'React, my never-ending struggle. Sometimes it feels like I''m juggling a hundred components!', '2023-03-05 08:20:37', true),
    (6, 24, 'Why does React have so many lifecycle methods? It''s like trying to keep up with a constantly changing dance routine!', '2022-12-20 17:03:19', true),
    (7, 26, 'Docker, the containerization nightmare. One wrong configuration, and everything falls apart!', '2023-01-10 12:45:51', true),
    (7, 28, 'I''ve been trying to deploy my application with Docker, but it feels like I''m trapped in a never-ending maze!', '2022-09-25 21:27:34', true),
    (8, 1, 'Kubernetes, the complexity monster. Managing pods, services, and deployments is driving me insane!', '2023-04-14 15:59:22', true),
    (8, 3, 'Why does Kubernetes have to be so unforgiving? One misconfiguration, and everything crashes!', '2022-11-28 23:42:07', true),
    (9, 5, 'GraphQL, the puzzle I can never solve. Writing queries feels like deciphering an ancient language!', '2023-02-08 09:36:49', true),
    (9, 7, 'I''ve been debugging a GraphQL resolver for days, and I still can''t figure out why it''s returning null!', '2022-10-21 18:18:15', true),
    (10, 9, 'Python, my love-hate relationship. Indentation errors are my constant companions!', '2023-06-20 16:28:12', true),
    (10, 11, 'Why does Python have to be so strict with its whitespace? It''s like a never-ending battle of tabs vs. spaces!', '2022-07-05 22:01:55', true),
    (11, 13, 'Machine Learning, the endless abyss of algorithms. Sometimes I feel like I''m drowning in a sea of data!', '2023-04-01 11:14:29', true),
    (11, 15, 'Why does Machine Learning have to be so math-intensive? I''m starting to forget what "simple" means!', '2022-12-15 19:56:44', true),
    (12, 17, 'DevOps, the never-ending balancing act. Continuous integration, deployment, and monitoring are driving me crazy!', '2023-01-15 14:47:51', true),
    (12, 19, 'I''ve been trying to set up a CI/CD pipeline, but it feels like I''m juggling a dozen spinning plates!', '2022-09-30 23:29:35', true),
    (13, 21, 'Cloud Computing, the elusive concept. Sometimes I wonder if I''m just chasing clouds!', '2023-05-10 10:08:07', true),
    (13, 23, 'Why does Cloud Computing have so many buzzwords? It feels like a never-ending game of catch-up!', '2022-08-25 18:50:22', true),
    (14, 25, 'Cybersecurity, the constant battle against invisible enemies. I feel like I''m living in a hacker thriller!', '2023-03-20 07:39:59', true),
    (14, 27, 'I''ve been trying to secure my application, but it seems like the vulnerabilities are always one step ahead!', '2022-12-05 16:22:34', true),
    (15, 29, 'Why does programming have to be so challenging? It feels like an endless maze of complexity!', '2023-02-05 11:58:21', true),
    (15, 2, 'Sometimes I wonder if I''ll ever truly master programming. It''s like trying to conquer a never-ending mountain!', '2022-10-20 20:41:05', true),
    (16, 4, 'Java, the language that never stops surprising me with its intricate syntax. It''s a constant struggle!', '2023-04-27 13:14:43', true),
    (16, 6, 'Why does Java have to be so strict with its type system? It feels like I''m always fighting against its rules!', '2022-11-10 21:57:26', true),
    (17, 8, 'Angular, the framework that tests my patience. Sometimes I feel like I''m wrestling with a stubborn beast!', '2023-01-25 15:42:58', true),
    (17, 10, 'I''ve been chasing a bug in an Angular template for hours, and I still can''t find the culprit!', '2022-09-09 00:24:42', true),
    (18, 12, 'Spring, the framework that keeps me on my toes. It''s like a never-ending dance with dependency injection!', '2023-04-13 10:07:16', true),
    (18, 14, 'Why does Spring have to have so many configuration files? It''s like a maze of XML and annotations!', '2022-10-28 18:49:30', true),
    (19, 16, 'Git, the version control system that tests my patience every day. Merge conflicts, oh the pain!', '2023-03-01 07:30:44', true),
    (19, 18, 'I''ve been trying to understand Git branching strategies, but it feels like I''m lost in a forest of commits!', '2022-11-14 16:12:59', true),
    (20, 20, 'PostgreSQL, the database that haunts my dreams. It''s like a never-ending battle against query optimization!', '2023-01-18 09:03:12', true),
    (20, 22, 'Why does PostgreSQL have to be so strict with its data types? It feels like I''m walking on a tightrope of constraints!', '2022-09-02 17:45:26', true),
    (21, 24, 'TypeScript, the language that drives me to the brink of madness. I just want to write JavaScript!', '2023-04-10 14:56:49', true),
    (21, 26, 'I''ve been battling with TypeScript type errors, and it feels like I''m swimming against a strong current!', '2022-10-24 23:39:12', true),
    (22, 28, 'React, the library that constantly challenges my sanity. State management, why must you be so complicated?', '2023-03-06 12:20:37', true),
    (22, 1, 'Why does React have so many abstractions? It feels like I''m building a tower of components!', '2022-12-19 21:03:19', true),
    (23, 3, 'Docker, the containerization tool that brings tears to my eyes. Networking, why do you have to be so confusing?', '2023-01-09 14:45:51', true),
    (23, 5, 'I''ve been troubleshooting Docker volume mounts, and it feels like I''m stuck in a maze of paths!', '2022-09-24 23:27:34', true),
    (24, 7, 'Kubernetes, the orchestrator that keeps me up at night. Scaling pods, why must you be so unpredictable?', '2023-04-13 18:59:22', true),
    (24, 9, 'Why does Kubernetes have to have so many YAML configurations? It''s like deciphering an alien language!', '2022-10-28 03:42:07', true),
    (25, 11, 'GraphQL, the query language that always keeps me on my toes. Fragments, why must you complicate things?', '2023-02-07 14:36:49', true),
    (25, 13, 'I''ve been debugging a GraphQL resolver for days, and it feels like I''m chasing a phantom bug!', '2022-10-20 23:18:15', true),
    (26, 15, 'Python, the language that sometimes feels like a maze. Indentation errors, why do you haunt me?', '2023-06-19 15:28:12', true),
    (26, 17, 'Why does Python have to be so strict with its syntax? It''s like dancing with a strict partner!', '2022-07-04 21:01:55', true),
    (27, 19, 'Machine Learning, the field that constantly reminds me of my limitations. Algorithms, why must you be so complex?', '2023-03-31 17:14:29', true),
    (27, 21, 'Why does Machine Learning have to involve so much math? It feels like I''m lost in an endless sea of equations!', '2022-12-14 01:56:44', true),
    (28, 23, 'DevOps, the never-ending challenge that tests my patience. Infrastructure as code, why must you be so finicky?', '2023-01-14 10:47:51', true),
    (28, 25, 'I''ve been trying to automate my deployment pipeline, but it feels like I''m navigating a minefield!', '2022-09-29 19:29:35', true),
    (29, 27, 'Cloud Computing, the concept that sometimes feels like a distant dream. Why must you have so many layers of abstraction?', '2023-05-09 14:08:07', true),
    (29, 29, 'Why does Cloud Computing have so many different services? It feels like a never-ending game of learning!', '2022-08-24 21:50:22', true),
    (30, 2, 'Cybersecurity, the field that keeps me on my toes. Hackers, why must you be one step ahead?', '2023-03-19 03:39:59', true),
    (30, 4, 'I''ve been trying to secure my application, but it feels like the vulnerabilities are always lurking!', '2022-12-04 10:22:34', true),
    (31, 6, 'Why does programming have to be so mentally exhausting? It feels like I''m running a marathon with no finish line!', '2023-02-04 07:58:21', true),
    (31, 8, 'Sometimes I wonder if I''ll ever truly understand programming. It''s like trying to solve a never-ending puzzle!', '2022-10-19 14:41:05', true),
    (32, 10, 'Java, the language that tests my patience every day. Why must you have so many rules and exceptions?', '2023-04-26 20:14:43', true),
    (32, 12, 'I''ve been battling with Java memory leaks, and it feels like I''m fighting against invisible enemies!', '2022-11-09 04:57:26', true),
    (33, 14, 'Angular, the framework that constantly reminds me of my limitations. Why must you have so many concepts to grasp?', '2023-03-24 17:42:58', true),
    (33, 16, 'I''ve been struggling with Angular template syntax, and it feels like I''m lost in a jungle of braces and directives!', '2022-11-08 02:24:42', true),
    (34, 18, 'Spring, the framework that makes me question my sanity. Why must you have so many layers of abstraction?', '2023-04-12 18:07:16', true),
    (34, 20, 'I''ve been debugging Spring bean wiring issues, and it feels like I''m untangling a web of dependencies!', '2022-10-27 02:49:30', true);