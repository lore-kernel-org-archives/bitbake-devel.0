Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CF2CE7A98
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 16:01:03 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.43])
 by mx.groups.io with SMTP id smtpd.web11.65083.1695657661202338610
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Sep 2023 09:01:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=GJKnFF/k;
 spf=pass (domain: axis.com, ip: 40.107.8.43, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6kuhESL4BGab7PimZ8O0QCKSRxUR4434EZgEGnSbz70xt+mqjGLU3RTNaH59INJpXbNbajCG2RyXtybrkQpSRcNEl1yqSiJpGx17cp8i0ZiPGECimaizlTktT8qL7YraY+6NlqE86Sbfy55Aj32oHnLl5AuLcmCBqD1Duomyz6e5nUIcewSlGOHc0vn6T24fxpoeKT+u9jlNjjOJdN+bVOhOnRQykLMOb4rWgNEClI/GnM4NYZhj6bfydrjUupTvOFe/k37tkpbXlQVo5fMFBIJryX3CAG1t36IeskblKoS7f9p1qPMTBDPqQDZKKMvDGnyW2ZsmvwyAGBgIz24XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQL0Y9jB/O6zCZK3vJMiRl+i3XMEdESu9UZPtTVbHUQ=;
 b=KpRwRjzBWRQ+Tkg/TFngYdkS+vG1G9NVQWrxvUdHgvNj0j6mbXVndcVLNWp0KN25DIEJqXPF2cDM2xQmoGguwFyUUVhqr2PfV2PLGFKaQr3oePODG1Oj88oV9Tjc2yWBWl8OaQSHjuwQAmBjaxixqaUfg4V10bFdl9s2zHWgjELcmEfBVy5cdeySczaLx0r2kAmNZOUi3YXGxyKJbnIOAEPXvlJXpVDELh0Gwb5wXNSOy254m5f0555RGwYHk9rU70/GYBcYkDkn+kn7KM4GJoH30mTPoqox3MzY88zso40NsNRcaLwr4rW72/a0b9hcEA/qVPkgZpZY08yrPEfw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQL0Y9jB/O6zCZK3vJMiRl+i3XMEdESu9UZPtTVbHUQ=;
 b=GJKnFF/kVeeuzwSHVcDkSWfSh548tRltVlNotxXXcKl/RYKrom1qZ/gbABnfCgAIQVjl0aUcZuA0qK7fXTzrDaLpKHs9FMQXFjgH/suGWE7fGQD9QcdYK3tANrVKHk8G8Y/UMWdl3zb6H+msrRmg7yrvbOFEPs10mSL1Kv8diq8=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by DU0PR02MB10043.eurprd02.prod.outlook.com (2603:10a6:10:422::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Mon, 25 Sep
 2023 16:00:57 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::46e8:4a9e:ea9a:7861]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::46e8:4a9e:ea9a:7861%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 16:00:57 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] bitbake-getvar: Do not output anything
 with --value and undefined variable
Thread-Topic: [bitbake-devel] [PATCH] bitbake-getvar: Do not output anything
 with --value and undefined variable
Thread-Index: AQHZ75HHLvUupXI6K0yyvOd1GScPw7ArSq9wgAAMr4CAABNswIAAKSuAgAAJ+kA=
Date: Mon, 25 Sep 2023 16:00:57 +0000
Message-ID: 
 <DB5PR02MB1021356A2A4354ED39DB5CD96EFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230925032246.1316597-1-pkj@axis.com>
	 <2dfb0d4ca6650781ad55e6ba164da4e40d7b41f7.camel@linuxfoundation.org>
	 <DB5PR02MB102138720B4A38345285D26BCEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
	 <35b58142c73b9b22f960a87876f260d10c30b57c.camel@linuxfoundation.org>
	 <DB5PR02MB1021381B9F45F71019B89C8FAEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <659f37fdb542e410ab6ed039d6cadb2403024350.camel@linuxfoundation.org>
In-Reply-To: 
 <659f37fdb542e410ab6ed039d6cadb2403024350.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DU0PR02MB10043:EE_
