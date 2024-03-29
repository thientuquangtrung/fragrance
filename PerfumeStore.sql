raiserror('Creating PerfumeStore database....',0,1)
SET NOCOUNT ON
GO

USE [master]
GO

DROP DATABASE IF EXISTS [PerfumeStore]
GO

CREATE DATABASE [PerfumeStore]
GO

USE [PerfumeStore]
GO

CREATE TABLE [dbo].[Account](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[username] [nvarchar](100) NOT NULL,
	[address] [nvarchar](500) NOT NULL,
	[phone] [varchar](12) NOT NULL,
	[email] [varchar](30) NOT NULL,
	-- Default
	[password] [char](64) NOT NULL default('6B86B273FF34FCE19D6B804EFF5A3F5747ADA4EAA22F1D49C01E52DDB7875B4B'),
	[enabled] [bit] NOT NULL default(1),
	[role] [varchar](255) NOT NULL DEFAULT ('ROLE_CUSTOMER')
)
GO

CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [NVARCHAR](max) NOT NULL
)
GO

CREATE TABLE [dbo].[Product](
	[id] [INT] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[name] [NVARCHAR](100) NOT NULL,
	[description] [NVARCHAR](max) NOT NULL,
	[price] [FLOAT] NOT NULL,
	[discount] [FLOAT] NOT NULL,
	[categoryId] [INT] REFERENCES Category(id) NOT NULL,
	[enabled] [bit] NOT NULL default(1)
)
GO

CREATE TABLE [dbo].[Customer](
	[id] [int] PRIMARY KEY references [Account](id) NOT NULL,
	[category] varchar(50) NOT NULL CHECK([category] IN ('Diamond','Gold','Silver','Copper')),
	[deliveryAddress] [nvarchar](500) NOT NULL
)
GO

CREATE TABLE [dbo].[Employee](
	[id] [int] PRIMARY KEY references [Account](id) NOT NULL,
	[salary] [money] NOT NULL,
	[departmentId] [int] NOT NULL
)
GO

CREATE TABLE [dbo].[OrderHeader](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[date] [datetime] NOT NULL,
	[status] [varchar](30) NOT NULL default('Pending'),
	[customerId] [int] references Customer(id) NOT NULL,
	[employeeId] [int] references Employee(id) NULL,
	[note] [nvarchar](max) NULL
)
GO

CREATE TABLE [dbo].[OrderDetail](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[orderHeaderId] [int] references OrderHeader(id) NOT NULL,
	[productId] [int] references Product(id) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [float] NOT NULL,
	[discount] [float] NOT NULL
)
GO

-- DROP DATABASE PerfumeStore

-- Insert Value Category
SET IDENTITY_INSERT [dbo].[Category] ON

-- Example INSERT [dbo].[Category] ([id], [name]) VALUES (1,'Louis Vuitton')
INSERT [dbo].[Category] ([id], [name], [description]) VALUES (1, 'CHANEL', N'Được biết đến là một trong những thương hiệu đi đầu về các dòng nước hoa, Chanel đã thể hiện sự sang trọng, tinh tế và đẳng cấp trong từng sản phẩm của mình. Để tạo nên những thành công ấy là cả một quá trình hình thành và phát triển ít ai biết nhằm mang hương thơm ấy đến với người sử dụng. Hãy cùng P~Sephora khám phá sự hình thành của dòng nước hoa Chanel đang làm mưa làm gió trên thị trường hiện nay nhé.')
INSERT [dbo].[Category] ([id], [name], [description]) VALUES (2, 'GUCCI', N'Gucci là một trong những thương hiệu nước hoa cao cấp hàng đầu thế giới, dòng sản phẩm này được sinh ra từ một nhà thời trang cao cấp bậc nhất nước Ý và được tôn sùng trên khắp thế giới, Gucci Fragrance sở hữu những sắc hương gợi cảm, lãng mạn và đầy kiêu hãnh của tinh thần Gucci. Thừa hưởng những đặc tính đổi mới và sáng tạo dựa trên nguồn cảm hứng truyền thống. Gắn liền với thẩm mỹ thời trang cao cấp của Ý, Gucci Fragrance cũng đã cho ra đời những hương thơm tuyệt diệu dành cho cả nam và nữ, với các tầng hương hòa quyện: ngọt ngào, mê đắm và đầy khát vọng.')
INSERT [dbo].[Category] ([id], [name], [description]) VALUES (3, 'VALENTINO', N'Valentino là một dòng nước hoa cao cấp được thành lập bởi nhà thiết kế tài năng người Ý nổi tiếng Valentino Garavani. Với tư duy cầu tiến, Valentino đã sử dụng ý tưởng sáng tạo vô tận, tài năng và tâm huyết của mình để tạo ra bộ sưu tập nước hoa Valentino gây ấn tượng sâu sắc với mọi người. Từ hương thơm tuyệt vời đến thiết kế chai độc đáo, dần dần nước hoa Valentino đã trở thành hình ảnh thu nhỏ của sự cân bằng hoàn hảo giữa niềm đam mê hiện đại, sự tinh tế bất biến và sự lãng mạn không thể cưỡng lại. Hãy cùng P~Sephora điểm qua những dòng nước hoa Valentino được yêu thích nhất nhé!')
INSERT [dbo].[Category] ([id], [name], [description]) VALUES (4, N'LANCÔME', N'Lancôme được biết đến là một thương hiệu mỹ phẩm cao cấp hàng đầu thế giới. Tuy nhiên, để có được thành công như hiện tại và làm nên tên tuổi của Lancôme bấy giờ lại là nước hoa. Ngay từ khi cho ra mắt sản phẩm nước hoa đầu tiên, Lancôme đã chinh phục người tiêu dùng bởi mùi hương của sự lịch lãm và truyền cảm cho tất cả mọi người, đã thu về không ít sự yêu thích của những tín đồ nước hoa. Để hiểu rõ hơn về thương hiệu này cũng như sản phẩm nước hoa lôi cuốn nơi đây thì hãy cùng P~Sephora tìm hiểu qua những dòng nước hoa nhé!')
SET IDENTITY_INSERT [dbo].[Category] OFF

-- Insert Value Product
SET IDENTITY_INSERT [dbo].[Product] ON

