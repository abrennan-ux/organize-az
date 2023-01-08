drop table if exists `prod-organize-arizon-4e1c0a83.viewers_dataset.PimaVolActivity`;
create table `prod-organize-arizon-4e1c0a83.viewers_dataset.PimaVolActivity` as
 
SELECT
vfc.DateCanvassed,
pu.Name,
pn.precinct_num,
ct.ContactTypeName,
count(case when ct.ContactTypeName = 'Walk' then 1 else null end) as WalkAttempts,
count(case when vfc.ResultID = 14 and ct.ContactTypeName = 'Walk' then 1 else null end) as WalkCanvassed,
count(case when ct.ContactTypeName = 'Phone' then 1 else null end) as PhoneAttempts,
count(case when vfc.ResultID = 14 and ct.ContactTypeName = 'Phone' then 1 else null end) as PhoneCanvassed,
count(case when vfc.ResultID = 14 and ct.ContactTypeName = 'Phone' or ct.ContactTypeName = 'Walk' then 1 else null end) as Canvassed,
count(case when vfc.ResultID = 3 then 1 else null end) as Inaccessible
 
from
`prod-organize-arizon-4e1c0a83.ngpvan.CTARAA_ContactsContacts_VF` vfc
join
`prod-organize-arizon-4e1c0a83.viewers_dataset.Union_User_PublicUser` pu
on
vfc.CanvassedBy = pu.UserID
 
join
 `prod-organize-arizon-4e1c0a83.ngpvan.CTARAA_ContactTypes` ct
 on
vfc.ContactTypeID = ct.ContactTypeID
 
right join
`prod-organize-arizon-4e1c0a83.viewers_dataset.TargetHouseHoldsPima` tp
on
vfc.VanID = tp.voter_file_vanid
 
join
`prod-organize-arizon-4e1c0a83.viewers_dataset.PrecinctNums` pn
on
vfc.VanID = pn.voter_file_vanid
 
where vfc.DateCanvassed >= '2022-06-15'
 
 and not
 (pu.Name = 'Organizer Last Name, First Name' or
 pu.Name = 'Organizer Last Name, First Name' and vfc.DateCanvassed >= '2022-09-15')
 
group by  vfc.DateCanvassed,
pu.Name, pn.precinct_num,
ct.ContactTypeName
 
order by vfc.DateCanvassed asc
