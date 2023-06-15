# README

This README provides instructions on how to get the application up and running, as well as other important information.

## Prerequisites

Make sure you have the following installed:

- Ruby version 3.0.1
- Rails version 7.0.5
- PostgreSQL (for the database)

## Installation

1. Clone the repository to your local machine.
2. Navigate to the project directory.

## Setup

### System Dependencies

Ensure that you have the necessary system dependencies installed. If not, please install them before proceeding.

### Configuration

No additional configuration steps are required.

### Database Creation

To create the database, run the following commands:

```bash
rails db:create

Database Initialization
To initialize the database and run migrations, execute the following command:
rails db:migrate

User and Roles Generation
To generate user roles, create users, and assign roles, use the following commands:

rails user:create_roles
rails user:create_users
rails user:assign_roles

Running the Test Suite
To run the test suite, execute the following command:

rspec spec/

Starting the Server
To start the Rails server, run the following command:

rails s

The application should now be accessible at http://localhost:3000.

