
        if exists(select name from sys.tables where name='book')
        drop table book;
        

    create table book (
        id varchar(20) not null primary key,
        name nvarchar(80) not null,
        publish nvarchar(30),
        author nvarchar(15),
        price decimal(10, 3)
    );
    
/*
[('dep01_s001_01', '电磁波工程', '电子工业出版社', '顾华', Decimal('21.000')), ('dep02_s016_01', '数字信号处理', '北京科学技术出版社', '寿黎明', Decimal('34.000')), ('dep02_s017_01', '通信原理', '人民邮电出版社', '郝义勇', Decimal('52.000')), ('dep02_s018_01', '通信网理论基础', '北方交通大学出版社', '毛迈', Decimal('51.000')), ('dep02_s019_01', '现代通信技术', '北京邮电大学出版社', '李曦', Decimal('45.000')), ('dep04_b001_01', '计算机基础', '清华大学出版社', '洪涛', Decimal('16.000')), ('dep04_b001_02', '计算机应用', '电子工业出版社', '李群', Decimal('19.800')), ('dep04_p001_01', 'C语言程序设计', '清华大学出版社', '钟军', Decimal('18.800')), ('dep04_s001_01', 'SQL Server数据库开发技术', '北方交通大学出版社', '成虎', Decimal('21.500')), ('dep04_s002_01', 'JAVA语言程序设计', '东南大学出版社', '王平', Decimal('22.500')), ('dep04_s003_01', '单片机原理', '东南大学出版社', '肖红', Decimal('16.800')), ('dep04_s004_01', '软件开发技术', '南京大学出版社', '刘雨', Decimal('15.000')), ('dep04_s005_01', '网页设计', '地质出版社', '张凯芝', Decimal('12.000')), ('dep04_s006_01', '计算机网络', '机械工业出版社', '张旸', Decimal('23.500')), ('dep04_s007_01', '计算机导论', '北京邮电大学出版社', '周艳', Decimal('28.000')), ('dep04_s008_01', '计算机网络技术与实践', '人民邮电出版社', '潘晓', Decimal('38.000')), ('dep05_s009_01', '人际传播能力', '传媒大学出版社', '张范', Decimal('25.000')), ('dep05_s010_01', '思辨与创新', '中国人民大学出版社', '吴蔚', Decimal('36.000')), ('dep05_s011_01', '技术创新管理', '人民教育出版社', '郭晓勇', Decimal('28.000')), ('dep05_s012_01', '决胜移动互联网', '机械工业出版社', '常立', Decimal('33.000')), ('dep05_s013_01', '人文视野中的生态学', '中国社会科学出版社', '高同星', Decimal('37.000')), ('dep05_s014_01', '有效沟通技巧', '中信出版社', '于波', Decimal('56.000')), ('dep05_s015_01', '形势与政策', '北京大学出版社', '陈明明', Decimal('28.000'))]
*/

        if exists(select name from sys.tables where name='teacher_type')
        drop table teacher_type;
        

    create table teacher_type (
        id smallint not null,
        t_type nvarchar(15) not null,
        primary key(id, t_type)
    );
    
/*
[(1, '专职'), (2, '兼职'), (3, '外聘')]
*/

        if exists(select name from sys.tables where name='course')
        drop table course;
        

    create table course (
        id varchar(20) not null primary key,
        name nvarchar(80),
        book_id varchar(20),
        total_hour int,
        week_hour int,
        credit int
    );
    
