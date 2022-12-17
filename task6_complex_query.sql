
-- 1) для каждого клиента посчитать кол-во купленных билетов и их суммарную стоимость,
-- отсортировать по дате первого полета, вывести клиентов, у которые купили хотя бы 2 билета

select
    c.client_name as client_name,
    min(f.departure_time)::date as first_departure_date,
    count(t.price) as number_of_tickets,
    sum(t.price) as tickets_price_sum
    from
        avia.clients c
    left join avia.tickets t
        on c.client_id = t.client_id
    left join avia.flights f
        on f.flight_id = t.flight_id
group by
    c.client_id
having
    count(t.price) >= 2
order by
    first_departure_date;


-- 2) для каждого пилота посчитать кол-во часов, проведенных в воздухе,
-- а также кол-во перелетов у пилота, отсортировать по убыванию часов,
-- вывести только пилотов с налетом более > 10 часов

select
    cw.member_name as pilot_name,
    extract(hours from sum(f.arrival_time - f.departure_time)) as hours_in_air,
    count(f.flight_id) as number_of_flights
    from
        avia.crew_members cw
    inner join avia.flights_x_crew_members fxcm
        on cw.member_id = fxcm.member_id
    inner join avia.flights f
        on f.flight_id = fxcm.flight_id
where
    cw.member_role = 'pilot'
group by
    cw.member_id
having
    extract(hours from sum(f.arrival_time - f.departure_time)) > 10
order by
    hours_in_air desc;


-- 3) для каждого клиента узнать страну, в которую он прилетел в последний раз и когда это произошло
-- отсортировать по дате последнего полета

select
    res.client_name as client_name,
    res.arrival_time::date as last_arrival,
    res.country as country
    from (select
              c.client_name as client_name,
              max(f.arrival_time) over (partition by c.client_id) as last_arrival,
              f.arrival_time as arrival_time,
              a_arr.country as country
        from
            avia.clients c
    left join avia.tickets t
        on c.client_id = t.client_id
    left join avia.flights f
        on f.flight_id = t.flight_id
    left join avia.routes r
        on f.route_id = r.route_id
    left join avia.airports a_arr
        on r.arrival_iata = a_arr.code_iata) res
where
    res.last_arrival = res.arrival_time or res.last_arrival is null
order by last_arrival;

-- 4) для каждого стюарда посчитать кол-во их совместных полётов с каждыым пилотом
-- пары отсортировать по алфавиту

select distinct
    cmfa.member_id as flight_attendant_id,
    cmfa.member_name as flight_attendant_name,
    cmp.pilot_id as pilot_id,
    cmp.pilot_name as pilot_name,
    count(pxf.pilot_id) over (partition by cmfa.member_id, cmp.pilot_id order by cmp.pilot_id) as joint_flights
    from
        avia.crew_members cmfa
    cross join
            (select
                 cm.member_name as pilot_name,
                 cm.member_id as pilot_id
             from avia.crew_members cm
             where cm.member_role = 'pilot') cmp
    inner join avia.flights_x_crew_members fxcm
        on cmfa.member_id = fxcm.member_id
    inner join avia.flights f
        on f.flight_id = fxcm.flight_id
    left join
            (select
                cm.member_id as pilot_id,
                f.flight_id
                from
                    avia.crew_members cm
                inner join avia.flights_x_crew_members fxcm
                    on cm.member_id = fxcm.member_id
                inner join avia.flights f
                    on f.flight_id = fxcm.flight_id
             where cm.member_role = 'pilot') pxf
        on cmp.pilot_id = pxf.pilot_id and pxf.flight_id = f.flight_id
where
    cmfa.member_role = 'flight attendant'
order by
    cmfa.member_name, cmp.pilot_name;

-- 5) для каждого самолета вывести информацию о нем: id, дату начала эксплуатации
-- модель, вместимость, кол-во перелетов, кол-во часов в воздухе,
-- вывести только самолеты, которые начали эксплуатироваться до 2020 года
-- отсортировать по убыванию кол-ва часов

select
    a.airplane_id as airplane_id,
    a.start_of_operation as start_of_operation,
    max(am.model) as model,
    max(am.capacity) as capacity,
    max(am.flight_range) as flight_range,
    count(f.flight_id) as number_of_flights,
    extract(hours from sum(f.arrival_time - f.departure_time)) as hours_in_air
from avia.airplanes a
    inner join avia.airplane_models am
        on am.model = a.model
    left join avia.flights f
        on a.airplane_id = f.airplane_id
group by
    a.airplane_id
having
    extract(year from max(a.start_of_operation)) < 2020
order by hours_in_air desc;