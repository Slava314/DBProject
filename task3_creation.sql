drop schema if exists
    avia cascade;

create schema
    avia;

drop table if exists avia.clients cascade;
create table avia.clients (
    client_id       serial primary key,
    client_name     varchar(100) not null,
    passport_number varchar(9)   not null check (regexp_match(passport_number, '[0-9]{9}') notnull),
    citizenship     varchar(100) not null
);

drop table if exists avia.airplane_models cascade;
create table avia.airplane_models (
    model        varchar(100) primary key,
    capacity     integer not null check (capacity > 0),
    flight_range integer not null check (capacity > 0)
);

drop table if exists avia.airplanes cascade;
create table avia.airplanes (
    airplane_id        serial primary key,
    model              varchar(100) not null references avia.airplane_models (model),
    start_of_operation date         not null
);

drop table if exists avia.airports cascade;
create table avia.airports (
    code_IATA varchar(3) primary key,
    city      varchar(100) not null,
    country   varchar(100) not null
);

drop table if exists avia.routes cascade;
create table avia.routes (
    route_id       serial primary key,
    duration       integer not null check ( duration > 0 ),
    departure_IATA varchar(3) references avia.airports (code_IATA),
    arrival_IATA   varchar(3) references avia.airports (code_IATA)
);

drop table if exists avia.flights cascade;
create table avia.flights (
    flight_id      serial primary key,
    airplane_id    integer                  not null references avia.airplanes (airplane_id),
    route_id       integer                  not null references avia.routes (route_id),
    departure_time timestamp not null check (departure_time < arrival_time),
    arrival_time   timestamp not null check (departure_time < arrival_time)
);

drop table if exists avia.tickets cascade;
create table avia.tickets (
    seat_number varchar(4) check (regexp_match(seat_number, '[A-Z][0-9]{3}') notnull),
    flight_id   integer not null references avia.flights (flight_id),
    client_id   integer not null references avia.clients (client_id),
    t_class     char    not null check (t_class in ('E', 'B')),
    price       integer not null check ( price >= 0 ),
    primary key (seat_number, flight_id)
);


drop table if exists avia.crew_members cascade;
create table avia.crew_members (
    member_id     serial primary key,
    member_name   varchar(100) not null,
    date_of_birth date         not null,
    member_role   varchar(100) not null
);

drop table if exists avia.flights_x_crew_members cascade;
create table avia.flights_x_crew_members (
    flight_id integer references avia.flights (flight_id),
    member_id integer references avia.crew_members (member_id),
    primary key (flight_id, member_id)
);

drop table if exists avia.route_time cascade;
create table avia.route_time (
    route_id       integer not null references avia.routes (route_id),
    day_of_week    varchar(3) check (day_of_week in ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun') ),
    departure_time time,
    periodicity    varchar(100) check (regexp_match(periodicity, '[0-4] weeks [0-9] months') notnull ),
    valid_from     timestamp,
    valid_to       timestamp,
    primary key (route_id, day_of_week, departure_time, periodicity, valid_from)
);

