Return-Path: <kweihmann@outlook.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-oln040092064084.outbound.protection.outlook.com [40.92.64.84])
	by mail.openembedded.org (Postfix) with ESMTP id 647D07FA24
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 14:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=BOidxmNWpU/ejstGSK7ndD8oCzNKOBq/+4artdS9rv2GBG3NV5cN55G+ZWjNjwKMkbY2/nsoq2rd74DpdEBTNjQDLogsEaZY8ruIrgbDqk80LK6zE+ggyaNPxwSyjzO0nuK42/bearPdBSDNfhUCzqCjN+m/l3DFTTZD28GyNKfxjoPR6vz9teT9gFHp+Or6FLcK+vW18YXWpG6+OucZtxODlg1m85N8jYf6HAm4QO+UQcA0QVGj2ttFWdhSnZE4kCPDQSWEOHtI/zX7b7dr3JIwVXES4zi2oWK7sots1DdH1yMcACG7+OaGh9T9DOat2BNzKCXmB7TfCrJk/V419g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=q4YP/6YPx66xFdOzo23jiUhCGVrq6bRugUvjtGVmS2I=;
	b=YR8XYlJ/5qpAGwMlcIzFW88JLJk2QoGi4Pvdu/gtVfXm0IXouN2QfR2XSQXr9IMyMFduz3pvc2gK1Ye0RmXreD+ijoaprZpPIDFwOO0v0pBK8jgZf1HSYjknOzPiGpMfJx52Ol0Kn024vzvJQkhTg1NwDIZYYtcCsKqf7IlsM4l90h11qYhdEfIetnpmKMGXHZo9+jlQxA1lxSnG2+fiDTHVspxCDL85MY3gubQkhl16MxtDW0E82iXbCB+LKstfB7sAs4XYpJPGEnCy/F5gpqcIhO2yNBMpDqCeiYXJzHWa28A/Yr7mB+hYrTEVks0dC70FSEQJitQ4frcWpdtcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
	dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=q4YP/6YPx66xFdOzo23jiUhCGVrq6bRugUvjtGVmS2I=;
	b=MDRxkyNduEt6rGnib6Y0rJAQIcROD2o0y6G9kV/OsDP0DufHZZDiqUUuUvdeFk1lVsoiwoFLQRzUYjUi7LVDGGYK590p4l/R02oKWqMXometDvfnvkzJ0dpB4xdOEFnAKyo69/hK/WuAe15Al2RsEGOCqehoQSJkncqZ61RUm2mIvbO1DeFcbwyq73BiuYzYIJaZwXg1yKjTtf0XC2U1KEvJMPFYFfuP1C97G1/oH4PlM2Eao1f9nXKVxDCPv02zuVguqjN9E6KRw73tAgF8dgUVgKBizrMHiOmGDO2OFzJng9+At2P61dZHaF6RN+KCz4dp8XMdmm7/wR3xrtaZSg==
Received: from HE1EUR01FT045.eop-EUR01.prod.protection.outlook.com
	(10.152.0.57) by HE1EUR01HT183.eop-EUR01.prod.protection.outlook.com
	(10.152.1.161) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14;
	Sun, 22 Dec 2019 14:29:39 +0000
Received: from AM4PR05MB3380.eurprd05.prod.outlook.com (10.152.0.60) by
	HE1EUR01FT045.mail.protection.outlook.com (10.152.0.239) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2559.14 via Frontend Transport; Sun, 22 Dec 2019 14:29:39 +0000
Received: from AM4PR05MB3380.eurprd05.prod.outlook.com
	([fe80::e923:8aad:dca0:fc9d]) by
	AM4PR05MB3380.eurprd05.prod.outlook.com
	([fe80::e923:8aad:dca0:fc9d%7]) with mapi id 15.20.2559.017;
	Sun, 22 Dec 2019 14:29:39 +0000
From: Konrad Weihmann <kweihmann@outlook.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Bitbake exception when recipe path contains a blank
Thread-Index: AQHVuNQ+iUav85bqMU2T31nkcAPcDg==
Date: Sun, 22 Dec 2019 14:29:39 +0000
Message-ID: <AM4PR05MB3380452CB92A3A59408226A0A82F0@AM4PR05MB3380.eurprd05.prod.outlook.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0088.EURP191.PROD.OUTLOOK.COM
	(2603:10a6:209:8a::29) To AM4PR05MB3380.eurprd05.prod.outlook.com
	(2603:10a6:205:e::10)
