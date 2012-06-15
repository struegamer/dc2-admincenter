module DcClient
  require "xmlrpc/client"
  XMLRPC::Config.module_eval {
    remove_const(:ENABLE_NIL_PARSER)     # so that we're not warned about reassigning to a constant
    const_set(:ENABLE_NIL_PARSER, true)  # so that we don't get "RuntimeError: wrong/unknown XML-RPC type 'nil'"
   }

  class Connection
    def initialize(dcb)
      @dcb=dcb
      @proxy=XMLRPC::Client.new2(@dcb.url)
    end
  end

  class Configuration < Connection
    def initialize(dcb)
      super(dcb)
    end

    def environment_names
      envs=@proxy.call("dc2.configuration.environments.list")
      environs={}
      envs.each do |env|
        environs[env["name"]]=env["name"]
      end
      environs
    end
    def defaultclasses_names
      defclasses=@proxy.call("dc2.configuration.defaultclasses.list")
      dfclass={}
      defclasses.each do |dcl|
        dfclass[dcl["classname"]]=dcl["classname"]
      end
      dfclass
    end
  end

  class Servers < Connection
    def initialize(dcb)
      super(dcb)
    end

    def list
      server_list=@proxy.call("dc2.inventory.servers.list")
      server_list
    end

    def get(server_id)
      server_list=@proxy.call("dc2.inventory.servers.find",{"_id"=>server_id})
      server=server_list[0]
      server["macs"]=@proxy.call("dc2.inventory.servers.macaddr.find",{"server_id"=>server_id})
      server["ribs"]=@proxy.call("dc2.inventory.servers.rib.find",{"server_id"=>server_id})
      host=@proxy.call("dc2.inventory.hosts.find",{"server_id"=>server_id})
      server["host"]=host[0]
      server
    end

    def update(server_info,macs,ribs,host)
      server_list=@proxy.call("dc2.inventory.servers.find",{"_id"=>server_info["_id"]})
      server=server_list[0]
      server["asset_tags"]=server_info["asset_tags"]
      server["location"]=server_info["location"]
      @proxy.call("dc2.inventory.servers.update",server)

      macs.each do |mac|
        mac["server_id"]=server["_id"]
        if mac["_id"] != "none"
          if mac["needs_removal"]=="yes"
            mac.delete("needs_removal")
            @proxy.call("dc2.inventory.servers.macaddr.delete",mac)
          else
            @proxy.call("dc2.inventory.servers.macaddr.update",mac)
          end
        else
          mac.delete("_id")
          if mac["mac_addr"]!="" and mac["device_name"]!=""
            @proxy.call("dc2.inventory.servers.macaddr.add",mac)
          end
        end
      end
      if ribs != nil
        ribs.each do |rib|
          rib["server_id"]=server["_id"]
            if rib["_id"] != "none"
              if rib["needs_removal"]=="yes"
                rib.delete("needs_removal")
                @proxy.call("dc2.inventory.servers.rib.delete",rib)
              else
                @proxy.call("dc2.inventory.servers.rib.update",rib)
              end
            else
              rib.delete("_id")
              if rib["remote_type"]!="" and rib["remote_ip"]!=""
                @proxy.call("dc2.inventory.servers.rib.add",rib)
              end
            end
        end
      end
      hostclasses=[]
      host["hostclasses"].each do |hostclass|
        if hostclass != ""
          hostclasses.append(hostclass)
        end
      end
      host["hostclasses"]=hostclasses
      interfaces=[]
      if host['interfaces'] != nil
        host['interfaces'].each do |interface|
          if interface['name']!='' || interface['name']!=null
            interfaces.append(interface)
          end
        end
        host['interfaces']=interfaces
      else
        host['interfaces']=[]
      end
      @proxy.call("dc2.inventory.hosts.update",host)
    end

    def get_mac_device_names(server_id)
      mac_list=@proxy.call("dc2.inventory.servers.macaddr.list",{"server_id"=>server_id})
      macs=[]
      mac_list.each do |mac|
        macs.append(mac["device_name"])
      end
      macs
    end
    def count
      server_list=@proxy.call("dc2.inventory.servers.list")
      server_list.length
    end
  end

  class MacAddrs < Connection
    def list(server_id)
      macaddr_list=@proxy.call("dc2.inventory.servers.macaddr.find",{"server_id"=>server_id})
      macaddr_list
    end
  end

  class RIB < Connection
    def list(server_id)
      rib_list=@proxy.call("dc2.inventory.servers.rib.find",{"server_id"=>server_id})
      if rib_list.kind_of?(Array)
        rib_list
      else
        nil
      end
    end
  end

  class Hosts < Connection 
    def count
      host_list = @proxy.call("dc2.inventory.hosts.list")
      host_list.length
    end

    def list
      host_list = @proxy.call('dc2.inventory.hosts.list')
      host_list
    end

    def count
      host_list = self.list
      host_list.length
    end
  end
  class Installstate < Connection
    def list 
      is_list=@proxy.call('dc2.deployment.installstate.list')
      is_list
    end
    def count
      is_list=self.list
      is_list.length
    end
    def count_lb
      lb_list=@proxy.call('dc2.deployment.installstate.list',{'status'=> 'localboot'})
      lb_list.length
    end
    def count_deploy
      lb_list=@proxy.call('dc2.deployment.installstate.list',{'status'=> 'deploy'})
      lb_list.length
    end
    def update(id,status)
      entry=@proxy.call('dc2.deployment.installstate.get',{'_id'=>id})
      entry['status']=status
      update=@proxy.call('dc2.deployment.installstate.update',entry)
      update
    end
  end
end

