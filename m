Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99BFFC981D
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 09:01:33 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47161.1774861286401995106
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Mar 2026 02:01:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Qus6lDY5;
 spf=pass (domain: siemens.com, ip: 52.101.65.70, mailfrom: adrian.freihofer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTuZ1jj85lU4ZKlxyCedpBAeZmxwWcB9OEW3vF44jr6jgPF3BESdXNz56FbTR4UlLYd60JaJUaXjD4EQ7ODT3Gz+/OJJYkMOzx5peAoQtzd2JcpioSdd01g23kEt3vCWBi6Q9v3mXbUnr9f1ecQJuw9Q2UW8MDzytv7aBTkWKqVw3xwXPYGmn9PVCkvdlrHSxdi7bb7gHYtv+qpRtY4KeIwgoRL3eR2L1GZ3TcxNi3D9Nb57E7C+fbPqJfHO7PniFMrAbsbO3x4k1mAVOh8qlWfbH3BNEVKnTTQeKidqxTQC8iBDgB6npX/jbBHmencQd5vVvFiMX7Ep783X1msllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8goNg0aNQuy++Qc3IcIoT0uRTLoYjAtPJ1loH4SBOU=;
 b=VYiu5nAF71yM1yEbx3OO6M+LKIhLo1zEg5n13HAxs0ARnch+1voB/M1VT4FMMrLVPrzMugUGJsaLwTtod7ca5L8Cyo2MBru2vimAS5I6+OBZwzUosZ7+yYPzxHC5B3o8ztRQn8x/fmKuIsRQN8srRNYDXO+fcvNBplibGDMyUM2ZiocfaL/IyIvYXkLqsf5LpZBDEsSaOU+sL+JVtPNXRhIyE+SOL/tRFtMXasZN+YG6zU/29Phxh/W0sSv9kyg/eP4+eOV0LC1Up61tM+2RRRsBqZfUhSTbLVhRJD8fg6LQSJmhPHdmnVxmSic56XdHreqmKTlu0ma6MEeyOksocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8goNg0aNQuy++Qc3IcIoT0uRTLoYjAtPJ1loH4SBOU=;
 b=Qus6lDY53XQmllWLNSpG/8IUOvUJp91kvNK5zbjnpfrcehRTURBfW59qiZHUHcb78egRrcocdesTuRUaM1ELl3EA3ss85GkqhBgaYg/+wO/Cm7ZN3n5GFVW+s19z7AcwtBv0qzlsrWjLLm9FehgiIpl9ZDPO8X394PKAQXeHV478WHfv1GtMki4z8EsehzhdYTyFfbRM5WMBqnhvVDlDjN8g+D8l/PT/0thI4+f+kvOz1xcbNCp0H5Tb4o32/xTyIz5GDyKHi2D1HyRWQ8Tv3x8WGfNd4qXS1OsfPqN8NRvs+msnpZIq4eBhHKzX5vcFRyHwKhsEjiFUeMnm+iK4mg==
Received: from AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47f::8)
 by AS8PR10MB5830.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:50a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 09:01:22 +0000
Received: from AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d515:f4e4:e935:ee4f]) by AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d515:f4e4:e935:ee4f%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 09:01:22 +0000
From: "Freihofer, Adrian" <adrian.freihofer@siemens.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/14] bitbake-setup: improvements,
 VSCode workspace generation
Thread-Topic: [bitbake-devel] [PATCH v3 00/14] bitbake-setup: improvements,
 VSCode workspace generation
Thread-Index: AQHcv6qpGXBZ+OUNsEictIWGCCE1v7XGqRUAgAAfI4A=
Date: Mon, 30 Mar 2026 09:01:22 +0000
Message-ID: <e1fe66216b8b426198689c8acf27fb1c21daa800.camel@siemens.com>
References: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
	 <565cf6848e8f3c0f9e626a61e27cb7ed482fe33f.camel@linuxfoundation.org>
In-Reply-To: 
 <565cf6848e8f3c0f9e626a61e27cb7ed482fe33f.camel@linuxfoundation.org>
