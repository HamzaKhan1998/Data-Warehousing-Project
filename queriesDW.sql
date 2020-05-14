





1) select * from (
	Select PID, Pname, t_year, sum(Sales)  
	from ( (DimProduct P join FactSales S where P.PID=S.P_ID) and (DimDate D join FactSales S where D.DID=S.D_ID) ) 
	GROUP BY PID, Pname, t_year having t_year=2016  order by Sales DESC ) limit 1;

2) select * from (
	Select SID, Sname, t_month, t_year, sum(Sales) 
	from ( (DimSupplier S join FactSales F where S.SID= F.S_ID) and (DimDate D join FactSales F where D.DID=F.D_ID) ) 
	GROUP BY SID, Sname, t_month, t_year having t_month=8 and t_year=2016 order by Sales DESC ) limit 3;

3) select * from (
	Select STID, STname, t_month, t_year, sum(Sales) 
	from ( (DimStore S join FactSales F where S.STID=F.ST_ID) and (DimDate D join FactSales F where D.DID=F.D_ID) ) 
	GROUP BY STID, STname, t_month, t_year having t_month=8 and t_year=2016 order by Sales DESC ) limit 3;

4) select * from (
	Select PID, Pname, Quantity, t_year, sum(Sales) 
	from ( ( DimProduct P join FactSales F where P.PID=F.P_ID) and (DimDate D join FactSales F where D.DID=F.D_ID) ) 
	GROUP BY  order by Sales DESC ) limit 1;

5) 
	Select PID, Pname, t_quarter, sum(Sales) 
	from ( ( DimProduct P join FactSales F where P.PID=F.P_ID) and ( DimDate D join FactSales F where D.DID=F.D_DID) ) 
	GROUP BY t_quarter 

6) CREATE MATERIALIZED VIEW STOREANALYSIS_MV
     	BUILD IMMEDIATE 	
		REFRESH FAST
			ON DEMAND AS
 
Select STID, PID, sum(Sales) from ( ( DimStore S join FactSales F where S.STID=F.ST_ID) and ( DimProduct P join FactSales F where P.PID=F.P_ID) ) 
GROUP BY STID, PID, Sales
