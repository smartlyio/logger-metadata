require 'spec_helper'
require 'logger/metadata'

RSpec.describe Logger::Metadata do
  let(:output) { StringIO.new }
  let(:logger) { Logger.new(output) }
  subject { Logger::Metadata.inject(logger) }

  it 'includes metadata in logger' do
    subject.metadata(key: 'value') do
      subject.info('foo')
    end
    expect(output.string).to end_with("foo\e[2m (key=value)\e[0m\n")
  end

  it 'handles multiple levels of tagging' do
    subject.metadata(key: 'value') do
      subject.metadata(foo: 'bar') do
        subject.info('test')
      end
    end
    expect(output.string).to end_with("test\e[2m (key=value) (foo=bar)\e[0m\n")
  end

  it 'keeps metadata in their own logger instances' do
    other_output = StringIO.new
    other_logger = Logger::Metadata.inject(Logger.new(other_output))
    subject.metadata(omg: 'lol') do
      other_logger.metadata(foo: 'bar') do
        subject.info('Cool story')
        other_logger.info('Bro')
      end
    end
    expect(output.string).to end_with(" Cool story\e[2m (omg=lol)\e[0m\n")
    expect(other_output.string).to end_with("Bro\e[2m (foo=bar)\e[0m\n")
  end

  it 'cleans up the metadata on flush' do
    subject.metadata(foo: 'bar') do
      Thread.new do
        subject.metadata(omg: 'lol') do
          subject.flush
          subject.info 'test'
        end
      end.join
    end
    expect(output.string).to end_with("test\n")
  end

  it 'clears metadata outside block' do
    subject.metadata(key: 'value') do
    end
    subject.info('bar')
    expect(output.string).to end_with("bar\n")
  end
end