/*
[('dep01_s001', '电磁波工程', 'dep01_s001_01', 72, 6, 6), ('dep01_s002', '网络技术与实践', 'dep01_s002_01', 68, 4, 4), ('dep02_s016', '数字信号处理', 'dep02_s016_01', 72, 6, 6), ('dep02_s017', '通信原理', 'dep02_s017_01', 48, 4, 4), ('dep02_s018', '通信网理论基础', 'dep02_s018_01', 60, 5, 5), ('dep02_s019', '现代通信技术', 'dep02_s019_01', 72, 6, 6), ('dep04_b001', '计算机基础', 'dep04_b001_01', 68, 4, 4), ('dep04_p001', 'C语言程序设计', 'dep04_p001_01', 68, 4, 4), ('dep04_s001', 'SQL Server数据库开发技术', 'dep04_s001_01', 80, 5, 5), ('dep04_s002', 'JAVA程序设计与开发', 'dep04_s002_01', 68, 4, 4), ('dep04_s003', '单片机原理', 'dep04_s003_01', 68, 4, 4), ('dep04_s004', '软件开发技术', 'dep04_s004_01', 51, 3, 3), ('dep04_s005', '网页设计', 'dep04_s005_01', 80, 5, 5), ('dep04_s006', '计算机网络', 'dep04_s006_01', 60, 3, 3), ('dep04_s007', '计算机导论', 'dep04_s007_01', 80, 4, 6), ('dep05_s009', '人际传播能力', 'dep05_s009_01', 38, 2, 2), ('dep05_s010', '思辨与创新', 'dep05_s010_01', 48, 3, 3), ('dep05_s011', '技术创新管理', 'dep05_s011_01', 60, 5, 5), ('dep05_s012', '决胜移动互联网', 'dep05_s012_01', 24, 3, 3), ('dep05_s013', '人文视野中的生态学', 'dep05_s013_01', 32, 4, 4), ('dep05_s014', '有效沟通技巧', 'dep05_s014_01', 32, 4, 4), ('dep05_s015', '形势与政策', 'dep05_s015_01', 72, 6, 6)]
*/

        if exists(select name from sys.tables where name='class')
        drop table class;
        

    create table class (
        id varchar(20) not null primary key,
        head_teacher nvarchar(15),
        address nvarchar(120),
        dept_id varchar(20)
    );
    
/*
[('g09101', '朱敬兰', '教学楼201', 'dep_03'), ('g09102', '孙兵', '教学楼202', 'dep_03'), ('g09103', '李晴', '教学楼203', 'dep_03'), ('g09401', '李强', '教学楼210', 'dep_04'), ('g09402', '姜一鸣', '教学楼211', 'dep_04'), ('g09403', '成佳洱', '教学楼212', 'dep_04'), ('g10401', '张丽', '教学楼310', 'dep_01'), ('g10402', '姚夏', '教学楼311', 'dep_01'), ('g10403', '路立', '教学楼312', 'dep_01'), ('g11401', '方舟', '教学楼410', 'dep_02'), ('g11402', '钱程', '教学楼411', 'dep_02'), ('g11403', '李微', '教学楼412', 'dep_02'), ('g12401', '程丽', '教学楼512', 'dep_05'), ('g12402', '高月', '教学楼513', 'dep_05'), ('g12403', '林琴', '教学楼514', 'dep_05'), ('g12404', '王曼', '教学楼515', 'dep_05')]
*/

        if exists(select name from sys.tables where name='class_course')
        drop table class_course;
        

    create table class_course (
        class_id varchar(20) not null,
        course_id varchar(20) not null,
        primary key(class_id, course_id)
    );
    
/*
[('g09402', 'dep04_s001'), ('g09402', 'dep04_s002'), ('g09402', 'dep04_s003'), ('g09402', 'dep04_s004'), ('g09402', 'dep04_s005'), ('g09403', 'dep04_s002'), ('g09403', 'dep04_s003'), ('g09403', 'dep04_s004'), ('g09403', 'dep04_s005'), ('g10401', 'dep01_s001'), ('g10402', 'dep01_s002'), ('g10403', 'dep01_s003'), ('g10404', 'dep01_s004'), ('g11401', 'dep04_s001'), ('g11402', 'dep04_s002'), ('g11403', 'dep04_s003'), ('g11404', 'dep04_s004'), ('g12401', 'dep01_s001'), ('g12402', 'dep01_s002'), ('g12403', 'dep01_s003'), ('g12404', 'dep01_s004')]
*/

        if exists(select name from sys.tables where name='department')
        drop table department;
        

    create table department (
        id varchar(20) not null primary key,
        name nvarchar(15) not null,
        leader nvarchar(15),
        teacher_count int,
    );
    
/*
[('dep_01', '无线电', '王敬远', 82), ('dep_02', '通信与信息工程', '康辉', 105), ('dep_03', '电子工程', '董一平', 72), ('dep_04', '计算机科学', '纪云', 85), ('dep_05', '英语', '韩春', 56)]
*/

        if exists(select name from sys.tables where name='student')
        drop table student;
        

    create table student (
        id varchar(20) not null primary key,
        name nvarchar(15),
        class_id varchar(20),
        gender nvarchar(2),
        birth datetime,
        created_at datetime default CURRENT_TIMESTAMP,
        address nvarchar(120),
    );
    