x-ms-office365-filtering-correlation-id: e72e8c8a-a335-4997-ed75-08dbbde09b2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RYUKP1LW+2qa/YXbHSBCKHlLRjuyuzbRN6GvccIS8kUU8MJBxpedHuKEioikKnR7Y48oVLeCjlfnHlMf2m0/HwMVN37+ceFukCTNDTtt8QZ0dtRyiIyi/xgm0iuFgLNGhEPiNwVh2ZS9YDOekFG/VoLdFAG1/iuAjecqYxOrDVd6/C5ES1pv5Kvrg2mqK3kV/GPacxqBS4ytqz85nrAMm310+N6atyN/kkePGA25oP984I9lk7lf+KaYLskRpYLlL5KobLhFZNXGPbfUelsAJq1+ALMwH/VUH2Neooa1iyIlAcmjQeMPvqJ14H4jq3Lc5KcnhmRdlEz2fPywpxCA0nGqhuatXCM+ZKTx2op5HdbLt+cZ26UxbCpR3Qpjt71TEuUn32ejn+5cvnyVORqgembSXACFgy58uCM/I+l123ginSOr/Gni6n/JScfG+SC0CqnokyavsHvZ2VkLe8lJaSIRn+FVOaIHplUfFl5HrSifDBTUCzzZ7wL1Lfn00AFp249ggU27Me1uoZDomdsa3Q+R54ebO8qjSfcAxVqcq0wiQOwqxcSz8B5eR6ro04xEYebPn1jwy5bSlfYSrGcG2s1PjgAeNgCzWIeL6XCSu+TlSk6myZrJlynR26N8jv8N
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(1800799009)(451199024)(8936002)(8676002)(26005)(52536014)(110136005)(76116006)(66946007)(83380400001)(44832011)(5660300002)(2906002)(38100700002)(55016003)(7696005)(6506007)(53546011)(9686003)(478600001)(66446008)(66476007)(66556008)(64756008)(316002)(33656002)(86362001)(41300700001)(71200400001)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d1cxNWlOOWpublVCQWZZMjZacmI1OHhBZWliSlF0NlFJaE9qWTZCVmo5YS9O?=
 =?utf-8?B?bDk3Qk1QSGM0Z1c1QU1yNlhhVi90UzArcStMYlpkdjB4Nit0U1NzREpoalFz?=
 =?utf-8?B?ekZNVWY1VTRwdjExaEMvZEZjV1gzbm5QS2FLNGxvTkdTbGJBdG1McENjUmRu?=
 =?utf-8?B?aU00cXFDZURqbXQrS1hmZ3FlL1RDRTIraFVhb0owQ2MrWnZSM0pyY05HMk5u?=
 =?utf-8?B?SndHU3pmOXo1VlJ2dHQrcmJmeHMyZWlLWFlSd2lDdXA1MGRBT0xuSDFWbDgr?=
 =?utf-8?B?NUdmQlgxMGdyMVNFUGZSVW1pdGJJMGZLWjFrS3l5U1c5TVdsUU1RR09ZSVAz?=
 =?utf-8?B?S2hWa2NtbUxWclNodVMrelFJSlpqOG8zM3FtdS82MC9pOGhaT0dUV0Exd0RW?=
 =?utf-8?B?V21DeDA4S0doVDZiekJjZWFRd3UyU1kxTzlwMUl2dE9CSHRva2xDa2xxb0pq?=
 =?utf-8?B?QVpScVdaL3IyTnNMdU9KTFNtODQwVGN4a1NsUDYxVjBvZkxBSEFqc3F2RjVQ?=
 =?utf-8?B?YSthOHFtUDF5c2p5S0pobncrVkt0N2VVN0ttM1Y1NXZ5N1FZM1ZBV0lHZVU1?=
 =?utf-8?B?ZlVEcHU3U0owYncrSUdVUEUzSDZ2TVNHY0JSYVNSRXBZWVE3WXlYc0EzbTE1?=
 =?utf-8?B?YlNYb21PN3VUNmRiYVF3cXNTVVI4NjVHN1J4ZWdDYlpDVXpwMlN2V2Zyak9u?=
 =?utf-8?B?S3JmWEhabFFBWDZkeXpNcTlQWDdJQTM2OFBjVU5EcEV4SHZybGhBRW16Ti9r?=
 =?utf-8?B?VHU1VkRHdDN2N2Y2UUZQT2lDWG85VFBETTcxdnNyTVM3aFR0RURocmZ6YjY1?=
 =?utf-8?B?Nnl6SFQrcVZzRUZ6SC9kV2ZuY1RLc2Q3TUVIZUo0NGJTQ2V2alZRR3pGRnRS?=
 =?utf-8?B?R0xjS3VNK1dZRHUraDRkY0dvcXpyYzBReVBQeENwZEdvRkZFdkZIYXZPencx?=
 =?utf-8?B?SzdpQ3p3ZWV0R0ZEVmY4L2tHTlZOcW1xN1hlc0ZpWXFta09OUENkOFVrUWJn?=
 =?utf-8?B?THRjeHNhZjZjMnZ0MDFsOUpuMG9rV3hGdnFtcGhlQlJKTkN2VTNDZUhpNEdT?=
 =?utf-8?B?K3hHMFY2RFBNeHFiRm1sZWllQUQzK01wc1gyNGdHVTNIMU5XVHV5R3ZPQ2ZT?=
 =?utf-8?B?ZGMxK1ZvNXVxNThuYmZndGZldy9ISE1OQUFNenhqam8yQSsyWSswU084R2sx?=
 =?utf-8?B?V1dyTnhxK2ZoTG5NSHdLczJVRk1xN3pvcHpxYitOMXlrMXVzcWhyYWVEZ285?=
 =?utf-8?B?OGNsd0o1d1VJTEs1aDM5RzJ1d2RySnNYTFNldm9MNEUydVUwQzFhTjhWajdP?=
 =?utf-8?B?Rm05OGRCVXpSbVZVSDhERE1USkxvMjBRQVlBVDFTWU4rU3NMVkNGVWhyTjZZ?=
 =?utf-8?B?SUltZ1drcDNzRVpROTNUTGNLZzl0U0FGSlJmdTh3VCtZTWt1VnBSSG1sbnlM?=
 =?utf-8?B?RThXblZ0ZElUcGswNzhjMXM1aDRiTC9sOFBvS1Q0QnhzMkpDcG1MRC9MaHdG?=
 =?utf-8?B?TDB4YnZTckYvQkhidEVaM1Y0UnpLdHNhMkZEWEV0Zk51R2NEdTd0MEM5OUZq?=
 =?utf-8?B?N0RhTkJ3UytUaGhhYUJLNGtpdjV0T1gyb1dvSm5LZU5DcDJiYUpZTU1ib3RL?=
 =?utf-8?B?UEZQRHZHQko2TTVPOHpTNTdEVHJKSzBBdTJXWHFVTFRBZjFwN2xpcjRCbGlP?=
 =?utf-8?B?dnpldVZ5RmFjbHdUcXlLQzk5M2Zxd21kQ3Q1QjZRVEpxOUpLTWdxR1ZOeVFQ?=
 =?utf-8?B?bmFBZ2FKU0FhVy9IazU3dmhGeWFkMmRmV0xFQnRKMWpzVFFMVHJaTDVMV3Iy?=
 =?utf-8?B?S0xGN3BucHdMdXVRbm85TjNFTWtQQTN0NFcyVnpxeGc1N0tac0Zaa0h1cVpk?=
 =?utf-8?B?REcxai9CM2x6RnpRL2NkK0JMYWkrSk9yaCtTTXU3TDd4Z0J1OXlNc0tzdEFx?=
 =?utf-8?B?eVJUM0ExWHJ4eVcrajlzTE1uTnQ2eWNKVE8wMVRnbEZIQzlwUkhDQ2xTVndT?=
 =?utf-8?B?ckFjdjcxQ2NuNDcrMmZFMnZic0NSaHFkbTlHdytWQllGejNQbUtTb3p1VHJs?=
 =?utf-8?B?TDNLUkNSdnpLTG9wL1BldnRBRHI1QjV3Tmhaakt6Rm9ic3lHMEhoaHkvME1W?=
 =?utf-8?Q?Yc3o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72e8c8a-a335-4997-ed75-08dbbde09b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 16:00:57.6468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0z1jXqPbJ/CjzWF+5wS7CmVVzJkjPKbMd3upF76FS+Dce/ujNTnqiammiZqKICZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB10043
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 16:01:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15120

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmlj
aGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogZGVuIDI1IHNlcHRlbWJl
ciAyMDIzIDE2OjA3DQo+IFRvOiBQZXRlciBLamVsbGVyc3RlZHQgPHBldGVyLmtqZWxsZXJzdGVk
dEBheGlzLmNvbT47IGJpdGJha2UtDQo+IGRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4g
U3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0hdIGJpdGJha2UtZ2V0dmFyOiBEbyBu
b3Qgb3V0cHV0DQo+IGFueXRoaW5nIHdpdGggLS12YWx1ZSBhbmQgdW5kZWZpbmVkIHZhcmlhYmxl
DQo+IA0KPiBPbiBNb24sIDIwMjMtMDktMjUgYXQgMTM6NTUgKzAwMDAsIFBldGVyIEtqZWxsZXJz
dGVkdCB3cm90ZToNCj4gPiA+IEZyb206IFJpY2hhcmQgUHVyZGllIDxyaWNoYXJkLnB1cmRpZUBs
aW51eGZvdW5kYXRpb24ub3JnPg0KPiA+ID4gT24gTW9uLCAyMDIzLTA5LTI1IGF0IDEwOjE2ICsw
MDAwLCBQZXRlciBLamVsbGVyc3RlZHQgd3JvdGU6DQo+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmljaGFyZC5wdXJk
aWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPiA+ID4gPiBTZW50OiBkZW4gMjUgc2VwdGVtYmVy
IDIwMjMgMTE6MjINCj4gPiA+ID4gPiBUbzogUGV0ZXIgS2plbGxlcnN0ZWR0IDxwZXRlci5ramVs
bGVyc3RlZHRAYXhpcy5jb20+Ow0KPiA+ID4gPiA+IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVt
YmVkZGVkLm9yZw0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gW1BBVENI
XSBiaXRiYWtlLWdldHZhcjogRG8gbm90DQo+ID4gPiA+ID4gb3V0cHV0IGFueXRoaW5nIHdpdGgg
LS12YWx1ZSBhbmQgdW5kZWZpbmVkIHZhcmlhYmxlDQo+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+
ID4gPg0KPiA+ID4gPiBNeSBnb2FsIGhlcmUgd2FzIG5vdCByZWFsbHkgdG8gYmUgYWJsZSB0byBk
ZXRlcm1pbmUgaWYgdGhlDQo+ID4gPiA+IHZhcmlhYmxlIGlzDQo+ID4gPiA+IGRlZmluZWQgb3Ig
bm90DQo+ID4gPg0KPiA+ID4gSSBrbm93LCBidXQgdGhhdCBpcyBhbiBpbXBvcnRhbnQgZGV0YWls
IGFuZCB3aGlsc3QgaXQgbWF5IG5vdA0KPiA+ID4gbWF0dGVyIHRvDQo+ID4gPiB5b3UsIGl0IGRv
ZXMgbWF0dGVyIGEgbG90Lg0KPiA+DQo+ID4gV2VsbCwgYXMgSSBzZWUgaXQsIHdpdGggbXkgY2hh
bmdlIGl0IF9pc18gbm93IHBvc3NpYmxlIHRvIG1ha2UgdGhlDQo+ID4gZGlzdGluY3Rpb24gaWYg
eW91IHJlYWxseSBjYXJlLCB3aGVyZSBiZWZvcmUgeW91IGNvdWxkIG9ubHkgYXNzdW1lDQo+ID4g
dGhhdCBhIHJldHVybmVkIHZhbHVlIG9mICJOb25lIiBhY3R1YWxseSBtZWFudCB0aGF0IHRoZSB2
YXJpYWJsZSBpcw0KPiA+IG5vdCBkZWZpbmVkLg0KPiANCj4gQXMgdGhpbmdzIGN1cnJlbnRseSBz
dGFuZCBpdCBpcyBjbGVhciBzb21ldGhpbmcgd2VudCB3cm9uZyB0aHJvdWdoIHRoZQ0KPiBwcm9j
ZXNzIHlvdSB5b3Vyc2VsZiBtZW50aW9uZWQgYXMgaG93IG5vdGljZWQuIE9uY2UgeW91ciBwcm9w
b3NlZA0KPiBjaGFuZ2UgbWVyZ2VzLCBpdCBiZWNvbWVzIHZlcnkgdW5jbGVhciB3aGF0IGlzIGhh
cHBlbmluZy4NCg0KVGhlIGRvY3VtZW50YXRpb24gKGkuZS4sIGBiaXRiYWtlLWdldHZhciAtaGAp
IGZvciAtLXZhbHVlIHN0YXRlcyANCiJPbmx5IHJlcG9ydCB0aGUgdmFsdWUsIG5vIGhpc3Rvcnkg
YW5kIG5vIHZhcmlhYmxlIG5hbWUiLiBXaGVuIEkgDQpyZWFkIHRoYXQsIEkgaW5zdGluY3RseSBh
c3N1bWUgdGhhdCBpdCB3aWxsIG5vdCBvdXRwdXQgYW55dGhpbmcgaWYgDQpJIGFzayBmb3IgYSB2
YXJpYWJsZSB0aGF0IGRvZXMgbm90IGV4aXN0LCBub3QgdGhhdCBpdCB3aWxsIG91dHB1dCANCnNv
bWV0aGluZyB0aGF0IGxvb2tzIGxpa2UgYSB2YWxpZCB2YWx1ZSAoaS5lLiwgIk5vbmUiKSwgYnV0
IGlzbid0LiANCg0KSSB3b3VsZCBiZSBmaW5lIHdpdGggYW4gZXJyb3IgbWVzc2FnZSB0byBzdGRl
cnIsIGJ1dCB0aGVuIEkgd291bGQgDQphc3N1bWUgdGhlIHNhbWUgcmVzdWx0IGlmIGJpdGJha2Ut
Z2V0dmFyIGlzIGNhbGxlZCB3aXRob3V0IC0tdmFsdWUgDQpmb3IgYW4gdW5kZWZpbmVkIHZhcmlh
YmxlLiBJIHdvdWxkIGFsc28gcHJlZmVyIGlmIGl0IGlzIHBvc3NpYmxlIA0KdG8gc2lsZW5jZSB0
aGUgZXJyb3IgZm9yIHRoZSBjYXNlIHdoZXJlIHlvdSBkbyBub3QgY2FyZSBpZiB0aGUgDQp2YXJp
YWJsZSBpcyB1bmRlZmluZWQuDQoNCldoZXRoZXIgYml0YmFrZS1nZXR2YXIgc2hvdWxkIGFjdHVh
bGx5IGZhaWwgd2l0aCBhbiBlcnJvciBpbiBjYXNlIA0KdGhlIHZhcmlhYmxlIGRvZXMgbm90IGV4
aXN0IGlzIG1vcmUgZGViYXRhYmxlLiBJIGNhbiBzZWUgdXNlIGNhc2VzIA0KYm90aCB3YXlzLg0K
DQo+IEknbSBub3QgZGlzYWdyZWVpbmcgdGhhdCBpdCBuZWVkcyB0byBiZSBmaXhlZCBzb21laG93
IHdlIGFncmVlIG9uIHRoYXQNCj4gYW5kIEkndmUgYWxyZWFkeSBzYWlkIGFzIG11Y2guIFdoYXQg
d2UgZGlzYWdyZWUgb24gaXMgaG93IHRvIGZpeCBpdC4gSQ0KPiBkaXNhZ3JlZSBvbiB0aGlzIHdh
eSBvZiBhZGRyZXNzaW5nIGl0Lg0KDQpCYXNlZCBvbiBteSBjb21tZW50cyBhYm92ZSwgaGVyZSBp
cyBteSBzdWdnZXN0aW9uOiANCg0KV2hlbiBhbiB1bmRlZmluZWQgdmFyaWFibGUgaXMgcmVxdWVz
dGVkLCBnaXZlIGFuIGVycm9yIG1lc3NhZ2UsIGUuZy46DQoNCiQgYml0YmFrZS1nZXR2YXIgVU5E
RUZJTkVEX1ZBUg0KVGhlIHZhcmlhYmxlICdVTkRFRklORURfVkFSJyBpcyBub3QgZGVmaW5lZCEg
W29uIHN0ZGVycl0NCg0KYW5kIHNldCB0aGUgZXhpdCBjb2RlIHRvIDEuIEFuZCB0aGUgc2FtZSBy
ZXN1bHQgd2l0aCAtLXZhbHVlOg0KDQokIGJpdGJha2UtZ2V0dmFyIC0tdmFsdWUgVU5ERUZJTkVE
X1ZBUg0KVGhlIHZhcmlhYmxlICdVTkRFRklORURfVkFSJyBpcyBub3QgZGVmaW5lZCEgW29uIHN0
ZGVycl0NCg0KSWYgLXMgb3IgLS1uby1tZXNzYWdlcyAoYm9ycm93ZWQgZnJvbSBgZ3JlcGApIGlz
IGFsc28gc3BlY2lmaWVkLCB0aGVuIA0Kbm8gZXJyb3IgbWVzc2FnZSBpcyBvdXRwdXQgYW5kIHRo
ZSBleGl0IGNvZGUgaXMgMC4NCg0KPiBJJ20gbm90IHRha2luZyB0aGlzIHBhdGNoIGFzIGl0IHN0
YW5kcy4NCj4gDQo+IENoZWVycywNCj4gDQo+IFJpY2hhcmQNCg0KLy9QZXRlcg0KDQo=

