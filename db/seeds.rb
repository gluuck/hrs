# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Очистка данных..."
ReportingRelationship.delete_all
GroupMembership.delete_all
Group.delete_all
Employee.delete_all

puts "Создание сотрудников..."
alice   = Employee.create!(name: "Алиса Иванова", position: "CEO")
bob     = Employee.create!(name: "Боб Петров", position: "CTO")
carol   = Employee.create!(name: "Каролина Смирнова", position: "Финансовый директор")
dave    = Employee.create!(name: "Давид Левин", position: "Разработчик")
erin    = Employee.create!(name: "Эрин Ким", position: "Аналитик")
frank   = Employee.create!(name: "Фрэнк Юдин", position: "QA")

puts "Создание групп..."
it_dept     = Group.create!(name: "IT Отдел", description: "Все разработчики и тех.руководители")
finance     = Group.create!(name: "Финансовый Отдел", description: "Финансы и бухгалтера")
project_xyz = Group.create!(name: "Проект XYZ", description: "Команда проекта XYZ")

puts "Добавление сотрудников в группы..."
GroupMembership.create!(employee: bob, group: it_dept, role: "Руководитель отдела")
GroupMembership.create!(employee: dave, group: it_dept, role: "Разработчик")
GroupMembership.create!(employee: frank, group: it_dept, role: "QA")

GroupMembership.create!(employee: carol, group: finance, role: "Руководитель отдела")

GroupMembership.create!(employee: erin, group: project_xyz, role: "Бизнес-аналитик")
GroupMembership.create!(employee: dave, group: project_xyz, role: "Разработчик")
GroupMembership.create!(employee: frank, group: project_xyz, role: "QA")

puts "Создание связей подчинения..."
# Простая иерархия
ReportingRelationship.create!(subordinate: bob, supervisor: alice, connection_type: "функциональный")
ReportingRelationship.create!(subordinate: carol, supervisor: alice, connection_type: "функциональный")

# Подчинение сотруднику
ReportingRelationship.create!(subordinate: dave, supervisor: bob, connection_type: "функциональный")
ReportingRelationship.create!(subordinate: frank, supervisor: bob, connection_type: "функциональный")

# Подчинение отделу
ReportingRelationship.create!(subordinate: erin, supervisor: finance, connection_type: "по структуре")

# Матричная структура: у Дейва 2 руководителя — CTO и руководитель проекта
ReportingRelationship.create!(subordinate: dave, supervisor: Group.find_by(name: "Проект XYZ"), connection_type: "проектный")

puts "Готово! Сотрудники, группы и связи созданы."
