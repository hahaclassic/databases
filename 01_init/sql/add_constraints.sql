ALTER TABLE artists
ADD CONSTRAINT unique_artist_name UNIQUE (name);

ALTER TABLE albums
ADD CONSTRAINT check_release_date CHECK (release_date <= CURRENT_DATE);

ALTER TABLE tracks
ADD CONSTRAINT check_track_duration CHECK (duration > 0),
ADD CONSTRAINT check_stream_count CHECK (stream_count >= 0),
ADD CONSTRAINT check_order_in_album CHECK (order_in_album >= 0),
ADD CONSTRAINT album_id FOREIGN KEY (album_id) REFERENCES albums(id),
ADD CONSTRAINT unique_album_track_order UNIQUE (album_id, order_in_album);

ALTER TABLE playlists
ADD CONSTRAINT check_rating CHECK (rating >= 0),

ALTER TABLE playlist_tracks
ADD CONSTRAINT fk_playlist_track_id FOREIGN KEY (track_id) REFERENCES tracks(id),
ADD CONSTRAINT fk_playlist_id FOREIGN KEY (playlist_id) REFERENCES playlists(id),
ALTER COLUMN track_id SET NOT NULL,
ALTER COLUMN playlist_id SET NOT NULL,
ALTER COLUMN date_added SET DEFAULT CURRENT_TIMESTAMP,
ADD CONSTRAINT unique_playlist_track_order UNIQUE (playlist_id, track_order);

ALTER TABLE user_playlists
ADD CONSTRAINT fk_user_playlist_playlist FOREIGN KEY (playlist_id) REFERENCES playlists(id),
ADD CONSTRAINT fk_user_playlist_user FOREIGN KEY (user_id) REFERENCES users(id),
ADD CONSTRAINT check_access_level CHECK (access_level >= 0),
ALTER COLUMN last_updated SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE tracks_by_artists
ADD CONSTRAINT fk_artist_track_id FOREIGN KEY (track_id) REFERENCES tracks(id),
ADD CONSTRAINT fk_artist_artist_id FOREIGN KEY (artist_id) REFERENCES artists(id),
ADD CONSTRAINT unique_track_artist UNIQUE (track_id, artist_id);

ALTER TABLE albums_by_artists
ADD CONSTRAINT fk_albums_album_id FOREIGN KEY (album_id) REFERENCES albums(id),
ADD CONSTRAINT fk_albums_artist_id FOREIGN KEY (artist_id) REFERENCES artists(id);
