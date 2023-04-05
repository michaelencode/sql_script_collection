/* This script is a T-SQL query that retrieves the total number of rows 
for each user-defined table in the current SQL Server database. 
It provides an overview of the data distribution in the database. */
SELECT 
    t.NAME AS TableName,
    SUM(p.[rows]) AS [RowCount] --SUM(p.[rows]) AS [RowCount]: Calculates the total number of rows for each table using the 'rows' column in the sys.partitions system catalog view, and aliases the result as 'RowCount'.
FROM 
    sys.tables t
INNER JOIN 
    sys.partitions p 
ON 
    t.object_id = p.object_id
WHERE 
    t.is_ms_shipped = 0 --Filters out the system tables by checking the 'is_ms_shipped' column, which indicates if the table is a Microsoft-shipped system table
    AND 
    p.index_id IN (0, 1) -- Filters the partitions based on the 'index_id' column, considering only heap (0) or clustered index (1) to avoid counting rows multiple times.
GROUP BY 
    t.NAME --Groups the result set by the table name to aggregate the row count for each table.
ORDER BY 
    TableName;