/*
[('g0140101', '徐志超', 'g01401', '男', datetime.datetime(1992, 1, 7, 0, 0), datetime.datetime(2010, 9, 1, 0, 0), '杭州市余杭路12号'), ('g0140102', '王志鹏', 'g01401', '男', datetime.datetime(1992, 10, 8, 0, 0), datetime.datetime(2010, 9, 1, 0, 0), '慈溪市中正路23号'), ('g0140103', '李昊', 'g01401', '男', datetime.datetime(1992, 5, 9, 0, 0), datetime.datetime(2010, 9, 1, 0, 0), '南昌市起义路55号'), ('g0140104', '叶梦宇', 'g01401', '女', datetime.datetime(1992, 3, 10, 0, 0), datetime.datetime(2010, 9, 1, 0, 0), '新昌市海棠路123号'), ('g0140105', '张威', 'g01401', '男', datetime.datetime(1992, 1, 11, 0, 0), datetime.datetime(2010, 9, 1, 0, 0), '诸暨市高湖路65号'), ('g0140106', '唐勇睿', 'g01401', '男', datetime.datetime(1992, 11, 12, 0, 0), datetime.datetime(2010, 9, 1, 0, 0), '北京市正义路2号'), ('g0140107', '邓皓', 'g01401', '男', datetime.datetime(1992, 7, 13, 0, 0), datetime.datetime(2010, 9, 1, 0, 0), '邯郸市望江路24号'), ('g0140201', '王一言', 'g01402', '男', datetime.datetime(1994, 8, 14, 0, 0), datetime.datetime(2010, 9, 1, 0, 0), '深圳市华侨路78号'), ('g0140204', '徐江洪', 'g01402', '男', datetime.datetime(1992, 11, 17, 0, 0), datetime.datetime(2010, 9, 1, 0, 0), '高邮市樱花路22号'), ('g0140205', '朱玺仲', 'g01402', '男', datetime.datetime(1996, 10, 20, 0, 0), datetime.datetime(2010, 9, 1, 0, 0), '扬州市望乡路156号'), ('g0240206', '刘又嘉', 'g01402', '男', datetime.datetime(1993, 12, 19, 0, 0), datetime.datetime(2012, 9, 1, 0, 0), '上海市东风路12号'), ('g0240301', '袁毓堃', 'g01403', '男', datetime.datetime(1992, 11, 20, 0, 0), datetime.datetime(2012, 9, 1, 0, 0), '上海市模范路4号'), ('g0240302', '顾天飞', 'g01403', '男', datetime.datetime(1992, 12, 21, 0, 0), datetime.datetime(2012, 9, 1, 0, 0), '南京市下沙路88号'), ('g0240303', '刘乐', 'g01403', '男', datetime.datetime(1992, 2, 22, 0, 0), datetime.datetime(2012, 9, 1, 0, 0), '常熟市后山路6号'), ('g0240304', '赵慧琳', 'g01403', '女', datetime.datetime(1995, 4, 23, 0, 0), datetime.datetime(2012, 9, 1, 0, 0), '镇江市静安路16号'), ('g0240401', '王晓庆', 'g01404', '男', datetime.datetime(1993, 9, 24, 0, 0), datetime.datetime(2012, 9, 1, 0, 0), '苏州市普陀路15号'), ('g0240402', '赵莹莹', 'g01404', '女', datetime.datetime(1993, 5, 25, 0, 0), datetime.datetime(2012, 9, 1, 0, 0), '昆明市花市路77号'), ('g0240403', '吴珊珊', 'g01404', '女', datetime.datetime(1994, 3, 26, 0, 0), datetime.datetime(2012, 9, 1, 0, 0), '广州市体育路55号'), ('g0940201', '张虹', 'g09402', '男', datetime.datetime(1991, 9, 12, 0, 0), datetime.datetime(2009, 9, 1, 0, 0), '南京玄武区美玲大道4号'), ('g0940202', '林红', 'g09402', '女', datetime.datetime(1991, 6, 16, 0, 0), datetime.datetime(2009, 9, 1, 0, 0), '扬州市五亭街41号'), ('g0940203', '曹雨', 'g09402', '男', datetime.datetime(1990, 12, 11, 0, 0), datetime.datetime(2009, 9, 1, 0, 0), '南京玄武区林荫大道4号'), ('g0940204', '芮华', 'g09402', '男', datetime.datetime(1992, 9, 9, 0, 0), datetime.datetime(2009, 9, 1, 0, 0), '江苏仪征市青年路6号'), ('g0940205', '李红[大]', 'g09402', '女', datetime.datetime(1991, 9, 2, 0, 0), datetime.datetime(2009, 9, 1, 0, 0), '江苏仪征市青年东路16号'), ('g0940206', '林海国', 'g09402', '男', datetime.datetime(1991, 4, 5, 0, 0), datetime.datetime(2009, 9, 1, 0, 0), '北京市中关村太平北路1号'), ('g0940207', '李红[小]', 'g09402', '女', datetime.datetime(1991, 5, 23, 0, 0), datetime.datetime(2009, 9, 1, 0, 0), '南京虎踞北路43号'), ('g0940210', '赵青', 'g09402', '男', datetime.datetime(1990, 1, 9, 0, 0), datetime.datetime(2009, 9, 1, 0, 0), '南京中山北路10号'), ('g0940211', '赵凯', 'g09402', '男', datetime.datetime(1992, 1, 11, 0, 0), datetime.datetime(2009, 9, 1, 0, 0), '南京中山北路10号'), ('g0940301', '左群声', 'g09403', '男', datetime.datetime(1992, 9, 8, 0, 0), datetime.datetime(2009, 9, 1, 0, 0), '贵州是遵义路68号'), ('g0940302', '许小华', 'g09403', '女', datetime.datetime(1991, 10, 15, 0, 0), datetime.datetime(2009, 9, 1, 0, 0), '上海市龙盘路97号'), ('g0940303', '张雅丽', 'g09403', '女', datetime.datetime(1990, 1, 21, 0, 0), datetime.datetime(2009, 9, 1, 0, 0), '上海市北京东路191号')]
*/

        if exists(select name from sys.tables where name='student_course')
        drop table student_course;
        

    create table student_course (
        course_id varchar(20) not null,
        student_id varchar(20) not null,
        score int,
        credit int,
        sem smallint,
        year varchar(20)
    );
    
