Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88E0C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 13:11:36 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.55])
 by mx.groups.io with SMTP id smtpd.web10.88236.1740402689585067048
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Feb 2025 05:11:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ob3JyTq6;
 spf=pass (domain: siemens.com, ip: 40.107.22.55, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJtBSFkVaykRVxUIXo6wZsentxN3NZR9IspptP33zaKjQwgzqTRsDx0J1HJZkRbOdwLmsogtRlz4mEAPFmKiJgk5/zOjyr93F8i63ECCdf5movIbpxB/nWidi1MXy9rjv6h5wLzQpLvUfYPa7Lt8SD0dTUKwZbDjKBdeYtHPW4uISyBJ+MHeopqNyShJ/BydAfoXfMYvLxWjiZ9fVcyZ91T0xr+g5tj/zkpbbJx/f9fV0PggRJVe5WfOWdNybLi3J6vBDW5vLIYBj2LJbv26A7jlpwJktKvqW542h3OprS9nsmV6xanZ72LlkSidRcj388IACK8jBobffByY2d3m3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yftaT/wDL/Te1PoiH3L6PMcWriSaT+cRM9DiWCUJfWo=;
 b=iSGvsM/gmsSFu311/2iNdCsoOC+NwjWPO/L6JxUA3sXivOj23WL3FnKE9UFTOdSxLxKWXjUmASJJDFUNiZ3D8WEznZHjQBQai6lS5PwoCUxmpwEoW5G8LmkuJ07hIkmBjUYEfCYidsVkAi6LfEdzbCyumuqae4b7oUZAZVeFp+HmqHwDiurFovYus3VGGpJDlfr6vHwuYy8Twdu+/S9GiMj1QoBTvsuwYl+teFavM0YimVPbaLSgjEiONCBb9faq3snTBtfDveQQtm4yoz7CvlwaD8+cLdBIQ2tEWsqbTffmpR6XoPkTytdaf0CBMzfBz/JHPPoBhcQHColLw7pXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yftaT/wDL/Te1PoiH3L6PMcWriSaT+cRM9DiWCUJfWo=;
 b=ob3JyTq6GTV7+Pk94X5uIQp3BRvbVfVShTnFb5cAqmvr9+2//+nU3C/Nzc46MRmHPf/8G7vjAxtSUjWopcNlDq/Ht6pkUS8X/MxYokvzWAnZwLOYyXEruFmdd3IgLuoJsEOWUT9UYqPaM1iZW6shBLDx1B6UXHmJFLi4f53dKJL50tWyHPEdWTSiLmuUWfNG7NtreEJjYkeK18B8WWaMDmCI3qwFMGKNrh76XqsRBc3Vlr1rINa2qlcJaFKrHHpYlpMA+Huk8Ymr8Ng9x6kuMSmCaFrEzqVuQEYvNmgqEQpGxANZZlp7ZQLhKbYqciEtxyh0orTJgolx/da0j74DPQ==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by GV2PR10MB6525.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 13:11:25 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 13:11:25 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "mathieu.dubois-briand@bootlin.com"
	<mathieu.dubois-briand@bootlin.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>, "alex.kanavin@gmail.com"
	<alex.kanavin@gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Thread-Topic: [bitbake-devel] [PATCH v3 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Thread-Index: AQHbg7ywZJqt9JvQhESFPikUXBi+bLNWX0eAgAAQGoCAAARbAA==
Date: Mon, 24 Feb 2025 13:11:25 +0000
Message-ID: <4961407c133c3579acf66ca5deefa6f680c4f391.camel@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
	 <D80NPDG5BAOJ.21VFGTXZZIRP5@bootlin.com>
	 <e041fd346c069847c11899777503721d0dfaf952.camel@siemens.com>
In-Reply-To: <e041fd346c069847c11899777503721d0dfaf952.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|GV2PR10MB6525:EE_
x-ms-office365-filtering-correlation-id: 60eb7db7-6e0b-4513-9309-08dd54d4be3b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?a21xcUFDWXY2TnZ1M2k3RFVpdklwcXUxRnZ4RnE4K3BSRFlUTThXcTNWZmNi?=
 =?utf-8?B?a1l5MFFKbm40cVA4RGpPOTF2b1pzM0E2ak9rbWRGbjludmhZc3lzVDN4YU9n?=
 =?utf-8?B?SFYxWTZyZnNDTEUxSENzWW5zQlErQ2hyTVNYWWVQVWhoYldwYWpSZEt5VEJw?=
 =?utf-8?B?T1ZPcmxLRzQ3S3NaZ1pTcXRNdnBkVUNXYXRsQzdyMlEzTE5CakNtQW5KVUNP?=
 =?utf-8?B?ak9xbkVqK1VHSGlLVnFNOTdBT2QrVmNnM21jN0ZoTzVqUno4MVRoOUNnRDF2?=
 =?utf-8?B?NkxGbDZaaWY2TTN1UVRJYlhsQ0Y5cGRBTmVHU1U3MXNLaUtUNVRmKzFJd1ZF?=
 =?utf-8?B?WFF6d2FFWGUwQWFIaUFwSFc0VGEyMm1DNWNCeGxGNVVoQ2pieElRaTRHdjRW?=
 =?utf-8?B?dWNMU3ZEd3Q1ZjZ1S0QrRkEzanYyQzhOMmMzRmQ5K2Q2S1Evb0Nxek54Mnkr?=
 =?utf-8?B?RVNWMXFPT2cxcEM2bHZ4bWhMaDA3amxKdkx2LzhjaXZHYmxzZDBiQUR5SkpI?=
 =?utf-8?B?RHNnTDQyNHR4c3NBM2RCNDlRcjNTSVBUTktPZFhQTmpyZjZKWWJvODNkcHA5?=
 =?utf-8?B?OXo2KzZGQ0pYdkxWYi84aDl0UmhOelJQekxJcjUrVndvdER3RG9tdThYZE11?=
 =?utf-8?B?Q0g1T2h2UnRCTmFKVXpiYS95QWU2UEl5MFkrUHFwc3FBUm5WdFI3dWlvbGwy?=
 =?utf-8?B?cno4YWRUcUlyRkxwZE9kK0NKdUV1Mzg3aitsd0FKb29qc3BOVXB6aVpMVDI5?=
 =?utf-8?B?L0J3dktmL1IzejVIWlViRFljOHJEU25DZUdrU0FJYVlCMnNsVE5JaEJkazU0?=
 =?utf-8?B?QjYrRWU4SWo3Y1c4d0ZJYjI5elhMbW9HUWtHNXd1Ti9aWisydTB0dFdHUDRz?=
 =?utf-8?B?cW9mT0hKOEY3d095Y0RpM2wyTi9wc3QyWkVzR095S2twSDZUZHRkWjBsUW54?=
 =?utf-8?B?b0dFZEhienZRZHMza3ZaSkQ3SHdiemttOHB4T0VVdDlZN3Z4enVpSVlMNWxa?=
 =?utf-8?B?K1ZFOHB0YTJFRE5ldTQvajVRYXNUUEU5dmNCeERjcGplOFc4SWYvbXk1Ky94?=
 =?utf-8?B?SzVXWGUySDN0eWZJaURscDlGMnV3R0pzVGVkcC9PdHFBUW02Rk9sTFI0MHF1?=
 =?utf-8?B?ZXcyOEVKeDVIMWJMSldPaDlqeTlyZlc0Z3d2NTZSN0RsUXBMU1Q1NnpYUTc2?=
 =?utf-8?B?cDJmM09WWW12TDVLbVpKeUJnSGF0SGRKSHc4bGFtV2NiSHdudEgwblNPdmRh?=
 =?utf-8?B?Z21SZmJEUTQ5dkxDL21FU1hINU9JUGpiVVNqRzF3dUE5cHNSNVNWV1kzRE5r?=
 =?utf-8?B?R1cvQ1pyeHRmQldjaGkxcnlOSDdKSW5PZGsrb21jd2pEbndORE85NFVTZU1S?=
 =?utf-8?B?NWpqSHUzTklKZ3V1a1VOMEZldyt6dVZOc1dPd3lsUEUraVN6dFhIb2FKbHhj?=
 =?utf-8?B?VUhaMTd2ZllaNEZ4cGQrWG9oM01JVWVxQ2NGSEJXWlpZZ1BmQStjV3JDRDgr?=
 =?utf-8?B?VExQRTdyb2hwNFA2R1A0cTBoZU1IUFp6TTNCNUJ1bElaVjdzeVdTNWNObFZB?=
 =?utf-8?B?dEhzdjkrSDQwZmkxTWYyeXYxa3pHMThDOXp5WmxjSjBucldZbCtmWDNGdjZz?=
 =?utf-8?B?dkp5RzVRaU9Yck5Ud2YweXRGODVQQ2JDNS9ZWFBnMFJsdzdORVNYaUt1ZUpo?=
 =?utf-8?B?OWQvTCt3NVFGMUhGeGJud0orQTFTQkJabFBaa0xOWlMrQ3REZDZqQnhKVTBP?=
 =?utf-8?B?bjhXTDZWeUZ6UWpjS1FrNmdJbVh5bWpucDIvcFZzdTRyVVFmUFcxb3hGdzN4?=
 =?utf-8?B?YVBrdzFMQ0Fabm8vMDBlNWQzTnVLR3JUVlJOeHZBTEREazd5OElHUGZMdkJT?=
 =?utf-8?Q?mt9Ht+YWx3Ljq?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cDU2VldnbGpkd2JlaU0zclJVRmUrZWR0UHdDRjZVclJVNk5lT3F6Q1J5SEI4?=
 =?utf-8?B?K05sWDRza3Vkb1FpNms3amtjaHZBZUFoTmd1NGtqUWNXQ0FLQTB1RjFOVm9W?=
 =?utf-8?B?SzlYcGEzVEFFL3g2bTBwNUVSUURJZDUrR0lwMkVPWHk0ZnFpbitFWXQvNlJK?=
 =?utf-8?B?Wk1uZi9JV095TE93S2ZkQjEzUzdaMWljNHRXQ29JOHdDY0hvcGF1Q3N3c1hn?=
 =?utf-8?B?NUU3SVpGYjhUa0xsUDQyTWRmYzlVMEZDQ1RUTjBkL3paS2dHd1doODNEV0VY?=
 =?utf-8?B?UG5QVVMzUnRqWXVMeXhRTlQvbisyOXlIVDJFMmt4aWVuWTV2SklMekRJdzlY?=
 =?utf-8?B?VVBWeHdRVVlpQ0NKL2MvdlVTNzI1WWQwYzJHbjBWQ3dXT3FycVh5UkRwQVd1?=
 =?utf-8?B?c3VRSlBtSVhrQTNsaW1pd1pwTHc4NzJxRGZsOVp5T0JiOXBlRXMvRDI1Nzl0?=
 =?utf-8?B?TXVEa2dGOGp0M2xnZ0xYRGhyRlZXdzB0S21BRXhXT3hEZVljQXNTUHRwcVIz?=
 =?utf-8?B?M0I3cTdTb0dRS01YVXBudEhJZ3IxTDV0QVpBVXl3SGs3ZWZ5SnYrRWk3SUxY?=
 =?utf-8?B?NW1vVDJhdXdxVGUyVm5oYk1tclVxU0ZPRXI1MVk0U2dycEpPT0s3QXRUamZT?=
 =?utf-8?B?U3NqWnhnSDdGSFNCbUE5dXplY3BUaDlkWCtXSmI3dHlWYThXU09TQVpKb0VR?=
 =?utf-8?B?MlY0M3BJNk0yc0ZobnBVRTlWb3hkLzZmYmk5L1pzd2hEV2VYS0VaTU1wOUIz?=
 =?utf-8?B?WHNNcWVNbUxGTGs0dTRSaStEU2tFOWxrYkNnS3A4dmhIQ2lyRVZmOWpuZFlM?=
 =?utf-8?B?WTdJTUd5Y3Rqb1dsWXBaQi9UNDNlWmcveHVwQ0hBZnk3NGpQei9nQUhrdnI2?=
 =?utf-8?B?U1JCY2JibzZ2NEVjTzFwVWU5S2tUU0RKYTFPRW9meG9URDd5bmdKYk82MGtx?=
 =?utf-8?B?VVpwYU90Rk5qVnVySWg3NENHVm84Mm4xSVFtNWdHODVPSWtuVk5FYnFsMFZi?=
 =?utf-8?B?MHgwNE9pdjZ2Zjk3cTJPSFRHRW5WdXZ5c2VlRm5VbDB3TzBod2VhMTRneE1t?=
 =?utf-8?B?OUU1Y2pDeVluVHR0MFRjdExQSGpvaTY2MUZIczZkWTdVSlpCK3pUanJvbjVF?=
 =?utf-8?B?UERIRnlSc3BjTjJ3NWdpZW5PRFFhSy95eTFoQzYrR1pZYit3b3VLWStZdlY4?=
 =?utf-8?B?ZTJDOUtCeWJxY3Nzd3RBMjVKT0RvRHFCb0dXTjdmUitwZVo3K2JJQTk0SHp0?=
 =?utf-8?B?V2dLeTlESlMxQ2F1Z0o5VHdXd3drVHp1eVRNSkhubVVtVkZXN0FlYkFwa01V?=
 =?utf-8?B?dk56NXNCbjQxbTVUbFhaMnI0TW1reW8yV1RaakMzRDJ4SEp3WXdENUQvVFNo?=
 =?utf-8?B?MUo3Y21GdFB2UU81SlIwbnNhc080M2k1MzVLN2RqWVA5ODJaMXpOVWpieUti?=
 =?utf-8?B?M3lvcUV2ZDJGRis3TitZQXVHZktoR1ZaWTZOOE9FeUxvL1loUGR1SE9GT3Zj?=
 =?utf-8?B?T3ZEWUVVTkE0TS8yRUE4clF2WGFpcWFJK1dPWm9XUHlSOHduRHRjNEgrWlFI?=
 =?utf-8?B?Ujl6anZIQ2prZWozRS9DSFZFelo4NXRQWTZOWkZoQ21lMU9LQk16Q0Q2elkr?=
 =?utf-8?B?Qno4V0RjeGVHY0dZTENXMUxZTmZTbGJmcFRzdlNRaVl5djB2MU9NWVpJY044?=
 =?utf-8?B?d3czaW1NQXIxWjhFV2lXOWNFd05SMFAxRGFhdFVKc1pwM2JHdkZoRkVZd1I1?=
 =?utf-8?B?cnd5YzNlV0lyTDVySDROaWNGQXJtMjdqVHlvZlYxRTJBa3JBVElpN25BcnRm?=
 =?utf-8?B?dCtXUUxNS2w3V2pKOUIrSzZaUzFSWHc0cG5oeFoxWGlqRVd5UFNkRml3UHA4?=
 =?utf-8?B?a2N4UURXM1MwNUFSdDhRS25GRDRSWHREeitqejBJRlhnTkplQjBTZGU4ang2?=
 =?utf-8?B?QWxKK1JpZFgzbG5MWGpUbFF4Qi9HUXhqaWNNa1FUcklvVG9OQnUyVjRVTWpT?=
 =?utf-8?B?VDR5dUhhbkM3d2lybkJud0M0dWxxWW5sWlAzNDUvMFNRSkNQU3RiRGd3NGhw?=
 =?utf-8?B?cGN4QTAxTlM2MVFFUjNlVHR0TFF1eG5HUU5LeXIyVG5pcUJCK1hFTGp2akFZ?=
 =?utf-8?B?WTllUExZWnRCSndWdlFWOUtPdlkySHZjejZjM0hIU1JieXA5OWJvTUJNZ3Ni?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EEBAC787F7D9E489C56FABA335D43A6@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 60eb7db7-6e0b-4513-9309-08dd54d4be3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 13:11:25.7288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRrNTmMJxFppUa3ite42NmN8i2Qx/StpUkbwa6hq3V3k2sVgoTLc5G7XLgLs3ZztRbooNrwcFckHpq8fLzh4ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6525
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Feb 2025 13:11:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17295

T24gTW9uLCAyMDI1LTAyLTI0IGF0IDEzOjU1ICswMTAwLCBTdGVmYW4gS29jaCB3cm90ZToNCj4g
T24gTW9uLCAyMDI1LTAyLTI0IGF0IDEyOjU4ICswMTAwLCBNYXRoaWV1IER1Ym9pcy1CcmlhbmQg
d3JvdGU6DQo+ID4gT24gVGh1IEZlYiAyMCwgMjAyNSBhdCA2OjI3IFBNIENFVCwgU3RlZmFuIHZp
YQ0KPiA+IGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gPiBLb2NoIHdyb3RlOg0KPiA+ID4gV2hl
biBgdWQuc2hhbGxvdyA9PSAxYDoNCj4gPiA+IC0gUHJlZmVyIGFuIGluaXRpYWwgc2hhbGxvdyBj
bG9uZSBvdmVyIGFuIGluaXRpYWwgZnVsbCBiYXJlDQo+ID4gPiBjbG9uZSwNCj4gPiA+ICAgd2hp
bGUgc3RpbGwgdXRpbGl6aW5nIGFueSBhbHJlYWR5IGV4aXN0aW5nIGZ1bGwgYmFyZSBjbG9uZXMu
DQo+ID4gPg0KPiA+ID4gVGhpcyBpbXByb3ZlczoNCj4gPiA+IC0gUmVzb2x2ZSB0aW1lb3V0IGlz
c3VlcyBkdXJpbmcgaW5pdGlhbCBjbG9uZXMgb24gc2xvdyBpbnRlcm5ldA0KPiA+ID4gY29ubmVj
dGlvbnMNCj4gPiA+ICAgYnkgcmVkdWNpbmcgdGhlIGFtb3VudCBvZiBkYXRhIHRyYW5zZmVycmVk
Lg0KPiA+ID4gLSBFbGltaW5hdGUgdGhlIG5lZWQgdG8gdXNlIGFuIEhUVFBTIHRhcmJhbGwgYFNS
Q19VUklgDQo+ID4gPiAgIHRvIHJlZHVjZSBkYXRhIHRyYW5zZmVyLg0KPiA+ID4gLSBBbGxvdyBT
U0gtYmFzZWQgYXV0aGVudGljYXRpb24gKGUuZy4gY2VydCBhbmQgYWdlbnQtYmFzZWQpIHdoZW4N
Cj4gPiA+ICAgdXNpbmcgbm9uLXB1YmxpYyByZXBvcywgc28gYWRkaXRpb25hbCBIVFRQUyB0b2tl
bnMgbWF5IG5vdCBiZQ0KPiA+ID4gcmVxdWlyZWQuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogU3RlZmFuIEtvY2ggPHN0ZWZhbi1rb2NoQHNpZW1lbnMuY29tPg0KPiA+ID4gLS0tDQo+ID4N
Cj4gPiBIaSBTdGVmYW4sDQo+ID4NCj4gPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2guDQo+ID4NCj4g
PiBXZSBnb3QgYSBuZXcgZmFpbHVyZSBvbiB0aGUgYXV0b2J1aWxkZXIsIHNwZWNpZmljYWxseSB3
aXRoIHRoZQ0KPiA+IG9lLXNlbGZ0ZXN0LXVidW50dSBidWlsZC4gSSdtIG5vdCBlbnRpcmVseSBz
dXJlIHRoaXMgY29tZXMgZnJvbQ0KPiA+IHRoaXMNCj4gPiBzZXJpZXMsIHNvIEkgd2lsbCB0cnkg
YSBidWlsZCB3aXRob3V0IGl0IHRvIGNvbmZpcm0uDQo+ID4NCj4gPiBIZXJlIGlzIHRoZSBlcnJv
cjoNCj4gPg0KPiA+IE5PVEU6IFJ1bm5pbmcgdGFzayAyIG9mIDQgKC9zcnYvcG9reWJ1aWxkL3lv
Y3RvLXdvcmtlci9vZS1zZWxmdGVzdC0NCj4gPiB1YnVudHUvYnVpbGQvYnVpbGQtc3QtMzUwMjk0
My9tZXRhLXNlbGZ0ZXN0L3JlY2lwZXMtdGVzdC9naXQtDQo+ID4gc3VibW9kdWxlLXRlc3QvZ2l0
LXN1Ym1vZHVsZS10ZXN0LmJiOmRvX2ZldGNoKQ0KPiA+IE5PVEU6IHJlY2lwZSBnaXQtc3VibW9k
dWxlLXRlc3QtMS4wLXIwOiB0YXNrIGRvX2ZldGNoOiBTdGFydGVkDQo+ID4gV0FSTklORzogZ2l0
LXN1Ym1vZHVsZS10ZXN0LTEuMC1yMCBkb19mZXRjaDogQ3JlYXRpbmcgZmFzdCBpbml0aWFsDQo+
ID4gc2hhbGxvdyBjbG9uZSBmYWlsZWQsIHRyeSBpbml0aWFsIHJlZ3VsYXIgY2xvbmUgbm93Lg0K
PiA+IFdBUk5JTkc6IGdpdC1zdWJtb2R1bGUtdGVzdC0xLjAtcjAgZG9fZmV0Y2g6IEZhaWxlZCB0
byBmZXRjaCBVUkwNCj4gPiBnaXRzbTovL2dpdC5vcGVuZW1iZWRkZWQub3JnL2JpdGJha2U7cHJv
dG9jb2w9Z2l0O25hbWU9Yml0YmFrZTtzdWJwDQo+ID4gYXQNCj4gPiBoPWJpdGJha2U7bm9icmFu
Y2g9MTtsZnM9RmFsc2U7YmFyZWNsb25lPTE7bm9icmFuY2g9MSwgYXR0ZW1wdGluZw0KPiA+IE1J
UlJPUlMgaWYgYXZhaWxhYmxlDQo+ID4gRVJST1I6IGdpdC1zdWJtb2R1bGUtdGVzdC0xLjAtcjAg
ZG9fZmV0Y2g6IEZldGNoZXIgZmFpbHVyZTogRmV0Y2gNCj4gPiBjb21tYW5kIGV4cG9ydCBQU0VV
RE9fRElTQUJMRUQ9MTsgZXhwb3J0DQo+ID4gUEFUSD0iL3Nydi9wb2t5YnVpbGQveW9jdG8tDQo+
ID4gd29ya2VyL29lLXNlbGZ0ZXN0LXVidW50dS9idWlsZC9idWlsZC1zdC0zNTAyOTQzL3RtcC9z
eXNyb290cy0NCj4gPiB1bmluYXRpdmUveDg2XzY0LWxpbnV4L3Vzci9iaW46L3Nydi9wb2t5YnVp
bGQveW9jdG8td29ya2VyL29lLQ0KPiA+IHNlbGZ0ZXN0LXVidW50dS9idWlsZC9zY3JpcHRzOi9z
cnYvcG9reWJ1aWxkL3lvY3RvLXdvcmtlci9vZS0NCj4gPiBzZWxmdGVzdC11YnVudHUvYnVpbGQv
YnVpbGQtc3QtMzUwMjk0My90bXAvd29yay9jb3JlMi02NC1wb2t5LQ0KPiA+IGxpbnV4L2dpdC1z
dWJtb2R1bGUtdGVzdC8xLjAvcmVjaXBlLXN5c3Jvb3QtbmF0aXZlL3Vzci9iaW4veDg2XzY0LQ0K
PiA+IHBva3ktbGludXg6L3Nydi9wb2t5YnVpbGQveW9jdG8td29ya2VyL29lLXNlbGZ0ZXN0LQ0K
PiA+IHVidW50dS9idWlsZC9idWlsZC1zdC0zNTAyOTQzL3RtcC93b3JrL2NvcmUyLTY0LXBva3kt
bGludXgvZ2l0LQ0KPiA+IHN1Ym1vZHVsZS10ZXN0LzEuMC9yZWNpcGUtDQo+ID4gc3lzcm9vdC91
c3IvYmluL2Nyb3Nzc2NyaXB0czovc3J2L3Bva3lidWlsZC95b2N0by13b3JrZXIvb2UtDQo+ID4g
c2VsZnRlc3QtDQo+ID4gdWJ1bnR1L2J1aWxkL2J1aWxkLXN0LTM1MDI5NDMvdG1wL3dvcmsvY29y
ZTItNjQtcG9reS1saW51eC9naXQtDQo+ID4gc3VibW9kdWxlLXRlc3QvMS4wL3JlY2lwZS1zeXNy
b290LQ0KPiA+IG5hdGl2ZS91c3Ivc2Jpbjovc3J2L3Bva3lidWlsZC95b2N0by13b3JrZXIvb2Ut
c2VsZnRlc3QtDQo+ID4gdWJ1bnR1L2J1aWxkL2J1aWxkLXN0LTM1MDI5NDMvdG1wL3dvcmsvY29y
ZTItNjQtcG9reS1saW51eC9naXQtDQo+ID4gc3VibW9kdWxlLXRlc3QvMS4wL3JlY2lwZS1zeXNy
b290LQ0KPiA+IG5hdGl2ZS91c3IvYmluOi9zcnYvcG9reWJ1aWxkL3lvY3RvLXdvcmtlci9vZS1z
ZWxmdGVzdC0NCj4gPiB1YnVudHUvYnVpbGQvYnVpbGQtc3QtMzUwMjk0My90bXAvd29yay9jb3Jl
Mi02NC1wb2t5LWxpbnV4L2dpdC0NCj4gPiBzdWJtb2R1bGUtdGVzdC8xLjAvcmVjaXBlLXN5c3Jv
b3QtbmF0aXZlL3NiaW46L3Nydi9wb2t5YnVpbGQveW9jdG8tDQo+ID4gd29ya2VyL29lLXNlbGZ0
ZXN0LXVidW50dS9idWlsZC9idWlsZC1zdC0zNTAyOTQzL3RtcC93b3JrL2NvcmUyLTY0LQ0KPiA+
IHBva3ktbGludXgvZ2l0LXN1Ym1vZHVsZS10ZXN0LzEuMC9yZWNpcGUtc3lzcm9vdC0NCj4gPiBu
YXRpdmUvYmluOi9zcnYvcG9reWJ1aWxkL3lvY3RvLXdvcmtlci9vZS1zZWxmdGVzdC0NCj4gPiB1
YnVudHUvYnVpbGQvYml0YmFrZS9iaW46L3Nydi9wb2t5YnVpbGQveW9jdG8td29ya2VyL29lLXNl
bGZ0ZXN0LQ0KPiA+IHVidW50dS9idWlsZC9idWlsZC1zdC0zNTAyOTQzL3RtcC9ob3N0dG9vbHMi
OyBleHBvcnQNCj4gPiBIT01FPSIvc3J2L3Bva3lidWlsZCI7IGdpdCAtYyBnYy5hdXRvRGV0YWNo
PWZhbHNlIC1jIGNvcmUucGFnZXI9Y2F0DQo+ID4gLQ0KPiA+IGMgc2FmZS5iYXJlUmVwb3NpdG9y
eT1hbGwgLWMgY2xvbmUuZGVmYXVsdFJlbW90ZU5hbWU9b3JpZ2luIGZldGNoDQo+ID4gb3JpZ2lu
IDUyYTE0NGE3ZGFhOTRiMmJkMjM5ZDU4MmNiNzFkMWYwMzExOTkxOGYgLS1kZXB0aCAxIGZhaWxl
ZA0KPiA+IHdpdGgNCj4gPiBleGl0IGNvZGUgMSwgb3V0cHV0Og0KPiA+IGVycm9yOiBTZXJ2ZXIg
ZG9lcyBub3QgYWxsb3cgcmVxdWVzdCBmb3IgdW5hZHZlcnRpc2VkIG9iamVjdA0KPiA+IDUyYTE0
NGE3ZGFhOTRiMmJkMjM5ZDU4MmNiNzFkMWYwMzExOTkxOGYNCj4gPg0KPiA+IGh0dHBzOi8vYXV0
b2J1aWxkZXIueW9jdG9wcm9qZWN0Lm9yZy92YWxreXJpZS8jL2J1aWxkZXJzLzU0L2J1aWxkcy8x
MDMxL3N0ZXBzLzE0L2xvZ3Mvc3RkaW8NCj4gPg0KPiA+IENhbiB5b3UgaGF2ZSBhIGxvb2sgYXQg
dGhpcyBpc3N1ZSBwbGVhc2U/DQo+IERvIHlvdSB1c2luZyAxNzE2YWQ2N2JiZTlmNGNlY2YxZTNi
Y2ZjMjAwN2IxNTBiYTc3NzQxIGZyb20gYml0YmFrZXMNCj4gbWFzdGVyLW5leHQgYnJhbmNoPyBC
ZWNhdXNlIHRoYXQgaXMgUEFUQ0ggdjIgd2l0aCB0aGF0IGlzc3VlDQo+IHNwZWNpYWxseQ0KPiBv
biB1YnVudHUgMjAuMDQuLi4NClNvcnJ5LCB2MyBpcyBtZWFudC4NCnY0IFBBVENIIGZyb20gRnJp
ZGF5IHNob3VsZCBmaXggdGhpcy4NCj4gPg0KPg0KDQotLQ0KU3RlZmFuIEtvY2gNClNpZW1lbnMg
QUcNCmh0dHA6Ly93d3cuc2llbWVucy5jb20vDQo=

