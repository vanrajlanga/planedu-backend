# PlanEdu API Backend

Node.js + Express + PostgreSQL REST API for PlanEdu Education Platform

## Features

- ✅ User Authentication (Register, Login, Email Verification)
- ✅ College Discovery with Advanced Search & Filters
- ✅ College Reviews
- ✅ JWT-based Authentication
- ✅ Input Validation
- ✅ Error Handling
- ✅ Security (Helmet, CORS)
- ✅ Database Connection Pooling

## Tech Stack

- **Runtime:** Node.js
- **Framework:** Express.js
- **Database:** PostgreSQL 17.5
- **Authentication:** JWT (jsonwebtoken)
- **Password Hashing:** bcrypt
- **Validation:** express-validator
- **Security:** Helmet, CORS

## Project Structure

```
backend/
├── src/
│   ├── config/
│   │   └── database.js          # PostgreSQL connection pool
│   ├── controllers/
│   │   ├── authController.js    # Authentication logic
│   │   └── collegeController.js # College operations
│   ├── middleware/
│   │   ├── auth.js              # JWT authentication middleware
│   │   └── errorHandler.js      # Global error handler
│   ├── routes/
│   │   ├── authRoutes.js        # Auth endpoints
│   │   └── collegeRoutes.js     # College endpoints
│   ├── validators/
│   │   └── authValidator.js     # Input validation rules
│   ├── utils/
│   │   ├── response.js          # Standard API responses
│   │   └── jwt.js               # JWT utilities
│   ├── app.js                   # Express app configuration
│   └── server.js                # Server entry point
├── .env                         # Environment variables
├── .gitignore
├── package.json
└── README.md
```

## Installation

1. **Clone the repository**
   ```bash
   git clone git@github.com:vanrajlanga/planedu-backend.git
   cd planedu-backend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure environment variables**

   Copy the example environment file and update with your values:
   ```bash
   cp .env.example .env
   ```

   Update the `.env` file with your configuration:
   ```env
   PORT=3000
   DB_HOST=localhost
   DB_PORT=5432
   DB_NAME=collegedunia_db
   DB_USER=postgres
   DB_PASSWORD=your-postgres-password
   JWT_SECRET=your-super-secret-jwt-key-change-this
   ADMIN_JWT_SECRET=your-admin-jwt-secret-key-change-this
   ```

4. **Set up PostgreSQL Database**

   a. Ensure PostgreSQL is running:
   ```bash
   # Check if PostgreSQL is running
   psql --version
   pg_isready
   ```

   b. Create the database:
   ```bash
   psql -U postgres -c "CREATE DATABASE collegedunia_db;"
   ```

   c. Import the database schema and data:
   ```bash
   psql -U postgres -d collegedunia_db -f database.sql
   ```

   This will create all tables, indexes, and insert initial data.

5. **Verify database import**
   ```bash
   psql -U postgres -d collegedunia_db -c "\dt"
   ```
   You should see all the tables listed.

## Running the Server

### Development Mode (with auto-reload)
```bash
npm run dev
```

### Production Mode
```bash
npm start
```

The server will start on `http://localhost:3000`

## Project: PlanEdu

PlanEdu is a comprehensive education discovery platform helping students find the right colleges, courses, and career paths.

## API Endpoints

### Health Check
```
GET /health
```

### Authentication Module

| Endpoint | Method | Description | Auth Required |
|----------|--------|-------------|---------------|
| `/api/v1/auth/register` | POST | Register new user | No |
| `/api/v1/auth/verify-email` | POST | Verify email with OTP | No |
| `/api/v1/auth/login` | POST | User login | No |
| `/api/v1/auth/logout` | POST | User logout | Yes |
| `/api/v1/auth/forgot-password` | POST | Request password reset | No |
| `/api/v1/auth/reset-password` | POST | Reset password | No |
| `/api/v1/auth/me` | GET | Get current user profile | Yes |

### College Module

