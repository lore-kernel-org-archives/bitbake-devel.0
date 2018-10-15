Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 3578 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 15 Oct 2018 15:15:48 UTC
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr50048.outbound.protection.outlook.com [40.107.5.48])
	by mail.openembedded.org (Postfix) with ESMTP id A634479670
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 15:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=QbKE+5qPdmQHfX9ltMR6znaTa1Nm1z3MOM9g67h8l8E=;
	b=euDGFBWFP4Hn82MlEQakGLMQTysqAoMw2IAO3aLeMpUGf7qo0sjv5UAbwMrKRgMEA8bjttdFRP09yGd7A4t6zZD97l6C2iiUtRkFKh/rEL23nV8dXfcuyhy+mBAUznVZV6C6oq0TWBMefXzxcoA1/XyDzndjRgRaLaPuOvQVx0g=
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
Thread-Topic: [bitbake-devel][PATCH 3/7] fetch2/git: add tests to capture
	existing behavior wrt. naming of git shallow tarball
Thread-Index: AQHUZI0I6RjQCP12QUioHIRxzfHEKA==
Date: Mon, 15 Oct 2018 13:43:19 +0000
Message-ID: <20181015134255.4634-4-urs.fassler@bbv.ch>
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
	6:ZbqrU6UCmIAQPhL8s93l0KxZ/1rIFxa06ioEJqh7vg2tfeHYdVj4UvCWbt2OmmZh3G4O7ca4qIQku66FADRgv03yhi4vBIP1gphPYQzsfDI5cHvIgpvssVhRPAlMRjmZZoaroDPaHkhRYfflbaWrWGkb+1v4PF79x2qOji/1leYnJOIR5qbLdiwnBVVHtFVJduoE/uoLsKjUKzVqtDtDmDac+4Yh/Ih4DwHOAY+MV6slwAFyyJ0Sg5uFTn0wujSmnu/E7XfjPmYRqX51CQ7yW2YQ7rVfQy219glUGzQmCGnen2Z19gQPs9ADVL+yl0Nyt3uuRUgR+vKvdEKZeLRQcWGh1zuRsCduswaX9LLWTXbZ+z0045/agLBmfOZ20Xh6GHHQC5yoxiBvDWmp3JMB7ZBiKWPDwdPrGvQ/+iDC2WeOTAr7ivk/+IMfffLUBERx/i360gpEEWlmP3XW4p4q8g==;
	5:34X/FH9uzfWdSbUVORA27+5AV6bjPpklaXwD5ukkrMloF2rnlMcY38XuIl8ZYIkn9W2sw634fwCbmyMA8JBvBul5hzjAP2o7M8B0lHMqwE6rmjmrZTvsSaX4OY7grzYhh48gMT9Tzfji1dt4qUQBo6Ks4BqJLX+Uoa3tcupo8rM=;
	7:xKUfBEQoeuSxBewoDM2syn+V+FxvJlISFV5EWgvCrD6tFbSjZR7229+S7M0Mer2j65mRSFn4ZJn4Z/wT14sfbCe3K3vHx326sV9j6ZEVjd1R4sJfG4LA+qmfRj8i1SUpJUTmDRcw3iWRa/si1j5VM80k7Y3y4sCXocOwm9wVujUnnXrF0MSpKpHNEPQzOR9p8waSGxBIFDpDCOYqTf5YSUde6MkCLXOXqq6S9W6a2qLAZgPQm0Mdq2tYiurqL10m
