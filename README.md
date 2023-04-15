### Payroll management in x86_32 assembly


#### todo:
- data to be stored in text files
- text files to be grouped in departments
- each text files is linked to a department and contains details of its employees
- each employee entry has
    - employee name
    - employee number
    - salary
    - job group
    - department
- thinking of separating each employee entry with "\n-----------\n"

- on running
    - user is prompted "1. Read employee payroll" "2. add/update employee payroll"
```ts
switch (option) {
    case 1:
        // prompt for employee id, get employee with id and output details
    case 2:
        // prompt for employee details, check if employee exists.
        // if employee doesn't exist create a new entry in the department record
        // if employee exist's,  update fields
}
```
