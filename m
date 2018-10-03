Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 11029 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 03 Oct 2018 15:40:08 UTC
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
	(mail-eopbgr80042.outbound.protection.outlook.com [40.107.8.42])
	by mail.openembedded.org (Postfix) with ESMTP id DF36D72EB7
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Oct 2018 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fW80SiNxtEn0KZF9pSdHb+9TNcSuaIufcaHqHmZNzo0=;
	b=m8oXh+DWt0R+wFUcYBkNbIaitvpWKuFc5diK6m7jhEz5RKvVUjSfnDoDHoTgzdN7VYZiv8C/sBaJcg2MpXOa0K7bU5mAgN/EAnDf377ur7enKk0rHvBw3yTx29hG7+CA6B+sQn6BpYzzN0pH0sYi+2cjYZUh0igRbkMgwHJKOVQ=
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com (52.135.135.148) by
	DB7PR03MB3625.eurprd03.prod.outlook.com (52.134.98.150) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1185.25; Wed, 3 Oct 2018 12:04:09 +0000
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb]) by
	DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb%3]) with mapi id 15.20.1185.026;
	Wed, 3 Oct 2018 12:04:09 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH 7/7] fetch2/git: provide information about missing sources
Thread-Index: AQHUWxExrqIkY2X8N0yjgVqDRXVShQ==
Date: Wed, 3 Oct 2018 12:04:09 +0000
Message-ID: <20181003120346.3523-8-urs.fassler@bbv.ch>
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
x-microsoft-exchange-diagnostics: 1; DB7PR03MB3625;
	6:Jg0KYe0XQHWu4Fv1IDEc7hC/DGRKQhdrCV9dLscE358GFUon05KglBMAZDKsyZfVR+NdosdAnrthBBZQPs/ss+6uuxW/L+LLSjaYrDa56V1XbFq13oEAEsIiDiRouaALQ719WL3ZnpxfG3ukChVhOkELdtlGeyfx5CLpLNii53wcRQ+BZ0O1ND8Humhdp0sD2sjgL7Hc2P2U07gOeJK5bJ9NGgfc0mkF5RMFqHTSI0kRgyvzJjLyloosGCfUPf8LLX/OfItFa732rBEkwsNUf9Qet2otZQzoGT8TqI8Yma5qcW0rddG3OpTg8rjK5IH3iz+uU3Eu2zdvwVQyvdGGcS3zMG1WTiylQw1X9waiKrk7zyccS1FG2jh6YynDAZvErvd3grQgECRgrTY2sqI9FUbbl1cEeZsaEjZzlkQeX6LzhnCjxE9rJb3ALZZos94CBn0Qfkv7sbaSehCk17/Odg==;
	5:BSqkhyzAbOrkMfBg8ylqrvHlRm0cGWX2ctRoCKI6plQpYi+WxkyIlsXzQBLmOfASNqy1hkr8c9pargMc+szQkQO4bmG5m9iaxLIqL+/RCv5wTM/s/kjZbmCifl17BatxrhHN3IH/C8ZYKCbf76VCc+kO9uz/EQzsKXyLYDs0OaQ=;
	7:zxT7WtMo2HW7Om3C5WHtdiqvSxqwUEixIdHu5zTRB0MEmMCt3HwEYidj/BvutggpTNQuOmXfmMfs2SDjgvgx0dRGMk8LZVmM/PNN47BJyspzveHXSJIoNjonQW4CDq++r4W/GDqC+nW1MqkvBTeGus9VmyvLJ27EQY40RFXHOePsLpDculI3K4rT0xm9IVmDDloLn9C9Re/BcQOtxgJWWKhmhd1OISalXMs5AINJjcY3aITe9u+Ovl8IoFLOjcUU
