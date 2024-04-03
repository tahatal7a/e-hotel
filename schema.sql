
-- Implement a database schema for a hotel management system.

-- Create a database schema for a hotel management system.

CREATE TABLE IF NOT EXISTS hotel_chain(
    id_hotel_chain INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL UNIQUE,
    hotels_number INTEGER, 
    PRIMARY KEY (id_hotel_chain),
    CONSTRAINT chk_hotels_number CHECK (hotels_number >= 0)
);

CREATE TABLE IF NOT EXISTS office_address_hotel_chain(
    id INTEGER NOT NULL,
    street_number INTEGER NOT NULL,
    street_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    postal_code VARCHAR(10) NOT NULL UNIQUE,
    country VARCHAR(255) NOT NULL,
    id_hotel_chain INTEGER NOT NULL,
    PRIMARY KEY (id), 
    FOREIGN KEY (id_hotel_chain) REFERENCES hotel_chain(id_hotel_chain),
    CONSTRAINT chk_postal_code_format CHECK (
        postal_code ~* '^\d{5}(-\d{4})?$' -- US ZIP code format
        OR postal_code ~* '^[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$' -- Canadian postal code format
        OR postal_code ~* '^([0-9]{5}|[0-9]{5}-[0-9]{4}|[0-9]{3}-[0-9]{3})$' -- Mexican postal code format
    ),
    CONSTRAINT chk_country CHECK (country in ('US', 'CA', 'MX')),
    CONSTRAINT chk_id_format CHECK (
        (country = 'US') -- US state format
        OR (country = 'CA') -- Canadian province format
        OR (country = 'MX') -- Mexican state format
    )
);

CREATE TABLE IF NOT EXISTS emails_hotel_chain(
    email VARCHAR(255) NOT NULL,
    id_hotel_chain INTEGER NOT NULL,
    PRIMARY KEY(email),
    FOREIGN KEY (id_hotel_chain) REFERENCES hotel_chain(id_hotel_chain),
    CONSTRAINT chk_email_format CHECK (
        email ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    )
);

CREATE TABLE IF NOT EXISTS phone_number_hotel_chain(
    phone_number VARCHAR(13) NOT NULL,
    id_hotel_chain INTEGER NOT NULL,
    PRIMARY KEY(phone_number), 
    FOREIGN KEY (id_hotel_chain) REFERENCES hotel_chain(id_hotel_chain)
);

CREATE TABLE IF NOT EXISTS hotel(
    id_hotel INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    rooms_number INTEGER NOT NULL,
    start_number INTEGER NOT NULL CHECK(start_number BETWEEN 1 AND 5),
    email VARCHAR(255) NOT NULL, 
    street_number INTEGER NOT NULL,
    street_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    postal_code VARCHAR(10) NOT NULL UNIQUE,
    country VARCHAR(255) NOT NULL, 
    id_hotel_chain INTEGER NOT NULL,
    PRIMARY KEY(id_hotel),
    FOREIGN KEY (id_hotel_chain) REFERENCES hotel_chain(id_hotel_chain),
    CONSTRAINT chk_postal_code_format CHECK (
        postal_code ~* '^\d{5}(-\d{4})?$' -- US ZIP code format
        OR postal_code ~* '^[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$' -- Canadian postal code format
        OR postal_code ~* '^([0-9]{5}|[0-9]{5}-[0-9]{4}|[0-9]{3}-[0-9]{3})$' -- Mexican postal code format
    ),
    CONSTRAINT chk_email_format CHECK (
        email ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    ),
    CONSTRAINT chk_rooms_number CHECK (rooms_number >= 0),
    CONSTRAINT chk_start_number CHECK (start_number BETWEEN 1 AND 5),
    CONSTRAINT chk_country CHECK (country in ('US', 'CA', 'MX')),
    CONSTRAINT chk_id_format CHECK (
        (country = 'US') -- US state format
        OR (country = 'CA') -- Canadian province format
        OR (country = 'MX') -- Mexican state format
    )
);


CREATE TABLE IF NOT EXISTS phone_number_hotel(
    phone_number VARCHAR(13) NOT NULL,
    id_hotel INTEGER NOT NULL,
    PRIMARY KEY(phone_number),
    FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel)
);

CREATE TABLE IF NOT EXISTS employee(
    sin_employee VARCHAR(12) NOT NULL, 
    firstname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    role VARCHAR(255), 
    street_number INTEGER NOT NULL,
    street_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    country VARCHAR(255) NOT NULL,
    id_hotel INTEGER,
    PRIMARY KEY (sin_employee),
    FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel),
    CONSTRAINT chk_postal_code_format CHECK (
        postal_code ~* '^\d{5}(-\d{4})?$' -- US ZIP code format
        OR postal_code ~* '^[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$' -- Canadian postal code format
        OR postal_code ~* '^([0-9]{5}|[0-9]{5}-[0-9]{4}|[0-9]{3}-[0-9]{3})$' -- Mexican postal code format
    ),
    CONSTRAINT chk_role CHECK (
        role in ('Manager', 'Receptionist', 'Housekeeper', 'Maintenance', 'Security', 'Cook', 'Waiter', 'Concierge', 'Valet', 'Driver', 'Spa therapist', 'Fitness instructor', 'Lifeguard', 'Accountant', 'Human resources', 'Marketing', 'Customer service')
    ),
    CONSTRAINT chk_country CHECK (country in ('US', 'CA', 'MX')),
    CONSTRAINT chk_id_format CHECK (
        (country = 'US') -- US state format
        OR (country = 'CA') -- Canadian province format
        OR (country = 'MX') -- Mexican state format
    ), 
    CONSTRAINT chk_sin_employee_format CHECK (
        sin_employee ~* '^\d{3}-\d{3}-\d{3}$'
    )

);

CREATE TABLE IF NOT EXISTS customer(
    sin_customer VARCHAR(12) NOT NULL,
    firstname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    check_in_date Date NOT NULL,
    street_number INTEGER NOT NULL,
    street_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    country VARCHAR(255) NOT NULL,
    PRIMARY KEY (sin_customer),
    CONSTRAINT chk_postal_code_format CHECK (
        postal_code ~* '^\d{5}(-\d{4})?$' -- US ZIP code format
        OR postal_code ~* '^[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$' -- Canadian postal code format
        OR postal_code ~* '^([0-9]{5}|[0-9]{5}-[0-9]{4}|[0-9]{3}-[0-9]{3})$' -- Mexican postal code format
    ),
    CONSTRAINT chk_country CHECK (country in ('US', 'CA', 'MX')),
    CONSTRAINT chk_id_format CHECK (
        (country = 'US') -- US state format
        OR (country = 'CA') -- Canadian province format
        OR (country = 'MX') -- Mexican state format
    ),
    CONSTRAINT chk_check_in_date CHECK (check_in_date >= CURRENT_DATE),
    CONSTRAINT chk_sin_customer_format CHECK (
        sin_customer ~* '^\d{3}-\d{3}-\d{3}$'
    )

);

CREATE TABLE IF NOT EXISTS room(
    id_room INTEGER NOT NULL,
    room_number INTEGER NOT NULL,
    availability BOOLEAN NOT NULL,
    price NUMERIC(8, 2) NOT NULL CHECK(price > 0),
    view VARCHAR(255) NOT NULL,
    extensible BOOLEAN NOT NULL,
    capacity VARCHAR(255) NOT NULL,
    id_hotel INTEGER NOT NULL,
    PRIMARY KEY (id_room),
    FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel),
    CONSTRAINT chk_room_number CHECK (room_number >= 0),
    CONSTRAINT chk_price CHECK (price > 0),
    CONSTRAINT chk_capacity CHECK (capacity in ('Simple', 'Double', 'Triple', 'Quadruple', 'Suite', 'Penthouse')),
    CONSTRAINT chk_view CHECK (view in ('Sea', 'Mountain', 'City', 'Garden', 'Pool', 'Lake', 'Forest', 'River', 'Park', 'Courtyard', 'Street', 'Other'))
);

CREATE TABLE IF NOT EXISTS booking(
    id_booking INTEGER NOT NULL,
    sin_customer VARCHAR(18) NOT NULL,
    id_room INTEGER NOT NULL,
    start_date Date NOT NULL,
    end_date Date NOT NULL,
    PRIMARY KEY(id_booking, sin_customer, id_room),
    FOREIGN KEY (sin_customer) REFERENCES customer(sin_customer),
    FOREIGN KEY (id_room) REFERENCES room(id_room),
    CONSTRAINT chk_start_date CHECK (start_date >= CURRENT_DATE),
    CONSTRAINT chk_end_date CHECK (end_date > start_date)
);

/*
    To finally archive to comply with this requirement: We need to store in the database 
    the history of the bookings and rentals (archives), 
    but we don't need to store the archieve 
    payments. Information about an old reservation/room rental 
    (archived) must exist in the database, even if the room information 
    they no longer exist in the database.
*/

-- Archive tables

CREATE TABLE IF NOT EXISTS booking_archieve(
    id_booking INTEGER NOT NULL,
    sin_customer VARCHAR(18) NOT NULL,
    id_room INTEGER NOT NULL,
    start_date Date NOT NULL,
    end_date Date NOT NULL,
    PRIMARY KEY(id_booking),
    CONSTRAINT chk_end_date CHECK (end_date > start_date)
);

CREATE TABLE IF NOT EXISTS rental(
    id_rental INTEGER NOT NULL,
    sin_customer VARCHAR(18) NOT NULL,
    id_room INTEGER NOT NULL,
    start_date Date NOT NULL,
    end_date Date NOT NULL,
    PRIMARY KEY(id_rental),
    FOREIGN KEY (sin_customer) REFERENCES customer(sin_customer),
    FOREIGN KEY (id_room) REFERENCES room(id_room),
    CONSTRAINT chk_end_date CHECK (end_date > start_date)
);

/*
    To finally archive to comply with this requirement: We need to store in the database 
    the history of the bookings and rentals (archives), 
    but we don't need to store the archieve 
    payments. Information about an old reservation/room rental 
    (archived) must exist in the database, even if the room information 
    they no longer exist in the database.
*/

-- Archive tables

CREATE TABLE IF NOT EXISTS rental_archieve(
	id_rental INTEGER NOT NULL,
    sin_customer VARCHAR(18) NOT NULL,
    id_room INTEGER NOT NULL,
    start_date Date NOT NULL,
    end_date Date NOT NULL,
    PRIMARY KEY(id_rental),
    CONSTRAINT chk_end_date CHECK (end_date > start_date)
);

CREATE TABLE IF NOT EXISTS payment (
    id_payment SERIAL PRIMARY KEY,
    id_rental INTEGER NOT NULL,
    payment_date DATE NOT NULL,
    amount NUMERIC(8, 2) NOT NULL,
    payment_method VARCHAR(100) NOT NULL,
    payment_status VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_rental) REFERENCES rental(id_rental),
    CONSTRAINT chk_payment_date CHECK (payment_date >= CURRENT_DATE),
    CONSTRAINT chk_amount CHECK (amount > 0),
    CONSTRAINT chk_payment_method CHECK (payment_method in ('Credit card', 'Debit card', 'Cash', 'Check', 'Bank transfer')),
    CONSTRAINT chk_payment_status CHECK (payment_status in ('Paid', 'Pending', 'Refunded'))
);

CREATE TABLE IF NOT EXISTS commodity(
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(name)
);