/*
[('dep04_b001', 'g0940201', 88, 4, 2, '2009/2000'), ('dep04_b001', 'g0940202', 78, 4, 2, '2009/2000'), ('dep04_b001', 'g0940203', 88, 4, 2, '2009/2000'), ('dep04_b001', 'g0940204', 56, 0, 2, '2009/2000'), ('dep04_b001', 'g0940205', 45, 0, 2, '2009/2000'), ('dep04_b001', 'g0940206', 98, 4, 2, '2009/2000'), ('dep04_b001', 'g0940207', 87, 4, 2, '2009/2000'), ('dep04_s001', 'g0940201', 89, 5, 1, '2011/2012'), ('dep04_s001', 'g0940202', 78, 5, 1, '2011/2012'), ('dep04_s001', 'g0940203', 44, 0, 1, '2011/2012'), ('dep04_s001', 'g0940204', 65, 5, 1, '2011/2012'), ('dep04_s001', 'g0940205', 52, 0, 1, '2011/2012'), ('dep04_s001', 'g0940206', 92, 5, 1, '2011/2012'), ('dep04_s001', 'g0940207', 77, 5, 1, '2011/2012'), ('dep04_s001', 'g0940301', 78, 5, 2, '2012/2013'), ('dep04_s001', 'g0940302', 89, 5, 2, '2012/2013'), ('dep04_s002', 'g0940201', 56, 0, 1, '2011/2012'), ('dep04_s002', 'g0940202', 78, 4, 1, '2011/2012'), ('dep04_s002', 'g0940203', 98, 4, 1, '2011/2012'), ('dep04_s002', 'g0940204', 66, 4, 1, '2011/2012'), ('dep04_s002', 'g0940205', 78, 4, 1, '2011/2012'), ('dep04_s002', 'g0940206', 54, 0, 1, '2011/2012'), ('dep04_s002', 'g0940207', 87, 4, 1, '2011/2012'), ('dep04_s003', 'g0940201', 68, 4, 1, '2011/2012'), ('dep04_s003', 'g0940202', 98, 4, 1, '2011/2012'), ('dep04_s003', 'g0940203', 23, 0, 1, '2011/2012'), ('dep04_s003', 'g0940204', 86, 4, 1, '2011/2012'), ('dep04_s003', 'g0940205', 78, 4, 1, '2011/2012'), ('dep04_s003', 'g0940206', 86, 4, 1, '2011/2012'), ('dep04_s003', 'g0940207', 87, 4, 1, '2011/2012'), ('dep04_s004', 'g0940201', 47, 0, 1, '2011/2012'), ('dep04_s004', 'g0940202', 95, 3, 1, '2011/2012'), ('dep04_s004', 'g0940203', 78, 3, 1, '2011/2012'), ('dep04_s004', 'g0940204', 67, 3, 1, '2011/2012'), ('dep04_s004', 'g0940205', 76, 3, 1, '2011/2012'), ('dep04_s004', 'g0940206', 76, 3, 1, '2011/2012'), ('dep04_s004', 'g0940207', 46, 0, 1, '2011/2012'), ('dep04_s005', 'g0940201', 87, 5, 2, '2012/2013'), ('dep04_s005', 'g0940202', 91, 5, 2, '2012/2013'), ('dep04_s005', 'g0940203', 56, 0, 2, '2012/2013'), ('dep04_s005', 'g0940204', 77, 5, 2, '2012/2013'), ('dep04_s005', 'g0940205', 76, 5, 2, '2012/2013'), ('dep04_s006', 'g0940206', 88, 5, 2, '2012/2013'), ('dep04_s007', 'g0940207', 99, 5, 2, '2012/2013')]
*/

        if exists(select name from sys.tables where name='teacher')
        drop table teacher;
        

    create table teacher (
        id varchar(20) not null primary key,
        name nvarchar(20),
        gender nvarchar(2),
        birth datetime,
        dept_id varchar(20),
        prof nvarchar(5),
        phone varchar(15),
        address nvarchar(120),
        post_code varchar(10),
        cat smallint
    );
    
