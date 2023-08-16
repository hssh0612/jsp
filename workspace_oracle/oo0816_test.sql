select e.eno, e.ename, m.eno, m.ename
    from employee e join employee m
    on e.manager(+) = m.eno
    order by e.eno;