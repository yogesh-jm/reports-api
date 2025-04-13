# 📊 Reports API

A simple API-only Ruby on Rails application to perform CRUD operations on Reports.

## 🚀 Features

- Create, Read, Update, and Delete reports
- Pagination support
- JSON responses
- Basic validations
- RSpec test coverage
- Query pattern
- Presenter pattern

## 🛠 Tech Stack

- Ruby on Rails (API Mode)
- PostgreSQL (or any preferred DB)
- RSpec for testing
- Pry for debugging

## 📦 Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/reports-api.git
cd reports-api
```

### 2. Install dependencies
```bash
bundle install
```

### 3. Database setup
```bash
rails db:create
rails db:migrate
```

### 4. Start the server
```bash
rails server

The API will be available at http://localhost:3000
```

## ✅ Running tests

```bash
bundle exec rspec
```


## 📄 API endpoints

GET /reports

GET /reports/:id

POST /reports

PUT /reports/:id

DELETE /reports/:id

Supports pagination with ?page=1&per_page=10.

Test the endpoints with CURL. 
Example: 
```bash
curl -X GET http://localhost:3000/reports
```

## 💡 Notes

- Query Pattern is used for querying and paginating the reports. The Query Pattern helps in separating the querying logic from the controller, providing better reusability and maintainability.
- The Presenter pattern is used to encapsulate presentation logic, keeping controllers and models clean and focused on their core responsibilities.
- Strong parameters are used to whitelist input data.
- Includes basic error handling with appropriate HTTP status codes.
- Supports basic pagination
