class MainController < ApplicationController
    def index
        client = Mongo::Client.new('mongodb://127.0.0.1:27017/PROJECT')
        db = client.database

        collection = client[:imdb]
        data = collection.aggregate([
            {
                '$match' => { 'rating' => { '$ne' => 0.0 } }
            },
            {
                '$group' => {
                    '_id' => '$titleType',
                    'average' => { '$avg' => '$rating' }
                } 
            },
            {
                '$sort' => { '_id' => 1 }
            },
            {
                '$match' => { 'average' => { '$ne' => 0 } }
            }
        ])

        @data_list_2 = [['Title Category', 'Average', {role: 'style'}, {role: 'annotation'}]]
        color_list = ['blue', 'yellow', 'green', 'red', 'purple']
        labels = ['Short', 'Movie', 'TV Movie', 'TV Short', 'TV Special', 'VideoGame']
        counter = 0

        data.each do |doc|
            @data_list_2 << [doc[:_id], doc[:average], color_list[counter], labels[counter]]
            counter += 1
        end

        @data_list_2 = @data_list_2.slice(0, 11)
    end

    def runtime
        client = Mongo::Client.new('mongodb://127.0.0.1:27017/PROJECT')
        db = client.database

        collection = client[:imdb]
        data = collection.aggregate([
            {
                '$match' => { 'rating' => { '$ne' => 0.0 } }
            },
            {
                '$group' => {
                    '_id' => '$runtime_category',
                    'average' => { '$avg' => '$rating' }
                } 
            },
            {
                '$sort' => { '_id' => 1 }
            },
            {
                '$match' => { 'average' => { '$ne' => 0 } }
            }
        ])

        @data_list = []
        #@data_list = {
        #    'Category': [],
        #    'Average': []
        #}
        data.each do |doc|
            @data_list << [doc[:_id], doc[:average]]
            #@data_list[:Category] << doc[:_id]
            #@data_list[:Average] << doc[:average]
        end
        @data_list = @data_list.slice(0, 10)
    end

    def actors
        client = Mongo::Client.new('mongodb://127.0.0.1:27017/PROJECT')
        db = client.database

        collection = client[:imdb]
        data = collection.aggregate([
            {
                '$match' => { 'numVotes' => { '$ne' => 0 } }
            },
            {
                '$group' => {
                    '_id' => '$primaryName',
                    'total' => { '$sum' => '$numVotes' }
                } 
            },
            {
                '$sort' => { 'total' => -1 }
            },
            {
                '$match' => { 'total' => { '$ne' => 0 } }
            },
            {
                '$limit' => 10
            }
        ],
        {
            :allow_disk_use => true
        })

        @data_list_3 = [['Worker', 'Total Votes', {role: 'annotation'}]]
        counter = 0

        data.each do |doc|
            @data_list_3 << [counter, doc[:total], doc[:_id]]
            counter += 1
        end

        @data_list_3
    end
end
