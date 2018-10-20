module InOut
    def self.ask_option(menu)
        option = 0
        while (option <= 0 || option > menu.count)
            enter_data = gets.chomp
            int_number = Ops.verify_integer(enter_data)
            if !int_number then
                puts "Su opción es: #{enter_data}, debes Ingresar un entero"
            elsif
                option = enter_data.to_i
                if option <= 0 || option > menu.count
                then puts "Opciones del 1 al #{menu.count}"
                end
            end          
        end 
        puts menu[option - 1]
        return option 
    end     
    
    def self.print_menu(menu)
        menu_s = ''
        menu.each_with_index { |option, index |
            menu_s += "\n\t #{(index + 1)} - " + option
        }   
        puts "\nIngrese una opción \n" + menu_s
    end     
    
    def self.enter_approving_grade
        dec_number = false
        okRange = false
        while !dec_number || !okRange
            okRange = true
            puts 'Ingrese calificación aprobatoria (si ingresa blanco, se considera por defecto 5)'
            enter_data = gets.chomp
            dec_number = Ops.verify_decimal(enter_data)
            if !dec_number then
                puts "Ingreso: #{enter_data}, debes Ingresar un numero del 1 al 10"
            elsif enter_data.to_f < 1 || enter_data.to_f > 10
                puts "Ingreso: #{enter_data}, debes Ingresar un numero del 1 al 10"
                okRange = false
            end 
        end
        enter_data = enter_data.to_f
    end
end 

module Ops
    def self.read_file(file_name)
        file = File.open(file_name, 'r')
        data = file.readlines
        file.close
        arr_grades = []
        arr_grades = data.map { |line| line.chomp.split(', ') }
        arr_grades.each do |grade| 
            1.upto(5) { |i| grade[i] = grade[i].to_i }
        end 
        return arr_grades
    end

    def self.read_file_text(file_name)
        file = File.open(file_name, 'r')
        data = file.readlines
        file.close
        arr_grades = []
        arr_grades = data.map { |line| line.chomp.split(', ') }
        return arr_grades
    end

    def self.avg_grades(arr_grades)
        arr_avgs = []
        arr_grades.each do |grade|
            sum = 0
            1.upto(5) { |i| sum += grade[i] }
            arr_avgs << [grade[0], (sum / 5)]
        end 
        return arr_avgs
    end 

    def self.absents(arr_grades)
        arr_absents = []
        arr_grades.each do |grade|
            absent = 0
            1.upto(5) do |i| 
                if grade[i] == "A" 
                    absent += 1 
                end 
            end 
            arr_absents << [grade[0], absent]
        end 
        return arr_absents
    end 

    def self.verify_integer(text)
        int_number = true
        if  text.to_i == 0 || (text.to_i - text.to_f) != 0 
        then  int_number = false
        end   
        return int_number
    end   

    def self.verify_decimal(text)
        dec_number = true
        if  text.to_f == 0  
        then  dec_number = false
        end   
        return dec_number
    end   

    def self.approved(approving_grade, arr_avgs)
        arr_approved = []
        arr_approved = arr_avgs.map do |grade|
           if grade[1] >= approving_grade
                 [grade[0], grade[1]]
           end 
        end
        arr_approved.compact!
        return arr_approved
    end
    
    def self.create_file(arr_avgs)
        file = File.open('average_grades.txt', 'w')
        arr_avgs.each do |key, value| 
            file.puts "#{key}, #{value}"
        end
        file.close
    end     
end 
