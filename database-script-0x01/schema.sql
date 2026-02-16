-- =============================================
-- Airbnb Database Schema (DDL)
-- =============================================

-- Drop tables if they exist (for re-running script safely)
DROP TABLE IF EXISTS message CASCADE;
DROP TABLE IF EXISTS review CASCADE;
DROP TABLE IF EXISTS payment CASCADE;
DROP TABLE IF EXISTS booking CASCADE;
DROP TABLE IF EXISTS property CASCADE;
DROP TABLE IF EXISTS "user" CASCADE;

-- =============================================
-- USER TABLE
-- =============================================

CREATE TABLE "user" (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(20) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster email lookup
CREATE INDEX idx_user_email ON "user"(email);

-- =============================================
-- PROPERTY TABLE
-- =============================================

CREATE TABLE property (
    property_id SERIAL PRIMARY KEY,
    host_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    location VARCHAR(255) NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL CHECK (price_per_night > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_property_host
        FOREIGN KEY (host_id)
        REFERENCES "user"(user_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_property_host_id ON property(host_id);
CREATE INDEX idx_property_location ON property(location);

-- =============================================
-- BOOKING TABLE
-- =============================================

CREATE TABLE booking (
    booking_id SERIAL PRIMARY KEY,
    property_id INT NOT NULL,
    guest_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price >= 0),
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'confirmed', 'cancelled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_booking_property
        FOREIGN KEY (property_id)
        REFERENCES property(property_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_booking_guest
        FOREIGN KEY (guest_id)
        REFERENCES "user"(user_id)
        ON DELETE CASCADE,
    CONSTRAINT check_dates
        CHECK (check_out_date > check_in_date)
);

CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_booking_guest_id ON booking(guest_id);

-- =============================================
-- PAYMENT TABLE
-- =============================================

CREATE TABLE payment (
    payment_id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('card', 'paypal', 'mpesa')),
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'completed', 'failed')),
    CONSTRAINT fk_payment_booking
        FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_payment_booking_id ON payment(booking_id);

-- =============================================
-- REVIEW TABLE
-- =============================================

CREATE TABLE review (
    review_id SERIAL PRIMARY KEY,
    property_id INT NOT NULL,
    guest_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_review_property
        FOREIGN KEY (property_id)
        REFERENCES property(property_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_review_guest
        FOREIGN KEY (guest_id)
        REFERENCES "user"(user_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_review_property_id ON review(property_id);
CREATE INDEX idx_review_guest_id ON review(guest_id);

-- =============================================
-- MESSAGE TABLE
-- =============================================

CREATE TABLE message (
    message_id SERIAL PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_message_sender
        FOREIGN KEY (sender_id)
        REFERENCES "user"(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_message_receiver
        FOREIGN KEY (receiver_id)
        REFERENCES "user"(user_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_message_sender_id ON message(sender_id);
CREATE INDEX idx_message_receiver_id ON message(receiver_id);
