require 'feedzirra'
class EntryParser
  def initialize(entry)
    @entry = entry
    @description_hash = parse_entry_description
    @show = nil
    @episode = nil
    @torrent = nil
  end

  def parse
    @show = parse_and_create_show
    @episode = parse_and_create_episode
    @torrent = parse_and_create_torrent
  end

  protected

  def parse_entry_description
    result = Hash.new
    split_description = @entry.summary.split(';').map{ |i| i.strip }
    result[:show_name] = split_description[0]
    result[:show_title] = split_description[1]
    result[:season_number] = split_description[2]
    result[:episode_number] = split_description[3]
    result[:filename] = split_description[4]
    result
  end

  def parse_and_create_show
    @show = Show.find_or_create_by_name(parse_show_name)
  end

  def parse_and_create_episode
    @episode =
      @show.episodes.find_or_create_by_episode_number_and_season_number(
        title: parse_episode_title,
        episode_number: parse_episode_number,
        season_number: parse_season_number
      )
  end

  def parse_and_create_torrent
    @torrent = @episode.torrents.find_or_create_by_guid(
      title: @entry.title,
      guid: @entry.entry_id,
      link: @entry.url,
      description: @entry.summary,
      published_at: @entry.published,
      filename: parse_filename,
      file_format: parse_file_format,
      is_full_season: is_full_season?
    )
  end

  def parse_show_name
    @show_title ||= slice_and_strip_string_with_regex(
      @description_hash[:show_name], /Show Name:([^\(\)]+)/
    )
  end

  def parse_episode_title
    @episode_title ||= slice_and_strip_string_with_regex(
      @description_hash[:show_title], /Show Title:([^\(\)]+)/
    )
  end

  def parse_file_format
    @file_format ||= slice_and_strip_string_with_regex(
      @description_hash[:show_title], /Show Title:[^\(\)]+ .*\(([^\(\)]+)\) *$/
    )
  end

  def parse_season_number
    @season_number ||= slice_and_strip_string_with_regex(
      @description_hash[:season_number], /Season: (\d+)/
    ).to_i
  end

  def parse_episode_number
    @episode_number ||= slice_and_strip_string_with_regex(
      @description_hash[:episode_number], /Episode: (.+)/
    ).to_i
  end

  def is_full_season?
    @episode_number == 0
  end

  def parse_filename
    @filename ||= slice_and_strip_string_with_regex(
      @description_hash[:filename], /Filename:(.+)/
    )
  end

  def slice_and_strip_string_with_regex(string, expression)
    string.slice(expression, 1).strip
  end

end
