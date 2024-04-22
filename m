Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B36CC4345F
	for <webhook@archiver.kernel.org>; Mon, 22 Apr 2024 12:41:02 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.87])
 by mx.groups.io with SMTP id smtpd.web11.17372.1713789653159521250
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Apr 2024 05:40:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=QxHhytqu;
 spf=pass (domain: axis.com, ip: 40.107.8.87, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h05RW+TuUpOw3mezSFfO50u3MUU/kH2f3Mf+jmcjRL/1Z/rzmCEbZxwmwQ3g5W73wf8kdXkHPvxtZVQmkFOw2Jdb/E3rDDDAeybCu8coBoeD8tBb2fcas9VTdk5W3ginO4cx/gMVH3q075ydJ420K2AnU0OgjVz8eM8xOrg99eRr6lyDfIkuFVggobtm6S8UOhVaUS3VXv2iy06VMIU/HT8Peq4eTNBVULVHOf3IdPuXw9vg+uCtcnUTJrhNq6G4B/GbZufIEO705CJsw7Us8agIPqScTiuRM/aQp5IEMT9JblpKbh6I8Xpbm/lvId3U1cLPO207/xr1HBEn5Xpdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1uTgnu18foyFKvarRDJIw36rQG6vf1lm92I4EUKU9A=;
 b=hF7D3j+vQbAvd/jZaoLxdV0LUFZDLEC2cfatGfKdlnZfxcl6SDK01R8/mu9o9+LCrv/7CdmW4N3JpbGmnwf+BCF9X2ZDhx6v9MPwjc+ssnv3aWh8MFxb6vrvc1G9gcNWm0Kn1UDmTOJZ3GofbhCwdnDeOLI7zko37Xjdz5OfScHZ12MUD8LY11G2X24A5KsLY/IzRdIckZUNu2uRw19u7W/4tQMhltExALYyfEipj5LV+qFLZK8R6ihjbZCPWbdhnWGjV0+FdNFssb8u9laWWntooypCx63RV84FIBhW4QlhQbmv6DBSMjrJ9A6YqDsO7KxeijUwzhCqxndRG38Ibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1uTgnu18foyFKvarRDJIw36rQG6vf1lm92I4EUKU9A=;
 b=QxHhytquBCEJjM0Onc1K41U3V0hmmExP5ultnb12y6Z9lyXZ4dzOx9aBz2kJQ5AC2HW4GobEjeL+ak9UwSULjUDD4krHxnKJFo5I2mY4HYpEUgfhDAG3OjWScuxgEBbU3lz7MnBbv/eOvwGyVlOdHFo7E3qkS8tiHGyk7SLTE1E=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by PAVPR02MB9062.eurprd02.prod.outlook.com (2603:10a6:102:2fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 12:40:48 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::fa03:deff:aae:c4d0]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::fa03:deff:aae:c4d0%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 12:40:48 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: =?utf-8?B?U2ltb25lIFdlacOf?= <simone.p.weiss@posteo.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH v4] bitbake-layers: adapt force option to
 not use tinfoil
Thread-Topic: [bitbake-devel] [PATCH v4] bitbake-layers: adapt force option to
 not use tinfoil
Thread-Index: AQHakpWmrDy9/Mncgk66xeVXFXMBhbF0Pngg
Date: Mon, 22 Apr 2024 12:40:48 +0000
Message-ID: 
 <DB5PR02MB10213B63FF2F852F27E5840E5EF122@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20240419200854.10611-1-simone.p.weiss@posteo.com>
