# frozen_string_literal: true

module ProtoBoeuf
  module Protobuf
    class FloatValue
      def self.decode(buff)
        buff = buff.b
        allocate.decode_from(buff, 0, buff.bytesize)
      end

      def self.encode(obj)
        buff = obj._encode "".b
        buff.force_encoding(Encoding::ASCII_8BIT)
      end
      # required field readers
      attr_accessor :value

      def initialize(value: 0.0)
        @value = value
      end

      def decode_from(buff, index, len)
        @value = 0.0

        tag = buff.getbyte(index)
        index += 1

        while true
          if tag == 0xd
            @value = buff.unpack1("F", offset: index)
            index += 4

            return self if index >= len
            tag = buff.getbyte(index)
            index += 1
          end

          return self if index >= len
        end
      end
      def _encode(buff)
        val = @value
        if val != 0
          buff << 0x0d

          buff << [val].pack("F")
        end

        buff
      end
      def to_h
        result = {}
        result["value".to_sym] = @value
        result
      end
    end
  end
end