/*
[('dep01_001', '王敬远', '男', datetime.datetime(1956, 9, 9, 0, 0), 'dep_01', '副教授', '6211544', '南京先贤路31号', '210002', 1), ('dep01_002', '马丽', '女', datetime.datetime(1973, 7, 9, 0, 0), 'dep_01', '副教授', '65431235', '南京古北青年路35号', '210021', 1), ('dep01_003', '包维', '女', datetime.datetime(1978, 7, 10, 0, 0), 'dep_01', '副教授', '65431246', '南京鼓山新风路78号', '210028', 1), ('dep01_004', '蒋晓英', '女', datetime.datetime(1982, 7, 11, 0, 0), 'dep_01', '讲师', '5881254', '南京河西总统路79号', '215828', 2), ('dep01_005', '黄翔', '男', datetime.datetime(1988, 1, 12, 0, 0), 'dep_01', '讲师', '3728543', '南京下沙环江路2号', '214428', 3), ('dep01_025', '周春桃', '女', datetime.datetime(1989, 6, 1, 0, 0), 'dep_05', '教授', '40123456', '云南省景洪市解放路61号', '100102', 2), ('dep02_001', '康辉', '男', datetime.datetime(1949, 8, 6, 0, 0), 'dep_02', '教授', '13951606754', '南京鼓楼区长虹路3号', '210008', 2), ('dep02_002', '王皓', '男', datetime.datetime(1987, 6, 13, 0, 0), 'dep_02', '讲师', '3728643', '南京下沙环江路45号', '214428', 3), ('dep02_003', '李丽华', '女', datetime.datetime(1989, 3, 14, 0, 0), 'dep_02', '讲师', '7654987', '南京鼓楼区高邮路2号', '210012', 2), ('dep02_004', '罗伟', '男', datetime.datetime(1989, 11, 15, 0, 0), 'dep_02', '讲师', '7342122', '南京西霞区长寿路102号', '219912', 2), ('dep03_001', '董一平', '男', datetime.datetime(1968, 1, 1, 0, 0), 'dep_03', '副教授', '3728543', '南京长江路9号', '210036', 1), ('dep03_002', '潘惠', '女', datetime.datetime(1966, 4, 1, 0, 0), 'dep_01', '讲师', '5887654', '南京长江路5号', '210036', 1), ('dep04_001', '纪云', '男', datetime.datetime(1965, 9, 9, 0, 0), 'dep_04', '副教授', '6245321', '南京长江路3号', '210036', 3), ('dep04_002', '章红', '女', datetime.datetime(1970, 7, 4, 0, 0), 'dep_04', '教授', '13027816022', '南京北京西路31号', '210043', 2), ('dep04_003', '李伟', '男', datetime.datetime(1954, 6, 6, 0, 0), 'dep_04', '教授', '3728543', '南京先贤路3号', '210002', 2), ('dep04_004', '严为', '男', datetime.datetime(1978, 9, 1, 0, 0), 'dep_04', '助教', '7654987', '南京鼓楼区长虹路3号', '210002', 2), ('dep04_005', '乔红', '女', datetime.datetime(1969, 5, 31, 0, 0), 'dep_04', '讲师', '8802888', '南京太州青年路3号', '210071', 3)]
*/

        if exists(select name from sys.tables where name='teacher_course')
        drop table teacher_course;
        

    create table teacher_course (
        teacher_id varchar(20) not null,
        course_id varchar(20) not null,
        class_id varchar(20),
        sem smallint,
        year varchar(20),
        id bigint not null,
        address nvarchar(20),
        book_id varchar(20),
        primary key(teacher_id, course_id, class_id)
    );
    
