drop schema if exists
    db_project cascade;

create schema
    db_project;

set
    search_path = db_project;

drop table if exists clients cascade;
create table clients (
    client_id       serial primary key,
    client_name     varchar(100) not null,
    passport_number varchar(9)   not null check (regexp_match(passport_number, '[0-9]{9}') notnull),
    citizenship     varchar(100) not null
);

drop table if exists airplane_models cascade;
create table airplane_models (
    model        varchar(100) primary key,
    capacity     integer not null check (capacity > 0),
    flight_range integer not null check (capacity > 0)
);

drop table if exists airplanes cascade;
create table airplanes (
    airplane_id        serial primary key,
    model              varchar(100) not null references airplane_models (model),
    start_of_operation date         not null
);

drop table if exists airports cascade;
create table airports (
    code_IATA varchar(3) primary key,
    city      varchar(100) not null,
    country   varchar(100) not null
);

drop table if exists routes cascade;
create table routes (
    route_id       serial primary key,
    duration       integer not null check ( duration > 0 ),
    departure_IATA varchar(3) references airports (code_IATA),
    arrival_IATA   varchar(3) references airports (code_IATA)
);

drop table if exists flights cascade;
create table flights (
    flight_id      serial primary key,
    airplane_id    integer                  not null references airplanes (airplane_id),
    route_id       integer                  not null references routes (route_id),
    departure_time timestamp with time zone not null check (departure_time < arrival_time),
    arrival_time   timestamp with time zone not null check (departure_time < arrival_time)
);

drop table if exists tickets cascade;
create table tickets (
    seat_number varchar(4) check (regexp_match(seat_number, '[A-Z][0-9]{3}') notnull),
    flight_id   integer not null references flights (flight_id),
    client_id   integer not null references clients (client_id),
    t_class     char    not null check (t_class in ('E', 'B')),
    primary key (seat_number, flight_id)
);


drop table if exists crew_members cascade;
create table crew_members (
    member_id     serial primary key,
    member_name   varchar(100) not null,
    date_of_birth date         not null,
    member_role   varchar(100) not null
);

drop table if exists flights_x_crew_members cascade;
create table flights_x_crew_members (
    flight_id integer references flights (flight_id),
    member_id integer references crew_members (member_id),
    primary key (flight_id, member_id)
);

drop table if exists route_time cascade;
create table route_time (
    route_id       integer not null references routes (route_id),
    day_of_week    varchar(3) check (day_of_week in ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun') ),
    departure_time time,
    periodicity    varchar(100) check (regexp_match(periodicity, '[0-4] weeks [0-9] months') notnull ),
    valid_from     timestamp with time zone,
    valid_to       timestamp with time zone,
    primary key (route_id, day_of_week, departure_time, periodicity, valid_from)
);

