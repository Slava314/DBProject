select
    client_name as name,
    passport_number,
    citizenship
from avia.clients;

insert into avia.clients(client_name, passport_number, citizenship)
    values ('Meowth', '471238193', 'Sweden');

select *
    from avia.clients
    where client_name = 'Meowth';

update avia.clients
    set citizenship = 'Greece'
where client_name = 'Meowth';

select *
    from avia.clients
    where client_name = 'Meowth';

delete from avia.clients
    where client_name = 'Meowth';

select *
    from avia.clients
    where client_name = 'Meowth';

select
    seat_number,
    flight_id,
    client_id,
    case
        when t_class = 'E'
            then 'Econom'
        else
             'Business'
    end as class_of_ticket,
    price
    from avia.tickets;

insert into avia.tickets(seat_number, flight_id, client_id, t_class, price)
    values ('A001', 1, 7, 'E', 12000);

select *
    from avia.tickets
    where flight_id = 1 and seat_number = 'A001';

update avia.tickets
    set price = 15000
where flight_id = 1 and seat_number = 'A001';

select *
    from avia.tickets
    where flight_id = 1 and seat_number = 'A001';

delete from avia.tickets
    where flight_id = 1 and seat_number = 'A001';

select *
    from avia.tickets
    where flight_id = 1 and seat_number = 'A001';