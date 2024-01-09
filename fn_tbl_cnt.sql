create or replace function fn_tbl_cnt(tbl_nm varchar(50) default null) returns integer as $$
declare
cnt_sql text;
rtn_cnt int := 0;
begin
  cnt_sql := 'select count(1) from ods.' || tbl_name;
  execute cnt_sql into rtn_cnt;

  return rtn_cnt;
end;
$$ language plpgsql;

create or replace procedure sp_tbl_cnt(in tbl_name varchar(50) default null) as $$
declare
cnt_sql text;
rtn_cnt int := 0;
begin
  if tbl_name is null then
    return;
  end if;

  cnt_sql := 'select count(1) from ods.' || tbl_name;
  execute cnt_sql into rtn_cnt;

  update mig_list
  set cnt = rtn_cnt
  where tbl_nm = tbl_name;
end;
$$ language plpgsql;

create or replace procedure sp_all_tbl_cnt() as $$
declare
cnt_sql text;
rtn_cnt int := 0;
tbl1 varhar(100);
begin
  for tbl1 in select tbl_nm from ods.mig_list loop
    call ods.sp_tbl_cnt(tbl1);
  end loop;
end;
$$ language plpgsql;
