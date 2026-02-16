# Airbnb Database – Entity Relationship Diagram (ERD) Requirements

## 1. Overview

This document defines the entities, attributes, and relationships for an Airbnb-like relational database system.  
The design follows relational database best practices and enforces data integrity using primary keys, foreign keys, and appropriate constraints.

---

## 2. Entities and Attributes

### 2.1 User

Represents all platform users (guests, hosts, admins).

Attributes:

- user_id (PK)
- first_name (NOT NULL)
- last_name (NOT NULL)
- email (UNIQUE, NOT NULL)
- password_hash (NOT NULL)
- phone_number
- role (ENUM: guest, host, admin)
- created_at (NOT NULL)

Constraints:
- Email must be unique.
- Role is restricted to predefined values.

---

### 2.2 Property

Represents properties listed by hosts.

Attributes:

- property_id (PK)
- host_id (FK → User.user_id, NOT NULL)
- title (NOT NULL)
- description
- location (NOT NULL)
- price_per_night (NOT NULL)
- created_at (NOT NULL)

Constraints:
- host_id references a valid user.
- A host can own multiple properties.

---

### 2.3 Booking

Represents reservations made by guests.

Attributes:

- booking_id (PK)
- property_id (FK → Property.property_id, NOT NULL)
- guest_id (FK → User.user_id, NOT NULL)
- check_in_date (NOT NULL)
- check_out_date (NOT NULL)
- total_price (NOT NULL)
- status (ENUM: pending, confirmed, cancelled)
- created_at (NOT NULL)

Constraints:
- A booking must reference an existing property.
- A booking must reference an existing guest.
- Check-out date must be later than check-in date.

---

### 2.4 Payment

Represents payments made for bookings.

Attributes:

- payment_id (PK)
- booking_id (FK → Booking.booking_id, NOT NULL)
- amount (NOT NULL)
- payment_date (NOT NULL)
- payment_method (ENUM: card, paypal, mpesa)
- status (ENUM: pending, completed, failed)

Constraints:
- Each payment must reference a valid booking.
- One booking can have one or more payments.

---

### 2.5 Review

Represents feedback given by guests for properties.

Attributes:

- review_id (PK)
- property_id (FK → Property.property_id, NOT NULL)
- guest_id (FK → User.user_id, NOT NULL)
- rating (CHECK: 1–5)
- comment
- created_at (NOT NULL)

Constraints:
- A review must reference a valid property.
- A review must reference a valid guest.
- Rating must be between 1 and 5.

---

### 2.6 Message

Represents communication between users.

Attributes:

- message_id (PK)
- sender_id (FK → User.user_id, NOT NULL)
- receiver_id (FK → User.user_id, NOT NULL)
- message_body (NOT NULL)
- sent_at (NOT NULL)

Constraints:
- Both sender and receiver must exist in the User table.

---

## 3. Relationships and Cardinality

### 3.1 User – Property
- One User (host) can own multiple Properties.
- One Property belongs to exactly one User.
- Relationship type: 1:M

---

### 3.2 User – Booking
- One User (guest) can make multiple Bookings.
- Each Booking belongs to one User.
- Relationship type: 1:M

---

### 3.3 Property – Booking
- One Property can have multiple Bookings.
- Each Booking references one Property.
- Relationship type: 1:M

---

### 3.4 Booking – Payment
- One Booking can have one or more Payments.
- Each Payment belongs to one Booking.
- Relationship type: 1:M

---

### 3.5 User – Review
- One User can write multiple Reviews.
- Each Review belongs to one User.
- Relationship type: 1:M

---

### 3.6 Property – Review
- One Property can receive multiple Reviews.
- Each Review references one Property.
- Relationship type: 1:M

---

### 3.7 User – Message
- One User can send multiple Messages.
- One User can receive multiple Messages.
- Relationship type: 1:M (sender)
- Relationship type: 1:M (receiver)

---

## 4. Design Considerations

- All tables use surrogate primary keys.
- Foreign key constraints enforce referential integrity.
- ENUM and CHECK constraints enforce domain integrity.
- NOT NULL constraints prevent incomplete records.
- The design supports scalability and future feature expansion.

---

## 5. ER Diagram

The visual representation of this design is included in this directory as:

airbnb_erd.png
