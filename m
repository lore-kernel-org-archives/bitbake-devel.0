Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC87C54E64
	for <webhook@archiver.kernel.org>; Thu, 28 Mar 2024 14:06:58 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.89])
 by mx.groups.io with SMTP id smtpd.web10.17180.1711634809011319352
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Mar 2024 07:06:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=Ke4kkWtS;
 spf=pass (domain: axis.com, ip: 40.107.22.89, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG7lH2kkHwMXOVv9disDPluktbk5IvIu98sHjzyOqw75x5aAub3JtJHKv99cHUveyIqvmSSWgLq1t+4XY4B2/FZ+Rran41eFBNaoCIdIxUN+WvWQCrQavfswPwuu1h/yMst/ggWd/1rK97ZboHYBh3ZbNgT+sZOdJsrArw6VF7icFhCuAVdba5uUybRr1T9Qi2rCIaJsaroY5APR1Bvi7WUeovD1AO1a469lu9gftkBkIvS2IEjQdFMNOf8kmCJ47VqL/6FS8twToMFwT0gMTaALC+J6IWovEws1RF1WpDaw6+dDo8E8OuvPVR+qhg6Lpb9NLlqo8egPvUDEq4KlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZEyy2q/ZAebcoDbii+rg0mjSq2IVCpGnHKz2Gi+ZFA=;
 b=J0I2HzMPIrXXyuBM0iJOwXbsd4ZRAnxizKd9JD547VrArWi5OpQlLIaVOZ9tF7YnGIscE3PHgt6qTkwI8UobV+ztxF9lTmeEt3Ek9Yr4Af1VJN2N9by+IwhIo7eU4qXaugxl4VZFRC/1BHk/en/5KR73a0fg0FZxybdfK9NJrl9v2rGRZE2w6X50EI0u2XbLenL6KuzMMdPKuDAdL9GwWPVL0kTTQIDgtx1YMaTskuOeqLlPtQiKAhV6jA1pj60T5u8vliJgWoQsHsaX8A3awFYgIvE1UK9T5Esjy3VTX1Iv/PKPigymO+F+DudNiMleJxRvFRi5E2LEeatN6gIbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZEyy2q/ZAebcoDbii+rg0mjSq2IVCpGnHKz2Gi+ZFA=;
 b=Ke4kkWtSgHt195j8gL4lXd3Ay6EJdyyj32UvPjnMOU/+Kx0RY2VVyX+UpSxsO/pmlK5jIfQRiGSCc2iC8RVjI4lcws1yiVIYbw2P5oiBGowZG7ECPkDpeIP4uKTaajnepEpHnn4Cq1RBJqTnZ9iWSXk9o72R9BxKRByTAipPkQY=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS2PR02MB9763.eurprd02.prod.outlook.com (2603:10a6:20b:60d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 14:06:45 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::fa03:deff:aae:c4d0]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::fa03:deff:aae:c4d0%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 14:06:45 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "nvhieudt11@gmail.com" <nvhieudt11@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] Support add-layer to prepend
Thread-Topic: [bitbake-devel] [PATCH] Support add-layer to prepend
Thread-Index: AQHaexyOk/9RwmFAIUaCkR3vYwnhALFMwgkAgAB5roA=
Date: Thu, 28 Mar 2024 14:06:45 +0000
Message-ID: 
 <DB5PR02MB1021362ED90F20C176D61E024EF3B2@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: 
 <9063a1127c8d569337ed4bea269b3168de780020.camel@linuxfoundation.org>
 <23497.1711608590865460022@lists.openembedded.org>