CREATE TABLE IF NOT EXISTS room_commodity(
    id_room INTEGER NOT NULL,
    commodity_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id_room, commodity_name),
    FOREIGN KEY (id_room) REFERENCES room(id_room),
    FOREIGN KEY (commodity_name) REFERENCES commodity(name)
);

CREATE TABLE IF NOT EXISTS problem(
    id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL UNIQUE,
    description VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS room_problem(
    id_room INTEGER NOT NULL,
    id_problem INTEGER NOT NULL,
    PRIMARY KEY(id_room, id_problem),
    FOREIGN KEY (id_room) REFERENCES room(id_room),
    FOREIGN KEY (id_problem) REFERENCES problem(id)
);



-- Alterations

-- Add a column sin_manager to the hotel table to store the SIN of the hotel manager

ALTER TABLE IF EXISTS hotel
ADD COLUMN sin_manager VARCHAR(12);

-- Add a foreign key constraint to the sin_manager column in the hotel table

ALTER TABLE IF EXISTS hotel
ADD CONSTRAINT fk_sin_manager
FOREIGN KEY (sin_manager) REFERENCES employee(sin_employee);

ALTER TABLE IF EXISTS hotel
ADD CONSTRAINT chk_sin_manager_format CHECK (
    sin_manager ~* '^\d{3}-\d{3}-\d{3}$'
);


-- Prohibit the deletion of a hotel chain if it still has hotels

ALTER TABLE hotel
ADD CONSTRAINT fk_hotel_chain
FOREIGN KEY (id_hotel_chain) REFERENCES hotel_chain(id_hotel_chain) ON DELETE RESTRICT;

-- Prohibit the deletion of a hotel if it still has rooms
ALTER TABLE room
ADD CONSTRAINT fk_hotel
FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel) ON DELETE RESTRICT;


-- Delete all hotel chain information when a hotel chain is deleted
ALTER TABLE IF EXISTS hotel
DROP CONSTRAINT IF EXISTS fk_hotel_chain;

ALTER TABLE hotel
ADD CONSTRAINT fk_hotel_chain
FOREIGN KEY (id_hotel_chain) REFERENCES hotel_chain(id_hotel_chain) ON DELETE CASCADE;

-- Delete all room information when a hotel is deleted

ALTER TABLE IF EXISTS room
DROP CONSTRAINT IF EXISTS fk_hotel;

ALTER TABLE room
ADD CONSTRAINT fk_hotel
FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel) ON DELETE CASCADE;


-- Triggers

-- Déclencheur pour incrémenter hotels_number lors de l'insertion d'un nouvel hôtel
-- Création du déclencheur pour l'incrémentation
CREATE OR REPLACE FUNCTION increment_hotels_number()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE hotel_chain
    SET hotels_number = hotels_number + 1
    WHERE id_hotel_chain = NEW.id_hotel_chain;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Création du déclencheur pour la décrémentation
CREATE OR REPLACE FUNCTION decrement_hotels_number()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE hotel_chain
    SET hotels_number = hotels_number - 1
    WHERE id_hotel_chain = OLD.id_hotel_chain;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Association des déclencheurs aux opérations d'insertion et de suppression
CREATE TRIGGER increment_hotels_number_trigger
AFTER INSERT ON hotel
FOR EACH ROW
EXECUTE FUNCTION increment_hotels_number();

CREATE TRIGGER decrement_hotels_number_trigger
AFTER DELETE ON hotel
FOR EACH ROW
EXECUTE FUNCTION decrement_hotels_number();


-- Création du déclencheur pour l'incrémentation
CREATE OR REPLACE FUNCTION increment_rooms_number()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE hotel
    SET rooms_number = rooms_number + 1
    WHERE id_hotel = NEW.id_hotel;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Création du déclencheur pour la décrémentation
CREATE OR REPLACE FUNCTION decrement_rooms_number()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE hotel
    SET rooms_number = rooms_number - 1
    WHERE id_hotel = OLD.id_hotel;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Association des déclencheurs aux opérations d'insertion et de suppression
CREATE TRIGGER increment_rooms_trigger
AFTER INSERT ON room
FOR EACH ROW
EXECUTE FUNCTION increment_rooms_number();

CREATE TRIGGER decrement_rooms_trigger
AFTER DELETE ON room
FOR EACH ROW
EXECUTE FUNCTION decrement_rooms_number();

-- Create a trigger to update the availability of a room when a booking is made
CREATE OR REPLACE FUNCTION update_room_availability()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE room
    SET availability = FALSE
    WHERE id_room = NEW.id_room;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_room_availability_trigger
AFTER INSERT ON booking
FOR EACH ROW
EXECUTE FUNCTION update_room_availability();


-- Create a trigger to archive bookings
CREATE FUNCTION archieve_booking()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO booking_archieve (id_booking, sin_customer, id_room, start_date, end_date)
    VALUES (NEW.id_booking, NEW.sin_customer, NEW.id_room, NEW.start_date, NEW.end_date);
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach the trigger to the booking table
CREATE TRIGGER booking_archiving_trigger
AFTER INSERT ON booking
FOR EACH ROW
EXECUTE FUNCTION archieve_booking();

-- Create a trigger to archive rentals
CREATE FUNCTION archieve_rental()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO rental_archieve (id_rental, sin_customer, id_room, start_date, end_date)
    VALUES (NEW.id_rental, NEW.sin_customer, NEW.id_room, NEW.start_date, NEW.end_date);
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach the trigger to the rental table
CREATE TRIGGER rental_archiving_trigger
AFTER INSERT ON rental
FOR EACH ROW
EXECUTE FUNCTION archieve_rental();

-- Create a trigger to update the availability of a room when a rental is made
CREATE OR REPLACE FUNCTION update_room_availability_rental()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE room
    SET availability = FALSE
    WHERE id_room = NEW.id_room;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_room_availability_rental_trigger
AFTER INSERT ON rental
FOR EACH ROW
EXECUTE FUNCTION update_room_availability_rental();

-- Create a function to check room availability before insertion
CREATE OR REPLACE FUNCTION check_room_availability()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM room WHERE id_room = NEW.id_room AND availability = TRUE
    ) THEN
        RAISE EXCEPTION 'The room is not available.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach the trigger to the booking table
CREATE TRIGGER room_availability_trigger
BEFORE INSERT ON booking
FOR EACH ROW
EXECUTE FUNCTION check_room_availability();

-- Function to update room availability
CREATE OR REPLACE FUNCTION update_room_availability() RETURNS TRIGGER AS $$
BEGIN
    UPDATE room SET availability = TRUE WHERE id_room = NEW.id_room AND CURRENT_DATE > NEW.end_date;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger after booking update
CREATE TRIGGER update_availability_after_booking
AFTER UPDATE ON booking
FOR EACH ROW
EXECUTE FUNCTION update_room_availability();

-- Trigger after rental update
CREATE TRIGGER update_availability_after_rental
AFTER UPDATE ON rental
FOR EACH ROW
EXECUTE FUNCTION update_room_availability();




-- Insertion
-- Inserting hotel chain
INSERT INTO hotel_chain (id_hotel_chain, name, hotels_number)
VALUES
    (1, 'Marriott International', 0),
    (2, 'Hilton Worldwide Holdings Inc.', 0),
    (3, 'InterContinental Hotels Group', 0),
    (4, 'AccorHotels', 0),
    (5, 'Wyndham Hotels & Resorts', 0);
-- Inserting office addresses for each hotel chain in North America
INSERT INTO office_address_hotel_chain (id, street_number, street_name, city, postal_code, country, id_hotel_chain)
VALUES
    -- Marriott International (US)
    (1, 123, 'Main Street', 'New York', '10001', 'US', 1),
    
    -- Hilton Worldwide Holdings Inc. (US)
    (2, 456, 'Broadway', 'Los Angeles', '90001', 'US', 2),
    
    -- InterContinental Hotels Group (CA)
    (3, 789, 'Market Street', 'Toronto', 'M5V 3P5', 'CA', 3),
    
    -- AccorHotels (CA)
    (4, 101, 'Rue de Rivoli', 'Montreal', 'H2Y 2E3', 'CA', 4),
    
    -- Wyndham Hotels & Resorts (MX)
    (5, 555, 'Avenida Juárez', 'Mexico City', '06000', 'MX', 5);

-- Inserting email addresses for each hotel chain
INSERT INTO emails_hotel_chain (email, id_hotel_chain)
VALUES
    -- Marriott International
    ('info@marriott.com', 1),
    
    -- Hilton Worldwide Holdings Inc.
    ('info@hilton.com', 2),
    
    -- InterContinental Hotels Group
    ('info@ihg.com', 3),
    
    -- AccorHotels
    ('info@accorhotels.com', 4),
    
    -- Wyndham Hotels & Resorts
    ('info@wyndham.com', 5);

-- Inserting phone numbers for each hotel chain
INSERT INTO phone_number_hotel_chain (phone_number, id_hotel_chain)
VALUES
    -- Marriott International 
    ('+18005551234', 1),
    
    -- Hilton Worldwide Holdings Inc. 
    ('+1888555-5678', 2),
    
    -- InterContinental Hotels Group 
    ('+18775559876', 3),
    
    -- AccorHotels
    ('+15145551234', 4),
    
    -- Wyndham Hotels & Resorts
    ('+525555555555', 5);

-- Inserting hotels
-- Hotel data for Marriott International in New York, USA
INSERT INTO hotel (id_hotel, name, rooms_number, start_number, email, street_number, street_name, city, postal_code, country, id_hotel_chain) VALUES
(1, 'Marriott Marquis', 0, 5, 'info@marriottmarquis.com', 1535, 'Broadway', 'New York', '10036', 'US', 1),
(2, 'Marriott Downtown', 0, 4, 'info@marriottdowntown.com', 85, 'West St', 'New York', '10006', 'US', 1),
(3, 'Marriott Courtyard Times Square', 0, 3, 'info@courtyardtimessquare.com', 114, 'West 40th St', 'New York', '10200', 'US', 1),
(4, 'Marriott Residence Inn Central Park', 0, 2, 'info@residenceinncentralpark.com', 1717, 'Broadway', 'New York', '10019', 'US', 1),
(5, 'Marriott Fairfield Inn & Suites Manhattan/Times Square', 0, 1, 'info@fairfieldinnmanhattan.com', 330, 'West 40th St', 'New York', '10018', 'US', 1),
(6, 'Marriott Renaissance New York Midtown Hotel', 0, 5, 'info@renaissancenymidtown.com', 218, 'West 35th St', 'New York', '10001', 'US', 1),
(7, 'Marriott SpringHill Suites Times Square', 0, 4, 'info@springhilltimestsquare.com', 135, 'West 37th St', 'New York', '10021', 'US', 1),
(8, 'Marriott Residence Inn World Trade Center', 0, 3, 'info@residenceinnworldtradecenter.com', 170, 'Broadway', 'New York', '10007', 'US', 1);

