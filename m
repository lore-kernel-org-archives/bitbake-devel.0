Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E088CF8578
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 10:31:03 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.51])
 by mx.groups.io with SMTP id smtpd.web10.8133.1727951452656736997
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Oct 2024 03:30:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=Etlqn/2k;
 spf=pass (domain: axis.com, ip: 52.101.67.51, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Msrv7sxb99ub8M66ksm6+DiYVLxoluJtYTg8solJvBxWEWV3GwFKN+6+lRBL1cTfAa2EFyVVP9h4rWv9OV6C69z4uB0cuAxrut44YrU18ebYNah0GIZUwnR0uUq0RklOTUlboM40tn2j1LHhwxTqP9SZKzJat+UJefmKQLVLLDPGx+i+1sgXNnXG/0Gc11QkMl47r3ctyzo8S/kjlYWWyontfuas8ONrVjW1CdnbhOI7hjzukSfFP3NiaZOkZgxil5vplwfUvzNa5dqvWZ2XZFi4gk++ZXHrPQD440Be5pOFTbcJiFnZt39EevtVPmoNz9WfEkJUV7ZMtd9f0t8ymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrkolvOj38cCE7jXsf2C0PPZ98ubrFZ2IWATRucvE9E=;
 b=HPgsQb5JMeWc+/61zkC3cl0LCLkyr+D4aR5kH+7Xy8D6bggx1L1DCwR9TWuHjTwJDAUysVP41wWP+EXdkaE/z4FtCSnDd9mJqz32lBxoY/tuZNnkuvX1uhghNO5mhHlyRopVqeCVjFiAYHxkKfAZC0NqEx/qB/t4arSq/k5w0xBCOe3V9X6EpKlfiIfNtLL9MUXFYLfHvgy4R21FlwFLIu5ZZ5MIn69YQs4ofaTEnyv7LcTrR8Lyvy2uIIYZRQGsB0P68C8H1K34uZuusdjjCntJmhvpwZbYvnakAhJA2/MDBnQgHS2xnpYw8qfB5S6c/0WVLoJQmp84wBlePCEHkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrkolvOj38cCE7jXsf2C0PPZ98ubrFZ2IWATRucvE9E=;
 b=Etlqn/2kfLOv4nly3pazEBOloNJQ/zHEYTaLeS3iVrigFYVn4TM4Gr4MXOwmmEhSHP6yjtM8Rm+5l7lMC6PSGHDCeWIKdon40rxyLGyvCUgLcaGogMowALzcPoiE1u8skkQKDxEwALdfI8MU0eGl0eCTf3Eb9ZcujzBVuw51/1A=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by PAVPR02MB9133.eurprd02.prod.outlook.com (2603:10a6:102:323::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 10:30:49 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 10:30:49 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Konrad Weihmann <kweihmann@outlook.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH v4 2/3] bb/data_smart: fix override syntax
 warning
Thread-Topic: [bitbake-devel] [PATCH v4 2/3] bb/data_smart: fix override
 syntax warning
Thread-Index: AQHbFWwfULzeqaR7ekCLMAMWZsynPrJ0zIlg
Date: Thu, 3 Oct 2024 10:30:49 +0000
Message-ID: 
 <DB5PR02MB10213CFBC40BA9DE6FD9320B3EF712@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: 
 <GV1PR07MB9120D47783B36E780C1BF012A8712@GV1PR07MB9120.eurprd07.prod.outlook.com>
In-Reply-To: 
 <GV1PR07MB9120D47783B36E780C1BF012A8712@GV1PR07MB9120.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|PAVPR02MB9133:EE_
x-ms-office365-filtering-correlation-id: 3982a83c-5757-4fa9-570d-08dce39672cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cWdkd3UvRXNsRWpSV0gyd1EvWUd4WGZTdFFnT2VBT1FnM052WkVzbHhsSFJS?=
 =?utf-8?B?bWJzbVRmbEVoalljd2xYajVkZVcvaExvWFFNQjVZSHRkZUtBK0JGR2ZpQUZI?=
 =?utf-8?B?NGJsZjF3cDZ4bVoxVVpPVnF3YnkxNTJRbkw0RkpGZTFSdDRXeFJsNG1la0dJ?=
 =?utf-8?B?eEM1QU92d3o0UGtsRkdHUXZUc0dUdnhyUDlBcmRtVURZR2lKL3o5OEREZFR0?=
 =?utf-8?B?UGZDWThnd2ZhbC96cGRRZldsS3dxS3MxUXI2NHlFdU1jaFU5a2ZhTS9IUktZ?=
 =?utf-8?B?THpqamp3QktnRWNZK3Bjb2xTTkJaQUhPOUJtTTBMQlZ0aTdQS1dXaTZPWE53?=
 =?utf-8?B?ak13NUFtWkdJc0FFRmRwRUdxTjZZMzB1OFhGaVAwR0ViTFZFRlhXNkJJRGVX?=
 =?utf-8?B?QWxHSER0blFtRSsrcE56OS9KYjFWQkZkU1ZLZVpUUE1MYitpQ3Z3ZVVBVzBt?=
 =?utf-8?B?VFY1VnpEaTJ2VnBGd3BldVBhejhKbnlQYjlEaldnRUwxOTJPRjRscHFCaTJk?=
 =?utf-8?B?c2RhYVlua3pOcjB6ZzlxbkN0UEZYSDBvdnY3TEdQeE4wZFRlS2JHa29HcjZp?=
 =?utf-8?B?YVhtN1pKbWZxNDFLVW9vTW13SjJCdDFoWjFnbldQb1JxZVBtYjBUUWxxM3g4?=
 =?utf-8?B?Q2Vab0Q1V2E3a0MvS1diK2dQdkFpSEtFZjA5d0ZaQUZrUWRGeC9JaU9rWTRC?=
 =?utf-8?B?SUpBNjhVdGdEN1M0d3lHMmZOaWMzVTRXQVArd1BFNzl4QmtlV2s5dlRoTFB4?=
 =?utf-8?B?cmlVdE5ONk9rYnJNa2JWVFkwZjQ1TTR0eDZYTmkydHA5TVNSc3ZxTkxwMWlY?=
 =?utf-8?B?Z2todXg2eFRzSVNJdWhVamVWUE1tRDdDclBocU1rQjh6dXZjSTgvVGY2a1FS?=
 =?utf-8?B?Vk1MYVkrVmk3UWZISFhCell4SXU2TDFBOVE4WER6ek14NGEyeFRqMXJ3WGFP?=
 =?utf-8?B?N05tbG80WElBaGF4K24wQ25CRUdsNlZCZDI5N1B0bWhSMWpsZTRrR1lMU3pi?=
 =?utf-8?B?VlpLYXdWSlUvc0JKaEYzWHNmbkl3MGcyRVBoYXZQOVFhejhMZUtQeWJ0eE95?=
 =?utf-8?B?Yjk4ODRybVhObjVyZExYN2RlTHk3QStwV1EwQVJWbnVVWUQvTnhmRW9TUExT?=
 =?utf-8?B?WEN3Ty81S0N3UDA4d00rdkJtVTNsbWlhbUlXUXltcGFJc0x1K0RKajVoc0k2?=
 =?utf-8?B?YkZ6bmFMWUs4Ry9nTjBXdFhlQjJEUzZwamVOSmI1TVd1UlYyNWpwTmN6SUgr?=
 =?utf-8?B?ZkdqWVJxVVNna2k5M05HUkh2RzRnTFdkb2g0SlRSYVczTHNnQTFtRTQxTTdS?=
 =?utf-8?B?cnFJOHpielo1NXBIcm1QSnQrRWpKRDArMzhCWkhSNTQzZndXc3d4S0tlaFI2?=
 =?utf-8?B?c0xFM0lhN21EYnM1d0YyWkgvYUMwV2x3TmdIZnVNVk9qYUFoc2lpeTQ5N2kx?=
 =?utf-8?B?S0RRU0QxaStsazlhU2dZeW5ZZGVjb1hZYnJYZVJaeXB5TnpXRTdSd2JNdWND?=
 =?utf-8?B?Mm1oeU10VlIzMlp6OFlQdkZqQ1VMZDdVWDVyUmJCd3B2dmtWNkhPbjVDckhQ?=
 =?utf-8?B?aHA0V0pRbVMva05TdzlLbnY2d1daY1hoVHl4S2FjU3JsZFpRaWQ1aSs0Rmpo?=
 =?utf-8?B?UStDRjVvSHF5aHVIRnhuK2NObUE4YmZLSDB1RCtqU21CRjRJVjhURm4yc0VQ?=
 =?utf-8?B?WndEVW5MUWhPZTRCbjlnSkRRSDFqRXU1cHFnK2xKcXVaT0s5U0o1MGV5TnNT?=
 =?utf-8?B?dDhYTDRNeVF6RWxxeXRSY0tpcmtaWVduMVd3NXRqS0RLeXYwbitIT3c3bGlE?=
 =?utf-8?B?YjdiWGVOK28xS0c4QVRSZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MGJnSElxelVleFFrd0lHU2dQSjJDemJZRDZ1eXp1MDZURS9XUjFKQ0pyWllv?=
 =?utf-8?B?Z2RON2kxZDArYnRCQ2pkYWJqbklpQTljUkRsOTllVm10cmMrQ3N2bXBYQ1N2?=
 =?utf-8?B?TWZOSEtkMjR4SkRlcFdIbmJHcEVNRUFHKzVOZzIzRXJkTGlLR3FYYWpMRUNi?=
 =?utf-8?B?TXVCcXJZVTN1czdyWnd2dXlyVmMybHJMKzJEUEsxNlJWSDQ0Q3lLc3VCcmp1?=
 =?utf-8?B?TFBoNXNMOWVTd2U1UmpjcDlwOTV5N1BIQSswelY0T0ZTTFhzRUFlUkV5ZEgx?=
 =?utf-8?B?cXZrOEgxNTIyYXl4Q3k2SHA3akwvUmhod1YvanVCOGxaWlJTM3hmUURvR2c3?=
 =?utf-8?B?ZFYxenRGWXpTdlN0a3NTQjRnT2NKYUFySlhkNDJnQnc4cEhDWEJkSEp2SWIv?=
 =?utf-8?B?OXdiZlpuOXE4UTVYb1RIckNZY3dsemFnaE4vZUpleC9tckJ6VXFRdVBzR1ZH?=
 =?utf-8?B?eloxNnFWbWk1RDVnRVpMNmVrWnB1bFJITFE4QVNGcWdNYzkxZ1JwQ0FHWXdH?=
 =?utf-8?B?a2lmdjhncUFuVk5qTWJJUGxDdnpZdWd3citHczYyOEpnMWNETDNuYU1NTkt1?=
 =?utf-8?B?aE1BVnU1di9oNmovTWxnR01acU1OZHRZMXNSbnI1dXhJQUNpcDZJT1NKakNF?=
 =?utf-8?B?TkZaeEhmZ3EyQjNNVms5cHVpUkxxS2ZyN0JRdU1wbFMrRldXckpUZ25XTERY?=
 =?utf-8?B?cmo3Vnk1M1hVZkZIT2k2dThudlV6d3dIWExMbU81cE9XbGg3cmlkU3ZoQlZt?=
 =?utf-8?B?M1pnd1gySmxqNG5SQTBsdm1MZXE0ZHl3WWZzMCt6YkR6emEyajFHai9HWkFP?=
 =?utf-8?B?VkppY01adnlsalpSSXBna0pvOGxNY0pjQ2tBQjNGL0IzbmN0Y1Q1djIvK21S?=
 =?utf-8?B?T0N5eFBmOW12ZURRYXZ5R1F2Q2xDSGpzOGVMVEU4dEJnT09WSXVoak9obVpT?=
 =?utf-8?B?ekRzMWxxYVhkZithczdxcTBKc29hUE9Icng1Ykd1SUExTTlUOGxUVEZLNURB?=
 =?utf-8?B?M2o4VEZ3bVJROHdvdzZSdHVXSkEweWdmKytPMDNqdDQ2aEZua1gvQ25qdk9w?=
 =?utf-8?B?ZlBZK0EzOEQzUEtpNWV4L21OU0hzUkpGYlgvdDQrVjJJL0FEYjl1Szk5MFFv?=
 =?utf-8?B?d2RVMUE1dmgrYmJJaUNGcGZwQjRoditqemc0bitVOUVOd1puU3lFcitxWVgv?=
 =?utf-8?B?Nk53VzQ3SWdKWVZRcEdKMFBjQW1LUHJtV0QvakswbVk2MVVaUU5URU9XRG81?=
 =?utf-8?B?L2lXS29UcERxTldyMUNGM0hnc3BQSzFpeXBxaHFBcTJTakRKMmF4eCtlRm1v?=
 =?utf-8?B?MFRBZ1AvZW9KT0Nxd3hSTllMdkM2Z1d1U3VGMEtLcm4rdWpEUUVtMFpjSmZP?=
 =?utf-8?B?azdQYlcveUR1NkVtS0syR0JjRE43elR2YnY0N01WMFlvMmtZcG5pRUhvV1VU?=
 =?utf-8?B?NDNhdE1TVllyQ3dqd2pLSm9TN255VmVVZDJIMHhvWTdXek5RUm8yZklIYzBj?=
 =?utf-8?B?bUxtUHJKNlhlektEVDRlNWl1WUlPVUZVVjdPcFBwNm9RMEQzU2tOd1FjTXVp?=
 =?utf-8?B?SmpKcmV6M05ocUZ0SFJvbjkvME1ROEx3ZlFBWHV0Umx6dU9oaDN0NFBTMExz?=
 =?utf-8?B?RkJ4dnJ3YUh0ZTM4RzJ1UjU4c3MwTUJ6Y0tYS1lpN1R6TStrVGo3aEZFZDBu?=
 =?utf-8?B?T0UvS05XNSt6SkY2Ni8rZnVoUnd5ekhxY25hWEx6TllvUnhkbGhoU1FyNnRM?=
 =?utf-8?B?aytFLzVLSUMzWm1Lakx4YjlkSnBqWEdaVUxRbVUwSjZKNTJVSnIrdjlsMUhH?=
 =?utf-8?B?dXFIdWQ3NFNUUTdEajBaaGZNVFpidXY3YXhoSDN3S2MyQzJZSFhxU0Z6NURi?=
 =?utf-8?B?dzJ2cWZ5VzJOamU0OWpKeGF2SDBidG50aFZTK1dVUDAwSHNHT2JkMU90MDdl?=
 =?utf-8?B?Q3JIQ082dVprd2lqQ0ZuM1MzOWVWNkE4SGRCVGN6VEhJRm94ejNDMmRRUVRT?=
 =?utf-8?B?OVZjRmNqQmZPRDgrQjR5WGxmb2o1WlN2TFlzSUtrRXd1NHhwV1ROUXBoc2ZE?=
 =?utf-8?B?VDN1ZjFpalpzOXYvTVZJd1lkMXZaMEhabW42THJNVmc5dHM2Mmk1Tm9acE8w?=
 =?utf-8?Q?/wUM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3982a83c-5757-4fa9-570d-08dce39672cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 10:30:49.0395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gm2sLZVr/LB8ENPmkvfDvolFxsiGikWSGvMC8VGaGVt67kIWOkO0wSO2AiKH2KTo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9133
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Oct 2024 10:31:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16632

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIEtvbnJhZCBXZWlobWFubg0KPiBTZW50OiBkZW4gMyBva3RvYmVyIDIwMjQg
MTA6MTMNCj4gVG86IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBTdWJq
ZWN0OiBbYml0YmFrZS1kZXZlbF0gW1BBVENIIHY0IDIvM10gYmIvZGF0YV9zbWFydDogZml4IG92
ZXJyaWRlIHN5bnRheCB3YXJuaW5nDQo+IA0KPiB3aGVuIGRlZmluaW5nIGEgZnVuY3Rpb24gZG9f
cmVtb3Zlc29tZXRoaW5nLA0KPiB0aGUgcGFyc2VyIHdhcm5lZCBhYm91dA0KPiANCj4gVmFyaWFi
bGUgZG9fcmVtb3Zlc29tZXRoaW5nIGNvbnRhaW5zIGFuIG9wZXJhdGlvbiB1c2luZyB0aGUNCj4g
b2xkIG92ZXJyaWRlIHN5bnRheC4gUGxlYXNlIGNvbnZlcnQgdGhpcyBsYXllci9tZXRhZGF0YSBi
ZWZvcmUNCj4gYXR0ZW1wdGluZyB0byB1c2Ugd2l0aCBhIG5ld2VyIGJpdGJha2UNCj4gDQo+IGNv
cnJlY3QgaXQgd291bGQgYmUgdG8gc2VhcmNoIGZvciBhIG92ZXJyaWRlIG9wZXJhdG9yIGF0IHRo
ZSBlbmQNCj4gb2YgdGhlIHN0cmluZyBvciBmb3IgdGhlIG5leHQgb3BlcmF0b3IuDQo+IA0KPiBU
byBhdm9pZCBydW5uaW5nIHRoZSBleHBlbnNpdmUgcmVnZXggc2VhcmNoIG9uIGV2ZXJ5IHNldFZh
ciBjYWxsDQo+IHRoZSBjdXJyZW50ICJjaGVhcCIgY2hlY2sgd291bGQgYmUgaGF2ZSB0byBiZSB0
cmlnZ2VyZWQsDQo+IGJlZm9yZSB0aGUgbW9yZSBwcmVjaXNlIGNoZWNrIGlzIHJ1bi4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEtvbnJhZCBXZWlobWFubiA8a3dlaWhtYW5uQG91dGxvb2suY29tPg0K
PiAtLS0NCj4gICBsaWIvYmIvZGF0YV9zbWFydC5weSB8IDE1ICsrKysrKysrLS0tLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbGliL2JiL2RhdGFfc21hcnQucHkgYi9saWIvYmIvZGF0YV9zbWFydC5weQ0K
PiBpbmRleCA0ZTE1YTQzYzIuLmJkMjcxNmIyYiAxMDA2NDQNCj4gLS0tIGEvbGliL2JiL2RhdGFf
c21hcnQucHkNCj4gKysrIGIvbGliL2JiL2RhdGFfc21hcnQucHkNCj4gQEAgLTM1LDYgKzM1LDcg
QEAgX19leHBhbmRfdmFyX3JlZ2V4cF9fID0gcmUuY29tcGlsZShyIlwke1thLXpBLVowLTlcLV8r
Li9+Ol0rP30iKQ0KPiAgIF9fZXhwYW5kX3B5dGhvbl9yZWdleHBfXyA9IHJlLmNvbXBpbGUociJc
JHtAKD86ey4qP318LikrP30iKQ0KPiAgIF9fd2hpdGVzcGFjZV9zcGxpdF9fID0gcmUuY29tcGls
ZShyJyhccyknKQ0KPiAgIF9fb3ZlcnJpZGVfcmVnZXhwX18gPSByZS5jb21waWxlKHInW2EtejAt
OV0rJykNCj4gK19fb2xkX292ZXJyaWRlX2RldGFpbGVkX3JlZ2V4cF9fID0gcmUuY29tcGlsZShy
IihfYXBwZW5kfF9wcmVwZW5kfF9yZW1vdmUpKF98JCkiKQ0KDQpXaGlsZSB0aGUgcGF0Y2ggaXMg
bm8gbG9uZ2VyIGxpbmUgYnJva2VuLCB0aGVyZSBpcyBzdGlsbCBzb21ldGhpbmcgDQp3ZWlyZCBo
YXBwZW5pbmcuIEFsbCBjb250ZXh0IGxpbmVzIHNlZW0gdG8gaGF2ZSBhbiBleHRyYSBzcGFjZSBh
dCANCnRoZSBzdGFydCBvZiB0aGUgbGluZS4gVGhpcyBvZiBjb3Vyc2UgcHJldmVudHMgdGhlIHBh
dGNoZXMgZnJvbSANCmJlaW5nIGFwcGxpZWQuIEkgdHJpZWQgdG8gYXBwbHkgdGhpcyBwYXRjaCB1
c2luZzoNCg0KYjQgc2hhemFtIC1wIGJpdGJha2UtZGV2ZWwgR1YxUFIwN01COTEyMEQ0Nzc4M0Iz
NkU3ODBDMUJGMDEyQTg3MTJAR1YxUFIwN01COTEyMC5ldXJwcmQwNy5wcm9kLm91dGxvb2suY29t
DQoNCi8vUGV0ZXINCg0KPiANCj4gICBiaXRiYWtlX3JlbmFtZWRfdmFycyA9IHsNCj4gICAgICAg
IkJCX0VOVl9XSElURUxJU1QiOiAiQkJfRU5WX1BBU1NUSFJPVUdIIiwNCj4gQEAgLTUzOSwxNCAr
NTQwLDE0IEBAIGNsYXNzIERhdGFTbWFydChNdXRhYmxlTWFwcGluZyk6DQo+ICAgICAgICAgICBy
ZXR1cm4gdmFyIGluIHNlbGYub3ZlcnJpZGVkYXRhDQo+IA0KPiAgICAgICBkZWYgc2V0VmFyKHNl
bGYsIHZhciwgdmFsdWUsICoqbG9naW5mbyk6DQo+IC0NCj4gICAgICAgICAgIGlmIG5vdCB2YXIu
c3RhcnRzd2l0aCgiX19hbm9uXyIpIGFuZCAoIl9hcHBlbmQiIGluIHZhciBvciAiX3ByZXBlbmQi
IGluIHZhciBvciAiX3JlbW92ZSIgaW4gdmFyKToNCj4gLSAgICAgICAgICAgIGluZm8gPSAiJXMi
ICUgdmFyDQo+IC0gICAgICAgICAgICBpZiAiZmlsZSIgaW4gbG9naW5mbzoNCj4gLSAgICAgICAg
ICAgICAgICBpbmZvICs9ICIgZmlsZTogJXMiICUgbG9naW5mb1siZmlsZSJdDQo+IC0gICAgICAg
ICAgICBpZiAibGluZSIgaW4gbG9naW5mbzoNCj4gLSAgICAgICAgICAgICAgICBpbmZvICs9ICIg
bGluZTogJXMiICUgbG9naW5mb1sibGluZSJdDQo+IC0gICAgICAgICAgICBiYi5mYXRhbCgiVmFy
aWFibGUgJXMgY29udGFpbnMgYW4gb3BlcmF0aW9uIHVzaW5nIHRoZSBvbGQgb3ZlcnJpZGUgc3lu
dGF4LiBQbGVhc2UgY29udmVydCB0aGlzIGxheWVyL21ldGFkYXRhIGJlZm9yZSBhdHRlbXB0aW5n
IHRvIHVzZSB3aXRoIGEgbmV3ZXIgYml0YmFrZS4iICUgaW5mbykNCj4gKyAgICAgICAgICAgIGlm
IHJlLnNlYXJjaChfX29sZF9vdmVycmlkZV9kZXRhaWxlZF9yZWdleHBfXywgdmFyKSBpcyBub3Qg
Tm9uZToNCj4gKyAgICAgICAgICAgICAgICBpbmZvID0gIiVzIiAlIHZhcg0KPiArICAgICAgICAg
ICAgICAgIGlmICJmaWxlIiBpbiBsb2dpbmZvOg0KPiArICAgICAgICAgICAgICAgICAgICBpbmZv
ICs9ICIgZmlsZTogJXMiICUgbG9naW5mb1siZmlsZSJdDQo+ICsgICAgICAgICAgICAgICAgaWYg
ImxpbmUiIGluIGxvZ2luZm86DQo+ICsgICAgICAgICAgICAgICAgICAgIGluZm8gKz0gIiBsaW5l
OiAlcyIgJSBsb2dpbmZvWyJsaW5lIl0NCj4gKyAgICAgICAgICAgICAgICBiYi5mYXRhbCgiVmFy
aWFibGUgJXMgY29udGFpbnMgYW4gb3BlcmF0aW9uIHVzaW5nIHRoZSBvbGQgb3ZlcnJpZGUgc3lu
dGF4LiBQbGVhc2UgY29udmVydCB0aGlzIGxheWVyL21ldGFkYXRhIGJlZm9yZSBhdHRlbXB0aW5n
IHRvIHVzZSB3aXRoIGEgbmV3ZXIgYml0YmFrZS4iICUgaW5mbykNCj4gDQo+ICAgICAgICAgICBz
aG9ydHZhciA9IHZhci5zcGxpdCgiOiIsIDEpWzBdDQo+ICAgICAgICAgICBpZiBzaG9ydHZhciBp
biBzZWxmLl92YXJfcmVuYW1lczoNCj4gLS0NCj4gMi4zNC4xDQo=

