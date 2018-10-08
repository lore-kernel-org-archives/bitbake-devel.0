Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 3590 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 08 Oct 2018 09:47:52 UTC
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0057.outbound.protection.outlook.com [104.47.2.57])
	by mail.openembedded.org (Postfix) with ESMTP id 2914876068
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Oct 2018 09:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=8WFdSPFmYOUCKLlcvfQlELp5RJBfxLd534QKkOHOrg0=;
	b=JH5a3AceO8vV1H01qQ6u1thZdu3AP1UI6XO2Ap6BYoJSJRitoh0EFIYlWBxZ7S5Ps9GSIzVjkRumPUVKGjzlxqmjQ8THPHu0w3T86Q3oOVjJQaNZHueEZ9knhcTOGauYD3hmL00x9ygU6FoXsajXgMm/tBWD8SxCpfB2h+QwStY=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB4488.eurprd03.prod.outlook.com (20.177.34.11) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1207.18; Mon, 8 Oct 2018 08:15:12 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::4117:4dd2:d53a:645b]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::4117:4dd2:d53a:645b%4]) with mapi id 15.20.1207.024;
	Mon, 8 Oct 2018 08:15:12 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH v2 3/3] fetch2/git: provide information
	about missing sources
Thread-Index: AQHUXt8JqKzjn79lRkG2W53KADFswA==
Date: Mon, 8 Oct 2018 08:15:12 +0000
Message-ID: <20181008081455.16384-4-urs.fassler@bbv.ch>
References: <20181008081455.16384-1-urs.fassler@bbv.ch>
In-Reply-To: <20181008081455.16384-1-urs.fassler@bbv.ch>
Accept-Language: de-CH, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.19.0
x-clientproxiedby: HE1PR07CA0012.eurprd07.prod.outlook.com
	(2603:10a6:7:67::22) To AM6PR03MB3832.eurprd03.prod.outlook.com
	(2603:10a6:20b:24::26)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.194.183.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR03MB4488;
	6:YVaIyJO7fayqai0oSJmBfXCcGZ0gFenx4bNhfKxecUIRywQ1ulw0Kbof3XGUhoaWc17GE4TwCNcZ/cTmgj4mukSRZ0flv4HWFdYwmVgu28KxE7tCIufkifKJ9nkKOj9YMiqVeH7+hzAZjJu2ORBPI39LQYMK1zAAQF+6wBVhdJXJj09IngHj7esaPFDlDbTeJhCvA+84jXjYaArZdGH36x1KVbDBpEfxbdUVkGuI9bkIo/NyYsFVa+L9hTMpnKn4kuhp2u90NGrhLDbDApqoRDuT+hFBIatoy8kGxyCVyDeGDkusbMsXPcCF6l0Tl4pJ1pOTiNPRi/S5F4BDZfr1IPh3eeoc03WmfHGclhNv32rFL2ibEFyNm4Se2xvRxHGSqxvDeIvzCVknSHJ372sxoJzTuFdy4LJqietAwa3Gro6IhxaqQ+BXZHK5cLUoU2pAQ0StZ84M1GJmWlpiWPq/wQ==;
	5:uKyT0Uv0x11eUTT+zPZQb5h72NGwfRGCEn5WJeLB+7cm6zIJP2qkRmqcQ9KVPjutzjhGyErFMjaf4XJOYg8rb7JlnWkPy+e0YE8hnWf2HfC27bRkUfZV5sDgdR+OZKiXncRTV+X2QpqcWkIIYfd30C6MQ2N+/LHBmSWbjgqnwu0=;
	7:9mF0vD9AdpZVAKU2N4oc0Pk1t0jkmsSyhiyxE6fUSpUXY6a4soe6zZrL/zIzSGgDHOt7BCQaf7zjjLD08NfhlO+RnWxJGRBwgzhnedEfinPQffsSx4QX4ihA4lKilA+fHs/kHr+UdqAxns0E/HPKhNH9rGqHJyooZNhEcnJV8+zAABBrmix9CioyQZfdU8rnpkrBJL3MdXWvoaTwA6Uu0EXVm6YHhy35/Ymit+0cX1YEDmUwLiKVNdpTC/3/nMAO
