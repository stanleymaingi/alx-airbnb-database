# Database Schema – Airbnb System

## Overview

This directory contains the SQL Data Definition Language (DDL) script used to create the Airbnb-like relational database.

File included:

- schema.sql

## Features

The schema includes:

- Primary Keys (SERIAL)
- Foreign Key Constraints
- CHECK Constraints
- UNIQUE Constraints
- NOT NULL Constraints
- Performance Indexes
- ON DELETE CASCADE rules

## Tables Created

1. user
2. property
3. booking
4. payment
5. review
6. message

## How to Run

Using PostgreSQL:

```bash
psql -U username -d database_name -f schema.sql