| Endpoint | Method | Description | Auth Required |
|----------|--------|-------------|---------------|
| `/api/v1/colleges` | GET | Get all colleges (with filters) | No |
| `/api/v1/colleges/:slug` | GET | Get college by slug | No |
| `/api/v1/colleges/:college_id/reviews` | GET | Get college reviews | No |

## API Examples

### 1. Register User
```bash
curl -X POST http://localhost:3000/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "student@example.com",
    "password": "SecurePass123",
    "user_type": "student",
    "first_name": "Rahul",
    "last_name": "Kumar"
  }'
```

### 2. Login
```bash
curl -X POST http://localhost:3000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "student@example.com",
    "password": "SecurePass123"
  }'
```

### 3. Get Colleges
```bash
curl "http://localhost:3000/api/v1/colleges?city=Mumbai&min_rating=4.0&page=1&limit=20"
```

### 4. Search Colleges
```bash
curl "http://localhost:3000/api/v1/colleges?search=IIT&sort_by=rating"
```

### 5. Get College Details
```bash
curl "http://localhost:3000/api/v1/colleges/iit-bombay"
```

### 6. Protected Endpoint (with JWT)
```bash
curl -X GET http://localhost:3000/api/v1/auth/me \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## Database

The API connects to PostgreSQL database `collegedunia_db` with 73 tables across 4 schemas:

- **public**: 45 tables (users, colleges, courses, reviews, etc.)
- **geo_master**: 3 tables (countries, states, cities)
- **discovery**: 20 tables (applications, facilities, SEO metadata)
- **analytics**: 5 tables (leads, counselling sessions, user activity)

## Error Handling

All errors follow a consistent format:

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [...]
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

**Error Codes:**
- `400` - VALIDATION_ERROR
- `401` - UNAUTHORIZED
- `403` - FORBIDDEN
- `404` - NOT_FOUND
- `409` - CONFLICT
- `500` - INTERNAL_ERROR

## Testing with Postman

Import the Postman collection from `postman/PlanEdu_API.postman_collection.json`

The collection includes:
- Pre-configured requests for all endpoints
- Environment variables
- Authentication setup
- Example request bodies

## Security Features

- **Helmet**: Security headers
- **CORS**: Cross-origin resource sharing
- **bcrypt**: Password hashing (10 salt rounds)
- **JWT**: Secure token-based authentication
- **Input Validation**: express-validator
- **SQL Injection Prevention**: Parameterized queries
- **Rate Limiting**: TODO

## Development

### Code Style
- Use async/await for asynchronous operations
- Always use parameterized queries ($1, $2, etc.)
- Follow RESTful conventions
- Use meaningful variable names
- Add comments for complex logic

### Adding New Endpoints

1. Create controller in `src/controllers/`
2. Create route file in `src/routes/`
3. Add validators in `src/validators/`
4. Register route in `src/app.js`
5. Update Postman collection

## Troubleshooting

### Database Connection Error
```
Error: connect ECONNREFUSED 127.0.0.1:5432
```
**Solution:** Ensure PostgreSQL is running
```bash
PGPASSWORD="postgres" /Library/PostgreSQL/17/bin/pg_ctl status
```

### Port Already in Use
```
Error: listen EADDRINUSE: address already in use :::3000
```
**Solution:** Change PORT in `.env` or kill the process using port 3000
```bash
lsof -ti:3000 | xargs kill -9
```

### Invalid JWT Token
```
{"success": false, "error": {"code": "UNAUTHORIZED", "message": "Invalid or expired token"}}
```
**Solution:** Get a new token by logging in again

## Next Steps

- [ ] Add more modules (Courses, Exams, Reviews submission)
- [ ] Implement file upload for profile photos
- [ ] Add email sending for OTP
- [ ] Implement rate limiting
- [ ] Add caching with Redis
- [ ] Write unit tests
- [ ] Add API documentation (Swagger)
- [ ] Set up CI/CD

## License

ISC

## Author

PlanEdu Development Team
