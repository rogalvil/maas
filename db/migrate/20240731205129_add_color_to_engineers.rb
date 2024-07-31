class AddColorToEngineers < ActiveRecord::Migration[7.0]
  def up
    add_column :engineers, :color, :string, null: false, default: '#0000FF'

    Engineer.reset_column_information
    Engineer.find_each do |engineer|
      engineer.update!(color: engineer.send(:generate_unique_color))
    end

    add_index :engineers, :color, unique: true
  end

  def down
    remove_index :engineers, :color
    remove_column :engineers, :color
  end
end
