Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 19854 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 03 Oct 2018 17:35:02 UTC
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
	(mail-eopbgr10087.outbound.protection.outlook.com [40.107.1.87])
	by mail.openembedded.org (Postfix) with ESMTP id D21CC74B02
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Oct 2018 17:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=zkeRfpbhoFN1yROfUlKlEH/IzLTPN+/2KyB7uEW2eyk=;
	b=QexWc0nXSQi4lFkupSxxASbDptYZTMxUImCMBX+R3UUMHUI0Fxpp03i0bBxBzJBvywpdzq/88Bg/W9A6OMCSByrb8GRtm1GPGKR6ypErRKSpjzL2woDl7I8mGehJMN8wEkRSFTD8G19Bmo9NLMRqSZ4+4gbfRM+Y39/xD1S8MD0=
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com (52.135.135.148) by
	DB7PR03MB3754.eurprd03.prod.outlook.com (52.134.99.31) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1207.18; Wed, 3 Oct 2018 12:04:07 +0000
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb]) by
	DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb%3]) with mapi id 15.20.1185.026;
	Wed, 3 Oct 2018 12:04:07 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH 3/7] fetch2/git: use correct check to decide if the
	shallow tarball should be unpacked
Thread-Index: AQHUWxEvZu+eb1uaVE2zEpHaCNGguQ==
Date: Wed, 3 Oct 2018 12:04:07 +0000
Message-ID: <20181003120346.3523-4-urs.fassler@bbv.ch>
References: <20181003120346.3523-1-urs.fassler@bbv.ch>
In-Reply-To: <20181003120346.3523-1-urs.fassler@bbv.ch>
Accept-Language: de-CH, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.19.0
x-clientproxiedby: VI1PR0102CA0083.eurprd01.prod.exchangelabs.com
	(2603:10a6:803:15::24) To DB7PR03MB3834.eurprd03.prod.outlook.com
	(2603:10a6:5:30::20)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.160.33.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB7PR03MB3754;
	6:l5deOqkhqcG/8BE8AxhzrVCA5RPrHygM/BrZaj/Wr2F+G37C2c96QEfm/d2N1ZOc4o3XCtNZChwU5n2LOeRsTW9oXlrgOdZhPrQ65r5VgLOs8Y2or3euS5JAiZHd8HSdfQKNZrlQVa8TfMXtWEmcyRNb8Q3choRhOxmU2idLxN2TIcTX4X1ZMq9VQYARhzjnJ+33wmobCKowFqJq1IMIL9jsE3w+K8n5T45AvUewlbXgLswxeZqIBgevDao6fotYYnM1ilbGHhKHHSIDlw5mpUQOzGqaUF7TVP4+TT25FCqunkNhvUu2ajAG6G2c+oD2YR3HEn2EFhGKvLi/b5+JkzbcjeUTBsXK/VC8rhAhJe5vPuHaPN5qyqJf32VqUu3zLT/z4cqLZ6QMd9p9+EQRBO6hakNo5WdTVZthmEkgSlahGxgomvZSpysA1pmBewVx55YhUsA+Z6c5Out+kxFmQQ==;
	5:M/7FtGPcq06A737WBjHMWXsqa2xdNZsKtW0JXunpJqvu1qh/OLqMvfcPXKvRgWXSHNB1zhV7VHe7oGdU3DZnW0PKgwYq18TgINM9jhgNpGCg4zk3EW2wK6zbCGRSuHj4mU/m+TZL5xGrj/o0wiUFtOTe2jFkvDi9Vgt0E1dVfzs=;
	7:D7RSpavQSrD71kjqCmzvRVdyXelu4b5pvH5RaprHCwUbpvNUX4aIHM22HjBR45Tj4RGEMqiI4RaHfMg7GbtAN5usXLoKqVWRW6tuII7hGjQLVSVPyMHEQftH0bNMe0qV1nBcR9p18Ui1/Eun5Cm6JyLQlfIZ1VXSOr/oyORHXoA/CWw/63rFFQRywRPlRh9MUW+z5XXdMLvVZpoGJFUpI11kZsv0uiMRESqn9uF0kVnUVBdWeTSY0wc7YlmXom91
