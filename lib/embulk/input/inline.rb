module Embulk
  module Input

    class Inline < InputPlugin
      Plugin.register_input("inline", self)

      def self.transaction(config, &control)
        task = {
          "schema" => config.param("schema", :array),
          "data" => config.param("data", :array)
        }

        columns = task['schema'].map.with_index { |column, i|
          Column.new(i, column['name'], column['type'].to_sym)
        }

        resume(task, columns, 1, &control)
      end

      def self.resume(task, columns, count, &control)
        task_reports = yield(task, columns, count)

        next_config_diff = {}
        return next_config_diff
      end

      def init
        @data = task["data"]
      end

      def run
        @data.each do |record|
          values = schema.map { |column|
            convert_value(column.type, record[column.name])
          }
          page_builder.add(values)
        end
        page_builder.finish

        task_report = {}
        return task_report
      end

      private

      def convert_value(type, value)
        return nil if value.nil?
        case type
        when :string
          value
        when :long
          value.to_i
        when :double
          value.to_f
        when :boolean
          if value.is_a?(TrueClass) || value.is_a?(FalseClass)
            value
          else
            downcased_val = value.downcase
            case downcased_val
            when 'true' then true
            when 'false' then false
            when '1' then true
            when '0' then false
            else nil
            end
          end
        when :timestamp
          Time.parse(value)
        when :json
          value
        else
          raise "Unsupported type #{field['type']}"
        end
      end
    end
  end
end
