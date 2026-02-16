# Seed Database – Airbnb System

## Overview

This script (`seed.sql`) populates the Airbnb-like database with **sample data** for:

- Users
- Properties
- Bookings
- Payments
- Reviews
- Messages

The sample data reflects realistic scenarios, including:

- Multiple users with different roles (guest, host)
- Properties associated with hosts
- Bookings with check-in/check-out dates
- Payments with different methods and statuses
- Reviews with ratings and comments
- Messages between users

## How to Run

1. Make sure the database and schema are already created (see `schema.sql` in database-script-0x01).  
2. Using PostgreSQL, run:

```bash
psql -U username -d database_name -f seed.sql
