module DcClient
  require "xmlrpc/client"
  
  class Connection
    def initialize(dcb)
      @dcb=dcb
      @proxy=XMLRPC::Client.new2(@dcb.url)
    end
  end

  class Servers < Connection
    def initialize(dcb)
      super(dcb)
      @mac_addr=MacAddrs.new(@dcb)
      @ribs=RIB.new(@dcb)
    end

    def list
      server_list=@proxy.call("dc2.inventory.servers.list")
      server_list
    end

    def get(server_id)
      server=@proxy.call("dc2.inventory.servers.find",{"_id"=>server_id})
      server[0]
    end

    def get_mac_addr(server_id)
      mac_list=@mac_addr.list(server_id)
      mac_list
    end
    def get_ribs(server_id)
      rib_list=@ribs.list(server_id)
      rib_list
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

