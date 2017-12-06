INSERT INTO AGENT VALUES ('admin', '123', 'Yumin Kim', 'Programmer', '010-9098-4469');
INSERT INTO AGENT VALUES ('Hojung', '123', 'Hojung', 'Fighter', '010-1231-5125');
INSERT INTO AGENT VALUES ('Hyungchan', '123', 'Hyungchan', 'Dancer', '010-9122-8383');
INSERT INTO AGENT VALUES ('Wonseok', '123', 'Wonseok', 'Begger', '010-1521-6326');
INSERT INTO AGENT VALUES ('Bugs', '123', 'Bugs', 'Singer', '010-1121-4243');

INSERT INTO CCTV VALUES ('cctv_1', 'CctvPro Z1', '1970-01-01', 'admin');
INSERT INTO CCTV VALUES ('cctv_2', 'CctvPro Z2', '2017-02-22', 'Hojung');
INSERT INTO CCTV VALUES ('cctv_3', 'CctvPro S2', '2017-02-22', 'Hyungchan');
INSERT INTO CCTV VALUES ('cctv_4', 'CctvPro S2', '2017-02-22', 'Wonseok');
INSERT INTO CCTV VALUES ('cctv_5', 'CctvPro A1', '2017-02-22', 'Bugs');

INSERT INTO AREA VALUES ('area_1', 'Seoul Yonsei 50', 'Engineering Hall 1', '2F', '205');
INSERT INTO AREA VALUES ('area_2', 'Seoul Yonsei 50', 'Engineering Hall 2', '5F', '504');
INSERT INTO AREA VALUES ('area_3', 'Seoul Yonsei 50', 'Engineering Hall 1', 'B1', '101');
INSERT INTO AREA VALUES ('area_4', 'Seoul Yonsei 50', 'Engineering Hall 3', '6F', '605');
INSERT INTO AREA VALUES ('area_5', 'Seoul Yonsei 50', 'Engineering Hall 4', '5F', '506');

INSERT INTO META_LOG_FILE VALUES ('meta_log_file_1', 'cctv_1', 'area_1', '2017-03-02 14:43:21', '2018-01-01 01:00:00');
INSERT INTO META_LOG_FILE VALUES ('meta_log_file_2', 'cctv_2', 'area_2', '2017-03-02 14:43:21', '2018-01-01 01:00:00');
INSERT INTO META_LOG_FILE VALUES ('meta_log_file_3', 'cctv_3', 'area_3', '2017-03-02 14:43:21', '2018-01-01 01:00:00');
INSERT INTO META_LOG_FILE VALUES ('meta_log_file_4', 'cctv_4', 'area_4', '2017-03-02 14:43:21', '2018-01-01 01:00:00');
INSERT INTO META_LOG_FILE VALUES ('meta_log_file_5', 'cctv_5', 'area_5', '2017-03-02 14:43:21', '2018-01-01 01:00:00');

INSERT INTO OBJECT VALUES ('object_1', 123, 22, 11, 25, 42);
INSERT INTO OBJECT VALUES ('object_2', 142, 25, 22, -12, 15);
INSERT INTO OBJECT VALUES ('object_3', 89, 17, 33, 15, -29);
INSERT INTO OBJECT VALUES ('object_4', 100, 32, 123, -5, -6);
INSERT INTO OBJECT VALUES ('object_5', 0, 24, 440011, 5, 42);

INSERT INTO ADJACENT_AREA VALUES ('adjacent_area_1', 'Baekyang Ro', 'area_1', 'area_2');
INSERT INTO ADJACENT_AREA VALUES ('adjacent_area_2', 'Hanjong Ro', 'area_2', 'area_3');
INSERT INTO ADJACENT_AREA VALUES ('adjacent_area_3', 'Gongreung Ro', 'area_1', 'area_3');
INSERT INTO ADJACENT_AREA VALUES ('adjacent_area_4', 'Sechang Ro', 'area_3', 'area_4');
INSERT INTO ADJACENT_AREA VALUES ('adjacent_area_5', 'Dongil Ro', 'area_4', 'area_5');

INSERT INTO SEQUENCE VALUES ('sequence_1');
INSERT INTO SEQUENCE VALUES ('sequence_2');
INSERT INTO SEQUENCE VALUES ('sequence_3');
INSERT INTO SEQUENCE VALUES ('sequence_4');
INSERT INTO SEQUENCE VALUES ('sequence_5');

INSERT INTO LINKS VALUES ('sequence_1', 'adjacent_area_1');
INSERT INTO LINKS VALUES ('sequence_1', 'adjacent_area_2');
INSERT INTO LINKS VALUES ('sequence_3', 'adjacent_area_3');
INSERT INTO LINKS VALUES ('sequence_4', 'adjacent_area_4');
INSERT INTO LINKS VALUES ('sequence_5', 'adjacent_area_5');

INSERT INTO META_LOG_RECORD VALUES ('2001-02-11 11:00:00', 'meta_log_file_1');
INSERT INTO META_LOG_RECORD VALUES ('2001-02-11 11:00:00', 'meta_log_file_2');
INSERT INTO META_LOG_RECORD VALUES ('2001-02-11 11:00:00', 'meta_log_file_3');
INSERT INTO META_LOG_RECORD VALUES ('2001-02-11 11:00:00', 'meta_log_file_4');
INSERT INTO META_LOG_RECORD VALUES ('2001-02-11 11:00:00', 'meta_log_file_5');

INSERT INTO CAPTURES VALUES ('2001-02-11 11:00:00', 'object_1');
INSERT INTO CAPTURES VALUES ('2001-02-11 11:00:00', 'object_2');
INSERT INTO CAPTURES VALUES ('2001-02-11 11:00:00', 'object_3');
INSERT INTO CAPTURES VALUES ('2001-02-11 11:00:00', 'object_4');
INSERT INTO CAPTURES VALUES ('2001-02-11 11:00:00', 'object_5');

INSERT INTO MONITORS VALUES ('cctv_1', 'area_1');
INSERT INTO MONITORS VALUES ('cctv_2', 'area_2');
INSERT INTO MONITORS VALUES ('cctv_3', 'area_3');
INSERT INTO MONITORS VALUES ('cctv_4', 'area_4');
INSERT INTO MONITORS VALUES ('cctv_5', 'area_5');

INSERT INTO RECORDS VALUES ('cctv_1', 'meta_log_file_1', 'area_1');
INSERT INTO RECORDS VALUES ('cctv_2', 'meta_log_file_2', 'area_2');
INSERT INTO RECORDS VALUES ('cctv_3', 'meta_log_file_3', 'area_3');
INSERT INTO RECORDS VALUES ('cctv_4', 'meta_log_file_4', 'area_4');
INSERT INTO RECORDS VALUES ('cctv_5', 'meta_log_file_5', 'area_5');

INSERT INTO STATISTICS VALUES ('meta_log_file_1', 412, 1521512, 5, 152, 1, 63);
INSERT INTO STATISTICS VALUES ('meta_log_file_2', 123, 1235325, 4, 122, 2, 63);
INSERT INTO STATISTICS VALUES ('meta_log_file_3', 242, 1623632, 2, 132, 3, 63);
INSERT INTO STATISTICS VALUES ('meta_log_file_4', 222, 1232111, 3, 112, 4, 63);
INSERT INTO STATISTICS VALUES ('meta_log_file_5', 241, 1235613, 1, 100, 5, 63);
