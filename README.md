# MaaS

This is an MVP for MaaS (Monitoring as a Service), developed with Rails and Vue.

It uses Docker for containerization and has support for DevContainers to
facilitate development in consistent environments.

## Requirements

- Docker
- Docker Compose
- Visual Studio Code (optional, but recommended for using DevContainers)

## How to Run with DevContainer

To set up and run the project using a DevContainer, follow these steps:

1. **Clone the repository:**

```
git clone https://github.com/rogalvil/maas
cd maas
```

2. **Open the project in Visual Studio Code:**

```
code .
```

3. **Reopen in Container:**

If you have the Dev Containers extension installed.

https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers

You should see a prompt in the bottom right corner asking if you want to reopen
the project in a container. Click "Reopen in Container".

![Screenshot 2024-06-26 at 7 07 28 a m](https://github.com/rogalvil/tgc/assets/695923/666428ad-6cda-44a2-8650-da9e0b3659dd)

If you don't see the prompt, you can open the Command Palette
(Ctrl+Shift+P or Cmd+Shift+P on macOS) and select "Remote-Containers: Reopen in Container".

4. **Wait for the container to build and start:**

The first time you open the project in a container, it will build the Docker
image specified in the `Dockerfile` and set up the development environment. This
may take a few minutes.

5. **Set up the database:**

Once the container is up and running, open a new terminal in VS Code and run:

```
rails db:create db:migrate
```

and run to seed the database with engineers and services:

```
rails db:seed
```

6. Create master.key file, you can use the following command:

```
rails credentials:edit
```

7. **Start the Rails server:**

In the terminal, run:

```
rails server -b 0.0.0.0
```

or click on Run and Debug in the sidebar and select "Rails Server".

![Screenshot 2024-06-26 at 7 08 06 a m](https://github.com/rogalvil/tgc/assets/695923/aea7dd1e-66bd-4873-8d95-22d65ec2edae)

and then click on the green play button.

![Screenshot 2024-06-26 at 7 08 48 a m](https://github.com/rogalvil/tgc/assets/695923/6811ac40-e241-4d66-a365-cdc85a09b0bd)

then apper a controls to manage the server.

![Screenshot 2024-06-26 at 7 09 00 a m](https://github.com/rogalvil/tgc/assets/695923/cca2d9f6-b6ee-49c4-8564-fba1564228ef)

8. **Access the application:**

The application should now be running and accessible at `http://localhost:3000`.

9. **Run tests:**

To run the test suite, use the following command in the terminal:

```
rspec
```

By following these steps, you should be able to set up and run the project
using a DevContainer in Visual Studio Code.

## How to Run with Docker

To set up and run the project using Docker, follow these steps:

1. **Clone the repository:**

```
git clone https://github.com/rogalvil/maas
cd maas
```

2. **Build the Docker images:**

```
docker-compose build development
```

3. **Run the containers in bash mode:**

Run the development service in bash mode to get inside the container by using
the following command:

```
docker-compose run development bash
```

5. **Run the containers:**

```
docker-compose up development
```

6. **Set up the database:**

Inside the containers in bash mode you need to migrate the database:

```
rails db:create db:migrate
```

and run to seed the database with engineers and services:

```
rails db:seed
```

Or once the containers are up and running, you need to create and migrate the
database. Open a new terminal window and run:

```
docker-compose exec development rails db:create db:migrate
```

and run to seed the database with engineers and services:

```
docker-compose exec development rails db:seed
```

7. Create master.key file, you can use the following command:

Inside the containers in bash mode you need to migrate the database:

```
rails credentials:edit
```

Or once the containers are up and running, you need to create the master.key
file. Open a new terminal window and run:

```
docker-compose exec development rails credentials:edit
```

7. **Access the application:**

The application should now be running and accessible at `http://localhost:3000`.

8. **Run tests:**

To run the test suite, use the following command in bash mode:

```
rspec
```

Or once the containers are up and running, you can run the tests using the
following command in a new terminal window

```
docker-compose exec development rspec
```

9. **Stop the containers:**

To stop the running containers, use:

```
docker-compose down development
```

By following these steps, you should be able to set up and run the project using
Docker.

## Pages

The project is divided into two main pages:

1. Confirmed Shifts: This page shows a list of confirmed shifts. It is possible
   to filter by service and week.

2. Weekly Availability: This page sets up the weekly availability for a service.
   It allows the user to select available hours for each engineer and also
   generates a work schedule for the week.

## Components

1. **Engineer Hours:** This component allows the user to view a list of
   engineers with a summary of the hours assigned to them.

![Screenshot 2024-08-01 at 7 22 31 p m](https://github.com/user-attachments/assets/5692e3d0-f53f-4048-9f36-1dcfa0509cc2)

2. **Schedule Table:** This component displays a table with the work schedule
   for the week. It shows the shifts assigned to each engineer.

![Screenshot 2024-08-01 at 7 23 41 p m](https://github.com/user-attachments/assets/a2644203-4e43-4628-afb2-e9935ec7ddf4)

3. **Service Selector:** This component allows the user to select a service from
   a dropdown list.

![Screenshot 2024-08-01 at 7 24 40 p m](https://github.com/user-attachments/assets/301f471f-8d44-43aa-b3e9-45c0bab62a93)

4. **Weekly Schedule:** This component allow to setup the weekly availability
   for a service. It allows the user to select available hours for each engineer
   and also generates a work schedule for the week.

![Screenshot 2024-08-01 at 7 26 35 p m](https://github.com/user-attachments/assets/cf62275e-e458-4a23-a46f-f42c08941227)

5. **Week Selector:** This component allows the user to select a week from a
   dropdown list.

![Screenshot 2024-08-01 at 7 24 45 p m](https://github.com/user-attachments/assets/cd491571-0d87-4564-a074-dc8f2602349a)

## Issues

- The assignment of schedules from weekly availability was uncertain about when to
  execute it. I consider that it would be good to execute it with sidekiq and
  sidekiq-unique-jobs to avoid multiple executions, but for now, I haven’t
  developed it. Therefore, for now, a button "ASIGNAR TURNOS" must be pressed to
  perform the action manually.

- I also believe that previous weeks should possibly not be editable, but this
  has not been developed either.
