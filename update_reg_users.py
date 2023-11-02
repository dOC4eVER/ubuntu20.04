DROP TABLE IF EXISTS `reg_users`;
CREATE TABLE `reg_users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_registered` int(11) NOT NULL,
  `verify_key` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login` int(11) DEFAULT NULL,
  `member_group_id` int(11) NOT NULL,
  `verified` int(11) NOT NULL DEFAULT 0,
  `credits` float NOT NULL DEFAULT 0,
  `notes` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 1,
  `default_lang` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `reseller_dns` text COLLATE utf8_unicode_ci NOT NULL,
  `owner_id` int(11) NOT NULL DEFAULT 0,
  `override_packages` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `google_2fa_sec` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `dark_mode` int(1) NOT NULL DEFAULT 0,
  `sidebar` int(1) NOT NULL DEFAULT 0,
  `expanded_sidebar` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
INSERT INTO `reg_users` (`id`, `username`, `password`, `email`, `ip`, `date_registered`, `verify_key`, `last_login`, `member_group_id`, `verified`, `credits`, `notes`, `status`, `default_lang`, `reseller_dns`, `owner_id`, `override_packages`, `google_2fa_sec`, `dark_mode`, `sidebar`, `expanded_sidebar`) VALUES
(1, 'adminL', 'Padmin', 'EMAIL', NULL, 0, NULL, NULL, 1, 1, 0, NULL, 1, 'en', '', 0, NULL, '', 0, 0, 0);
ALTER TABLE `reg_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_group_id` (`member_group_id`),
  ADD KEY `username` (`username`),
  ADD KEY `password` (`password`);
  ADD KEY `email` (`email`);
ALTER TABLE `reg_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;
DROP TABLE IF EXISTS `admin_settings`;
CREATE TABLE `admin_settings` (
  `type` varchar(128) NOT NULL DEFAULT '',
  `value` varchar(4096) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `admin_settings` (`type`, `value`) VALUES
('active_mannuals', '1'),
('auto_refresh', '1'),
('cc_time', '1655207282'),
('geolite2_version', '1'),
('panel_version', '1'),
('reseller_can_isplock', '1'),
('reseller_reset_isplock', '1'),
('reseller_reset_stb', '1'),
('show_tickets', '1'),
('stats_pid', ''),
('tmdb_pid', ''),
('watch_pid', ''),
('ip_logout', '1'),
('reseller_restrictions', '1'),
('change_own_dns', '1'),
('change_own_email', '1'),
('change_own_password', '1'),
('change_own_lang', '1'),
('reseller_view_info', '1'),
('active_apps', '1'),
('reseller_mag_to_m3u', '1'),
('release_parser', 'python2');
ALTER TABLE `admin_settings`
  ADD PRIMARY KEY (`type`);
COMMIT;
ALTER TABLE settings ADD PRIMARY KEY(id);
-- update panel locale
UPDATE settings SET default_locale = 'pt_PT.utf8' WHERE settings.id = 1;
-- disable empty user agent
UPDATE settings SET disallow_empty_user_agents = '1' WHERE settings.id = 1;
UPDATE settings SET hash_lb = '1' WHERE settings.id = 1;
UPDATE admin_settings SET value = '1' WHERE admin_settings.type = 'order_streams';
UPDATE settings SET audio_restart_loss = '1' WHERE settings.id = 1;
UPDATE settings SET county_override_1st = '1' WHERE settings.id = 1;
UPDATE settings SET disallow_2nd_ip_con = '1' WHERE settings.id = 1;
UPDATE settings SET enable_isp_lock = '1' WHERE settings.id = 1;
UPDATE settings SET vod_bitrate_plus = '300' WHERE settings.id = 1;
UPDATE settings SET vod_limit_at = '10' WHERE settings.id = 1;
UPDATE settings SET block_svp = '1' WHERE settings.id = 1;
UPDATE settings SET priority_backup = '1' WHERE settings.id = 1;
UPDATE settings SET mag_security = '1' WHERE settings.id = 1;
UPDATE settings SET stb_change_pass = '1' WHERE settings.id = 1;
UPDATE settings SET stalker_lock_images = '1' WHERE settings.id = 1;
UPDATE settings SET allowed_stb_types = '["MAG200","MAG245","MAG245D","MAG250","MAG254","MAG255","MAG256","MAG257","MAG260","MAG270","MAG275","MAG322","MAG322w1","MAG322w2","MAG323","MAG324","MAG324C","MAG324w2","MAG325","MAG349","MAG350","MAG351","MAG352","MAG420","MAG420w1","MAG420w2","MAG422","MAG422A","MAG422Aw1","MAG424","MAG424w1","MAG424w2","MAG424w3","MAG424A","MAG424Aw3","MAG425","MAG425A","MAG520","MAG520W1","MAG520W2","MAG520W3","MAG520A","MAG520Aw3","MAG522","MAG522w1","MAG522w3","MAG524","MAG524W3","AuraHD","AuraHD0","AuraHD1","AuraHD2","AuraHD3","AuraHD4","AuraHD5","AuraHD6","AuraHD7","AuraHD8","AuraHD9","WR320","IM2100","IM2100w1","IM2100V","IM2100VI","IM2101","IM2101V","IM2101VI","IM2101VO","IM2101w2","IM2102","IM4410","IM4410w3","IM4411","IM4411w1","IM4412","IM4414","IM4414w1","IP_STB_HD",]' WHERE settings.id = 1;
UPDATE settings SET allowed_stb_types_rec = '1' WHERE settings.id = 1;
UPDATE settings SET allowed_stb_types_for_local_recording = '["MAG200","MAG245","MAG245D","MAG250","MAG254","MAG255","MAG256","MAG257","MAG260","MAG270","MAG275","MAG322","MAG322w1","MAG322w2","MAG323","MAG324","MAG324C","MAG324w2","MAG325","MAG349","MAG350","MAG351","MAG352","MAG420","MAG420w1","MAG420w2","MAG422","MAG422A","MAG422Aw1","MAG424","MAG424w1","MAG424w2","MAG424w3","MAG424A","MAG424Aw3","MAG425","MAG425A","MAG520","MAG520W1","MAG520W2","MAG520W3","MAG520A","MAG520Aw3","MAG522","MAG522w1","MAG522w3","MAG524","MAG524W3","AuraHD","AuraHD0","AuraHD1","AuraHD2","AuraHD3","AuraHD4","AuraHD5","AuraHD6","AuraHD7","AuraHD8","AuraHD9","WR320","IM2100","IM2100w1","IM2100V","IM2100VI","IM2101","IM2101V","IM2101VI","IM2101VO","IM2101w2","IM2102","IM4410","IM4410w3","IM4411","IM4411w1","IM4412","IM4414","IM4414w1","IP_STB_HD",]' WHERE settings.id = 1;
INSERT INTO admin_settings (type, value) VALUES ('clear_log_auto', '1');
INSERT INTO admin_settings (type, value) VALUES ('clear_log_check', '$(date +"%s")');
INSERT INTO admin_settings (type, value) VALUES ('clear_log_tables', '["flushActivity","flushActivitynow","flushPanelogs","flushLoginlogs","flushLogins","flushMagclaims","flushStlogs","flushClientlogs","flushEvents","flushMaglogs"]');
DROP TABLE IF EXISTS `reg_userlog`;
CREATE TABLE IF NOT EXISTS `reg_userlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` int(11) NOT NULL,
  `username` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `password` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `date` int(30) NOT NULL,
  `type` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=304 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
DROP TABLE IF EXISTS `devices`;
CREATE TABLE IF NOT EXISTS `devices` (
  `device_id` int(11) NOT NULL AUTO_INCREMENT,
  `device_name` varchar(255) NOT NULL,
  `device_key` varchar(255) NOT NULL,
  `device_filename` varchar(255) NOT NULL,
  `device_header` mediumtext NOT NULL,
  `device_conf` mediumtext NOT NULL,
  `device_footer` mediumtext NOT NULL,
  `default_output` int(11) NOT NULL DEFAULT 0,
  `copy_text` mediumtext DEFAULT NULL,
  PRIMARY KEY (`device_id`),
  KEY `device_key` (`device_key`),
  KEY `default_output` (`default_output`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
INSERT INTO `devices` (`device_id`, `device_name`, `device_key`, `device_filename`, `device_header`, `device_conf`, `device_footer`, `default_output`, `copy_text`) VALUES
(1, 'm3u', 'm3u', 'tv_channels_{USERNAME}.m3u', '#EXTM3U', '#EXTINF:-1,{CHANNEL_NAME}\r\n{URL}', '', 2, NULL),
(2, 'm3u With Options', 'm3u_plus', 'tv_channels_{USERNAME}_plus.m3u', '#EXTM3U', '#EXTINF:-1 tvg-id=\"{CHANNEL_ID}\" tvg-name=\"{CHANNEL_NAME}\" tvg-logo=\"{CHANNEL_ICON}\" group-title=\"{CATEGORY}\",{CHANNEL_NAME}\r\n{URL}', '', 2, NULL),
(3, 'Simple List', 'simple', 'simple_{USERNAME}.txt', '', '{URL} #Name: {CHANNEL_NAME}', '', 2, NULL),
(4, 'Enigma 2 OE 1.6', 'enigma16', 'userbouquet.favourites.tv', '#NAME {BOUQUET_NAME}', '#SERVICE 4097{SID}{URL#:}\n#DESCRIPTION {CHANNEL_NAME}', '', 2, NULL),
(5, 'DreamBox OE 2.0', 'dreambox', 'userbouquet.favourites.tv', '#NAME {BOUQUET_NAME}', '#SERVICE {ESR_ID}{SID}{URL#:}\n#DESCRIPTION {CHANNEL_NAME}', '', 2, NULL),
(6, 'GigaBlue', 'gigablue', 'userbouquet.favourites.tv', '#NAME {BOUQUET_NAME}', '#SERVICE 4097:0:1:0:0:0:0:0:0:0:{URL#:}\n#DESCRIPTION {CHANNEL_NAME}', '', 2, NULL),
(7, 'Octagon', 'octagon', 'internettv.feed', '', '[TITLE]\n{CHANNEL_NAME}\n[URL]\n{URL}\n[DESCRIPTION]\nIPTV\n[TYPE]\nLive', '', 2, NULL),
(8, 'Starlive v3/StarSat HD6060/AZclass', 'starlivev3', 'iptvlist.txt', '', '{CHANNEL_NAME},{URL}', '', 2, NULL),
(9, 'MediaStar / StarLive v4', 'mediastar', 'tvlist.txt', '', '{CHANNEL_NAME} {URL}', '', 2, NULL),
(10, 'Enigma 2 OE 1.6 Auto Script', 'enigma216_script', 'iptv.sh', 'USERNAME=\"{USERNAME}\";PASSWORD=\"{PASSWORD}\";bouquet=\"{BOUQUET_NAME}\";directory=\"/etc/enigma2/iptv.sh\";url=\"{SERVER_URL}get.php?username=$USERNAME&password=$PASSWORD&type=enigma16&output={OUTPUT_KEY}\";rm /etc/enigma2/userbouquet.\"$bouquet\"__tv_.tv;wget -O /etc/enigma2/userbouquet.\"$bouquet\"__tv_.tv $url;if ! cat /etc/enigma2/bouquets.tv | grep -v grep | grep -c $bouquet > /dev/null;then echo \"[+]Creating Folder for iptv and rehashing...\";cat /etc/enigma2/bouquets.tv | sed -n 1p > /etc/enigma2/new_bouquets.tv;echo \'#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET \"userbouquet.\'$bouquet\'__tv_.tv\" ORDER BY bouquet\' >> /etc/enigma2/new_bouquets.tv; cat /etc/enigma2/bouquets.tv | sed -n \'2,$p\' >> /etc/enigma2/new_bouquets.tv;rm /etc/enigma2/bouquets.tv;mv /etc/enigma2/new_bouquets.tv /etc/enigma2/bouquets.tv;fi;rm /usr/bin/enigma2_pre_start.sh;echo \"writing to the file.. NO NEED FOR REBOOT\";echo \"/bin/sh \"$directory\" > /dev/null 2>&1 &\" > /usr/bin/enigma2_pre_start.sh;chmod 777 /usr/bin/enigma2_pre_start.sh;wget -qO - \"http://127.0.0.1/web/servicelistreload?mode=2\";wget -qO - \"http://127.0.0.1/web/servicelistreload?mode=2\";', '', '', 2, 'wget -O /etc/enigma2/iptv.sh {DEVICE_LINK} && chmod 777 /etc/enigma2/iptv.sh && /etc/enigma2/iptv.sh'),
(11, 'Enigma 2 OE 2.0 Auto Script', 'enigma22_script', 'iptv.sh', 'USERNAME=\"{USERNAME}\";PASSWORD=\"{PASSWORD}\";bouquet=\"{BOUQUET_NAME}\";directory=\"/etc/enigma2/iptv.sh\";url=\"{SERVER_URL}get.php?username=$USERNAME&password=$PASSWORD&type=dreambox&output={OUTPUT_KEY}\";rm /etc/enigma2/userbouquet.\"$bouquet\"__tv_.tv;wget -O /etc/enigma2/userbouquet.\"$bouquet\"__tv_.tv $url;if ! cat /etc/enigma2/bouquets.tv | grep -v grep | grep -c $bouquet > /dev/null;then echo \"[+]Creating Folder for iptv and rehashing...\";cat /etc/enigma2/bouquets.tv | sed -n 1p > /etc/enigma2/new_bouquets.tv;echo \'#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET \"userbouquet.\'$bouquet\'__tv_.tv\" ORDER BY bouquet\' >> /etc/enigma2/new_bouquets.tv; cat /etc/enigma2/bouquets.tv | sed -n \'2,$p\' >> /etc/enigma2/new_bouquets.tv;rm /etc/enigma2/bouquets.tv;mv /etc/enigma2/new_bouquets.tv /etc/enigma2/bouquets.tv;fi;rm /usr/bin/enigma2_pre_start.sh;echo \"writing to the file.. NO NEED FOR REBOOT\";echo \"/bin/sh \"$directory\" > /dev/null 2>&1 &\" > /usr/bin/enigma2_pre_start.sh;chmod 777 /usr/bin/enigma2_pre_start.sh;wget -qO - \"http://127.0.0.1/web/servicelistreload?mode=2\";wget -qO - \"http://127.0.0.1/web/servicelistreload?mode=2\";', '', '', 2, 'wget -O /etc/enigma2/iptv.sh {DEVICE_LINK} && chmod 777 /etc/enigma2/iptv.sh && /etc/enigma2/iptv.sh'),
(12, 'StarLive v5', 'starlivev5', 'channel.jason', '', '', '', 2, NULL),
(13, 'WebTV List', 'webtvlist', 'webtv list.txt', '', 'Channel name:{CHANNEL_NAME}\r\nURL:{URL}', '[Webtv channel END]', 2, NULL),
(14, 'Octagon Auto Script', 'octagon_script', 'iptv', 'USERNAME=\"{USERNAME}\";PASSWORD=\"{PASSWORD}\";url=\"{SERVER_URL}get.php?username=$USERNAME&password=$PASSWORD&type=octagon&output={OUTPUT_KEY}\";rm /var/freetvplus/internettv.feed;wget -O /var/freetvplus/internettv.feed1 $url;chmod 777 /var/freetvplus/internettv.feed1;awk -v BINMODE=3 -v RS=\'(\\r\\n|\\n)\' -v ORS=\'\\n\' \'{ print }\' /var/freetvplus/internettv.feed1 > /var/freetvplus/internettv.feed;rm /var/freetvplus/internettv.feed1', '', '', 2, 'wget -qO /var/bin/iptv {DEVICE_LINK}'),
(15, 'Ariva', 'ariva', 'ariva_{USERNAME}.txt', '', '{CHANNEL_NAME},{URL}', '', 2, NULL),
(16, 'Spark', 'spark', 'webtv_usr.xml', '<?xml version=\"1.0\"?>\r\n<webtvs>', '<webtv title=\"{CHANNEL_NAME}\" urlkey=\"0\" url=\"{URL}\" description=\"\" iconsrc=\"{CHANNEL_ICON}\" iconsrc_b=\"\" group=\"0\" type=\"0\" />', '</webtvs>', 2, NULL),
(17, 'Geant/Starsat/Tiger/Qmax/Hyper/Royal', 'gst', '{USERNAME}_list.txt', '', 'I: {URL} {CHANNEL_NAME}', '', 2, NULL),
(18, 'Fortec999/Prifix9400/Starport', 'fps', 'Royal.cfg', '', 'IPTV: { {CHANNEL_NAME} } { {URL} }', '', 2, NULL),
(19, 'Revolution 60/60 | Sunplus', 'revosun', 'network_iptv.cfg', '', 'IPTV: { {CHANNEL_NAME} } { {URL} }', '', 2, NULL),
(20, 'Zorro', 'zorro', 'iptv.cfg', '<NETDBS_TXT_VER_1>', 'IPTV: { {CHANNEL_NAME} } { {URL} } -HIDE_URL', '', 2, NULL),
(21, 'get', 'get', 'get.sh', '#!/bin/bash', 'mkdir -p \"$HOME/tmp\"\r\ncd \"$HOME/tmp\"\r\nwget -O \"$HOME/tmp/{CHANNEL_NAME}.mp4\" {URL}\r\ncd \"$HOME\"\r\nrm -rf \"$HOME/tmp/\"', '', 3, NULL);
COMMIT;
TRUNCATE user_activity;
TRUNCATE user_activity_now;
TRUNCATE panel_logs;
TRUNCATE login_logs;
TRUNCATE login_users;
TRUNCATE mag_claims;
TRUNCATE stream_logs;
TRUNCATE client_logs;
TRUNCATE mag_logs;
TRUNCATE mag_events;