x-ms-office365-filtering-correlation-id: b7b6ae73-13c5-43e8-37bd-08d6292851ec
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:DB7PR03MB3754; 
x-ms-traffictypediagnostic: DB7PR03MB3754:
x-microsoft-antispam-prvs: <DB7PR03MB37546049580B0C6618A750298FE90@DB7PR03MB3754.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(181554191321653)(126837547833334)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);
	SRVR:DB7PR03MB3754; BCL:0; PCL:0; RULEID:; SRVR:DB7PR03MB3754; 
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(346002)(366004)(39840400004)(376002)(136003)(189003)(199004)(6486002)(476003)(2616005)(6436002)(86362001)(6916009)(5640700003)(2900100001)(54906003)(74482002)(5660300001)(14444005)(8936002)(81156014)(50226002)(68736007)(256004)(6512007)(99286004)(53936002)(66574008)(52116002)(36756003)(11346002)(33896004)(305945005)(386003)(6506007)(486006)(76176011)(7736002)(25786009)(71200400001)(446003)(6116002)(2906002)(81166006)(2501003)(14454004)(4326008)(186003)(26005)(85182001)(71190400001)(5250100002)(102836004)(106356001)(105586002)(2351001)(97736004)(85202003)(8676002)(66066001)(1076002)(478600001)(316002)(3846002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR03MB3754;
	H:DB7PR03MB3834.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: zoVVIY4T2tn1CE1X+Z7sKcV0Cxr0whBrjYN0gZ692k4vk6KtU6B30Q0XlSG9cGBldlg+luQCH+PSsbiF8FQBjryAaNCYAmNUvEOlgLGr2zo3d7oK351HFrCM6GJ7HTmr6/1rlZu/kyEkFboOqhyTf3GQQpfJovyGSLgUFo7mkJ9vQDdok1HI9r4OfgHWANO9huU6ydZlBTtrXzvHrdwfvrXl5GcetMlKD3ZRgEkXRPpn7TPqZU3bwiASd7iqqljHMgch3OHmLuyxOfEMJanrKbP+DhOZYO3sfjFbaruFl689shqxEhIzfNI85IMv3AHubQWS/2tSvN2l6V5p2m/+w+tpZcHtJYqlg6GpK8JvVwg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b6ae73-13c5-43e8-37bd-08d6292851ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 12:04:07.2552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3754
Subject: [PATCH 3/7] fetch2/git: use correct check to decide if the shallow tarball should be unpacked
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 03 Oct 2018 17:35:03 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <332679F650B9004E912157F2877C69AB@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

VGhlIHNoYWxsb3dfdGFyYmFsbCBjaGVjayBpcyBuZXZlciB0cnVlIGR1ZSBhIGNoZWNrIG9uIHRo
ZSBjYWxsZXIgc2lkZS4NClRoZSB0YXJiYWxsIGNoZWNrIGlzIG5vdCByZWxhdGVkIHRvIHRoZSBj
b2RlIG9uIHRoZSBjYWxsZXIgc2lkZS4NCg0KU2lnbmVkLW9mZi1ieTogVXJzIEbDpHNzbGVyIDx1
cnMuZmFzc2xlckBiYnYuY2g+DQpTaWduZWQtb2ZmLWJ5OiBQYXNjYWwgQmFjaCA8cGFzY2FsLmJh
Y2hAc2llbWVucy5jb20+DQotLS0NCiBsaWIvYmIvZmV0Y2gyL2dpdC5weSB8IDIgKy0NCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBh
L2xpYi9iYi9mZXRjaDIvZ2l0LnB5IGIvbGliL2JiL2ZldGNoMi9naXQucHkNCmluZGV4IDYzYzQz
M2E0Li5mMTNhMjVmOSAxMDA2NDQNCi0tLSBhL2xpYi9iYi9mZXRjaDIvZ2l0LnB5DQorKysgYi9s
aWIvYmIvZmV0Y2gyL2dpdC5weQ0KQEAgLTQ3Niw3ICs0NzYsNyBAQCBjbGFzcyBHaXQoRmV0Y2hN
ZXRob2QpOg0KICAgICAgICAgaWYgb3MucGF0aC5leGlzdHMoZGVzdGRpcik6DQogICAgICAgICAg
ICAgYmIudXRpbHMucHJ1bmVkaXIoZGVzdGRpcikNCiANCi0gICAgICAgIGlmIHVkLnNoYWxsb3cg
YW5kIG9zLnBhdGguZXhpc3RzKHVkLmZ1bGxzaGFsbG93KSBhbmQgc2VsZi5uZWVkX3VwZGF0ZSh1
ZCwgZCk6DQorICAgICAgICBpZiB1ZC5zaGFsbG93IGFuZCBvcy5wYXRoLmV4aXN0cyh1ZC5mdWxs
c2hhbGxvdykgYW5kIHNlbGYuY2xvbmVkaXJfbmVlZF91cGRhdGUodWQsIGQpOg0KICAgICAgICAg
ICAgIGJiLnV0aWxzLm1rZGlyaGllcihkZXN0ZGlyKQ0KICAgICAgICAgICAgIHJ1bmZldGNoY21k
KCJ0YXIgLXh6ZiAlcyIgJSB1ZC5mdWxsc2hhbGxvdywgZCwgd29ya2Rpcj1kZXN0ZGlyKQ0KICAg
ICAgICAgZWxzZToNCi0tIA0KMi4xOS4wDQoNCg==

