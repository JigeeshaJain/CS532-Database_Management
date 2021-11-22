select firstname from students s, enrollments e
where s.sid = e.sid and e.classid in (select classid from classes where dept_code = 'CS')
intersect
select firstname from students s, enrollments e
where s.sid = e.sid and e.classid in (select classid from classes where dept_code = 'Math');