-- Hotel data for Hilton Worldwide Holdings Inc. in Los Angeles, USA
INSERT INTO hotel (id_hotel, name, rooms_number, start_number, email, street_number, street_name, city, postal_code, country, id_hotel_chain) VALUES
(9, 'Hilton Los Angeles Airport', 0, 5, 'info@hiltonlaairport.com', 5711, 'W Century Blvd', 'Los Angeles', '90145', 'US', 2),
(10, 'Hilton Checkers Los Angeles', 0, 4, 'info@hiltoncheckersla.com', 535, 'South Grand Ave', 'Los Angeles', '90071', 'US', 2),
(11, 'Hilton Los Angeles/Universal City', 0, 3, 'info@hiltonlauniversal.com', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 2),
(12, 'Hilton Garden Inn Los Angeles/Hollywood', 0, 2, 'info@hiltongardenhollywood.com', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 2),
(13, 'Homewood Suites by Hilton Los Angeles International Airport', 0, 1, 'info@homewoodlaairport.com', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 2),
(14, 'DoubleTree by Hilton Hotel Los Angeles Downtown', 0, 5, 'info@doubletreedowntownla.com', 120, 'South Los Angeles St', 'Los Angeles', '90012', 'US', 2),
(15, 'Embassy Suites by Hilton Los Angeles International Airport South', 0, 4, 'info@embassysuiteslaairport.com', 1440, 'East Imperial Ave', 'Los Angeles', '90021', 'US', 2),
(16, 'Hampton Inn & Suites Los Angeles/Sherman Oaks', 0, 3, 'info@hamptoninnshermanoaks.com', 5638, 'Sepulveda Blvd', 'Los Angeles', '91411', 'US', 2);

-- Hotel data for InterContinental Hotels Group in Toronto, Canada
INSERT INTO hotel (id_hotel, name, rooms_number, start_number, email, street_number, street_name, city, postal_code, country, id_hotel_chain) VALUES
(17, 'InterContinental Toronto Centre', 0, 5, 'info@ictorontocentre.com', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 3),
(18, 'InterContinental Toronto Yorkville', 0, 4, 'info@ictorontoyorkville.com', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 3),
(19, 'Holiday Inn Toronto Downtown Centre', 0, 3, 'info@holidayinndowntowncentre.com', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 3),
(20, 'Crowne Plaza Toronto Airport', 0, 2, 'info@crowneplazatorontoairport.com', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 3),
(21, 'Holiday Inn Express Toronto Downtown', 0, 1, 'info@hiexpressdowntowntoronto.com', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 3),
(22, 'InterContinental Toronto Midtown', 0, 5, 'info@ictorontomidtown.com', 220, 'Bloor St W', 'Toronto', 'M5S 1W2', 'CA', 3),
(23, 'Holiday Inn Toronto Bloor-Yorkville', 0, 4, 'info@holidayinnbloor-yorkville.com', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 3),
(24, 'Staybridge Suites Toronto', 0, 3, 'info@staybridgetoronto.com', 20, 'Steeles Ave E', 'Toronto', 'M2M 3Y1', 'CA', 3);

-- Hotel data for AccorHotels in Montreal, Canada

INSERT INTO hotel (id_hotel, name, rooms_number, start_number, email, street_number, street_name, city, postal_code, country, id_hotel_chain) VALUES
(25, 'Fairmont The Queen Elizabeth', 0, 5, 'info@fairmontqueenelizabeth.com', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 4),
(26, 'Novotel Montreal Centre', 0, 4, 'info@novotelmontrealcentre.com', 1180, 'Rue de la Montagne', 'Montreal', 'H3G 1Z1', 'CA', 4),
(27, 'Mercure Montreal Centre-Ville', 0, 3, 'info@mercuremontrealcentre.com', 990, 'Boulevard de Maisonneuve O', 'Montreal', 'H3A 1M5', 'CA', 4),
(28, 'ibis Montreal Centre-Ville', 0, 2, 'info@ibismontrealcentre.com', 22, 'Rue Ste-Catherine E', 'Montreal', 'H2X 1K4', 'CA', 4),
(29, 'Hotel Faubourg Montreal', 0, 1, 'info@hotelfaubourgmontreal.com', 155, 'Rue René-Lévesque E', 'Montreal', 'H2X 3Z8', 'CA', 4),
(30, 'Sofitel Montreal Golden Mile', 0, 5, 'info@sofitelmontrealgoldenmile.com', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 4),
(31, 'Novotel Montreal Airport', 0, 4, 'info@novotelmontrealairport.com', 2599, 'Boulevard Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 4),
(32, 'ibis Styles Montreal Centre-Ville', 0, 3, 'info@ibisstylesmontrealcentre.com', 1415, 'Rue Saint-Hubert', 'Montreal', 'H2L 3Y9', 'CA', 4);

-- Hotel data for Wyndham Hotels & Resorts in Mexico City, Mexico
INSERT INTO hotel (id_hotel, name, rooms_number, start_number, email, street_number, street_name, city, postal_code, country, id_hotel_chain) VALUES
(33, 'Wyndham Grand Mexico City Reforma', 0, 5, 'info@wyndhamgrandmexicocity.com', 5, 'Av. Paseo de la Reforma', 'Mexico City', '16030', 'MX', 5),
(34, 'Wyndham Garden Mexico City Polanco', 0, 4, 'info@wyndhamgardenmexicocitypolanco.com', 318, 'Calle Cicerón', 'Mexico City', '11560', 'MX', 5),
(35, 'Wyndham Garden Mexico City Centro Historico', 0, 3, 'info@wyndhamgardenmexicocityhistorico.com', 61, 'Av. Juárez', 'Mexico City', '06010', 'MX', 5),
(36, 'Wyndham Garden Mexico City Santa Fe', 0, 2, 'info@wyndhamgardenmexicocitysantafe.com', 25, 'Av. Santa Fe', 'Mexico City', '01210', 'MX', 5),
(37, 'Ramada by Wyndham Mexico City Reforma', 0, 1, 'info@ramadamexicocityreforma.com', 145, 'Av. Paseo de la Reforma', 'Mexico City', '06030', 'MX', 5),
(38, 'TRYP by Wyndham Mexico City World Trade Center Area Hotel', 0, 5, 'info@trypmexicocityworldtradecenter.com', 22, 'Av. Insurgentes Sur', 'Mexico City', '06140', 'MX', 5),
(39, 'Microtel Inn & Suites by Wyndham Mexico City', 0, 4, 'info@microtelinnmexicocity.com', 7, 'Av. Rio Mixcoac', 'Mexico City', '03810', 'MX', 5),
(40, 'La Quinta by Wyndham Mexico City', 0, 3, 'info@laquintamexicocity.com', 36, 'Av. Paseo de la Reforma', 'Mexico City', '06500', 'MX', 5);

-- Inserting phone numbers for each hotel
INSERT INTO phone_number_hotel (phone_number, id_hotel) VALUES
('+15551234567', 1),   -- Marriott Marquis
('+15552345678', 2),   -- Marriott Downtown
('+15553456789', 3),   -- Marriott Courtyard Times Square
('+15554567890', 4),   -- Marriott Residence Inn Central Park
('+15555678901', 5),   -- Marriott Fairfield Inn & Suites Manhattan/Times Square
('+15556789012', 6),   -- Marriott Renaissance New York Midtown Hotel
('+15557890123', 7),   -- Marriott SpringHill Suites Times Square
('+15558901234', 8),   -- Marriott Residence Inn World Trade Center
('+15559012345', 9),   -- Hilton Los Angeles Airport
('+15560123456', 10),  -- Hilton Checkers Los Angeles
('+15561234567', 11),  -- Hilton Los Angeles/Universal City
('+15562345678', 12),  -- Hilton Garden Inn Los Angeles/Hollywood
('+15563456789', 13),  -- Homewood Suites by Hilton Los Angeles International Airport
('+15564567890', 14),  -- DoubleTree by Hilton Hotel Los Angeles Downtown
('+15565678901', 15),  -- Embassy Suites by Hilton Los Angeles International Airport South
('+15566789012', 16),  -- Hampton Inn & Suites Los Angeles/Sherman Oaks
('+15567890123', 17),  -- InterContinental Toronto Centre
('+15568901234', 18),  -- InterContinental Toronto Yorkville
('+15569012345', 19),  -- Holiday Inn Toronto Downtown Centre
('+15570123456', 20),  -- Crowne Plaza Toronto Airport
('+15571234567', 21),  -- Holiday Inn Express Toronto Downtown
('+15572345678', 22),  -- InterContinental Toronto Midtown
('+15573456789', 23),  -- Holiday Inn Toronto Bloor-Yorkville
('+15574567890', 24),  -- Staybridge Suites Toronto
('+15575678901', 25),  -- Fairmont The Queen Elizabeth
('+15576789012', 26),  -- Novotel Montreal Centre
('+15577890123', 27),  -- Mercure Montreal Centre-Ville
('+15578901234', 28),  -- ibis Montreal Centre-Ville
('+15579012345', 29),  -- Hotel Faubourg Montreal
('+15580123456', 30),  -- Sofitel Montreal Golden Mile
('+15581234567', 31),  -- Novotel Montreal Airport
('+15582345678', 32),  -- ibis Styles Montreal Centre-Ville
('+525512345678', 33), -- Wyndham Grand Mexico City Reforma
('+525523456789', 34), -- Wyndham Garden Mexico City Polanco
('+525534567890', 35), -- Wyndham Garden Mexico City Centro Historico
('+525545678901', 36), -- Wyndham Garden Mexico City Santa Fe
('+525556789012', 37), -- Ramada by Wyndham Mexico City Reforma
('+525567890123', 38), -- TRYP by Wyndham Mexico City World Trade Center Area Hotel
('+525578901234', 39), -- Microtel Inn & Suites by Wyndham Mexico City
('+525589012345', 40); -- La Quinta by Wyndham Mexico City

-- Inserting employees

-- Inserting employees for Marriott Marquis

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-000', 'John', 'Doe', 'Manager', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-001', 'Jane', 'Doe', 'Receptionist', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-002', 'James', 'Smith', 'Housekeeper', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-003', 'Emily', 'Johnson', 'Maintenance', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-004', 'Michael', 'Williams', 'Security', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-005', 'Jessica', 'Brown', 'Cook', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-006', 'Daniel', 'Miller', 'Waiter', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-007', 'Olivia', 'Davis', 'Concierge', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-008', 'Liam', 'Garcia', 'Valet', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-009', 'Sophia', 'Rodriguez', 'Driver', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-010', 'Ava', 'Martinez', 'Spa therapist', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-011', 'Noah', 'Hernandez', 'Fitness instructor', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-012', 'Isabella', 'Lopez', 'Lifeguard', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-013', 'Mason', 'Gonzalez', 'Accountant', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-014', 'Ethan', 'Wilson', 'Human resources', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-015', 'Amelia', 'Anderson', 'Marketing', 1535, 'Broadway', 'New York', '10036', 'US', 1),
('000-000-016', 'Elijah', 'Taylor', 'Customer service', 1535, 'Broadway', 'New York', '10036', 'US', 1);

UPDATE hotel
SET sin_manager = '000-000-000'
WHERE id_hotel = 1;

-- Inserting employees for Marriott Downtown

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-017', 'William', 'Thomas', 'Manager', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-018', 'Oliver', 'Jackson', 'Receptionist', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-019', 'Evelyn', 'White', 'Housekeeper', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-020', 'Harper', 'Harris', 'Maintenance', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-021', 'Ethan', 'Martin', 'Security', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-022', 'Avery', 'Thompson', 'Cook', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-023', 'Scarlett', 'Garcia', 'Waiter', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-024', 'Madison', 'Martinez', 'Concierge', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-025', 'Liam', 'Robinson', 'Valet', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-026', 'Aria', 'Clark', 'Driver', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-027', 'Ella', 'Rodriguez', 'Spa therapist', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-028', 'Logan', 'Lewis', 'Fitness instructor', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-029', 'Aiden', 'Lee', 'Lifeguard', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-030', 'Chloe', 'Walker', 'Accountant', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-031', 'Mia', 'Hall', 'Human resources', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-032', 'Zoey', 'Young', 'Marketing', 85, 'West St', 'New York', '10006', 'US', 2),
('000-000-033', 'Mila', 'Allen', 'Customer service', 85, 'West St', 'New York', '10006', 'US', 2);

