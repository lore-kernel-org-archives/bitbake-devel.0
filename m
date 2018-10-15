Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0070.outbound.protection.outlook.com [104.47.2.70])
	by mail.openembedded.org (Postfix) with ESMTP id 197D660064
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 13:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=vH8QmRLe3JybH2VgVO4/E6GWXoxbJrDSApI9AS94exg=;
	b=qaD/3jT+SdSP5pO7kcB/wumQvVtMOW2jfegATz06GheuhTI79u0DrHQ1CUXpCwRBqoYnaBBIueY95DS/boHH1NRtanS7Hb+QGebTUt5/DGPYNMTAnVLIBd8ANqZ6dYsIaTwOm+hwkQ1QvyL3y7t+emsVKywfl8JYRNwaOWdrdeo=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB4421.eurprd03.prod.outlook.com (20.177.33.87) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1228.21; Mon, 15 Oct 2018 13:43:19 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12%3]) with mapi id 15.20.1228.027;
	Mon, 15 Oct 2018 13:43:19 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH 2/7] fetch2/git: add tests to capture
	existing behavior wrt. naming of mirror tarball
Thread-Index: AQHUZI0I+qLCvVeEw060avkyMEMo4A==
Date: Mon, 15 Oct 2018 13:43:19 +0000
Message-ID: <20181015134255.4634-3-urs.fassler@bbv.ch>
References: <20181015134255.4634-1-urs.fassler@bbv.ch>
In-Reply-To: <20181015134255.4634-1-urs.fassler@bbv.ch>
Accept-Language: de-CH, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.19.1
x-clientproxiedby: VI1PR09CA0095.eurprd09.prod.outlook.com
	(2603:10a6:803:78::18) To AM6PR03MB3832.eurprd03.prod.outlook.com
	(2603:10a6:20b:24::26)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.160.33.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR03MB4421;
	6:RoWWn1mJvyxiPaF60vwXCRuQPE4QmlZ/Y+ldpcLbEGxN2FwQBznNVDl+WJ4x2MNKpipYoyqyPDzsIc59ApAINQUwpygkvd/Y27wT8FvLPEkKm9Dd16d0Ml1YI4jgxUl9eCRXLE20CZFgLpR6xSJBD0Ou+0kvZqMb0jdSQr/fQ0x8cH4WDF4FTCDU00ciK7o9eym1ayjXyRlzjguG85g5zMzgzDbCxCwp5SlUZYYZOr+84OxlSi4uVLTvRnJMHbmOKVGyTkxnaBZOd9WfUMdW6ozUmR59j1Z/IWL1zgHP1LZfyY+qJtzz1fxpddBnGuNrmhOORJ1tTltd5NebFIzOE5/CyWArJAZadPrvKk+f9KMifJl0eCttdUSFSie2Jcasd9qih21jmZurYX+NYZuXQv03B7UAXO3yzxdkFP4Ft628Dr7/YSc9kM2+/X09dgkqXpBhxtUVFQDNiKN6nK1KXw==;
	5:7aJ41/ODhVfbgxglQorLeBhRfbNxLlI64Jd4bO9nZl82m56c8KwSlqdOxXFDYzW+Z90YDfuos+4WgEXEVuYgjTgY3ABRmxV6rUGnS1cm53E5e0vpYRM/ya1bek9YCCkR5PZNhiFRdxIi+mIECvBAmxC+W6YcSgGq1cVCMsrPbKg=;
	7:97MwnGSn239Gwxdtn4YukxEjFZC7/Bq2M64v61qusRmJpn0L7aXTHUt7EqtQ//5GH/9aV3s6WP3IObxQJSdJrfia8Xq2J06oByHdj6u+Rk/7AtRiIfHsVzhac4WigwUl6bzsNtlXn3JhOGcX+TbqzYEUTCdvtMjBjrJADYzlKA7qk0W67qN8mtNKGRkb0idnX1kA9dgSSUH7Pn0/H5hjlUCHi8DGABJbKOqAZALYbCHWJ5t/yKdmMf0DgC9RFFbe
