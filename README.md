# Wallet Application README

This README provides the necessary steps to set up and run the Wallet application.

## Prerequisites

Ensure you have the following installed:
- Ruby (specific version mentioned in the Gemfile, e.g., `ruby 3.4.2`)
- Rails (`~> 7.1.5`)
- Bundler gem (`gem install bundler`)

## Setup Instructions

1. **Install Dependencies**  
    Run the following command to install all required gems:
    ```bash
    bundle install
    ```

2. **Database Setup**  
    Create and migrate the database:
    ```bash
    rails db:create
    rails db:migrate
    ```

3. **Seed the Database**  
    Populate the database with initial data:
    ```bash
    rails db:seed
    ```

4. **Start the Server**  
    Launch the Rails server:
    ```bash
    rails server
    ```

5. **Run Tests**  
    Execute the test suite to ensure everything is working correctly:
    ```bash
    bundle exec rspec
    ```

