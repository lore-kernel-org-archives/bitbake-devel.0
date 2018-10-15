Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0084.outbound.protection.outlook.com [104.47.2.84])
	by mail.openembedded.org (Postfix) with ESMTP id 222C879479
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 19:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ZN3sYVZk/HMtAIHvrrEjuqTsj6fQS8ZV4rHcOBPXiU0=;
	b=SIU06ZsDtwKK7he5Yt3z8C4YlivMbzEMfm4Dojtw87z2rjKoZmSipDTrp1Jo2fRBNNbBxDRkx0+bCQaPAew8YikfNkO7sERdRDG4HIqi8rA6BTQg3IMKfMuIBMlll8Vc1Mo9umqMEG6GSnoIDOirdIHTP4TKrDwmD7k91oifUQ8=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB4421.eurprd03.prod.outlook.com (20.177.33.87) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1228.21; Mon, 15 Oct 2018 13:43:18 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::d882:426c:1de7:5c12%3]) with mapi id 15.20.1228.027;
	Mon, 15 Oct 2018 13:43:18 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH 1/7] fetch2/git: add tests to capture
	existing behavior wrt. naming of clone directories
Thread-Index: AQHUZI0HaKEQwATPjE+HrIz2mDvWjA==
Date: Mon, 15 Oct 2018 13:43:18 +0000
Message-ID: <20181015134255.4634-2-urs.fassler@bbv.ch>
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
	6:tsqC3sDPhT3bzSmqgtYHc4r6p+Cs+jziKQhUBDKgeyBy9ystMepNWw9Ldw2uOry9ZIg45L4HCN1jK7L6roaPq9qT5I7LJjQOYl8PG4ja4CG+XD1adVC2RxtUd/mk0r/g+39QDcOvtCksXLfyHyTWMmTVPndsCjITffqW9KqeCrZdMjHMr6eBg3AeMLPBLYl6RnLSIwZinfyA1lSvUyMWA8PXT186dHNAh45rmVNa2ORldohVpiW/lDub9fgIDV5fS0GzSO181rGMyvEViXsnNvVyooZDKAWb8WSxjCWyJPoIPb3jnSqZhTWXq7SeJ/bxzDJEsZ/zufaoSxX05VXJfyU7QXJiEe1BZw53PRgPlrlpSxObCtwiysnhBaBIWa6mie6O2BS/TozLQ657v/YMDluL6Eo3B1Dyjwbb+l9YHGR8oVlwy8s5gNCc3AXbBMmfBq0Nxv5BIPyhd0Hg3448dA==;
	5:yRAfzBjP1LyRDxAnjieUmQpDyipwttsI2lG5P34Fx60lVea5K/2jvZEF9VuOgjDTe5LgYjS5/TGLKTQ8xB0RLW3SnzXUWFd99TQtXW0mT2MeXNUAOJZ/7KpSQ7TYiWk22VFGPipImhdZnGjYZ9KEVeYVy9w5jbCovTYxQqNZQZs=;
	7:5gwXVe8hS9TX6gEc0T3qGe4+5ymKKzMCk24kaBjKyq1bNEv6dcI2axM/V+DM3zscyFeX1HWmrmsMM4x01vvywBKczH9WQ1GPVyFDn2gvJXR5wFwMptx6yn9YCJJDu7QotBHMilT+b/a176yKbUT2B8oaBjv5qUZcs4nHxkjrvO5AYSGV3R1IOw9fqPnuM34sMVt6EuYg56wUaeNRuWjfE8JhTY1h9DaTKcCLTDCC9KvbRJhFGBAESREqh2/TtV6E
