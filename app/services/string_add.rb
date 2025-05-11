class StringAdd
    def self.add(data, delimiter = ",")
        # If the string is empty, return 0
        return 0 if data.empty?

        # Check for custom delimiter
        if data.start_with?("//")
            delimiter, data = parse_custom_delimiter(data)
        end

        # Allow the add method to handle new lines between numbers (instead of commas)
        # Convert the strings to integers
        numbers = data.gsub("\n", delimiter).split(delimiter).map(&:to_i)

        # Check for negative numbers and raise an exception if found
        negatives = numbers.select { |n| n < 0 }
        raise "negative numbers not allowed #{negatives}" unless negatives.empty?

        # Add the numbers
        numbers.sum
    end

    private

    def self.parse_custom_delimiter(data)
        # Extract the custom delimiter and the rest of the data
        match = data.match(%r{//(.+)\n(.*)})
        [match[1], match[2]]
    end
end

