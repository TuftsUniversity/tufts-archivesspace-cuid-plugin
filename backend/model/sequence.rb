class Sequence < Sequel::Model(:sequence)
  set_primary_key :sequence_name

  def self.get(name)
    self.db.transaction do
      row = self[sequence_name: name]
      if row
        val = row[:value]
        row.update(value: val + 1)
        val
      else
        self.insert(sequence_name: name, value: 1)
        0
      end
    end
  end
end

