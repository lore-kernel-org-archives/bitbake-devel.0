Return-Path: <mark-pk.tsai@mediatek.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BABF433D5
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 01:33:45 +0000 (UTC)
Received: from mailgw02.mediatek.com (mailgw02.mediatek.com [210.61.82.184])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3216.1776303215116169760
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Apr 2026 18:33:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mediatek.com header.s=dk header.b=I8LlRdip;
 dkim=pass header.i=@mediateko365.onmicrosoft.com header.s=selector2-mediateko365-onmicrosoft-com header.b=D7eaLgYU;
 spf=pass (domain: mediatek.com, ip: 210.61.82.184, mailfrom: mark-pk.tsai@mediatek.com)
X-UUID: 3eb6b0fe393411f19a16598d5ca7f8ec-20260416
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uYTr3J6Cc6mtV9Yr34YU7OlJB7/ydQoKsCkkYTchS00=;
	b=I8LlRdipkClJKBBN3zZTb84H8ZbU4DWAuZkjmW5tskMNfikCwuoqB/jFjdEA23KtFvwQfT6I1lgNpwwvAZnJxxXzlXokEZLAIB71CEtNdJHzPYT8z1IVs6BVVVFeGxq/kNANs1InHQRelpWTNE2lyjPqOVtMTbLwbLVg7NTVoOI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e13ffb5a-49ba-46ad-984a-bf1e9ce80a59,IP:0,U
	RL:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:12
X-CID-META: VersionHash:e7bac3a,CLOUDID:8a67798f-6df4-4a3d-a7a4-fbdc42d669ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|11|83|106|80|1,File:130,RT:
	0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
	RR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3eb6b0fe393411f19a16598d5ca7f8ec-20260416
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <mark-pk.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 600766591; Thu, 16 Apr 2026 09:33:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 16 Apr 2026 09:33:17 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 16 Apr 2026 09:33:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDKEiL2QnYl60Pf2AXmgRW2ztk9d2gH3PrxBzANMUiay0EEC5JxrmS2vUGT0/48PSXiSnpz08Xy4vqNVz8raYPWQda+76F136PcXFstJ7Z2qfsXjQXdN2LWFBcUllmO66b/U+qR/ezU/ltxi6xOmuGy9I3WC4QAvaC+RqyvHG8M1VonLJNpDModcaulnQ1I/htdpLaVWRZNFLtedfvVxg4PXbuHTXi4LEhbZZCpIjcrFoPIuDeG8EvGNlNUj8T+7zhFrjLuWkyW3ngBsz1jO0R+yH0sOEvTcZheGR8VsXIGwVDE/ayvHKoEymQzlsSLdOlJn8QtUk4X8yd7CSCvW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYTr3J6Cc6mtV9Yr34YU7OlJB7/ydQoKsCkkYTchS00=;
 b=FDVG/fGO9yacTey2389J7zwqESSIUZoH8HnDDsH9MUsV872B2PouR5VREy90r79eUam33ZPm3Iq0HktnPlJ6OCHhFw6njAAWmKt453pOIksL6KA7NoMrJUD1W5woGuWYal4sLoTxp1kOcB6gYGyPMH54H9VqyxGY1Trrn1SgysBlDwU9qELVUGeomU6FMsnTR6TmAsNyZMZw7XH/n3LFYlDleYjTTvBfBgOqbmM00FkQeL6h0aN6GCF/vmydwTNo+REN9A+1mSjnCVQOPybzMA+gTwVqDFZr14PHQs5GGXWHBb3gtZHEIofPZGIRxbuITvu+3Z1GCXyWvxBCwjjaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYTr3J6Cc6mtV9Yr34YU7OlJB7/ydQoKsCkkYTchS00=;
 b=D7eaLgYU12Xy2DvACKTn2RGFNy1r4FkTvRbc2o0DoTKrZQqknYB+UV6TZyDJ71lEGtjG+RfGRN8d1lSvOWolEJel3OXQYbgB6CXk70V1wCZkV0Kd4c/UVdloUJ6aAl98tAqUOghjAdz8INerElq+KrQ6WEfoh/QONnwg3/5nKRw=