UPDATE hotel
SET sin_manager = '000-000-017'
WHERE id_hotel = 2;

-- Inserting employees for Marriott Courtyard Times Square

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-034', 'Luna', 'King', 'Manager', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-035', 'Leo', 'Wright', 'Receptionist', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-036', 'Hazel', 'Lopez', 'Housekeeper', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-037', 'Mila', 'Hill', 'Maintenance', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-038', 'Liam', 'Baker', 'Security', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-039', 'Aria', 'Gonzalez', 'Cook', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-040', 'Ella', 'Perez', 'Waiter', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-041', 'Logan', 'Sanchez', 'Concierge', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-042', 'Aiden', 'Rivera', 'Valet', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-043', 'Chloe', 'Reed', 'Driver', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-044', 'Mia', 'Campbell', 'Spa therapist', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-045', 'Zoey', 'Mitchell', 'Fitness instructor', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-046', 'Mila', 'Roberts', 'Lifeguard', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-047', 'Luna', 'Cook', 'Accountant', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-048', 'Leo', 'Baker', 'Human resources', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-049', 'Hazel', 'Gonzalez', 'Marketing', 114, 'West 40th St', 'New York', '10200', 'US', 3),
('000-000-050', 'Mila', 'Perez', 'Customer service', 114, 'West 40th St', 'New York', '10200', 'US', 3);

UPDATE hotel
SET sin_manager = '000-000-034'
WHERE id_hotel = 3;

-- Inserting employees for Marriott Residence Inn Central Park

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-051', 'Liam', 'Hill', 'Manager', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-052', 'Aria', 'Baker', 'Receptionist', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-053', 'Ella', 'Gonzalez', 'Housekeeper', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-054', 'Logan', 'Perez', 'Maintenance', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-055', 'Aiden', 'Sanchez', 'Security', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-056', 'Chloe', 'Rivera', 'Cook', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-057', 'Mia', 'Reed', 'Waiter', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-058', 'Zoey', 'Campbell', 'Concierge', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-059', 'Mila', 'Roberts', 'Valet', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-060', 'Luna', 'Cook', 'Driver', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-061', 'Leo', 'Baker', 'Spa therapist', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-062', 'Hazel', 'Gonzalez', 'Fitness instructor', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-063', 'Mila', 'Perez', 'Lifeguard', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-064', 'Liam', 'Hill', 'Accountant', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-065', 'Aria', 'Baker', 'Human resources', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-066', 'Ella', 'Gonzalez', 'Marketing', 1717, 'Broadway', 'New York', '10019', 'US', 4),
('000-000-067', 'Logan', 'Perez', 'Customer service', 1717, 'Broadway', 'New York', '10019', 'US', 4);

UPDATE hotel
SET sin_manager = '000-000-051'
WHERE id_hotel = 4;

-- Inserting employees for Marriott Fairfield Inn & Suites Manhattan/Times Square

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-068', 'Aiden', 'Sanchez', 'Manager', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-069', 'Chloe', 'Rivera', 'Receptionist', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-070', 'Mia', 'Reed', 'Housekeeper', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-071', 'Zoey', 'Campbell', 'Maintenance', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-072', 'Mila', 'Roberts', 'Security', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-073', 'Luna', 'Cook', 'Cook', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-074', 'Leo', 'Baker', 'Waiter', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-075', 'Hazel', 'Gonzalez', 'Concierge', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-076', 'Mila', 'Perez', 'Valet', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-077', 'Liam', 'Hill', 'Driver', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-078', 'Aria', 'Baker', 'Spa therapist', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-079', 'Ella', 'Gonzalez', 'Fitness instructor', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-080', 'Logan', 'Perez', 'Lifeguard', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-081', 'Aiden', 'Sanchez', 'Accountant', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-082', 'Chloe', 'Rivera', 'Human resources', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-083', 'Mia', 'Reed', 'Marketing', 330, 'West 40th St', 'New York', '10018', 'US', 5),
('000-000-084', 'Zoey', 'Campbell', 'Customer service', 330, 'West 40th St', 'New York', '10018', 'US', 5);

UPDATE hotel
SET sin_manager = '000-000-068'
WHERE id_hotel = 5;

-- Inserting employees for Marriott Renaissance New York Midtown Hotel

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-085', 'Mila', 'Roberts', 'Manager', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-086', 'Luna', 'Cook', 'Receptionist', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-087', 'Leo', 'Baker', 'Housekeeper', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-088', 'Hazel', 'Gonzalez', 'Maintenance', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-089', 'Mila', 'Perez', 'Security', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-090', 'Liam', 'Hill', 'Cook', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-091', 'Aria', 'Baker', 'Waiter', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-092', 'Ella', 'Gonzalez', 'Concierge', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-093', 'Logan', 'Perez', 'Valet', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-094', 'Aiden', 'Sanchez', 'Driver', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-095', 'Chloe', 'Rivera', 'Spa therapist', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-096', 'Mia', 'Reed', 'Fitness instructor', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-097', 'Zoey', 'Campbell', 'Lifeguard', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-098', 'Mila', 'Roberts', 'Accountant', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-099', 'Luna', 'Cook', 'Human resources', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-100', 'Leo', 'Baker', 'Marketing', 218, 'West 35th St', 'New York', '10001', 'US', 6),
('000-000-101', 'Hazel', 'Gonzalez', 'Customer service', 218, 'West 35th St', 'New York', '10001', 'US', 6);

UPDATE hotel
SET sin_manager = '000-000-085'
WHERE id_hotel = 6;

-- Inserting employees for Marriott SpringHill Suites Times Square

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-102', 'Liam', 'Hill', 'Manager', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-103', 'Aria', 'Baker', 'Receptionist', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-104', 'Ella', 'Gonzalez', 'Housekeeper', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-105', 'Logan', 'Perez', 'Maintenance', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-106', 'Aiden', 'Sanchez', 'Security', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-107', 'Chloe', 'Rivera', 'Cook', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-108', 'Mia', 'Reed', 'Waiter', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-109', 'Zoey', 'Campbell', 'Concierge', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-110', 'Mila', 'Roberts', 'Valet', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-111', 'Luna', 'Cook', 'Driver', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-112', 'Leo', 'Baker', 'Spa therapist', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-113', 'Hazel', 'Gonzalez', 'Fitness instructor', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-114', 'Mila', 'Perez', 'Lifeguard', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-115', 'Liam', 'Hill', 'Accountant', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-116', 'Aria', 'Baker', 'Human resources', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-117', 'Ella', 'Gonzalez', 'Marketing', 25, 'West 37th St', 'New York', '10018', 'US', 7),
('000-000-118', 'Logan', 'Perez', 'Customer service', 25, 'West 37th St', 'New York', '10018', 'US', 7);

UPDATE hotel
SET sin_manager = '000-000-102'
WHERE id_hotel = 7;

-- Inserting employees for Marriott Residence Inn World Trade Center

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-119', 'Aiden', 'Sanchez', 'Manager', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-120', 'Chloe', 'Rivera', 'Receptionist', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-121', 'Mia', 'Reed', 'Housekeeper', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-122', 'Zoey', 'Campbell', 'Maintenance', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-123', 'Mila', 'Roberts', 'Security', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-124', 'Luna', 'Cook', 'Cook', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-125', 'Leo', 'Baker', 'Waiter', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-126', 'Hazel', 'Gonzalez', 'Concierge', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-127', 'Mila', 'Perez', 'Valet', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-128', 'Liam', 'Hill', 'Driver', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-129', 'Aria', 'Baker', 'Spa therapist', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-130', 'Ella', 'Gonzalez', 'Fitness instructor', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-131', 'Logan', 'Perez', 'Lifeguard', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-132', 'Aiden', 'Sanchez', 'Accountant', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-133', 'Chloe', 'Rivera', 'Human resources', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-134', 'Mia', 'Reed', 'Marketing', 170, 'Broadway', 'New York', '10007', 'US', 8),
('000-000-135', 'Zoey', 'Campbell', 'Customer service', 170, 'Broadway', 'New York', '10007', 'US', 8);

UPDATE hotel
SET sin_manager = '000-000-119'
WHERE id_hotel = 8;

-- Inserting employees for Hilton Los Angeles Airport

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-136', 'Chloe', 'Rivera', 'Manager', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-137', 'Mia', 'Reed', 'Receptionist', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-138', 'Zoey', 'Campbell', 'Housekeeper', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-139', 'Mila', 'Roberts', 'Maintenance', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-140', 'Luna', 'Cook', 'Security', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-141', 'Leo', 'Baker', 'Cook', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-142', 'Hazel', 'Gonzalez', 'Waiter', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-143', 'Mila', 'Perez', 'Concierge', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-144', 'Liam', 'Hill', 'Valet', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-145', 'Aria', 'Baker', 'Driver', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-146', 'Ella', 'Gonzalez', 'Spa therapist', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-147', 'Logan', 'Perez', 'Fitness instructor', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-148', 'Aiden', 'Sanchez', 'Lifeguard', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-149', 'Chloe', 'Rivera', 'Accountant', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-150', 'Mia', 'Reed', 'Human resources', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-151', 'Zoey', 'Campbell', 'Marketing', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9),
('000-000-152', 'Mila', 'Roberts', 'Customer service', 5711, 'W Century Blvd', 'Los Angeles', '90045', 'US', 9);

UPDATE hotel
SET sin_manager = '000-000-136'
WHERE id_hotel = 9;

-- Inserting employees for Hilton Checkers Los Angeles

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-153', 'Luna', 'Cook', 'Manager', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-154', 'Leo', 'Baker', 'Receptionist', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-155', 'Hazel', 'Gonzalez', 'Housekeeper', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-156', 'Mila', 'Perez', 'Maintenance', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-157', 'Liam', 'Hill', 'Security', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-158', 'Aria', 'Baker', 'Cook', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-159', 'Ella', 'Gonzalez', 'Waiter', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-160', 'Logan', 'Perez', 'Concierge', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-161', 'Aiden', 'Sanchez', 'Valet', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-162', 'Chloe', 'Rivera', 'Driver', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-163', 'Mia', 'Reed', 'Spa therapist', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-164', 'Zoey', 'Campbell', 'Fitness instructor', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-165', 'Mila', 'Roberts', 'Lifeguard', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-166', 'Luna', 'Cook', 'Accountant', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-167', 'Leo', 'Baker', 'Human resources', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-168', 'Hazel', 'Gonzalez', 'Marketing', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10),
('000-000-169', 'Mila', 'Perez', 'Customer service', 535, 'S Grand Ave', 'Los Angeles', '90071', 'US', 10);

UPDATE hotel
SET sin_manager = '000-000-153'
WHERE id_hotel = 10;