x-ms-office365-filtering-correlation-id: 6bd9c824-899f-4bd2-ab52-08d632a42aeb
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4421; 
x-ms-traffictypediagnostic: AM6PR03MB4421:
x-microsoft-antispam-prvs: <AM6PR03MB442150C60A194D445A8494298FFD0@AM6PR03MB4421.eurprd03.prod.outlook.com>
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
x-microsoft-antispam-message-info: 0feDtObcuCJ2/8oCwORkXTj3m+U0UQMRZJO1MPlSQn5T34u7ASgIaZ1l7C4Moxi/+9Fs+6t8r2LJn0mO1IncBvyoXHFF4eKoKrXyMUJ1JD/TF0WmqksVDoAHFdxMOrbH7Q2EcG7gUq3Ij0E7bg6zfYcxJCB/Cn5sR7FyMCz/kET9+xzMup0eumprDnr9VtahcEFQVOIoZPHiPV4FIbx1V5cwyrGzigxZEwZDtVhizuDy2rE0ZLpM/ma4ON2M7/UTRV4DjnmK6lFLjZjaBviiiey5Peew9z5ypxSDEuB/q/ZuoANo5vxqHyWOT06/dIoRFbYrwdsguO1T+lkKscaYC0pg41wRFL1RkMmemLvumXw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd9c824-899f-4bd2-ab52-08d632a42aeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:43:19.8429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4421
Subject: [PATCH 3/7] fetch2/git: add tests to capture existing behavior wrt. naming of git shallow tarball
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
X-List-Received-Date: Mon, 15 Oct 2018 15:15:49 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5037E5C2AB08734D8307E504CAD3888F@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