Accept-Language: en-US, de-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5724:EE_|AS8PR10MB5830:EE_
x-ms-office365-filtering-correlation-id: 711c2cb0-128d-46ce-43c6-08de8e3aea33
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003|55112099003;
x-microsoft-antispam-message-info: 
 Wt/2eKQTcvaZhT7w/v+EVAJxaHM80xA7TFFqPYs1Ke0NdWYWSmS2FwKVYYLrJSPon4l3+X6u9Py6tWmXRHaxOy8u1fA8VUCxHog/yE1rRdXAyUZjYqDXtq4vpLEz3AWa+YE79QZObhbV2URBaiY3mSQySuhhAHsz6gFEqxV/6sU8p9nDNOp/jHb6skO7pSDW4fyUTZIupTHTcBXuMMpGkefPZxNe7pui12nxvuxIglBV1xrEnqnA9PNOBdi+R5zwKYnJTXaFwixFotzcmCm51R68Ot4YkTJ22rdgH1z2i5qbgfpbk34+hgP5cUQVj0OMZrdWflshApjYWDa/bMwjtzQylskxS2wwIulUtPE21w5WT4E9PyWQHGxyExTg1o1NB2h792sLbFurliKgNh4WqzkLePiMggrFvZY4cukc7i1hlJtU9wVzQjnvktpmFI4C9uCj8IWWSVrEgwFkAhsJkXCx1sVdxLtUTmkY7P2w2h2TS+dSqXATgmt4KB5GUCfc9yLEsq/Yb8diZ2V2WNSDLaHOWKbwdxQEB/bbeYQdtRVhL+41z4ta8xWFhZGHUZ9vmsMWU4iw1KklyCgAOtQJGayxkrzqs3K1tOqIfHm2ZKJg60k1eO89lTqD6xuCP/t0B2M2G2SrDlGg2XMWiz7ipB8AqCYmxwJz0BEvYu1mwhq1tQOYDhilmMtW0A0IGM4Fz5jhVT8b7yW/FOgxITx3qU14KSjvlnLAV50HYn83HqI16eSoCeKHs0jg5gQzRAwb
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UkZMa0Ryelo4NDJPQjUySVJzQ3VmMXgvR1h3OWltd1J0aWFGNzlmQ1dLVDZw?=
 =?utf-8?B?L2YrSUx2Y0UvcFRrU0dmMTFKUDE1aUl1RlpCQkRTVE9zaVVrU3ozU0tDQllj?=
 =?utf-8?B?SmYwV2JlQkxMZysrREllMm5tR1doSmxpQkZYWlVhUEh6ZzBRb0lKeURwN1RV?=
 =?utf-8?B?bzlJdVhMZnhSRWw4ZkFrcFVma2pFZU5nU3NueEVrTVFXZlBkT3FNTVJRNTV4?=
 =?utf-8?B?eU1qWVN4K1lqSXlHUkVDcWZpNEV3NkF2UXdyN3JQQ1lhR0ZSdndJbjlBYWhu?=
 =?utf-8?B?WVZaZ29pTythWmdjNjR1SmszdEFUaG5mK0grekNaMllUakZZWjA2QzVwbUp3?=
 =?utf-8?B?K0RvVHBQNHp5aFl1Y0kxZ3JUMWMxSUMzcU1jeHlVMHI1blVNNlYzaUtWL2lI?=
 =?utf-8?B?WnhSWDA2b3Q5cUVnNCs5djM0dXFoelJacDA4Sjh1TzJta21LRGdWK3FmLzRI?=
 =?utf-8?B?MUJMeG1ZVlZVUHE0d01wc1ROclJRWDVPdG9IYVVOZnlXYUU5QjFCWDFzbThF?=
 =?utf-8?B?djRPK2NQOHpmM2hLaXFNWWt4UzJNWUlxbGgvK2REVEMwYi9tM2tNaXB4Qy85?=
 =?utf-8?B?SUNDdEl0SFJJOVFWdHJZZk5XMTFjME5aaGdobHIzVTlqVHNCTnhyZjk3R1Nj?=
 =?utf-8?B?VGVTL1M3N2oyNTVFa1pDcjZpNGdDSWxpOEFIQUhSeGEwUG9YTWlWbXRhYS9I?=
 =?utf-8?B?U1NLRjJQMTJTMUpBdUZWVjlXNi8zVVBqdlpGWlFXb0RPaUE4RGFzM0Y1Z2Ez?=
 =?utf-8?B?VUorOCt6V05xRUZKRkd1NXIwTDBoWTg5V1I3czJMUFJXM3N1VkhwUkpMYjZp?=
 =?utf-8?B?aXFPQTlYc2ZrZ3VTbjl5Y0tEQUNKZlozMGZFWDlNckZTYUxCb1I0eHgxZVkr?=
 =?utf-8?B?UjJFdVVWTmthZ0UxeXpXSHU2WDc3L2xIb0FORWcyR2pZYkVtS09GbGRtSmsz?=
 =?utf-8?B?NEtzbEIwdUhCTHFmOU5LMzd3c3BlR1o4eHp6WVgvcVNRUWEvRVBzWWZ2b0Nz?=
 =?utf-8?B?Vzc1aGZwSWRiempPcGRYQ1lIYzRVS0NINHNQbW1zZXBxUDVnMzBHenVweFhy?=
 =?utf-8?B?dDhiZGhQM2pLSzZSNlk5cnN4TE5UMmpLMTczTGxLQytaYUVpNHE4WFp0SVN0?=
 =?utf-8?B?M28yWjdwcXd1RFZFdWgvVDlBVExPYlZoeDVsMVpRMWwySmJ3YWxKV2ZNMGtn?=
 =?utf-8?B?MStQem1wZ21OdEtPZ240ZC9NZVIzajVaYTdpMmZaRHFsRkxmSEtoS3lDbFFV?=
 =?utf-8?B?R3F6aDMyekZJU05YcWUvN0o3NzJuU096K2VmSDBrV3RjSGxhakFFNHZ0Uit4?=
 =?utf-8?B?WEF5NWJlakdWT3puZFNWVVFRL0J4bXJwcFFsSW1YN2ZhLzJMTzB4UDVrNUJM?=
 =?utf-8?B?VGszSy9ELy9COXpOeDEwZzhCWWI5eVpMTGJjaVhMTnZXVUpRcXkwUG5HaW9p?=
 =?utf-8?B?K1p6K0NQdmlhd3lUQ3JsUjZteitLVlpFVmtjc2x1dEF1Sm5RNEx2clJqYkw0?=
 =?utf-8?B?dEkybmkrdUlFYTN5ZEpPN05oS1JPR2tWVFBuTm1XS3piWDRUQ1M5ZGVwbmtK?=
 =?utf-8?B?ZFc4WWxpa2xlT3A1ZDlZUnU5SlkrMmhYUHJCVGNRNC9YNXk3R01ubXRiYkhN?=
 =?utf-8?B?VGJUdTlqTFNVbXlLd0dHMVNFeDBHUzhXckRMd2wyaVVDL0prUFRKRy9CWlp4?=
 =?utf-8?B?b2Z6MDMreHZ1SXBzbksvR0VEdlFId0ZvS0hzTGRmaldJdGpPVWdZUXhMeTZL?=
 =?utf-8?B?K0lYWWpBYjBVcTBxVW1Vdk8rMFVFMnRFNWhRbjlNSWlvU2IxSStyT0U3czJC?=
 =?utf-8?B?U3ZGTEt5dFRrV29KNmZ6bWZIdkF0a3MyeDRkWUNHL3hZZkpSZFdhMjgxTnVP?=
 =?utf-8?B?ais3ZENjcENhems2Qi9xOHQwUlZTSlNQK2xhOVBHTlZoTkNOL0ZlMmkrSWcy?=
 =?utf-8?B?NGgxYmxoNUE4N2l5NXF4cDNTM2RHajZoL3RsZWUyRjBQaFo2M2VLK0hIMWcv?=
 =?utf-8?B?dkJyQnRQZ1MyV1BJbkdSU1pqeUtYY280OUtzWFRDVm5oTW53MzFDT3JTQy9t?=
 =?utf-8?B?NnJqaHdvQ3VmTmQ0TXhibGVSTkdpY2p6YlhCeUNabzlJRU56ZHdad2dyWlZT?=
 =?utf-8?B?MVdLb0dsYTlIWVo2OGdVSHZZNnFYWlB3TDMrR0R2Rm01MXBNWEVaTFV5bmJN?=
 =?utf-8?B?Rmd4VnVzeWpQZGFBcFRxNXNNNnFzd2JLOWRiMmtRdGp2VzM0YnE1V09MT05o?=
 =?utf-8?B?K0w4VjZtRkJTejRzVGcyWk5XTWVhcUFKNEl1N2hRSlZCWlpBZDAvbW90OVRC?=
 =?utf-8?B?THR4T24vZlJxM1ltUEh4ZkR3NW16TGQ4N2k2RkZxdGphenhQUlBrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3AD7C0BC9F2174497CDC670DDC4EA4B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 711c2cb0-128d-46ce-43c6-08de8e3aea33
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 09:01:22.1339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4nH/nqWPJdGD/efe8dBMNyHrGecPw9agYh1CfvaXfWq5sVZ/uPZYJswkvpIRWrRgNU2FN6+vK8bWlbf+U2CF9tXO4e599ttIhLCINkXNULI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5830
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Mar 2026 09:01:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19279

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDA4OjA5ICswMTAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gT24gU3VuLCAyMDI2LTAzLTI5IGF0IDIwOjMyICswMjAwLCBBZHJpYW4gRnJlaWhvZmVyIHZp
YQ0KPiBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIHdyb3RlOg0KPiA+IEZyb206IEFkcmlhbiBGcmVp
aG9mZXIgPGFkcmlhbi5mcmVpaG9mZXJAc2llbWVucy5jb20+DQo+ID4NCj4gPiBDaGFuZ2VzIGZy
b20gdjIgdG8gdjM6DQo+ID4gLSBSZWJhc2VkIG9uIG1hc3Rlci1uZXh0IGZyb20gMjkuMy4yMDI2
Og0KPiA+IC0gTmV3IGNvbW1pdDoNCj4gPiAgIGJpdGJha2Utc2V0dXA6IEZpeCB0eXBlIGFubm90
YXRpb24gZm9yIGRlc2NyaXB0aW9ucyBwYXJhbWV0ZXIgaW4NCj4gPiBwcmludF9jb25maWdzDQo+
ID4gICBtaWdodCBiZSBzcXVhc2hlZCBpbnRvIGNvbW1pdCBvbiBtYXN0ZXItbmV4dA0KPiA+IC0g
TmV3IGV4Y2VwdGlvbjogYmIuZmV0Y2gyLlJlYmFzZUVycm9yDQo+ID4gICAtIEFkYXB0ZWQgdGVz
dHMgYWNjb3JkaW5nbHkNCj4gPiAgIC0gU2ltcGxpZmllZCBjb2RlIGluIGJpdGJha2Utc2V0dXAg
YWNjb3JkaW5nbHkNCj4gPiAtIE5ldyBjb21taXQ6DQo+ID4gICBiaXRiYWtlLXNldHVwOiBjYXRj
aCB1bmV4cGVjdGVkIGV4Y2VwdGlvbnMgYW5kIHNob3cgYSBjbGVhbiBlcnJvcg0KPiA+IG1lc3Nh
Z2UNCj4gPiAtIERvY3VtZW50YXRpb24NCj4gPiAgIC0gZ2l0IGZldGNoZXIgdW5wYWNrX3VwZGF0
ZQ0KPiA+ICAgLSBiaXRiYWtlLXNldHVwIG5vbiBkZXN0cnVjdGl2ZSB1cGRhdGUgbW9kZQ0KPg0K
PiBTb3JyeSBBZHJpYW4sIHRoaXMgY2F1c2VkIGFuIGlzc3VlIG9uIHRoZSBhdXRvYnVpbGRlcjoN
Cj4NCj4gaHR0cHM6Ly9hdXRvYnVpbGRlci55b2N0b3Byb2plY3Qub3JnL3ZhbGt5cmllLyMvYnVp
bGRlcnMvNS9idWlsZHMvMzQ0Mw0KPiBodHRwczovL2F1dG9idWlsZGVyLnlvY3RvcHJvamVjdC5v
cmcvdmFsa3lyaWUvIy9idWlsZGVycy85Mi9idWlsZHMvMzQ3MQ0KPiAoYW5kIHByb2JhYmx5IGEg
ZmV3IG1vcmUpDQo+DQo+IFRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToNCj4gICBG
aWxlICIvc3J2L3Bva3lidWlsZC95b2N0by13b3JrZXIvcWVtdWFybTY0LQ0KPiB0Yy9idWlsZC9y
ZXBvcy9iaXRiYWtlL2Jpbi9iaXRiYWtlLXNldHVwIiwgbGluZSA0OSwgaW4gPG1vZHVsZT4NCj4g
ICAgIGRlZiBwcmludF9jb25maWdzKHByb21wdDogc3RyLCBjaG9pY2VzOiBsaXN0W3N0cl0sIGRl
c2NyaXB0aW9uczoNCj4gbGlzdFtzdHJdIHwgTm9uZSA9IE5vbmUpOg0KPiBUeXBlRXJyb3I6IHVu
c3VwcG9ydGVkIG9wZXJhbmQgdHlwZShzKSBmb3IgfDogJ3R5cGVzLkdlbmVyaWNBbGlhcycNCj4g
YW5kICdOb25lVHlwZScNCj4NCj4gcHl0aG9uIHZlcnNpb24gc3BlY2lmaWM/DQoNCkl0J3MgdGhl
IGZpcnN0IHBhdGNoIHdoaWNoIGFkZHMgb25seSB0aGlzIGxpdHRsZSAoYXMgSSBqdXN0IGxlYXJu
ZWQNCnByb2JsZW1hdGljKSBkZXRhaWwuIEl0IHJlcXVpcmVzIFB5dGhvbiAzLjEwKy4NCldvdWxk
IHlvdSBsaWtlIHRvIHRyeSB0aGlzIHNlcmllcyB3aXRob3V0IHBhdGNoDQoNCltQQVRDSCB2MyAw
MS8xNF0gYml0YmFrZS1zZXR1cDogRml4IHR5cGUgYW5ub3RhdGlvbiBmb3IgZGVzY3JpcHRpb25z
DQpwYXJhbWV0ZXIgaW4gcHJpbnRfY29uZmlncw0KDQpUaGFuayB5b3UNCkFkcmlhbg0KDQoNCj4N
Cj4gQ2hlZXJzLA0KPg0KPiBSaWNoYXJkDQo=