-- Example INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (1, N'Name', N'Description', 204.99, 0.1, 1)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (1, N'Nước Hoa Nữ Chanel Coco Mademoiselle Intense Eau De Parfum 100ML', N'Nước hoa Chanel Coco Mademoiselle Intense EDP 100ml là chai nước hoa nữ tính, thanh lịch nhưng không kém phần sang trọng đến từ thương hiệu Chanel nổi tiếng của Pháp. Chanel Coco Mademoiselle Intense Eau De Parfum được lấy cảm hứng từ những người phụ nữ thích tự do, tự tin và táo bạo trong cách thể hiện cảm xúc, nhưng vẫn luôn toát lên sự quyến rũ và hấp dẫn đối phương một cách khó đoán. Mở đầu của mùi hương này là những nốt hương cam, chanh tươi sáng và sắc xảo, sau đó được tiếp nối bởi những nốt hương ngọt ngào và đằm thắm từ hoa nhài, hoa hồng và hương thơm hoa quả. Tầng hương này khá dịu dàng và mềm mại, nữ tính, tất cả như để chuẩn bị cho màn trình diễn xuất sắc nhất của lớp hương cuối cùng – cũng là tầng hương cô đọng nhiều tinh hoa nhất. Lớp hương cuối hoà quyện với những nốt hương Phương Đông ấm áp, gợi cảm và nồng nàn từ hoắc hương, đậu tonka, vani, xạ hương và nhựa thơm. Đây là lớp hương đầy đặn, dày và dễ để lại thương nhớ nhất của phiên bản Intense.', 3750000, 0.11, 1)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (2, N'Nước Hoa Nữ Chanel N°5 Eau De Parfum 100ML', N'N°5 - mùi hương của người phụ nữ. Đóa hoa rực rỡ và ngát hương hòa quyện cùng nốt aldehyde, gói gọn trong lọ thủy tinh có thiết kế tối giản mang tính biểu tượng. Một mùi hương huyền thoại và bất tận. Eau De Parfum lấy cảm hứng từ hương hoa kết hợp với aldehyde điển hình. Hương hoa là sự hoà quyện hài hoà và tinh tế giữa hoa hồng, hoa nhài và hương cam quýt. Thành phần aldehyde mang đến sự độc đáo, cùng những nốt hương vanilla cho mùi hương thêm nồng nàn, quyến rũ.', 3590000, 0.2, 1)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (3, N'Nước Hoa Nữ Gucci Flora Gorgeous Jasmin Eau De Parfum 100ML', N'Nước Hoa Nữ Gucci Flora Gorgeous Jasmin Eau De Parfum 100ml là một trong những mùi hương đình đám và luôn cháy hàng của thương hiệu nổi tiếng Gucci. Gucci Flora Gorgeous Jasmin Eau De Parfum được mệnh danh là đóa dành dành trong khu vườn mùa xuân, nốt hương gợi cảm của loài hoa mang đến sự ngọt ngào và thanh khiết. Gucci Flora Gorgeous Jasmin Eau De Parfum gợi lên như một cô nàng mang những nét hương hoa dịu nhẹ bao trùm toàn bộ các tầng hương. Bùng nổ với hương hoa nhài Tây Ban Nha mang dáng vẻ thanh lịch, quý phái dành cho những quý cô sành điệu. Bên cạnh đó, hương Cam Ý và Cam bergamot mang lại cảm giác vui tươi, tràn đầy sức sống tôn nên vẻ đẹp của những cô nàng thời đại mới với vẻ đẹp dịu dàng, duyên dáng.', 2650000, 0.4, 2)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (4, N'Nước Hoa Nữ Valentino Donna Born In Roma Eau De Parfum 100ML', N'Nước Hoa Nữ Valentino Donna Born In Roma Eau De Parfum 100ml là dòng nước hoa cao cấp  đến từ thương hiệu Valentino nổi tiếng tại Ý. Thông qua trải nghiệm nước hoa chắc chắn bạn sẽ tìm thấy mảnh ghép hoàn hảo của phong cách nhẹ nhàng, nữ tính, hiện đại và thanh lịch. Valentino Donna Born In Roma Eau De Parfum 100ml sở hữu thiết kế với đinh tán Valentino mang tính biểu tượng ở bên ngoài, chai nước hoa luxe nổi bật so với phần còn lại. Bên ngoài được đính đá thô, một lời ca ngợi về nhà thời trang sắc sảo và kiến trúc La Mã, tương phản với nước hoa nữ tinh tế, nữ tính bên trong. Hương thơm được mở đầu bằng cái chạm sắc nét của nho đen, tiêu hồng và cam Bergamot. Dư vị ngọt ngào ấy dần được thay thế bởi nét thuần khiết và nữ tính của bộ ba hương hoa nhài. Sự lôi cuốn của hương thơm được mở đầu tự nhiên và rời đi trong cảm giác lưu luyến. Vani Bourbon, gỗ Cashmeran, gỗ Guaiac tạo nên sự phong phú mà ấm áp của nước hoa Valentino Donna Born In Roma Eau De Parfum. Cũng là tầng hương kết thúc thật sắc sảo nơi thành phố Roma lộng lẫy.', 4180000, 0.2, 3)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (5, N'Nước Hoa Nam Valentino Uomo Intense Eau De Parfum 100ML', N'Nước Hoa Nam Valentino Uomo Intense EDP 100ml là dòng nước hoa nam cao cấp mang đậm bản sắc phong cách của những chàng trai nước Ý đầy lãng tử và phong trần. Valentino Uomo Intense EDP kế thừa trọn vẹn nét thanh lịch đậm tinh thần nước hoa Valentino nhưng không kém phần sành điệu. Nước Hoa Nam Valentino Uomo Intense EDP được lấy cảm hứng từ những người đàn ông trẻ tuổi được 	kế thừa gia nghiệp giàu có từ gia đình của 	mình tại đất nước Italia, được miêu tả với cốt cách của một người thượng lưu, sang trọng, lịch lãm và cuốn hút. Nước Hoa Nam Valentino Uomo Intense EDP là một mùi hương của chàng trai thuộc giới thượng lưu lịch sự sang trọng từ mọi góc nhìn không thể cưỡng lại, đầy tinh tế, thanh lịch, thể hiện rõ phong thái của một người đàn ông trẻ trung, tự tin, sành điệu. Mang hương thơm da thuộc - Leather đặc trưng, hương đầu được mở ra với sự tươi mới từ quả quýt hồng và chứa dầu cây từ tô. Nối tiếp là tông hương giữa có vị ngọt ngào tự nhiên từ đậu tonka và sự sang trọng của hoa diên vĩ. Lớp hương cuối lưu lại trên da là sự hòa quyện giữa hương da thuộc và vani.', 3000000, 0.2, 3)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (6, N'Nước Hoa Nữ Chanel Allure Eau De Parfum 100ML', N'ALLURE là định nghĩa của sự thanh lịch. Lôi cuốn và tự nhiên. Hương nước hoa tươi mát với sáu khía 	cạnh khác biệt, tạo nên sức hút riêng cho mỗi người phụ nữ. Mỗi người phụ nữ đều có sức quyến rũ của riêng 	mình. Mùi hương của hoa cỏ tươi mát, của sự tinh tế và thanh lịch. Sáu khía cạnh mùi hương tiếp cận mỗi người phụ nữ theo những cách khác nhau. Một sự hòa trộn của những nốt hương tươi sáng của quýt, sự mềm mại của hoa hồng và sự gợi cảm của vanilla. Tất cả dường như đều được khuếch đại trong mùi hương này.', 3200000, 0.1, 1)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (7, N'Nước Hoa Nữ Gucci Bloom Ambrosia Di Fiori Eau De Parfum 100ML', N'Nước Hoa Gucci Bloom Ambrosia Di Fiori Intense 100ml là chai nước hoa nữ sang trọng từ thương hiệu Gucci nổi tiếng của Ý. Gucci Bloom Ambrosia Di Fiori EDP Intense đem đến cho phái đẹp một hương thơm hoa thật tinh tế và tràn đầy ngọt ngào. Nước Hoa Gucci Bloom Ambrosia Di Fiori EDP Intense 100ml& cải thiện hơn so với bản gốc Gucci Bloom Eau de Parfum với 3 sự kết hợp của hoa nhài, hoa huệ &amp; hoa dạ lý hương. Lần này bản Gucci 2019 “Ambrosia Di Fiori” còn được tăng cường thêm bởi 2 thành phần mới làm lan toả hương thơm sang trọng – nữ tính. Đó chính là hoa diên vỹ và hoa hồng. Hương giữa được tiếp nối với hương hoa huệ, nhưng tinh khôi và tinh khiết bởi những cánh hoa kim ngân bài trí lộng lẫy ở khắp sảnh điện. Sự huyền bí của Orris kết hợp cùng sự quyến rũ, ngọt ngào mộng mị của hoa hồng Đan Mạch biến bữa tiệc trở nên sang trọng, tinh tế và gợi cảm đến bất ngờ.', 2950000, 0.2, 2)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (8, N'Nước Hoa Nam Chanel Allure Homme Sport Eau Extreme 100ML', N'Nước Hoa Chanel Allure Homme Sport Eau Extreme EDP là chai nước hoa dành cho nam giới đến từ thương hiệu Chanel nổi tiếng của Pháp. Chanel Allure Homme Sport Eau Extreme sở hữu một mùi hương mạnh mẽ, nam tính, thích hợp với những người đàn ông hiện đại, mang lại sự tự tin để đương đầu với mọi thử thách.
Chai nước hoa Chanel với hương thơm nước hoa từ tổ hợp những hương sắc xạ hương, gia vị chua cay, hương thơm tươi mát và hương gỗ mạnh mẽ nam tính, kết hợp với hương quýt, bạc hà, trắc bá và cây xô thơm từ xứ Sicily mang lại cảm giác thảo mộc tươi tắn mát lạnh.
Chanel Allure Homme Sport Eau Extreme có vị chua cay của nước hoa xuất phát từ hạt tiêu và hương gỗ bao gồm cây bách hương và đàn hương đến từ New Caledonia. Tất cả các mùi hương của mùi hương Chanel này được hình thành và làm dịu đi nhờ vào hương xạ hương gợi cảm và đậu tonka ấm áp.
Tổ hợp nước hoa Chanel này thể hiện được sự phối hợp của nét tươi mát, chua cay, gợi cảm, sắc bén và mạnh mẽ, sự lựa chọn hoàn hảo cho quý ông. Hương thơm đầy nam tính đa dạng, có thể sử dụng tốt cả ngày lẫn đêm và vào tất cả các mùa trong năm, đặc biệt là mùa xuân.', 3180000, 0.4, 1)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (9, N'Nước Hoa Nam Valentino Uomo Born In Roma Eau 	de Toilette 50ML', N'Nước Hoa Nam Valentino Uomo Born In Roma EDT 50ml là chai nước hoa nam cao cấp mang phong cách mạnh mẽ, trẻ trung và hiện đại. Valentino Uomo Born In Roma mang mùi hương nồng nàn theo phong cách cổ điển, hướng tới những người đàn ông theo đuổi phong cách cổ điển và giản dị.
Giá trị cốt lõi của thương hiệu thời trang Valentino một lần nữa được tái hiện xuất sắc qua thiết kế của Valentino Uomo Born In Roma 50ml. Nước hoa được lấy cảm hứng từ kiến trúc La Mã. Bao phủ toàn bộ thân chai là họa tiết đinh tán mang tính biểu tượng cùng vóc dáng hình quả chuông quen thuộc của nước hoa Valentino. Sự độc đáo của thiết kế còn nằm ở chi tiết đinh tán xây quanh cổ chai. Tông màu đen tuyền ôm trọn vẻ ngoài của thiết kế. Logo “Valentino” in nổi giữa thân với sắc hồng tươi mới tạo nên ấn tượng tương phản tuyệt đẹp. Nhìn tổng thể nước hoa Valentino Uomo Born In Roma là nét thiết kế tinh xảo, càng ngắm càng mê.
Hương nước hoa Valentino Uomo Born In Roma là sự kết hợp mới lạ của các hương liệu. Nổi bật bên trong đó là hương gừng, lá Violet, muối khoáng và cỏ Vetiver. Các nốt hương đi từ nhẹ nhàng, ngọt ngào đến 	tinh tế và mãnh mẽ. Cảm giác rất nam tính nhưng lại ôn hòa dễ chịu tạo ấn tượng tích cực nơi đối phương. Không phải hoàn hảo nhất nhưng là đặc biệt nhất, Valentino Uomo Born In Roma 50ml chính là phụ kiện tạo nên phong độ ổn định của đấng mày râu. Hiện đại, sang trọng, quyến rũ và tràn đầy sinh lực.', 2000000, 0.5, 3)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (10, N'Nước Hoa Nữ Lancôme Tresor Midnight Rose Eau De Parfum 75ML', N'Nước hoa Lancôme Tresor Midnight Rose  là dòng nước hoa nữ thời thượng với xuất xứ từ Pháp, được coi là đứa con cưng và hoàn hảo của hãng nước hoa Lancôme nổi tiếng. Lancôme Tresor mang mùi hương nồng nàn đầy vẻ bí ẩn, nhưng vẫn hé lộ những nét ngọt ngào và quyến rũ bên trong cho các bạn nữ.
Mẫu chai nước hoa Lancôme lôi cuốn phái đẹp bởi gam màu chuyển từ hồng phấn nhẹ nhàng sang tím 	nhạt quyến rũ lấy cảm hứng từ hình ảnh bầu trời đêm đẹp lãng mạn. Bông hồng satin tím ở cổ chai càng tôn vinh vẻ đẹp tinh xảo, nổi bật và quý phái.
Nước hoa Lancôme Tresor Midnight Rose mở ra bằng cuộc bùng nổ năng lượng tuyệt vời của hỗn hợp hương liệu hoa hồng và quả mâm xôi đan xen sắc vị mạnh mẽ của hồ tiêu và gỗ tuyết tùng. Hương thơm dần lắng đọng, thẩm thấu và hòa quyện khơi dậy một giai điệu hài hòa mạch lạc.
Chất vị gỗ tuyết tùng hòa hợp với nồng độ dịu nhẹ, sự hòa quyện của hương hoa nhài nồng nàn và xạ hương êm ái thắp lên tâm hồn nữ tính, bí ẩn mà hấp dẫn, cuồng nhiệt. Quả mâm xôi và phúc bồn tử lan tỏa hương thơm nhẹ nhàng và ngọt ngào. Hương hoa hồng khéo léo vừa đủ đi cùng mùi vị hồ tiêu hài hòa làm nên 	sự tinh tế giàu độ phức tạp cho các cung bậc hương thơm.
Tresor Midnight Rose là hương thơm nước hoa xinh đẹp quyến rũ và tinh quái. Tất cả tựa như một câu chuyện chinh phục tình yêu tràn ngập nụ cười, bí mật và vô cùng quyến rũ. Tresor Midnight Rose là một trò chơi trốn tìm tình ái lãng mạn giữa thủ đô Paris xinh đẹp.', 2450000, 0.2, 4)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (11, N'Nước Hoa Nữ Valentino Valentina Blush 80ML', N'ValentinoValentina Blush được ra đời vào năm 2017 với hợp âm gồm sự tuyển chọn bắt đầu với những 	ghi chú “mềm mại và sắc nét” của anh đào Morello và hạt tiêu hồng. Hương hoa cam được lộ ra ở lớp hương giữa, đặt trên cơ sở hương kẹo nhân ngọt ngào.
Sử dụng hợp âm màu hồng nhằm tạo ra sức cuốn hút trong tình yêu của mình trao đến những người xung quanh, Valentina Blush tựa như món trang sức mềm mại và sắc nét trong mắt mọi cô gái sau khi cầm qua nó. Kéo bất kỳ ai lại gần cũng như xóa tan đi những cảm giác xa lạ, Valentina Blush  kích thích khứu giác của nhiều người bằng cách pha trộn nét dịu nhẹ lẫn vào một ít cay nồng với Quả anh đào và Tiêu hồng.', 2640000, 0.2, 3)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (12, N'Nước Hoa Nữ Gucci Bloom Profumo Di Fiori Eau De Parfum 100ML', N'Nước Hoa Nữ Gucci Bloom Profumo Di Fiori là dòng nước hoa Ý được thiết kế dành riêng cho phụ nữ. Gucci Bloom Profumo  sở hữu có hương thơm của một vườn hoa phong phú và đa dạng của nhiều loài hoa mang lại sự trang trọng, tinh tế và thu hút cho người sử dụng.
Gucci Bloom Profumo Di Fiori chai nước hoa màu vàng - sắc vàng của mật ong, ngọt ngào mà ấm áp. Alberto Morillas, chuyên gia nước hoa bậc thầy, người ký hợp đồng với toàn bộ dòng Gucci Bloom, lần này đã chọn một “liên minh hoa” của ylang-ylang, hoa huệ và dây leo rangoon để tạo ra một hương thơm tinh vi, kỳ lạ được hỗ trợ bởi rừng cây thấm đẫm những tia nắng lấp lánh, tinh anh và rạng rỡ, sự khéo léo của orris cùng nhựa benzoin ấm và sắc thái mềm mại. Jasmine Sambac nhấn mạnh màu trắng của bó hoa và tăng cường hiệu ứng mặt trời của thành phần cùng với những nụ hoa nhài tinh tế.
Nước Hoa Nữ Gucci Bloom Profumo Di Fiori mở đầu là hương ngọt dịu của hoa huệ và ngọc lan tây. Tầng hương giữa được nhiều cô nàng yêu thích và tìm kiếm, những cánh hoa nhài quen thuộc nay được làm phong phú bởi sự ấm áp và ngọt ngào của hoa Ylang Ylang. Và cuối cùng là gỗ đàn hương ấm cúng, nồng nàn khó quên.', 3300000, 0.1, 2)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (13, N'Nước Hoa Unisex Lancôme Oranges Bigarades Eau De Parfum 100ML', N'Nước Hoa Unisex Lancôme Oranges Bigarades  có hương thơm tươi mát với nốt hương chủ đạo của cam chanh thơm ngát và hoa cỏ, làm nên người phụ nữ sống động, tươi vui.
Chai nước hoa Oranges Bigarades được làm bằng thủy tinh và vàng, trang trí bởi một tấm vàng ở mặt sau để khám phá dấu ấn của các thành phần, và ở bên cạnh, tiết lộ bí mật của nhà lắp ráp.
Hương cam quýt đẹp thực sự. Nó có mùi rất sang trọng, tinh tế và thanh lịch chỉ với một chút rung cảm của "người sành ăn". Mùi hương và chất lượng chính là thứ tôi mong đợi từ Lancôme. Orange Bigarades mở ra với cam tươi và mịn, trà đen và hoa nhài. Trời khô ráo trở nên ấm hơn, kem hơn, thân mật và gợi cảm hơn với hoa cam, gỗ đàn hương, hạt tiêu và vani. Tất cả các note hương đều là sự lãng mạn pha trộn với nhau. Nó chắc chắn có mùi như một loại nước hoa unisex cao cấp và đắt tiền. Nó sẽ rất hấp dẫn đối với một người phụ nữ và thiêng liêng đối với một người đàn ông. Tôi nghĩ rằng nó có thể được mặc quanh năm cho ngày hay đêm. Một chai nước hoa mới được thực hiện rất tốt từ Maison Lancôme.', 4800000, 0.2, 4)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (14, N'Nước Hoa Nữ Valentino Valentina Eau De Parfum 50ML', N'Valentino Valentina gây ấn tượng mạnh mẽ ngay từ thiết kế bên ngoài. Chai nước hoa Ý toát lên sự 	thanh lịch, tinh tế mang hơi hướng của phương Đông cổ điển. Thân chai được thiết kế hình tròn được trang trí bởi một bông hoa nở rộ làm điểm nhấn nổi bật rất xinh đẹp, nữ tính.
Hương thơm của chai nước hoa Valentino Valentina 50ml mang đến một sự cảm nhận vô cùng tinh tế 	về loại nước hoa dành riêng cho nữ, từ sự kết hợp tươi mát giữa hương hoa – trái cây – và các mùi hương đến từ 	phương Đông, đầy sự tương phản, đồng thời cũng vô cùng tinh tế với sự mạnh mẽ, thanh lịch, gợi cảm, nổi loạn và vui nhộn.
Chai nước hoa Valentino bắt đầu bởi hương thơm tươi mát tự nhiên của Cam bergamot và nấm cục 	trắng Alba. Tiếp theo đó là sự bung tỏa của hương hoa Nhài, hoa cam, hoa huệ trắng nồng nàn quyến rũ và hương dâu tây dại ngọt ngào, tinh nghịch, tất cả lắng đọng trên nền tuyết tùng, vanilla và hổ phách.', 1560000, 0.4, 3)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (15, N'Nước Hoa Nam Gucci Guilty Pour Homme Parfum 90ML', N'Nước hoa nam Gucci Guilty Pour Homme Parfum 90ml là chainước hoa nam hiện đại, đến từ thương hiệu nước hoa Gucci nổi tiếng. Gucci Guilty Pour Homme Parfum với hương thơm nam tính, sang trọng và đầy lôi cuốn dành cho phái mạnh.
Gucci Guilty Pour Homme Parfum là phiên bản nước hoa mới được ra mắt trong năm 2022. Đây được xem là bản nước hoa nồng nàn, đậm đà, và thơm lâu hơn bản Gucci Guilty Pour Homme Eau De Parfum  vốn đã quá nổi tiếng và được ưa chuộng trước đó.
Gucci Guilty Pour Homme Parfum  thuộc nhóm hương gia vị, gỗ cay nồng rất quyến rũ, với hai thành phần đặc trưng là hoa oải hương và hoa cam, mang đến sự rung cảm mãnh liệt giữa sự mạnh mẽ, gợi cảm nhưng không kém phần ngọt ngào, lãng mạn.
Hương thơm của Gucci Guilty Pour Homme Parfum mở ra với hương thơm nhẹ nhàng , dịu nhẹ hơn và hiện đại hơn với hương thơm của hoa oải hương khuếch đại ở tầng hương giữa với dấu ấn sâu đậm của nhựa thơm mềm và hương hoa cam và một chút cay của nhục đậu khấu. Cuối cùng kết thúc huwong bền lâu dài với hoắc hương quyến rũ, gỗ ấm áp và xạ hương hấp dẫn.', 2400000, 0.5, 2)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (16, N'Nước Hoa Nam Chanel Bleu De Chanel Parfum 100ML', N'Khúc ca tôn vinh sự tự do đầy nam tính được thể hiện trong một mùi hương gỗ thơm quyến rũ và kinh điển, chứa bên trong thiết kế chai màu xanh đầy bí ẩn. BLEU DE CHANEL Parfum là hương nước hoa hoàn hảo với hương thơm thuần khiết nhưng cũng rất sâu sắc, thể hiện sự nam tính, mạnh mẽ và tự tin.
	BLEU DE CHANEL Parfum là mùi hương gỗ nồng nàn và sôi nổi. Khởi đầu với cảm giác tươi mát và khỏe khoắn. Sau đó là nốt hương vương giả của gỗ đàn hương của vùng New Caledonia, mở ra những sắc thái đa dạng và mạnh mẽ trong những tầng hương dày dặn và tinh tế.', 3450000, 0.23, 1)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (17, N'Nước Hoa Valentino Valentina Assoluto Eau De Parfum 80ML', N'Hương thơm hoa cỏ Chypre chính là chủ đề được chọn ở Valentino Valentina Assoluto nhờ vào sự mãnh liệt và thanh tao của nó, và nguồn gốc của các nốt hương này bắt nguồn chủ yếu ở nước Ý. Hương thơm bắt đầu với cam bergamot, nấm cục trắng và nốt hương trái cây của đào chín. Ngay lớp hương giữa, hương thơm của hoa nhài tỏa hương một cách giao hưởng cùng với hoa huệ và phảng phất hương va-ni. Lớp hương cuối là sự hòa trộn của các nốt hương chypre - gỗ, trong đó có, rêu sồi, gỗ tuyết tùng và hoắc hương.
Khả năng lưu giữ mùi hương của Valentino Valentina Assoluto khá tốt, các nàng có thể tự tin với hương thơm mê mẩn đánh thức mọi giác quan của người đối diện suốt một thời gian dài, với từng tầng hương thơm.
Valentino đã lấy cảm hứng của mình từ Rome, thành phố bắt nguồn của thương hiệu để tạo nên hương thơm này. Hương thơm gợi lên hình ảnh của một cuộc tản bộ về đêm quanh thủ đô nước Ý. Valentina Assoluto đã mời người dùng bước chân vào và tận hưởng cuộc sống đầy gợi cảm và quyến rũ, dù chỉ trong phút chốc. Hương thơm được tạo ra dành cho những người phụ nữ nữ tính và vô cùng gợi cảm.', 2350000, 0.2, 3)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (18, N'Nước Hoa Nam Chanel Allure Homme EDT 100ML', N'Một mùi hương tươi mát, cay nồng nhưng cũng rất trầm ấm. Những nốt hương hài hòa và cân bằng của 	nó đại diện cho mùi hương của một người đàn ông lôi cuốn và quyết đoán.
Hỗn hợp hương tươi mát, cay nồng nhưng cũng rất trầm ấm là mô hình của sự cân bằng và hài hòa. Các nốt hương mạnh mẽ, tươi mát của quýt và coriander nổi bật ngay từ đầu, hòa quyện cùng những nốt hương mãnh liệt của gỗ tuyết tùng. Sau đó là sự kết hợp của đậu Tonka và lá Cistus Labdanum, trên nền của hương tiêu đen vùng Madagascar, tạo nên sức quyến rũ khó cưỡng.', 2450000, 0.4, 1)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (19, N'Nước Hoa Nữ Lancôme Tresor Eau De Parfum 100ML', N'Nước hoa Lancôme Tresor là dòng nước hoa nữ nổi tiếng được thiết kế riêng biệt cho phái đẹp đến từ Pháp. Lancôme Tresor được mệnh danh là kho báu quý giá trong thế giới nước hoa với mùi hương chững chạc, quyến rũ, gợi cảm.
Nước hoa Lancôme nói chung và chai nước hoa Lancôme Tresor 100ml nói riêng đều được thiết kế bao bì lấp lánh ánh vàng sang trọng, mỗi giọt nước thơm mang tên Tresor đều đủ sức khiến làn da bạn nở hoa, khiến bạn luôn quyến rũ và nổi bật. Mẫu chai nước hoa Lancôme Tresor đã trở thành một huyền thoại gợi lên hình ảnh một chiếc kim tự tháp thủy tinh lật ngược tinh tế, hệt như một viên kim cương lộng lẫy tọa lạc trong chiếc hộp châu báu.
		Mùi nước hoa sang trọng mang đến nét riêng biệt độc đáo không thể nhầm lẫn với bất kỳ ai khác với 	kiểu hương thơm phân tầng. Hương đầu có sự hiện diện của trái cây với đào chín mọng và hương thơm của quả 	mơ, tiếp ngay sau đó là hương hoa hồng nồng nàn cùng Irit mạnh mẽ, hoa vòi voi và violet, hương cuối kích thích mùi gỗ đàn hương và xạ hương, trái đào cùng tạo nên mùi thương đặc biệt bền lâu ấy.', 2650000, 0.2, 4)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (20, N'Nước Hoa Nữ Gucci Premiere 75ML', N'Chai nước hoa Gucci Premiere For Women nhấn mạnh khả năng tỏa sáng trong mỗi người phụ nữ, từ vẻ duyên dáng, tao nhã đầy mê hoặc. Nước hoa Gucci Premiere với hương đầu độc đáo, toát lên được nét sang 	trọng, mang lại cảm giác phấn khích như thể ta đang đang uống một ly rượu sâm banh lâu năm, rồi lại bùng nổ mạnh mẽ với hương cam bergamot quyện cùng với hương hoa cam  mang đến nét duyên dáng, vui vẻ, đầy mới mẻ.
Nước hoa Gucci Premiere là một hương thơm mạnh mẽ tinh tế, với hương thơm nồng nàn của gỗ và xạ hương. Gucci Premiere khoác vào đó là những phẩm chất cao quý của Gucci, bắt mắt, quyến rũ, với nét đẹp sang trọng, quý phái mà mọi cô gái đều xứng đáng nhận được.
Hương thơm nước hoa Gucci Premiere mở đầu với một mùi hương độc đáo, toát lên được nét sang trọng, mang lại cảm giác phấn khích như thể ta đang đang uống một ly rượu sâm banh lâu năm. Hương thơm 	bùng nổ mạnh mẽ với hương cam bergamot quyện cùng với hương hoa cam mang đến nét duyên dáng, vui vẻ, đầy mới mẻ.', 2549000, 0.2, 2)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (21, N'Set Nước Hoa Valentino Voce Viva Eau De Parfum (50ML + 15ML)', N'Set Nước Hoa Valentino Voce Viva Eau De Parfum (50 ml + 15ml) là sản phẩm nước hoa đến từ thương hiệu Valentino nổi tiếng Ý. Ngay từ khi có mặt trên thị trường set nước hoa luôn được yêu thích, săn đón. Set sản phẩm bao gồm: Nước hoa Valentino Voce Viva Eau De Parfum full size 50ml & Nước hoa Valentino Voce Viva Eau De Parfum Travel Spray 15ml.
Nguyên set nước hoa nữ Valentino Voce Viva Eau De Parfum đựng trong thiết kế hộp tone đỏ ấn tượng. 	Valentino Voce Viva Eau De Parfum full size 50ml có dạng chai thủy tinh kiểu hình vuông còn Voce Viva Eau De Parfum Travel Spray 15ml dạng hình trụ đứng. Cả hai đều có các đường khía ở các cạnh, cho thấy ánh sáng đi qua hương thơm của phụ nữ được bao bọc, cho phép ánh sáng chữ V nổi lên. Phần nắp chai có đinh tán bằng đá 	Valentino nổi bật nắp và cổ chai làm từ bằng crôm cùng với màu đỏ rực rỡ tương phản với hoa nước hoa phụ nữ bên trong.
Mùi hương nước hoa Valentino Voce Viva Eau De Parfum là một ca khúc của Valentino nữ tính-một sự hài hòa của thời trang cao cấp cam hoa cây sơn tuyệt đối và vàng kết hợp với cam bergamot Ý đầy màu sắc và quýt. Loại nước hoa này được làm gây nghiện thông qua một bất ngờ, lưu ý mát của tinh rêu phù hợp và vani nước hoa.', 3700000, 0.4, 3)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (22, N'Nước Hoa Nữ Gucci Bamboo 75ML', N'Ra mắt vào mùa xuân năm 2015, Gucci Bamboo là dòng nước hoa cùng tên với BST 	trang sức và phụ kiện thời thượng đến từ nhà mốt nổi tiếng nước Ý. Với ý tưởng tôn vinh nét đẹp nữ tính đầy tự tin của mỗi người phụ nữ, nước hoa Gucci Bamboo mang đến cho bạn một mùi hương sang trọng và cuốn hút đến bất ngờ.
Thuộc nhóm hương hoa cỏ – Floral, Gucci Bamboo được so sánh như một trải nghiệm vô cùng tinh tế và chân thực đến từ thiên nhiên nhiệt đới hoang dã. Sử dụng nguyên liệu chính từ tinh dầu trái cây và hoa 	tươi xứ nóng, nước hoa mang đến cho bạn cảm giác ngọt ngào và quyến rũ như đang lan tỏa dịu nhẹ trên khắp cơ thể.
Gucci Bamboo khởi đầu "kim tự tháp" mùi hương với cảm giác thanh mát, ngọt ngào đặc trưng của cam Bergamot. Khúc dạo đầu này sẽ khéo dài trong khoảng từ 10 đến 15 phút đầu tiên với nhiệm vụ tạo nên ấn tượng 	nhẹ nhàng đầy cuốn hút cho cơ thể bạn.
"Perfume pyramid" tiếp tục di chuyển đến tầng thứ 2 với cú “tấn công” đầy bất ngờ của middle notes. Nốt giữa của chai nước hoa Gucci là sự pha trộn đầy phức tạp giữa ngọc lan tây, hoa huệ Casablanca và hoa cam nữ tính. Dù mang một mùi hương khá đậm nhưng middle notes của Gucci Bamboo lại được đánh giá là khá ngọt ngào và dễ chịu khi sử dụng lâu dài.
Cuối cùng là base notes với sự góp mặt của xạ hương, gỗ đàn hương và vani Tây Ấn giúp mang đến cái kết không thể ngọt ngào và ấm áp hơn cho chai nước hoa của thương hiệu Gucci.', 2500000, 0.2, 2)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (23, N'Set Nước Hoa Chanel Coco Mademoiselle Eau De Parfum Twist & Spray (20MLx3)', N'Set nước hoa Chanel Coco Mademoiselle Eau De Parfum Twist & Spray  có thiết kế gồm 3 ống dung tích 20ml/ ống kèm 1 vỏ xịt, nhờ thiết kế chai trong suốt ấn tượng với màu nước hoa bên trong chai. Phần nắp chai cũng được thay đổi hoàn toàn bằng chất liệu kim loại mạ bạc sang chảnh. Chi tiết vàng hồng lấp lánh phía cổ chai càng tô điểm cho vẻ ngoài thời thượng và bắt mắt cho bộ nước hoa này.
Set Nước hoa Chanel Coco Mademoiselle Eau De Parfum Twist & Spray có mùi hương thơm phương Đông hiện đại với những nốt hương cơ bản là hoa hồng và hoa lài, nó tựa 1 bản nhạc nhẹ nhàng lướt qua như những cánh hoa rơi. Coco Mademoiselle Eau de Parfum không chỉ cuốn hút mọi ánh nhìn mà còn ẩn chưa sự ngọt ngào đầy quyến rũ, ma mị.', 3200000, 0.1, 1)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (24, N'Nước Hoa Nữ Valentino Donna Rosa Verde Eau De Toilette 125ML', N'Nước hoa Valentino Donna Rosa Verde dành cho nữ là hương thơm hoa cỏ được lấy cảm hứng từ mùi hương tưởng tượng của một khu vườn mê hoặc, Sonia Constant đã tạo ra Rosa Verde với một góc nhìn mới, với các thành phần tươi mát như hoa hồng xanh, trà xanh, cam bergamot, và điểm nhấn của gừng và mộc lan. 	Valentino Donna Rosa Verde được thiết kế với mang tính biểu tượng, lấy cảm hứng từ kiến trúc La Mã, là chữ 	ký của Valentino Couture.
Nước hoa Valentino Donna Rosa Verde đưa chúng ta vào một cuộc hành trình bí hiểm vào một khu vườn xanh tươi của một cung điện Ý, đi qua những đài phun nước huyền bí và những hồ nước trong vắt, những mảng ánh sáng mặt trời lấp lánh. Lấy cảm hứng từ mùi hương tưởng tượng của một khu vườn mê hoặc, 	Sonia Constant đã tạo ra Rosa Verde với một góc nhìn mới, với các thành phần tươi mát như hoa hồng xanh, trà xanh, cam bergamot, và điểm nhấn của gừng và mộc lan.', 1980000, 0.5, 3)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (25, N'Set Nước Hoa Nữ Gucci Flora Gorgeous Gardenia Eau De Parfum Mini Perfume (10ML + 5ML)', N'Set Nước Hoa Nữ Gucci Flora Gorgeous Gardenia  (10ml + 5ml) được mô tả như một theo một cách như trải hương thơm dẫn dắt nàng vào thế giới của các loài hoa. Chai nước hoa Pháp cho nàng thể hiện sự nữ tính, gợi cảm một cách đầy mạnh liệt, cuốn hút.
Set sản phẩm gồm:
	- Nước Hoa Nữ Gucci Mini Flora Gorgeous Gardenia 5ml.
	- Nước Hoa Nữ Gucci Flora Gorgeous Gardenia Travel Spray 10 ml.
Gucci Flora Gorgeous Gardenia  trở lại với một phiên bản Eau de Parfum mới thể hiện sự mạnh mẽ và sắc sảo hơn so với phiên bản Eau de Toilette ban đầu.&nbsp;Lấy cảm hứng từ truyền thuyết này và ý tưởng về sức mạnh thần bí của nó, nốt hương hoa Dành Dành tuyệt đẹp được kết hợp với Hoa Nhài mang lại năng lượng sáng ngời như một cách để tôn vinh vẻ đẹp của các loài hoa. Mùi hương được tinh tế điểm xuyến thêm chút ngọt ngào của đường nâu và một nguồn năng lượng dồi dào tươi mát của Hoa lê tựa như sự bùng nổ ở khứu giác tạo ra một cảm giác thăng hoa, đầy sức sống.', 1680000, 0.5, 2)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (26, N'Nước Hoa Nữ Valentino Valentina Oud Assoluto Eau De Parfum 80ML', N'Nước hoa Valentina Oud Assoluto của Valentino là một loại nước hoa dành cho phụ nữ. Đây là dòng 	nước hoa thuộc nhóm Leather (Hương da thuộc). đem lại cảm giác lôi cuốn, quyến rũ và gợi cảm.
Valentino Valentina Oud Assoluto là một mùi hương dành cho phụ nữ, thuộc tông da thuộc. Đây là một hương thơm mới của hãng Valentino, ra mắt vào năm 2013. Chuyên gia tạo ra hương thơm này là Olivier Cresp.
Valentino Valentina Oud Assoluto gây ấn tượng mạnh mẽ ngay từ thiết kế bên ngoài. Chai nước hoa Ý toát lên sự huyền bí, thu hút mang hơi hướng của phương Đông cổ điển. Thân chai được thiết kế hình tròn được trang trí bởi một bông hoa nở rộ màu đen làm điểm nhấn nổi bật rất xinh đẹp, nữ tính.
Đây là dòng nước hoa Valentino thuộc nhóm Leather (Hương da thuộc). Olivier Cresp chính là nhà pha 	chế ra loại nước hoa này. Bên cạnh đó, Gỗ trầm hương và Da thuộc là hai hương bạn có thể dễ dàng cảm nhận được nhất khi sử dụng nước hoa này.
Valentino Valentina Oud Assoluto có độ lưu hương lâu – 7 giờ đến 12 giờ. và độ tỏa hương thuộc dạng xa – toả hương trong vòng bán kính 2 mét. Valentina Oud Assoluto phù hợp để sử dụng trong cả ngày lẫn đêm vào mùa thu, đông.', 1880000, 0.4, 3)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (27, N'Nước Hoa Nữ Lancôme La Vie Est Belle Soleil Cristal 100ML', N'Nước Hoa Nữ Lancôme La Vie Est Belle Soleil Cristal 100ml là chai nước hoa nữ thanh lịch và quý phái đến từ thương hiệu Lancôme của Pháp.Lancôme La Vie Est Belle Soleil Cristal hương thơm vô cùng lôi cuốn và hấp dẫn, làm xao xuyến trái tim bao chàng trai xung quanh.
Lancôme La Vie Est Belle Soleil Cristal được thiết kế kiểu chai đơn giản kết hợp gam màu rực rỡ, lấp lánh, phụ kiện đi kèm là chiếc ruy bang màu hồng thanh lịch tượng trưng một cô gái với chiếc khăn lụa thời trang.
Hạnh phúc không chỉ là cảm giác, nó là ánh hào quang tỏa ra xung quanh như ánh mặt trời trong ngày hè ấm áp. Lancôme La Vie Est Belle Soleil Cristal nắm bắt được bản chất của một ngày hè đầy nắng và tạo ra hương nước hoa Lancôme đầy ngọt ngào và tươi mát. Đây đích thị là hương nước hoa làm được điều không tưởng. Bởi mặc dù mang tông mùi chủ đạo là mùi ngọt nhưng bạn có thể vô tư sử dụng vào mùa hè đầy nắng…
Những cảm nhận đầu tiên khi sử dụng là hương thơm vô cùng lôi cuốn bởi mùi tiêu hồng, và mát mẻ của Cam Bergamot. Sau đó hoàn toàn là hương dừa và vani kết hợp với hương từ các loại hoa nở rộ. Lancôme La Vie Est Belle Soleil Cristal được làm tươi mới bởi trái cây, thơm mang lại cảm giác thư thái và dễ chịu.', 3150000, 0.2, 4)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (28, N'Nước Hoa Chanel Chance Eau Tendre 100ML', N'Nước hoa Chanel Chance Eau Tendre Eau de Parfum thuộc nhóm hương Floral Fruity (Hương hoa cỏ trái cây). Hương Bưởi và quả Mộc Qua bắt đầu với sự nhẹ nhàng, đơn giản nhưng đầy tinh tế. Chance Eau Tendre Eau de Parfum được đánh giá là một cô gái xinh đẹp với mái tóc bồng bềnh, sở hữu một nụ cười nhẹ nhàng và một mùi hương “sạch sẽ”. Hoa Nhài và hoa Hồng khiến nàng trở nên ngọt ngào nhưng không hề gắt, và mọi sự chú ý sẽ dồn vào note hương cuối cùng của cô nàng Chance Eau Tendre Eau de Parfum, Xạ hương trắng. Nếu bạn là một tín đồ của xạ hương, và cũng yêu thích sự tươi mát của hương hoa cây cỏ, thì đừng bao giờ bỏ qua cô nằng dịu dàng Chanel Chance Eau Tendre Eau de Parfum này.', 3450000, 0.11, 1)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (29, N'Nước Hoa Nữ Lancôme Hypnose Eau De Parfum 50ML', N'Nước Hoa Nữ Lancôme Hypnose Eau De Parfum 50ml là sự hòa quyện hoàn hảo của nhóm vani phương Đông ngào ngạt, mang đến cho bạn vẻ ngoài nổi bật và hấp dẫn hơn bao giờ. Đây là dòng nước hoa cao cấp được hãng Lancôme cho ra mắt vào năm 2005 và được sự đón nhận của các tín đồ nước hoa.
Bên cạnh hương thơm thanh lịch thì vẻ ngoài tinh tế đầy sang chảnh của Lancôme Hypnose 50ml cũng là một điểm nhấn khó phai đối với mọi tín đồ nước hoa Lancôme nữ.
Lancôme Hypnose EDP mang tới thiết kế lộng lẫy, kiêu sa cực kỳ đặc trưng của thương hiệu làm đẹp nước Pháp. Siêu phẩm này được mô tả như một cô nàng điệu đà đang chìm đắm trong những bước nhảy đam mê. Sắc xanh dương của phần thân chai khiến chúng ta liên tưởng đến màu mắt quyến rũ của các cô nàng phương Tây. Thời thượng, sang trọng và ngập tràn lôi cuốn, nước hoa Lancôme Hypnose 50ml chính là chiếc chìa khóa mở ra cánh cửa sức hút cho bạn.
Mang theo nét ấn tượng và lôi cuốn trong từng chuyển động của bạn, nước hoa Lancôme Hypnose được coi là “thứ hành trang” không thể bỏ qua trên chặng đường làm đẹp của mọi cô gái.
Lancôme Hypnose 50ml khai thác nét quyến rũ đầy ấn tượng của nhóm tinh dầu vani phương Đông. Mùi hương này bắt đầu với cảm giác ngọt ngào, thanh mát của hoa chanh dây. Heart notes xuất hiện một cách nồng nàn hơn với sự góp mặt đồng thời của hoa nhài và sơn chi thơm ngát.
Tầng hương giữa mang đến cảm giác khá bay bổng và mềm mại, tựa như một giấc mộng thoảng qua trong chốc lát. Base notes kết lại bản hòa ca mùi hương bằng sự tinh tế, đậm đà của vani và cỏ hương bài. Ở Lancôme Hypnose EDP, chúng ta hoàn toàn có thể cảm nhận được vẻ đẹp sang trọng và quyến rũ như đang hòa quyện trong từng nốt hương nồng nàn.', 1700000, 0.5, 4)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (30, N'Nước Hoa Nữ Lancôme Tresor La Nuit Eau De Parfum 100ML', N'Nước Hoa Lancôme Tresor La Nuit EDP 100ml là chai nước hoa hàng hiệu đẳng cấp dành cho nữ, đến từ thương hiệu Lancôme nổi tiếng Pháp. Lancôme Tresor La Nuit được đánh giá có phần ngọt ngào, tinh tế hơn dễ dàng thể hiện được sự nữ tính, quyến rũ của các nàng sử dụng.
Thân chai nước hoa Lancôme Tresor La Nuit EDP 100ml như một viên kim cương, nhưng nó không lóng lánh mà mang vẻ đẹp huyền bí như viên đá quý. Chai nước hoa thủy tinh không màu làm lộ dung dịch màu hồng nhạt bên trong vô cùng gợi cảm đầy tinh tế.
Điểm gây ấn tượng nhất đó chính là phần cổ chai với bông hoa hồng đen bằng satin, ngay lập tức người ta liên tưởng đến quý cô người Pháp sang trọng, gợi cảm, đẹp và biết cách tạo sự bí ẩn riêng cho mình.
Mở đầu cho chai nước hoa Lancôme là sự kết hợp của lê, cam bergamot và quýt tươi mát tự nhiên. Sự bung tỏa của hương phong lan vani ngạt ngào, hương hoa hồng đen cùng chanh dây và dâu tây hòa quyện với nhau, nhẹ nhàng, sang trọng nhưng cũng vô cùng cuốn hút. Tiếp theo là một loạt các thành phần: hoắc hương, nhang, cây cói, kẹo nhân hạt ngọt ngào, quả vải, vani, cam thảo, cafe. Tất cả những nốt cuối dù không mạnh nhưng tạo được ấn tượng sâu sắc và giữ thật lâu trên cơ thể.', 2650000, 0.2, 4)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (31, N'Nước Hoa Nữ Gucci Flora by Gucci Eau De Parfum 50ML', N'Nước hoa Gucci Flora có mùi hương nữ tính với các lớp hương cực kỳ tinh tế cùng độ tỏa hương khá ổn: hương đầu nổi bật với hương cam quýt hoa mẫu đơn, hương giữa quyến rũ với mùi hoa hồng và hoa Osmanthus và hương cuối gồm gỗ đàn hương hoắc và gỗ cây tuyết tùng.
Khởi đầu là điểm đặc trưng của Flora by Gucci , với hương thơm tươi mát của hương cam, kết hợp 	với hương hoa mẫu đơn và quýt hồng, làm dậy lên mùi hương hoa trái ngọt ngào, thanh khiết và mộng mơ. Đi sâu vào lớp hương giữa, ta cảm nhận được mùi hương tinh tế của hương hoa hồng và hương thơm hoa mộc tê hương phảng phất và vương mãi trên làn da.
Trong khi đó, lớp hương cuối gợi lên sự mơ mộng, với hương hoa thơm ngát, ngọt ngào, nống ấm của hoa hoắc hương. Sự góp mặt của hương gỗ đàn hương và hồng tiêu giúp lớp hương này trở nên mềm mại hơn, với hương thơm lưu lại lâu trên làn da.', 1590000, 0.5, 2)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (32, N'Nước Hoa Nam Chanel Allure Homme Sport Eau De Toilette 100ML', N'Một hương thơm tươi mát và phảng phất mùi gỗ ấm. Sự pha trộn của những nốt hương tươi mát, sống động và gợi cảm gợi lên sức hút của một người đàn ông phóng khoáng.
Một mùi hương tươi mát và gợi cảm. Hương quýt Italia được tôn thêm một cách thanh khiết và mãnh liệt trên nền của tuyết tùng. Hương hạnh nhân gợi cảm của đậu tonka Venezuela kết hợp cùng những nốt hương bao bọc của xạ hương trắng, mở ra một sự sâu thẳm và mãnh liệt.', 2790000, 0.4, 1)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (33, N'Nước Hoa Nữ Lancôme Tresor La Nuit A La Folie 75ML', N'Nước hoa nữ Lancôme Tresor La Nuit A La Folie, hương thơm kỳ bí hiện thân của khoảnh khắc tình yêu thăng hoa. Khoảnh khắc ngất ngây khi thời gian bỗng như ngừng lại, những cặp tình nhân như bị mê hoặc 	bởi hương thơm nồng nàn, quyến rũ, quyện vào nhau đắm say.
Bên cạnh hương thơm thanh lịch thì vẻ ngoài tinh tế đầy sang chảnh của Lancôme La Nuit Tresor A La 	Folie cũng là một điểm nhấn khó phai đối với mọi tín đồ nước hoa Lancôme nữ.
Nước hoa Lancôme La Nuit Tresor A La Folie mang theo vóc dáng của một viên kim cương diễm lệ với những mặt cắt chân thực đến hoàn hảo. Sự kết hợp giữa màu sắc đen hồng cùng thứ nước lấp lánh phía trong càng tô điểm cho vẻ ngoài mê hoặc đến bí ẩn của “siêu phẩm” này. Quyền lực, đam mê và ngập tràn lôi cuốn, nước hoa Lancôme La Nuit Tresor A La Folie chính là viên ngọc quý mà mọi cô nàng đều khát khao được sở 	hữu một lần trong đời.
Với cảm hứng từ đề tài tình yêu và sức quyến rũ lan tỏa, mùi hương của dòng nước hoa này đã được “nhào nặn” một cách kỹ càng nhằm mang tới những trải nghiệm chân thực nhất. Lancôme La Nuit Tresor A La Folie chính là hình ảnh phản chiếu của những cô nàng hiện đại, lôi cuốn với niềm hạnh phúc luôn hiện hữu 	trên đôi môi.
Lancôme La Nuit Tresor A La Folie mang theo âm hưởng ngọt ngào đầy nữ tính của các loài hoa và trái cây tươi. Nốt hương đầu mở màn với cảm giác lạc quan đầy tươi tắn của tiêu hồng, cam Bergamot và trái lê. Tiến dần hơn vào phía trong, các nàng sẽ lập tức cảm nhận được hương vị nồng nàn và tinh tế đến từ nhóm hoa cỏ ấm áp. Tinh dầu violet hòa quyện cùng mẫu đơn, hồng Đan Mạch và nhài thơm Sambac đã mang tới nét ngào ngạt và hấp dẫn đặc trưng của mùi hương này. Base notes khép lại đầy lãng mạn với hoắc hương, đậu Tonka và vani cuốn hút.', 2250000, 0.5, 4)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (34, N'Nước Hoa Nữ Valentino Donna 100ML', N'Donna dành cho những cô nàng thích sự thanh lịch, dịu dàng, nhưng không kém phần quyến rũ, mang thêm chút cổ điển.
Là dòng nước hoa thuộc hương hoa cỏ Chypre nên Valentino Donna tổng hòa những hương vị khá độc đáo. Mở đầu cho mùi hương này là sự tươi mát của cam bergamot Ý, một chút ngọt ngào thanh tao của các loài hoa hồng Bulgari, hoa diên vĩ mong manh dễ chịu và tăng nét đậm đà cho lớp hương cuối là hoắc hương, da thuộc và vani.
Thiết kế chai là sự kết hợp giữa thủy tinh trong điểm xuyết hoạ tiết nhấp nhô như những viên kim cương sáng lấp lánh dập nổi khắp thân chai nước hoa rất bắt mắt và thời thượng, để mẫu chai nữ tính hơn nên màu hồng được lấy làm chủ đạo.', 2650000, 0.2, 3)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (35, N'Nước Hoa Nam Chanel Egoiste Platinum Eau De Toilette 50ML', N'Như bức chân dung của một quý ông có tính cách hướng ngoại, cá tính và khiêu khích. Phiên bản Eau 	De Toilette mang nốt hương xanh fougère-vert. Một mùi hương tràn đầy năng lượng với những nốt hương tươi 	mát.
Sự hoà quyện giữa cân bằng và sức mạnh. Mùi hương fougère xanh tươi với hương thơm tươi mát từ 	oải hương và hương thảo, được tôn lên nhờ tinh dầu cam đắng từ Paraguay. Hương thơm tâm điểm được tạo thành từ sự kết hợp của tinh dầu xô thơm và hoa phong lữ, trên hương nền tinh khiết, ấm áp như hổ phách của những nốt hương gỗ diệu kỳ.', 2480000, 0.2, 1)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (36, N'Nước Hoa Nam Gucci Guilty Black Pour Homme Eau De Toilette 90ML', N'Nước Hoa Nam  Gucci Guilty Black Pour Homme là chai nước hoa nam cao cấp  đến từ thương hiệu Gucci nổi tiếng của Ý. Gucci Guilty Black Pour Homme EDT với hương thơm dành riêng cho chàng trai có phong cách táo bạo, hiện đại nhưng vẫn giữ lại đôi nét về sự cổ điển.
Chai nước hoa Ý mang một hương thơm ấm áp và nồng nàn, pha lẫn một chút gì đó bí ẩn và hiện đại. Mở đầu với mùi hương được kết hợp giữ ngò thơm xanh lục, hoa oải hương nhẹ nhàng. Tầng tiếp đến với hương thơm ấm áp của hoa cam, hoa cam neroli, hương lục. Tầng cuối với mùi hương của cây hoắc hương và gỗi tuyết lùn.', 2300000, 0.4, 2)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (37, N'Nước Hoa Nữ Lancôme La Nuit Trésor Musc Diamant L’eau De Parfum 75ML', N'Nước Hoa Nữ Lancôme La Nuit Trésor Musc Diamant L’eau De Parfum 75ml là chai nước hoa hàng hiệu đẳng cấp dành cho nữ, đến từ thương hiệu Lancôme nổi tiếng Pháp. Lancôme Tresor La Nuit được đánh giá có phần ngọt ngào, tinh tế hơn dễ dàng thể hiện được sự nữ tính, quyến rũ của các nàng sử dụng.
Thiết kế chai nước hoa Lancôme La Nuit Trésor Musc Diamant L’eau De Parfum 75ml tựa như viên kim cương tỏa sáng, sang trọng và tinh khôi cùng thành phần note hương có cấu trúc đặc biệt, khi xạ hương trắng hiện diện ở khắp các tầng hương, phủ lên lớp kim cương bằng sắc hương mộng mị của hoa tím. La Nuit Tresor Musc Diamant là mùi hương ngọt ngào pha chút tươi mới, nhưng sạch sẽ và cuốn hút đầy bất ngờ.
Lancôme La Nuit Trésor Musc Diamant L’eau De Parfum 75ml lại mang một cấu trúc hương vô cùng đặc biệt khi ta có thể thấy thành phần Xạ hương trắng có mặt trong cả 3 tầng hương. Mặc dù có độ phủ dầy đặc nhưng xạ hương của La Nuit Trésor Musc Diamant lại rất nhẹ êm và rất mượt mà.
Hương thơm xuất hiện lấp lánh trên da thịt, hòa quyện với từng mạch đập, tỏa hương dìu dặt, đủ để bạn đấm chìm trong cảm giác đê mê ấy. La Nuit Trésor Musc Diamant như một bông hồng quyến rũ và đầy đam mê. Hương thơm mang đến ấn tượng đầu tiên về nốt hương đầu việt quất dịu dàng, dần dần lan tỏa thành nốt hương hoa đầy kích thích của tinh chất Hoa hồng Damascena trước khi đến với nốt hương cuối – hương xạ hương trắng đầy thanh nhã.', 2290000, 0.2, 4)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (38, N'Nước Hoa Nữ Lancôme Tresor In Love Eau De Parfum 75ML', N'Nước Hoa Lancôme Tresor In Love là chai nước hoa nữ cao cấp đến từ thương hiệu Lancôme nổi tiếng. Lancôme Tresor In Love sở hữu hương thơm nhẹ nhàng quyến rũ, ngay từ khi ra mắt chai nước hoa được rất nhiều tín đồ yêu thích.
Chai nước hao Lancôme Tresor In Love gợi nên vẻ lôi cuốn ngay từ cái nhìn lần đầu bởi sự chuyển màu tinh tế từ gam màu hồng phấn sang hồng nhạt. Một bông hồng đen điểm trên cổ chai càng tôn vinh vẻ đẹp thanh lịch và sang trọng tuyệt vời.
Mùi hương này vừa nồng nàn, lôi cuốn lại vô cùng trẻ trung, thanh lịch với mọi cô nàng hiện đại. Sử dụng Lancôme Tresor In Love trong điều kiện thời tiết ấm áp vào mùa xuân sẽ là chìa khóa hoàn hảo cho sức hấp dẫn của bạn.
Với hương thơm nhẹ nhàng, nước hoa Tresor In Love thể hiện cảm giác của người phụ nữ đang yêu. Mùi hương được kết hợp bởi hoa, trái cây và hương nền là gỗ tuyết tùng. Kiểu chai được thiết kế dạng cao, trên cổ chai được điểm một bông hồng làm tăng vẻ sang trọng.
Những đường nét uốn lượn mềm mại trên thân chai như đặc tả vẻ đẹp hình thể của người phụ nữ, vừa mềm mại, vừa nữ tính. Đặc biệt, trên mỗi chai nước hoa cao cấp này đều có một bông hồng bằng Satin dành tặng riêng cho chủ nhân của nó. Câu chuyện tình yêu của bạn sẽ thật tuyệt vời nếu có Tresor In Love cùng đồng hành, hãy cảm nhận những gì bạn xứng đáng được nhận nhé.', 1800000, 0.4, 4)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (39, N'Nước Hoa Nam Lancôme Hypnose Homme Eau De Toilette 75ML', N'Lancôme Hypnose EDT mang tới thiết kế lộng lẫy, kiêu sa cực kỳ đặc trưng của thương hiệu làm đẹp nước Pháp. Siêu phẩm này được mô tả như một chàng trai quyến rũ đang chìm đắm trong những bước nhảy đam mê. Thời thượng, sang trọng và ngập tràn lôi cuốn, nước hoa Lancôme Hypnose 75ml chính là chiếc chìa khóa mở ra cánh cửa sức hút cho bạn.
Mở đầu là nốt hương bạc hà đầy tươi mát xen lẫn gia vị bạch đậu khấu nồng nàn. Điểm xuyết nét chấm phá của mùi hương cam quýt tạo nên cảm giác rất tự nhiên, đầm ấm và dễ chịu.
Sau cảm giác thoải mái thư giãn ấy là sự ùa về của cơn lốc mùi Oải hương. Hương thơm nồng nàn đến từ nước Pháp có một sự lôi cuốn đến vô tận. Mùi hương ấy không những hấp dẫn các quý ông mà còn hấp dẫn tất cả phụ nữ. Mỗi lần chạm vào là một lần mãi không quên.
Chưa hết cảm giác xao xuyến thì một làn hương trầm ấm và tinh tế lại khe khẽ đến bên bạn. Mùi hương ấy cứ vương vấn trên da mãi không rời. Mùi hương ấy là sự kết hợp giữa hoắc hương Indonesia, hổ phách và xạ hương. Đây chính là nốt thăng và điểm nhấn ấn tượng của tác phẩm. Chắc hẳn nốt hương cuối sẽ là một mùi hương không thể nào quên.
Lancôme Hypnose là một kết hợp hài hòa rất nam tính, rất trầm ổn, nhưng không kém phần gợi cảm. Hypnose khơi gợi nét quyến rũ tiềm ẩn của mỗi người đàn ông khi khoác mùi hương lên mình. Đây thực sự là một món quà hoàn hảo cho các quý ông trong những dịp đặc biệt.', 1785000, 0.2, 4)
INSERT [dbo].[Product] ([id], [name] , [description], [price], [discount], [categoryId]) VALUES (40, N'Nước hoa Gucci Flora Gorgeous Gardenia Eau De Toilette 100ML', N'Nước hoa Gucci Flora Gorgeous Gardenia Eau De Toilette 100ml là nước hoa dành cho nữ đến từ thương hiệu Gucci của nước Ý. Gucci Flora Gorgeous Gardenia mang một mùi thơm tinh tế, 	sâu sắc và vô cùng 	nữ tính.
Flora by Gucci Gorgeous Gardenia ra mắt vào năm 2012 là một trong năm phiên bản nước hoa mới của Gucci Flora. Một hương thơm mới lộng lẫy, sáng mịn và nữ tính, không thể thiếu trong bộ sưu tập của giới đam mê nước hoa. Mùi hương chất chứa nhiều xúc cảm lãng mạn, gợi cảm theo một cách rất tự nhiên.
Gucci Flora Gorgeous Gardenia mở ra những nốt dạo đầu tươi mát với hương thơm cuốn hút đến từ nhóm trái cây như lê và quả mọng. Sau một vài phút chìm đắm trong cảm giác nhẹ nhàng, thư thái sẽ là đoạn điệp khúc ngọt ngào của tầng hương giữa. Với đặc trưng nồng nàn và mạnh mẽ, heart botes của Gucci Flora Gorgeous Gardenia mang đến cảm giác lưu luyến rất riêng của loài hoa nhài tây. Hoa đại với phong vị nhẹ nhàng, mơ mộng cũng góp phần tạo nên tính cách cuốn hút của tầng hương giữa. Cuối cùng, bản hòa ca khép lại đầy êm dịu với sự xuất hiện của hoắc hương và đường nâu đậm đà.', 1895000, 0.4, 2)
SET IDENTITY_INSERT [dbo].[Product] OFF

SET IDENTITY_INSERT [dbo].[Account] ON 
-- INSERT [dbo].[Account] ([id], [name], [address], [phone], [email], [role]) VALUES (1, N'Admin', N'9652 Los Angeles', N'0123456789', N'a@petstore.com', 'ROLE_ADMIN')
INSERT [dbo].[Account] ([id], [username], [address], [phone], [email],[password], [role]) VALUES
(1, N'Admin', N'9652 Los Angeles', N'0123456789', N'a@perfumestore.com', 'F55FF16F66F43360266B95DB6F8FEC01D76031054306AE4A4B380598F6CFD114', 'ROLE_ADMIN'),
(2, N'Employee1', N'5747 Shirley Drive', N'1234567890', N'e1@perfumestore.com', '8B5CC4DF7EEC7D32A7814ECA4AF047AE33B2D52342667715682E19C25B0B9FAA', 'ROLE_EMPLOYEE'),
(3, N'Employee2', N'3841 Silver Oaks Place', N'2345678901', N'e2@perfumestore.com', 'AC0F09C0F8BF5E7A4B063D863255F16D8CE9ABE600E288D934CF313BCBFF63EB', 'ROLE_EMPLOYEE'),
(4, N'Employee3', N'3208 Hilltop Drive', N'2345678901', N'e3@perfumestore.com', 'CEF7FC13A38180936FFA2635489088778E059F07A5D1BEDA53F1719D35577631', 'ROLE_EMPLOYEE'),
(5, N'Customer1', N'1873 Lion Circle', N'5678901234', N'c1@perfumestore.com', 'D0F631CA1DDBA8DB3BCFCB9E057CDC98D0379F1BEE00E75A545147A27DADD982', 'ROLE_CUSTOMER'),
(6, N'Customer2', N'1030 Forest Avenue', N'2025550184', N'c2@perfumestore.com', '9C0ABE51C6E6655D81DE2D044D4FB194931F058C0426C67C7285D8F5657ED64A', 'ROLE_CUSTOMER'),
(7, N'Customer3', N'5108 South Greenwood Avenue', N'2125550876', N'c3@perfumestore.com', '7C1C97DF17C066924822B0AF09A65251554962C61E23329AED04CD19020DC3B8', 'ROLE_CUSTOMER'),
(8, N'Customer4', N'2448 W Pensacola Ave', N'3125550199', N'c4@perfumestore.com', '0012A3FA000C5DC26EE658C3C58E12CECD58D6455CEC3D5621F0C787675B38AA', 'ROLE_CUSTOMER'),
(9, N'Customer5', N'1791 Broadway', N'4155550133', N'c5@perfumestore.com', 'D0BF3E6EE1D668DE18C9CA200A4F152062F345283EE68CADFE41204F215D75E9', 'ROLE_CUSTOMER'),
(10, N'Customer6', N'4137 University Way', N'8045550182', N'c6@perfumestore.com', '6DB53C9D5A2CA72A85DDF3A681C0D9567899F4C48632A2E9B0BEEBA0D6938485', 'ROLE_CUSTOMER')
SET IDENTITY_INSERT [dbo].[Account] OFF

-- Insert Table Customer
-- Example INSERT [dbo].[Customer] ([id], [category], [deliveryAddress]) VALUES (4, 'Copper', N'1873 Lion Circle')
INSERT [dbo].[Customer] ([id], [category], [deliveryAddress]) VALUES (5, 'Gold', N'Vinhome Grand Park, Quận 9, Thành phố Hồ Chí Minh')
INSERT [dbo].[Customer] ([id], [category], [deliveryAddress]) VALUES (6, 'Diamond', N'191 Nguyễn Thị Minh Khai, Quận 1, Thành phố Hồ Chí Minh')
INSERT [dbo].[Customer] ([id], [category], [deliveryAddress]) VALUES (7, 'Copper', N'5108 South Greenwood Avenue')
INSERT [dbo].[Customer] ([id], [category], [deliveryAddress]) VALUES (8, 'Silver', N'2448 W Pensacola Ave')
INSERT [dbo].[Customer] ([id], [category], [deliveryAddress]) VALUES (9, 'Gold', N'1791 Broadway')
INSERT [dbo].[Customer] ([id], [category], [deliveryAddress]) VALUES (10, 'Diamond', N'4137 University Way')

-- Insert Table Employee
-- Example INSERT [dbo].[Employee] ([id], [salary], [departmentId]) VALUES (1, 1200, 1)
INSERT [dbo].[Employee] ([id], [salary], [departmentId]) VALUES 
(1, 20000000, 1),
(2, 18000000, 2),
(3, 15000000, 2),
(4, 15000000, 2)
GO

INSERT dbo.OrderHeader([date], [status], customerId, employeeId, note) VALUES
('2019-01-29', 'Completed', 5, 1, NULL),
('2019-02-17', 'Completed', 6, 3, NULL),
('2019-04-01', 'Completed', 8, 2, NULL),
('2019-06-12', 'Completed', 7, 4, NULL),
('2019-08-15', 'Completed', 9, 3, NULL),
('2019-10-13', 'Completed', 10, 1, NULL),
('2019-11-07', 'Completed', 8, 2, NULL)
GO

INSERT dbo.OrderDetail (orderHeaderId, productId, quantity, price, discount) VALUES
(1, 3, 2, 5300000, 0.4),
(1, 5, 1, 3000000, 0.2),
(1, 2, 1, 3590000, 0.2),

(2, 4, 1, 4180000, 0.2),
(2, 8, 2, 6360000, 0.4),
(2, 6, 3, 9600000, 0.1),

(3, 1, 1, 3750000, 0.11),
(3, 7, 2, 5900000, 0.2),
(3, 9, 1, 2000000, 0.5),

(4, 10, 1, 2450000, 0.2),
(4, 12, 2, 6600000, 0.1),
(4, 15, 2, 4800000, 0.5),

(5, 17, 3, 7050000, 0.2),
(5, 12, 1, 3300000, 0.1),
(5, 6, 2, 6400000, 0.1),

(6, 20, 1, 2549000, 0.2),
(6, 18, 3, 7350000, 0.4),
(6, 22, 2, 5000000, 0.2),

(7, 24, 1, 1980000, 0.5),
(7, 23, 2, 6400000, 0.1),
(7, 27, 3, 9450000, 0.2)
GO

INSERT dbo.OrderHeader([date], [status], customerId, employeeId, note) VALUES
('2020-01-21', 'Completed', 6, 1, NULL),
('2020-03-26', 'Completed', 6, 2, NULL),
('2020-04-15', 'Completed', 7, 3, NULL),
('2020-06-01', 'Completed', 5, 2, NULL),
('2020-10-05', 'Completed', 10, 1, NULL),
('2020-12-09', 'Completed', 9, 4, NULL),
('2020-11-26', 'Completed', 8, 1, NULL)
GO

INSERT dbo.OrderDetail (orderHeaderId, productId, quantity, price, discount)
VALUES

(7, 1, 1, 3750000, 0.11),
(7, 3, 1, 2650000, 0.4),
(7, 5, 3, 9000000, 0.2),

(8, 10, 2, 4900000, 0.2),
(8, 14, 5, 7800000, 0.4),

(9, 36, 1, 2300000, 0.4),
(9, 30, 2, 5300000, 0.2),
(9, 23, 5, 16000000, 0.1),

(10, 29, 1, 1700000, 0.5),
(10, 18, 3, 7350000, 0.4),
(10, 10, 1, 2450000, 0.2),

(11, 17, 1, 2350000, 0.2),
(11, 23, 1, 3200000, 0.4),

(12, 29, 1, 1700000, 0.5),
(12, 20, 1, 2549000, 0.2),

(13, 6, 1, 3200000, 0.1),
(13, 11, 1, 2640000, 0.2),

(14, 7, 1, 2950000, 0.2),
(14, 27, 1, 3150000, 0.2)

GO

INSERT dbo.OrderHeader([date], [status], customerId, employeeId, note) VALUES
('2021-02-19', 'Completed', 5, 4, NULL),
('2021-03-17', 'Completed', 6, 2, NULL),
('2021-05-20', 'Completed', 7, 1, NULL),
('2021-07-09', 'Completed', 8, 4, NULL),
('2021-09-21', 'Completed', 9, 3, NULL),
('2021-11-19', 'Completed', 7, 1, NULL),
('2021-12-14', 'Completed', 6, 2, NULL)
GO


INSERT dbo.OrderDetail (orderHeaderId, productId, quantity, price, discount)
VALUES
(15, 10, 1, 7500000, 0.5),
(15, 20, 3, 6000000, 0.6),
(15, 30, 3, 6500000, 0.4),

(16, 15, 1, 9000000, 0.3),
(16, 20, 3, 1200000, 0.6),
(16, 36, 4, 3000000, 0.4),
(16, 30, 2, 5600000, 0.4),

(17, 35, 2, 3200000, 0.1),

(18, 11, 1, 7500000, 0.3),
(18, 22, 3, 3900000, 0.3),
(18, 33, 2, 1300000, 0.1),
(18, 36, 3, 8900000, 0.2),
(18, 21, 2, 4000000, 0.4),

(19, 15, 5, 7000000, 0.2),
(19, 20, 3, 3400000, 0.3),
(19, 30, 2, 5400000, 0.3),

(20, 18, 4, 6100000, 0.1),
(20, 28, 3, 2800000, 0.2),

(21, 14, 1, 2300000, 0.5),
(21, 27, 3, 5600000, 0.6),
(21, 36, 2, 6500000, 0.7)

GO

INSERT dbo.OrderHeader([date], [status], customerId, employeeId, note) VALUES
('2022-02-17', 'Completed', 8, 1, NULL),
('2022-04-23', 'Completed', 6, 2, NULL),
('2022-05-19', 'Completed', 10, 3, NULL),
('2022-07-10', 'Completed', 9, 2, NULL),
('2022-09-26', 'Completed', 7, 1, NULL),
('2022-11-05', 'Failed', 5, 4, NULL),
('2022-12-14', 'Completed', 10, 1, NULL)
GO

INSERT dbo.OrderDetail (orderHeaderId, productId, quantity, price, discount)
VALUES

(22, 33, 1, 2250000, 0.5),
(22, 2, 1, 3590000, 0.2),
(22, 15, 1, 2400000, 0.5),

(23, 5, 2, 6000000, 0.2),
(23, 13, 1, 4800000, 0.2),

(24, 19, 1, 2650000, 0.2),
(24, 22, 2, 5000000, 0.2),
(24, 6, 1, 3200000, 0.1),

(25, 25, 1, 1680000, 0.5),
(25, 3, 1, 2650000, 0.4),
(25, 10, 1, 2450000, 0.2),

(26, 32, 1, 2790000, 0.4),
(26, 21, 1, 3700000, 0.4),

(27, 29, 1, 1700000, 0.5),

(28, 16, 1, 3450000, 0.23),
(28, 22, 1, 2500000, 0.2),
(28, 7, 1, 2950000, 0.2),
(28, 27, 1, 3150000, 0.2)

GO

INSERT dbo.OrderHeader([date], [status], customerId, employeeId, note) VALUES
('2023-01-18', 'Completed', 10, 2, NULL),
('2023-01-20', 'Failed', 5, 3, NULL),
('2023-01-28', 'Completed', 6, 4, NULL),
('2023-02-17', 'Completed', 7, 1, NULL),
('2023-02-25', 'Completed', 8, 3, NULL),
('2023-03-01', 'Completed', 9, 2, NULL),
('2023-03-10', 'Completed', 6, 1, NULL)
GO

INSERT dbo.OrderDetail (orderHeaderId, productId, quantity, price, discount)
VALUES

(29, 4, 1, 4180000, 0.2),
(29, 18, 1, 2450000, 0.4),
(29, 15, 1, 2400000, 0.5),
(29, 27, 1, 3150000, 0.2),

(30, 11, 1, 2640000, 0.2),
(30, 26, 1, 1880000, 0.4),
(30, 6, 1, 3200000, 0.1),

(31, 19, 1, 2650000, 0.2),
(31, 21, 1, 3700000, 0.4),

(32, 14, 1, 1560000, 0.4),
(32, 13, 1, 4800000, 0.2),
(32, 20, 1, 2549000, 0.2),
(32, 36, 2, 4600000, 0.4),

(33, 39, 1, 1785000, 0.2),
(33, 40, 1, 1895000, 0.4),

(34, 35, 1, 2480000, 0.2),
(34, 23, 2, 6400000, 0.1),

(35, 30, 1, 2650000, 0.2),
(35, 12, 1, 3300000, 0.1),
(35, 27, 1, 3150000, 0.2)

GO

SET NOCOUNT OFF
raiserror('The PerfurmStore database in now ready for use.',0,1)
GO
