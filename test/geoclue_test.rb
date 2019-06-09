require "test_helper"

class GeoClueTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GeoClue::VERSION
  end

  def test_that_cache_knows_if_it_exists
    cache = GeoClue::Cache.new
    File.unlink(cache.filepath) if File.exists?(cache.filepath)
    assert ! cache.exists?
    File.new(cache.filepath, 'w')
    assert cache.exists?
  end

  def test_that_cache_knows_if_it_is_recent
    cache = GeoClue::Cache.new
    FileUtils.touch(cache.filepath, mtime: Time.now - 601)
    assert ! cache.recent?
    FileUtils.touch(cache.filepath, mtime: Time.now - 599)
    assert cache.recent?
  end

  def test_that_cache_filepath_is_correct
    ENV['XDG_CACHE_HOME'] = File.expand_path('~/.cache')
    assert_equal File.expand_path("~/.cache/geoclue-cache.json"), GeoClue::Cache.new.filepath
  end
end