In-Reply-To: <23497.1711608590865460022@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS2PR02MB9763:EE_
x-ms-office365-filtering-correlation-id: 9c6d6f63-23f3-471b-bd9a-08dc4f304d63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OQxlpNnLFqR2xYvVN1q3gsOcJbDaZ7ldvA6xIDsHyz52LmTmm15OouhCVRwm9KuNBw635kfRKg/Q+K5MqTuWobezJ9OzsC6b34RWOp5sKQATPlLnlsSKCbOUVVP3cVhVkMrJhZXS8Bx9Vla416hLz7tG97B2qOtuLUoEK6jbhWP55EcMYgPKHNxZ4JTsxtgGhxBJOnGAW6+LQHxrla31McPqbn69rrZ3kAq6gPp16t1iUieqgXyKNDO4L3oj0nS6ONKbegHIfkKvP+AU7nI0JBmSNIg0tCsX9+6Oclsr2K25YYF4O9NEecuJoh6Ei/857r16lNYRDVr6QUOD5Q7aoriGGDBfgdafJ9oCIxol6oC7ucvM2dD6IAf2OdAMq2Bvu+/RrYSCCNgP7NTSuY6DpQak4Cj6ECYt+lkxKWgD+RwHgs+ppg8gvWc/ExFrlMSf87Q6JjLDsS/PcmwAiKEGRcADl9lA9QCcK4hXgXCHEbSsFoyu/a91pr3Zfyf68MpvwiXnZnD6MNyEwUZYExPQg7r1/blOIsTqZa1pJSIob0fSGke1hiGJfQnvmp9/k/UrWwHDphVWll67dmNKTDEpPngnKLnL/6d/PgnlSQ+V+ibc/om1GohUBcx7v/j/mRDNtWr5PeLnLTCOJw3xhxfTdKOzadSq59BLi00Sl0Mltyk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bnFwZlZzb2ExK0dBMDNFMmpobW1QSGJKM3JkYXppSWd0TTBhN0Yxd0tiSlR2?=
 =?utf-8?B?dTF5SUI2Y2djTFdIbllZM1lHbVJsQks2WUs3RVVaUUE4aWcyV1VXemNJUlJ2?=
 =?utf-8?B?aiszMk9PZFJwSGVGSUs2NURPS3R2dHBPOHUxcnUxdDRVdS9iZ2h6NHdsU281?=
 =?utf-8?B?NC9HcG16cWxGTTNXTkhmUFlQYmlKWHFkbVZYRm5ZSnVBeGxtcGh5WnVGcDdr?=
 =?utf-8?B?MXRMci92aDFGdDJmNmtBVlFmaEI0aVhmU0FZb2hlOVFieGlTU1JLOTJHMDhL?=
 =?utf-8?B?U0VESGxScWY5a3R2K0MvKzVSU1Nna0hYZ3VHbm4vcHhVZnUxL0JIN3pNc2N3?=
 =?utf-8?B?Y2xkTThwWnBoaGgxMjBadjYvcG5FcEsvRFgrTW1ESnNNdUdPeEwvMWJZU0k3?=
 =?utf-8?B?KzlJVnRUQ3hkYTRNWkFHOW9XVk1CaFRzNkp5K3kxaDl6MHJPZzBRc0RsOHdu?=
 =?utf-8?B?blNMdUQ1cUhjay9nS1R6LzZSQzZidmJWMW90eVA3OHZiY21LYSt4bTR3cmxB?=
 =?utf-8?B?dVRzdmtKOVp6bHBiaHN4cWZVNm44Rkdld0pJYWZiSE1WL3BvSjBaWkxSREpx?=
 =?utf-8?B?clNQcVA2ZFdRWlBUL2hiejF3VUk2alQyMVhCTVRLMmRubWpnNkxTYk5RTFNj?=
 =?utf-8?B?c0F2TGdpTkREZHFoMGxOUlBneWdNRGYvcXl0WGUwVXkwQmN4MmRKMVcwSlAx?=
 =?utf-8?B?VEVzNmhsVUMyYldqb1ovQUoxM01hc1h5R2NOUC9iREt1eW44V2o2MTQxeWNr?=
 =?utf-8?B?anhPMjVlZ0lTOXFQSTN4ZWhaMEx3YXlyakNyWWtlalBIcGVtcVQxRXcwYXJE?=
 =?utf-8?B?VHhRVHdHOU5hdzBrclg2RFRSWXFBYU9LU3hCbCtjc21pamYyb2xLSkRlc1kz?=
 =?utf-8?B?ZXdEUG8xaE9vWDRRbE12endNcEhoMWpJSnhEUmtDdHFnRVR4TVFVSTQ4K2h2?=
 =?utf-8?B?bzhROHdoVEJpbDBVU25TdTBITVFvMzNRV1VWa1g5a3JzdGlScG9wNERTVjRj?=
 =?utf-8?B?QkVCTHN6REpYUjlIdU9XMHZLcmRCQzNPQUZlUXZRdFNONXYwVHUzeTFCekhs?=
 =?utf-8?B?aHAxQVc1YWhVYmVDbXprTGV3WnFIeG9aYkRsTnRncklUSElyVlVYcm9Fa0VS?=
 =?utf-8?B?K3dJTU5kQmw4dVUyWmw2MndNK2JJc3hGTGo2bUJnZGMxNkFQTllhSWZrQS9E?=
 =?utf-8?B?K2V0NHU5bnlPeGNybFNMNDNqbGZWVnNkY0hFMXcvVUlnRnpSNmFaOFdqQXI1?=
 =?utf-8?B?YmhJQ2d1QXAwTnByVTZDclBJR2RTTHlRZEVZVTJoRXRqamp1VERDRW9DRFNS?=
 =?utf-8?B?SDR0eW8xUkk2VEExTWRWVGtyMHlGV1VMdHR1dGV3MlIrKzE5V1VLSTRPU3lk?=
 =?utf-8?B?RWNKVjhGT0NBUW1ONnlHY1ZZc015SFk5UXgvN1k5cVBCamMraXNHeXV5ZjNO?=
 =?utf-8?B?dFA1Mll0VnZQSEs4TmFnRTdzV3MrcmRPOXdIVXNGcklFdW1tV2NsQTZPTE50?=
 =?utf-8?B?a1Z6TWliQUc3M09nVEhxK2lhZUw5NjRuM2ZNRnE1UDkrVnpybFdicEVIeCtp?=
 =?utf-8?B?ZUF2RWU5bVVaV0NJQUpqRDlteGc1L1EwMDJLZjVSaUpkLzk1akdISFk4V1RU?=
 =?utf-8?B?U1BxbGl5VmZQZmM2bHZrT3o4S1Jra1ZQeDd1dExFOUhRTFA3cFROWmI4bmhI?=
 =?utf-8?B?djRNNzlyU2dEdWh6S2swV2k2YXNYZ0FnZzQ5UldKZWdqMTYzRGpnWldURHVr?=
 =?utf-8?B?VDlyYytwNVFNTlF5U2FpMGJtMFY4ZTVGTW9tR0x4amF4NzFETVRxdEFhR0xz?=
 =?utf-8?B?S2I4VUNsTUR2Z2pLNXdFR25mcFYwb3FKU09SOHg3SmdpMVcyanFmcVg4Y3gr?=
 =?utf-8?B?YmMyd1JCaGJvYVhmempDU1dmTXNDcnNjTDVyTTVLYm52ZEJ3NUhua2JkZDgr?=
 =?utf-8?B?LzA3SVFLS0F6MWpodms0ejdJL3JCWE9mcDU1S3ZoWDNSUE5FQWhjamtwQk5u?=
 =?utf-8?B?RFkzNW5uQ2c1djR6ZmRXVGo0R1BEZEdGdW9YNVJKRS9uODVsRit2ZlA1NGgz?=
 =?utf-8?B?bDBVanhyd3hMbklyZUtOMThFcmxXNGF2K0dCbGE0KzRHR0Y5ZllzMGkyWmJr?=
 =?utf-8?Q?z7cw=3D?=
