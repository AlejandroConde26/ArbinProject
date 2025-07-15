DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetIngresosGeneralesMensuales`(
    IN inputYear INT
)
BEGIN
    SELECT 
        MONTH(p.PAYMENTDATE) AS mes,
        SUM(p.AMOUNT) AS ingreso_total
    FROM payment p
    WHERE YEAR(p.PAYMENTDATE) = inputYear
      AND p.PAYMENTSTATUS = 'Pagado'
    GROUP BY MONTH(p.PAYMENTDATE)
    ORDER BY mes;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetIngresosMensualesPorHost`(
    IN inputYear INT
)
BEGIN
    SELECT 
        h.ID_HOST AS host_id,
        u.FULL_NAME AS host_name,
        ho.HOUSINGID AS housing_id,
        ho.COMMERCIALNAME AS housing_name,
        MONTH(p.PAYMENTDATE) AS mes,
        SUM(p.AMOUNT) AS ingreso_total
    FROM payment p
    INNER JOIN reservation r ON p.reservationId = r.RESERVATIONID
    INNER JOIN housing ho ON r.housing_id = ho.HOUSINGID
    INNER JOIN host h ON ho.host_id = h.ID_HOST
    INNER JOIN user u ON h.user_id = u.ID_USERS
    WHERE YEAR(p.PAYMENTDATE) = inputYear
      AND p.PAYMENTSTATUS = 'Pagado'
    GROUP BY h.ID_HOST, u.FULL_NAME, ho.HOUSINGID, ho.COMMERCIALNAME, MONTH(p.PAYMENTDATE)
    ORDER BY h.ID_HOST, ho.HOUSINGID, mes;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ActualizarServicio`(
    IN p_ID_Servicio INT,
    IN p_Descripcion VARCHAR(255),
    IN p_NombreServicio VARCHAR(255),
    IN p_Estado TINYINT(1)
)
BEGIN
    UPDATE services
    SET
        DESCRIPTION = p_Descripcion,
        NAME_SERVICE = p_NombreServicio,
        STATUS = p_Estado
    WHERE ID_SERVICE = p_ID_Servicio;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscar_pago_por_id`(IN id_pago INT)
