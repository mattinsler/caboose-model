caboose_model = require '../index'
Connection = require './connection'

module.exports = class Collection
  @create: (connection_name, collection_name, callback) ->
    Connection.create connection_name, (err, conn) ->
      return callback(err) if err?
      
      opts = {}
      
      read_pref = caboose_model.configs[connection_name].readPreference
      if read_pref?
        read_pref = caboose_model.mongodb.ReadPreference[read_pref.toUpperCase()]
        if read_pref?
          opts.readPreference = read_pref
        else
          console.warn(read_pref + ' is not a recognized ReadPreference (check out http://mongodb.github.com/node-mongodb-native/driver-articles/anintroductionto1_1and2_2.html#read-preferences)')
      
      conn.collection(collection_name, opts, callback)
