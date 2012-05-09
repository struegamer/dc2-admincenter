module DcClient
  require "xmlrpc/client"
  
  class Connection
    def initialize(dcb)
      @dcb=dcb
      @proxy=XMLRPC::Client.new2(@dcb.url)
    end
  end

  class Servers < Connection
    def list
      server_list=@proxy.call("dc2.inventory.servers.list")
      server_list
    end
  end
end

