# frozen_string_literal: true

# Module that can be included (mixin) to take and output Yaml data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    newline = "\n"
    tab     = "\t"
    @data = []
    content = tsv.split(newline).map { |line| line.split(tab) }
    header = content.first
    content.delete_at(0)
    @data = content.map do |record|
      record.each_with_index.map { |item, idx| [header[idx], item] }.to_h
    end
  end
  # to_tsv: converts @data into tsv string
  # returns: String in TSV format

  def to_tsv
    newline = "\n"
    tab     = "\t"
    header  = @data.first.keys.join(tab)
    records = @data.map { |record| record.values.join(tab) }
    ([header] + records).join(newline) + newline
  end
end