x-ms-office365-filtering-correlation-id: 3b8fcd46-d60b-473c-b2b6-08d632a42a50
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4421; 
x-ms-traffictypediagnostic: AM6PR03MB4421:
x-microsoft-antispam-prvs: <AM6PR03MB4421BC5BC515CECE3D4189688FFD0@AM6PR03MB4421.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(126837547833334)(181554191321653)(33711482430040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(4982022)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);
	SRVR:AM6PR03MB4421; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4421; 
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(346002)(396003)(39840400004)(366004)(136003)(189003)(199004)(6436002)(86362001)(5640700003)(36756003)(74482002)(575784001)(6512007)(53936002)(6306002)(66066001)(26005)(102836004)(6116002)(3846002)(81166006)(8676002)(68736007)(2906002)(50226002)(6486002)(7736002)(8936002)(305945005)(81156014)(1076002)(6916009)(76176011)(99286004)(52116002)(256004)(33896004)(6506007)(386003)(186003)(1857600001)(105586002)(476003)(2616005)(446003)(11346002)(486006)(85202003)(106356001)(2900100001)(54906003)(2351001)(25786009)(85182001)(4326008)(316002)(5660300001)(14454004)(97736004)(2501003)(5250100002)(478600001)(71190400001)(71200400001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4421;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: /9Ff+5jrl4YpLxqKb9SOURz+mhx4Qqndqxl81AjsnzPGzO5KorExver5cEg8duRxeuit3OtDddprAQqbfadzOUVXy9d/3buGKHPjzPtchou7A3h338WXBFRhCQaufJtFQcjXb+7t4vz/NfTEZGSuGTS0WvIJpIzdXd/6jiXEF4ElVxXPHwEFQlvAK1n0bXU9K1h7kvz+CycUuUUfk8sBwdX8SEiT93Bxsp/ZgpxtkjkEftj+qiEJwwCDNnlg3OcqmCzgz/3uKIGXRwVe+TQGXqrZ5qNuWKOA6idKGLwrVlwbkxUHF03hsB4nC5kwy+2X5yFmBZX6MEr0y0VsZ18lMdYZUQBZ8qEOMebpqU9a0KQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8fcd46-d60b-473c-b2b6-08d632a42a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:43:18.8117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4421
Subject: [PATCH 1/7] fetch2/git: add tests to capture existing behavior wrt. naming of clone directories
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
X-List-Received-Date: Mon, 15 Oct 2018 19:16:44 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F3F76BA44B4CF40910C5F52FE22ED94@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

VGhlIG1hcHBpbmcgb2YgdGhlIFVSTHMgdG8gdGhlIGxvY2FsIGRpcmVjdG9yeSBpcyBub3Qgb2J2
aW91cy4gRm9yIGVhc2llcg0KdW5kZXJzdGFuZGluZywgd2UgYWRkIHRoaXMgdGVzdHMgdG8gZXhw
bGljaXRseSBzaG93aW5nIHRoZSBtYXBwaW5nLg0KDQpTaWduZWQtb2ZmLWJ5OiBVcnMgRsOkc3Ns
ZXIgPHVycy5mYXNzbGVyQGJidi5jaD4NClNpZ25lZC1vZmYtYnk6IFBhc2NhbCBCYWNoIDxwYXNj
YWwuYmFjaEBzaWVtZW5zLmNvbT4NCi0tLQ0KIGxpYi9iYi90ZXN0cy9mZXRjaC5weSB8IDQ5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdl
ZCwgNDkgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvbGliL2JiL3Rlc3RzL2ZldGNoLnB5
IGIvbGliL2JiL3Rlc3RzL2ZldGNoLnB5DQppbmRleCBmZjY2MzE1YS4uNTM1OTUzMTIgMTAwNjQ0
DQotLS0gYS9saWIvYmIvdGVzdHMvZmV0Y2gucHkNCisrKyBiL2xpYi9iYi90ZXN0cy9mZXRjaC5w
eQ0KQEAgLTQ2Myw2ICs0NjMsNTUgQEAgY2xhc3MgTWlycm9yVXJpVGVzdChGZXRjaGVyVGVzdCk6
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAnaHR0cHM6Ly9CQkJCL0IvQi9CL2Jp
dGJha2UvYml0YmFrZS0xLjAudGFyLmd6JywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICdodHRwOi8vQUFBQS9BL0EvQS9CL0IvYml0YmFrZS9iaXRiYWtlLTEuMC50YXIuZ3onXSkN
CiANCisNCitjbGFzcyBHaXREb3dubG9hZERpcmVjdG9yeU5hbWluZ1Rlc3QoRmV0Y2hlclRlc3Qp
Og0KKyAgICBkZWYgc2V0VXAoc2VsZik6DQorICAgICAgICBzdXBlcihHaXREb3dubG9hZERpcmVj
dG9yeU5hbWluZ1Rlc3QsIHNlbGYpLnNldFVwKCkNCisgICAgICAgIHNlbGYucmVjaXBlX3VybCA9
ICJnaXQ6Ly9naXQub3BlbmVtYmVkZGVkLm9yZy9iaXRiYWtlIg0KKyAgICAgICAgc2VsZi5yZWNp
cGVfZGlyID0gImdpdC5vcGVuZW1iZWRkZWQub3JnLmJpdGJha2UiDQorICAgICAgICBzZWxmLm1p
cnJvcl91cmwgPSAiZ2l0Oi8vZ2l0aHViLmNvbS9vcGVuZW1iZWRkZWQvYml0YmFrZS5naXQiDQor
ICAgICAgICBzZWxmLm1pcnJvcl9kaXIgPSAiZ2l0aHViLmNvbS5vcGVuZW1iZWRkZWQuYml0YmFr
ZS5naXQiDQorDQorICAgICAgICBzZWxmLmQuc2V0VmFyKCdTUkNSRVYnLCAnODJlYTczN2EwYjQy
YThiNTNlMTFjOWNkZTE0MWU5ZTljMGJkOGM0MCcpDQorDQorICAgIGRlZiBzZXR1cF9taXJyb3Jf
cmV3cml0ZShzZWxmKToNCisgICAgICAgIHNlbGYuZC5zZXRWYXIoIlBSRU1JUlJPUlMiLCBzZWxm
LnJlY2lwZV91cmwgKyAiICIgKyBzZWxmLm1pcnJvcl91cmwgKyAiIFxuIikNCisNCisgICAgQHNr
aXBJZk5vTmV0d29yaygpDQorICAgIGRlZiB0ZXN0X3RoYXRfZGlyZWN0b3J5X2lzX25hbWVkX2Fm
dGVyX3JlY2lwZV91cmxfd2hlbl9ub19taXJyb3JpbmdfaXNfdXNlZChzZWxmKToNCisgICAgICAg
IHNlbGYuc2V0dXBfbWlycm9yX3Jld3JpdGUoKQ0KKyAgICAgICAgZmV0Y2hlciA9IGJiLmZldGNo
LkZldGNoKFtzZWxmLnJlY2lwZV91cmxdLCBzZWxmLmQpDQorDQorICAgICAgICBmZXRjaGVyLmRv
d25sb2FkKCkNCisNCisgICAgICAgIGRpciA9IG9zLmxpc3RkaXIoc2VsZi5kbGRpciArICIvZ2l0
MiIpDQorICAgICAgICBzZWxmLmFzc2VydEluKHNlbGYucmVjaXBlX2RpciwgZGlyKQ0KKw0KKyAg
ICBAc2tpcElmTm9OZXR3b3JrKCkNCisgICAgZGVmIHRlc3RfdGhhdF9kaXJlY3RvcnlfZXhpc3Rz
X2Zvcl9taXJyb3JlZF91cmxfYW5kX3JlY2lwZV91cmxfd2hlbl9taXJyb3JpbmdfaXNfdXNlZChz
ZWxmKToNCisgICAgICAgIHNlbGYuc2V0dXBfbWlycm9yX3Jld3JpdGUoKQ0KKyAgICAgICAgZmV0
Y2hlciA9IGJiLmZldGNoLkZldGNoKFtzZWxmLnJlY2lwZV91cmxdLCBzZWxmLmQpDQorDQorICAg
ICAgICBmZXRjaGVyLmRvd25sb2FkKCkNCisNCisgICAgICAgIGRpciA9IG9zLmxpc3RkaXIoc2Vs
Zi5kbGRpciArICIvZ2l0MiIpDQorICAgICAgICBzZWxmLmFzc2VydEluKHNlbGYubWlycm9yX2Rp
ciwgZGlyKQ0KKyAgICAgICAgc2VsZi5hc3NlcnRJbihzZWxmLnJlY2lwZV9kaXIsIGRpcikNCisN
CisgICAgQHNraXBJZk5vTmV0d29yaygpDQorICAgIGRlZiB0ZXN0X3RoYXRfcmVjaXBlX2RpcmVj
dG9yeV9hbmRfbWlycm9yZWRfZGlyZWN0b3J5X2V4aXN0c193aGVuX21pcnJvcmluZ19pc191c2Vk
X2FuZF90aGVfbWlycm9yZWRfZGlyZWN0b3J5X2FscmVhZHlfZXhpc3RzKHNlbGYpOg0KKyAgICAg
ICAgc2VsZi5zZXR1cF9taXJyb3JfcmV3cml0ZSgpDQorICAgICAgICBmZXRjaGVyID0gYmIuZmV0
Y2guRmV0Y2goW3NlbGYubWlycm9yX3VybF0sIHNlbGYuZCkNCisgICAgICAgIGZldGNoZXIuZG93
bmxvYWQoKQ0KKyAgICAgICAgZmV0Y2hlciA9IGJiLmZldGNoLkZldGNoKFtzZWxmLnJlY2lwZV91
cmxdLCBzZWxmLmQpDQorDQorICAgICAgICBmZXRjaGVyLmRvd25sb2FkKCkNCisNCisgICAgICAg
IGRpciA9IG9zLmxpc3RkaXIoc2VsZi5kbGRpciArICIvZ2l0MiIpDQorICAgICAgICBzZWxmLmFz
c2VydEluKHNlbGYubWlycm9yX2RpciwgZGlyKQ0KKyAgICAgICAgc2VsZi5hc3NlcnRJbihzZWxm
LnJlY2lwZV9kaXIsIGRpcikNCisNCisNCiBjbGFzcyBGZXRjaGVyTG9jYWxUZXN0KEZldGNoZXJU
ZXN0KToNCiAgICAgZGVmIHNldFVwKHNlbGYpOg0KICAgICAgICAgZGVmIHRvdWNoKGZuKToNCi0t
IA0KMi4xOS4xDQoNCg==