/*
[('dep01_001', 'dep01_s002', 'g09402', 1, '2009/2010', 110310510, '教学楼201', 'dep01_s002_01'), ('dep01_001', 'dep01_s002', 'g10402', 1, '2011/2012', 120320520, '教学楼202', 'dep01_s002_01'), ('dep04_001', 'dep04_s001', 'g09402', 1, '2012/2013', 110320512, '教学楼601', 'dep04_s001_01'), ('dep04_001', 'dep04_s005', 'g09402', 2, '2011/2012', 130310511, '教学楼602', 'dep04_s005_01'), ('dep04_002', 'dep04_p001', 'g09402', 1, '2009/2010', 110320234, '教学楼302', 'dep04_p001_01'), ('dep04_002', 'dep04_s002', 'g09402', 1, '2012/2013', 210420321, '教学楼601', 'dep04_s002_01'), ('dep04_003', 'dep04_s003', 'g09402', 1, '2009/2010', 110410231, '教学楼212', 'dep04_s003_01'), ('dep04_003', 'dep04_s004', 'g09403', 1, '2011/2012', 120410132, '教学楼211', 'dep04_s004_01'), ('dep04_004', 'dep04_b001', 'g09403', 2, '2011/2012', 310520789, '教学楼603', 'dep04_b001_01'), ('dep04_004', 'dep04_s004', 'g09402', 1, '2011/2012', 220521897, '教学楼211', 'dep04_s004_01'), ('dep04_005', 'dep04_s001', 'g09403', 1, '2011/2012', 210512456, '教学楼212', 'dep04_s001_01')]
*/
exec sp_columns student
/*
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
| TABLE_QUALIFIER | TABLE_OWNER | TABLE_NAME | COLUMN_NAME | DATA_TYPE | TYPE_NAME | PRECISION | LENGTH | SCALE | RADIX | NULLABLE | REMARKS |  COLUMN_DEF | SQL_DATA_TYPE | SQL_DATETIME_SUB | CHAR_OCTET_LENGTH | ORDINAL_POSITION | IS_NULLABLE | SS_DATA_TYPE |
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
|  student_source |     dbo     |  student   |      id     |     12    |  varchar  |     20    |   20   |  None |  None |    0     |   None  |     None    |       12      |       None       |         20        |        1         |      NO     |      39      |
|  student_source |     dbo     |  student   |     name    |     -9    |  nvarchar |     15    |   30   |  None |  None |    1     |   None  |     None    |       -9      |       None       |         30        |        2         |     YES     |      39      |
|  student_source |     dbo     |  student   |   class_id  |     12    |  varchar  |     20    |   20   |  None |  None |    1     |   None  |     None    |       12      |       None       |         20        |        3         |     YES     |      39      |
|  student_source |     dbo     |  student   |    gender   |     -9    |  nvarchar |     2     |   4    |  None |  None |    1     |   None  |     None    |       -9      |       None       |         4         |        4         |     YES     |      39      |
|  student_source |     dbo     |  student   |    birth    |     11    |  datetime |     23    |   16   |   3   |  None |    1     |   None  |     None    |       9       |        3         |        None       |        5         |     YES     |     111      |
|  student_source |     dbo     |  student   |  created_at |     11    |  datetime |     23    |   16   |   3   |  None |    1     |   None  | (getdate()) |       9       |        3         |        None       |        6         |     YES     |     111      |
|  student_source |     dbo     |  student   |   address   |     -9    |  nvarchar |    120    |  240   |  None |  None |    1     |   None  |     None    |       -9      |       None       |        240        |        7         |     YES     |      39      |
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
*/
alter table student add comment varchar(100) not null default ''
exec sp_columns student
/*
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
| TABLE_QUALIFIER | TABLE_OWNER | TABLE_NAME | COLUMN_NAME | DATA_TYPE | TYPE_NAME | PRECISION | LENGTH | SCALE | RADIX | NULLABLE | REMARKS |  COLUMN_DEF | SQL_DATA_TYPE | SQL_DATETIME_SUB | CHAR_OCTET_LENGTH | ORDINAL_POSITION | IS_NULLABLE | SS_DATA_TYPE |
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
|  student_source |     dbo     |  student   |      id     |     12    |  varchar  |     20    |   20   |  None |  None |    0     |   None  |     None    |       12      |       None       |         20        |        1         |      NO     |      39      |
|  student_source |     dbo     |  student   |     name    |     -9    |  nvarchar |     15    |   30   |  None |  None |    1     |   None  |     None    |       -9      |       None       |         30        |        2         |     YES     |      39      |
|  student_source |     dbo     |  student   |   class_id  |     12    |  varchar  |     20    |   20   |  None |  None |    1     |   None  |     None    |       12      |       None       |         20        |        3         |     YES     |      39      |
|  student_source |     dbo     |  student   |    gender   |     -9    |  nvarchar |     2     |   4    |  None |  None |    1     |   None  |     None    |       -9      |       None       |         4         |        4         |     YES     |      39      |
|  student_source |     dbo     |  student   |    birth    |     11    |  datetime |     23    |   16   |   3   |  None |    1     |   None  |     None    |       9       |        3         |        None       |        5         |     YES     |     111      |
|  student_source |     dbo     |  student   |  created_at |     11    |  datetime |     23    |   16   |   3   |  None |    1     |   None  | (getdate()) |       9       |        3         |        None       |        6         |     YES     |     111      |
|  student_source |     dbo     |  student   |   address   |     -9    |  nvarchar |    120    |  240   |  None |  None |    1     |   None  |     None    |       -9      |       None       |        240        |        7         |     YES     |      39      |
|  student_source |     dbo     |  student   |   comment   |     12    |  varchar  |    100    |  100   |  None |  None |    0     |   None  |     ('')    |       12      |       None       |        100        |        8         |      NO     |      39      |
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
*/
alter table student alter column comment varchar(100) null
alter table student drop constraint DF__student__comment__47DBAE45
alter table student alter column comment int
exec sp_columns student
/*
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
| TABLE_QUALIFIER | TABLE_OWNER | TABLE_NAME | COLUMN_NAME | DATA_TYPE | TYPE_NAME | PRECISION | LENGTH | SCALE | RADIX | NULLABLE | REMARKS |  COLUMN_DEF | SQL_DATA_TYPE | SQL_DATETIME_SUB | CHAR_OCTET_LENGTH | ORDINAL_POSITION | IS_NULLABLE | SS_DATA_TYPE |
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
|  student_source |     dbo     |  student   |      id     |     12    |  varchar  |     20    |   20   |  None |  None |    0     |   None  |     None    |       12      |       None       |         20        |        1         |      NO     |      39      |
|  student_source |     dbo     |  student   |     name    |     -9    |  nvarchar |     15    |   30   |  None |  None |    1     |   None  |     None    |       -9      |       None       |         30        |        2         |     YES     |      39      |
|  student_source |     dbo     |  student   |   class_id  |     12    |  varchar  |     20    |   20   |  None |  None |    1     |   None  |     None    |       12      |       None       |         20        |        3         |     YES     |      39      |
|  student_source |     dbo     |  student   |    gender   |     -9    |  nvarchar |     2     |   4    |  None |  None |    1     |   None  |     None    |       -9      |       None       |         4         |        4         |     YES     |      39      |
|  student_source |     dbo     |  student   |    birth    |     11    |  datetime |     23    |   16   |   3   |  None |    1     |   None  |     None    |       9       |        3         |        None       |        5         |     YES     |     111      |
|  student_source |     dbo     |  student   |  created_at |     11    |  datetime |     23    |   16   |   3   |  None |    1     |   None  | (getdate()) |       9       |        3         |        None       |        6         |     YES     |     111      |
|  student_source |     dbo     |  student   |   address   |     -9    |  nvarchar |    120    |  240   |  None |  None |    1     |   None  |     None    |       -9      |       None       |        240        |        7         |     YES     |      39      |
|  student_source |     dbo     |  student   |   comment   |     4     |    int    |     10    |   4    |   0   |   10  |    1     |   None  |     None    |       4       |       None       |        None       |        8         |     YES     |      38      |
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
*/
alter table student drop column comment
exec sp_columns student
/*
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
| TABLE_QUALIFIER | TABLE_OWNER | TABLE_NAME | COLUMN_NAME | DATA_TYPE | TYPE_NAME | PRECISION | LENGTH | SCALE | RADIX | NULLABLE | REMARKS |  COLUMN_DEF | SQL_DATA_TYPE | SQL_DATETIME_SUB | CHAR_OCTET_LENGTH | ORDINAL_POSITION | IS_NULLABLE | SS_DATA_TYPE |
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
|  student_source |     dbo     |  student   |      id     |     12    |  varchar  |     20    |   20   |  None |  None |    0     |   None  |     None    |       12      |       None       |         20        |        1         |      NO     |      39      |
|  student_source |     dbo     |  student   |     name    |     -9    |  nvarchar |     15    |   30   |  None |  None |    1     |   None  |     None    |       -9      |       None       |         30        |        2         |     YES     |      39      |
|  student_source |     dbo     |  student   |   class_id  |     12    |  varchar  |     20    |   20   |  None |  None |    1     |   None  |     None    |       12      |       None       |         20        |        3         |     YES     |      39      |
|  student_source |     dbo     |  student   |    gender   |     -9    |  nvarchar |     2     |   4    |  None |  None |    1     |   None  |     None    |       -9      |       None       |         4         |        4         |     YES     |      39      |
|  student_source |     dbo     |  student   |    birth    |     11    |  datetime |     23    |   16   |   3   |  None |    1     |   None  |     None    |       9       |        3         |        None       |        5         |     YES     |     111      |
|  student_source |     dbo     |  student   |  created_at |     11    |  datetime |     23    |   16   |   3   |  None |    1     |   None  | (getdate()) |       9       |        3         |        None       |        6         |     YES     |     111      |
|  student_source |     dbo     |  student   |   address   |     -9    |  nvarchar |    120    |  240   |  None |  None |    1     |   None  |     None    |       -9      |       None       |        240        |        7         |     YES     |      39      |
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
*/

        if exists(select name from sys.tables where name='student')
        drop table student;
        
