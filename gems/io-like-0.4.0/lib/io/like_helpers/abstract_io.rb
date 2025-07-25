# frozen_string_literal: true

class IO; module LikeHelpers

##
# @abstract It defines the structure expected of low level streams and largely
#   reflects the structure of the IO class, but most methods raise
#   NotImplementedError.  Only the most basic semantics for stream opening and
#   closing are provided.
class AbstractIO
  ##
  # @overload open(*args, **kwargs)
  #   Equivalent to {#initialize}.
  #
  #   @return a new instances of this class
  #
  # @overload open(*args, **kwargs)
  #   Yields the new instance of this class to the block, ensures the instance
  #   is closed once the block completes, and returns the result of the block.
  #
  #   @yieldparam stream an instance of this class
  #
  #   @return [block result]
  #
  # @param args a list of arguments passed to the initializer of this class
  # @param kwargs a list of keyword arguments passed to the initializer of this
  #   class
  def self.open(*args, **kwargs)
    io = new(*args, **kwargs)
    return io unless block_given?

    begin
      yield(io)
    ensure
      while Symbol === io.close do
        warn 'warning: waiting for nonblocking close to complete at the end of the open method'
        # A wait timeout is used in order to allow a retry in case the stream
        # was closed in another thread while waiting.
        io.wait(IO::READABLE | IO::WRITABLE, 1)
      end
    end
  end

  ##
  # Creates a new instance of this class.
  #
  # @param kwargs [Hash] only provided for compatibility with .open on Ruby 2.6
  #
  # @todo Remove explicit `kwargs` parameter when Ruby 2.6 support is dropped.
  def initialize(**kwargs)
    @closed = false
  end

  ##
  # Announces an intention to access data from the stream in a specific pattern.
  #
  # This method is a no-op if not implemented.  If `offset` and `len` are both
  # `0`, then the entire stream is affected.
  #
  # | `advice` | Meaning |
  # | -------- | ------- |
  # | `:normal` | No advice given; default assumption for the stream. |
  # | `:sequential` | The data will be read sequentially from lower offsets to higher ones. |
  # | `:random` | The data will be accessed in random order. |
  # | `:willneed` | The data will be accessed in the near future. |
  # | `:dontneed` | The data will not be accessed in the near future. |
  # | `:noreuse` | The data will only be accessed once. |
  #
  # See `posix_fadvise(2)` for more details.
  #
  # @param advice [Symbol] the access pattern
  # @param offset [Integer] the starting location of the data that will be
  #   accessed
  # @param len [Integer] the length of the data that will be accessed
  #
  # @return [nil]
  #
  # @raise [IOError] if the stream is closed
  def advise(advice, offset = 0, len = 0)
    nil
  end

  ##
  # Closes the stream.
  #
  # Most operations on the stream after this method is called will result in
  # IOErrors being raised.
  #
  # @return [nil] on success
  # @return [:wait_readable, :wait_writable] if the stream is non-blocking and
  #   the operation would block
  def close
    @closed = true
    nil
  end

  ##
  # Returns `true` if this stream is closed and `false` otherwise.
  #
  # @return [Boolean]
  def closed?
    @closed
  end

  ##
  # Sets the close-on-exec flag for the underlying file descriptor.
  #
  # Note that setting this to `false` can lead to file descriptor leaks in
  # multithreaded applications that fork and exec or use the `system` method.
  #
  # @return [Boolean]
  def close_on_exec=(close_on_exec)
    raise NotImplementedError
  end

  ##
  # Returns `true` if the close-on-exec flag is set for this stream and `false`
  # otherwise.
  #
  # @return [Boolean]
  def close_on_exec?
    raise NotImplementedError
  end

  ##
  # Issues low level commands to control or query the file-oriented stream upon
  # which this stream is based.
  #
  # @param integer_cmd [Integer] passed directly to `fcntl(2)` as an operation
  #   identifier
  # @param arg [Integer, String] passed directly to `fcntl(2)` if an Integer and
  #   as a binary sequence of bytes otherwise
  #
  # @return [Integer] the return value of `fcntl(2)` when not an error
  #
  # @raise [IOError] if the stream is closed
  # @raise [NotImplementedError] on platforms without the `fcntl(2)` function
  # @raise [SystemCallError] on system level errors
  def fcntl(integer_cmd, arg)
    raise NotImplementedError
  end

  ##
  # Triggers the operating system to write any buffered metadata to disk
  # immediately.
  #
  # The default implementation calls {#fsync}, but override this if the stream
  # natively supports the equivalent of `fdatasync(2)` to offer better
  # performance when only metadata needs to be flushed to disk.
  #
  # @return [0, nil]
  def fdatasync
    fsync
  end

  ##
  # @return [Integer] the numeric file descriptor for the stream
  def fileno
    raise NotImplementedError
  end

  ##
  # Triggers the operating system to write any buffered data to disk
  # immediately.
  #
  # @return [0, nil]
  def fsync
    raise NotImplementedError
  end

  ##
  # Issues low level commands to control or query the device upon which this
  # stream is based.
  #
  # @param integer_cmd [Integer] passed directly to `ioctl(2)` as a device
  #   dependent request code
  # @param arg [Integer, String] passed directly to `ioctl(2)` if an Integer and
  #   as a binary sequence of bytes otherwise
  #
  # @return [Integer] the return value of `ioctl(2)` when not an error
  #
  # @raise [IOError] if the stream is closed
  # @raise [NotImplementedError] on platforms without the `ioctl(2)` function
  # @raise [SystemCallError] on system level errors
  def ioctl(integer_cmd, arg)
    raise NotImplementedError
  end

  ##
  # Yields `self` to the given block after setting the blocking mode as dictated
  # by `nonblock`.
  #
  # Ensures that the original blocking mode is reinstated after yielding.
  #
  # @param nonblock [Boolean] sets the stream to non-blocking mode if `true` and
  #   blocking mode otherwise
  #
  # @yieldparam self [Like] this stream
  #
  # @return [self]
  #
  # @raise [IOError] if the stream is closed
  def nonblock(nonblock = true)
    assert_open
    begin
      orig_nonblock = nonblock?
      self.nonblock = nonblock
      yield(self)
    ensure
      self.nonblock = orig_nonblock
    end
  end

  ##
  # Sets the stream into either blocking or non-blocking mode.
  #
  # @param nonblock [Boolean] `true` for non-blocking mode, `false` otherwise
  #
  # @raise [IOError] if the stream is closed
  def nonblock=(nonblock)
    raise NotImplementedError
  end

  ##
  # Returns whether or not the stream is in non-blocking mode.
  #
  # @return [true] if the stream is in non-blocking mode
  # @return [false] if the stream is in blocking mode
  #
  # @raise [IOError] if the stream is closed
  def nonblock?
    raise NotImplementedError
  end

  ##
  # @return [Integer] the number of bytes that can be read without blocking or
  #   `0` if unknown
  #
  # @raise [IOError] if the stream is not open for reading
  def nread
    assert_readable
    0
  end

  ##
  # Returns the path of the file associated with this stream.
  #
  # @return [String]
  def path
    raise NotImplementedError
  end

  ##
  # Returns the pid of the process associated with this stream.
  #
  # @return [Integer] if the stream is associated with a process
  # @return [nil] if the stream is not associated with a process
  #
  # @raise [IOError] if the stream is closed
  def pid
    assert_open
    nil
  end

  ##
  # Reads at most `length` bytes from the stream starting at `offset` without
  # modifying the read position in the stream.
  #
  # Note that a partial read will occur if the stream is in non-blocking mode
  # and reading more bytes would block.
  #
  # @param length [Integer] the maximum number of bytes to read
  # @param offset [Integer] the offset from the beginning of the stream at which
  #   to begin reading
  # @param buffer [String] if provided, a buffer into which the bytes should be
  #   placed
  # @param buffer_offset [Integer] the index at which to insert bytes into
  #   `buffer`
  #
  # @return [Integer] the number of bytes read if `buffer` is not `nil`
  # @return [String] a new String containing the bytes read if `buffer` is `nil`
  #   or `buffer` if provided
  # @return [:wait_readable, :wait_writable] if the stream is non-blocking and
  #   the operation would block
  #
  # @raise [EOFError] when reading at the end of the stream
  # @raise [IOError] if the stream is not readable
  def pread(length, offset, buffer: nil, buffer_offset: 0)
    position = seek(0, IO::SEEK_CUR)

    seek(offset, IO::SEEK_SET)
    begin
      read(length, buffer: buffer, buffer_offset: buffer_offset)
    ensure
      seek(position, IO::SEEK_SET)
    end
  end

  ##
  # Writes at most `length` bytes to the stream starting at `offset` without
  # modifying the write position in the stream.
  #
  # Note that a partial write will occur if the stream is in non-blocking mode
  # and writing more bytes would block.
  #
  # @param buffer [String] the bytes to write (encoding assumed to be binary)
  # @param offset [Integer] the offset from the beginning of the stream at which
  #   to begin writing
  # @param length [Integer] the number of bytes to write from `buffer`
  #
  # @return [Integer] the number of bytes written
  # @return [:wait_readable, :wait_writable] if the stream is non-blocking and
  #   the operation would block
  #
  # @raise [IOError] if the stream is not writable
  def pwrite(buffer, offset, length: buffer.bytesize)
    position = seek(0, IO::SEEK_CUR)

    seek(offset, IO::SEEK_SET)
    begin
      write(buffer, length: length)
    ensure
      seek(position, IO::SEEK_SET)
    end
  end

  ##
  # Reads bytes from the stream.
  #
  # Note that a partial read will occur if the stream is in non-blocking mode
  # and reading more bytes would block.
  #
  # @param length [Integer] the number of bytes to read
  # @param buffer [String] the buffer into which bytes will be read (encoding
  #   assumed to be binary)
  # @param buffer_offset [Integer] the index at which to insert bytes into
  #   `buffer`
  #
  # @return [Integer] the number of bytes read if `buffer` is not `nil`
  # @return [String] a buffer containing the bytes read if `buffer` is `nil`
  # @return [:wait_readable, :wait_writable] if the stream is non-blocking and
  #   the operation would block
  #
  # @raise [EOFError] when reading at the end of the stream
  # @raise [IOError] if the stream is not readable
  def read(length, buffer: nil, buffer_offset: 0)
    assert_readable
  end

  ##
  # Returns `true` if the stream is readable and `false` otherwise.
  #
  # @return [Boolean]
  def readable?
    false
  end

  ##
  # Returns whether or not the stream has input available.
  #
  # @return [true] if input is available
  # @return [false] if input is not available
  def ready?
    assert_open
    false
  end

  ##
  # Sets the current stream position to `amount` based on the setting of
  # `whence`.
  #
  # | `whence` | `amount` Interpretation |
  # | -------- | ----------------------- |
  # | `:CUR` or `IO::SEEK_CUR` | `amount` added to current stream position |
  # | `:END` or `IO::SEEK_END` | `amount` added to end of stream position (`amount` will usually be negative here) |
  # | `:SET` or `IO::SEEK_SET` | `amount` used as absolute position |
  #
  # @param amount [Integer] the amount to move the position in bytes
  # @param whence [Integer, Symbol] the position alias from which to consider
  #   `amount`
  #
  # @return [Integer] the new stream position
  #
  # @raise [IOError] if the stream is closed
  # @raise [Errno::ESPIPE] if the stream is not seekable
  def seek(amount, whence)
    assert_open
    raise Errno::ESPIPE
  end

  ##
  # Returns status information for the stream.
  #
  # @return [File::Stat]
  def stat
    raise NotImplementedError
  end

  ##
  # Returns the native IO object upon which this stream is based.
  #
  # @return [IO]
  def to_io
    raise NotImplementedError
  end

  ##
  # Returns whether or not the stream is a tty.
  #
  # @return [true] if the stream is a tty
  # @return [false] if the stream is not a tty
  #
  # @raise [IOError] if the stream is closed
  def tty?
    assert_open
    false
  end

  ##
  # Waits until the stream becomes ready for at least 1 of the specified events.
  #
  # @param events [Integer] a bit mask of `IO::READABLE`, `IO::WRITABLE`, or
  #   `IO::PRIORITY`
  # @param timeout [Numeric, nil] the timeout in seconds or no timeout if `nil`
  #
  # @return [true] if the stream becomes ready for at least one of the given
  #   events
  # @return [false] if the IO does not become ready before the timeout
  def wait(events, timeout = nil)
    raise NotImplementedError
  end

  ##
  # Writes bytes to the stream.
  #
  # Note that a partial write will occur if the stream is in non-blocking mode
  # and writing more bytes would block.
  #
  # @param buffer [String] the bytes to write (encoding assumed to be binary)
  # @param length [Integer] the number of bytes to write from `buffer`
  #
  # @return [Integer] the number of bytes written
  # @return [:wait_readable, :wait_writable] if the stream is non-blocking and
  #   the operation would block
  #
  # @raise [IOError] if the stream is not writable
  def write(buffer, length: buffer.bytesize)
    assert_writable
  end

  ##
  # Returns `true` if the stream is writable and `false` otherwise.
  #
  # @return [Boolean]
  def writable?
    false
  end

  private

  ##
  # Raises an exception if the stream is closed.
  #
  # @return [nil]
  #
  # @raise IOError if the stream is closed
  def assert_open
    raise IOError, 'uninitialized stream' unless defined? @closed
    raise IOError, 'closed stream' if closed?
  end

  ##
  # Raises an exception if the stream is closed or not open for reading.
  #
  # @return [nil]
  #
  # @raise IOError if the stream is closed or not open for reading
  def assert_readable
    assert_open
    raise IOError, 'not opened for reading' unless readable?
  end

  ##
  # Raises an exception if the stream is closed or not open for writing.
  #
  # @return [nil]
  #
  # @raise IOError if the stream is closed or not open for writing
  def assert_writable
    assert_open
    raise IOError, 'not opened for writing' unless writable?
  end

  ##
  # Creates an instance of this class that copies state from `other`.
  #
  # @param other [AbstractIO] the instance to copy
  #
  # @return [nil]
  #
  # @raise [IOError] if `other` is closed
  def initialize_copy(other)
    assert_open

    super

    nil
  end
end
end; end

# vim: ts=2 sw=2 et
