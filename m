Return-Path: <urs.fassler@bbv.ch>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
	(mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
	by mail.openembedded.org (Postfix) with ESMTP id F0F9779707
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Oct 2018 15:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=5JNzG6gJuLcRbmtPzPMX9zfMMDSrblvWQBHl60MUrtw=;
	b=bVSIL9mOKP2uhNnnUqH78bX/7aTMhaZzD2uiZ1A6wBM/g4ttsC2xwAipN0P8RbUpLOomuc7YxFHltEsFpXH7wyuLf1m1DOCpUsKbLjdF/vi48lNpPyCcquOxkvE7RybKKC4CIBVhWMKlctDmbJzT5VSU3fdkcRutmWvOCzPFlHc=
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com (52.135.135.148) by
	DB7PR03MB3754.eurprd03.prod.outlook.com (52.134.99.31) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1207.18; Wed, 3 Oct 2018 12:04:09 +0000
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb]) by
	DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb%3]) with mapi id 15.20.1185.026;
	Wed, 3 Oct 2018 12:04:09 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH 6/7] fetch2/git: explicitly show the decision logic to
	select the source in code
Thread-Index: AQHUWxEwl71XFNbyZk23rc/1cJxMoA==
Date: Wed, 3 Oct 2018 12:04:09 +0000
Message-ID: <20181003120346.3523-7-urs.fassler@bbv.ch>
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
	6:C+5L8uFiAZAjZnTyeujuly3a2mB5dHTUBoVPcsU1+HVcnV36w3t0r34gSzOIMdQ8g4MnyBtQU9FviCM3k9HoE2cbHtO4wulOV1Aw1LYmF/Ky91TN5H3I/B/BiszPotJHeyI7YfcWrk5pXoCBdKEuEcu904qZX4NVy/PtRffL8F+ulUImeujJ9d1C+85Lr9Az2CGPm04Owt5LT6Jtvp3TDdyLTm8cDLk5QAVPPDXNL+Whj2Z7CP8Flt0FTIS46f8QoMu0rB2Yh4T/lkCddyow6PGiBN5louhpIIHKKRDwpHHAzblVbbR65OSHGhMb5Vlufu9Jjs5WP0c8A0MQ2lDT7K8TpqMWbA0XcTC6Azu9mejJohlsMippT8RO7b6ecYiiGuCTNBf7UrYVEDRSx/wcBE+GNGUHj/nyESjDW6H/XF93xUWybaXkxKELQNjx4iM31nqxDWW/hOQgK8sQCidsYQ==;
	5:R6kALZ0jXn4c6W4PtRtKeYFqvoiGOkjclVlKti7WeD5Vr5PQrsdplJTYJ5dhwHYsNwTjHTQ3WJgx0p7CzgkqEzICQbBFgZnIQOvrdW7tuPi41XplwOFv7pxLrwk4YqxPeeCXUb7dO9Vk3TTR61q0+ayAfOoaqcsLqqp2MQ/+yyg=;
	7:FeQs5Kk8ogtYO4pAszZ0orcugER3PXFNoMhGQh7IZEJjcs0zZ14aZvVZcv1mzWrKXmROB+fwNoy+nKGoRqTG2+kbWnj3B5GIC6IobKLDW/phYFgMn7Bz6pXodhh+jkcxBX8Vc4I46cgtFQ7Q3S9VmHPWrb6ki7HYV1EszG1ouB5Af25q3b8FabZMngjxQO2Ka5sS59pj+fseg7SFlA+L/axFxW+5p1nvkfjnTUnS/7UJsMok7cbgEG2FwbhuMnFQ
x-ms-office365-filtering-correlation-id: bb6fa41b-6c98-4df4-3a38-08d62928530a
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:DB7PR03MB3754; 
x-ms-traffictypediagnostic: DB7PR03MB3754:
x-microsoft-antispam-prvs: <DB7PR03MB3754A4BB74DA688562271C3F8FE90@DB7PR03MB3754.eurprd03.prod.outlook.com>
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
x-microsoft-antispam-message-info: OW87Nm//RIXGU3CCT9SMBAi8osVlwRti5CFvuVfMhT4/eNyqH8w6Ogo0zEk3AiCS1eBdvKsdXBbcRRWbGfut+Gy3pTsUCqCvpxf01ZhwZ3xZYei71BPxgSBmcz0BoHq3UnwPJx4tWUaYXUEodbKGPhp5JlJ1nNFMLeiI4L309XHHXKMPS3TrSAHR0YJItf0M7MQ1XO0JWFb56T1ZiHWCy9IIo5X7S6ToBHGZtJNutWhNRWJaHHM7bg0Mv/UGb7wAQft/PbyppKTSpS9LR6DK3FqjaNYLwZqfQTBDHe8uwAoF7xymkneKGjyOx59iNoOxSTjsMPXe9fxBWUrs0/luYi/89l1r3fF/ER+nQCOxrvI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6fa41b-6c98-4df4-3a38-08d62928530a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 12:04:09.1416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3754
Subject: [PATCH 6/7] fetch2/git: explicitly show the decision logic to select the source in code
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
X-List-Received-Date: Wed, 03 Oct 2018 15:36:49 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA112C2BF27DE04A931223CEF7258B76@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

