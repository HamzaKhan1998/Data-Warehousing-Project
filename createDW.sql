
drop table FactSales;
drop table DimProduct;
drop table DimSupplier;
drop table DimStore;
drop table DimDate;
drop table DimCustomer;





create table DimCustomer
(
CID varchar2(4) not null PRIMARY KEY,
Cname varchar2(30)
);


create table DimDate
(
DID int not null PRIMARY KEY,
T_Date int,
T_Quarter int,
T_Month int,
T_Year int
);

create table DimProduct
(
price number(5,2) ,
PID varchar2(6) not null PRIMARY KEY,
Pname varchar2(50)
);

create table DimSupplier 
(
SID varchar2(5) not null PRIMARY KEY,
Sname varchar2(30)
);

create table DimStore
(
STID varchar2(4) not null PRIMARY KEY,
STname varchar2(20)
);




create table FactSales
(
Quantity number(3,0),
Sales int,
C_ID varchar2(4),
S_ID varchar2(5),
ST_ID varchar2(4),
P_ID varchar2(6),
D_ID int,
T_ID number(8,0)
);

/

alter table FactSales add constraint C_fk foreign key (C_ID) references DimCustomer(CID);
alter table FactSales add constraint S_fk foreign key (S_ID) references DimSupplier(SID);
alter table FactSales add constraint ST_fk foreign key (ST_ID) references DimStore(STID);
alter table FactSales add constraint P_fk foreign key (P_ID) references DimProduct(PID);
alter table FactSales add constraint D_fk foreign key (D_ID) references DimDate(DID);


