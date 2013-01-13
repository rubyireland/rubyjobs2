class CreateJobs < ActiveRecord::Migration
  def up
    create_table :jobs do |t|
			
			t.column :company,						:string, :limit => 50
			t.column :url,								:string, :limit => 300
			t.column :email,							:string, :limit => 200
			
			t.column :type_id,						:integer
			t.column :location_id,				:integer
			t.column :title,							:string, :limit => 50
			t.column :description,				:string, :limit => 8000
			t.column :how_to_apply,				:string, :limit => 100
			t.column :key, 								:string

      t.timestamps
    end
  end

  def down
    drop_table :jobs
  end
end