-- Inserting employees for Hilton Los Angeles/Universal City

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-170', 'Liam', 'Hill', 'Manager', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-171', 'Aria', 'Baker', 'Receptionist', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-172', 'Ella', 'Gonzalez', 'Housekeeper', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-173', 'Logan', 'Perez', 'Maintenance', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-174', 'Aiden', 'Sanchez', 'Security', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-175', 'Chloe', 'Rivera', 'Cook', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-176', 'Mia', 'Reed', 'Waiter', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-177', 'Zoey', 'Campbell', 'Concierge', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-178', 'Mila', 'Roberts', 'Valet', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-179', 'Luna', 'Cook', 'Driver', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-180', 'Leo', 'Baker', 'Spa therapist', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-181', 'Hazel', 'Gonzalez', 'Fitness instructor', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-182', 'Mila', 'Perez', 'Lifeguard', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-183', 'Liam', 'Hill', 'Accountant', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-184', 'Aria', 'Baker', 'Human resources', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-185', 'Ella', 'Gonzalez', 'Marketing', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11),
('000-000-186', 'Logan', 'Perez', 'Customer service', 555, 'Universal Hollywood Dr', 'Los Angeles', '91608', 'US', 11);

UPDATE hotel
SET sin_manager = '000-000-170'
WHERE id_hotel = 11;

-- Inserting employee for Hilton Garden Inn Los Angeles/Hollywood

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-187', 'Aiden', 'Sanchez', 'Manager', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-188', 'Chloe', 'Rivera', 'Receptionist', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-189', 'Mia', 'Reed', 'Housekeeper', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-190', 'Zoey', 'Campbell', 'Maintenance', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-191', 'Mila', 'Roberts', 'Security', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-192', 'Luna', 'Cook', 'Cook', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-193', 'Leo', 'Baker', 'Waiter', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-194', 'Hazel', 'Gonzalez', 'Concierge', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-195', 'Mila', 'Perez', 'Valet', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-196', 'Liam', 'Hill', 'Driver', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-197', 'Aria', 'Baker', 'Spa therapist', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-198', 'Ella', 'Gonzalez', 'Fitness instructor', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-199', 'Logan', 'Perez', 'Lifeguard', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-200', 'Aiden', 'Sanchez', 'Accountant', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-201', 'Chloe', 'Rivera', 'Human resources', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-202', 'Mia', 'Reed', 'Marketing', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12),
('000-000-203', 'Zoey', 'Campbell', 'Customer service', 2005, 'N Highland Ave', 'Los Angeles', '90068', 'US', 12);

UPDATE hotel
SET sin_manager = '000-000-187'
WHERE id_hotel = 12;

-- Inserting employee for Homewood Suites by Hilton Los Angeles International Airport

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-204', 'Liam', 'Hill', 'Manager', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-205', 'Aria', 'Baker', 'Receptionist', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-206', 'Ella', 'Gonzalez', 'Housekeeper', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-207', 'Logan', 'Perez', 'Maintenance', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-208', 'Aiden', 'Sanchez', 'Security', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-209', 'Chloe', 'Rivera', 'Cook', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-210', 'Mia', 'Reed', 'Waiter', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-211', 'Zoey', 'Campbell', 'Concierge', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-212', 'Mila', 'Roberts', 'Valet', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-213', 'Luna', 'Cook', 'Driver', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-214', 'Leo', 'Baker', 'Spa therapist', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-215', 'Hazel', 'Gonzalez', 'Fitness instructor', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-216', 'Mila', 'Perez', 'Lifeguard', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-217', 'Liam', 'Hill', 'Accountant', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-218', 'Aria', 'Baker', 'Human resources', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-219', 'Ella', 'Gonzalez', 'Marketing', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13),
('000-000-220', 'Logan', 'Perez', 'Customer service', 6151, 'W Century Blvd', 'Los Angeles', '90045', 'US', 13);

UPDATE hotel
SET sin_manager = '000-000-204'
WHERE id_hotel = 13;

-- Inserting employee for DoubleTree by Hilton Hotel Los Angeles Downtown

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-221', 'Aiden', 'Sanchez', 'Manager', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-222', 'Chloe', 'Rivera', 'Receptionist', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-223', 'Mia', 'Reed', 'Housekeeper', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-224', 'Zoey', 'Campbell', 'Maintenance', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-225', 'Mila', 'Roberts', 'Security', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-226', 'Luna', 'Cook', 'Cook', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-227', 'Leo', 'Baker', 'Waiter', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-228', 'Hazel', 'Gonzalez', 'Concierge', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-229', 'Mila', 'Perez', 'Valet', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-230', 'Liam', 'Hill', 'Driver', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-231', 'Aria', 'Baker', 'Spa therapist', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-232', 'Ella', 'Gonzalez', 'Fitness instructor', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-233', 'Logan', 'Perez', 'Lifeguard', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-234', 'Aiden', 'Sanchez', 'Accountant', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-235', 'Chloe', 'Rivera', 'Human resources', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-236', 'Mia', 'Reed', 'Marketing', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14),
('000-000-237', 'Zoey', 'Campbell', 'Customer service', 120, 'S Los Angeles St', 'Los Angeles', '90012', 'US', 14);

UPDATE hotel
SET sin_manager = '000-000-221'
WHERE id_hotel = 14;

-- Inserting employee for Embassy Suites by Hilton Los Angeles International Airport South

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-238', 'Liam', 'Hill', 'Manager', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-239', 'Aria', 'Baker', 'Receptionist', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-240', 'Ella', 'Gonzalez', 'Housekeeper', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-241', 'Logan', 'Perez', 'Maintenance', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-242', 'Aiden', 'Sanchez', 'Security', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-243', 'Chloe', 'Rivera', 'Cook', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-244', 'Mia', 'Reed', 'Waiter', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-245', 'Zoey', 'Campbell', 'Concierge', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-246', 'Mila', 'Roberts', 'Valet', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-247', 'Luna', 'Cook', 'Driver', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-248', 'Leo', 'Baker', 'Spa therapist', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-249', 'Hazel', 'Gonzalez', 'Fitness instructor', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-250', 'Mila', 'Perez', 'Lifeguard', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-251', 'Liam', 'Hill', 'Accountant', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-252', 'Aria', 'Baker', 'Human resources', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-253', 'Ella', 'Gonzalez', 'Marketing', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15),
('000-000-254', 'Logan', 'Perez', 'Customer service', 1440, 'E Imperial Ave', 'El Segundo', '90245', 'US', 15);

UPDATE hotel
SET sin_manager = '000-000-238'
WHERE id_hotel = 15;

-- Inserting employee forHampton Inn & Suites Los Angeles/Sherman Oaks

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-255', 'Aiden', 'Sanchez', 'Manager', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-256', 'Chloe', 'Rivera', 'Receptionist', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-257', 'Mia', 'Reed', 'Housekeeper', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-258', 'Zoey', 'Campbell', 'Maintenance', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-259', 'Mila', 'Roberts', 'Security', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-260', 'Luna', 'Cook', 'Cook', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-261', 'Leo', 'Baker', 'Waiter', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-262', 'Hazel', 'Gonzalez', 'Concierge', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-263', 'Mila', 'Perez', 'Valet', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-264', 'Liam', 'Hill', 'Driver', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-265', 'Aria', 'Baker', 'Spa therapist', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-266', 'Ella', 'Gonzalez', 'Fitness instructor', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-267', 'Logan', 'Perez', 'Lifeguard', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-268', 'Aiden', 'Sanchez', 'Accountant', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-269', 'Chloe', 'Rivera', 'Human resources', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-270', 'Mia', 'Reed', 'Marketing', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16),
('000-000-271', 'Zoey', 'Campbell', 'Customer service', 5638, 'Sepulveda Blvd', 'Sherman Oaks', '91411', 'US', 16);

UPDATE hotel
SET sin_manager = '000-000-255'
WHERE id_hotel = 16;

-- Inserting employee for InterContinental Toronto Centre

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-272', 'Mila', 'Roberts', 'Manager', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-273', 'Luna', 'Cook', 'Receptionist', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-274', 'Leo', 'Baker', 'Housekeeper', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-275', 'Hazel', 'Gonzalez', 'Maintenance', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-276', 'Mila', 'Perez', 'Security', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-277', 'Liam', 'Hill', 'Cook', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-278', 'Aria', 'Baker', 'Waiter', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-279', 'Ella', 'Gonzalez', 'Concierge', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-280', 'Logan', 'Perez', 'Valet', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-281', 'Aiden', 'Sanchez', 'Driver', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-282', 'Chloe', 'Rivera', 'Spa therapist', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-283', 'Mia', 'Reed', 'Fitness instructor', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-284', 'Zoey', 'Campbell', 'Lifeguard', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-285', 'Mila', 'Roberts', 'Accountant', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-286', 'Luna', 'Cook', 'Human resources', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-287', 'Leo', 'Baker', 'Marketing', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17),
('000-000-288', 'Hazel', 'Gonzalez', 'Customer service', 225, 'Front St W', 'Toronto', 'M5V 2X3', 'CA', 17);

UPDATE hotel
SET sin_manager = '000-000-272'
WHERE id_hotel = 17;

-- Inserting employee for InterContinental Toronto Yorkville

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-289', 'Mila', 'Perez', 'Manager', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-290', 'Liam', 'Hill', 'Receptionist', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-291', 'Aria', 'Baker', 'Housekeeper', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-292', 'Ella', 'Gonzalez', 'Maintenance', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-293', 'Logan', 'Perez', 'Security', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-294', 'Aiden', 'Sanchez', 'Cook', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-295', 'Chloe', 'Rivera', 'Waiter', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-296', 'Mia', 'Reed', 'Concierge', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-297', 'Zoey', 'Campbell', 'Valet', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-298', 'Mila', 'Roberts', 'Driver', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-299', 'Luna', 'Cook', 'Spa therapist', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-300', 'Leo', 'Baker', 'Fitness instructor', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-301', 'Hazel', 'Gonzalez', 'Lifeguard', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-302', 'Mila', 'Perez', 'Accountant', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-303', 'Liam', 'Hill', 'Human resources', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-304', 'Aria', 'Baker', 'Marketing', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18),
('000-000-305', 'Ella', 'Gonzalez', 'Customer service', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 18);

UPDATE hotel
SET sin_manager = '000-000-289'
WHERE id_hotel = 18;

-- Inserting employee for Holiday Inn Toronto Downtown Centre

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-306', 'Logan', 'Perez', 'Manager', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-307', 'Aiden', 'Sanchez', 'Receptionist', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-308', 'Chloe', 'Rivera', 'Housekeeper', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-309', 'Mia', 'Reed', 'Maintenance', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-310', 'Zoey', 'Campbell', 'Security', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-311', 'Mila', 'Roberts', 'Cook', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-312', 'Luna', 'Cook', 'Waiter', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-313', 'Leo', 'Baker', 'Concierge', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-314', 'Hazel', 'Gonzalez', 'Valet', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-315', 'Mila', 'Perez', 'Driver', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-316', 'Liam', 'Hill', 'Spa therapist', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-317', 'Aria', 'Baker', 'Fitness instructor', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-318', 'Ella', 'Gonzalez', 'Lifeguard', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-319', 'Logan', 'Perez', 'Accountant', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-320', 'Aiden', 'Sanchez', 'Human resources', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-321', 'Chloe', 'Rivera', 'Marketing', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19),
('000-000-322', 'Mia', 'Reed', 'Customer service', 30, 'Carlton St', 'Toronto', 'M5B 2E9', 'CA', 19);