x-ms-office365-filtering-correlation-id: 2562eee3-7370-4fa0-c9eb-08d62928536d
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:DB7PR03MB3625; 
x-ms-traffictypediagnostic: DB7PR03MB3625:
x-microsoft-antispam-prvs: <DB7PR03MB3625233577DD6A1DB2E3D8618FE90@DB7PR03MB3625.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(181554191321653)(126837547833334)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);
	SRVR:DB7PR03MB3625; BCL:0; PCL:0; RULEID:; SRVR:DB7PR03MB3625; 
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(366004)(136003)(396003)(376002)(39840400004)(199004)(189003)(71200400001)(5660300001)(71190400001)(478600001)(5640700003)(54906003)(476003)(2906002)(2900100001)(99286004)(446003)(11346002)(85182001)(575784001)(6506007)(8936002)(386003)(97736004)(50226002)(66574008)(2616005)(81166006)(26005)(68736007)(86362001)(8676002)(74482002)(52116002)(305945005)(102836004)(33896004)(6916009)(36756003)(14454004)(2501003)(186003)(105586002)(25786009)(7736002)(81156014)(5250100002)(4326008)(66066001)(76176011)(53936002)(6486002)(256004)(316002)(1076002)(14444005)(6512007)(6436002)(85202003)(3846002)(106356001)(486006)(6116002)(2351001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR03MB3625;
	H:DB7PR03MB3834.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: HQ0ut5fNvmVRHSA4QcasiHlQJ8rrEiJXHIdTZVohShECbb5grfFktBBDEWgYzHQ5aXv+YT9+kYeorEIqgRAkYYoPiE2HXo5S5qZphO/xucPyzHihVcZ+inXLs1OWSkBcUR91GqeHlhwBEIc2eGCf76Atko5N+QQWWIXC6+eWD6KYvyKu/pxZNK+XWrMOh4P9r/SEuAMmTuzPuKFF8ZNxVV/7qh2vLmS2AexHSyjh79iXWTQ+WAKGQBnZvH1msC2uG1A38HnvwHFLxhinq9PUgZnbAGxpmcuJpYbp0XgY+HJKdIvU9Ymz133I2+9N0OTdnPan8mNJrODvw0kM55t2y+PteSVvPIu263O5Vuoigxo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 2562eee3-7370-4fa0-c9eb-08d62928536d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 12:04:09.7911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3625
Subject: [PATCH 7/7] fetch2/git: provide information about missing sources
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
X-List-Received-Date: Wed, 03 Oct 2018 15:40:09 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <75EBB763C8EEA849924D8B668E0E57E7@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

UHJvdmlkZSBtb3JlIGluZm9ybWF0aW9uIGluIHRoZSBjYXNlIHRoZSBzb3VyY2VzIGFyZSBub3Qg
Zm91bmQgaW4gdGhlDQp1bnBhY2sgc3RlcC4NCg0KU2lnbmVkLW9mZi1ieTogVXJzIEbDpHNzbGVy
IDx1cnMuZmFzc2xlckBiYnYuY2g+DQpTaWduZWQtb2ZmLWJ5OiBQYXNjYWwgQmFjaCA8cGFzY2Fs
LmJhY2hAc2llbWVucy5jb20+DQotLS0NCiBsaWIvYmIvZmV0Y2gyL2dpdC5weSAgfCAyOSArKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLQ0KIGxpYi9iYi90ZXN0cy9mZXRjaC5weSB8ICAyICsr
DQogMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvbGliL2JiL2ZldGNoMi9naXQucHkgYi9saWIvYmIvZmV0Y2gyL2dpdC5weQ0K
aW5kZXggMzMzYjg4OTMuLjUwYTU4MDE4IDEwMDY0NA0KLS0tIGEvbGliL2JiL2ZldGNoMi9naXQu
cHkNCisrKyBiL2xpYi9iYi9mZXRjaDIvZ2l0LnB5DQpAQCAtNDc2LDE0ICs0NzYsMjcgQEAgY2xh
c3MgR2l0KEZldGNoTWV0aG9kKToNCiAgICAgICAgIGlmIG9zLnBhdGguZXhpc3RzKGRlc3RkaXIp
Og0KICAgICAgICAgICAgIGJiLnV0aWxzLnBydW5lZGlyKGRlc3RkaXIpDQogDQotICAgICAgICBj
bG9uZWRpcl9pc191cF90b19kYXRlID0gbm90IHNlbGYuY2xvbmVkaXJfbmVlZF91cGRhdGUodWQs
IGQpDQotICAgICAgICBpZiBjbG9uZWRpcl9pc191cF90b19kYXRlOg0KLSAgICAgICAgICAgIHJ1
bmZldGNoY21kKCIlcyBjbG9uZSAlcyAlcy8gJXMiICUgKHVkLmJhc2VjbWQsIHVkLmNsb25lZmxh
Z3MsIHVkLmNsb25lZGlyLCBkZXN0ZGlyKSwgZCkNCi0gICAgICAgIGVsaWYgdWQuc2hhbGxvdyBh
bmQgb3MucGF0aC5leGlzdHModWQuZnVsbHNoYWxsb3cpOg0KLSAgICAgICAgICAgIGJiLnV0aWxz
Lm1rZGlyaGllcihkZXN0ZGlyKQ0KLSAgICAgICAgICAgIHJ1bmZldGNoY21kKCJ0YXIgLXh6ZiAl
cyIgJSB1ZC5mdWxsc2hhbGxvdywgZCwgd29ya2Rpcj1kZXN0ZGlyKQ0KLSAgICAgICAgZWxzZToN
Ci0gICAgICAgICAgICBiYi5mYXRhbCgibm8gdXAgdG8gZGF0ZSBzb3VyY2UgZm91bmQiKQ0KKyAg
ICAgICAgc291cmNlX2ZvdW5kID0gRmFsc2UNCisgICAgICAgIHNvdXJjZV9lcnJvciA9IFtdDQor
DQorICAgICAgICBpZiBub3Qgc291cmNlX2ZvdW5kOg0KKyAgICAgICAgICAgIGNsb25lZGlyX2lz
X3VwX3RvX2RhdGUgPSBub3Qgc2VsZi5jbG9uZWRpcl9uZWVkX3VwZGF0ZSh1ZCwgZCkNCisgICAg
ICAgICAgICBpZiBjbG9uZWRpcl9pc191cF90b19kYXRlOg0KKyAgICAgICAgICAgICAgICBydW5m
ZXRjaGNtZCgiJXMgY2xvbmUgJXMgJXMvICVzIiAlICh1ZC5iYXNlY21kLCB1ZC5jbG9uZWZsYWdz
LCB1ZC5jbG9uZWRpciwgZGVzdGRpciksIGQpDQorICAgICAgICAgICAgICAgIHNvdXJjZV9mb3Vu
ZCA9IFRydWUNCisgICAgICAgICAgICBlbHNlOg0KKyAgICAgICAgICAgICAgICBzb3VyY2VfZXJy
b3IuYXBwZW5kKCJjbG9uZSBkaXJlY3Rvcnkgbm90IGF2YWlsYWJsZSBvciBub3QgdXAgdG8gZGF0
ZTogIiArIHVkLmNsb25lZGlyKQ0KKw0KKyAgICAgICAgaWYgbm90IHNvdXJjZV9mb3VuZDoNCisg
ICAgICAgICAgICBpZiB1ZC5zaGFsbG93IGFuZCBvcy5wYXRoLmV4aXN0cyh1ZC5mdWxsc2hhbGxv
dyk6DQorICAgICAgICAgICAgICAgIGJiLnV0aWxzLm1rZGlyaGllcihkZXN0ZGlyKQ0KKyAgICAg
ICAgICAgICAgICBydW5mZXRjaGNtZCgidGFyIC14emYgJXMiICUgdWQuZnVsbHNoYWxsb3csIGQs
IHdvcmtkaXI9ZGVzdGRpcikNCisgICAgICAgICAgICAgICAgc291cmNlX2ZvdW5kID0gVHJ1ZQ0K
KyAgICAgICAgICAgIGVsc2U6DQorICAgICAgICAgICAgICAgIHNvdXJjZV9lcnJvci5hcHBlbmQo
InNoYWxsb3cgY2xvbmUgbm90IGVuYWJsZWQgb3Igbm90IGF2YWlsYWJsZTogIiArIHVkLmZ1bGxz
aGFsbG93KQ0KKw0KKyAgICAgICAgaWYgbm90IHNvdXJjZV9mb3VuZDoNCisgICAgICAgICAgICBi
Yi5mYXRhbCgibm8gdXAgdG8gZGF0ZSBzb3VyY2UgZm91bmQ6ICIgKyAiOyAiLmpvaW4oc291cmNl
X2Vycm9yKSkNCiANCiAgICAgICAgIHJlcG91cmwgPSBzZWxmLl9nZXRfcmVwb191cmwodWQpDQog
ICAgICAgICBydW5mZXRjaGNtZCgiJXMgcmVtb3RlIHNldC11cmwgb3JpZ2luICVzIiAlICh1ZC5i
YXNlY21kLCByZXBvdXJsKSwgZCwgd29ya2Rpcj1kZXN0ZGlyKQ0KZGlmZiAtLWdpdCBhL2xpYi9i
Yi90ZXN0cy9mZXRjaC5weSBiL2xpYi9iYi90ZXN0cy9mZXRjaC5weQ0KaW5kZXggNTZjMGMwZGIu
LmI1NWQxNDIxIDEwMDY0NA0KLS0tIGEvbGliL2JiL3Rlc3RzL2ZldGNoLnB5DQorKysgYi9saWIv
YmIvdGVzdHMvZmV0Y2gucHkNCkBAIC0xNTkzLDYgKzE1OTMsOCBAQCBjbGFzcyBHaXRTaGFsbG93
VGVzdChGZXRjaGVyVGVzdCk6DQogICAgICAgICAgICAgICAgIGZldGNoZXIudW5wYWNrKHNlbGYu
ZC5nZXRWYXIoJ1dPUktESVInKSkNCiANCiAgICAgICAgICAgICBzZWxmLmFzc2VydFRydWUobG9n
Q29udGFpbnMoIm5vIHVwIHRvIGRhdGUgc291cmNlIGZvdW5kIiwgbG9ncykpDQorICAgICAgICAg
ICAgc2VsZi5hc3NlcnRUcnVlKGxvZ0NvbnRhaW5zKCJjbG9uZSBkaXJlY3Rvcnkgbm90IGF2YWls
YWJsZSBvciBub3QgdXAgdG8gZGF0ZSIsIGxvZ3MpKQ0KKyAgICAgICAgICAgIHNlbGYuYXNzZXJ0
VHJ1ZShsb2dDb250YWlucygic2hhbGxvdyBjbG9uZSBub3QgZW5hYmxlZCBvciBub3QgYXZhaWxh
YmxlIiwgbG9ncykpDQogDQogICAgIEBza2lwSWZOb05ldHdvcmsoKQ0KICAgICBkZWYgdGVzdF90
aGF0X3VucGFja19kb2VzX3dvcmtfd2hlbl91c2luZ19naXRfc2hhbGxvd190YXJiYWxsX2J1dF90
YXJiYWxsX2lzX25vdF9hdmFpbGFibGUoc2VsZik6DQotLSANCjIuMTkuMA0KDQo=

