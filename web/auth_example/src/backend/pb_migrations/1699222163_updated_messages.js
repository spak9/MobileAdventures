/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("95mde2sv2qnd0mq")

  collection.listRule = null

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("95mde2sv2qnd0mq")

  collection.listRule = "@request.auth.id != \"\" && author.id = @request.auth.id"

  return dao.saveCollection(collection)
})
