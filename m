Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 7286 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 03 Oct 2018 17:37:12 UTC
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
	(mail-eopbgr60050.outbound.protection.outlook.com [40.107.6.50])
	by mail.openembedded.org (Postfix) with ESMTP id 8FE7074B02
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Oct 2018 17:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=v1ByF5NT3xvcg600ERaNBmeoQAw5PdELtCWcwZuKNX0=;
	b=fc1MFCD1Lw7ujUF+KGWmU8jwjVBwmNJRuSZGNZPzdYGLOFuphs+tvstyeB0anwav4xI3+cA4hMw7p/z6Z6dD0sb4f7+kJ/16ha6ueuExu3/E0RLj7CBcgI1OK3+LP3PZjPJ9wceEgfHtLIJy4CJRCow7dBypTNoVXp2dTDnnXbg=
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com (52.135.135.148) by
	DB7PR03MB3754.eurprd03.prod.outlook.com (52.134.99.31) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1207.18; Wed, 3 Oct 2018 12:04:08 +0000
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb]) by
	DB7PR03MB3834.eurprd03.prod.outlook.com
	([fe80::15cf:1dc2:d333:eaeb%3]) with mapi id 15.20.1185.026;
	Wed, 3 Oct 2018 12:04:08 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH 5/7] fetch2/git: prevent access to non-existing clonedir
Thread-Index: AQHUWxEweYYjrZ6cDEO93JMOCkmttg==
Date: Wed, 3 Oct 2018 12:04:08 +0000
Message-ID: <20181003120346.3523-6-urs.fassler@bbv.ch>
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
	6:gP4NJ2RWQvYgTcsqwYp2zZNGd9Y3CB9/pdJs+11Kx2E3oA4WBPG1/RPTRQS0cTbnFx2rHhzGQQygy3muVci/ggbE3MtW5rEyEGOzTCi9slUaD5vuujB9PUT1et/7FvO9wSHvXb0OzJPrO9orMdNRtZ+p0BQF7w8LXaknjjvxBYa0jHNwW/XdDwrrXpcnO6klE+fIPCmIgn81AxSm8yWiiSdpyUq5hR9Gqdz0NkdgjCM8azQQDMmqmBgwHgdd+WhQA3EnxUg+UFIkPKpEhmYOpuH6JcLIoYqbWqHeUN1//70opFzIJI/1UjVPT5il6LSvawbP1yE7qKhGdi0K2fBj94VOBIQp9mLatFWA59F4oRsdY0sPTSsplHcXg7eCQVEBtaj1Fp6LRHAd4BUfnMN0MoWNaXnsRTicqynE08Cb/++ZzD3j1jR5WEYFaHPC6RW1JEGwW9DqLy6nx2NbnWmw0g==;
	5:zaDrACM1HhSUnCi7SKNwF8Yd/nVFQ3KPEEFMJizsZEo/nSHv/UQA3gzQHMP8+T/Gt94WjSHH6VAGxOWXGYS+ANSXm1JAw/mVd3HFuoD08LtFvVJW7oAVlIbNc+7fvwXrQq2Vl6qy0WDZuKb1ZQyS7nHMJOn1es7qa8cl6zQHH44=;
	7:WSsTCTkz9Q1qGvT645BGbxOcHLLCRnsbEs/1NoP+O/ii64gdkguqP3BmXTdZGEKOlDsp0AqG5KEiRfyKtjzQRM/xLaahLq/GQJwpHG3fkiyXZR4G1sc3eeXGBxxyYP68t5eHsBrycI4j4Hv350opUl1t+GqXcE/V5I6QJxyYSzZqwL4RKk+i4f7mKY4wymFNX2otPUXM0sthYjcgcQ5iDFAYP/zMlWlNjs5yUOt+bq2TDk5kFxLvjisjqtyN/wol
