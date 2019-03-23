class Foo

    def bar
        @[20]
    end

    private
    def [](num)
        puts "worked"
    end

end