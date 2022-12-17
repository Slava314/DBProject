drop schema if exists
    avia_views cascade;

create schema
    avia_views;

drop view if exists avia_views.clients;
create view avia_views.clients as (
select
    overlay(c.client_name placing '******' from 1 for 100) as client_name,
    overlay(c.passport_number placing '*********' from 1) as passport_number,
    c.citizenship
from
    avia.clients c
);
select * from avia_views.clients;


drop view if exists avia_views.airplane_models;
create view avia_views.airplane_models as (
select
    *
from
    avia.airplane_models
);
select * from avia_views.airplane_models;


drop view if exists avia_views.airplanes;
create view avia_views.airplanes as (
select
    a.model,
    a.start_of_operation
from
    avia.airplanes a
);
select * from avia_views.airplanes;


drop view if exists avia_views.airports;
create view avia_views.airports as (
select
    *
from
    avia.airports
);
select * from avia_views.airports;


drop view if exists avia_views.routes;
create view avia_views.routes as (
select
    r.duration,
    r.departure_iata,
    r.arrival_iata
from
    avia.routes r
);
select * from avia_views.routes;


drop view if exists avia_views.flights;
create view avia_views.flights as (
select
    f.airplane_id,
    f.route_id,
    f.departure_time,
    f.arrival_time
from
    avia.flights f
);
select * from avia_views.flights;

drop view if exists avia_views.tickets;
create view avia_views.tickets as (
select
    *
from
    avia.tickets
);
select * from avia_views.tickets;


drop view if exists avia_views.crew_members;
create view avia_views.crew_members as (
select
    overlay(cm.member_name placing '******' from 1 for 100) as member_name,
    overlay(cm.date_of_birth::text placing '****-**-**' from 1) as date_of_birth,
    cm.member_role
from
    avia.crew_members cm
);
select * from avia_views.crew_members;


drop view if exists avia_views.flights_x_crew_members;
create view avia_views.flights_x_crew_members as (
select
    *
from
    avia.flights_x_crew_members
);
select * from avia_views.flights_x_crew_members;


drop view if exists avia_views.route_time;
create view avia_views.route_time as (
select
    *
from
    avia.route_time
);
select * from avia_views.route_time;