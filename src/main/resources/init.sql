DROP DATABASE IF EXISTS java_database_usage;
CREATE DATABASE java_database_usage;

CREATE TABLE java_database_usage.vehicle_shops (
    shop_id INT PRIMARY KEY AUTO_INCREMENT,
    address VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE java_database_usage.customers (
    customer_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    phone CHAR(10) NOT NULL UNIQUE
);

CREATE TABLE java_database_usage.cars_info (
    info_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    make VARCHAR(20) NOT NULL,
    model VARCHAR(40) NOT NULL,
    manufacture_year SMALLINT NOT NULL,
    new_car_price DECIMAL(15,2) CHECK (new_car_price > 0),
    car_type VARCHAR(20) NOT NULL,
    door_amount TINYINT DEFAULT 4,
    is_electric BOOLEAN DEFAULT false,
    UNIQUE (make, model, manufacture_year),
    CONSTRAINT `cars_info_manufacture_year` CHECK (
        manufacture_year > 1000
        AND
        manufacture_year < 3000
    ),
    INDEX (make, model),
    INDEX (car_type)
);

CREATE TABLE java_database_usage.trucks_info (
    info_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    make VARCHAR(20) NOT NULL,
    model VARCHAR(40) NOT NULL,
    manufacture_year SMALLINT NOT NULL,
    new_truck_price DECIMAL(15,2) CHECK (new_truck_price > 0),
    truck_type VARCHAR(20) NOT NULL,
    max_load_capacity FLOAT,
    UNIQUE (make, model, manufacture_year),
    CONSTRAINT `trucks_info_manufacture_year` CHECK (
        manufacture_year > 1000
        AND
        manufacture_year < 3000
    ),
    INDEX (make, model),
    INDEX (truck_type)
);

CREATE TABLE java_database_usage.motos_info (
    info_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    make VARCHAR(20) NOT NULL,
    model VARCHAR(40) NOT NULL,
    manufacture_year SMALLINT NOT NULL,
    new_moto_price DECIMAL(15,2) CHECK (new_moto_price > 0),
    moto_type VARCHAR(20) NOT NULL,
    has_helmet_storage BOOLEAN DEFAULT false,
    riding_position VARCHAR(20) NOT NULL,
    UNIQUE (make, model, manufacture_year),
    CONSTRAINT `motos_info_manufacture_year` CHECK (
        manufacture_year > 1000
        AND
        manufacture_year < 3000
    ),
    INDEX (make, model),
    INDEX (moto_type)
);

CREATE TABLE java_database_usage.cars (
    vin CHAR(17) PRIMARY KEY,
    real_car_price DECIMAL(15,2) CHECK (real_car_price > 0),
    color VARCHAR(20) NOT NULL,
    car_status VARCHAR(10) NOT NULL DEFAULT 'NEW',
    info_id BIGINT NOT NULL,
    shop_id INT,
    FOREIGN KEY (info_id) REFERENCES java_database_usage.cars_info(info_id),
    FOREIGN KEY (shop_id) REFERENCES java_database_usage.vehicle_shops(shop_id) ON DELETE SET NULL
);

CREATE TABLE java_database_usage.trucks (
    vin CHAR(17) PRIMARY KEY,
    real_truck_price DECIMAL(15,2) CHECK (real_truck_price > 0),
    color VARCHAR(20) NOT NULL,
    truck_status VARCHAR(10) NOT NULL DEFAULT 'NEW',
    info_id BIGINT NOT NULL,
    shop_id INT,
    FOREIGN KEY (info_id) REFERENCES java_database_usage.trucks_info(info_id),
    FOREIGN KEY (shop_id) REFERENCES java_database_usage.vehicle_shops(shop_id) ON DELETE SET NULL
);

CREATE TABLE java_database_usage.motos (
    vin CHAR(17) PRIMARY KEY,
    real_moto_price DECIMAL(15,2) CHECK (real_moto_price > 0),
    color VARCHAR(20) NOT NULL,
    moto_status VARCHAR(10) NOT NULL DEFAULT 'NEW',
    info_id BIGINT NOT NULL,
    shop_id INT,
    FOREIGN KEY (info_id) REFERENCES java_database_usage.motos_info(info_id),
    FOREIGN KEY (shop_id) REFERENCES java_database_usage.vehicle_shops(shop_id) ON DELETE SET NULL
);

CREATE TABLE java_database_usage.vehicles_available (
    shop_id INT NOT NULL,
    vehicle_info_id BIGINT NOT NULL,
    vehicle_type VARCHAR(20) NOT NULL,
    amount TINYINT NOT NULL DEFAULT 1,
    UNIQUE (shop_id, vehicle_info_id, vehicle_type),
    FOREIGN KEY (shop_id) REFERENCES java_database_usage.vehicle_shops(shop_id),
    INDEX (shop_id),
    INDEX (vehicle_info_id, vehicle_type)
);

CREATE TABLE java_database_usage.sales (
    sale_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    sale_date DATE NOT NULL,
    discount FLOAT DEFAULT 0 NOT NULL CHECK (discount >= 0),
    total_price DECIMAL(15,2) NOT NULL CHECK (total_price > 0),
    shop_id INT NOT NULL,
    vehicle_vin CHAR(17) NOT NULL,
    vehicle_type VARCHAR(20) NOT NULL,
    customer_id BIGINT NOT NULL,
    FOREIGN KEY (shop_id) REFERENCES java_database_usage.vehicle_shops(shop_id),
    FOREIGN KEY (customer_id) REFERENCES java_database_usage.customers(customer_id),
    INDEX (sale_date),
    INDEX (total_price),
    INDEX (customer_id)
);


DELIMITER $$

CREATE FUNCTION java_database_usage.check_vehicle_exists(vehicle_vin CHAR(17), vehicle_type VARCHAR(10))
    RETURNS BOOLEAN
    READS SQL DATA
BEGIN
    DECLARE vehicle_exists BOOLEAN DEFAULT FALSE;

    IF vehicle_type = 'CAR' THEN
        SELECT EXISTS(SELECT 1 FROM java_database_usage.cars WHERE vin = vehicle_vin)
        INTO vehicle_exists;
    ELSEIF vehicle_type = 'TRUCK' THEN
        SELECT EXISTS(SELECT 1 FROM java_database_usage.trucks WHERE vin = vehicle_vin)
        INTO vehicle_exists;
    ELSEIF vehicle_type = 'MOTO' THEN
        SELECT EXISTS(SELECT 1 FROM java_database_usage.motos WHERE vin = vehicle_vin)
        INTO vehicle_exists;
    ELSE
        SET @errorMsg = CONCAT('Unknown vehicle type: ', vehicle_type);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMsg;
    END IF;

    RETURN vehicle_exists;
END;
$$

CREATE FUNCTION java_database_usage.check_vehicle_info_exists(vehicle_info_id BIGINT, vehicle_type VARCHAR(10))
    RETURNS BOOLEAN
    READS SQL DATA
BEGIN
    DECLARE vehicle_info_exists BOOLEAN DEFAULT FALSE;

    IF vehicle_type = 'CAR' THEN
        SELECT EXISTS(SELECT 1 FROM java_database_usage.cars_info WHERE info_id = vehicle_info_id)
        INTO vehicle_info_exists;
    ELSEIF vehicle_type = 'TRUCK' THEN
        SELECT EXISTS(SELECT 1 FROM java_database_usage.trucks_info WHERE info_id = vehicle_info_id)
        INTO vehicle_info_exists;
    ELSEIF vehicle_type = 'MOTO' THEN
        SELECT EXISTS(SELECT 1 FROM java_database_usage.motos_info WHERE info_id = vehicle_info_id)
        INTO vehicle_info_exists;
    ELSE
        SET @errorMsg = CONCAT('Unknown vehicle type: ', vehicle_type);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMsg;
    END IF;

    RETURN vehicle_info_exists;
END;
$$

CREATE TRIGGER java_database_usage.vehicles_available_insert_trigger
    BEFORE INSERT ON java_database_usage.vehicles_available
    FOR EACH ROW
BEGIN
    IF NOT java_database_usage.check_vehicle_info_exists(NEW.vehicle_info_id, NEW.vehicle_type) THEN
        SET @errorMsg = CONCAT(NEW.vehicle_type, ' with id ', NEW.vehicle_info_id, ' not found');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMsg;
    END IF;
END;
$$

CREATE TRIGGER java_database_usage.vehicles_available_update_trigger
    BEFORE UPDATE ON java_database_usage.vehicles_available
    FOR EACH ROW
BEGIN
    IF NOT java_database_usage.check_vehicle_info_exists(NEW.vehicle_info_id, NEW.vehicle_type) THEN
        SET @errorMsg = CONCAT(NEW.vehicle_type, ' with id ', NEW.vehicle_info_id, ' not found');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMsg;
    END IF;
END;
$$

CREATE TRIGGER java_database_usage.sales_insert_trigger
    BEFORE INSERT ON java_database_usage.sales
    FOR EACH ROW
BEGIN
    IF NOT java_database_usage.check_vehicle_exists(NEW.vehicle_vin, NEW.vehicle_type) THEN
        SET @errorMsg = CONCAT(NEW.vehicle_type, ' with vin code ', NEW.vehicle_vin, ' not found');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMsg;
    END IF;
END;
$$

CREATE TRIGGER java_database_usage.sales_update_trigger
    BEFORE UPDATE ON java_database_usage.sales
    FOR EACH ROW
BEGIN
    IF NOT java_database_usage.check_vehicle_exists(NEW.vehicle_vin, NEW.vehicle_type) THEN
        SET @errorMsg = CONCAT(NEW.vehicle_type, ' with vin code ', NEW.vehicle_vin, ' not found');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMsg;
    END IF;
END;
$$

DELIMITER ;