BEGIN
    SELECT 
        p.PAYMENTID,
        p.AMOUNT,
        p.CREATEDDATE,
        p.ENDDATE,
        p.PAYMENTDATE,
        p.PAYMENTSTATUS,
        p.UPDATEDDATE,
        p.reservationId,
        p.payment_method_id,
        pm.METHODNAME AS metodo_pago
    FROM payment p
    LEFT JOIN paymentmethod pm ON p.payment_method_id = pm.PAYMENTMETHODID
    WHERE p.PAYMENTID = id_pago;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_crear_cupon`(
  IN p_code VARCHAR(50),
  IN p_description VARCHAR(255),
  IN p_discount_type VARCHAR(20),
  IN p_discount_value DECIMAL(10,2),
  IN p_min_stay_nights INT,
  IN p_valid_from DATE,
  IN p_valid_until DATE,
  IN p_usage_limit_per_coupon INT,
  IN p_usage_limit_per_user INT,
  IN p_active BOOLEAN
)
BEGIN
  INSERT INTO coupon (
    code,
    description,
    discount_type,
    discount_value,
    min_stay_nights,
    valid_from,
    valid_until,
    usage_limit_per_coupon,
    usage_limit_per_user,
    active
  ) VALUES (
    p_code,
    p_description,
    p_discount_type,
    p_discount_value,
    p_min_stay_nights,
    p_valid_from,
    p_valid_until,
    p_usage_limit_per_coupon,
    p_usage_limit_per_user,
    p_active
  );
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_housing_category`(
    IN p_name VARCHAR(100),
    IN p_description TEXT
)
BEGIN
    INSERT INTO housingcategory (CATEGORYNAME, CATEGORYDESCRIPTION)
    VALUES (p_name, p_description);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_housing_category`(
    IN p_id INT
)
BEGIN
    DELETE FROM housingcategory
    WHERE CATEGORYID = p_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_coupon`(
  IN p_id_coupon INT,
  IN p_code VARCHAR(50),
  IN p_description VARCHAR(255),
  IN p_discount_type VARCHAR(20),
  IN p_discount_value DECIMAL(10,2),
  IN p_min_stay_nights INT,
  IN p_valid_from DATE,
  IN p_valid_until DATE,
  IN p_usage_limit_per_coupon INT,
  IN p_usage_limit_per_user INT,
  IN p_active BOOLEAN
)
BEGIN
  START TRANSACTION;

  IF NOT EXISTS (SELECT 1 FROM coupon WHERE id = p_id_coupon) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cupón no encontrado';
  END IF;

  UPDATE coupon
  SET
    code = p_code,
    description = p_description,
    discount_type = p_discount_type,
    discount_value = p_discount_value,
    min_stay_nights = p_min_stay_nights,
    valid_from = p_valid_from,
    valid_until = p_valid_until,
    usage_limit_per_coupon = p_usage_limit_per_coupon,
    usage_limit_per_user = p_usage_limit_per_user,
    active = p_active
  WHERE id = p_id_coupon;

  COMMIT;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_pago`(
    IN id_pago INT,
    IN nuevo_monto FLOAT,
    IN nueva_fecha_fin DATE,
    IN nueva_fecha_pago DATE,
    IN nuevo_estado VARCHAR(50),
    IN nueva_fecha_actualizacion DATE,
    IN nuevo_metodo INT
)
BEGIN
    UPDATE payment
    SET 
        AMOUNT = nuevo_monto,
        ENDDATE = nueva_fecha_fin,
        PAYMENTDATE = nueva_fecha_pago,
        PAYMENTSTATUS = nuevo_estado,
        UPDATEDDATE = nueva_fecha_actualizacion,
        payment_method_id = nuevo_metodo
    WHERE PAYMENTID = id_pago;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_coupon`(
  IN p_id_coupon INT
)
BEGIN
  DECLARE v_exists INT;
  DECLARE v_error_msg VARCHAR(255);

  -- Verificar si el cupón existe
  SELECT COUNT(*) INTO v_exists FROM coupon WHERE id = p_id_coupon;

  IF v_exists = 0 THEN
    SET v_error_msg = 'Cupón no existe con ID: ';
    SET v_error_msg = CONCAT(v_error_msg, p_id_coupon);

    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = v_error_msg;

  ELSE
    DELETE FROM coupon WHERE id = p_id_coupon;
  END IF;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_pago`(IN id_pago INT)
BEGIN
    DELETE FROM payment WHERE PAYMENTID = id_pago;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EliminarServicio`(
    IN p_ID_Servicio INT
)
BEGIN
    UPDATE services
    SET STATUS = 0
    WHERE ID_SERVICE = p_ID_Servicio;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_all_housing_categories`()
BEGIN
    SELECT * FROM housingcategory;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_housing_category_by_id`(
IN p_id INT
)
BEGIN
SELECT * FROM housingcategory
WHERE CATEGORYID = p_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_housing_category_by_name`(
    IN p_name VARCHAR(100)
)
BEGIN
    SELECT * FROM housingcategory
    WHERE CATEGORYNAME = p_name;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_housing_metrics`(
    IN p_housing_id INT,
    IN p_month INT,
    IN p_year INT
)
BEGIN
    IF p_month < 1 OR p_month > 12 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El mes debe estar entre 1 y 12';
    END IF;

    IF p_year < 1900 OR p_year > 2025 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El año debe estar entre 1900 y 2025';
    END IF;

    IF (SELECT COUNT(*) FROM reservation r 
        WHERE r.housing_id = p_housing_id 
        AND MONTH(r.CREATEDDATE) = p_month 
        AND YEAR(r.CREATEDDATE) = p_year) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay datos para el alojamiento, mes y año especificados';
    END IF;

    SELECT 
        COALESCE(SUM(r.totalPrice), 0) AS total_revenue,
        COALESCE(AVG(CAST(r.numberOfAdults + r.numberOfChildren AS DECIMAL) / (h.numHabitaciones * 4)), 0) * 100 AS average_occupancy,
        COALESCE(SUM(r.numberOfAdults + r.numberOfChildren), 0) AS total_guests,
        h.stars,
        h.city,
        h.country,
        h.commercialName AS housing_name,
        u.full_name AS host_name
    FROM reservation r
    JOIN housing h ON r.housing_id = h.housingId
    JOIN host ho ON h.host_id = ho.id_Host
    JOIN user u ON ho.user_id = u.id_users
    WHERE r.housing_id = p_housing_id
      AND r.CREATEDDATE >= CONCAT(p_year, '-', LPAD(p_month, 2, '0'), '-01')
      AND r.CREATEDDATE < CONCAT(IF(p_month = 12, p_year + 1, p_year), '-', LPAD(IF(p_month = 12, 1, p_month + 1), 2, '0'), '-01')
    GROUP BY h.housingId, h.stars, h.city, h.country, h.commercialName, u.full_name;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_top_housing_reservations`(IN p_year INT)
BEGIN
    WITH RankedReservations AS (
        SELECT 
            MONTH(r.createdDate) AS reservation_month,
            r.housing_id,
            COUNT(*) AS total_reservations,
            ROW_NUMBER() OVER (PARTITION BY MONTH(r.createdDate) ORDER BY COUNT(*) DESC) AS rank_num
        FROM reservation r
        JOIN housing h ON r.housing_id = h.housingId
        WHERE YEAR(r.createdDate) = p_year
        GROUP BY MONTH(r.createdDate), r.housing_id
    )
    SELECT 
        reservation_month,
        housing_id,
        total_reservations
    FROM RankedReservations
    WHERE rank_num = 1
    ORDER BY reservation_month, total_reservations DESC;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_hosts_mas_alojamientos`()
