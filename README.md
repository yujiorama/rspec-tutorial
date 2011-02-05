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

