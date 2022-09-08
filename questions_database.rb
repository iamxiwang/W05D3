require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include singleton

    def initialize
        super('question.db')
        self.type_translation = true
        self.result_as_hash = true
    end
end



