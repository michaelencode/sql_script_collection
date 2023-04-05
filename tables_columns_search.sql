/*
This T-SQL script retrieves information about columns in the current SQL Server database 
whose names contain the keyword 'invoice'. The result set includes the schema name, table name, 
column ID, column name, data type, maximum length, and precision of the columns. 
*/

select schema_name(tab.schema_id) as schema_name,
    tab.name as table_name, 
    col.column_id,
    col.name as column_name, 
    t.name as data_type,    
    col.max_length,
    col.precision
from sys.tables as tab --Specifies the main source of data as the sys.tables system catalog view and aliases it as 'tab'.
    inner join sys.columns as col -- Performs an inner join between sys.tables and the sys.columns system catalog view (aliased as 'col') to retrieve column information
        on tab.object_id = col.object_id
    left join sys.types as t
    on col.user_type_id = t.user_type_id
where col.name like '%invoice%'
order by schema_name,
    table_name, 
    column_id;