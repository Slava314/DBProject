-- триггер для версионной таблицы, при изменении строки в view обновляет строчку в табличке
-- и создаёт новую со старыми данными и правильным valid_to
create or replace function update_route_time()
    returns trigger as $$
    declare
        t timestamp := now();
    begin
        insert into avia.route_time(route_id, day_of_week, departure_time, periodicity, valid_from, valid_to)
            values (new.route_id, new.day_of_week, new.departure_time, new.periodicity, t + '1 sec', old.valid_to);
        update avia.route_time rt
            set valid_to = t
        where rt.* = old.*;
        return new;
    end
    $$ language plpgsql;


create or replace trigger edit_route_time
    instead of update on avia_views.route_time
    for each row
    execute procedure update_route_time();

-- test
-- update avia_views.route_time rt
--     set day_of_week = 'Tue'
-- where rt.route_id = 1;


-- триггер для логирования всех изменений в таблицу clients, нужно сохранять новые и старые данные, тип операции, время и пользователя

drop table if exists avia.avia_log;
create table if not exists avia.avia_log (
    id serial primary key ,
    old_data jsonb,
    new_data jsonb,
    op_type varchar(10) not null,
    op_timestamp timestamp not null,
    logged_user varchar(255) not null
);

create or replace function log_changes()
    returns trigger as $$
    declare
    begin
        insert into avia.avia_log(old_data, new_data, op_type, op_timestamp, logged_user)
            values (to_jsonb(old), to_jsonb(new), tg_op, now(), "current_user"());
        return new;
    end
    $$ language plpgsql;


create or replace trigger log_all_changes
    after update or insert or delete on avia.clients
    for each row
    execute procedure log_changes();

-- test
-- insert into avia.clients(client_name, passport_number, citizenship)
--     values ('Meowth', '471238193', 'Sweden');
--
-- update avia.clients
--     set citizenship = 'Greece'
-- where client_name = 'Meowth';
--
-- delete from avia.clients
--     where client_name = 'Meowth' and citizenship = 'Greece';
--
-- select * from avia.avia_log;