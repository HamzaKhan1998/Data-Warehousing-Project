
create procedure INLJLOOP()
is
	cursor ms is select t.transaction_id as TID, t.product_id as PID, t.customer_id as CID, t.customer_name as Cname, t.store_id as STID, t.store_name as STname,
	t.t_date as TD,t.Quantity as Q, m.product_name as Pname, m.supplier_id as SID, m.supplier_name as Sname,m.price 
		from transaction t join masterdata m where t.PID = m.product_id	
		
		MM int; --------------------------------- Variable to extract month from Date ---------------------------------------
		YY int; --------------------------------- Variable to extract year from Date ---------------------------------------
		QQ int; --------------------------------- Variable to extract quarter from Date ---------------------------------------
		temp ms%rowtype ; ---------------------------- To fetch records row wise and insert them into their respective tables -----------------------------------
		fetch ms into temp;
		count1 int:=0; -------------------------------- Set to 0 initially and incremented as records are inserted ---------------------------------
		count2 int;
begin

open ms;
	while @count1<=50 
	
	----------------------------------- Data insertion into DimCustomer -------------------------------------------
	BEGIN
	merge into DimCustomer 	
    using ( select temp.CID, temp.Cname from temp )
	on ( DimCustomer.CID = temp.CID )
	when matched then
	update set
	DimCustomer.Cname = temp.Cname;
	when not matched then
	INSERT VALUES ( temp.CID,temp.Cname)
	END
	
	----------------------------------- Data insertion into DimProduct -------------------------------------------
	BEGIN
	merge into DimProduct 	
    using ( select temp.price, temp.PID, temp.Pname from temp )
	on ( DimProduct.PID = temp.PID )
	when matched then
	update set
	DimProduct.Pname = temp.Pname;
	when not matched then
	INSERT VALUES ( temp.price, temp.PID, temp.Pname)
	END
	
	----------------------------------- Data insertion into DimSupplier -------------------------------------------
	BEGIN
	merge into DimSupplier 	
    using ( select temp.SID, temp.Sname from temp )
	on ( DimCustomer.SID = temp.SID )
	when matched then
	update set
	DimSupplier.Sname = temp.Sname;
	when not matched then
	INSERT VALUES ( temp.SID,temp.Sname)
	END
	
	----------------------------------- Data insertion into DimStore -------------------------------------------
	BEGIN
	merge into DimStore 	
    using ( select temp.STID, temp.STname from temp )
	on ( DimDate.DID = temp. )
	when matched then
	update set
	DimStore.STname = temp.STname;
	when not matched then
	INSERT VALUES ( temp.STID,temp.STname)
	END
	
	----------------------------------- Data insertion into DimDate -------------------------------------------
	
	DD= select extract ( day from temp.t_date);
	MM= select extract ( month from temp.t_date)
	YY= select extract ( year from temp.t_date);
	QQ= select extract ( quarter from temp.t_date);
	BEGIN
	merge into DimDate 	
    using ( select DD, MM, YY, QQ )
	on ( DimDate.STID = temp.TD )
	when matched then
	update set
	DimDate.T_Date = DD;
	when not matched then
	INSERT VALUES ( TD, DD, MM, QQ, YY)
	END	
		
	
	
	----------------------------------- Data insertion into FactSales -------------------------------------------
	BEGIN
	merge into FactSales 	
    using ( select temp.Q, temp.TID, temp.CID, temp.SID, temp.STID, temp.PID temp.STID, temp.STname from temp )
	on ( FactSales.TID = temp.TID )
	when matched then
	update set
	DimStore.STname = temp.STname;
	when not matched then
	INSERT ( Quantity, Sales, C_ID, S_ID, ST_ID, P_ID, D_ID, T_ID ) VALUES ( temp.Q, temp.Q * temp.price, temp.CID, temp.SID, temp.STID, temp.PID, temp.DID, temp.TID)
	END
	
	
	
	
	
	
	SET @count1 = @count1 + 1;
	exit when ms%notfound;
	
	end loop;
	close ms;
end;