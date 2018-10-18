# Se tiene un archivo con formato .csv que contiene nombres de alumnos con sus
# respectivas notas.
#
# El archivo tiene la siguiente estructura:
#
# David, 9, 2, 5, 1, 1
# Gonzalo, 10, 2, A, 8, 1
# Mai, 10, 10, 9, 9, A
# JP, 10, 10, 10, 10, 10
#
# Donde la A señala que el alumno estuvo ausente en la prueba.
#
# Se pide:
#
# Crear un menú con 4 opciones:
#
#     Se debe validar, en caso que se ingrese otra opción, que la opción
#     escogida sea 1, 2, 3, o 4. Por ende, si se ingresa cualquier otra opción el
#     programa debe mostrar que la opción es inválida, mostrar nuevamente
#     el menú y la posibilidad de volver a ingresar una opción
#
#     Opción 1: Debe generar un archivo con el nombre de cada alumno y el
#     avg de sus notas.
#     Se puede leer el archivo completo o ir leyendo y procesando
#     por línea, ambas opciones son válidas.
#
#     Opción 2: Debe contar la cantidad de inasistencias totales y mostrarlas en
#     pantalla.
#
#     Opción 3: Debe mostrar los nombres de los alumnos aprobados. Para eso
#     se debe crear un método que reciba -como argumento- la nota necesaria pa
#     aprobar, por defecto esa nota debe ser 5.
#
#     Opción 4: Debe terminar el programa.

require_relative 'metodos'

menu = ['Generar archivo con promedio de notas', 'Totales de inasistencia', 
         'Mostrar los alumnos aprobados', 'Salir']

option = 0
while option != menu.count do
    InOut.print_menu(menu)

    option = InOut.ask_option(menu)
    
    case option
    when 1     # Generar archivo con promedio de notas
        arr_grades = Ops.read_file('grades.csv')
        arr_avgs = Ops.avg_grades(arr_grades)
        puts 'Los promedios son:'
        arr_avgs.each do |avg| 
            spaces = ' ' * ( (12 - avg[0].size) + (2 - avg[1].to_s.size) )
            puts "Alumno: #{avg[0]}  #{spaces} #{avg[1]} " 
        end
        Ops.create_file(arr_avgs)
        puts 'Se creo el archivo average_grades.txt'
    when 2     # Totales de inasistencia
        arr_grades = Ops.read_file_text('grades.csv')
        arr_absents = Ops.absents(arr_grades)
        puts 'Las ausencias fueron:'
        arr_absents.each do |absent| 
            if absent[1] != 0
                spaces = ' ' * (12 - absent[0].size) 
                puts "Alumno: #{absent[0]}  #{spaces} #{absent[1]} "
            end  
        end
    when 3     # Mostrar alumnos aprobados
        arr_grades = Ops.read_file('grades.csv')
        arr_avgs = Ops.avg_grades(arr_grades)
        approving_grade = InOut.enter_approving_grade
        arr_approved = Ops.approved(approving_grade, arr_avgs)
        puts 'Los alumnos aprobados fueron:'
        arr_approved.each do |approved| 
            if approved[1] != 0
                spaces = ' ' * (12 - approved[0].size) 
                puts "Alumno: #{approved[0]}  #{spaces} con promedio: #{approved[1]} "
            end  
        end
    end 
end     
                
                
                



