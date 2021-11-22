select classes.classid, classes.dept_code, classes.course#, classes.sect#, classes.year, classes.semester, classes.limit, classes.class_size from classes inner join enrollments on classes.classid = enrollments.classid inner join students on enrollments.sid = students.sid where classes.year = '2021' and classes.semester = 'Fall' and classes.dept_code = 'CS'
 group by classes.classid, classes.dept_code, classes.course#, classes.sect#, classes.year, classes.semester, classes.limit, classes.class_size having count(enrollments.classid)<3;