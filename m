Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE33C61DCB
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 12:01:02 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4720.1787918460215993396
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 05:01:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=ZCweG0Mo;
 spf=pass (domain: axis.com, ip: 40.107.159.8, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py8VrQm0439VZrnGs9zPrJLOopd/dEdmjV7DnVza+VYAvrIUyWGxUfJjs7FhHXq1nXfLgrhcdG//7Ia3ww1a621staq+0fQTDXj9wAMR2N+utxqG0vEMdWnsg3y4dDsQqqLAWu3S2i7sVvv38ZS/elohzQsmZhfHwzcTNVZbT75jXdLY/WB5vJpxX8843xN0ai8wSiLrApsbOp0y+4DBnM3XO1YzbLUfeYthdZwA5po1JQxZcnKv2WZ1tTEVzgxhdb6T6fMvw4ps5Wc/aG5u03iksu6nPSDIOoh/90NY7D+UIrLtxvJK44rxv8nVGZD8hrmvNSeGns9JGTv2AqqhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOObR6Wuxk3Qx1/wBCrzqGwiuAj4Kr5Fs1/Do4251uA=;
 b=DshaMu0oypVz47T4/4z2T3XDMBsoN86YQ0Ku+BZL1YLqir7KhQXGb5wTYN1W46OZx6ZUxzhd7ZKPJmNCPt8zxcuHDx07ICagUFMZ/jPzhidGUVVCuKHSDR4oUjIBUzy4dT8MgrIO3g3BEPvoQc3OPo/GLsDEAyCjMmLGD3pecPKoX4SQ7pY84vvubNtpc2N3f/qjbZYicdwO3v/DuI2Mkz6dhPhDf/GdTS65GrOvrADTwSICg3UZExwBuueEkJJ4jZsRmFoYuQWuhBu+vRPyVjuDFt3jxwv4CrAunVPUEiIsffkCNyPrTcvI/iyffjaCna5qIiEJIlCymp/DeVgA+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOObR6Wuxk3Qx1/wBCrzqGwiuAj4Kr5Fs1/Do4251uA=;
 b=ZCweG0Mo6MIzt+aGBAw0trYhsAfIxePeCq+Wsl/icskr4Bt7g0Ye2tQuZIWg05TtXzMOIzwbisOzTUK7XmmGPfqducMVmCL3SspKwxAazKw65iVAM2cWXfUxOnGLZm4KE8eSRm/hr/XFp5hiw8xi1YS97yDOOopIqZUD9SJDHzA=
Received: from AS8PR02MB10201.eurprd02.prod.outlook.com (2603:10a6:20b:63d::6)
 by DB5PR02MB10161.eurprd02.prod.outlook.com (2603:10a6:10:4a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:00:53 +0000
Received: from AS8PR02MB10201.eurprd02.prod.outlook.com
 ([fe80::670:3815:35f6:ba2c]) by AS8PR02MB10201.eurprd02.prod.outlook.com
 ([fe80::670:3815:35f6:ba2c%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 12:00:53 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>,
	"chris.laplante@agilent.com" <chris.laplante@agilent.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Subject: RE: [bitbake-devel] [docs] [PATCH 1/4] lib: rename fetch2 as fetch;
 invert compat shim to make bb.fetch2 = bb.fetch
Thread-Topic: [bitbake-devel] [docs] [PATCH 1/4] lib: rename fetch2 as fetch;
 invert compat shim to make bb.fetch2 = bb.fetch
Thread-Index: AQHdNjC9bpSs//XDak+U/8DtjkuvxLay9jmAgABmcOA=
Date: Fri, 28 Aug 2026 12:00:53 +0000
Message-ID: 
 <AS8PR02MB10201CF48B8F8DD1675237AD3EFAC2@AS8PR02MB10201.eurprd02.prod.outlook.com>
References: <20260827142958.547182-1-chris.laplante@agilent.com>
 <DL0CCF115T08.227YUHOXXHLP3@bootlin.com>
In-Reply-To: <DL0CCF115T08.227YUHOXXHLP3@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10201:EE_|DB5PR02MB10161:EE_
x-ms-office365-filtering-correlation-id: 188ae24c-78c9-4974-d3cf-08df04fc02f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|10067099003|4143699003|11063799006|18002099003|22082099003|3023799007|56012099006;
x-microsoft-antispam-message-info: 
 UvqdIRCzALmkUzbdoCWgxb+a0p/KRFBnQPGHVzWah/yqghQRya1xggbu9a0YsQIe0/HPzDkogF0D6VpV9l6y6+RkTFLTmZzOILrq9uWNUKiATd1s/7Ko7LD7izWDnSvdNvbZkmBHa3FUh5ko72XTmugu5Ek+DGG0XsTQMOAQeM5D+bOguzjd1XNnpgIWEI6W82mdXjzUk3xiYyJ9Q2psIdT7D6dOH686pZtaVl3PqAGqgYYogfYIGrrIJ1cN6m6ZCAehru9R5FqSxwNa0CcJUg8x4m+gCNN2VpwgqBFKJdhSZ8ROc47KFnzqH9xobBMCHgiuoY5lGXz9FVkASsSTsp+ftsRyYVIECkkBZvMjzTgF9eJ6YKkwghC1MZK9uDo6q3Cf3MWxD+xvEr+NpRiCCx1xIx/MS0eYrCI16DnCCRs6ajE427XBPGFHmqmTXBI5oREoJ7RbvMfWGiqUQG+eQp3l9BERGvyTQLxoo6PW/M4KgPhm6fzC/JZrDkTbtqQJLUETZ6ELZRGejz2lg4WO43SK5KFSXiqzy5FG5mf62DbJTjvrhFRjEb1AhBUkIx14q2TXqz/Hlm2hv3lEoY/rejqJ+ss3MU4T8Gz4sHfP2RLPe2l2sR3+Zvw5BworpnU4JNzkct83vKCExL1wDpf44+c7tMQPvztSWwxW4efXWDs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB10201.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UlRRQUFKUVZ4ckpZOVBwMTFaMWw2RXVxWnk4TnNncjNhWlRoVkFhTU94elZ0?=
 =?utf-8?B?cnJhdThDTGl0YUtIa3dSdytCYjUrQ1BwdmhGWldrc3Q5KzNPTmxGMlFEMXUx?=
 =?utf-8?B?ZTJxcy95WmdNNzVGUWQvYmljRHh2ZW4zV0dpOXRyaU1HV1UzMThuSjFVRTB5?=
 =?utf-8?B?Mmg1b2NrU21Takd3TkYxVHZoOVQ2cmgrQ3dTSTYwZFNGdzFjbUtBNlM3dlFK?=
 =?utf-8?B?enZkN2l6THNMZ1hyb1Q3dHZZQWlGYkFJTlJuZGRLTFZMQjg0SlFhcWxTaTMr?=
 =?utf-8?B?RVpjdGI5MUxselNmWmI5Z3dqL2NSQkx0M2RPMzB1MVNOVmN6Q0Z3M2RoRS9i?=
 =?utf-8?B?ajhoQVk0enRlU2NKS2pVd2ttSlk5MHAyZXFsTDZleXBCZHhiYWh6VTRpZjUv?=
 =?utf-8?B?UUZHdXA0UGZ5NCtVenhNeG1wNWIzb0dsK29HcDVybXk1bFlVZUNLVlVYMHRw?=
 =?utf-8?B?dVpGMGVhSEw4b1pJc2lZd3FLUXpqTDc4YlhPS1NGc2J5WldibUJueGkzaWtM?=
 =?utf-8?B?NXZZLzdmOWVaWTdVTjgxblJHdWJFclo4TEp5Z2hPVTE0QlZKalFMZWt1czJF?=
 =?utf-8?B?VWFyd1UvbkRHa0VIemNESHpYd2sxV2UyQ05KM01GdFk4MzhScElqMXVBY3BF?=
 =?utf-8?B?M3BqM1BndHNFMXlZODJmaEFUMVZQcS8wVWl4UFFEZHR3UGJNSVFKWVlxbVZ3?=
 =?utf-8?B?SVAvV1BWVmNyVld2WGdaY2gwbjRDei9nb0RWTWJOcndPSEhrTEhxVW94dXI0?=
 =?utf-8?B?RjNvdFd6bVhNM3V1bUV5Z3hjRTBrNzJSWW9JWVJSK2FES3JDZlFxWFkxdm1T?=
 =?utf-8?B?ZUtIK2VYeEdJQm5sTDRHTk5mZE9uL2IvQk5LSnZmVXNPbkpsVFhnS05ZQysw?=
 =?utf-8?B?RFhNMGV4RFFJZEM4NDliaHlMYUJIS3pNY2pLTTF4OEVYZG12TlV1MDBwNWMx?=
 =?utf-8?B?a2ZNOWRvWHZpa0d3Y01SU2owYVExVnlwMjRnYW5QZCtPY2x1WHIrU0Juc3pS?=
 =?utf-8?B?UHc1ck0vTWkrUWdqcHo5eUdsdFhVc3hSTDBha1BHQ0ZRdVUwdjhVbFI3aWxo?=
 =?utf-8?B?bUo5RVJwMDI4cXNyREFZUTdhVERidVhldThDaThuQUl1VTVxZUt0MWkvaUdr?=
 =?utf-8?B?dUNOWUNmOGh5M1g3eXgxTy8rR2VkODZVajYxWlVzYUFlY3RhcjZGWGNxeFdN?=
 =?utf-8?B?aEtlYjE1Y29iZzk0UXd0Sk5QVTl4aGx3ajlmdGpQR3ZIZnlrRWFvSWtoc3ZR?=
 =?utf-8?B?V2JTTGx2cmE4Y2xROWcyb2dONTI5U1RPYXFkU0RlMjlCLzRwanFoclkvb2Nz?=
 =?utf-8?B?UWkrUmdFbkFDMmJGSTN3U3krZjFDY3VINTJmSFI1ckw4R0c4cnY1eExMOXRW?=
 =?utf-8?B?aTlZeTBoMXdEVGF5WTlLeVpKMFdKRnJCU29CNTFHaVJCdnpFTis0M3I4cnlW?=
 =?utf-8?B?SGZCZmJtZjJncS95ZmIwVGs1OWVqL1NETWpicW4zVzlMbHE2ZzRRWHc3aS9o?=
 =?utf-8?B?S3R0U2xUWVFRVlRHaUpLSlY0R05LWUZZK2xQaEFVSm5NcWJRLzg0SVNaUG9s?=
 =?utf-8?B?WDRlSG1pMm1wR1k5YmdBc0pDMWdrbXNBUHdIRlJHZVhuWit1UFhxMW5tT3hB?=
 =?utf-8?B?SG1nQ0FleGVJL2dXUXpmdEpkY3BBYVNUalg5TnM2b01rUk4rMGRGMWlucE9u?=
 =?utf-8?B?MmZkM3hpRm1ubElCQWpqTCtycFdwV1pMOWFLSERzdFFOZG9JQmkveEZHWldr?=
 =?utf-8?B?RTR3emFOM1F4VVhCWEZlQzJ5WWFXd0tWQXRVdnZmaVhxak92aXg0dFNTeVRD?=
 =?utf-8?B?VWlZUHhQQ3g3QTNCTlpHbEQ4eXYyN051MGJheG9SWjFKT1BBSXRwNUhOTmp0?=
 =?utf-8?B?TnphZXZRZCs2cHF5dmtoSTVPQ3NIRVR1QTU3V0V5aE1zM1crckd2RkxXamY3?=
 =?utf-8?B?R2xlMVlKcFhERmxFOTRkRThyLzZTOUpWNzRpejl2Q3l5U0xIemE2N2k2aUQx?=
 =?utf-8?B?WmRNVHJJdXRMWDhYNEFYejZDd200RkhDTTduQjdaTEF0MG1MQnJ2SU40MzQx?=
 =?utf-8?B?a0VObytMblhHMjlKU29Jb1phZnR0TzUwSEdRZFJOQ1ZRVytUNTE4eENvS0c1?=
 =?utf-8?B?U1NiSFVyNm1HWGJqZitqa2JwWGpBWStxZU1XQmJSOGNOc0ZGK2lhM0tUOEZZ?=
 =?utf-8?B?eGVqRGJTWW81S0lJZDF5T1JrRFI2eWxJY1o0cVhSbEZsSWIwZnhqcFJza0or?=
 =?utf-8?Q?CzimVv9mYdRz7UkKN3QoEqivRn3WgOQJimF7TeN/ao=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10201.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188ae24c-78c9-4974-d3cf-08df04fc02f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 12:00:53.7783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8m/LSYIsH7uUhEunBjNGYucxIZ5MwthbpZuAJGBmx2Ef0b/gLbhU1FuoQiiF9mN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB10161
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 12:01:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20100

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIE1hdGhpZXUgRHVib2lzLUJyaWFuZCB2aWEgbGlzdHMub3BlbmVtYmVkZGVk
Lm9yZw0KPiBTZW50OiBkZW4gMjggYXVndXN0aSAyMDI2IDA3OjUyDQo+IFRvOiBjaHJpcy5sYXBs
YW50ZUBhZ2lsZW50LmNvbTsgYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+
IENjOiBkb2NzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNCj4gU3ViamVjdDogUmU6IFtiaXRiYWtl
LWRldmVsXSBbZG9jc10gW1BBVENIIDEvNF0gbGliOiByZW5hbWUgZmV0Y2gyIGFzIGZldGNoOyBp
bnZlcnQgY29tcGF0IHNoaW0gdG8gbWFrZSBiYi5mZXRjaDIgPSBiYi5mZXRjaA0KPiANCj4gT24g
VGh1IEF1ZyAyNywgMjAyNiBhdCA0OjI5IFBNIENFU1QsIENocmlzIExhcGxhbnRlIHZpYSBsaXN0
cy55b2N0b3Byb2plY3Qub3JnIHdyb3RlOg0KPiA+IEZyb206IENocmlzIExhcGxhbnRlIDxjaHJp
cy5sYXBsYW50ZUBhZ2lsZW50LmNvbT4NCj4gPg0KPiA+IGJiLmZldGNoMiByZXBsYWNlZCBiYi5m
ZXRjaCBiYWNrIGluIDIwMTIsIGFuZCB0aGUgY29tcGF0aWJpbGl0eSBzaGltIG9mDQo+ID4gYmIu
ZmV0Y2ggPSBiYi5mZXRjaDIgaGFzIGJlZW4gaW4gcGxhY2UgZXZlciBzaW5jZS4gVGhlcmUncyBu
byBsb25nZXIgYQ0KPiA+IGdvb2QgcmVhc29uIHRvIGtlZXAgdGhlICcyJyBzdWZmaXgsIHNvIGxl
dHMgZHJvcCBpdC4NCj4gPg0KPiA+IFdlIGFsc28gaW52ZXJ0IHRoZSBiYi5mZXRjaCA9IGJiLmZl
dGNoMiBjb21wYXRpYmlsaXR5IHNoaW0gdG8gbm93IG1ha2UNCj4gPiBiYi5mZXRjaDIgPSBiYi5m
ZXRjaC4gV2UgZG8gdGhpcyBieSBjcmVhdGluZyBhIG5ldyBsaWIvYmIvZmV0Y2gyLnB5LA0KPiA+
IHdoaWNoIGxldHMgdXMgZ2V0IHJpZCBvZiB0aGUgdWdseS1pc2ggc2hpbSBpbiBsaWIvYmIvX19p
bml0X18ucHkuDQo+ID4gRmluYWxseSwgd2UgYWRkIGEgZGVwcmVjYXRpb24gd2FybmluZyBmb3Ig
Z29vZCBtZWFzdXJlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgTGFwbGFudGUgPGNo
cmlzLmxhcGxhbnRlQGFnaWxlbnQuY29tPg0KPiA+IC0tLQ0KPiANCj4gSGkgQ2hyaXMsDQo+IA0K
PiBJIHN1c3BlY3Qgc29tZSByZW5hbWluZyBpcyBtaXNzaW5nIG9uIHRoZSBvZWNvcmUgc2lkZS4g
V2UgaGF2ZSB0aGlzDQo+IGVycm9yIG9uIGFsbCBidWlsZHM6DQo+IA0KPiBSdW5uaW5nICcuIC4v
aW5pdC1idWlsZC1lbnY7IGJpdGJha2Ugd29ybGQgLWsnIHdpdGggb3V0cHV0IHRvIC9zcnYvcG9r
eWJ1aWxkL3lvY3RvLXdvcmtlci9xZW11eDg2LXdvcmxkLWFsdC9idWlsZC9idWlsZC9jb21tYW5k
LTEtYnVpbGQtdGFyZ2V0cy5sb2cgaW4gL3Nydi9wb2t5YnVpbGQveW9jdG8td29ya2VyL3FlbXV4
ODYtd29ybGQtYWx0L2J1aWxkL2J1aWxkDQo+IEVSUk9SOiBFeGVjdXRpb24gb2YgZXZlbnQgaGFu
ZGxlciAnY2hlY2tfc2FuaXR5X2V2ZW50aGFuZGxlcicgZmFpbGVkDQo+IFRyYWNlYmFjayAobW9z
dCByZWNlbnQgY2FsbCBsYXN0KToNCj4gICBGaWxlICIvc3J2L3Bva3lidWlsZC95b2N0by13b3Jr
ZXIvcWVtdXg4Ni13b3JsZC1hbHQvYnVpbGQvbGF5ZXJzL29wZW5lbWJlZGRlZC1jb3JlL21ldGEv
Y2xhc3Nlcy1nbG9iYWwvc2FuaXR5LmJiY2xhc3MiLCBsaW5lIDE2OSwgaW4gY2hlY2tfc2FuaXR5
X2V2ZW50aGFuZGxlcg0KPiAgICAgb2Uuc2FuaXR5LmNoZWNrX3Nhbml0eShzYW5pdHlfZGF0YSkN
Cj4gICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5eXl5eXl5eXl5eXl5eDQo+ICAgRmlsZSAiL3Ny
di9wb2t5YnVpbGQveW9jdG8td29ya2VyL3FlbXV4ODYtd29ybGQtYWx0L2J1aWxkL2xheWVycy9v
cGVuZW1iZWRkZWQtY29yZS9tZXRhL2xpYi9vZS9zYW5pdHkucHkiLCBsaW5lIDEwMDcsIGluIGNo
ZWNrX3Nhbml0eQ0KPiAgICAgY2hlY2tfc2FuaXR5X2V2ZXJ5YnVpbGQoc3RhdHVzLCBzYW5pdHlf
ZGF0YSkNCj4gICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Xl5eXl5eXl5eXl5eXl5eXl5eXl5e
DQo+ICAgRmlsZSAiL3Nydi9wb2t5YnVpbGQveW9jdG8td29ya2VyL3FlbXV4ODYtd29ybGQtYWx0
L2J1aWxkL2xheWVycy9vcGVuZW1iZWRkZWQtY29yZS9tZXRhL2xpYi9vZS9zYW5pdHkucHkiLCBs
aW5lIDg5MCwgaW4gY2hlY2tfc2FuaXR5X2V2ZXJ5YnVpbGQNCj4gICAgIGRlY29kZWQgPSBiYi5m
ZXRjaDIuZGVjb2RldXJsKHBhdHRlcm4pDQo+ICAgICAgICAgICAgICAgXl5eXl5eXl5eDQo+IEF0
dHJpYnV0ZUVycm9yOiBtb2R1bGUgJ2JiJyBoYXMgbm8gYXR0cmlidXRlICdmZXRjaDInLiBEaWQg
eW91IG1lYW46DQo+ICdmZXRjaCc/DQo+IA0KPiBodHRwczovL2F1dG9idWlsZGVyLnlvY3RvcHJv
amVjdC5vcmcvdmFsa3lyaWUvIy9idWlsZGVycy8xNy9idWlsZHMvNDM1OQ0KPiANCj4gQ2FuIHlv
dSBoYXZlIGEgbG9vayBhdCB0aGUgaXNzdWU/DQo+IA0KPiBUaGFua3MsDQo+IE1hdGhpZXUNCj4g
DQo+IC0tDQo+IE1hdGhpZXUgRHVib2lzLUJyaWFuZCwgQm9vdGxpbg0KPiBFbWJlZGRlZCBMaW51
eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQo+IGh0dHBzOi8vYm9vdGxpbi5jb20NCg0KSXNuJ3Qg
dGhlIGJiLmZldGNoMiBzaGltIGV4cGVjdGVkIHRvIHRha2UgY2FyZSBvZiB0aGF0Pw0KDQovL1Bl
dGVyDQo=

