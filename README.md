# 🏍️ MotoVerse — Smart Bike & Car Enthusiast Platform

MotoVerse is a Java-based web application that allows users to explore, search, filter, and compare bikes and cars in one place. It also provides user authentication, a personalized wishlist, and an admin interface for managing vehicle information.

## ✨ Features

- **Vehicle Browsing:** View available bikes and cars.
- **Search and Filtering:** Find vehicles based on available criteria.
- **Vehicle Comparison:** Compare two vehicles of the same type.
- **User Authentication:** Register, log in, and log out.
- **Personalized Wishlist:** Add favourite vehicles to your wishlist and remove them when needed.
- **Admin Dashboard:** Add, edit, and delete vehicle records.
- **Database Integration:** Store and retrieve vehicle and user data using MySQL.

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Java | Backend application logic |
| JSP | Dynamic web pages |
| Jakarta Servlets | Request handling and application flow |
| JDBC | Database connectivity |
| MySQL | Relational database |
| HTML, CSS, JavaScript | Frontend development |
| Apache Tomcat 10 | Web application server |
| Eclipse IDE | Development environment |

## 🏗️ Project Structure

```text
MotoVerse/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/motoverse/
│       │       ├── controller/
│       │       ├── dao/
│       │       ├── model/
│       │       └── util/
│       └── webapp/
│           ├── WEB-INF/
│           ├── css/
│           ├── images/
│           ├── index.jsp
│           ├── vehicles.jsp
│           ├── login.jsp
│           ├── register.jsp
│           └── wishlist.jsp
├── .classpath
├── .project
├── .gitignore
└── README.md
```

## ⚙️ Prerequisites

Before running MotoVerse, make sure you have:

- JDK installed
- Eclipse IDE with Dynamic Web Project support
- Apache Tomcat 10.x
- MySQL Server
- MySQL Connector/J

## 🚀 Setup and Run

1. Clone the repository:

   ```bash
   git clone https://github.com/maheshreddy077/MotoVerse.git
   ```

2. Import the project into Eclipse as an existing project.

3. Create a MySQL database named `motoverse_db`.

4. Create the required database tables and configure the database schema for the application.

5. Configure the following environment variables for database connectivity:

   - `MOTOVERSE_DB_URL` — for example, `jdbc:mysql://localhost:3306/motoverse_db`
   - `MOTOVERSE_DB_USER` — your MySQL username
   - `MOTOVERSE_DB_PASSWORD` — your MySQL password

6. Ensure the MySQL Connector/J library is available to the application.

7. Configure Apache Tomcat 10.x in Eclipse and add MotoVerse to the server.

8. Start Tomcat and open the application using the local URL assigned by your server configuration.

## 🔐 Security Notes

- Database credentials are read from environment variables rather than hardcoded in the Java source.
- User passwords are handled using a password-hashing utility.
- Keep database credentials and other secrets out of version control.

## 🎯 Learning Outcomes

This project provided hands-on experience with:

- Java web