In-Reply-To: <20240419200854.10611-1-simone.p.weiss@posteo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|PAVPR02MB9062:EE_
x-ms-office365-filtering-correlation-id: 4a50c2e4-0b93-401a-f14f-08dc62c96ff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Vkd5OUJBUStsaytPWWc0QndBcGQ5aVJVb0xYQm8rZFR6N2RVVWVNM3RVTHRk?=
 =?utf-8?B?VWVudlRTVUFUdkorcjhBNkxZKzhaSmpnaDFGUGpDS0RLZHFrKzg1SkFNeWVr?=
 =?utf-8?B?RUFaRktoV2J1UUI2SkdCcTVlcktpYjlrWGVZUlNYNy9lWW9IaWR6U2dSS1lp?=
 =?utf-8?B?UEJlejBPVlVDOVFxQU44SGZ6YUhtUERsTHZTQzIrZlZQMTBzZzdYcm1zckhx?=
 =?utf-8?B?WE1zc1dUSVhUTnNoTkt4MVZLb0Y2RHZ6RDBndEFmTFR1Nm1abjFrQUlURi9T?=
 =?utf-8?B?L0xQa2FKcVVXRm94NWNBREJ6QUk0dU1UUy9tWFlOSHZRVC83cW9JZFN4VkFn?=
 =?utf-8?B?TFp2RjRZTkpIRXdZeWdmcjU2VjQzaTltMVNKd05vNE5hZUFjbkRlODNoZ044?=
 =?utf-8?B?ekorRmptbkNNZWV3cTNRNkVzVFdFZThpU1hxWmtFN091RENYSWZyalUwQjBX?=
 =?utf-8?B?eFowbkhvWm5hUzJWeTNpa2lzaytzVnZ1R0RYSk5iWXhNLy9kck5WTjFUMm1N?=
 =?utf-8?B?bjNuRkYyWk5vTHZkM2lPZWlZdVNNUUhhelNERXdLRTJoSDgxSUg1UWpaVEhh?=
 =?utf-8?B?SjJxWUV6VjBDZXJrdlpRTmtxcGFlU1NpUVQ4TVUyOUZNeUZTQnpkK2hHN0xh?=
 =?utf-8?B?ckNLRE82TEI1L3RPeTR1YzYzMk1XQjVjOGdTem9FdWVLWjBzdlNyNlRqeGU1?=
 =?utf-8?B?Tmp5S3ZDN3J4dzJoUzhCYWppOEkvdlZyaEFTdVpKdTlPVW03T0t6RFVNNVhF?=
 =?utf-8?B?ek9yRkNpOCtTMFBlMXlqR3ZDU3B4ZXdlYmRENUtTMkNXMFRIUWh1OTN0R1ZL?=
 =?utf-8?B?TVErMXRHajN6QTczTnd0dUtnNi9ObHd0QzFYejdyOTZWSDB0QmR0U05sQ3Z5?=
 =?utf-8?B?Y0Z0RHVOcWRwZEZNNEtMVm5EM3FSamtoUk00M2pIaEFsRnYvd01SQ0VyVnha?=
 =?utf-8?B?SHFUaUo1S3JhdDJKWjZLeEp5V3QwNkZ6SVcrN3Q1YTdJamhibXRhdDVpVWNS?=
 =?utf-8?B?UHBiY3FNa3hnQ3lwQ1NNQ29jVHdhNVdXOFA0aWsvdkZkcXZ0ZTBmWUpHT3Zr?=
 =?utf-8?B?Kyt3NzJ6SGczNzhzQTIxdUliTFFhS2kyWi9Jb0MzbVZza2FUUFpBV0FGMyt4?=
 =?utf-8?B?ZDIyb0kydmJTUS9sTk9MZEQ2RUhtbHVQN2hJbWo0eC9hZnFFUGh3ODFsSWRP?=
 =?utf-8?B?WXR2dWhTYmEzeWNvQXJhSDVBQkg0ZnkrNzZxc3A1L1pKOFJXS3dJMGtCQUMw?=
 =?utf-8?B?a0h5cXo2T1FpaUQ4SWN2U2MraC9IWGhJalRlUlNpYlIwWkFFZitGTGJ3VWFU?=
 =?utf-8?B?Q1pRaFcwcUFqam1rdXlGUjMwaVlZUXJhWlNob3h0ZTJqVFBmdVVkR1VUNGNo?=
 =?utf-8?B?VXdIbjhTZCtNZG1BVG11akcxMzM0TzA4RzFpWmwweGtySldmVUk5cE40WUlN?=
 =?utf-8?B?Nm9OMStIQ1pzU05MakU0aFBpSDFmQ3AyRHJPbmhRSWxVMW95SE03L2ZMbHZB?=
 =?utf-8?B?T01sVmdSa3V0RVBNSlFJOUhneEFpbHplSTFneDZGc2dPZnhZcnp4ajlWalFz?=
 =?utf-8?B?T0xMZHdFYnY0TCs3bDhhRnYxeHBuOFhOOFhLMTBzQUw3NUJTU2R0TTQwKzJG?=
 =?utf-8?B?cjh0Yk1HdWlIenpXM0wzNE9BRHkwQ2E4VW5tL0dUa3BvcU9QZGRrQVhzdGNN?=
 =?utf-8?B?enpudHI2djZpTTFGb0hhMWVqUWZSU21DZHM2QisxRkVYNHBSTE13S0hWbHE3?=
 =?utf-8?B?QkFGOHJMZGNpMzkrTm9sR0d6S0k4cGJmMjVWbVhzVTBEYXRVNzV4K2o0U01V?=
 =?utf-8?B?aWhDd0hlLzlLQURpZWVnQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UkgzcHp3aDcreUxabDBhTWx5ZTJOUjJ5WHNTME9LNXpWdlBHdjlyWmF6L2pq?=
 =?utf-8?B?bnhXd1FDT3U0QkZFdTVWN01pVGpHQTMwUEpmbDcrUTJaQjFFQW5vVTViNEFB?=
 =?utf-8?B?Z3luMzBLcUJvNmxGeGNoUWY1NVdLTEwwVVluZzR2WTU4WURqV0pGZVVDTjR6?=
 =?utf-8?B?RlZZb1RwdGlIRXlsSWs0REpmaWEwSEJzQk5ZM3ZraGRUN2dPUGdXSllmVms1?=
 =?utf-8?B?My8xeTZBYjk1RWZta1NlRFlpd3kzMTlIKzlzOGltVEwvdWllMVdNaFRkK09a?=
 =?utf-8?B?UTREZVRGKzQ2VkdzRVFNM1ZqMzBaLzlJRHdNNlJFTFg3YmJheWRtN25jakdC?=
 =?utf-8?B?YWhqWjVaOS9WeDN5MGdpRHFPdGRqeWZMMzR4U3lWVnRjbVIydmgvVmovR1F6?=
 =?utf-8?B?di9rbWtveElGTjIxdm9xWWNMWUFxZEhjZ25Gd2R4eXdoemZhcWpGU2lKRHV5?=
 =?utf-8?B?S2MyclkxNEthR3Q5cmRTSUtuSWdnRy9XWHN3dzBibHBDQUVJUzFLZjUrcThS?=
 =?utf-8?B?VkIvbkhYTTZRK0NFdkUydlV5c2dRZUx3YkhmMjNPb2FVQk1tcE54V2g0MTZH?=
 =?utf-8?B?YklvOXRIVFVDY2RBQjI0dTJqTnh4NWV2Z2Jub3BwY1pla3k5L3pFblcyUi84?=
 =?utf-8?B?WjJ3K293YTVBSWphbTlsUTRYaklPak9ETGFHUUZwL015NU9HL1NZNnFHRU0v?=
 =?utf-8?B?WlVRcTZ2SE96K1JDemFDcW5HaXVlcmI5TXI4UVQ5QjZ5bFdmb2xIY09OelRx?=
 =?utf-8?B?OCtuMnNqaXpJRDhTQUoxVGdvYldhbWdjNjAydEJwWTlhTU53aGhFeFcwU1Fr?=
 =?utf-8?B?UjlPLzR6SlQ2UGp2TE9YZFdXaEhJZHh4L1FHV2hrdEhjYUV1Mm5PUXl0MU0y?=
 =?utf-8?B?R1J2L2pnUFptQkVuL1psRVYxTWJNWG0zY0lMR1JvelBxeXlTcXhGeGlyUUZy?=
 =?utf-8?B?TlpXcHZERzZETEJRVWV2Y3pGaDY2Mlo4c0NPeWlrWitmNENKdVVFdjV2eTZh?=
 =?utf-8?B?YllhRDdyYmVrd0YrczVnWVV3L3NpMWcwNVI5V29Rd0Irc1pjVUlGTk5qZEE0?=
 =?utf-8?B?Y1VwaGY4ZmV2dHRKbDM2aENlTjFxRFE5Uy9ucDFlQzZDTEdJbXI1aWhCeVhH?=
 =?utf-8?B?NTBqYUN3Unk4cytqQVRZT1V3NitVZGk2V2o1Yjl6cE5ndmhzQVdiZDZMamNl?=
 =?utf-8?B?aEVRaExYNSszaHY1NEVFOGF3QjZSeFRRanE2eU5IVVhlUXFESlY5T25EM0tN?=
 =?utf-8?B?MndRZklnODRuZFc3VDNBVnpaVWl4VEhmS3I1RUZ3bkNVbU1IMllzL3M0aDl3?=
 =?utf-8?B?ZzJ3Tk0rZmJjaXNnbjVxTUJUdXNWU1NLd0c2ZkRzNUlwTDMxWDArRFc5YnVt?=
 =?utf-8?B?M1ZQV2RnYWFmRENtSVMxbjVGWE1sb3RkdXpyM2NIV3Q2TzlsMUIyUEduZGlF?=
 =?utf-8?B?TXJrem94cURhYm11eW16b2h5OFk1MVZ5QTRQY2FuM1JwMWw2b0RVa0NKalpV?=
 =?utf-8?B?TkwvMmNpZnJtNHNGbmJvVUJ4SWsrU0prYS9oTXk3YzdHVis1djdGZWdSdWxM?=
 =?utf-8?B?dVJzRWxNYWpKNlpLZ1ZWSXZYQ0dQT3hvR1EzdjhTa3RhaFhKbCtUTFg3WFN3?=
 =?utf-8?B?NGwrbEZJaFpmMDM4ekdpY2Z2M1RUZjI5NDQ5bVNvbWM3R0hlOFJWQzdTNVJi?=
 =?utf-8?B?L0RkbUY4aVlUSnNWQkpWa3h0WHNlL2V6Vld5MUVUQlpmdGRnNDBRVzA5ZEhN?=
 =?utf-8?B?MmlIMk9IOUdVSENTV2FNUkoyM2djL3UwUmJxZVU0ZUNXVVlrTm9QcFR1dnJT?=
 =?utf-8?B?dEZCKzk5QnNNMCtNalBVNUdJVk9ocnBKQlA3dWhkVzlDWWFWWTM5TUJvbExj?=
 =?utf-8?B?RWpJaXFIejhSaDlZVXJhVzBSNGRFNGZ5LzBPUG1maEI5WkhrcjNUR1dtdE91?=
 =?utf-8?B?bTBhTytoQnBmM2t6NE5xWU9kTEF5cy9lNVJwNGtGZmQ3TkJVQzhwa3l1eVVo?=
 =?utf-8?B?T0xHSTNsRDNLNzVEbENSdnQ3ZUdCWGNENEFxU0g3SGFQNCt1SW9lcURrT0dE?=
 =?utf-8?Q?IB6A3d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a50c2e4-0b93-401a-f14f-08dc62c96ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 12:40:48.6235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1AXB1zim0aeY3eI8WcxshfL24tMYWvVumyXZbJYw558AzrkbhrGB8BK8DQShmvny
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9062
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Apr 2024 12:41:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16120

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIFNpbW9uZSBXZWnDnw0KPiBTZW50OiBkZW4gMTkgYXByaWwgMjAyNCAyMjow
OQ0KPiBUbzogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IENjOiBTaW1v
bmUgV2Vpw58gPHNpbW9uZS5wLndlaXNzQHBvc3Rlby5jb20+DQo+IFN1YmplY3Q6IFtiaXRiYWtl
LWRldmVsXSBbUEFUQ0ggdjRdIGJpdGJha2UtbGF5ZXJzOiBhZGFwdCBmb3JjZSBvcHRpb24gdG8g
bm90IHVzZSB0aW5mb2lsDQo+IA0KPiBGcm9tOiBTaW1vbmUgV2Vpw58gPHNpbW9uZS5wLndlaXNz
QHBvc3Rlby5jb20+DQo+IA0KPiBGaXhlcyBbWU9DVE8gIzE1NDE3XQ0KPiANCj4gV2hlbiBhIGxh
eWVyIGFkZHMgYSBuZXcgZGVwZW5kZW5jeSBhZnRlciBpdCB3YXMgYWRkZWQgdG8gYSBjb25mLCBp
dCBjYW4gbm90IGJlDQo+IHJlbW92ZWQgdy9vIHRoaXMgZGVwZW5kZW5jeSBpbiB0aGUgc2V0dXAu
IEV2ZW4gdGhlIGRlcGVuZGVudCBsYXllciBjYW4gbm90IGJlDQo+IGFkZGVkLCBhcyB0aGUgdGlu
Zm9pbCBzZXR1cCB3aWxsIGZhaWwuDQo+IEFkYXB0IC0tZm9yY2UgdG8gbm90IHBlcmZvcm0gdGhl
IHRpbmZvaWwgYXQgYWxsLCB0aGUgdXNlIHdpbGwgYmUgYXQgb3duIHJpc2ssDQo+IGkuZS4gdGhl
IGFkZGVkIGxheWVycyBtaWdodCBub3QgcGFyc2UgcHJvcGVybHkgYWZ0ZXJ3YXJkcy4NCj4gVGhp
cyBpcyBub3QgbWVyZ2VkIGludG8gdGhlIGZvcmNlIG9wdGlvbiB3aXRoIC1GIGFzIGl0IGV2ZW4g
Y2hhbmdlcyB0aGUgbG9hZGluZyBvZg0KPiBwbHVnaW5zIGZyb20gb3RoZXIgbGF5ZXJzIGFuZCBp
cyBoZW5jZSBldmVuIG1vcmUgaW52YXNpdmUgYXMgZm9yY2UuIEluc3RlYWQNCj4gZm9yY2UgY2Fu
IG5vdyBiZSBzcGVjaWVmaWVkIG11bHRpcGxlIHRpbWVzIGFuZCBpcyBjb3VudGVkLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogU2ltb25lIFdlacOfIDxzaW1vbmUucC53ZWlzc0Bwb3N0ZW8uY29tPg0K
PiAtLS0NCj4gdjQ6IERvIG5vdCBhZGQgYSBuZXcgb3B0aW9uIHRvIHNraXAgdGhlIHRpbmZvaWwg
c2V0dXAgYW5kIGFsbG93IG11dGlwbGUgZm9yY2UNCj4gbGV2ZWxzIGluc3RlYWQuDQo+IA0KPiAg
YmluL2JpdGJha2UtbGF5ZXJzICAgICB8IDE0ICsrKysrKysrKy0tLS0tDQo+ICBsaWIvYmJsYXll
cnMvYWN0aW9uLnB5IHwgIDQgKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jpbi9iaXRiYWtlLWxheWVy
cyBiL2Jpbi9iaXRiYWtlLWxheWVycw0KPiBpbmRleCBkNGIxZDFhYS4uYWViYjUxMDAgMTAwNzU1
DQo+IC0tLSBhL2Jpbi9iaXRiYWtlLWxheWVycw0KPiArKysgYi9iaW4vYml0YmFrZS1sYXllcnMN
Cj4gQEAgLTMzLDcgKzMzLDcgQEAgZGVmIG1haW4oKToNCj4gICAgICAgICAgYWRkX2hlbHA9RmFs
c2UpDQo+ICAgICAgcGFyc2VyLmFkZF9hcmd1bWVudCgnLWQnLCAnLS1kZWJ1ZycsIGhlbHA9J0Vu
YWJsZSBkZWJ1ZyBvdXRwdXQnLCBhY3Rpb249J3N0b3JlX3RydWUnKQ0KPiAgICAgIHBhcnNlci5h
ZGRfYXJndW1lbnQoJy1xJywgJy0tcXVpZXQnLCBoZWxwPSdQcmludCBvbmx5IGVycm9ycycsIGFj
dGlvbj0nc3RvcmVfdHJ1ZScpDQo+IC0gICAgcGFyc2VyLmFkZF9hcmd1bWVudCgnLUYnLCAnLS1m
b3JjZScsIGhlbHA9J0ZvcmNlIGFkZCB3aXRob3V0IHJlY2lwZSBwYXJzZSB2ZXJpZmljYXRpb24n
LCBhY3Rpb249J3N0b3JlX3RydWUnKQ0KPiArICAgIHBhcnNlci5hZGRfYXJndW1lbnQoJy1GJywg
Jy0tZm9yY2UnLCBoZWxwPSdGb3JjZWQgZXhlY3V0aW9uOiBjYW4gYmUgc3BlY2lmaWVkIG11bHRp
cGxlIHRpbWVzLiAtRiB3aWxsIGZvcmNlIGFkZCB3aXRob3V0IHJlY2lwZSBwYXJzZSB2ZXJpZmlj
YXRpb24gYW5kIC1GRiB3aWxsIGFkZGl0aW9uYWxseSBmb3JjZSB0aGUgcnVuIHdpdGhwdXQgbGF5
ZXIgcGFyc2luZy4nLCBhY3Rpb249J2NvdW50JywgZGVmYXVsdD0wKQ0KDQpUeXBvOiB3aXRocHV0
IC0+IHdpdGhvdXQNCg0KPiAgICAgIHBhcnNlci5hZGRfYXJndW1lbnQoJy0tY29sb3InLCBjaG9p
Y2VzPVsnYXV0bycsICdhbHdheXMnLCAnbmV2ZXInXSwgZGVmYXVsdD0nYXV0bycsIGhlbHA9J0Nv
bG9yaXplIG91dHB1dCAod2hlcmUgJShtZXRhdmFyKXMgaXMgJShjaG9pY2VzKXMpJywgbWV0YXZh
cj0nQ09MT1InKQ0KPiANCj4gICAgICBnbG9iYWxfYXJncywgdW5wYXJzZWRfYXJncyA9IHBhcnNl
ci5wYXJzZV9rbm93bl9hcmdzKCkNCj4gQEAgLTU5LDE2ICs1OSwyMCBAQCBkZWYgbWFpbigpOg0K
PiAgICAgIHBsdWdpbnMgPSBbXQ0KPiAgICAgIHRpbmZvaWwgPSBiYi50aW5mb2lsLlRpbmZvaWwo
dHJhY2tpbmc9VHJ1ZSkNCj4gICAgICB0aW5mb2lsLmxvZ2dlci5zZXRMZXZlbChsb2dnZXIuZ2V0
RWZmZWN0aXZlTGV2ZWwoKSkNCj4gLSAgICB0cnk6DQo+ICsgICAgaWYgZ2xvYmFsX2FyZ3MuZm9y
Y2UgPiAxOg0KPiArICAgICAgICBiYnBhdGhzID0gW10NCj4gKyAgICBlbHNlOg0KPiAgICAgICAg
ICB0aW5mb2lsLnByZXBhcmUoVHJ1ZSkNCj4gLSAgICAgICAgZm9yIHBhdGggaW4gKFt0b3BkaXJd
ICsNCj4gLSAgICAgICAgICAgICAgICAgICAgdGluZm9pbC5jb25maWdfZGF0YS5nZXRWYXIoJ0JC
UEFUSCcpLnNwbGl0KCc6JykpOg0KPiArICAgICAgICBiYnBhdGhzID0gdGluZm9pbC5jb25maWdf
ZGF0YS5nZXRWYXIoJ0JCUEFUSCcpLnNwbGl0KCc6JykNCj4gKw0KPiArICAgIHRyeToNCj4gKyAg
ICAgICAgZm9yIHBhdGggaW4gKFt0b3BkaXJdICsgYmJwYXRocyk6DQo+ICAgICAgICAgICAgICBw
bHVnaW5wYXRoID0gb3MucGF0aC5qb2luKHBhdGgsICdsaWInLCAnYmJsYXllcnMnKQ0KPiAgICAg
ICAgICAgICAgYmIudXRpbHMubG9hZF9wbHVnaW5zKGxvZ2dlciwgcGx1Z2lucywgcGx1Z2lucGF0
aCkNCj4gDQo+ICAgICAgICAgIHJlZ2lzdGVyZWQgPSBGYWxzZQ0KPiAgICAgICAgICBmb3IgcGx1
Z2luIGluIHBsdWdpbnM6DQo+IC0gICAgICAgICAgICBpZiBoYXNhdHRyKHBsdWdpbiwgJ3RpbmZv
aWxfaW5pdCcpOg0KPiArICAgICAgICAgICAgaWYgaGFzYXR0cihwbHVnaW4sICd0aW5mb2lsX2lu
aXQnKSBhbmQgZ2xvYmFsX2FyZ3MuZm9yY2UgPD0gMToNCj4gICAgICAgICAgICAgICAgICBwbHVn
aW4udGluZm9pbF9pbml0KHRpbmZvaWwpDQo+ICAgICAgICAgICAgICBpZiBoYXNhdHRyKHBsdWdp
biwgJ3JlZ2lzdGVyX2NvbW1hbmRzJyk6DQo+ICAgICAgICAgICAgICAgICAgcmVnaXN0ZXJlZCA9
IFRydWUNCj4gZGlmZiAtLWdpdCBhL2xpYi9iYmxheWVycy9hY3Rpb24ucHkgYi9saWIvYmJsYXll
cnMvYWN0aW9uLnB5DQo+IGluZGV4IGE4ZjI2OTkzLi5hMTRmMTk5NCAxMDA2NDQNCj4gLS0tIGEv
bGliL2JibGF5ZXJzL2FjdGlvbi5weQ0KPiArKysgYi9saWIvYmJsYXllcnMvYWN0aW9uLnB5DQo+
IEBAIC01MCw4ICs1MCw4IEBAIGNsYXNzIEFjdGlvblBsdWdpbihMYXllclBsdWdpbik6DQo+IA0K
PiAgICAgICAgICB0cnk6DQo+ICAgICAgICAgICAgICBub3RhZGRlZCwgXyA9IGJiLnV0aWxzLmVk
aXRfYmJsYXllcnNfY29uZihiYmxheWVyc19jb25mLCBsYXllcmRpcnMsIE5vbmUpDQo+IC0gICAg
ICAgICAgICBzZWxmLnRpbmZvaWwubW9kaWZpZWRfZmlsZXMoKQ0KPiAgICAgICAgICAgICAgaWYg
bm90IChhcmdzLmZvcmNlIG9yIG5vdGFkZGVkKToNCj4gKyAgICAgICAgICAgICAgICBzZWxmLnRp
bmZvaWwubW9kaWZpZWRfZmlsZXMoKQ0KPiAgICAgICAgICAgICAgICAgIHRyeToNCj4gICAgICAg
ICAgICAgICAgICAgICAgc2VsZi50aW5mb2lsLnJ1bl9jb21tYW5kKCdwYXJzZUNvbmZpZ3VyYXRp
b24nKQ0KPiAgICAgICAgICAgICAgICAgIGV4Y2VwdCAoYmIudGluZm9pbC5UaW5mb2lsVUlFeGNl
cHRpb24sIGJiLkJCSGFuZGxlZEV4Y2VwdGlvbik6DQo+IEBAIC04Myw2ICs4Myw4IEBAIGNsYXNz
IEFjdGlvblBsdWdpbihMYXllclBsdWdpbik6DQo+ICAgICAgICAgICAgICAgICAgbGF5ZXJkaXIg
PSBvcy5wYXRoLmFic3BhdGgoaXRlbSkNCj4gICAgICAgICAgICAgIGxheWVyZGlycy5hcHBlbmQo
bGF5ZXJkaXIpDQo+ICAgICAgICAgIChfLCBub3RyZW1vdmVkKSA9IGJiLnV0aWxzLmVkaXRfYmJs
YXllcnNfY29uZihiYmxheWVyc19jb25mLCBOb25lLCBsYXllcmRpcnMpDQo+ICsgICAgICAgIGlm
IGFyZ3MuZm9yY2UgPiAxOg0KPiArICAgICAgICAgICAgcmV0dXJuIDANCj4gICAgICAgICAgc2Vs
Zi50aW5mb2lsLm1vZGlmaWVkX2ZpbGVzKCkNCj4gICAgICAgICAgaWYgbm90cmVtb3ZlZDoNCj4g
ICAgICAgICAgICAgIGZvciBpdGVtIGluIG5vdHJlbW92ZWQ6DQo+IC0tDQo+IDIuMzkuMg0KDQov
L1BldGVyDQoNCg==

