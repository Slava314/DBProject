-- 1) для каждого клиента вывести статистику по всем его билетам:
-- имя, данные про билет: дата отправления, цена, место в самолете, класс, города отправления и прибытия
-- отсортировать по дате перелета, посчитать нарастающую сумму стоимости билетов


drop view if exists client_ticket_statistics;
create view client_ticket_statistics as (
select
    c.client_name as client_name,
    f.departure_time::date as departure_date,
    t.price as ticket_price,
    t.seat_number as seat_number,
    case
        when t.t_class = 'E'
            then 'Econom'
        when t.t_class = 'B'
             then 'Business'
    end as class_of_ticket,
    a_dep.city as departure,
    a_arr.city as arrival,
    sum(t.price) over (partition by c.client_name order by f.departure_time) as tickets_cumulative_sum
from
        avia.clients c
    left join avia.tickets t
        on c.client_id = t.client_id
    left join avia.flights f
        on f.flight_id = t.flight_id
    left join avia.routes r
        on f.route_id = r.route_id
    left join avia.airports a_arr
        on r.arrival_iata = a_arr.code_iata
    left join avia.airports a_dep
        on r.departure_iata = a_dep.code_iata
order by c.client_name, f.departure_time
);

select * from  client_ticket_statistics;

-- 2) для каждого перелета вывести кол-во купленных билетов, максимальное кол-во пассажиров, кол-во свободных мест и
-- среднюю стоимость билетов, отсортировать по дате перелета

drop view if exists flights_seats_statistics;
create view flights_seats_statistics as (
select
    res.flight_id as flight_id,
    res.departure_time::date as departure_date,
    res.ticket_count,
    res.average_ticket_price,
    am.capacity as plane_capacity,
    am.capacity - res.ticket_count as number_of_available_seats
from
    (select
            f.flight_id,
            sum(1) over (partition by f.flight_id) as ticket_count,
            avg(t.price) over (partition by f.flight_id) as average_ticket_price,
            row_number() over (partition by f.flight_id) as row_number,
            f.airplane_id,
            f.departure_time
        from
            avia.flights f
        inner join avia.tickets t
            on t.flight_id = f.flight_id) res
    inner join avia.airplanes a
        on res.airplane_id = a.airplane_id
    inner join avia.airplane_models am
        on am.model = a.model
where
    res.row_number = 1
order by
    res.departure_time
);

select * from flights_seats_statistics;

-- 3) для каждой записи в таблице route_time вывести информацию о маршруте,
-- кол-во совершенных перелетов, кол-во билетов, вывести метку актуальные это данные или устаревшие,
-- отсортировать по началу действия маршрута

drop view if exists routes_all_statistics;
create view routes_all_statistics as (
select
    dense_rank() over (partition by res.route_id order by res.valid_from) as route_numeration,
    res.route_id as route_id,
    res.day_of_week as day_of_week,
    res.departure_time as departure_time,
    res.periodicity as periodicity,
    res.valid_from as start_of_operation,
    max(res.departure_city) as departure_city,
    max(res.arrival_city) as arrival_city,
    max(res.flight_count) as flight_count,
    coalesce(count(t.client_id), 0) as ticket_count,
    case
        when max(res.valid_to) > now()
            then 'actual'
        else 'outdated'
    end as status
from
    (select
        rt.route_id,
        rt.day_of_week,
        rt.departure_time,
        rt.periodicity,
        rt.valid_from,
        rt.valid_to,
        coalesce(count(f.flight_id), 0) as flight_count,
        max(a_dep.city) as departure_city,
        max(a_arr.city) as arrival_city
    from avia.route_time rt
        inner join avia.routes r
            on r.route_id = rt.route_id
        left join avia.flights f
            on rt.route_id = f.route_id
                and f.departure_time >= rt.valid_from
                and f.departure_time <= rt.valid_to
                and to_char(f.departure_time, 'dy') = lower(rt.day_of_week)
                and extract(hours from f.departure_time) = extract(hours from rt.departure_time)
        inner join avia.airports a_arr
            on a_arr.code_iata = r.arrival_iata
        inner join avia.airports a_dep
            on a_dep.code_iata = r.departure_iata
    group by
        rt.route_id, rt.day_of_week, rt.departure_time, rt.periodicity, rt.valid_from
    ) res
    left join avia.flights f
            on res.route_id = f.route_id
                and f.departure_time >= res.valid_from
                and f.departure_time <= res.valid_to
                and to_char(f.departure_time, 'dy') = lower(res.day_of_week)
                and extract(hours from f.departure_time) = extract(hours from res.departure_time)
    left join avia.tickets t
        on f.flight_id = t.flight_id
group by
        res.route_id, res.day_of_week, res.departure_time, res.periodicity, res.valid_from
order by
    res.route_id, start_of_operation
);

select * from routes_all_statistics;