x-ms-office365-filtering-correlation-id: ccb1db0a-2402-4831-665a-08d6292852ab
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:DB7PR03MB3754; 
x-ms-traffictypediagnostic: DB7PR03MB3754:
x-microsoft-antispam-prvs: <DB7PR03MB3754F29D8B2A1BA032656F958FE90@DB7PR03MB3754.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(181554191321653)(126837547833334)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);
	SRVR:DB7PR03MB3754; BCL:0; PCL:0; RULEID:; SRVR:DB7PR03MB3754; 
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(346002)(366004)(39840400004)(376002)(136003)(189003)(199004)(6486002)(476003)(2616005)(575784001)(6436002)(86362001)(6916009)(5640700003)(2900100001)(54906003)(74482002)(5660300001)(14444005)(8936002)(81156014)(50226002)(68736007)(256004)(6512007)(99286004)(53936002)(66574008)(52116002)(36756003)(11346002)(33896004)(305945005)(386003)(6506007)(486006)(76176011)(7736002)(25786009)(71200400001)(446003)(6116002)(2906002)(81166006)(2501003)(14454004)(4326008)(186003)(26005)(85182001)(71190400001)(5250100002)(102836004)(106356001)(105586002)(2351001)(97736004)(85202003)(8676002)(66066001)(1076002)(478600001)(316002)(3846002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR03MB3754;
	H:DB7PR03MB3834.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: 7w6REfxvTCjVh0HaHycIPGfUqAAIk/xpFeQ0hCZnNiyEZWi6D2Z9Y2If2p4xAVdtXfdENoXGjGsmgJP8oFPGXZkherIkMti2GfgSV6vonTSiI8n3Klajv5g2dtHfxi5aYRvQ5QFQeSNH1+DiKb3GcNuKMN9VwoPYM1iXdDgETRQyh+7x+ExgatvR9rFdhJ8uz9TnqqE+/4E88MKfSkwZ1VgGvzUHSy4ccOGXScvQR+iVsDyfJM1NujUw1xpZuHdHOXeni4QZmnU0zsvUKEI3wm0YV1400xe9X3UgflnbLTXFE+JNAyTrk0BH/UVMu86ynQinYZc1trLt/wl1v28hZUsUH+ft80d8YXJQXZicP0M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb1db0a-2402-4831-665a-08d6292852ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 12:04:08.5011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3754
Subject: [PATCH 5/7] fetch2/git: prevent access to non-existing clonedir
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
X-List-Received-Date: Wed, 03 Oct 2018 17:37:13 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <57E6E20D47C0DB45AACFF4E932C17404@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

QSB1c2VyIGZyaWVuZGx5IGVycm9yIGlzIHRocm93IHdoZW4gbmVpdGhlciB0aGUgY2xvbmVkaXIg
bm9yDQpmdWxsc2hhbGxvdyBleGlzdC4gV2l0aG91dCB0aGUgY2hlY2ssIGEgZGlmZmljdWx0IHRv
IGludGVycHJldCBlcnJvcg0KaXMgdGhyb3cgZnJvbSB3aXRoaW4gdGhlIGZldGNoIGNvbW1hbmQu
DQoNClNpZ25lZC1vZmYtYnk6IFVycyBGw6Rzc2xlciA8dXJzLmZhc3NsZXJAYmJ2LmNoPg0KU2ln
bmVkLW9mZi1ieTogUGFzY2FsIEJhY2ggPHBhc2NhbC5iYWNoQHNpZW1lbnMuY29tPg0KLS0tDQog
bGliL2JiL2ZldGNoMi9naXQucHkgIHwgIDQgKysrLQ0KIGxpYi9iYi90ZXN0cy9mZXRjaC5weSB8
IDEzICsrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2xpYi9iYi9mZXRjaDIvZ2l0LnB5IGIvbGliL2Ji
L2ZldGNoMi9naXQucHkNCmluZGV4IGYxM2EyNWY5Li5mYmQzMDAxMSAxMDA2NDQNCi0tLSBhL2xp
Yi9iYi9mZXRjaDIvZ2l0LnB5DQorKysgYi9saWIvYmIvZmV0Y2gyL2dpdC5weQ0KQEAgLTQ3OSw4
ICs0NzksMTAgQEAgY2xhc3MgR2l0KEZldGNoTWV0aG9kKToNCiAgICAgICAgIGlmIHVkLnNoYWxs
b3cgYW5kIG9zLnBhdGguZXhpc3RzKHVkLmZ1bGxzaGFsbG93KSBhbmQgc2VsZi5jbG9uZWRpcl9u
ZWVkX3VwZGF0ZSh1ZCwgZCk6DQogICAgICAgICAgICAgYmIudXRpbHMubWtkaXJoaWVyKGRlc3Rk
aXIpDQogICAgICAgICAgICAgcnVuZmV0Y2hjbWQoInRhciAteHpmICVzIiAlIHVkLmZ1bGxzaGFs
bG93LCBkLCB3b3JrZGlyPWRlc3RkaXIpDQotICAgICAgICBlbHNlOg0KKyAgICAgICAgZWxpZiBu
b3Qgc2VsZi5jbG9uZWRpcl9uZWVkX3VwZGF0ZSh1ZCwgZCk6DQogICAgICAgICAgICAgcnVuZmV0
Y2hjbWQoIiVzIGNsb25lICVzICVzLyAlcyIgJSAodWQuYmFzZWNtZCwgdWQuY2xvbmVmbGFncywg
dWQuY2xvbmVkaXIsIGRlc3RkaXIpLCBkKQ0KKyAgICAgICAgZWxzZToNCisgICAgICAgICAgICBi
Yi5mYXRhbCgibm8gdXAgdG8gZGF0ZSBzb3VyY2UgZm91bmQiKQ0KIA0KICAgICAgICAgcmVwb3Vy
bCA9IHNlbGYuX2dldF9yZXBvX3VybCh1ZCkNCiAgICAgICAgIHJ1bmZldGNoY21kKCIlcyByZW1v
dGUgc2V0LXVybCBvcmlnaW4gJXMiICUgKHVkLmJhc2VjbWQsIHJlcG91cmwpLCBkLCB3b3JrZGly
PWRlc3RkaXIpDQpkaWZmIC0tZ2l0IGEvbGliL2JiL3Rlc3RzL2ZldGNoLnB5IGIvbGliL2JiL3Rl
c3RzL2ZldGNoLnB5DQppbmRleCAyZWZlZjA3OC4uNTZjMGMwZGIgMTAwNjQ0DQotLS0gYS9saWIv
YmIvdGVzdHMvZmV0Y2gucHkNCisrKyBiL2xpYi9iYi90ZXN0cy9mZXRjaC5weQ0KQEAgLTI4LDYg
KzI4LDcgQEAgaW1wb3J0IG9zDQogZnJvbSBiYi5mZXRjaDIgaW1wb3J0IFVSSQ0KIGZyb20gYmIu
ZmV0Y2gyIGltcG9ydCBGZXRjaE1ldGhvZA0KIGltcG9ydCBiYg0KK2Zyb20gYmIudGVzdHMubG9n
cmVjb3JkIGltcG9ydCBMb2dSZWNvcmQsIGxvZ0NvbnRhaW5zDQogDQogZGVmIHNraXBJZk5vTmV0
d29yaygpOg0KICAgICBpZiBvcy5lbnZpcm9uLmdldCgiQkJfU0tJUF9ORVRURVNUUyIpID09ICJ5
ZXMiOg0KQEAgLTE1ODEsNiArMTU4MiwxOCBAQCBjbGFzcyBHaXRTaGFsbG93VGVzdChGZXRjaGVy
VGVzdCk6DQogICAgICAgICBzZWxmLmFzc2VydFJlZnMoWydtYXN0ZXInLCAnb3JpZ2luL21hc3Rl
ciddKQ0KICAgICAgICAgc2VsZi5hc3NlcnRSZXZDb3VudChvcmlnX3JldnMgLSAxNzU4KQ0KIA0K
KyAgICBkZWYgdGVzdF90aGF0X3VucGFja190aHJvd3NfYW5fZXJyb3Jfd2hlbl90aGVfZ2l0X2Ns
b25lX25vcl9zaGFsbG93X3RhcmJhbGxfZXhpc3Qoc2VsZik6DQorICAgICAgICBzZWxmLmFkZF9l
bXB0eV9maWxlKCdhJykNCisgICAgICAgIGZldGNoZXIsIHVkID0gc2VsZi5mZXRjaCgpDQorICAg
ICAgICBiYi51dGlscy5yZW1vdmUoc2VsZi5naXRkaXIsIHJlY3Vyc2U9VHJ1ZSkNCisgICAgICAg
IGJiLnV0aWxzLnJlbW92ZShzZWxmLmRsZGlyLCByZWN1cnNlPVRydWUpDQorDQorICAgICAgICB3
aXRoIExvZ1JlY29yZCgpIGFzIGxvZ3M6DQorICAgICAgICAgICAgd2l0aCBzZWxmLmFzc2VydFJh
aXNlcyhFeGNlcHRpb24pIGFzIGNvbnRleHQ6DQorICAgICAgICAgICAgICAgIGZldGNoZXIudW5w
YWNrKHNlbGYuZC5nZXRWYXIoJ1dPUktESVInKSkNCisNCisgICAgICAgICAgICBzZWxmLmFzc2Vy
dFRydWUobG9nQ29udGFpbnMoIm5vIHVwIHRvIGRhdGUgc291cmNlIGZvdW5kIiwgbG9ncykpDQor
DQogICAgIEBza2lwSWZOb05ldHdvcmsoKQ0KICAgICBkZWYgdGVzdF90aGF0X3VucGFja19kb2Vz
X3dvcmtfd2hlbl91c2luZ19naXRfc2hhbGxvd190YXJiYWxsX2J1dF90YXJiYWxsX2lzX25vdF9h
dmFpbGFibGUoc2VsZik6DQogICAgICAgICBzZWxmLmQuc2V0VmFyKCdTUkNSRVYnLCAnZTU5Mzlm
ZjYwOGI5NWNkZDRkMGFiMGUxOTM1NzgxYWI5YTI3NmFjMCcpDQotLSANCjIuMTkuMA0KDQo=

