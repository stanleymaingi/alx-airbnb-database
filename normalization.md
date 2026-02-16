# Database Normalization – Airbnb System (Up to 3NF)

## 1. Introduction

This document explains the normalization process applied to the Airbnb-like database design.  
The database has been analyzed and structured to satisfy First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF).

---

## 2. First Normal Form (1NF)

A table satisfies 1NF if:
- All attributes contain atomic (indivisible) values.
- There are no repeating groups.
- Each record is uniquely identifiable.

### Application:

- Each table has a primary key.
- No multi-valued attributes are stored.
- Fields such as phone_number and payment_method store single values.
- No arrays or lists are stored in a single column.

Result: The database satisfies 1NF.

---

## 3. Second Normal Form (2NF)

A table satisfies 2NF if:
- It is already in 1NF.
- All non-key attributes are fully dependent on the entire primary key.

### Application:

- All tables use single-column surrogate primary keys (e.g., user_id, property_id).
- There are no composite primary keys.
- Therefore, no partial dependencies exist.

Result: The database satisfies 2NF.

---

## 4. Third Normal Form (3NF)

A table satisfies 3NF if:
- It is in 2NF.
- There are no transitive dependencies.
- Non-key attributes depend only on the primary key.

### Analysis and Adjustments:

1. Property Table
   - Host details such as name and email are not stored in the Property table.
   - Only host_id is stored as a foreign key.
   - This prevents transitive dependency.

2. Booking Table
   - Property details are not duplicated in Booking.
   - Only property_id is stored.
   - total_price is stored instead of price_per_night to avoid redundancy.

3. Payment Table
   - Payment references booking_id.
   - No booking or user details are duplicated.

4. Review Table
   - Guest and property details are not duplicated.
   - Only foreign keys are stored.

Result: No transitive dependencies exist.

The database satisfies Third Normal Form (3NF).

---

## 5. Conclusion

The Airbnb database design:

- Eliminates redundancy
- Prevents update anomalies
- Maintains data integrity
- Supports scalability

The schema is fully normalized up to Third Normal Form (3NF).