UPDATE hotel
SET sin_manager = '000-000-306'
WHERE id_hotel = 19;

-- Inserting employee for Crowne Plaza Toronto Airport

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-323', 'Zoey', 'Campbell', 'Manager', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-324', 'Mila', 'Roberts', 'Receptionist', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-325', 'Luna', 'Cook', 'Housekeeper', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-326', 'Leo', 'Baker', 'Maintenance', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-327', 'Hazel', 'Gonzalez', 'Security', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-328', 'Mila', 'Perez', 'Cook', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-329', 'Liam', 'Hill', 'Waiter', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-330', 'Aria', 'Baker', 'Concierge', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-331', 'Ella', 'Gonzalez', 'Valet', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-332', 'Logan', 'Perez', 'Driver', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-333', 'Aiden', 'Sanchez', 'Spa therapist', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-334', 'Chloe', 'Rivera', 'Fitness instructor', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-335', 'Mia', 'Reed', 'Lifeguard', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-336', 'Zoey', 'Campbell', 'Accountant', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-337', 'Mila', 'Roberts', 'Human resources', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-338', 'Luna', 'Cook', 'Marketing', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20),
('000-000-339', 'Leo', 'Baker', 'Customer service', 33, 'Carlson Ct', 'Toronto', 'M9W 6H5', 'CA', 20);

UPDATE hotel
SET sin_manager = '000-000-323'
WHERE id_hotel = 20;

-- Inserting employee for Holiday Inn Express Toronto Downtown

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-340', 'Hazel', 'Gonzalez', 'Manager', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-341', 'Mila', 'Perez', 'Receptionist', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-342', 'Liam', 'Hill', 'Housekeeper', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-343', 'Aria', 'Baker', 'Maintenance', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-344', 'Ella', 'Gonzalez', 'Security', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-345', 'Logan', 'Perez', 'Cook', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-346', 'Aiden', 'Sanchez', 'Waiter', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-347', 'Chloe', 'Rivera', 'Concierge', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-348', 'Mia', 'Reed', 'Valet', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-349', 'Zoey', 'Campbell', 'Driver', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-350', 'Mila', 'Roberts', 'Spa therapist', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-351', 'Luna', 'Cook', 'Fitness instructor', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-352', 'Leo', 'Baker', 'Lifeguard', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-353', 'Hazel', 'Gonzalez', 'Accountant', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-354', 'Mila', 'Perez', 'Human resources', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-355', 'Liam', 'Hill', 'Marketing', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21),
('000-000-356', 'Aria', 'Baker', 'Customer service', 111, 'Lombard St', 'Toronto', 'M5C 2T9', 'CA', 21);

UPDATE hotel
SET sin_manager = '000-000-340'
WHERE id_hotel = 21;

-- Inserting employee for InterContinental Toronto Midtown

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-357', 'Ella', 'Gonzalez', 'Manager', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-358', 'Logan', 'Perez', 'Receptionist', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-359', 'Aiden', 'Sanchez', 'Housekeeper', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-360', 'Chloe', 'Rivera', 'Maintenance', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-361', 'Mia', 'Reed', 'Security', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-362', 'Zoey', 'Campbell', 'Cook', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-363', 'Mila', 'Roberts', 'Waiter', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-364', 'Luna', 'Cook', 'Concierge', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-365', 'Leo', 'Baker', 'Valet', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-366', 'Hazel', 'Gonzalez', 'Driver', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-367', 'Mila', 'Perez', 'Spa therapist', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-368', 'Liam', 'Hill', 'Fitness instructor', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-369', 'Aria', 'Baker', 'Lifeguard', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-370', 'Ella', 'Gonzalez', 'Accountant', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-371', 'Logan', 'Perez', 'Human resources', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-372', 'Aiden', 'Sanchez', 'Marketing', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22),
('000-000-373', 'Chloe', 'Rivera', 'Customer service', 220, 'Bloor St W', 'Toronto', 'M5S 1T8', 'CA', 22);

UPDATE hotel
SET sin_manager = '000-000-357'
WHERE id_hotel = 22;

-- Inserting employee for Holiday Inn Toronto Bloor-Yorkville

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-374', 'Mia', 'Reed', 'Manager', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-375', 'Zoey', 'Campbell', 'Receptionist', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-376', 'Mila', 'Roberts', 'Housekeeper', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-377', 'Luna', 'Cook', 'Maintenance', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-378', 'Leo', 'Baker', 'Security', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-379', 'Hazel', 'Gonzalez', 'Cook', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-380', 'Mila', 'Perez', 'Waiter', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-381', 'Liam', 'Hill', 'Concierge', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-382', 'Aria', 'Baker', 'Valet', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-383', 'Ella', 'Gonzalez', 'Driver', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-384', 'Logan', 'Perez', 'Spa therapist', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-385', 'Aiden', 'Sanchez', 'Fitness instructor', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-386', 'Chloe', 'Rivera', 'Lifeguard', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-387', 'Mia', 'Reed', 'Accountant', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-388', 'Zoey', 'Campbell', 'Human resources', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-389', 'Mila', 'Roberts', 'Marketing', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23),
('000-000-390', 'Luna', 'Cook', 'Customer service', 280, 'Bloor St W', 'Toronto', 'M5S 1V8', 'CA', 23);

UPDATE hotel
SET sin_manager = '000-000-374'
WHERE id_hotel = 23;

-- Inserting employee for Staybridge Suites Toronto

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-391', 'Leo', 'Baker', 'Manager', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-392', 'Hazel', 'Gonzalez', 'Receptionist', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-393', 'Mila', 'Perez', 'Housekeeper', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-394', 'Liam', 'Hill', 'Maintenance', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-395', 'Aria', 'Baker', 'Security', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-396', 'Ella', 'Gonzalez', 'Cook', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-397', 'Logan', 'Perez', 'Waiter', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-398', 'Aiden', 'Sanchez', 'Concierge', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-399', 'Chloe', 'Rivera', 'Valet', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-400', 'Mia', 'Reed', 'Driver', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-401', 'Zoey', 'Campbell', 'Spa therapist', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-402', 'Mila', 'Roberts', 'Fitness instructor', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-403', 'Luna', 'Cook', 'Lifeguard', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-404', 'Leo', 'Baker', 'Accountant', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-405', 'Hazel', 'Gonzalez', 'Human resources', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-406', 'Mila', 'Perez', 'Marketing', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24),
('000-000-407', 'Liam', 'Hill', 'Customer service', 385, 'Wellington St W', 'Toronto', 'M5V 1E3', 'CA', 24);

UPDATE hotel
SET sin_manager = '000-000-391'
WHERE id_hotel = 24;

-- Inserting employee for Fairmont The Queen Elizabeth

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-408', 'Aria', 'Baker', 'Manager', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-409', 'Ella', 'Gonzalez', 'Receptionist', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-410', 'Logan', 'Perez', 'Housekeeper', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-411', 'Aiden', 'Sanchez', 'Maintenance', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-412', 'Chloe', 'Rivera', 'Security', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-413', 'Mia', 'Reed', 'Cook', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-414', 'Zoey', 'Campbell', 'Waiter', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-415', 'Mila', 'Roberts', 'Concierge', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-416', 'Luna', 'Cook', 'Valet', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-417', 'Leo', 'Baker', 'Driver', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-418', 'Hazel', 'Gonzalez', 'Spa therapist', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-419', 'Mila', 'Perez', 'Fitness instructor', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-420', 'Liam', 'Hill', 'Lifeguard', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-421', 'Aria', 'Baker', 'Accountant', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-422', 'Ella', 'Gonzalez', 'Human resources', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-423', 'Logan', 'Perez', 'Marketing', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25),
('000-000-424', 'Aiden', 'Sanchez', 'Customer service', 900, 'René-Lévesque Blvd W', 'Montreal', 'H3B 4A5', 'CA', 25);

UPDATE hotel
SET sin_manager = '000-000-408'
WHERE id_hotel = 25;

-- Inserting employee for Novotel Montreal Centre

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-425', 'Chloe', 'Rivera', 'Manager', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-426', 'Mia', 'Reed', 'Receptionist', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-427', 'Zoey', 'Campbell', 'Housekeeper', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-428', 'Mila', 'Roberts', 'Maintenance', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-429', 'Luna', 'Cook', 'Security', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-430', 'Leo', 'Baker', 'Cook', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-431', 'Hazel', 'Gonzalez', 'Waiter', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-432', 'Mila', 'Perez', 'Concierge', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-433', 'Liam', 'Hill', 'Valet', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-434', 'Aria', 'Baker', 'Driver', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-435', 'Ella', 'Gonzalez', 'Spa therapist', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-436', 'Logan', 'Perez', 'Fitness instructor', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-437', 'Aiden', 'Sanchez', 'Lifeguard', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-438', 'Chloe', 'Rivera', 'Accountant', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-439', 'Mia', 'Reed', 'Human resources', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-440', 'Zoey', 'Campbell', 'Marketing', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26),
('000-000-441', 'Mila', 'Roberts', 'Customer service', 1180, 'de la Montagne St', 'Montreal', 'H3G 1Z1', 'CA', 26);

UPDATE hotel
SET sin_manager = '000-000-425'
WHERE id_hotel = 26;

-- Inserting employee for Mercure Montreal Centre-Ville

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-442', 'Luna', 'Cook', 'Manager', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-443', 'Leo', 'Baker', 'Receptionist', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-444', 'Hazel', 'Gonzalez', 'Housekeeper', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-445', 'Mila', 'Perez', 'Maintenance', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-446', 'Liam', 'Hill', 'Security', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-447', 'Aria', 'Baker', 'Cook', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-448', 'Ella', 'Gonzalez', 'Waiter', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-449', 'Logan', 'Perez', 'Concierge', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-450', 'Aiden', 'Sanchez', 'Valet', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-451', 'Chloe', 'Rivera', 'Driver', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-452', 'Mia', 'Reed', 'Spa therapist', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-453', 'Zoey', 'Campbell', 'Fitness instructor', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-454', 'Mila', 'Roberts', 'Lifeguard', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-455', 'Luna', 'Cook', 'Accountant', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-456', 'Leo', 'Baker', 'Human resources', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-457', 'Hazel', 'Gonzalez', 'Marketing', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27),
('000-000-458', 'Mila', 'Perez', 'Customer service', 2100, 'de Maisonneuve Blvd W', 'Montreal', 'H3H 1K6', 'CA', 27);

UPDATE hotel
SET sin_manager = '000-000-442'
WHERE id_hotel = 27;

-- Inserting employee for ibis Montreal Centre-Ville

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-459', 'Liam', 'Hill', 'Manager', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-460', 'Aria', 'Baker', 'Receptionist', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-461', 'Ella', 'Gonzalez', 'Housekeeper', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-462', 'Logan', 'Perez', 'Maintenance', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-463', 'Aiden', 'Sanchez', 'Security', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-464', 'Chloe', 'Rivera', 'Cook', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-465', 'Mia', 'Reed', 'Waiter', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-466', 'Zoey', 'Campbell', 'Concierge', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-467', 'Mila', 'Roberts', 'Valet', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-468', 'Luna', 'Cook', 'Driver', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-469', 'Leo', 'Baker', 'Spa therapist', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-470', 'Hazel', 'Gonzalez', 'Fitness instructor', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-471', 'Mila', 'Perez', 'Lifeguard', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-472', 'Liam', 'Hill', 'Accountant', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-473', 'Aria', 'Baker', 'Human resources', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-474', 'Ella', 'Gonzalez', 'Marketing', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28),
('000-000-475', 'Logan', 'Perez', 'Customer service', 22, 'Rene-Levesque Blvd E', 'Montreal', 'H2X 1N1', 'CA', 28);

