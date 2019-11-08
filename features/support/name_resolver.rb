# frozen_string_literal: true

# シナリオの表記名を変換するモジュール
module NameResolver
  def output_to_matcher(output)
    case output
    when '標準出力', 'stdout', 'STDOUT' then :have_output_on_stdout
    when '標準エラー出力', 'stderr', 'STDERR' then :have_output_on_stderr
    else
      :have_output
    end
  end
end

World NameResolver