U2lnbmVkLW9mZi1ieTogVXJzIEbDpHNzbGVyIDx1cnMuZmFzc2xlckBiYnYuY2g+DQpTaWduZWQt
b2ZmLWJ5OiBQYXNjYWwgQmFjaCA8cGFzY2FsLmJhY2hAc2llbWVucy5jb20+DQotLS0NCiBsaWIv
YmIvZmV0Y2gyL2dpdC5weSB8IDcgKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9saWIvYmIvZmV0Y2gyL2dpdC5w
eSBiL2xpYi9iYi9mZXRjaDIvZ2l0LnB5DQppbmRleCBmYmQzMDAxMS4uMzMzYjg4OTMgMTAwNjQ0
DQotLS0gYS9saWIvYmIvZmV0Y2gyL2dpdC5weQ0KKysrIGIvbGliL2JiL2ZldGNoMi9naXQucHkN
CkBAIC00NzYsMTEgKzQ3NiwxMiBAQCBjbGFzcyBHaXQoRmV0Y2hNZXRob2QpOg0KICAgICAgICAg
aWYgb3MucGF0aC5leGlzdHMoZGVzdGRpcik6DQogICAgICAgICAgICAgYmIudXRpbHMucHJ1bmVk
aXIoZGVzdGRpcikNCiANCi0gICAgICAgIGlmIHVkLnNoYWxsb3cgYW5kIG9zLnBhdGguZXhpc3Rz
KHVkLmZ1bGxzaGFsbG93KSBhbmQgc2VsZi5jbG9uZWRpcl9uZWVkX3VwZGF0ZSh1ZCwgZCk6DQor
ICAgICAgICBjbG9uZWRpcl9pc191cF90b19kYXRlID0gbm90IHNlbGYuY2xvbmVkaXJfbmVlZF91
cGRhdGUodWQsIGQpDQorICAgICAgICBpZiBjbG9uZWRpcl9pc191cF90b19kYXRlOg0KKyAgICAg
ICAgICAgIHJ1bmZldGNoY21kKCIlcyBjbG9uZSAlcyAlcy8gJXMiICUgKHVkLmJhc2VjbWQsIHVk
LmNsb25lZmxhZ3MsIHVkLmNsb25lZGlyLCBkZXN0ZGlyKSwgZCkNCisgICAgICAgIGVsaWYgdWQu
c2hhbGxvdyBhbmQgb3MucGF0aC5leGlzdHModWQuZnVsbHNoYWxsb3cpOg0KICAgICAgICAgICAg
IGJiLnV0aWxzLm1rZGlyaGllcihkZXN0ZGlyKQ0KICAgICAgICAgICAgIHJ1bmZldGNoY21kKCJ0
YXIgLXh6ZiAlcyIgJSB1ZC5mdWxsc2hhbGxvdywgZCwgd29ya2Rpcj1kZXN0ZGlyKQ0KLSAgICAg
ICAgZWxpZiBub3Qgc2VsZi5jbG9uZWRpcl9uZWVkX3VwZGF0ZSh1ZCwgZCk6DQotICAgICAgICAg
ICAgcnVuZmV0Y2hjbWQoIiVzIGNsb25lICVzICVzLyAlcyIgJSAodWQuYmFzZWNtZCwgdWQuY2xv
bmVmbGFncywgdWQuY2xvbmVkaXIsIGRlc3RkaXIpLCBkKQ0KICAgICAgICAgZWxzZToNCiAgICAg
ICAgICAgICBiYi5mYXRhbCgibm8gdXAgdG8gZGF0ZSBzb3VyY2UgZm91bmQiKQ0KIA0KLS0gDQoy
LjE5LjANCg0K