UPDATE hotel
SET sin_manager = '000-000-459'
WHERE id_hotel = 28;

-- Inserting employee for Hotel Faubourg Montreal

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-476', 'Aiden', 'Sanchez', 'Manager', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-477', 'Chloe', 'Rivera', 'Receptionist', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-478', 'Mia', 'Reed', 'Housekeeper', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-479', 'Zoey', 'Campbell', 'Maintenance', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-480', 'Mila', 'Roberts', 'Security', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-481', 'Luna', 'Cook', 'Cook', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-482', 'Leo', 'Baker', 'Waiter', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-483', 'Hazel', 'Gonzalez', 'Concierge', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-484', 'Mila', 'Perez', 'Valet', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-485', 'Liam', 'Hill', 'Driver', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-486', 'Aria', 'Baker', 'Spa therapist', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-487', 'Ella', 'Gonzalez', 'Fitness instructor', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-488', 'Logan', 'Perez', 'Lifeguard', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-489', 'Aiden', 'Sanchez', 'Accountant', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-490', 'Chloe', 'Rivera', 'Human resources', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-491', 'Mia', 'Reed', 'Marketing', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29),
('000-000-492', 'Zoey', 'Campbell', 'Customer service', 155, 'René-Lévesque Blvd E', 'Montreal', 'H2X 1N4', 'CA', 29);

UPDATE hotel
SET sin_manager = '000-000-476'
WHERE id_hotel = 29;

-- Inserting employee for Sofitel Montreal Golden Mile

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-493', 'Mila', 'Roberts', 'Manager', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-494', 'Luna', 'Cook', 'Receptionist', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-495', 'Leo', 'Baker', 'Housekeeper', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-496', 'Hazel', 'Gonzalez', 'Maintenance', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-497', 'Mila', 'Perez', 'Security', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-498', 'Liam', 'Hill', 'Cook', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-499', 'Aria', 'Baker', 'Waiter', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-500', 'Ella', 'Gonzalez', 'Concierge', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-501', 'Logan', 'Perez', 'Valet', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-502', 'Aiden', 'Sanchez', 'Driver', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-503', 'Chloe', 'Rivera', 'Spa therapist', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-504', 'Mia', 'Reed', 'Fitness instructor', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-505', 'Zoey', 'Campbell', 'Lifeguard', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-506', 'Mila', 'Roberts', 'Accountant', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-507', 'Luna', 'Cook', 'Human resources', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-508', 'Leo', 'Baker', 'Marketing', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30),
('000-000-509', 'Hazel', 'Gonzalez', 'Customer service', 1155, 'Sherbrooke St W', 'Montreal', 'H3A 2N3', 'CA', 30);

UPDATE hotel
SET sin_manager = '000-000-493'
WHERE id_hotel = 30;

-- Inserting employee for Novotel Montreal Airport

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-510', 'Mila', 'Perez', 'Manager', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-511', 'Liam', 'Hill', 'Receptionist', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-512', 'Aria', 'Baker', 'Housekeeper', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-513', 'Ella', 'Gonzalez', 'Maintenance', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-514', 'Logan', 'Perez', 'Security', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-515', 'Aiden', 'Sanchez', 'Cook', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-516', 'Chloe', 'Rivera', 'Waiter', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-517', 'Mia', 'Reed', 'Concierge', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-518', 'Zoey', 'Campbell', 'Valet', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-519', 'Mila', 'Roberts', 'Driver', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-520', 'Luna', 'Cook', 'Spa therapist', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-521', 'Leo', 'Baker', 'Fitness instructor', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-522', 'Hazel', 'Gonzalez', 'Lifeguard', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-523', 'Mila', 'Perez', 'Accountant', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-524', 'Liam', 'Hill', 'Human resources', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-525', 'Aria', 'Baker', 'Marketing', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31),
('000-000-526', 'Ella', 'Gonzalez', 'Customer service', 2599, 'Boul. Alfred Nobel', 'Montreal', 'H4S 2G1', 'CA', 31);

UPDATE hotel
SET sin_manager = '000-000-510'
WHERE id_hotel = 31;

-- Inserting employee for ibis Styles Montreal Centre-Ville

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-527', 'Logan', 'Perez', 'Manager', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-528', 'Aiden', 'Sanchez', 'Receptionist', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-529', 'Chloe', 'Rivera', 'Housekeeper', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-530', 'Mia', 'Reed', 'Maintenance', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-531', 'Zoey', 'Campbell', 'Security', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-532', 'Mila', 'Roberts', 'Cook', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-533', 'Luna', 'Cook', 'Waiter', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-534', 'Leo', 'Baker', 'Concierge', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-535', 'Hazel', 'Gonzalez', 'Valet', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-536', 'Mila', 'Perez', 'Driver', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-537', 'Liam', 'Hill', 'Spa therapist', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-538', 'Aria', 'Baker', 'Fitness instructor', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-539', 'Ella', 'Gonzalez', 'Lifeguard', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-540', 'Logan', 'Perez', 'Accountant', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-541', 'Aiden', 'Sanchez', 'Human resources', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-542', 'Chloe', 'Rivera', 'Marketing', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32),
('000-000-543', 'Mia', 'Reed', 'Customer service', 1415, 'Rene-Levesque Blvd W', 'Montreal', 'H3G 1T6', 'CA', 32);

UPDATE hotel
SET sin_manager = '000-000-527'
WHERE id_hotel = 32;

-- Inserting employee for Wyndham Grand Mexico City Reforma

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-544', 'Zoey', 'Campbell', 'Manager', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-545', 'Mila', 'Roberts', 'Receptionist', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-546', 'Luna', 'Cook', 'Housekeeper', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-547', 'Leo', 'Baker', 'Maintenance', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-548', 'Hazel', 'Gonzalez', 'Security', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-549', 'Mila', 'Perez', 'Cook', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-550', 'Liam', 'Hill', 'Waiter', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-551', 'Aria', 'Baker', 'Concierge', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-552', 'Ella', 'Gonzalez', 'Valet', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-553', 'Logan', 'Perez', 'Driver', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-554', 'Aiden', 'Sanchez', 'Spa therapist', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-555', 'Chloe', 'Rivera', 'Fitness instructor', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-556', 'Mia', 'Reed', 'Lifeguard', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-557', 'Zoey', 'Campbell', 'Accountant', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-558', 'Mila', 'Roberts', 'Human resources', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-559', 'Luna', 'Cook', 'Marketing', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33),
('000-000-560', 'Leo', 'Baker', 'Customer service', 5, 'de la Reforma Ave', 'Mexico City', '06040', 'MX', 33);

UPDATE hotel
SET sin_manager = '000-000-544'
WHERE id_hotel = 33;

-- Inserting employee for Wyndham Garden Mexico City Polanco

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-561', 'Hazel', 'Gonzalez', 'Manager', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-562', 'Mila', 'Perez', 'Receptionist', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-563', 'Liam', 'Hill', 'Housekeeper', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-564', 'Aria', 'Baker', 'Maintenance', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-565', 'Ella', 'Gonzalez', 'Security', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-566', 'Logan', 'Perez', 'Cook', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-567', 'Aiden', 'Sanchez', 'Waiter', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-568', 'Chloe', 'Rivera', 'Concierge', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-569', 'Mia', 'Reed', 'Valet', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-570', 'Zoey', 'Campbell', 'Driver', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-571', 'Mila', 'Roberts', 'Spa therapist', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-572', 'Luna', 'Cook', 'Fitness instructor', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-573', 'Leo', 'Baker', 'Lifeguard', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-574', 'Hazel', 'Gonzalez', 'Accountant', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-575', 'Mila', 'Perez', 'Human resources', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-576', 'Liam', 'Hill', 'Marketing', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34),
('000-000-577', 'Aria', 'Baker', 'Customer service', 22, 'Mariano Escobedo Ave', 'Mexico City', '11590', 'MX', 34);

UPDATE hotel
SET sin_manager = '000-000-561'
WHERE id_hotel = 34;

-- Inserting employee for Wyndham Garden Mexico City Centro Historico

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-578', 'Ella', 'Gonzalez', 'Manager', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-579', 'Logan', 'Perez', 'Receptionist', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-580', 'Aiden', 'Sanchez', 'Housekeeper', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-581', 'Chloe', 'Rivera', 'Maintenance', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-582', 'Mia', 'Reed', 'Security', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-583', 'Zoey', 'Campbell', 'Cook', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-584', 'Mila', 'Roberts', 'Waiter', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-585', 'Luna', 'Cook', 'Concierge', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-586', 'Leo', 'Baker', 'Valet', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-587', 'Hazel', 'Gonzalez', 'Driver', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-588', 'Mila', 'Perez', 'Spa therapist', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-589', 'Liam', 'Hill', 'Fitness instructor', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-590', 'Aria', 'Baker', 'Lifeguard', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-591', 'Ella', 'Gonzalez', 'Accountant', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-592', 'Logan', 'Perez', 'Human resources', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-593', 'Aiden', 'Sanchez', 'Marketing', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35),
('000-000-594', 'Chloe', 'Rivera', 'Customer service', 5, 'de Mayo St', 'Mexico City', '06000', 'MX', 35);

UPDATE hotel
SET sin_manager = '000-000-578'
WHERE id_hotel = 35;

-- Inserting employee for Wyndham Garden Mexico City Santa Fe

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-595', 'Mia', 'Reed', 'Manager', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-596', 'Zoey', 'Campbell', 'Receptionist', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-597', 'Mila', 'Roberts', 'Housekeeper', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-598', 'Luna', 'Cook', 'Maintenance', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-599', 'Leo', 'Baker', 'Security', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-600', 'Hazel', 'Gonzalez', 'Cook', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-601', 'Mila', 'Perez', 'Waiter', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-602', 'Liam', 'Hill', 'Concierge', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-603', 'Aria', 'Baker', 'Valet', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-604', 'Ella', 'Gonzalez', 'Driver', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-605', 'Logan', 'Perez', 'Spa therapist', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-606', 'Aiden', 'Sanchez', 'Fitness instructor', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-607', 'Chloe', 'Rivera', 'Lifeguard', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-608', 'Mia', 'Reed', 'Accountant', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-609', 'Zoey', 'Campbell', 'Human resources', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-610', 'Mila', 'Roberts', 'Marketing', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36),
('000-000-611', 'Luna', 'Cook', 'Customer service', 150, 'Antonio Dovali Jaime St', 'Mexico City', '01219', 'MX', 36);

UPDATE hotel
SET sin_manager = '000-000-595'
WHERE id_hotel = 36;

