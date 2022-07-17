#! /bin/bash

select input_file in QUIT ПІБ*-comma_separated.csv; do
	[ "${input_file}" = 'QUIT' ] && exit
	[ "${REPLY}" = 'q' ] && exit
	echo "Input file: ${input_file}"
	break
done

# if [ ! -e result.csv ]; then
# 	echo 'No input file: result.csv'
# 	exit 1
# fi

#####################################################

#     1	Ім'я
#     2	Прізвище
#     3	"Індивідуальний номер"
#     4	Заклад
#     5	Відділ
#     6	"Електронна пошта"
#     7	"Загальне за курс (Бали)"
#     8	"Відвідування:Відвідування занять (Бали)"
#     9	"Завдання:Практична робота №1 (Завдання №1) (Бали)"
#    10	"Завдання:Практична робота №2 (Завдання №2) (Бали)"
#    11	"Завдання:Лабораторна робота №1 (Завдання №3) (Бали)"
#    12	"Завдання:Лаборатона робота №2 (Завдання №4) (Бали)"
#    13	"Завдання:Лабораторна робота №3 (Завдання №5) (Бали)"
#    14	"Завдання:Відповіді на питання екзаменаційних білетів (pdf розміром не більше 5 МБ) (Бали)"
#    15	"Завдання:Сертифікати дистанційних курсів Android (за бажанням студента) (pdf) (Бали)"
#    16	"Відвідування:Відвідування екзамену (Бали)"
#    17	"Останні завантаження з цього курсу"

#####################################################

#     1	Ім'я,
#     2	Прізвище,
#     3	"Індивідуальний номер",
#     4	Заклад,
#     5	Відділ,
#     6	"Електронна пошта",
#     7	"Загальне за курс (Бали)",
#     8	"Відвідування:Відвідування (Бали)",
#     9	"Відвідування:Відвідування практичних занять / лабораторних робіт з дисципліни (Бали)",

#    40	"Завдання:Звіт з Пз/Лб 1 (Бали)", група 11 *
#    41	"Завдання:Звіт з Пз/Лб 2 (Бали)",
#    42	"Завдання:Звіт з Пз/Лб 4 (Бали)",
#    43	"Завдання:Звіт з Пз/Лб 6 (Бали)",
#    44	"Завдання:Звіт з Пз/Лб 3 (Бали)",
#    45	"Завдання:Звіт з Пз/Лб 5 (Бали)",

#    76	"Virtual programming lab:Завдання на Пз/Лб 1 (Бали)", група 11 *
#    77	"Virtual programming lab:Завдання на Пз/Лб 2 (Бали)",
#    78	"Virtual programming lab:Завдання на Пз/Лб 3 (Бали)",
#    79	"Virtual programming lab:Завдання на Пз/Лб 4 (Бали)",
#    80	"Virtual programming lab:Завдання на Пз/Лб 5 (Бали)",
#    81	"Virtual programming lab:Завдання на Пз/Лб 6 (Бали)",

#    82	"Завдання:Звіти виконаних робіт (Бали)",
#    83	"Відвідування:Відвідування екзамену (Бали)",
#    84	"Завдання:Відповіді на питання екзаменаційних білетів (pdf розміром не більше 5 МБ) (Бали)",
#    85	"Завдання:Сретифікити дистанційних курсів Android (за бажанням студента) (pdf) (Бали)",
#    86	"Останні завантаження з цього курсу"

cat "${input_file}" | gawk '

BEGIN {
    FS=","

    num_str[0] = "немає"
    num_str[1] = "один"
    num_str[2] = "два"
    num_str[3] = "три"
    num_str[4] = "чотири"
    num_str[5] = "п\047ять"
    num_str[6] = "шість"
    num_str[7] = "сім"
    num_str[8] = "вісім"
    num_str[9] = "дев\047ять"
    num_str[10] = "десять"
    num_str[11] = "одинадцять"
    num_str[12] = "дванадцять"
    num_str[13] = "тринадцять"
    num_str[14] = "чотирнадцять"
    num_str[15] = "п\047ятнадцять"
    num_str[16] = "шістнадцять"
    num_str[17] = "сімнадцять"
    num_str[18] = "вісімнадцять"
    num_str[19] = "дев\047ятнадцять"
    num_str[20] = "двадцять"
    num_str[21] = "двадцять один"
    num_str[22] = "двадцять два"
    num_str[23] = "двадцять три"
    num_str[24] = "двадцять чотири"
    num_str[25] = "двадцять п\047ть"
}

function num_string(num) {
    return("(" num_str[num] ")")
}

