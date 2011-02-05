TDD 写経
========

-1st イテレーション::
        http://d.hatena.ne.jp/t-wada/20100228/p1
-2nd イテレーション::
        http://d.hatena.ne.jp/t-wada/20100306/p1

1st イテレーション
==================

最初の spec 実行。
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

テストを通すための仮実装!
        $ rspec -I. message_filter_spec.rb
        .
        
        Finished in 0.00038 seconds
        1 example, 0 failures

example を追加した。
        $ rspec -I. message_filter_spec.rb
        .F
        
        Failures:
        
          1) MessageFilter should not detect message without NG word
             Failure/Error: filter.detect?("hello world").should == false
               expected: false
                    got: true (using ==)
             # ./message_filter_spec.rb:13:in `block (2 levels) in <top (required)>'
        
        Finished in 0.00062 seconds
        2 examples, 1 failure

正しい実装に直した。
        $ rspec -I. message_filter_spec.rb
        ..
        
        Finished in 0.00052 seconds
        2 examples, 0 failures

ここで tag "1st_spec_refactoring" を打つ。
        $ git tag
        1st_spec_refactoring

テストをリファクタリング。デフォルト扱いな引数 :each も削除。さらに matcher の be_detect を追加。
        $ rspec -I. message_filter_spec.rb
        ..
        
        Finished in 0.00052 seconds
        2 examples, 0 failures

it にくっつけてる説明を消して rspec に推測させる。
        $ rspec -I. message_filter_spec.rb    
        ..
        
        Finished in 0.00067 seconds
        2 examples, 0 failures
        $ rspec -I. -fs message_filter_spec.rb
        
        MessageFilter
          should be detect "hello from foo"
          should not be detect "hello world"
        
        Finished in 0.00079 seconds
        2 examples, 0 failures

説明をもっと追加。テスト対象を subject で宣言してコードを洗練。
before が仕事してないので subject でインスタンスを生成するように変更。
        $ rspec -I. -fs message_filter_spec.rb                                 
        
        MessageFilter with argument "foo"
          should be detect "hello from foo"
          should not be detect "hello world"
        
        Finished in 0.00079 seconds
        2 examples, 0 failures

1st イテレーションはこれで終わりなので tag end_of_1st を打つ。
        $ git tag
        1st_spec_refactoring
        end_of_1st


2nd イテレーション
==================
引数を 2 つにした example を書く。
        $ rspec -I. -fs message_filter_spec.rb
        
        MessageFilter with argument "foo"
          should be detect "hello from foo"
          should not be detect "hello world"
        
        MessageFilter with argument "foo","bar"
           (FAILED - 1)
        
        Failures:
        
          1) MessageFilter with argument "foo","bar" 
             Failure/Error: subject { MessageFilter.new("foo", "bar") }
             ArgumentError:
               wrong number of arguments (2 for 1)
             # ./message_filter.rb:2:in `initialize'
             # ./message_filter_spec.rb:18:in `new'
             # ./message_filter_spec.rb:18:in `block (2 levels) in <top (required)>'
             # ./message_filter_spec.rb:19:in `block (2 levels) in <top (required)>'
        
        Finished in 0.00145 seconds
        3 examples, 1 failure

えいやっと実装。テストは通るけど不安は残る。
        $ rspec -I. -fs message_filter_spec.rb                 
        
        MessageFilter with argument "foo"
          should be detect "hello from foo"
          should not be detect "hello world"
        
        MessageFilter with argument "foo","bar"
          should be detect "hello from foo"
        
        Finished in 0.00118 seconds
        3 examples, 0 failures

引数が 1 つの example のテストを、引数が複数の example に混ぜる。
        $ rspec -I. -fs message_filter_spec.rb                           
        
        MessageFilter with argument "foo"
          should be detect "hello from foo"
          should not be detect "hello world"
        
        MessageFilter with argument "foo","bar"
          should be detect "hello from foo"
          should be detect "hello from foo"
          should not be detect "hello world"
        
        Finished in 0.00214 seconds
        5 examples, 0 failures

