class MainController < ApplicationController
    def index
        client = Mongo::Client.new(['127.0.0.1:27017'], database => 'PROJECT')
        db = client.database

        db.collections
        db.collection_names
    end

    def runtime

    end
end
