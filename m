Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED85C5DF9D
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 08:22:27 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.36])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31353.1787818944667596512
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 01:22:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=V1nEHCDq;
 spf=pass (domain: axis.com, ip: 52.101.65.36, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fE7rf5UyWqJTP7cYDNZ2NYIhGcHBDZ2u3wEFtmD2JDs5FbnuOfjSbxpwu0rv1dX7VUduW8MZNsCvx4hVI7ZW3NgRJlC8NdyDwo8yn/uFUwyYi+aK1TLoiQnBQnll5wPGNPiUepHDAx6v3FSJbueanF+hlxw5gFJCbZks121wzwsy8VBnfXoMZ+byOMUfp7zCAJYD3op69eIBtRWSlA9bEJweHoShrYSTk+b2vizBMj2mWPOvrD93mZuDjjAxRgkJ/KgHj8qqv9OjzQrMBVnOS8wYYdOqzqi8CN6Yi8RmYAuVCALZEF4h/9fvKInhJ9jG3O+WokpAI98fP+95RcE5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNCor65x4BjIjUk4qc31tBjVgKJmBL1v4K7Ezo4Fojs=;
 b=di9ABy7quMPA7ZKyJg3G1BRscWcvJrHQzEq+90bRsHXAOCwuV1oQqYlqzr2pCW4+ppsGr9wx1FQxcq/29sGoV/zIqYXW06NkQFHAJnVxdpmGY64J3zyK0W1lFYKwG4FfNjwj3HDVTC5NkmzRnbg2YHOcxVi4HGstk/xck4UDZCRa8Ic7TvWf9krlAVtXpH6WqtqHTIMHD01MTpWioX7HLAwnQjshuQTHyK1zELpNNnUcIL0rAMBX5ZWbXwDanuXpnEc7oMuOWaKUU33TFO7aCBXuK/IkwY6W1PmSPE2NpFPSrDdv7LDkpPc+9g7Sw716EcxdSZs8JtuRdcrtnjl/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNCor65x4BjIjUk4qc31tBjVgKJmBL1v4K7Ezo4Fojs=;
 b=V1nEHCDqnMw7VSfbqjUAwmxwws7WkjoEZP14e3MXUwJSlK4VJ9ltkD4s0+RNdCZwNO0ig7CQp+lDQyuIj9cXx+VrJPc3PJgOqvheuZUvhXtRGU5KYzumIMMno3uq4R3bjKW+r+ekIVGnmYK1uTBTbdl40bsO02wbxtvOEvOfkXc=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by DBBPR02MB10916.eurprd02.prod.outlook.com (2603:10a6:10:530::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 08:22:19 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd%4]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 08:22:19 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "WXbet@proton.me" <WXbet@proton.me>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] knotty: show elapsed time on the task
 progress bar
Thread-Topic: [bitbake-devel] [PATCH] knotty: show elapsed time on the task
 progress bar
Thread-Index: 
 AQHdL0k9RSgb9jpjW06sUpw1s+zcnbakOBIAgADRPICAABOrgIALRzBAgAAY2QCAARQL8A==
Date: Thu, 27 Aug 2026 08:22:19 +0000
Message-ID: 
 <DB5PR02MB10213EBD7A7D02A922F32223CEFAD2@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: 
 <CANNYZj9uDoKqqx_WV2CZ0-Q99AdRWzVUXD4idpcrZMf2Zpw28Q@mail.gmail.com>
 <20260819093321.3451-1-wxbet.oe@gmail.com>
 <DB5PR02MB1021395256F54ECB1AC5FF3CBEFAE2@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <2789044.1787757356219607465@lists.openembedded.org>
