http://d.hatena.ne.jp/t-wada/20100228/p1

最初の spec 実行
----------------
ちゃんと失敗する。
    $ rspec message_filter_spec.rb
    /home/yuji/.gem/ruby/1.9.1/gems/rspec-core-2.4.0/lib/rspec/core/backward_compatibility.rb:20:in `const_missing': uninitialized constant Object::MessageFilter (NameError)
            from /home/yuji/.gem/ruby/1.9.1/gems/rspec-expectations-2.4.0/lib/rspec/expectations/backward_compatibility.rb:6:in `const_missing'
            from /home/yuji/work/r/rspec-tutorial_t-wada-style/message_filter_spec.rb:4:in `<top (required)>'
            from /home/yuji/.gem/ruby/1.9.1/gems/rspec-core-2.4.0/lib/rspec/core/configuration.rb:387:in `load'
            from /home/yuji/.gem/ruby/1.9.1/gems/rspec-core-2.4.0/lib/rspec/core/configuration.rb:387:in `block in load_spec_files'
            from /home/yuji/.gem/ruby/1.9.1/gems/rspec-core-2.4.0/lib/rspec/core/configuration.rb:387:in `map'
            from /home/yuji/.gem/ruby/1.9.1/gems/rspec-core-2.4.0/lib/rspec/core/configuration.rb:387:in `load_spec_files'
            from /home/yuji/.gem/ruby/1.9.1/gems/rspec-core-2.4.0/lib/rspec/core/command_line.rb:18:in `run'
            from /home/yuji/.gem/ruby/1.9.1/gems/rspec-core-2.4.0/lib/rspec/core/runner.rb:55:in `run_in_process'
            from /home/yuji/.gem/ruby/1.9.1/gems/rspec-core-2.4.0/lib/rspec/core/runner.rb:46:in `run'
            from /home/yuji/.gem/ruby/1.9.1/gems/rspec-core-2.4.0/lib/rspec/core/runner.rb:10:in `block in autorun'

MessageFilter クラスを作る。そうするとエラーにならなくなる。
なんか怒られてるのは無視しておこう。
    $ cat message_filter.rb                             
    class MessageFilter
    end
    $ rspec -I. message_filter_spec.rb
    No examples were matched. Perhaps {:if=>#<Proc:0x8540418@/home/yuji/.gem/ruby/1.9.1/gems/rspec-core-2.4.0/lib/rspec/core/configuration.rb:50 (lambda)>, :unless=>#<Proc:0x85403dc@/home/yuji/.gem/ruby/1.9.1/gems/rspec-core-2.4.0/lib/rspec/core/configuration.rb:51 (lambda)>} is excluding everything?
    
    
    Finished in 0.00004 seconds
    0 examples, 0 failures

example を追加した。NoMethodError で怒られてる。
コンストラクタ無いのはいいのかしら...
    $ rspec -I. message_filter_spec.rb
    F
    
    Failures:
    
      1) MessageFilter should detect message with NG word
         Failure/Error: filter.detect?("hello from foo").should == true
         NoMethodError:
           undefined method `detect?' for #<MessageFilter:0x9b686c8>
         # ./message_filter_spec.rb:8:in `block (2 levels) in <top (required)>'
    
    Finished in 0.00043 seconds
    1 example, 1 failure

detect? メソッドの空実装をしてみた。
    $ rspec -I. message_filter_spec.rb
    F
    
    Failures:
    
      1) MessageFilter should detect message with NG word
         Failure/Error: filter.detect?("hello from foo").should == true
           expected: true
                got: nil (using ==)
         # ./message_filter_spec.rb:8:in `block (2 levels) in <top (required)>'
    
    Finished in 0.00052 seconds
    1 example, 1 failure
