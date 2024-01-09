create or replace function fn_tbl_cnt(tbl_nm varchar(50)) returns integer as $$
declare
cnt_sql text;
rtn_cnt int := 0;
begin
  cnt_sql := 'select count(1) from ods.' || tbl_name;
  execute cnt_sql into rtn_cnt;

  return rtn_cnt;
end;
$$ language plpgsql;

create or replace function sp_tbl_cnt(tbl_name varchar(50)) returns void as $$
declare
cnt_sql text;
rtn_cnt int := 0;
begin
  cnt_sql := 'select count(1) from ods.' || tbl_name;
  execute cnt_sql;
end;
$$ language plpgsql;