Content-Type: multipart/alternative;
	boundary="_000_DB5PR02MB1021362ED90F20C176D61E024EF3B2DB5PR02MB10213eu_"
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6d6f63-23f3-471b-bd9a-08dc4f304d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 14:06:45.4619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nM6ECKFdgTip526KBluPJ/tGJjJ8tHyb6twUlbBcUusIH+VlRcAR29Fey0gWcuo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9763
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Mar 2024 14:06:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16020

--_000_DB5PR02MB1021362ED90F20C176D61E024EF3B2DB5PR02MB10213eu_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

UGxlYXNlIGNoYW5nZSB0aGUgY29tbWl0IHN1YmplY3QgcHJlZml4IGZyb20g4oCcYml0YmFrZTri
gJ0gdG8g4oCcYml0YmFrZS1sYXllcnM64oCdLg0KDQovL1BldGVyDQoNCkZyb206IGJpdGJha2Ut
ZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyA8Yml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1i
ZWRkZWQub3JnPiBPbiBCZWhhbGYgT2YgbnZoaWV1ZHQxMUBnbWFpbC5jb20NClNlbnQ6IGRlbiAy
OCBtYXJzIDIwMjQgMDc6NTANClRvOiBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5v
cmcNClN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gW1BBVENIXSBTdXBwb3J0IGFkZC1sYXll
ciB0byBwcmVwZW5kDQoNCg0KSGkgUmljaGFyZCwNCg0KSSB1cGRhdGVkIG15IGNvbW1pdCBhbmQg
cnVuIG9lLXNlbGZ0ZXN0IGFzIHlvdXIgc3VnZ2VzdGlvbiwgQWxsIHJlcXVpcmVkIHRlc3RzIHBh
c3NlZC4NCg0KSGVyZSBpcyBteSB1cGRhdGVkIGNvbW1pdDogaHR0cHM6Ly9naXRodWIuY29tL2hp
ZXVudjA4MjgvYml0YmFrZS9jb21taXQvZDg3OTNhYTM2NDFmYjBhNDdlMGNkN2I0YzE0MWE0YzE0
YTE4MDA2Yy5wYXRjaA0KUGxlYXNlIGhlbHAgbWUgY2hlY2sgYWdhaW4uDQoNClRoYW5rcywNCkhp
ZXUNCg==

