#include <stdio.h>

int main() {
    char promptName[] = "Enter your name: \n";
    char promptAge[] = "Enter your age \n";
    const int year = 2023;
    char name[30];
    int age;

    printf("%s", promptName);

    fgets(name, sizeof(name), stdin);

    printf("%s", promptAge);

    scanf("%d", &age);

    printf("Name: %s\nAge: %d\nYear of birth: %d\n", name, age, year-age);

    return 0;
}