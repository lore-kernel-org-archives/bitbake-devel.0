Return-Path: <rasmus.villemoes@prevas.dk>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
	(mail-eopbgr60122.outbound.protection.outlook.com [40.107.6.122])
	by mail.openembedded.org (Postfix) with ESMTP id 938907F89D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2020 07:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=IFfz/a0wMPZf4SXQHZSZvPJs2SY/70hcmGJMkdMSCh+fnXU/k5o5b8xbLHYIHYWsMyjznkafntOaPVG3vuei+yR161beEQwrL1ajklYC0Y5qHCNl0Tjs+TUyL4uulTVD5DKMCi+qzVIBhDvbTRJqSmzmdrFSFNgNVndishcRud8qWE3kK8Xl53T+ZQy+Y+pK0BSp0NuxEG666QQzzAeQihKrTE5gXMQB75Ip6dqa5vpr1dCJwbUr3NXTz+tXlwWW4uhtEJYMiMoaNtjbA4ZYKdbSXAJxXDpTX9r5cFgfSjU/JjBu3mmitSpsxA9XfsiLDZfkSu3GV673d0KyjfGC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=b7N8/se5QC7GPt8dEgODBrVUot66aowAPkWXEAu8AO0=;
	b=b7e4n2gQ9D2R+P/iIDtTP53ZRdSayH/SfqZay/T59mSHwMPm+fGXZnxAtn246tKageBezc2Oygw10i5PyKU6jcETvUot9huozp+WmggvTz6kiIBK0FGvdeUmwPErwzfQHU5W05qFY/6yZ9FtA6DUwlK6LfoF+KkT4/h7M5wKGQH/W/nM66meQNaxlUp3vvHVnqUQBvbCe3D7HVBaLe0ok7wpar0jjExh8Ho3zSZvnum7O2gxxVGz+0MhGKFx2a8TMthzF99wqxv0zk/gdqIloUudFdPBIHo9Efn5Yo07o3I5byeRQLh8mog7LWlsnziHv15EIoY6L+CKfjsGb3qjhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk; 
	dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=b7N8/se5QC7GPt8dEgODBrVUot66aowAPkWXEAu8AO0=;
	b=NPJbuP/8KtLtIJiu9PsZEugVxOCFTHFrrmL/Kg6WGMxw8g38xhhzzGG6NieVkrJDnL1Z2FPw7om7+Hu8aIiZJ0StcYCacHxENxWv0hcf4jYrdiGj36V4o2wpDbH/ZZ4NefLTaszPggs+jKNbM5nX1GViQtRwczm0aoUSSahRXDU=
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (20.178.126.85) by
	VI1PR10MB2813.EURPRD10.PROD.OUTLOOK.COM (20.178.204.159) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2644.19; Mon, 20 Jan 2020 07:55:10 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	([fe80::8175:5aa2:2870:766d]) by
	VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	([fe80::8175:5aa2:2870:766d%6]) with mapi id 15.20.2644.026;
	Mon, 20 Jan 2020 07:55:10 +0000
Received: from [172.16.11.50] (81.216.59.226) by
	HE1PR0701CA0051.eurprd07.prod.outlook.com (2603:10a6:3:9e::19)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.13
	via Frontend Transport; Mon, 20 Jan 2020 07:55:10 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] build.py: record time spent executing each function
Thread-Index: AQHVzk/UviyzOepWnki5zcAR3u5NfKfx+QIAgAE4PAA=
Date: Mon, 20 Jan 2020 07:55:10 +0000
Message-ID: <fff6a3e9-80ef-a78a-6f7c-f1e42fa7777b@prevas.dk>
References: <20200118223705.17230-1-rasmus.villemoes@prevas.dk>
	<6df3aa1dbea9cf5318482d25cbe3c26a134e3ef1.camel@linuxfoundation.org>
In-Reply-To: <6df3aa1dbea9cf5318482d25cbe3c26a134e3ef1.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0051.eurprd07.prod.outlook.com
	(2603:10a6:3:9e::19) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:803:e1::21)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rasmus.villemoes@prevas.dk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef956aca-db2f-4116-e19b-08d79d7e12dc