BEGIN
    SELECT  
        u.FULL_NAME AS nombre_anfitrion,
        u.EMAIL AS correo,
        u.PHONE AS telefono,
        COUNT(h.HOUSINGID) AS total_alojamientos,
        ROUND(AVG(h.PRICENIGHT), 2) AS precio_promedio,
        COUNT(DISTINCT h.CITY) AS cantidad_ciudades,
        SUM(CASE WHEN h.STATUS = 'activo' THEN 1 ELSE 0 END) AS alojamientos_activos,
        MAX(h.CREATEDDATE) AS ultima_publicacion
    FROM host AS ho
    JOIN user AS u ON ho.user_id = u.ID_USERS
    LEFT JOIN housing AS h ON h.host_id = ho.ID_HOST
    GROUP BY ho.ID_HOST, u.FULL_NAME, u.EMAIL, u.PHONE
    ORDER BY total_alojamientos DESC;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InsertarServicio`(
    IN p_Descripcion VARCHAR(255),
    IN p_NombreServicio VARCHAR(255)
)
BEGIN
    INSERT INTO services (DESCRIPTION, NAME_SERVICE, STATUS)
    VALUES (p_Descripcion, p_NombreServicio, 1);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_leer_coupons`()
BEGIN
    SELECT
        id,
        code,
        description,
        discount_type,
        discount_value,
        min_stay_nights,
        valid_from,
        valid_until,
        usage_limit_per_coupon,
        usage_limit_per_user,
        active
    FROM
        coupon
    ORDER BY
        valid_until DESC, id ASC;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_pagos`()
BEGIN
    SELECT 
        p.PAYMENTID,
        p.AMOUNT,
        p.CREATEDDATE,
        p.ENDDATE,
        p.PAYMENTDATE,
        p.PAYMENTSTATUS,
        p.UPDATEDDATE,
        p.reservationId AS reserva_id,
        p.payment_method_id AS metodo_pago_id,
        pm.METHODNAME AS metodo_pago
    FROM payment p
    LEFT JOIN paymentmethod pm 
        ON p.payment_method_id = pm.PAYMENTMETHODID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SeleccionarServicioPorId`(
    IN p_ID_Servicio INT
)
BEGIN
    SELECT ID_SERVICE, DESCRIPTION, NAME_SERVICE, STATUS
    FROM services
    WHERE ID_SERVICE = p_ID_Servicio;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SeleccionarTodosLosServicios`()
BEGIN
    SELECT ID_SERVICE, DESCRIPTION, NAME_SERVICE, STATUS
    FROM services;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_housing_category`(
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_description TEXT
)
BEGIN
    UPDATE housingcategory
    SET CATEGORYNAME = p_name,
        CATEGORYDESCRIPTION = p_description
    WHERE CATEGORYID = p_id;
END$$
DELIMITER ;
