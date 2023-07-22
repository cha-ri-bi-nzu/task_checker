module EnumHelper
  def select_from_enum(class_o, column)
    enum_list = class_o.send(column.to_s.pluralize)
    enum_list.map do |column_n, _value|
      [t("enums.#{class_o.to_s}.#{column}.#{column_n}"), column_n]
    end
  end
end
