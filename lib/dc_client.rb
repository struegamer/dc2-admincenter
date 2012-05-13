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
end