x-ms-office365-filtering-correlation-id: 440b4dc0-0554-48d1-f063-08d62cf62b63
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4488; 
x-ms-traffictypediagnostic: AM6PR03MB4488:
x-microsoft-antispam-prvs: <AM6PR03MB4488EBFD477540F1ACCDC1B08FE60@AM6PR03MB4488.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(126837547833334)(181554191321653)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991055);
	SRVR:AM6PR03MB4488; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4488; 
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(39840400004)(396003)(376002)(346002)(136003)(189003)(199004)(14444005)(2501003)(6486002)(25786009)(8676002)(6436002)(478600001)(5640700003)(6116002)(256004)(3846002)(1076002)(99286004)(2906002)(8936002)(105586002)(2351001)(2900100001)(54906003)(81156014)(81166006)(71190400001)(71200400001)(85202003)(106356001)(5250100002)(5660300001)(6916009)(1857600001)(2616005)(36756003)(305945005)(85182001)(50226002)(7736002)(66066001)(6506007)(386003)(102836004)(66574009)(68736007)(186003)(26005)(74482002)(97736004)(86362001)(486006)(52116002)(4326008)(53936002)(76176011)(11346002)(446003)(6512007)(316002)(476003)(14454004)(33896004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4488;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: IGgZ/EeXeFqJVKe7PXgb8TTvttAwXeMoMq9GtBGUlvL2Y7ANiKNAKdChOJZsTMr+g5ESSWMqi+8hZwPTiNRNSQ3Uks+bFEuI4ZV4N/2/gzQ1y4c0Ud6vzS4gH7eik5717AW8xWhSyKFKHprH8EqYFBOexrKBXwgndQ9Dd44OR3uPyWVSBhpTbfnmYH+JTm/Whlqm+OlIz3J1E5u7kDZ2bRLlgmyEf0f0rnTiuAOKk+O1ep/P1e2JNWHGDg59Tdzh1jclprl0F69faqZvUTJ5b0IRFU65JdVg851rD4gUz+Gg0OwIcaDlRT4g/jvAXcDi2J6glFSSETdO1bOn8lTDiXnwVTdU0eXs1kmGTK2zVOM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 440b4dc0-0554-48d1-f063-08d62cf62b63
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 08:15:12.3852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4488
Subject: [PATCH v2 3/3] fetch2/git: provide information about missing sources
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
X-List-Received-Date: Mon, 08 Oct 2018 09:47:53 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE5A58D762CF6F43A628DE26CBDAAF6E@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

UHJvdmlkZSBtb3JlIGluZm9ybWF0aW9uIGluIHRoZSBjYXNlIHRoZSBzb3VyY2VzIGFyZSBub3Qg
Zm91bmQgaW4gdGhlDQp1bnBhY2sgc3RlcC4NCg0KU2lnbmVkLW9mZi1ieTogVXJzIEbDpHNzbGVy
IDx1cnMuZmFzc2xlckBiYnYuY2g+DQpTaWduZWQtb2ZmLWJ5OiBQYXNjYWwgQmFjaCA8cGFzY2Fs
LmJhY2hAc2llbWVucy5jb20+DQotLS0NCiBsaWIvYmIvZmV0Y2gyL2dpdC5weSAgfCAyOSArKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLQ0KIGxpYi9iYi90ZXN0cy9mZXRjaC5weSB8ICAyICsr
DQogMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvbGliL2JiL2ZldGNoMi9naXQucHkgYi9saWIvYmIvZmV0Y2gyL2dpdC5weQ0K
aW5kZXggNTEyNTlkZjkuLjE1ODU4YTYyIDEwMDY0NA0KLS0tIGEvbGliL2JiL2ZldGNoMi9naXQu
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
Ci0gICAgICAgICAgICByYWlzZSBiYi5mZXRjaDIuVW5wYWNrRXJyb3IoIk5vIHVwIHRvIGRhdGUg
c291cmNlIGZvdW5kIiwgdWQudXJsKQ0KKyAgICAgICAgc291cmNlX2ZvdW5kID0gRmFsc2UNCisg
ICAgICAgIHNvdXJjZV9lcnJvciA9IFtdDQorDQorICAgICAgICBpZiBub3Qgc291cmNlX2ZvdW5k
Og0KKyAgICAgICAgICAgIGNsb25lZGlyX2lzX3VwX3RvX2RhdGUgPSBub3Qgc2VsZi5jbG9uZWRp
cl9uZWVkX3VwZGF0ZSh1ZCwgZCkNCisgICAgICAgICAgICBpZiBjbG9uZWRpcl9pc191cF90b19k
YXRlOg0KKyAgICAgICAgICAgICAgICBydW5mZXRjaGNtZCgiJXMgY2xvbmUgJXMgJXMvICVzIiAl
ICh1ZC5iYXNlY21kLCB1ZC5jbG9uZWZsYWdzLCB1ZC5jbG9uZWRpciwgZGVzdGRpciksIGQpDQor
ICAgICAgICAgICAgICAgIHNvdXJjZV9mb3VuZCA9IFRydWUNCisgICAgICAgICAgICBlbHNlOg0K
KyAgICAgICAgICAgICAgICBzb3VyY2VfZXJyb3IuYXBwZW5kKCJjbG9uZSBkaXJlY3Rvcnkgbm90
IGF2YWlsYWJsZSBvciBub3QgdXAgdG8gZGF0ZTogIiArIHVkLmNsb25lZGlyKQ0KKw0KKyAgICAg
ICAgaWYgbm90IHNvdXJjZV9mb3VuZDoNCisgICAgICAgICAgICBpZiB1ZC5zaGFsbG93IGFuZCBv
cy5wYXRoLmV4aXN0cyh1ZC5mdWxsc2hhbGxvdyk6DQorICAgICAgICAgICAgICAgIGJiLnV0aWxz
Lm1rZGlyaGllcihkZXN0ZGlyKQ0KKyAgICAgICAgICAgICAgICBydW5mZXRjaGNtZCgidGFyIC14
emYgJXMiICUgdWQuZnVsbHNoYWxsb3csIGQsIHdvcmtkaXI9ZGVzdGRpcikNCisgICAgICAgICAg
ICAgICAgc291cmNlX2ZvdW5kID0gVHJ1ZQ0KKyAgICAgICAgICAgIGVsc2U6DQorICAgICAgICAg
ICAgICAgIHNvdXJjZV9lcnJvci5hcHBlbmQoInNoYWxsb3cgY2xvbmUgbm90IGVuYWJsZWQgb3Ig
bm90IGF2YWlsYWJsZTogIiArIHVkLmZ1bGxzaGFsbG93KQ0KKw0KKyAgICAgICAgaWYgbm90IHNv
dXJjZV9mb3VuZDoNCisgICAgICAgICAgICByYWlzZSBiYi5mZXRjaDIuVW5wYWNrRXJyb3IoIk5v
IHVwIHRvIGRhdGUgc291cmNlIGZvdW5kOiAiICsgIjsgIi5qb2luKHNvdXJjZV9lcnJvciksIHVk
LnVybCkNCiANCiAgICAgICAgIHJlcG91cmwgPSBzZWxmLl9nZXRfcmVwb191cmwodWQpDQogICAg
ICAgICBydW5mZXRjaGNtZCgiJXMgcmVtb3RlIHNldC11cmwgb3JpZ2luICVzIiAlICh1ZC5iYXNl
Y21kLCByZXBvdXJsKSwgZCwgd29ya2Rpcj1kZXN0ZGlyKQ0KZGlmZiAtLWdpdCBhL2xpYi9iYi90
ZXN0cy9mZXRjaC5weSBiL2xpYi9iYi90ZXN0cy9mZXRjaC5weQ0KaW5kZXggNTFjZjc1NjMuLmQ3
NDAzOWNiIDEwMDY0NA0KLS0tIGEvbGliL2JiL3Rlc3RzL2ZldGNoLnB5DQorKysgYi9saWIvYmIv
dGVzdHMvZmV0Y2gucHkNCkBAIC0xNTkxLDYgKzE1OTEsOCBAQCBjbGFzcyBHaXRTaGFsbG93VGVz
dChGZXRjaGVyVGVzdCk6DQogICAgICAgICAgICAgZmV0Y2hlci51bnBhY2soc2VsZi5kLmdldFZh
cignV09SS0RJUicpKQ0KIA0KICAgICAgICAgc2VsZi5hc3NlcnRUcnVlKCJObyB1cCB0byBkYXRl
IHNvdXJjZSBmb3VuZCIgaW4gY29udGV4dC5leGNlcHRpb24ubXNnKQ0KKyAgICAgICAgc2VsZi5h
c3NlcnRUcnVlKCJjbG9uZSBkaXJlY3Rvcnkgbm90IGF2YWlsYWJsZSBvciBub3QgdXAgdG8gZGF0
ZSIgaW4gY29udGV4dC5leGNlcHRpb24ubXNnKQ0KKyAgICAgICAgc2VsZi5hc3NlcnRUcnVlKCJz
aGFsbG93IGNsb25lIG5vdCBlbmFibGVkIG9yIG5vdCBhdmFpbGFibGUiIGluIGNvbnRleHQuZXhj
ZXB0aW9uLm1zZykNCiANCiAgICAgQHNraXBJZk5vTmV0d29yaygpDQogICAgIGRlZiB0ZXN0X3Ro
YXRfdW5wYWNrX2RvZXNfd29ya193aGVuX3VzaW5nX2dpdF9zaGFsbG93X3RhcmJhbGxfYnV0X3Rh
cmJhbGxfaXNfbm90X2F2YWlsYWJsZShzZWxmKToNCi0tIA0KMi4xOS4wDQoNCg==