テストの重複を、share_examples_for と it_should_behave_like で除去する。
        $ rspec -I. -fs message_filter_spec.rb                                                
        
        MessageFilter with argument "foo"
          it should behave like MessageFilter with argument "foo"
            should be detect "hello from foo"
            should not be detect "hello world"
        
        MessageFilter with argument "foo","bar"
          should be detect "hello from foo"
          it should behave like MessageFilter with argument "foo"
            should be detect "hello from foo"
            should not be detect "hello world"
        
        Finished in 0.00195 seconds
        5 examples, 0 failures

describe をネストして、くどいメッセージをすっきりさせてみる。
状況を説明していた describe を alias の context に変えた。
安直な実装を Enumerable#any? を使うようにリファクタリングした。
        $ rspec -I. -fs message_filter_spec.rb
        
        MessageFilter
          with argument "foo"
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
          with argument "foo","bar"
            should be detect "hello from foo"
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
        
        Finished in 0.00227 seconds
        5 examples, 0 failures

2nd イテレーションの終わりなので tag end_of_2nd を打つ。
        $ git tag
        1st_spec_refactoring
        end_of_1st
        end_of_2nd


3rd イテレーション
==================

登録された NG ワードが空でないことのための example を書いた。
        $ rspec -I. -fs message_filter_spec.rb
        
        MessageFilter
          with argument "foo"
            ng_words should not be empty (FAILED - 1)
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
          with argument "foo","bar"
            should be detect "hello from foo"
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
        
        Failures:
        
          1) MessageFilter with argument "foo" ng_words should not be empty
             Failure/Error: subject.ng_words.empty?.should == false
             NoMethodError:
               undefined method `ng_words' for #<MessageFilter:0x94093f0 @words=["foo"]>
             # ./message_filter_spec.rb:15:in `block (3 levels) in <top (required)>'
        
        Finished in 0.00253 seconds
        6 examples, 1 failure

明白な実装をした。
predicate マッチャを使うようにした。rspec のバージョンによってメッセージ違ってそうだ。
        $ rspec -I. -fs message_filter_spec.rb
        
        MessageFilter
          with argument "foo"
            ng_words should not be empty
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
          with argument "foo","bar"
            should be detect "hello from foo"
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
        
        Finished in 0.00221 seconds
        6 examples, 0 failures

it の説明を rspec に任せるようにしたら微妙な結果になった。
        $ rspec -I. -fs message_filter_spec.rb
        
        MessageFilter
          with argument "foo"
            should not be empty
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
          with argument "foo","bar"
            should be detect "hello from foo"
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
        
        Finished in 0.00183 seconds
        6 examples, 0 failures

its を使うとちょっとましになった。
        $ rspec -I. -fs message_filter_spec.rb                                         
        
        MessageFilter
          with argument "foo"
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
            ng_words
              should not be empty
          with argument "foo","bar"
            should be detect "hello from foo"
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
        
        Finished in 0.00191 seconds
        6 examples, 0 failures

its を share_examples_for に移した。
        $ rspec -I. -fs message_filter_spec.rb                 
        
        MessageFilter
          with argument "foo"
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
              ng_words
                should not be empty
          with argument "foo","bar"
            should be detect "hello from foo"
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
              ng_words
                should not be empty
        
        Finished in 0.00222 seconds
        7 examples, 0 failures

NG word のサイズを返すことのテストを追加した。
サイズを見るための have マッチャを使うように変更。
        $ rspec -I. -fs message_filter_spec.rb                   
        
        MessageFilter
          with argument "foo"
            ng_wors size is 1
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
              ng_words
                should not be empty
          with argument "foo","bar"
            should be detect "hello from foo"
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
              ng_words
                should not be empty
        
        Finished in 0.00252 seconds
        8 examples, 0 failures

説明を rspec に任せた。
        $ rspec -I. -fs message_filter_spec.rb
        
        MessageFilter
          with argument "foo"
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
              ng_words
                should not be empty
            ng_words
              should have 1 items
          with argument "foo","bar"
            should be detect "hello from foo"
            it should behave like exercise with argument "foo"
              should be detect "hello from foo"
              should not be detect "hello world"
              ng_words
                should not be empty
        
        Finished in 0.00264 seconds
        8 examples, 0 failures
