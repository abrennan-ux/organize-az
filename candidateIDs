drop table if exists `prod-organize-arizon-4e1c0a83.viewers_dataset.CandidateIDsPIMA`;
create table `prod-organize-arizon-4e1c0a83.viewers_dataset.CandidateIDsPIMA` as
 
SELECT
vfc.VanID,
vfc.DateCanvassed,
pu.Name,
pn.county_name,
pn.precinct_num,
ct.ContactTypeName,
count(case when ct.ContactTypeName = 'Walk' then 1 else null end) as WalkAttempts,
count(case when vfc.ResultID = 14 and ct.ContactTypeName = 'Walk' then 1 else null end) as WalkCanvassed,
count(case when ct.ContactTypeName = 'Phone' then 1 else null end) as PhoneAttempts,
count(case when vfc.ResultID = 14 and ct.ContactTypeName = 'Phone' then 1 else null end) as PhoneCanvassed,
 count(case when vfc.ResultID = 14 and ct.ContactTypeName = 'Phone' or ct.ContactTypeName = 'Walk' then 1 else null end) as Canvassed,
 sq.SurveyQuestionName,
 sq.SurveyQuestionText,
 sr.SurveyResponseName, d.Party, d.Age, d.Sex, d.AgeRange, csr.InputTypeID
 
 
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
 
join
`prod-organize-arizon-4e1c0a83.ngpvan.CTARAA_ContactsSurveyResponses_VF` csr
on
vfc.VanID = csr.VanID
 
full join
`prod-organize-arizon-4e1c0a83.ngpvan.CTARAA_SurveyResponses` sr
on csr.SurveyResponseID = sr.SurveyResponseID
 
full join
`prod-organize-arizon-4e1c0a83.ngpvan.CTARAA_SurveyQuestions` sq
on
sr.SurveyQuestionID = sq.SurveyQuestionID
 
right join
`prod-organize-arizon-4e1c0a83.viewers_dataset.TargetHouseHoldsPima` tp
on
vfc.VanID = tp.voter_file_vanid
 
join
`prod-organize-arizon-4e1c0a83.viewers_dataset.PrecinctNums` pn
on
vfc.VanID = pn.voter_file_vanid
 
join
`prod-organize-arizon-4e1c0a83.viewers_dataset.PimaTargetsData` d
on vfc.VanID = d.VanID
 
where
vfc.DateCanvassed >= '2022-09-16'
and sq.SurveyQuestionName = "Hobbs ID General"
 
group by  vfc.DateCanvassed,
pu.Name, pn.county_name, pn.precinct_num,
ct.ContactTypeName,
sq.SurveyQuestionName,
sq.SurveyQuestionText,
sr.SurveyResponseName, d.Party, d.Age, d.Sex, d.AgeRange, csr.InputTypeID, vfc.VanID