-- Inserting employee for Ramada by Wyndham Mexico City Reforma

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-612', 'Leo', 'Baker', 'Manager', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-613', 'Hazel', 'Gonzalez', 'Receptionist', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-614', 'Mila', 'Perez', 'Housekeeper', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-615', 'Liam', 'Hill', 'Maintenance', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-616', 'Aria', 'Baker', 'Security', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-617', 'Ella', 'Gonzalez', 'Cook', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-618', 'Logan', 'Perez', 'Waiter', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-619', 'Aiden', 'Sanchez', 'Concierge', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-620', 'Chloe', 'Rivera', 'Valet', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-621', 'Mia', 'Reed', 'Driver', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-622', 'Zoey', 'Campbell', 'Spa therapist', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-623', 'Mila', 'Roberts', 'Fitness instructor', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-624', 'Luna', 'Cook', 'Lifeguard', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-625', 'Leo', 'Baker', 'Accountant', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-626', 'Hazel', 'Gonzalez', 'Human resources', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-627', 'Mila', 'Perez', 'Marketing', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37),
('000-000-628', 'Liam', 'Hill', 'Customer service', 105, 'Reforma Ave', 'Mexico City', '06030', 'MX', 37);

UPDATE hotel
SET sin_manager = '000-000-612'
WHERE id_hotel = 37;

-- Inserting employee for TRYP by Wyndham Mexico City World Trade Center Area Hotel

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-629', 'Aria', 'Baker', 'Manager', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-630', 'Ella', 'Gonzalez', 'Receptionist', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-631', 'Logan', 'Perez', 'Housekeeper', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-632', 'Aiden', 'Sanchez', 'Maintenance', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-633', 'Chloe', 'Rivera', 'Security', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-634', 'Mia', 'Reed', 'Cook', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-635', 'Zoey', 'Campbell', 'Waiter', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-636', 'Mila', 'Roberts', 'Concierge', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-637', 'Luna', 'Cook', 'Valet', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-638', 'Leo', 'Baker', 'Driver', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-639', 'Hazel', 'Gonzalez', 'Spa therapist', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-640', 'Mila', 'Perez', 'Fitness instructor', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-641', 'Liam', 'Hill', 'Lifeguard', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-642', 'Aria', 'Baker', 'Accountant', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-643', 'Ella', 'Gonzalez', 'Human resources', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-644', 'Logan', 'Perez', 'Marketing', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38),
('000-000-645', 'Aiden', 'Sanchez', 'Customer service', 45, 'Insurgentes Sur Ave', 'Mexico City', '06140', 'MX', 38);

UPDATE hotel
SET sin_manager = '000-000-629'
WHERE id_hotel = 38;

-- Inserting employee for Microtel Inn & Suites by Wyndham Mexico City

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-646', 'Chloe', 'Rivera', 'Manager', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-647', 'Mia', 'Reed', 'Receptionist', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-648', 'Zoey', 'Campbell', 'Housekeeper', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-649', 'Mila', 'Roberts', 'Maintenance', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-650', 'Luna', 'Cook', 'Security', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-651', 'Leo', 'Baker', 'Cook', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-652', 'Hazel', 'Gonzalez', 'Waiter', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-653', 'Mila', 'Perez', 'Concierge', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-654', 'Liam', 'Hill', 'Valet', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-655', 'Aria', 'Baker', 'Driver', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-656', 'Ella', 'Gonzalez', 'Spa therapist', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-657', 'Logan', 'Perez', 'Fitness instructor', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-658', 'Aiden', 'Sanchez', 'Lifeguard', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-659', 'Chloe', 'Rivera', 'Accountant', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-660', 'Mia', 'Reed', 'Human resources', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-661', 'Zoey', 'Campbell', 'Marketing', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39),
('000-000-662', 'Mila', 'Roberts', 'Customer service', 5, 'de Febrero Ave', 'Mexico City', '06080', 'MX', 39);

UPDATE hotel
SET sin_manager = '000-000-646'
WHERE id_hotel = 39;

-- Inserting employee for La Quinta by Wyndham Mexico City

INSERT INTO employee (sin_employee, firstname, lastname, role, street_number, street_name, city, postal_code, country, id_hotel) VALUES
('000-000-663', 'Luna', 'Cook', 'Manager', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-664', 'Leo', 'Baker', 'Receptionist', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-665', 'Hazel', 'Gonzalez', 'Housekeeper', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-666', 'Mila', 'Perez', 'Maintenance', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-667', 'Liam', 'Hill', 'Security', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-668', 'Aria', 'Baker', 'Cook', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-669', 'Ella', 'Gonzalez', 'Waiter', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-670', 'Logan', 'Perez', 'Concierge', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-671', 'Aiden', 'Sanchez', 'Valet', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-672', 'Chloe', 'Rivera', 'Driver', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-673', 'Mia', 'Reed', 'Spa therapist', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-674', 'Zoey', 'Campbell', 'Fitness instructor', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-675', 'Mila', 'Roberts', 'Lifeguard', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-676', 'Luna', 'Cook', 'Accountant', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-677', 'Leo', 'Baker', 'Human resources', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-678', 'Hazel', 'Gonzalez', 'Marketing', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40),
('000-000-679', 'Mila', 'Perez', 'Customer service', 55, 'Insurgentes Sur Ave', 'Mexico City', '06000', 'MX', 40);

UPDATE hotel
SET sin_manager = '000-000-663'
WHERE id_hotel = 40;


-- Inserting commodity

INSERT INTO commodity (name) VALUES
('TV'),
('Air conditionning'),
('Wifi'),
('Fridge'),
('Microwave'),
('Stove'),
('Sauna'),
('Jacuzzi');

-- Inserting room

-- Insert rooms for hotels 1 to 40
INSERT INTO room (id_room, room_number, availability, price, view, extensible, capacity, id_hotel)
SELECT
    (SELECT COALESCE(MAX(id_room), 0) FROM room) + ROW_NUMBER() OVER (ORDER BY hotel_id, room_number) AS id_room,
    room_number,
    TRUE AS availability, -- Assuming all rooms are initially available
    CASE capacity
        WHEN 'Simple' THEN 50.00
        WHEN 'Double' THEN 70.00
        WHEN 'Triple' THEN 90.00
        WHEN 'Quadruple' THEN 110.00
        WHEN 'Suite' THEN 150.00
        WHEN 'Penthouse' THEN 200.00
    END AS price,
    view,
    CASE
        WHEN capacity = 'Simple' THEN FALSE
        WHEN capacity = 'Double' THEN FALSE
        WHEN capacity = 'Suite' THEN FALSE
        WHEN capacity = 'Penthouse' THEN FALSE
        ELSE TRUE
    END AS extensible, -- Set extensible value based on capacity
    capacity,
    hotel_id
FROM
(
    SELECT
        hotel_id,
        (ROW_NUMBER() OVER (PARTITION BY hotel_id ORDER BY RANDOM())) AS room_number,
        CASE
            WHEN MOD(hotel_id, 12) = 0 THEN 'Sea'
            WHEN MOD(hotel_id, 12) = 1 THEN 'Mountain'
            WHEN MOD(hotel_id, 12) = 2 THEN 'City'
            WHEN MOD(hotel_id, 12) = 3 THEN 'Garden'
            WHEN MOD(hotel_id, 12) = 4 THEN 'Pool'
            WHEN MOD(hotel_id, 12) = 5 THEN 'Lake'
            WHEN MOD(hotel_id, 12) = 6 THEN 'Forest'
            WHEN MOD(hotel_id, 12) = 7 THEN 'River'
            WHEN MOD(hotel_id, 12) = 8 THEN 'Park'
            WHEN MOD(hotel_id, 12) = 9 THEN 'Courtyard'
            WHEN MOD(hotel_id, 12) = 10 THEN 'Street'
            ELSE 'Other'
        END AS view,
        CASE
            WHEN MOD(hotel_id, 6) = 0 THEN 'Simple'
            WHEN MOD(hotel_id, 6) = 1 THEN 'Double'
            WHEN MOD(hotel_id, 6) = 2 THEN 'Triple'
            WHEN MOD(hotel_id, 6) = 3 THEN 'Quadruple'
            WHEN MOD(hotel_id, 6) = 4 THEN 'Suite'
            ELSE 'Penthouse'
        END AS capacity
    FROM
        generate_series(1, 40) AS hotel_id
    CROSS JOIN
        generate_series(1, 5) AS room_count
) AS room_info;


-- Inserting room_commodity

--INSERT INTO room_commodity (id_room, commodity_name)
--SELECT
--    id,
--    c.name
--FROM
--    generate_series(1, 200) AS id, 
--    (SELECT name FROM commodity ORDER BY RANDOM() LIMIT 5) AS c;


INSERT INTO problem(id, name, description)
VALUES
    (1, 'Room not clean', 'The room was not clean when I arrived'),
    (2, 'Broken TV', 'The TV in the room is not working properly'),
    (3, 'Faulty air conditioning', 'The air conditioning unit in the room is not cooling properly'),
    (4, 'No wifi', 'The wifi in the room is not working'),
    (5, 'Fridge not working', 'The fridge in the room is not cooling properly'),
    (6, 'Microwave not working', 'The microwave in the room is not heating properly'),
    (7, 'Stove not working', 'The stove in the room is not heating properly'),
    (8, 'Sauna not working', 'The sauna in the room is not heating properly'),
    (9, 'Jacuzzi not working', 'The jacuzzi in the room is not heating properly');




-- Indexes

-- Faster search for backend applications

CREATE INDEX idx_hotel_chain_name
ON hotel_chain (name);

CREATE INDEX idx_hotel_chain_id_hotel_chain
ON hotel_chain (id_hotel_chain);

CREATE INDEX idx_hotel_id_hotel 
ON hotel (id_hotel);

CREATE INDEX idx_hotel_rooms_number
ON hotel (rooms_number);

CREATE INDEX idx_hotel_start_number
ON hotel (start_number);

CREATE INDEX idx_room_id_room
ON room (id_room);

-- Créer un index sur la colonne city de la table hotel

CREATE INDEX idx_hotel_city
ON hotel (city);

-- Créer un index sur la colonne country de la table hotel

CREATE INDEX idx_hotel_country
ON hotel (country);

-- Créer un index sur la colonne availability de la table room

CREATE INDEX idx_room_availability
ON room (availability);

-- Créer un index sur la colonne id_hotel de la table room

CREATE INDEX idx_booking_id_room
ON booking (id_room);

--- Créer un index sur la colonne id_hotel de la table room

CREATE INDEX idx_rental_id_room
ON rental (id_room);

-- Créer un index sur la colonne capacity de la table room

CREATE INDEX idx_room_capacity
ON room (capacity);

-- Créer un index sur la colonne price de la table room

CREATE INDEX idx_room_price
ON room (price);

-- Créer un index sur la colonne view de la table room

CREATE INDEX idx_room_view
ON room (view);

-- Créer un index sur la colonne extensible de la table room

CREATE INDEX idx_room_id_hotel
ON room (id_hotel);

-- Créer un index sur la colonne extensible de la table room

CREATE INDEX idx_booking_sin_customer
ON booking (sin_customer);

-- Créer un index sur la colonne id_hotel de la table booking

CREATE INDEX idx_rental_sin_customer
ON rental (sin_customer);



-- Notre 1ere vue
CREATE VIEW ViewAvailableRoomsByArea AS
SELECT h.city, COUNT(*) as available_rooms
FROM room r
JOIN hotel h ON r.id_hotel = h.id_hotel
WHERE r.availability = True 
GROUP BY h.city;

-- Notre 2eme vue

CREATE VIEW ViewCapacityByHotel AS
select h.name, r.capacity, r.room_number
from hotel as h, room as r
where h.id_hotel = r.id_hotel
group by h.name, r.capacity, r.room_number


