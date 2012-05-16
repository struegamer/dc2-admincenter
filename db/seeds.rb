# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.all().count <= 0
  User.create([
              {username: "admin",password:"admin",firstname:"The Big",lastname:"Administrator",is_admin:true},
              {username: "user",password:"user",firstname:"The",lastname:"User",is_admin:false}
  ])
end

if Kvm.all().count <= 0
  Kvm.create([
             {kvm_type:"ILO1",kvm_name:"HP ILO Version 1"},
             {kvm_type:"ILO2",kvm_name:"HP ILO Version 2"},
             {kvm_type:"ILO3",kvm_name:"HP ILO Version 3"},
             {kvm_type:"FSC",kvm_name:"Fujitsu Siemens RIB"}
  ])
end

if InterfaceType.all().count <= 0
  InterfaceType.create([
                       {name:"Loopback",internal_name:"loopback"},
                       {name:"Ethernet Device",internal_name:"eth"},
                       {name:"Active/Passive Bonding",internal_name:"bond_1"},
                       {name:"Active/Acitve XOR bonding",internal_name:"bond_2"},
                       {name:"VLAN Interface",internal_name:"vlan"}
  ])
end

if InetType.all().count <= 0
  InetType.create([
                  {name:"Loopback Configuration",internal_name:"loopback"},
                  {name:"Static Configuration",internal_name:"static"},
                  {name:"Manual Configuration",internal_name:"manual"},
                  {name:"DHCP Configuration",internal_name:"dhcp"}
  ])
end
