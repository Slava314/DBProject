delete
    from avia.clients;

insert into avia.clients(client_name, passport_number, citizenship)
    values ('Bulbasaur','558892469', 'Russia');
insert into avia.clients(client_name, passport_number, citizenship)
    values ('Charmander','389174339', 'Russia');
insert into avia.clients(client_name, passport_number, citizenship)
    values ('Squirtle','493799879', 'Finland');
insert into avia.clients(client_name, passport_number, citizenship)
    values ('Pikachu','582950516', 'Japan');
insert into avia.clients(client_name, passport_number, citizenship)
    values ('Eevee','644086010', 'Germany');
insert into avia.clients(client_name, passport_number, citizenship)
    values ('Mewtwo','807867559', 'China');
insert into avia.clients(client_name, passport_number, citizenship)
    values ('Slowpoke','723214142', 'USA');

delete
    from avia.airplane_models;

insert into avia.airplane_models(model, capacity, flight_range)
    values ('Airbus A220', 130, 4000);
insert into avia.airplane_models(model, capacity, flight_range)
    values ('Airbus A350-900', 350, 13100);
insert into avia.airplane_models(model, capacity, flight_range)
    values ('Boeing 737 MAX', 200, 7100);
insert into avia.airplane_models(model, capacity, flight_range)
    values ('Boeing 777', 350, 12000);
insert into avia.airplane_models(model, capacity, flight_range)
    values ('Airbus A380', 525, 13000);

delete
    from avia.airplanes;

insert into avia.airplanes(model, start_of_operation)
    values ('Airbus A350-900', '2020-08-06');
insert into avia.airplanes(model, start_of_operation)
    values ('Airbus A220', '2021-03-24');
insert into avia.airplanes(model, start_of_operation)
    values ('Boeing 737 MAX', '2019-05-11');
insert into avia.airplanes(model, start_of_operation)
    values ('Boeing 777', '2017-03-20');
insert into avia.airplanes(model, start_of_operation)
    values ('Airbus A220', '2021-06-26');
insert into avia.airplanes(model, start_of_operation)
    values ('Airbus A380', '2016-12-27');
insert into avia.airplanes(model, start_of_operation)
    values ('Boeing 777', '2018-01-29');
insert into avia.airplanes(model, start_of_operation)
    values ('Boeing 737 MAX', '2018-03-03');

delete
    from avia.airports;

insert into avia.airports(code_iata, city, country)
    values ('SVO', 'Moscow', 'Russia');
insert into avia.airports(code_iata, city, country)
    values ('HEL', 'Helsinki', 'Finland');
insert into avia.airports(code_iata, city, country)
    values ('DME', 'Moscow', 'Russia');
insert into avia.airports(code_iata, city, country)
    values ('BER', 'Berlin', 'Germany');
insert into avia.airports(code_iata, city, country)
    values ('NRT', 'Tokyo', 'Japan');
insert into avia.airports(code_iata, city, country)
    values ('LHR', 'London', 'England');
insert into avia.airports(code_iata, city, country)
    values ('CDG', 'Paris', 'France');
insert into avia.airports(code_iata, city, country)
    values ('IST', 'Istanbul', 'Turkey');

delete from avia.routes;

insert into avia.routes(duration, departure_iata, arrival_iata)
    values (100, 'SVO', 'HEL');
insert into avia.routes(duration, departure_iata, arrival_iata)
    values (86, 'BER', 'LHR');
insert into avia.routes(duration, departure_iata, arrival_iata)
    values (615, 'NRT', 'DME');
insert into avia.routes(duration, departure_iata, arrival_iata)
    values (175, 'LHR', 'HEL');
insert into avia.routes(duration, departure_iata, arrival_iata)
    values (200, 'CDG', 'IST');
insert into avia.routes(duration, departure_iata, arrival_iata)
    values (675, 'IST', 'NRT');
insert into avia.routes(duration, departure_iata, arrival_iata)
    values (170, 'IST', 'SVO');
insert into avia.routes(duration, departure_iata, arrival_iata)
    values (180, 'HEL', 'CDG');
insert into avia.routes(duration, departure_iata, arrival_iata)
    values (146, 'DME', 'BER');

delete from avia.route_time;

insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
    values (1, 'Thu', '12:05', '1 weeks 0 months', '2021-06-08 12:11:00', '5999-01-01 00:00:00');
insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
    values (2, 'Sun', '16:34', '2 weeks 0 months', '2021-10-22 12:05:45', '2022-05-24 14:17:35');
insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
    values (3, 'Mon', '20:15', '1 weeks 0 months', '2021-08-10 16:17:24', '2021-07-27 09:05:36');
insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
    values (3, 'Mon', '20:45', '1 weeks 0 months', '2021-07-27 09:05:37', '5999-01-01 00:00:00');
insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
    values (4, 'Wed', '03:05', '0 weeks 1 months', '2022-01-14 15:56:28', '5999-01-01 00:00:00');
insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
    values (5, 'Sat', '21:53', '2 weeks 0 months', '2021-07-19 10:09:50', '5999-01-01 00:00:00');
insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
    values (6, 'Mon', '08:13', '1 weeks 0 months', '2021-09-11 23:33:24', '5999-01-01 00:00:00');
insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
    values (7, 'Thu', '10:47', '0 weeks 1 months', '2022-05-12 19:40:59', '5999-01-01 00:00:00');
insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
    values (8, 'Tue', '17:26', '2 weeks 0 months', '2021-07-12 10:59:35', '5999-01-01 00:00:00');
insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
    values (7, 'Fri', '12:28', '1 weeks 0 months', '2022-05-12 19:42:03', '5999-01-01 00:00:00');
insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
    values (9, 'Tue', '15:25', '1 weeks 0 months', '2021-10-29 06:06:10', '5999-01-01 00:00:00');
insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
    values (2, 'Sun', '16:34', '1 weeks 0 months', '2022-05-24 14:17:36', '5999-01-01 00:00:00');
insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
    values (9, 'Fri', '15:25', '1 weeks 0 months', '2022-09-05 17:13:34', '5999-01-01 00:00:00');


delete from avia.crew_members;

insert into avia.crew_members(member_name, date_of_birth, member_role)
    values ('Twilight Sparkle', '1988-10-20', 'pilot');
insert into avia.crew_members(member_name, date_of_birth, member_role)
    values ('Applejack', '1996-04-01', 'flight attendant');
insert into avia.crew_members(member_name, date_of_birth, member_role)
    values ('Rainbow Dash', '1991-12-29', 'pilot');
insert into avia.crew_members(member_name, date_of_birth, member_role)
    values ('Pinkie Pie', '2000-11-03', 'flight attendant');
insert into avia.crew_members(member_name, date_of_birth, member_role)
    values ('Rarity', '1998-10-08', 'flight attendant');
insert into avia.crew_members(member_name, date_of_birth, member_role)
    values ('Fluttershy', '1990-04-07', 'pilot');

delete from avia.flights;

insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
    values (1, 2, '2022-07-24 16:34:00', '2022-07-24 18:00:00');
insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
    values (2, 3, '2022-04-25 20:45:00', '2022-04-26 07:00:00');
insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
    values (4, 5, '2022-03-12 21:53:00', '2022-03-13 01:13:00');
insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
    values (7, 6, '2021-12-13 08:13:00', '2021-12-13 19:28:00');
insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
    values (8, 2, '2022-05-08 16:34:00', '2022-05-08 18:00:00');
insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
    values (3, 4, '2022-10-12 03:05:00', '2022-10-12 06:00:00');
insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
    values (2, 5, '2021-08-21 21:53:00', '2021-08-22 01:13:00');
insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
    values (6, 1, '2021-12-09 12:05:00', '2021-12-09 13:45:00');
insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
    values (7, 9, '2022-11-15 15:25:00', '2022-11-15 17:51:00');
insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
    values (8, 9, '2022-11-04 15:25:00', '2022-11-04 17:51:00');
insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
    values (1, 8, '2022-07-26 17:26:00', '2022-07-26 20:26:00');
insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
    values (5, 7, '2022-09-16 12:28:00', '2022-09-16 15:18:00');
insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
    values (6, 2, '2022-04-10 16:34:00', '2022-04-10 18:00:00');


delete from avia.flights_x_crew_members;

insert into avia.flights_x_crew_members(flight_id, member_id)
    values (1, 1);
insert into avia.flights_x_crew_members(flight_id, member_id)
    values (1, 2);

insert into avia.flights_x_crew_members(flight_id, member_id)
    values (2, 3);
insert into avia.flights_x_crew_members(flight_id, member_id)
    values (2, 5);

insert into avia.flights_x_crew_members(flight_id, member_id)
    values (3, 3);
insert into avia.flights_x_crew_members(flight_id, member_id)
    values (3, 2);

insert into avia.flights_x_crew_members(flight_id, member_id)
    values (4, 6);
insert into avia.flights_x_crew_members(flight_id, member_id)
    values (4, 4);

insert into avia.flights_x_crew_members(flight_id, member_id)
    values (5, 3);
insert into avia.flights_x_crew_members(flight_id, member_id)
    values (5, 2);

insert into avia.flights_x_crew_members(flight_id, member_id)
    values (6, 6);
insert into avia.flights_x_crew_members(flight_id, member_id)
    values (6, 5);

insert into avia.flights_x_crew_members(flight_id, member_id)
    values (7, 1);
insert into avia.flights_x_crew_members(flight_id, member_id)
    values (7, 4);

insert into avia.flights_x_crew_members(flight_id, member_id)
    values (8, 3);
insert into avia.flights_x_crew_members(flight_id, member_id)
    values (8, 4);

insert into avia.flights_x_crew_members(flight_id, member_id)
    values (9, 1);
insert into avia.flights_x_crew_members(flight_id, member_id)
    values (9, 5);

insert into avia.flights_x_crew_members(flight_id, member_id)
    values (10, 3);
insert into avia.flights_x_crew_members(flight_id, member_id)
    values (10, 4);

insert into avia.flights_x_crew_members(flight_id, member_id)
    values (11, 3);
insert into avia.flights_x_crew_members(flight_id, member_id)
    values (11, 2);

insert into avia.flights_x_crew_members(flight_id, member_id)
    values (12, 1);
insert into avia.flights_x_crew_members(flight_id, member_id)
    values (12, 4);

insert into avia.flights_x_crew_members(flight_id, member_id)
    values (13, 6);
insert into avia.flights_x_crew_members(flight_id, member_id)
    values (13, 2);

delete from avia.tickets;

insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('A009', 1, 7, 'E', 15000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('B001', 2, 5, 'E', 30000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('D029', 3, 4, 'E', 21000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('A014', 4, 1, 'B', 150000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('F002', 4, 2, 'E', 40000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('A014', 5, 3, 'E', 10000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('E018', 6, 2, 'E', 12000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('C016', 7, 6, 'B', 80000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('A021', 8, 4, 'E', 9000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('C019', 9, 5, 'E', 16000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('B020', 10, 7, 'E', 20000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('D031', 11, 6, 'B', 95000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('F025', 12, 1, 'E', 19000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('E017', 12, 2, 'E', 14000);
insert into avia.tickets (seat_number, flight_id, client_id, t_class, price)
    values ('A016', 13, 3, 'B', 100000);
