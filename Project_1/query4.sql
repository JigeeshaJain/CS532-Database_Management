select sid, lastname, GPA from students where status <>'graduate' intersect select sid, lastname, GPA from students where sid in (select sid from enrollments where lgrade = 'C');