--_000_DB5PR02MB1021362ED90F20C176D61E024EF3B2DB5PR02MB10213eu_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkNhbGlicmk7DQoJcGFub3NlLTE6MiAxNSA1IDIgMiAyIDQgMyAy
IDQ7fQ0KLyogU3R5bGUgRGVmaW5pdGlvbnMgKi8NCnAuTXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWws
IGRpdi5Nc29Ob3JtYWwNCgl7bWFyZ2luOjBjbTsNCglmb250LXNpemU6MTEuMHB0Ow0KCWZvbnQt
ZmFtaWx5OiJDYWxpYnJpIixzYW5zLXNlcmlmO30NCmE6bGluaywgc3Bhbi5Nc29IeXBlcmxpbmsN
Cgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5Ow0KCWNvbG9yOmJsdWU7DQoJdGV4dC1kZWNvcmF0aW9u
OnVuZGVybGluZTt9DQpzcGFuLkVtYWlsU3R5bGUxOQ0KCXttc28tc3R5bGUtdHlwZTpwZXJzb25h
bC1yZXBseTsNCglmb250LWZhbWlseToiQ2FsaWJyaSIsc2Fucy1zZXJpZjsNCgljb2xvcjojOTQz
NjM0Ow0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglmb250LXN0eWxlOm5vcm1hbDt9DQouTXNvQ2hw
RGVmYXVsdA0KCXttc28tc3R5bGUtdHlwZTpleHBvcnQtb25seTsNCglmb250LWZhbWlseToiQ2Fs
aWJyaSIsc2Fucy1zZXJpZjsNCgltc28tbGlnYXR1cmVzOm5vbmU7DQoJbXNvLWZhcmVhc3QtbGFu
Z3VhZ2U6RU4tVVM7fQ0KQHBhZ2UgV29yZFNlY3Rpb24xDQoJe3NpemU6NjEyLjBwdCA3OTIuMHB0
Ow0KCW1hcmdpbjo3MC44NXB0IDcwLjg1cHQgNzAuODVwdCA3MC44NXB0O30NCmRpdi5Xb3JkU2Vj
dGlvbjENCgl7cGFnZTpXb3JkU2VjdGlvbjE7fQ0KLS0+PC9zdHlsZT48IS0tW2lmIGd0ZSBtc28g
OV0+PHhtbD4NCjxvOnNoYXBlZGVmYXVsdHMgdjpleHQ9ImVkaXQiIHNwaWRtYXg9IjEwMjYiIC8+
DQo8L3htbD48IVtlbmRpZl0tLT48IS0tW2lmIGd0ZSBtc28gOV0+PHhtbD4NCjxvOnNoYXBlbGF5
b3V0IHY6ZXh0PSJlZGl0Ij4NCjxvOmlkbWFwIHY6ZXh0PSJlZGl0IiBkYXRhPSIxIiAvPg0KPC9v
OnNoYXBlbGF5b3V0PjwveG1sPjwhW2VuZGlmXS0tPg0KPC9oZWFkPg0KPGJvZHkgbGFuZz0iU1Yi
IGxpbms9ImJsdWUiIHZsaW5rPSJwdXJwbGUiIHN0eWxlPSJ3b3JkLXdyYXA6YnJlYWstd29yZCI+
DQo8ZGl2IGNsYXNzPSJXb3JkU2VjdGlvbjEiPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4g
bGFuZz0iRU4tVVMiIHN0eWxlPSJjb2xvcjojOTQzNjM0O21zby1mYXJlYXN0LWxhbmd1YWdlOkVO
LVVTIj5QbGVhc2UgY2hhbmdlIHRoZSBjb21taXQgc3ViamVjdCBwcmVmaXggZnJvbSDigJxiaXRi
YWtlOuKAnSB0byDigJxiaXRiYWtlLWxheWVyczrigJ0uPG86cD48L286cD48L3NwYW4+PC9wPg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJjb2xvcjojOTQz
NjM0O21zby1mYXJlYXN0LWxhbmd1YWdlOkVOLVVTIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48
L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImNvbG9y
OiM5NDM2MzQ7bXNvLWZhcmVhc3QtbGFuZ3VhZ2U6RU4tVVMiPi8vUGV0ZXI8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9
ImNvbG9yOiM5NDM2MzQ7bXNvLWZhcmVhc3QtbGFuZ3VhZ2U6RU4tVVMiPjxvOnA+Jm5ic3A7PC9v
OnA+PC9zcGFuPjwvcD4NCjxkaXYgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci1sZWZ0OnNvbGlk
IGJsdWUgMS41cHQ7cGFkZGluZzowY20gMGNtIDBjbSA0LjBwdCI+DQo8ZGl2Pg0KPGRpdiBzdHls
ZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLXRvcDpzb2xpZCAjRTFFMUUxIDEuMHB0O3BhZGRpbmc6My4w
cHQgMGNtIDBjbSAwY20iPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PGI+PHNwYW4gbGFuZz0iRU4t
VVMiPkZyb206PC9zcGFuPjwvYj48c3BhbiBsYW5nPSJFTi1VUyI+IGJpdGJha2UtZGV2ZWxAbGlz
dHMub3BlbmVtYmVkZGVkLm9yZyAmbHQ7Yml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQu
b3JnJmd0Ow0KPGI+T24gQmVoYWxmIE9mIDwvYj5udmhpZXVkdDExQGdtYWlsLmNvbTxicj4NCjxi
PlNlbnQ6PC9iPiBkZW4gMjggbWFycyAyMDI0IDA3OjUwPGJyPg0KPGI+VG86PC9iPiBiaXRiYWtl
LWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc8YnI+DQo8Yj5TdWJqZWN0OjwvYj4gUmU6IFti
aXRiYWtlLWRldmVsXSBbUEFUQ0hdIFN1cHBvcnQgYWRkLWxheWVyIHRvIHByZXBlbmQ8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86
cD4mbmJzcDs8L286cD48L3A+DQo8cD5IaSZuYnNwO1JpY2hhcmQsPGJyPg0KPGJyPg0KSSB1cGRh
dGVkIG15IGNvbW1pdCBhbmQgcnVuIG9lLXNlbGZ0ZXN0IGFzIHlvdXIgc3VnZ2VzdGlvbiwgQWxs
IHJlcXVpcmVkIHRlc3RzIHBhc3NlZC48bzpwPjwvbzpwPjwvcD4NCjxwPkhlcmUgaXMgbXkgdXBk
YXRlZCBjb21taXQ6IDxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9oaWV1bnYwODI4L2JpdGJh
a2UvY29tbWl0L2Q4NzkzYWEzNjQxZmIwYTQ3ZTBjZDdiNGMxNDFhNGMxNGExODAwNmMucGF0Y2gi
IHRhcmdldD0iX2JsYW5rIj4NCmh0dHBzOi8vZ2l0aHViLmNvbS9oaWV1bnYwODI4L2JpdGJha2Uv
Y29tbWl0L2Q4NzkzYWEzNjQxZmIwYTQ3ZTBjZDdiNGMxNDFhNGMxNGExODAwNmMucGF0Y2g8L2E+
PGJyPg0KUGxlYXNlIGhlbHAgbWUgY2hlY2sgYWdhaW4uPGJyPg0KPGJyPg0KVGhhbmtzLDxicj4N
CkhpZXU8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_DB5PR02MB1021362ED90F20C176D61E024EF3B2DB5PR02MB10213eu_--

