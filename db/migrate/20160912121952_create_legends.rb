Sequel.migration do
  up do
    create_table :legends do
      Uuid :id, primary_key: true, default: 'uuid_generate_v4()'.lit
      foreign_key :layer_id, :layers, type: 'uuid', null: false, on_delete: :cascade

      String :category, null: false
      String :title, null: false
      String :prehtml, null: false
      String :posthtml, null: false
      String :migration_html
      String :properties, null: false, type: 'json'
    end

    alter_table :legends do
      add_index :layer_id
    end
  end

  down do
    alter_table :legends do
      drop_index :layer_id
    end

    drop_table :legends
  end
end