In-Reply-To: <2789044.1787757356219607465@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DBBPR02MB10916:EE_
x-ms-office365-filtering-correlation-id: 73e26916-5f3b-4683-fece-08df04144faf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|38070700021|10067099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: 
 Ssmynq9YaElTIdMDGiZ+e2VR34k6yQlehGce+x5QhtHxhINx4qmlJC++97NLXZzlHX0Ulr7hE7aEH4ev+jrPvktzZ5ZVzHxBgmXbfC5ksuYxv6P5edvXLqABi45wuABLpofPoRQwXFubalf83Q1GpSs0cAxoMaciAhGapG9dst7HH7Xvdd1W+YOC+fLnxaKNR/0hM1XiFbikh+A05PC+UnNPV2B7LLKOHVabYZVcy66F2CRaBmIJ+ZWmp5aZxD/uDc2owezbXoJgppO1bKe3saZL1QG3AkNrn2/gK/HubCLoBj7Zo8UCv1U5XFPjBDW/h0A66KQ2GS0+i6Cm1kGagAQLMQYUa1DLhvqNCm5cEMXzaqXz229duqb7S+sIWy27jcNdc0nUvxlvLjEhcoo3CsSxQvYW69JCGr6iStb765L5kpcO1azzytimS+xy/A4ZD85XOmmw9K0x5j3ow132ovM2v15Qtf0jv9hgj1bUxqeJfuAvQ0Y1OPMaFRj0QaXMs/WPwb1BwXH6o0uy0adNkkx1r07fOdso6klrkTh7DWhlLddFp6WMyRiIXX5Okhf5sxvzfAOhe+VJEf12J+GD6B/g/k0pwfOSFFDqBb0X+FGQHyb751MwBjTLWiCuaQfuKEY3CnI2dfX9ebFb9/an02ngZ7xQrXA11hMd9PGNq2r9HcctTj/Ye1+Mr4B4MkCxbyXjUxQZFTibV26c/gYX70ioPFtmQ9cHmVtS5Rr3zTg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cW5nZ3N4WXpwcUlxZ0RST2dDNWZzK2NHT3ZTbVhxeUoweVJCY29QOXRLZXAw?=
 =?utf-8?B?YVNockh0UVd2T2JHKzRtUkVGUGx4WG45Y1ZpTGttbXNxbFdVZWwzcHd5UHdr?=
 =?utf-8?B?NTdCRm5ka0xsak5IR2dqa2V4MmdEcktCRWplZWlMQjFQRVdFSS94S3RVb2wr?=
 =?utf-8?B?dlMranVEODJGT1lNc0FoTDB3Ukt6NGZiSXRGOXJuZE5vMzFaT01FUFJZY3RW?=
 =?utf-8?B?eDIyeElTdWl2VjdoUDh6SmNocmZIUzNrdkVxZTN1ZGZic2piZW53Vy80MHIz?=
 =?utf-8?B?VEhMOUVvVVBpV0UyOU5KdDFmUWVhbnV3MFdoQjZ6bmJXcFRIVnJXby91Vmll?=
 =?utf-8?B?bDk1SUpxY0taVm1HeG42T0x6b1M3V25uYlJ0Zmd4VXlUalRlaXU3MTdCRHhk?=
 =?utf-8?B?TDhjSm5Fc21uc0FnNS85ZGFkT2QyVG5YZDQzbzlRKzFmKzVRcVVyZXBFMFJB?=
 =?utf-8?B?T2ZsVlBpelJETStVZ25wREsrc1dkUUMxL1YwYnhwYzNLdXhSQXVtYWVhZGVJ?=
 =?utf-8?B?NGlpcWhSVDBkMk50T1lQQTFiVUxNb2h6RFdhRzN5bjVaVlNaNzd2dWRlQjdu?=
 =?utf-8?B?RFl5djNlOHN3L290TW1pTzQwSWJFSWhWT3ZKdlZHaWkvUGllRGQzRWMrekU3?=
 =?utf-8?B?YnhtTWlkQ09nQnBFckxiNjZrQm1ScEFnTFV2bUFWTDFCcUNJOTN1NVZlZnph?=
 =?utf-8?B?VVZtbndmRGtmZW8yckhLWXRqZmNURWNxNkNtSU9abUJPSkRlWlhPMUxHbmxG?=
 =?utf-8?B?U1NMbWxCU3A2dWRnQWU4WWRGTndyRG1LWE10aTczbU9lcFZmMmhySGRYbjlh?=
 =?utf-8?B?LzFzZ245TnZlNXhUMG1CUGFoNTlacnd4eUEzUk1UY0F2Qm9xNmF3dnNQWnc5?=
 =?utf-8?B?K2VJclNHR3dCNmI4akxBOVNaMythdHRteFdJK1dVa3JobHJmMENzVTJadFlX?=
 =?utf-8?B?bmozZm9WOGVWQU5QV2V6aHJJRVloRDI0VFpWK0xTZFlGa1hzY01UUjFlSG1j?=
 =?utf-8?B?cHltUnptMkJZK2orWHdMR2RTRFRsdjdJbkFWQml1LzliTTExSlcraHE0RkIx?=
 =?utf-8?B?RUlNYm13ZlZvaU9nSHFwSEpQMWhjVW5nakR2R25YdTg0UDFaanpmSlpvK2tB?=
 =?utf-8?B?T0hlVCs1OVA4d0FaSGoyYi9CWG5GTG1aSUU4SDdkdWJhSExqUEYxcThtRkhj?=
 =?utf-8?B?U01lcUVOSFk0bHFOUTFrOTlPWTZBV2F1YXNKQkhtUnNCOWQrOWQyVEREWlFS?=
 =?utf-8?B?djN3WFFtQlVTSklnOTRWTWQ1OUREVXBSQ0Q5TGw0M0UzY2hrNzZQbk90bTQ0?=
 =?utf-8?B?aW13YnZybHl2cHo2SVl2TzArcDJLTFhmMDlvQXVYcDY2WWVpazk5MzBIYUc1?=
 =?utf-8?B?OUxMb09mYUJaa3NZaHVCVWZhQjJ4U0VqajdaS2FJeHhybVhGLzNrRjZqS1pC?=
 =?utf-8?B?TWhnTnJHTmkxcU1DQk1tNDRidkZkVXlwZ2xyVldoS2l3MTJjQlhxWnZ2WW9H?=
 =?utf-8?B?VTdRL0JNZ2Q5WkZ3cXkzNjB4TmVqbG9Vdlgvb0xGNVY0YlEzWWtrQXRzMERD?=
 =?utf-8?B?VlFJNXUzV2RMeHgyc1p5ckI2clBWT2xyZm9XQ0hXSjNaZ2toRHNyUFNkSTQ2?=
 =?utf-8?B?Q3FnUVVOQ3FxdFFBYktoWXVKTFNHVDZZZHZKUWxwU2pWUFpPejhoMGNZZGZq?=
 =?utf-8?B?NjA0MUdVQWVQRDVpMnBMQ2RpemtqaDJrMjFIaGhqN1BNS2lQZy9ENkV6ZWxn?=
 =?utf-8?B?dEtBeDlqT0pVREQ5R2FobzFPZGVHbzAxTkhqRkZTRWFDTVoyWVBNallOdzg0?=
 =?utf-8?B?a1V1aittNEYxRXNSRnFpczlqYlpxVjhGL1g4RnRXZ2U0WUlRbEdyQ1FhSitv?=
 =?utf-8?B?TGtsYzZVTkJrb25RM1JNdTZWZWZIbyt2T1VMVkQvYXlnVXZrMnFqNW5LcGM3?=
 =?utf-8?B?ZjZNdHZwMk1SQmlyYnFGeEh0c0JyMUEzdnNSK0lRdzFUS1NnTzlNczJUMyth?=
 =?utf-8?B?eEZ1bXJmNjRQUzcvZ1YzTVJ4UEJBTXJ2RWFVM2twS3RKRWl3UVgzTUZKVkhs?=
 =?utf-8?B?SzJ2RzlWOEJBQStGMm51NWVzcnAyQ0Zjc01oRklCZWxnTnptZ1pNc0VOMi8r?=
 =?utf-8?B?NDhuZlJTbHZOeXRIVjNzdUFDRWhFUnY0Smt1dHRwK1BVTDkzM1EreHdpSVZn?=
 =?utf-8?B?eVVCd2VlRFR0SlZENlQ5Z3VjT1NJYVFmd1U5VWtNK2dLbGV2N3NIN1hRSnI4?=
 =?utf-8?Q?/PMqZLVABujkNC8rA+rdiqCaPekrwuRStS6IfmxOLo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e26916-5f3b-4683-fece-08df04144faf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 08:22:19.2424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yLPra/BzKT1NBwfQe/0gQUwMAQ48kFlGd3239wpAVG0oqAxQ+4vu7WzeDhgg2LAb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10916
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 08:22:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20063

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIFdYYmV0IHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IFNlbnQ6IGRl
biAyNiBhdWd1c3RpIDIwMjYgMTc6MTYNCj4gVG86IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVt
YmVkZGVkLm9yZw0KPiBTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSF0ga25vdHR5
OiBzaG93IGVsYXBzZWQgdGltZSBvbiB0aGUgdGFzayBwcm9ncmVzcyBiYXINCj4gDQo+IE9uIFdl
ZCwgQXVnIDI2LCAyMDI2IGF0IDA0OjQxIFBNLCBQZXRlciBLamVsbGVyc3RlZHQgd3JvdGU6DQo+
ID4gT24gdGhlIG90aGVyIGhhbmQsIHRoZSBwcm9ncmVzcyBiYXJzIHRoYXQgYXJlIHNob3duIGR1
cmluZyB0aGUgaW5pdGlhbCANCj4gPiBwaGFzZSBiZWZvcmUgdGhlIGJ1aWxkIHRhc2tzIHN0YXJ0
cyBhbGwgdXNlIFByb2dyZXNzYmFyJ3Mgb3duIFRpbWVyIA0KPiA+IHdpZGdldC4gSSB0aGluayBp
dCBtYWtlcyBtb3JlIHNlbnNlIHRvIGp1c3QgdXNlIHByb2dyZXNzYmFyLlRpbWVyKCkgDQo+ID4g
cmF0aGVyIHRoYW4gQkJUaW1lcigpLg0KPiANCj4gVGhlIGZvcm1hdHRpbmcgaXMgZGVsaWJlcmF0
ZS4gVGhlIHJ1bm5pbmctdGFzayBsaW5lcyByaWdodCBiZWxvdyB0aGUgDQo+IGJhciBwcmludCB0
aGVpciB0aW1lIHRocm91Z2ggVGVybWluYWxGaWx0ZXIuZWxhcHNlZCgpLCBlLmcuIDE2bTM0cy4g
DQo+IFdpdGggcHJvZ3Jlc3NiYXIuVGltZXIgdGhlIGJhciByZWFkcyAwOjE2OjM0LCBzbyB0aGUg
c2FtZSBzY3JlZW4gd291bGQgDQo+IHNob3cgdHdvIGRpZmZlcmVudCB0aW1lIGZvcm1hdHMuDQoN
ClRydWUsIGJ1dCB0aGUgdGltZXMgdGhhdCBhcmUgZGlzcGxheWVkIHRocm91Z2ggZWxhcHNlZCgp
IGFyZSBzaG93biBhcyANCnBhcnQgb2YgdGhlIGxhYmVsIGZvciBlYWNoIHRhc2suIFRoZXJlIGl0
IG1ha2VzIHNlbnNlIHRvIGtlZXAgdGhlbSANCnNob3J0LCBhbmQgc2luY2UgbW9zdCB0YXNrcyBy
dW4gaW4gdGhlIG1hdHRlciBvZiBzZWNvbmRzIG9yIGEgZmV3IA0KbWludXRlcywgYWx3YXlzIGRp
c3BsYXlpbmcgdGhlIHRpbWUgd2l0aCBob3VycyBpcyBleGNlc3NpdmUuDQoNClRoZSB0b3RhbCBi
dWlsZCB0aW1lIG9uIHRoZSBvdGhlciBoYW5kIGlzIHNob3duIGFzIHBhcnQgb2YgdGhlIHByb2dy
ZXNzIA0KYmFyIHRvIHRoZSByaWdodCwgYW5kIGNhbiBlYXNpbHkgcmVhY2ggaG91cnMuDQoNCj4g
VGhlIHBhcnNpbmctcGhhc2UgYmFycyBhcmUgZ29uZSBieSANCj4gdGhlIHRpbWUgdGhlIHRhc2sg
YmFyIGFwcGVhcnMsIHNvIHRoZXkgbmV2ZXIgY29tcGV0ZSB3aXRoIGl0Lg0KDQpOb3QgZW50aXJl
bHkgdHJ1ZS4gVGhpcyBpcyB3aGF0IGl0IGxvb2tzIGxpa2Ugd2hlbiBJIGJ1aWxkLCB3aXRoIHRo
ZSANCmRlZmF1bHQgVGltZXIoKSBlbmFibGVkIGluIHRoZSBvdmVyYWxsIHRhc2tzIHByb2dyZXNz
IGJhcjoNCg0KSW5pdGlhbGlzaW5nIHRhc2tzOiAxMDAlIHwjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyN8IFRpbWU6IDA6MDA6MDcNCkNoZWNraW5n
IHNzdGF0ZSBtaXJyb3Igb2JqZWN0IGF2YWlsYWJpbGl0eSAoNDc1KTogMTAwJSB8IyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjfCBUaW1lOiAwOjAwOjAwDQpTc3RhdGUgc3VtbWFyeTogV2FudGVkIDQ3
NSBMb2NhbCAwIE1pcnJvcnMgMCBNaXNzZWQgNDc1IEN1cnJlbnQgMTA5MTcgKDAlIG1hdGNoLCA5
NSUgY29tcGxldGUpDQpOT1RFOiBFeGVjdXRpbmcgVGFza3MNCjEgcnVubmluZyB0YXNrcyAoMjEz
MzUgb2YgMjE2OTQpICA5OCUgfCMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyAgIHwgRWxh
cHNlZCBUaW1lOiAwOjAwOjAwDQoNClNvIHVzaW5nIFByb2dyZXNzYmFyJ3MgZm9ybWF0dGluZyBt
YXRjaGVzIHRoZSBhbHJlYWR5IGV4aXN0aW5nIA0KcHJvZ3Jlc3MgYmFycy4NCg0KPiANCj4gVGlt
ZXIuZm9ybWF0X3RpbWUgaXMgYSBzdGF0aWNtZXRob2QgYW5kIFRpbWVyIGRlZmluZXMgX19zbG90
c19fLCBzbyBpdCANCj4gY2Fubm90IGJlIHJlcGxhY2VkIHBlciBpbnN0YW5jZSwgaGVuY2UgdGhl
IHNtYWxsIHN1YmNsYXNzLg0KPiANCj4gSWYgeW91IHByZWZlciBjb25zaXN0ZW5jeSB3aXRoIHBy
b2dyZXNzYmFyJ3Mgb3duIGZvcm1hdCwgdGhpcyBvbmUtbGluZXIgDQo+IGRvZXMgaXQgaW5zdGVh
ZCBhbmQgSSBhbSBoYXBweSB0byBzZW5kIGl0IGFzIHYyOg0KPiANCj4gLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHdpZGdldHMgPSBbJyAnLCBwcm9ncmVzc2Jhci5QZXJjZW50YWdlKCksICcgJywg
cHJvZ3Jlc3NiYXIuQmFyKCldDQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB3aWRnZXRzID0g
WycgJywgcHJvZ3Jlc3NiYXIuUGVyY2VudGFnZSgpLCAnICcsIHByb2dyZXNzYmFyLkJhcigpLCAn
ICcsIHByb2dyZXNzYmFyLlRpbWVyKGZvcm1hdD0nRWxhcHNlZDogJXMnKV0NCg0KTm8gbmVlZCBm
b3IgYXMgc3BlY2lhbCBmb3JtYXQsIHRoZSBkZWZhdWx0IGlzICJFbGFwc2VkIFRpbWU6ICVzIiBh
bmQgSSANCnRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIGtlZXAgdGhlICJUaW1lIiBwYXJ0Og0KDQog
ICAgICAgICAgICAgICAgd2lkZ2V0cyA9IFsnICcsIHByb2dyZXNzYmFyLlBlcmNlbnRhZ2UoKSwg
JyAnLCBwcm9ncmVzc2Jhci5CYXIoKSwgJyAnLCBwcm9ncmVzc2Jhci5UaW1lcigpXQ0KDQpUaGF0
IHNhaWQsIEkgbGlrZSBoYXZpbmcgdGhlIHRvdGFsIHRpbWUgaW4gdGhlIHByb2dyZXNzIGJhci4g
SSBhbHdheXMgDQpydW4gbXkgYnVpbGRzIGFzIGB0aW1lIGJpdGJha2UgLi4uYCBzbyB0aGF0IEkg
aGF2ZSB0aGUgdG90YWwgYnVpbGQgdGltZQ0KYWZ0ZXJ3YXJkcywgYnV0IGhhdmluZyB0aGUgY3Vy
cmVudGx5IGVsYXBzZWQgdGltZSBpcyB2ZXJ5IG5pY2UgYXMgd2VsbC4NCg0KLy9QZXRlcg0KDQo=