Received: from TYZPR03MB6495.apcprd03.prod.outlook.com (2603:1096:400:1c8::6)
 by SI2PR03MB6565.apcprd03.prod.outlook.com (2603:1096:4:1e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:33:14 +0000
Received: from TYZPR03MB6495.apcprd03.prod.outlook.com
 ([fe80::68d0:6012:e6c:5460]) by TYZPR03MB6495.apcprd03.prod.outlook.com
 ([fe80::68d0:6012:e6c:5460%7]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:33:13 +0000
From: =?utf-8?B?TWFyay1QSyBUc2FpICjolKHmspvliZsp?= <Mark-PK.Tsai@mediatek.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "antonin.godard@bootlin.com"
	<antonin.godard@bootlin.com>
CC: =?utf-8?B?WUogQ2hpYW5nICjmsZ/oi7HmnbAp?= <yj.chiang@mediatek.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: fix HEAD and branch ref when
 subpath is used
Thread-Topic: [bitbake-devel] [PATCH] fetch2/git: fix HEAD and branch ref when
 subpath is used
Thread-Index: AQHczIPH1n8AN6PUaU+t0oXDvPqZ+LXfsY2AgAE3ZQA=
Date: Thu, 16 Apr 2026 01:33:13 +0000
Message-ID: <b1a18b2af50b864e85d46914dbaa59b10522b957.camel@mediatek.com>
References: <20260415025829.2342719-1-mark-pk.tsai@mediatek.com>
	 <DHTJ85579JI9.2SAQHSMRVTXSZ@bootlin.com>
In-Reply-To: <DHTJ85579JI9.2SAQHSMRVTXSZ@bootlin.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6495:EE_|SI2PR03MB6565:EE_
x-ms-office365-filtering-correlation-id: d5b3a099-de83-4c55-54b7-08de9b58207f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: sE+YyV6n0flaNgzdoV2DGrvf4O45rjecvkAGT3WzdeKnsgOw1OiLiNlT/C2wnucXMmhxH5J7+KCYHi1OPfT1CW1z2aaRUkSFdzwxnE4tk5ZF9QVNlXHNsfdiZE4+wjhk7j0DJL+YsddnW6grM2IYJb7wvHQrwyBn0EjnsfhJ/So2ln4CzuPQuKJdZE0mrwNoYEEvfWoz2SxLHs0f8Y5xkMl/58YIcmoWzOh/fb8P/Pkga0HaVFoK6Lt78ANLpQfiwx6jCsAO/qnX+trD/6vnkyzGSLl3mTsDQOjs2PW4gUnzepauBB0PAWqL+MMNiyNyK0o03SdNe7Gvgc3M60kFQZ3bSsQdJ0ZZJ8PIYqTSLECFSkUZY1cBLAcMbuV1CtmNu9bdxKKq4rdgRlkOchL/oN98hRq8MBru0kvJQZ0SUVFLN0BclspYMcLdHsKtqggwQg6Gwns0w/3ZIN3EUzEDwZBENgmriq/ucG5Rr8sS+obBlm36ZFtSZOMjxtqJHzqD5WrfxkSB9+JBjUK9VtHy6H6t4Gvt3y70G9Mv9WTPT3Rtk5viEDsEOGc1F3fcXiSjQ+GeZm+70OGGTmEzo5CVtUi7DU16T3y9aA5ftVB4pC+zfsiU8Cvwo1uuPXJgPrUSusRE1HRJTzZb1EeEC7NdclMc7Bq7f2FnWWBSpl/48WMSHZG0LH2aZ2hhSFt4xXnlFzIL3n95M2QEWy0sABPLWhIxAjTog5tTkp4ZRuUaz6/tWLo/JIVYzQWKraGjOWsv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6495.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWJ5NHJlZEJXcHN1TUxVUnV1QzBlamcwQ3lSWHlLUVZ6aFBlNUpzSzlkbzdG?=
 =?utf-8?B?MHduWXQvcjVlcnVOd0ZJTTl3dDJBbU8xSktNckdoMWNRcG9STllvRk44Uith?=
 =?utf-8?B?YUZoc1VTVytkZWdGMjdnR2xQYW4rM0owZmNFbHRiNklUU1RRTkJDME5rcXpO?=
 =?utf-8?B?ZFk5R0t0REVlMVhrOUJQRUZvUko0UDhWVUd0aHE4NlM2aTdKdm80WlhwNDhU?=
 =?utf-8?B?YVFySGI0cFBmQWIzTWRzajlkbTVTemJDeVllV2Z5RU94TTZWT1V6RTdSRW5R?=
 =?utf-8?B?VGhmTWRUb0t6WUNaR3doSm03cm9TRlNwN0xGMklBQmNpa2c2a0FrVVcvSGo4?=
 =?utf-8?B?aCtHYUlLK0VEc0ljUXRGYWRKdjNlbVNrclh0ZHJ0dlZFYXIxVjMzRnpKcnZL?=
 =?utf-8?B?TEZvbjlxQWFDUDJxcUwvc2dzTE1vcUVvcGl5Ky9teHZEK2MyUVgza1Vidmg3?=
 =?utf-8?B?Q2ZCMkIrS3lhbFBYVm45TEcyL1Fxb3JRWjJ1alFkSi9objkwYTQ0THQ0M0pa?=
 =?utf-8?B?ci9Ma3E0OEVUU1dCSXc3UzQ1bHBhK1BiT3pyK2w0cFBVL2FBTzRyclVrd1lx?=
 =?utf-8?B?NWJVUWs5ejM2Q3cvekhiL0FJRGV1eFRxZnlQOVM4L2FPcW9FVU5vZ0RmdVR4?=
 =?utf-8?B?VXJ2eUZ3b0dFdHJIRDJkVUpEVzVnem1ZVXFHVEpsSkJhT090Y3hmN0lCcW1s?=
 =?utf-8?B?bWhndURWTXlZZFhGemJSbmpTMFl6eGQvU1krWE9XZnpycitQOFBUa1o4bmQ1?=
 =?utf-8?B?WVRTb0NQalVKZDNKKzhyQVdIYm9wNjg1WVBzYWR5VVEybHhucm0yc01oaG9r?=
 =?utf-8?B?TFdyOVdiYXl2U0ErU2tSZHQreURzWnNOVFIrZXpyYUVSUzlLeHpNQ2xOU3Vy?=
 =?utf-8?B?WEhudUdMQmlsY2dBajl4b1FkUDdRTmlBRFdVV0NkY3NEdmdOaHlXZ25vcGE0?=
 =?utf-8?B?OStPc3lobm9MQUFMdTh1cDl3a3h3cEJnZnl3ZDlRcG5CUXhwRldGdi9DUGll?=
 =?utf-8?B?VXRZU3ZKaUNaSHo0RS9pSDZoRVo0RTFXOVBKQm5ka0ZrRWQxZ3gwUHdzVDA2?=
 =?utf-8?B?c0t6dVFNYWFZYVo2ODFlNDJTZlFQdUhUVStBejlIc0t2RzFDcXYwazhXOG1D?=
 =?utf-8?B?ejF6OUFDWi9UdndEQVIxL0hObU9DV3Z3Y1NVNFk1cUp2clQ0SVIxZzBXRFlj?=
 =?utf-8?B?WlB5V2ljRnpYOVFUbEEzRWY0RXpMQXpqdExzWGVKWlAyN2hkSHVrbGVJSU05?=
 =?utf-8?B?K1B2Nm9qdmQ0eStkZS9TVjR2VENVODBrSEwxM2FzUnVlVHRuWlRPdEo4ZGtO?=
 =?utf-8?B?R2FsNThTeFUzZTVUZ0lvY0p3UnJwTjlaMmgwSzFuQ3RHL0dVeFJKaUlFZHhN?=
 =?utf-8?B?YzRHYmdNNjA0c1dPaTVoS2xlTnMwOGY4ZjMySURZZXdhWmV0QVRVOHptMkZH?=
 =?utf-8?B?NmJQNnZTejdOMjlZdkZsRzBmdVZ4WDhVU3AyMEE4YWlQSWRDYlNkcWUyTmc2?=
 =?utf-8?B?SFhHTGZjVVhWUmxYZjdXQ2xGOTNyYVpHaXNlaFdqTnV1Y01CeVlkektOcWxC?=
 =?utf-8?B?ZUZBWjlRUmdrSFlhZ21rSUVzemNMMEFTaWJNK2hsVDkrUmFKTWo3NHZrYk9T?=
 =?utf-8?B?M1NWYXVZWFNxMEFLNlhuU3o2Q1pucHlNbjFrY21HemVMVXRQQlNyMWJWN25P?=
 =?utf-8?B?cnZMMUJ3VTNmSjQ0TU1lSWJoMzBEKzVMRUZmamdkUERvS3lORWd5Sk9MckJp?=
 =?utf-8?B?OVV0bnpHVjg3dmxXdE1EL29xWGZXcGVEVEFKeEFoM0RSVEhhME1MNVpiWVMw?=
 =?utf-8?B?OTdUQWxHSnlKaDhQTmUyRkZUR2wwdlhZZXMvNWUrYWp1YWF1UlZHbTYyY1Nq?=
 =?utf-8?B?Tmpnc09NUGVHZGNia1g1c1JhYUkwWkNGNzE4a0VKV3FzSkJXby9obzVoUHh1?=
 =?utf-8?B?d3JtZ29CUEc1RXdIV1hycmFYUkp5d20vTGZFRFJvNkxrN1FlRS9ZQ0hsNEU4?=
 =?utf-8?B?OGlmRiswVnRWckJSQTJEMlJMKzZRdFYycFBDdTBkcmwyN3BqelgzbFQ5SHpG?=
 =?utf-8?B?K1J4bjZMeGJWYTNDWk5NZXFvNVpCYlZZREg4UUsxcVNxaVAxd3JJOWJ3Qjlr?=
 =?utf-8?B?ZEc0cWhzMjBqYVprRGtVSVlRRVFsVWhWNlhsdXRYalFMZDBiQWIrS3cwT1ZQ?=
 =?utf-8?B?ZHloUDk2NWs3dHJaTFpQVHBBVGQ3bUhtNWluNEV3UndsV1ZDWVJ3N1BXUHZx?=
 =?utf-8?B?ZUZWa3kxb00zV1UxUHRjeHRBb1hsYmpKYnlMSE93SUgyR3gvVnJFL0tDN0lP?=
 =?utf-8?B?RFNxUnJvUTByVy9LRmY5OEtyWFRzRHMzQ0hieGl4eG12ZFVNMU9maU1Oc2tv?=
 =?utf-8?Q?nBOlatmgTdO4Y/Qc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A5D6ECD4761174E9B12ACEF5133126C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T3RqV/TtUzO+d8S9PWxLWO3vHIS3+9jucsqnlSSRrzhwrEJLVmjvxFt45iwXL/lvDuA60CydmZWdDSdSJSsTaF3jQYOKcUX0b3gL+kiNcHkAW3Gv0W2FqgrLriGGugUVgvnBGJlZ3BILN9RG3T+QN3nRTRzVAl5w3yTdkxT77UwmE2F+wj2Npf50aNhArE1HWoaOf1F5eIM6PlPJ9NoDVy06RveZUiA29CZvt9D5e3DKDYzk9n4xj+8W636fWrNEObzq3rGCg2m16Yx1Q3qqVAiIeAbU3VSP96WlRb7w3/RQ5VClzvqaRt3TZ68ymqcAeeyNIhB6xqmSQ47Kknwj5Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6495.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b3a099-de83-4c55-54b7-08de9b58207f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:33:13.6981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ApQyeDcYUyV10hmUREXrMoFXeIrtaTC+oE8gPFKnRSDQT6L9W7txznuUA96AfLwscRvDr7PjENRKUtSaPKp9WiaF90PiWbyoZ5i+5/CBRBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6565
X-MTK: N
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Apr 2026 01:33:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19366

T24gV2VkLCAyMDI2LTA0LTE1IGF0IDA4OjU4ICswMjAwLCBBbnRvbmluIEdvZGFyZCB3cm90ZToN
Cj4gSGksDQo+IA0KPiBPbiBXZWQgQXByIDE1LCAyMDI2IGF0IDQ6NTggQU0gQ0VTVCwgTWFyay1Q
SyBUc2FpIHZpYQ0KPiBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIHdyb3RlOg0KPiA+IEZyb206IE1h
cmstUGsgVHNhaSA8bWFyay1way50c2FpQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBXaGVuIHN1
YnBhdGggaXMgc2V0IHRoZSBjaGVja291dCBjb2RlIHVzZXMgcmVhZC10cmVlICsgY2hlY2tvdXQt
DQo+ID4gaW5kZXgsDQo+ID4gYnV0IG5ldmVyIHVwZGF0ZXMgSEVBRC4gSXQgc3RheXMgb24gd2hh
dGV2ZXIgYnJhbmNoIHRoZSBjbG9uZQ0KPiA+IGRlZmF1bHRlZA0KPiA+IHRvIGluc3RlYWQgb2Yg
cG9pbnRpbmcgdG8gdGhlIHJlcXVlc3RlZCByZXZpc2lvbi4NCj4gPiANCj4gPiBGaXggYnkgcG9p
bnRpbmcgSEVBRCBhdCB0aGUgY29ycmVjdCByZXZpc2lvbiBhZnRlciBjaGVja291dC1pbmRleCwN
Cj4gPiBhbmQNCj4gPiBjcmVhdGluZyB0aGUgYnJhbmNoIHJlZiB3aGVuIGJyYW5jaD0gaXMgc3Bl
Y2lmaWVkLg0KPiANCj4gQ2FuIHlvdSByZW1vdmUgdGhpcyB3YXJuaW5nIG5vdGUgd2l0aCB5b3Vy
IHBhdGNoPw0KPiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0Lm9w
ZW5lbWJlZGRlZC5vcmcvYml0YmFrZS90cmVlL2RvYy9iaXRiYWtlLXVzZXItbWFudWFsL2JpdGJh
a2UtdXNlci1tYW51YWwtZmV0Y2hpbmcucnN0Km40MjhfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IWds
SmJSU2tFZDhQX2hkYkVXd0pFTURzWVhHSmhlejFpQktRWmhucXg4c3dGTkY5OE5uaGx1WDhLa1Ra
VnQzdVZ5WkpjSkR0bkRQanFMcUwwM3MwaHhMR0lDYWxmVHdRJA0KPiDCoA0KPiANClRoYW5rIHlv
dSBmb3IgcG9pbnRpbmcgdGhhdCBvdXQuIEkgaGF2ZSByZW1vdmVkIHRoZSB3YXJuaW5nIG5vdGUg
aW4gdjIuDQpDb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBsb29rPw0KDQoNCj4gVGhhbmtzLA0KPiBB
bnRvbmluDQoNCg==