x-ms-office365-filtering-correlation-id: e573d2c5-a30a-43dd-fddb-08d632a42a9c
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4421; 
x-ms-traffictypediagnostic: AM6PR03MB4421:
x-microsoft-antispam-prvs: <AM6PR03MB44211326F18862E7543B58D38FFD0@AM6PR03MB4421.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(126837547833334)(181554191321653)(33711482430040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);
	SRVR:AM6PR03MB4421; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4421; 
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(346002)(396003)(39840400004)(366004)(136003)(189003)(199004)(6436002)(86362001)(5640700003)(36756003)(74482002)(575784001)(6512007)(53936002)(66066001)(26005)(102836004)(6116002)(3846002)(81166006)(8676002)(68736007)(2906002)(50226002)(6486002)(7736002)(8936002)(305945005)(81156014)(1076002)(6916009)(76176011)(99286004)(52116002)(256004)(33896004)(6506007)(386003)(186003)(1857600001)(105586002)(476003)(2616005)(446003)(11346002)(486006)(85202003)(106356001)(2900100001)(54906003)(2351001)(25786009)(85182001)(4326008)(316002)(5660300001)(14454004)(97736004)(2501003)(5250100002)(478600001)(71190400001)(71200400001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4421;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: rid+O1m12buNv9i5jiP3XMOre8i+OckwrG2OX5+KqUrTwwOcyCUO9fmfWbi5fTYh+SPf9AiBSvHPq9XHCftFR4L8TEi5kizaHXZb2O4i4oyhCZsc7ANc1NSnc23Qu59PCcjALVJwgx/Cxnagcv4R4W2o6CxwvDB1mCzqLFyTTmn6U0/h5c2TJyYtSBPFTPIk8LccihVM2A+bkCXI/nwl7ANLrp80CF8CBJpNVHUfKlb130t+l7af0XXM3cTO55zS0dapOS9tVD8vZU3WU2CQGnczgd+gqgfe1tgDjseKDMgZ5xKw8gtfAXH0yTnYjyhxKbPEaCXpSkAB8w1FeQaYDxoRZsoebj5DaVUd1Nrf0fI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: e573d2c5-a30a-43dd-fddb-08d632a42a9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:43:19.3273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4421
Subject: [PATCH 2/7] fetch2/git: add tests to capture existing behavior wrt. naming of mirror tarball
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
X-List-Received-Date: Mon, 15 Oct 2018 13:59:12 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <18B12B846CE7D143814A4DDA7A2C89DA@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

VGhlIG1hcHBpbmcgb2YgdGhlIFVSTHMgdG8gdGhlIGxvY2FsIHRhcmJhbGxzIGlzIG5vdCBvYnZp
b3VzLiBGb3IgZWFzaWVyDQp1bmRlcnN0YW5kaW5nLCB3ZSBhZGQgdGhpcyB0ZXN0cyB0byBleHBs
aWNpdGx5IHNob3dpbmcgdGhlIG1hcHBpbmcuDQoNClNpZ25lZC1vZmYtYnk6IFVycyBGw6Rzc2xl
ciA8dXJzLmZhc3NsZXJAYmJ2LmNoPg0KU2lnbmVkLW9mZi1ieTogUGFzY2FsIEJhY2ggPHBhc2Nh
bC5iYWNoQHNpZW1lbnMuY29tPg0KLS0tDQogbGliL2JiL3Rlc3RzL2ZldGNoLnB5IHwgMzQgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9saWIvYmIvdGVzdHMvZmV0Y2gucHkgYi9saWIvYmIv
dGVzdHMvZmV0Y2gucHkNCmluZGV4IDUzNTk1MzEyLi5kY2M0ZDhjZSAxMDA2NDQNCi0tLSBhL2xp
Yi9iYi90ZXN0cy9mZXRjaC5weQ0KKysrIGIvbGliL2JiL3Rlc3RzL2ZldGNoLnB5DQpAQCAtNTEy
LDYgKzUxMiw0MCBAQCBjbGFzcyBHaXREb3dubG9hZERpcmVjdG9yeU5hbWluZ1Rlc3QoRmV0Y2hl
clRlc3QpOg0KICAgICAgICAgc2VsZi5hc3NlcnRJbihzZWxmLnJlY2lwZV9kaXIsIGRpcikNCiAN
CiANCitjbGFzcyBUYXJiYWxsTmFtaW5nVGVzdChGZXRjaGVyVGVzdCk6DQorICAgIGRlZiBzZXRV
cChzZWxmKToNCisgICAgICAgIHN1cGVyKFRhcmJhbGxOYW1pbmdUZXN0LCBzZWxmKS5zZXRVcCgp
DQorICAgICAgICBzZWxmLnJlY2lwZV91cmwgPSAiZ2l0Oi8vZ2l0Lm9wZW5lbWJlZGRlZC5vcmcv
Yml0YmFrZSINCisgICAgICAgIHNlbGYucmVjaXBlX3RhcmJhbGwgPSAiZ2l0Ml9naXQub3BlbmVt
YmVkZGVkLm9yZy5iaXRiYWtlLnRhci5neiINCisgICAgICAgIHNlbGYubWlycm9yX3VybCA9ICJn
aXQ6Ly9naXRodWIuY29tL29wZW5lbWJlZGRlZC9iaXRiYWtlLmdpdCINCisgICAgICAgIHNlbGYu
bWlycm9yX3RhcmJhbGwgPSAiZ2l0Ml9naXRodWIuY29tLm9wZW5lbWJlZGRlZC5iaXRiYWtlLmdp
dC50YXIuZ3oiDQorDQorICAgICAgICBzZWxmLmQuc2V0VmFyKCdCQl9HRU5FUkFURV9NSVJST1Jf
VEFSQkFMTFMnLCAnMScpDQorICAgICAgICBzZWxmLmQuc2V0VmFyKCdTUkNSRVYnLCAnODJlYTcz
N2EwYjQyYThiNTNlMTFjOWNkZTE0MWU5ZTljMGJkOGM0MCcpDQorDQorICAgIGRlZiBzZXR1cF9t
aXJyb3JfcmV3cml0ZShzZWxmKToNCisgICAgICAgIHNlbGYuZC5zZXRWYXIoIlBSRU1JUlJPUlMi
LCBzZWxmLnJlY2lwZV91cmwgKyAiICIgKyBzZWxmLm1pcnJvcl91cmwgKyAiIFxuIikNCisNCisg
ICAgQHNraXBJZk5vTmV0d29yaygpDQorICAgIGRlZiB0ZXN0X3RoYXRfdGhlX3JlY2lwZV90YXJi
YWxsX2lzX2NyZWF0ZWRfd2hlbl9ub19taXJyb3JpbmdfaXNfdXNlZChzZWxmKToNCisgICAgICAg
IGZldGNoZXIgPSBiYi5mZXRjaC5GZXRjaChbc2VsZi5yZWNpcGVfdXJsXSwgc2VsZi5kKQ0KKw0K
KyAgICAgICAgZmV0Y2hlci5kb3dubG9hZCgpDQorDQorICAgICAgICBkaXIgPSBvcy5saXN0ZGly
KHNlbGYuZGxkaXIpDQorICAgICAgICBzZWxmLmFzc2VydEluKHNlbGYucmVjaXBlX3RhcmJhbGws
IGRpcikNCisNCisgICAgQHNraXBJZk5vTmV0d29yaygpDQorICAgIGRlZiB0ZXN0X3RoYXRfdGhl
X21pcnJvcl90YXJiYWxsX2lzX2NyZWF0ZWRfd2hlbl9taXJyb3JpbmdfaXNfdXNlZChzZWxmKToN
CisgICAgICAgIHNlbGYuc2V0dXBfbWlycm9yX3Jld3JpdGUoKQ0KKyAgICAgICAgZmV0Y2hlciA9
IGJiLmZldGNoLkZldGNoKFtzZWxmLnJlY2lwZV91cmxdLCBzZWxmLmQpDQorDQorICAgICAgICBm
ZXRjaGVyLmRvd25sb2FkKCkNCisNCisgICAgICAgIGRpciA9IG9zLmxpc3RkaXIoc2VsZi5kbGRp
cikNCisgICAgICAgIHNlbGYuYXNzZXJ0SW4oc2VsZi5taXJyb3JfdGFyYmFsbCwgZGlyKQ0KKw0K
Kw0KIGNsYXNzIEZldGNoZXJMb2NhbFRlc3QoRmV0Y2hlclRlc3QpOg0KICAgICBkZWYgc2V0VXAo
c2VsZik6DQogICAgICAgICBkZWYgdG91Y2goZm4pOg0KLS0gDQoyLjE5LjENCg0K

