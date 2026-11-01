SELECT round(
((count(case when texts.signup_action='Confirmed' then 1 end)))/(count(distinct emails.email_id)),2) as confirm_rate
FROM emails
left join texts on emails.email_id=texts.email_id;