function result_string(result_num, string_format, \
		result_str_text, result_str_char, return_string) {

    result_num = int(result_num)

    if (result_num >= 96) {
	result_str_text = "5 (відмінно)"
	result_short_str_text = "5(відмін.)"
	result_str_char = "A"
	excellent_grade_count++
	present_stud_num++

    } else if ((result_num >= 90) && (result_num <= 95)) {
	result_str_text = "5 (відмінно)"
	result_short_str_text = "5(відмін.)"
	result_str_char = "B"
	excellent_grade_count++
	present_stud_num++

    } else if ((result_num >= 75) && (result_num <= 89)) {
	result_str_text = "4 (добре)"
	result_short_str_text = "4(добре)"
	result_str_char = "C"
	good_grade_count++
	present_stud_num++

    } else if ((result_num >= 66) && (result_num <= 74)) {
	result_str_text = "3 (задовільно)"
	result_short_str_text = "3(задов.)"
	result_str_char = "D"
	satisfactory_grade_count++
	present_stud_num++

    } else if ((result_num >= 60) && (result_num <= 65)) {
	result_str_text = "3 (задовільно)"
	result_short_str_text = "3(задов.)"
	result_str_char = "E"
	satisfactory_grade_count++
	present_stud_num++

    } else if ((result_num >= 35) && (result_num <= 59)) {
	result_str_text = "2 (незадовільно)"
	result_short_str_text = "2(незад.)"
	result_str_char = "FX"
	unsatisfactory_grade_count++
	present_stud_num++

    } else if ((result_num > 0) && (result_num <= 34)) {
	result_str_text = "2 (незадовільно)"
	result_short_str_text = "1(незад.)"
	result_str_char = "F"
	unsatisfactory_grade_count++
	present_stud_num++

    } else if (result_num == 0)  {
	result_str_text = "не з\47явився"
	result_short_str_text = "не з\47явив."
	result_str_char = "--"
	absent_stud_num++

    } else {
	result_str_text = "Помилка!"
	result_str_char = ""
    }

    switch (string_format) {
    case "lib_office_tab":
	if (result_num == 0) result_num = "--"
	return_string = " " result_short_str_text "; " result_num "; " result_str_char  
	break
    case "long":
	return_string = result_str_text " " result_num " " result_str_char  
	break
    default:
	return_string = result_str_text ", " result_str_char  
    }

    return return_string
}

function whitespace(num,   whitespase_str) {
    if (num < 10 ) {
	whitespase_str="  "
    } else if (num < 100) {
	whitespase_str=" "
    } else {
	whitespase_str=""
    }
    return whitespase_str
}

BEGIN {
    stud_seq_num = 1

    excellent_grade_count = 0
    good_grade_count = 0
    satisfactory_grade_count = 0
    unsatisfactory_grade_count = 0
    present_stud_num = 0
    absent_stud_num = 0

    print "-----------------"
    print "№   Прізвище ім\47я\t\tСеместр\tЕкзамен\tСертифікат\tДисципліна"
}

NR == 1 {
    field_pattern = "Останні завантаження з цього курсу"
    if ($17 ~ field_pattern) {
	stud_groups_part = 1
    } else if ($86 ~ field_pattern) {
	stud_groups_part = 2
    } else {
	stud_groups_part = 0
    }
}

NR > 1 {
    switch (stud_groups_part) {
    case 1:
	task1 = 1.0 * $9
	task2 = 1.0 * $10
	task3 = 1.0 * $11
	task4 = 1.0 * $12
	task5 = 1.0 * $13
	task6 = 0.0
	exam_result = 1.0 * $14
	certificate = 1.0 * $15
	break
    case 2:
	task1 = 20.0 * ($10 + $16 + $22 + $28 + $34 + $40)
	task2 = 20.0 * ($11 + $17 + $23 + $29 + $35 + $41)
	task3 = 20.0 * ($12 + $18 + $24 + $30 + $36 + $42)
	task4 = 20.0 * ($13 + $19 + $25 + $31 + $37 + $43)
	task5 = 20.0 * ($14 + $20 + $26 + $32 + $38 + $44)
	task6 = 20.0 * ($15 + $21 + $27 + $33 + $39 + $45)
	exam_result = 1.0 * $84
	certificate = 1.0 * $85
	break
    default:
	task1 = -1
	task2 = -1
	task3 = -1
	task4 = -1
	task5 = -1
	task6 = -1
	exam_result = -1
	certificate = -1
    }
    semester_result = ((task1 + task2 + task3 + task4 + task5 + task6) / 5.0)
    course_result = int((0.6 * semester_result) + (0.4 * exam_result) + (certificate) + 0.9)
    if (course_result > 100 ) course_result = 100
    if ((course_result >= 20) && (course_result < 35)) course_result = 35

    report_variant = "lib_office_tab"

    switch (report_variant) {
    case "long":
	print (stud_seq_num) " " whitespace(stud_seq_num) $2 " " $1 " " $6 \
	    "\t" task1 "\t" task2 "\t" task3 "\t" task4 "\t" task5 "\t" task6 \
	    "\tсем.=" semester_result "\tекз.=" exam_result "\tсерт.=" certificate \
	    "\tрез.=" course_result "\t" result_string(course_result)
	break
    case "lib_office_tab":
	print result_string(course_result, "lib_office_tab") ";" $2
	break
    case "check_only":
	print (stud_seq_num) " " whitespace(stud_seq_num) $2 " " $1 " " $6 \
	    "\t" course_result "\t" result_string(course_result)
	break
    default:
	print (stud_seq_num) " " whitespace(stud_seq_num) $2 " " $1 "\t" \
	    "\t" semester_result "\t" exam_result "\t" certificate \
	    "\t" course_result "  " result_string(course_result)
    }

    stud_seq_num++
}

END {
    total_grade_count = excellent_grade_count + good_grade_count + \
	+ satisfactory_grade_count + unsatisfactory_grade_count + absent_stud_num
    print "-----------------"
    print "Не з\47явилося:  " absent_stud_num
    print "Bідмінно:     " excellent_grade_count 
    print "Добре:        " good_grade_count 
    print "Задовільно:   " satisfactory_grade_count
    print "Незадовільно: " unsatisfactory_grade_count 
    print "РАЗОМ:        " total_grade_count 
    print "-----------------"
    print absent_stud_num num_string(absent_stud_num) " " \
	  excellent_grade_count num_string(excellent_grade_count) " " \
	  good_grade_count num_string(good_grade_count) " " \
	  satisfactory_grade_count num_string(satisfactory_grade_count) " " \
	  unsatisfactory_grade_count num_string(unsatisfactory_grade_count) " " \
	  total_grade_count num_string(total_grade_count) 
    print "-----------------"
    print "Потік: " stud_groups_part
    print "-----------------"
}
' | column -s "	" -t
