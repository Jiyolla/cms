INSERT INTO AGENT VALUES ('admin', '123', 'Yumin Kim', 'Programmer', '010-9098-4469')
INSERT INTO AGENT VALUES ('Hojung', '123', 'Hojung', 'Fighter', '010-1231-5125')
INSERT INTO AGENT VALUES ('Hyungchan', '123', 'Hyungchan', 'Dancer', '010-9122-8383')
INSERT INTO AGENT VALUES ('Wonseok', '123', 'Wonseok', 'Begger', '010-1521-6326')
INSERT INTO AGENT VALUES ('Bugs', '123', 'Bugs', 'Singer', '010-1121-4243')



INSERT INTO CCTV VALUES ('cctv_1', 'CctvPro Z1', date???, 'admin')
INSERT INTO CCTV VALUES ('cctv_2', 'CctvPro Z2', date???, 'Hojung')
INSERT INTO CCTV VALUES ('cctv_3', 'CctvPro S2', date???, 'Hyungchan')
INSERT INTO CCTV VALUES ('cctv_4', 'CctvPro S2', date???, 'Wonseok')
INSERT INTO CCTV VALUES ('cctv_5', 'CctvPro A1', date???, 'Bugs')




INSERT INTO AREA VALUES ('area_1', 'Seoul Yonsei 50', 'Engineering Hall 1', 2, '205')
INSERT INTO AREA VALUES ('area_2', 'Seoul Yonsei 50', 'Engineering Hall 2', 5, '504')
INSERT INTO AREA VALUES ('area_3', 'Seoul Yonsei 50', 'Engineering Hall 1', 1, '101')
INSERT INTO AREA VALUES ('area_4', 'Seoul Yonsei 50', 'Engineering Hall 3', 6, '605')
INSERT INTO AREA VALUES ('area_5', 'Seoul Yonsei 50', 'Engineering Hall 4', 5, '506')


INSERT INTO META_LOG_FILE VALUES ('meta_log_file_1', 'cctv_1', 'area_1', timestamp???)
INSERT INTO META_LOG_FILE VALUES ('meta_log_file_2', 'cctv_2', 'area_2', timestamp???)
INSERT INTO META_LOG_FILE VALUES ('meta_log_file_3', 'cctv_3', 'area_3', timestamp???)
INSERT INTO META_LOG_FILE VALUES ('meta_log_file_4', 'cctv_4', 'area_4', timestamp???)
INSERT INTO META_LOG_FILE VALUES ('meta_log_file_5', 'cctv_5', 'area_5', timestamp???)


INSERT INTO OBJECT VALUES ('object_1', 123, 22, 'yellow', 25, 42)
INSERT INTO OBJECT VALUES ('object_2', 142, 25, 'red', -12, 15)
INSERT INTO OBJECT VALUES ('object_3', 89, 17, 'green', 15, -29)
INSERT INTO OBJECT VALUES ('object_4', 100, 32, 'blue', -5, -6)
INSERT INTO OBJECT VALUES ('object_5', 121, 24, 'purple', 5, 42)



INSERT INTO ADJACENT_AREA VALUES ('adjacnet_area_1', 'Baekyang Ro', 'area_1', 'area_2')
INSERT INTO ADJACENT_AREA VALUES ('adjacnet_area_2', 'Hanjong Ro', 'area_2', 'area_3')
INSERT INTO ADJACENT_AREA VALUES ('adjacnet_area_3', 'Gongreung Ro', 'area_1', 'area_3')
INSERT INTO ADJACENT_AREA VALUES ('adjacnet_area_4', 'Sechang Ro', 'area_3', 'area_4')
INSERT INTO ADJACENT_AREA VALUES ('adjacnet_area_5', 'Dongil Ro', 'area_4', 'area_5')

INSERT INTO SEQUENCE VALUES ('seqeunce_1')
INSERT INTO SEQUENCE VALUES ('seqeunce_2')
INSERT INTO SEQUENCE VALUES ('seqeunce_3')
INSERT INTO SEQUENCE VALUES ('seqeunce_4')
INSERT INTO SEQUENCE VALUES ('seqeunce_5')

INSERT INTO LINKS VALUES ('sequence_1', 'adjacent_area_1')
INSERT INTO LINKS VALUES ('sequence_2', 'adjacent_area_2')
INSERT INTO LINKS VALUES ('sequence_3', 'adjacent_area_3')
INSERT INTO LINKS VALUES ('sequence_4', 'adjacent_area_4')
INSERT INTO LINKS VALUES ('sequence_5', 'adjacent_area_6')

INSERT INTO META_LOG_RECORD VALUES (timestamp???, 'meta_log_file_1')
INSERT INTO META_LOG_RECORD VALUES (timestamp???, 'meta_log_file_2')
INSERT INTO META_LOG_RECORD VALUES (timestamp???, 'meta_log_file_3')
INSERT INTO META_LOG_RECORD VALUES (timestamp???, 'meta_log_file_4')
INSERT INTO META_LOG_RECORD VALUES (timestamp???, 'meta_log_file_5')

INSERT INTO CAPTURES VALUES (timestamp???, 'object_1')
INSERT INTO CAPTURES VALUES (timestamp???, 'object_2')
INSERT INTO CAPTURES VALUES (timestamp???, 'object_3')
INSERT INTO CAPTURES VALUES (timestamp???, 'object_4')
INSERT INTO CAPTURES VALUES (timedatetime???bject_5')

INSERT INTO MONITORS VALUES ('cctv_1', 'area_1')
INSERT INTO MONITORS VALUES ('cctv_2', 'area_2')
INSERT INTO MONITORS VALUES ('cctv_3', 'area_3')
INSERT INTO MONITORS VALUES ('cctv_4', 'area_4')
INSERT INTO MONITORS VALUES ('cctv_5', 'area_5')

INSERT INTO RECORDS VALUES ('cctv_1', 'meta_log_file_1', 'area_1')
INSERT INTO RECORDS VALUES ('cctv_2', 'meta_log_file_2', 'area_2')
INSERT INTO RECORDS VALUES ('cctv_3', 'meta_log_file_3', 'area_3')
INSERT INTO RECORDS VALUES ('cctv_4', 'meta_log_file_4', 'area_4')
INSERT INTO RECORDS VALUES ('cctv_5', 'meta_log_file_5', 'area_5')

INSERT INTO STATISTICS VALUES ('meta_log_file_1', 412, 1521512, 5, 152, 'green', 63)
INSERT INTO STATISTICS VALUES ('meta_log_file_2', 123, 1235325, 4, 122, 'blue', 63)
INSERT INTO STATISTICS VALUES ('meta_log_file_3', 242, 1623632, 2, 132, 'white', 63)
INSERT INTO STATISTICS VALUES ('meta_log_file_4', 222, 1232111, 3, 112, 'black', 63)
INSERT INTO STATISTICS VALUES ('meta_log_file_5', 241, 1235613, 1, 100, 'gray', 63)