x-incomingtopheadermarker: OriginalChecksum:65E4467A647E517D6354A458E3C4B5565172A8CCEEECB9C39A7EC83606351603;
	UpperCasedChecksum:3D418AFD9D2828BF83C1B61EA660F450DB39922890216C5E19A273699BCC1632;
	SizeAsReceived:7104; Count:46
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [2CGJDGzcY6QNI0jF59GA0oxE386VEliy]
x-microsoft-original-message-id: <52f108ec-08ed-9026-d39f-3949691e493a@outlook.com>
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 5e12c3b1-0ff6-4e03-8203-08d786eb60a7
x-ms-traffictypediagnostic: HE1EUR01HT183:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g0FiAI+BDEsqwbL2dWQoMkynoA5pV/tJBuW2MBTYcn7z3aTztQTVrV/ywVf6wuHZ558CyzM7s3bwbNZmnpnKxsGdVuZIzXv8U9pFkN9uZa71akhZcCx2ic86uIm9JUuTqcNhr+DVzKxRJ/rSaC5sT9VLia+/fol0ZJWaxehAyLSiwzcpUTpViw6mNIP7hsNf
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e12c3b1-0ff6-4e03-8203-08d786eb60a7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2019 14:29:39.4790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR01HT183
Subject: Bitbake exception when recipe path contains a blank
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
X-List-Received-Date: Sun, 22 Dec 2019 14:29:40 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFDC4E7E889E2749910D9CD7313B6974@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64

SGkgQWxsLA0KDQpJIGV4cGVyaWVuY2VkIGEgc3RyYW5nZSBpc3N1ZSByZWNlbnRseSAtIGN1cnJl
bnRseSBJJ20gdXNpbmcgYml0YmFrZSANCjEuNDQuMCBhcyBpdCBjb21lcyB3aXRoIFlvY3RvOnpl
dXMtcmVsZWFzZSwgYnV0IGl0IHJlYWxseSBkb2Vzbid0IA0KbWF0dGVyLCBhcyB0aGUgdW5kZXJs
eWluZyBjb2RlIGRpZG4ndCBjaGFuZ2Ugd2l0aGluIHRoZSBsYXN0IGZldyB5ZWFycy4NCg0KSSBj
cmVhdGVkIGEgcmVjaXBlIChub3RoaW5nIHNwZWNpYWwsIGp1c3Qgc29tZSBmaWxlcyBhbmQgc29t
ZSBjb21waWxlciANCmluc3RydWN0aW9ucykuDQpJbXBvcnRhbnQgaXMgdGhhdCBTUkNfVVJJIGNv
bnRhaW5zIGF0IGxlYXN0IG9uZSBmaWxlOi8vLWVudHJ5Lg0KDQpXaGVuIEkgdHJpZWQgdG8gcnVu
IHRoZSByZWNpcGUgYnVpbGQgY3Jhc2hlZCB3aXRoIHRoZSBmb2xsb3dpbmcgZXhjZXB0aW9uDQoN
CiDCoCBGaWxlICIvYnVpbGQvcG9reS9iaXRiYWtlL2xpYi9iYi9jaGVja3N1bS5weSIsIGxpbmUg
MTAzLCBpbiANCkZpbGVDaGVja3N1bUNhY2hlLmdldF9jaGVja3N1bXMoZmlsZWxpc3Q9Jy9idWls
ZC9tZXRhLXNvbWV0aGluZy90ZXN0LXJlY2lwZSANCi90ZXN0LXJlY2lwZS9teWRpc3Ryby9hLmZp
bGU6RmFsc2UgJywgcG49J3Rlc3QtcmVjaXBlJyk6DQoNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZm9yIHB0aCBpbiBmaWxlbGlzdC5zcGxpdCgpOg0KIMKgwqDCoCA+wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBleGlzdCA9IHB0aC5zcGxpdCgiOiIpWzFdDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgZXhpc3QgPT0gIkZhbHNlIjoNCkluZGV4RXJyb3I6IGxpc3QgaW5kZXgg
b3V0IG9mIHJhbmdlDQoNCkEgbG9vayBhdCB0aGUgZmlsZWxpc3QgYXJndW1lbnQgc2hvd3MgYSBz
dHJhbmdlIGZpcnN0IGl0ZW0gKG1pc3NpbmcgJzonKS4NCg0KQWZ0ZXIgc29tZSBkZWJ1Z2dpbmcg
aXQgd2VudCBkb25lIHRvIHRoYXQgdGhlIHBhdGggdG8gdGhlIHJlY2lwZSB3YXMNCg0KIi9idWls
ZC9tZXRhLXNvbWV0aGluZyAvdGVzdC1yZWNpcGUiIGluc3RlYWQgb2YgDQoiL2J1aWxkL21ldGEt
c29tZXRoaW5nL3Rlc3QtcmVjaXBlIi4NCg0KQWZ0ZXIgcmVtb3ZpbmcgdGhlIGJsYW5rIGluIHRo
ZSBwYXRoLCBldmVyeXRoaW5nIHdlbnQgd2VsbC4NCg0KTWF5YmUgdGhhdCdzIG9uZSBmb3IgdGhl
IGluaXRpYWwgcGFyc2luZyB0byBpc3N1ZSBhIHdhcm5pbmcsIHRoYXQgdGhlIA0KcGF0aCB0byBh
IHJlY2lwZSBpcyBjb3JydXB0ZWQuDQoNCkRvZXMgYW55b25lIGVuY291bnRlcmVkIHRoYXQgYmVm
b3JlPyBBbnkgdGhvdWdodHMgb24gaG93IGFuZCB3aGVyZSB0byANCmZpeCB0aGlzPw0KDQpSZWdh
cmRzDQoNCktvbnJhZA0KDQoNCg==

