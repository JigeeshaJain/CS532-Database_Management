select courses.dept_code, courses.course#, courses.title, lgrade as final_grade from courses, classes, enrollments where courses.dept_code = classes.dept_code and courses.course# = classes.course# and classes.classid = enrollments.classid and enrollments.sid in (select sid from students where sid = 'B005');