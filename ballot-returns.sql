drop table if exists `prod-organize-arizon-4e1c0a83.viewers_dataset.BallotReturns_AllPima`;
create table `prod-organize-arizon-4e1c0a83.viewers_dataset.BallotReturns_AllPima` as
 
SELECT
sr.DateCanvassed, sr.VanID, c.Sex, c.HobbsID, c.AgeRange
 
FROM `prod-organize-arizon-4e1c0a83.ngpvan.CTARAA_ContactsSurveyResponses_VF` sr
 
right join `prod-organize-arizon-4e1c0a83.viewers_dataset.AllVoters_Pima` c
on
sr.VanID = c.VANID
 
where sr.SurveyQuestionID = 529243
and sr.SurveyResponseID = 2165849
and sr.DateCanvassed >= '2022-10-12'
and sr.InputTypeID = 4
order by sr.DateCanvassed desc
