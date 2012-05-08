module DcClient
  require "xmlrpc/client"
  
  class Connection
    def initialize(xmlrpc_url)
      @xmlrpc_url=xmlrpc_url
      @proxy=XMLRPC::Client.new2(@xmlrpc_url)
    end
  end

  class Servers < Connection
    def list
      server_list=@proxy.call("dc2.inventory.servers.list")
      server_list
    end
  end
end