x-ms-traffictypediagnostic: VI1PR10MB2813:
x-microsoft-antispam-prvs: <VI1PR10MB281392BADB721D1EDA2445E293320@VI1PR10MB2813.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(346002)(39840400004)(366004)(136003)(376002)(189003)(199004)(4326008)(52116002)(66446008)(64756008)(2906002)(71200400001)(26005)(8676002)(81156014)(316002)(31686004)(81166006)(8936002)(478600001)(5660300002)(2616005)(66476007)(66556008)(6486002)(66946007)(956004)(110136005)(16576012)(8976002)(44832011)(36756003)(16526019)(31696002)(186003)(86362001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR10MB2813;
	H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: prevas.dk does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4nyrhO4rTi29rAh0j8pEtO27wBWtrQOU3v0AbYtvk7/jQ72BCEGAbNxIuu2zs1GQQYYXIab3zwfgS5xlwuoW0FnrS35zKyRvQDjKVBFOF4ND4ttWP678KfZbZJS9qhm4nQ9+gTlzjiY9p+XUqD85pPgKZ4v7jb2aEjdrvwMBmAphYQ2BC9P9+h96RH/cD2mmlnjHH0DSWW1zhDsCSHgb3qzRRof49e6KNMBUE7+kTO/FtXAZRmkcEJojcPEMFA/DBhnT5q2fUT6+2Caj28wuNo6pEoJb8OIYvKiuBSrdUBQhIT4bBQRt0R5f8pRhkN/6PsSTJRNMtRGXk3MFEBDTDr2CsWXwpC/hpD3vGvay1V0N4tNGB3DIWQMfNhjgUDGNZLFyj2cKrBDm5/++3q8cH0ks1M5EyyeM5ldJ5yCAT5RKN7ju+4/wmfdfC4CXwDe0
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ef956aca-db2f-4116-e19b-08d79d7e12dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 07:55:10.5679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7BZKlabv2QcB84Fh+RZTbAbSGk8nS0XSrn7Dm+QgG6ukT5oPF/xvyKuj9Jd4oKYrcreSHxIX4/El7Oi8G+ZgiwzYsGJMUoX7++YTTGA7u8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2813
Subject: Re: [PATCH] build.py: record time spent executing each function
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
X-List-Received-Date: Mon, 20 Jan 2020 07:55:12 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB764D98D127314DB515009D049FCCAE@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

T24gMTkvMDEvMjAyMCAxNC4xNywgUmljaGFyZCBQdXJkaWUgd3JvdGU6DQo+IE9uIFNhdCwgMjAy
MC0wMS0xOCBhdCAyMjozNyArMDAwMCwgUmFzbXVzIFZpbGxlbW9lcyB3cm90ZToNCj4+IEluIG9y
ZGVyIHRvIGhhdmUgYSBxdWljayB3YXkgdG8gc2VlIGlmIG9wdGltaXppbmcgc29tZSB0YXNrIGZ1
bmN0aW9uDQo+PiBhY3R1YWxseSBoYXMgYW4gZWZmZWN0LCBhZGQgYSBzaW5nbGUgbGluZSB0byB0
aGUgbG9nIGZpbGUgZm9yIGVhY2gNCj4+IGZ1bmN0aW9uIGV4ZWN1dGVkIGxpc3RpbmcgdGhlIHdh
bGxjbG9jaywgc3lzdGVtIGFuZCB1c2VyIHRpbWUNCj4+IHNwZW50LiBUaGF0IGNhbiBhbHNvIGhl
bHAgZmlndXJlIG91dCB3aGljaCBwYXJ0cyBvZiBhIHJlY2lwZSBpcw0KPj4gdGFraW5nDQo+PiB0
aGUgbG9uZ2VzdCBhbmQgaGVuY2UgZmluZCBwbGFjZXMgdGhhdCBtaWdodCBiZSB3b3J0aCBsb29r
aW5nIGF0Lg0KPj4NCj4+IGJpdGJha2UgYWxyZWFkeSBoYXMgdGhlIC0tcHJvZmlsZS8tUCBvcHRp
b24sIGJ1dCB0aGF0IHByb2R1Y2VzIGFuDQo+PiBlbm91cm1vdXMgYW1vdW50IG9mIG91dHB1dCwg
YW5kIEFGQUlDVCBvbmx5IGNvbmNlcm5zIHB5dGhvbiBjb2RlLCBzbw0KPj4gd29uJ3QgaGVscCBm
aW5kaW5nIHN1Ym9wdGltYWwgc2hlbGwgZnVuY3Rpb25zLg0KPiANCj4gU2hlbGwgY29kZSBpcyBl
eGVjdXRlZCBieSBleGVjX2Z1bmNfc2hlbGwoKSBzbyBpdCBzaG93cyB1cCBvbiB0aGUNCj4gcHJv
ZmlsZXMgYXMgZXhlY3V0ZWQgdGhlcmUuIFRoZSBtYWluIHNoZWxsIGNvZGUgaXMgaW4gZW5kIHRh
c2sNCj4gZXhlY3V0aW9uLg0KDQpIbSwgb2ssIGJ1dCB0aGF0IGRvZXNuJ3QgaGVscCB3aXRoIHRo
ZSBwcm9ibGVtIHRoYXQgLS1wcm9maWxlIHByb2R1Y2VzDQp3YXkgdG9vIG11Y2ggb3V0cHV0IHRv
IGJlIHF1aWNrbHkgdXNlZnVsLg0KDQo+IEknbSB0b3JuIG9uIHRoZSBwYXRjaCwgaXRzIGNsZWFy
bHkgdXNlZnVsIGZvciBkZWJ1Z2dpbmcgYnV0IEknbSBub3QNCj4gc3VyZSB3ZSdkIHdhbnQgaXQg
Zm9yIGdlbmVyYWwgdXNlLg0KDQpJTUUsIGhhdmluZyB0aGlzIGtpbmQgb2YgbG93LW92ZXJoZWFk
IGFuZCB2ZXJ5IHNpbXBsZSBwcm9maWxpbmcgaW5mbw0KYXZhaWxhYmxlIGV2ZW4gd2hlbiBub3Qg
ZXhwbGljaXRseSBhc2tlZCBmb3IgaXMgdmVyeSB2YWx1YWJsZSwgYW5kIG1heQ0KaGF2ZSBtb3Jl
IHBlb3BsZSBhY3R1YWxseSBsb29rIGZvciBib3R0bGVuZWNrcy4gSXQgYWxsb3dzIG9uZSB0byBz
YXkNCiJobW0sIGZvbzpkb19pbnN0YWxsIHNlZW1lZCB0byB0YWtlIGEgbG9uZyB0aW1lLCBJIHdv
bmRlciB3aGF0IHBhcnQgaXMNCnRha2luZyBzbyBsb25nIiwgYW5kIHRoZW4gb25jZSBpdCBmaW5p
c2hlcyBpbW1lZGlhdGVseSBzZWUgImFoaCwgdGhhdA0KcG9zdGZ1bmMgaXMgd2hlcmUgaXQgd2Fz
IHN0dWNrLCBhbmQgaXQgc2VlbXMgYmUgTyhuXjIpIGluIG51bWJlciBvZg0KZmlsZXMgaW5zdGFs
bGVkLi4uIi4gSWYgdGhlIHRpbWluZyBpbmZvcm1hdGlvbiBpcyBub3QgdGhlcmUgYnkgaXRzZWxm
LA0KaXQncyBtdWNoIGhhcmRlciB0byBnZXQgb25lc2VsZiB0byBzcGVuZCB0aGUgdGltZSBkb2lu
ZyBhbGwgdGhlICItYw0KY2xlYW4iLCAiLWMgY2xlYW5zc3RhdGUiIGV0Yy4gYW5kIHRoZW4gcmVk
byB0aGUgcmVjaXBlIGJ1aWxkIChrbm93aW5nDQp0aGF0IGl0IHRha2VzIGEgbG9uZyB0aW1lLi4u
LikganVzdCB0byBmaWd1cmUgb3V0IHdoZXJlIHRvIHN0YXJ0IGxvb2tpbmcuDQoNCj4gVGhpcyBw
YXRjaCB3aWxsIGdlbmVyYXRlIGEgbGFyZ2UNCj4gYW1vdW50IG9mIGRhdGEgdG9vLCBpdHMganVz
dCBzcHJlYWQgb3ZlciBhIGxvdCBvZiBwbGFjZXMuDQoNCk5vdCBzdXJlIGFib3V0IHRoZSBodWdl
IGFtb3VudCBvZiBkYXRhLCBpdCBhZGRzIG9uZSBleHRyYSBsaW5lIGJlc2lkZXMNCnRoZSB0d28g
IkV4ZWN1dGluZyB4IGZ1bmN0aW9uIHkiLCAiWCBmdW5jdGlvbiB5IGZpbmlzaGVkIiB3aGljaCBh
cmUNCmFscmVhZHkgZW1pdHRlZCBmb3IgZWFjaCBmdW5jdGlvbi4gSSBjYW4gZm9sZCB0aGUgaW5m
byBpbnRvIHRoZSBsYXR0ZXINCmxpbmUgaWYgdGhlIGxpbmUgY291bnQgaXMgYSBwcm9ibGVtLg0K
DQo+IEFzIENocmlzIG1lbnRpb25zLCB1c2luZyBzZWxmIGFzIGEgdmFyaWFibGUgbmFtZSBpcyBi
YWQgcHJhY3Rpc2UgdG9vLg0KDQpZZXMsIEknbGwgZGVmaW5pdGVseSBmaXggdGhhdC4NCg0KUmFz
bXVzDQo=