exec sp_columns student
/*
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+------------+---------------+------------------+-------------------+------------------+-------------+--------------+
| TABLE_QUALIFIER | TABLE_OWNER | TABLE_NAME | COLUMN_NAME | DATA_TYPE | TYPE_NAME | PRECISION | LENGTH | SCALE | RADIX | NULLABLE | REMARKS | COLUMN_DEF | SQL_DATA_TYPE | SQL_DATETIME_SUB | CHAR_OCTET_LENGTH | ORDINAL_POSITION | IS_NULLABLE | SS_DATA_TYPE |
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+------------+---------------+------------------+-------------------+------------------+-------------+--------------+
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+------------+---------------+------------------+-------------------+------------------+-------------+--------------+
*/

    create table student (
        id varchar(20) not null primary key,
        name nvarchar(15),
        class_id varchar(20),
        gender nvarchar(2),
        birth datetime,
        created_at datetime default CURRENT_TIMESTAMP,
        address nvarchar(120),
    );
    
exec sp_columns student
/*
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
| TABLE_QUALIFIER | TABLE_OWNER | TABLE_NAME | COLUMN_NAME | DATA_TYPE | TYPE_NAME | PRECISION | LENGTH | SCALE | RADIX | NULLABLE | REMARKS |  COLUMN_DEF | SQL_DATA_TYPE | SQL_DATETIME_SUB | CHAR_OCTET_LENGTH | ORDINAL_POSITION | IS_NULLABLE | SS_DATA_TYPE |
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
|  student_source |     dbo     |  student   |      id     |     12    |  varchar  |     20    |   20   |  None |  None |    0     |   None  |     None    |       12      |       None       |         20        |        1         |      NO     |      39      |
|  student_source |     dbo     |  student   |     name    |     -9    |  nvarchar |     15    |   30   |  None |  None |    1     |   None  |     None    |       -9      |       None       |         30        |        2         |     YES     |      39      |
|  student_source |     dbo     |  student   |   class_id  |     12    |  varchar  |     20    |   20   |  None |  None |    1     |   None  |     None    |       12      |       None       |         20        |        3         |     YES     |      39      |
|  student_source |     dbo     |  student   |    gender   |     -9    |  nvarchar |     2     |   4    |  None |  None |    1     |   None  |     None    |       -9      |       None       |         4         |        4         |     YES     |      39      |
|  student_source |     dbo     |  student   |    birth    |     11    |  datetime |     23    |   16   |   3   |  None |    1     |   None  |     None    |       9       |        3         |        None       |        5         |     YES     |     111      |
|  student_source |     dbo     |  student   |  created_at |     11    |  datetime |     23    |   16   |   3   |  None |    1     |   None  | (getdate()) |       9       |        3         |        None       |        6         |     YES     |     111      |
|  student_source |     dbo     |  student   |   address   |     -9    |  nvarchar |    120    |  240   |  None |  None |    1     |   None  |     None    |       -9      |       None       |        240        |        7         |     YES     |      39      |
+-----------------+-------------+------------+-------------+-----------+-----------+-----------+--------+-------+-------+----------+---------+-------------+---------------+------------------+-------------------+------------------+-------------+--------------+
*/
select name from sys.tables
/*
+----------------+
|      name      |
+----------------+
|      book      |
|  teacher_type  |
|     course     |
|     class      |
|  class_course  |
|   department   |
| student_course |
|    teacher     |
| teacher_course |
|    student     |
+----------------+
*/
