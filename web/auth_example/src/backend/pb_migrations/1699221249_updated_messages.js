/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("95mde2sv2qnd0mq")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "mdinn2bz",
    "name": "author",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "_pb_users_auth_",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("95mde2sv2qnd0mq")

  // remove
  collection.schema.removeField("mdinn2bz")

  return dao.saveCollection(collection)
})
