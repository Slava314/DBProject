-- функция добавляет новую щапись в таблицу flights и сразу заполняет нжные строки, связанные с этим перелетом в таблице flights_x_crew_members по переданному массиву
create or replace procedure add_flight(airplane_id_ integer, route_id_ integer, departure_time_ timestamp, arrival_time_ timestamp, members integer[])
    as $$
    declare
        id integer;
        m_id integer;
    begin
        insert into avia.flights(airplane_id, route_id, departure_time, arrival_time)
            values (airplane_id_, route_id_, departure_time_, arrival_time_)
        returning flight_id into id;
        if (not (members <@ (select array_agg(c.member_id) from avia.crew_members c)))
            then raise exception 'No such member ids';
        end if;
        foreach m_id in array members
            loop
                insert into avia.flights_x_crew_members(flight_id, member_id)
                    values (id, m_id);
            end loop;
    end
    $$ language plpgsql;

-- test
-- call add_flight(1, 2, '2022-07-24 16:34:00', '2022-07-24 18:00:00', '{1, 2}') ok
-- call add_flight(1, 2, '2022-07-24 16:34:00', '2022-07-24 18:00:00', '{123, 2}') exception


-- добавить новую запись в таблицу tickets c проверкой, что у клиента ещё нет билета на этот перелет
create or replace procedure add_ticket(seat_number_ text, flight_id_ integer, client_id_ integer, t_class_ char, price_ integer)
    as $$
    declare
        seat text;
    begin
        select seat_number into seat from avia.tickets
            where flight_id = flight_id_ and client_id = client_id_;
        if (seat is not null)
            then
                raise exception 'client has ticket for this flight: %',seat;
        end if;
        insert into avia.tickets(seat_number, flight_id, client_id, t_class, price)
            values (seat_number_, flight_id_, client_id_, t_class_, price_);
    end
    $$ language plpgsql;

-- test
-- call add_ticket('A013', 1, 5, 'E', 15000); ok
-- call add_ticket('A010', 1, 7, 'E', 15000); exception