VGhlIG1hcHBpbmcgb2YgdGhlIFVSTHMgdG8gdGhlIGxvY2FsIHNoYWxsb3cgdGFyYmFsbHMgaXMg
bm90IG9idmlvdXMuIEZvcg0KZWFzaWVyIHVuZGVyc3RhbmRpbmcsIHdlIGFkZCB0aGlzIHRlc3Rz
IHRvIGV4cGxpY2l0bHkgc2hvd2luZyB0aGUgbWFwcGluZy4NCg0KU2lnbmVkLW9mZi1ieTogVXJz
IEbDpHNzbGVyIDx1cnMuZmFzc2xlckBiYnYuY2g+DQpTaWduZWQtb2ZmLWJ5OiBQYXNjYWwgQmFj
aCA8cGFzY2FsLmJhY2hAc2llbWVucy5jb20+DQotLS0NCiBsaWIvYmIvdGVzdHMvZmV0Y2gucHkg
fCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAzNSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9saWIvYmIvdGVzdHMvZmV0Y2gucHkg
Yi9saWIvYmIvdGVzdHMvZmV0Y2gucHkNCmluZGV4IGRjYzRkOGNlLi43OWJlMWJlMCAxMDA2NDQN
Ci0tLSBhL2xpYi9iYi90ZXN0cy9mZXRjaC5weQ0KKysrIGIvbGliL2JiL3Rlc3RzL2ZldGNoLnB5
DQpAQCAtNTQ2LDYgKzU0Niw0MSBAQCBjbGFzcyBUYXJiYWxsTmFtaW5nVGVzdChGZXRjaGVyVGVz
dCk6DQogICAgICAgICBzZWxmLmFzc2VydEluKHNlbGYubWlycm9yX3RhcmJhbGwsIGRpcikNCiAN
CiANCitjbGFzcyBHaXRTaGFsbG93VGFyYmFsbE5hbWluZ1Rlc3QoRmV0Y2hlclRlc3QpOg0KKyAg
ICBkZWYgc2V0VXAoc2VsZik6DQorICAgICAgICBzdXBlcihHaXRTaGFsbG93VGFyYmFsbE5hbWlu
Z1Rlc3QsIHNlbGYpLnNldFVwKCkNCisgICAgICAgIHNlbGYucmVjaXBlX3VybCA9ICJnaXQ6Ly9n
aXQub3BlbmVtYmVkZGVkLm9yZy9iaXRiYWtlIg0KKyAgICAgICAgc2VsZi5yZWNpcGVfdGFyYmFs
bCA9ICJnaXRzaGFsbG93X2dpdC5vcGVuZW1iZWRkZWQub3JnLmJpdGJha2VfODJlYTczNy0xX21h
c3Rlci50YXIuZ3oiDQorICAgICAgICBzZWxmLm1pcnJvcl91cmwgPSAiZ2l0Oi8vZ2l0aHViLmNv
bS9vcGVuZW1iZWRkZWQvYml0YmFrZS5naXQiDQorICAgICAgICBzZWxmLm1pcnJvcl90YXJiYWxs
ID0gImdpdHNoYWxsb3dfZ2l0aHViLmNvbS5vcGVuZW1iZWRkZWQuYml0YmFrZS5naXRfODJlYTcz
Ny0xX21hc3Rlci50YXIuZ3oiDQorDQorICAgICAgICBzZWxmLmQuc2V0VmFyKCdCQl9HSVRfU0hB
TExPVycsICcxJykNCisgICAgICAgIHNlbGYuZC5zZXRWYXIoJ0JCX0dFTkVSQVRFX1NIQUxMT1df
VEFSQkFMTFMnLCAnMScpDQorICAgICAgICBzZWxmLmQuc2V0VmFyKCdTUkNSRVYnLCAnODJlYTcz
N2EwYjQyYThiNTNlMTFjOWNkZTE0MWU5ZTljMGJkOGM0MCcpDQorDQorICAgIGRlZiBzZXR1cF9t
aXJyb3JfcmV3cml0ZShzZWxmKToNCisgICAgICAgIHNlbGYuZC5zZXRWYXIoIlBSRU1JUlJPUlMi
LCBzZWxmLnJlY2lwZV91cmwgKyAiICIgKyBzZWxmLm1pcnJvcl91cmwgKyAiIFxuIikNCisNCisg
ICAgQHNraXBJZk5vTmV0d29yaygpDQorICAgIGRlZiB0ZXN0X3RoYXRfdGhlX3RhcmJhbGxfaXNf
bmFtZWRfYWZ0ZXJfcmVjaXBlX3VybF93aGVuX25vX21pcnJvcmluZ19pc191c2VkKHNlbGYpOg0K
KyAgICAgICAgZmV0Y2hlciA9IGJiLmZldGNoLkZldGNoKFtzZWxmLnJlY2lwZV91cmxdLCBzZWxm
LmQpDQorDQorICAgICAgICBmZXRjaGVyLmRvd25sb2FkKCkNCisNCisgICAgICAgIGRpciA9IG9z
Lmxpc3RkaXIoc2VsZi5kbGRpcikNCisgICAgICAgIHNlbGYuYXNzZXJ0SW4oc2VsZi5yZWNpcGVf
dGFyYmFsbCwgZGlyKQ0KKw0KKyAgICBAc2tpcElmTm9OZXR3b3JrKCkNCisgICAgZGVmIHRlc3Rf
dGhhdF90aGVfbWlycm9yX3RhcmJhbGxfaXNfY3JlYXRlZF93aGVuX21pcnJvcmluZ19pc191c2Vk
KHNlbGYpOg0KKyAgICAgICAgc2VsZi5zZXR1cF9taXJyb3JfcmV3cml0ZSgpDQorICAgICAgICBm
ZXRjaGVyID0gYmIuZmV0Y2guRmV0Y2goW3NlbGYucmVjaXBlX3VybF0sIHNlbGYuZCkNCisNCisg
ICAgICAgIGZldGNoZXIuZG93bmxvYWQoKQ0KKw0KKyAgICAgICAgZGlyID0gb3MubGlzdGRpcihz
ZWxmLmRsZGlyKQ0KKyAgICAgICAgc2VsZi5hc3NlcnRJbihzZWxmLm1pcnJvcl90YXJiYWxsLCBk
aXIpDQorDQorDQogY2xhc3MgRmV0Y2hlckxvY2FsVGVzdChGZXRjaGVyVGVzdCk6DQogICAgIGRl
ZiBzZXRVcChzZWxmKToNCiAgICAgICAgIGRlZiB0b3VjaChmbik6DQotLSANCjIuMTkuMQ0KDQo=

