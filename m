Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB707CA0EFC
	for <webhook@archiver.kernel.org>; Fri, 30 Aug 2024 09:49:57 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.69])
 by mx.groups.io with SMTP id smtpd.web11.9170.1725011388357346011
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Aug 2024 02:49:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=bpRVGVOM;
 spf=pass (domain: axis.com, ip: 52.101.69.69, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBl0lv8AGw48WVCmrgozji+JR5yqRTkIQ2E62sy/8WGRL8BUV6070729g7NsVSB9CsdHfuOIP4+Jtj2ndv3a9b0X76EupZhfk07AeyvTGepHxexxdvYc0XMOamCmP5EmpeAYgz6vAmn9BOhkHURWplRtQxATWzXEif3smJ8kg6sVtYOW/H0Q31rsKIhyyZJrCe4zRfQlEcQTiU9/9D4mHRbB77Stf1zMmty1aAM9kjwOb83NrY3W8Mb1PevJj8N0YM+fjYrBgTmmePWcMnBuISs6Uqeqx33hNRLqbkqPXt87RJlNzfWVSAUWzUrNZD6YkOmHR8AqfS1LU+AHMrPVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abzszVk6sHxwEOJA4NgHzn/S6uciLNgfLEFNFjOWT/M=;
 b=lkggMyo+M2VX7AL56A3oidu8z/SYXASTUr3XEDcRwMSVy0GCKNCDfCjEdp6W4IEtdwYCBC0xZbh8lfBzYJbdz/LvtMTypLCSaWqogiviwN5ycmk/Za648O60/bAXkSpnSC/g79pw9YuOVa1mFkeOLd+9ku/HEe8j8NMe9OHrQfWYUquKD506cuM78NXSDbETvPPdxYDDpl6GX1dO6JPJ+4s/6QYcJ8eYMd7NUpYzsa+wPiTQalIx8Lan/5nEIiMkEg/pQ0AVWRIi1ZiRD7iOrtgWWWSftTsR9ppU39gAeOSKRv5ENd3lYPDZb1G3MlaBL6Qus0/8B1n/1SLmcfuh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abzszVk6sHxwEOJA4NgHzn/S6uciLNgfLEFNFjOWT/M=;
 b=bpRVGVOMiv2aMQUpvqxMhQHTxaOiRT0mSSzR3fTiELudKGZ3f6R3K4NrVZGzkDPp5mD+2cITMNZwbPyYrB89IUqIVqFFN0/Cog1ZfjLpQn9g5ixDA2txX6isGyko7Keamqs/GNdy1mr27JlFnYuQxu9yUYniNJ4jAubrZ3w1lRM=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS2PR02MB10314.eurprd02.prod.outlook.com (2603:10a6:20b:62f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 09:49:42 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%4]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 09:49:42 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"adam.blank.g@gmail.com" <adam.blank.g@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [bitbake][kirkstone][2.0] Appends discarded by
 expandVarref
Thread-Topic: [bitbake-devel] [bitbake][kirkstone][2.0] Appends discarded by
 expandVarref
Thread-Index: AQHa+fk/hz7MGqMp1Ead+ldAvptQErI+Ld0AgAFerTA=
Date: Fri, 30 Aug 2024 09:49:42 +0000
Message-ID: 
 <DB5PR02MB10213757E587A5DE3B458F055EF972@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <zAtt.1724925180061037156.a5Q8@lists.openembedded.org>
 <083be01b5a70c46bedcdfca1c403c87b18299bf1.camel@linuxfoundation.org>
In-Reply-To: 
 <083be01b5a70c46bedcdfca1c403c87b18299bf1.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS2PR02MB10314:EE_
x-ms-office365-filtering-correlation-id: 44e22c1f-7856-4d4f-0c29-08dcc8d912bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bzVKNHI2R3RnU2VBTXM2ME1SRytpUk5MdW9kU3ZQNFBBUnJuZlJ4YUVvQVRy?=
 =?utf-8?B?emE3TzI3Rzc4UzlnOXgxcjV6UUowRjRxOVR3TkpOWmtTT0ZTaU50eFBXa2lo?=
 =?utf-8?B?VHNIZ0xpcDJ1ZVJuVzRWUktRZWY4U0lCUUVNbEQrcjJEbXY4WWxzUFRIVnFy?=
 =?utf-8?B?aWpVN0ZVTWQ4dnFZKzNNUG11aklWeGxITlJDZjd4dTRjSTJsM0g0Sk1ISGE3?=
 =?utf-8?B?VUJPYWp0MDNySGZGVDRMMGRUYjBhclhtUy9xZ014QzZSVmNZVGRJSng4TXJm?=
 =?utf-8?B?YWhrR3ZHNzBxck9qcFhmMTNFSUdaVWxjeHNwTlBhS0RhQkZIWlR3clRtL1pZ?=
 =?utf-8?B?M2JhRW55NU9oc3pvcjNsYU9XemRNb2MxbWY2YUpadEYyK1BKZm9TT2c0QXVh?=
 =?utf-8?B?R2czN0FXV3pXdVJMNVA1STNCWWZlV3o2TlNqWTV6VzgxUTFVSVlpcnZxb0Iy?=
 =?utf-8?B?U1BiY3FTcmdBWS9IRWszQ1Zxemh5VWdBKzZJMm5pWnAyVmF2QzJkc1U4WllB?=
 =?utf-8?B?ZEpPdFVGNjZGdVFHanFWOUZNeFp1Y09GSng4enZZazJadEVMRFI3UU5IRkhw?=
 =?utf-8?B?a0dGcHFVR1pJZ3dob3F2dUpJbGFTZ25RTFRJQTdMTGtwR0ptTnJLU01DQ3lY?=
 =?utf-8?B?VVJUNDI1N1kremdPeVBMUlMwSGhiRFF1UEo3czNTdm5kY0w1dHpZNlNzRTVw?=
 =?utf-8?B?YU1FZmpFdlRxbUhVUzczbm1LUnFaMXQvelFLQkgrUU1BNmJZaXgwVkpONGtk?=
 =?utf-8?B?WERJdVJRWU45UE5XZitrczhPYng4TlFMbVcwYWNxM0JEZXdCeWNwSitsaU9p?=
 =?utf-8?B?M1JBa2hKNyt1cWVKVTlicWo2ZlZUb3REM0NCQ2xGMGxPM1FMM0FiYVU5aVAy?=
 =?utf-8?B?d1BTWW42NHNHOXF1ZFhZRmgrRE1FQS82L3BVMlc0MnU2bFlBcytHRHRGRE9T?=
 =?utf-8?B?NWtqZnUxZHpycUcvSUZpemFVekpyWmcyMUtKR3JMdzNpQ1lQVTZsYlhva1Uz?=
 =?utf-8?B?SUEzUDNLbkZKVndOY2ZjQkN3QnAvMmlqU0JwVC9UazJQZHMwRTZxSHJ2aVdU?=
 =?utf-8?B?MWcvUVprN1R0ZUQxM1dDRFk5M0pkOXcvV1dmclZFdVNRQ3ZheHpEY2RmUGxF?=
 =?utf-8?B?cFQ1bGhYbmFwWWIrTlFlQStHT0FJY05CZkxQeDJiODhMZUpzZUN2TnlzSUZ3?=
 =?utf-8?B?MHdWQ3E0ZnVXNzM1M21pMW5vYnZVY1BzRUhXcVN1Z0hCbGkzZEVDZldTc004?=
 =?utf-8?B?R2R0amxUTm1EcnRVM0ZJaDNBZS91SWZQVlFTTUpkNzlDK2FkdWt0SzYwQWJK?=
 =?utf-8?B?TkE4ZmR2ekowc0pSYWdzUDhnaU01Z3orVWNXeVRyV2gvNUJneGlIYUUrc3pH?=
 =?utf-8?B?eFhxQmIrTm1iN2xyamlwS0J2UW91MkxwYzlGQy9UanVXMTV2dk5nWGx2NEh1?=
 =?utf-8?B?TEJRWlY2aE16QVZmZXdjb0xQMVZmTWdyL21uaWRyVDcxSW95M0w1ZW14aUFp?=
 =?utf-8?B?ZlVXWS80WFpJUVdSVHVpT201b1hHWmNlRS9LcUFxMHlFckUwM2h0S01rOWlZ?=
 =?utf-8?B?bzVVWEVRVVNTZGx6MGFma0RwMmlxVWtMd2tSS0NZS1ZRS0IrY0dQUkF6K2lV?=
 =?utf-8?B?ZDlCeVlZR3BHbEtnN2dDdlR2ZXhsOTU5bXpTakJHQXA2eTJPOHFqdHJwa1Nq?=
 =?utf-8?B?bmdvWHY2UVVtZG9LbWovYmY3LzFibitaVmRDR2xiV2FPRUx0R1k4NnJneS9h?=
 =?utf-8?B?YnhPZURLTnlDaFhOQ0tSTE9WdW9LeVY5Q0QySmNGN3cyeWVBckNMaURteE5z?=
 =?utf-8?B?N205OUdMbE45NENBQ29ucHg5MWZvK3hLWkdNMXcveElaMTVoQnJiMStZdm1u?=
 =?utf-8?B?ajNkTERGT1hGRVpTdXI0VXppVkNISnBZYnlNUnRYeWsvQkE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MzBvalFHVG5QRkF6Um1NSGtQNGdwYWNVUjRxR1FUenVvYW1ZYklSeXFDenJM?=
 =?utf-8?B?K3RGNlQxakpYRnZCQmIxYThEdnQ3cUo0TEU3SDdsbkl2dUIxQTN0M1dOQUZ0?=
 =?utf-8?B?YlN4OU1MUy93bmFtb0ZzSGw0aGp0Tlk0bVErM3JHUkZxdUpsQTZzZUdwYXk3?=
 =?utf-8?B?WlFqQjRZYVc0Q0Fmc0d1MXFzcmo2SzR6RkJWS0Z4aklqWU5xa3c3NGJSMExO?=
 =?utf-8?B?TEMzS2tUUi9iMXkwTUlKVDNjcHBlT0dEd21GeHJwQ3RuQk9PT1pYcnVjaEZV?=
 =?utf-8?B?aWpCY1J4M0dZaitlVDR3TnNQQXZIVTRQZ3B3clpwZTZxK3hZOFc3NGpRcVd4?=
 =?utf-8?B?bkhmT1U2SEMzL04zU0xHMUV4VWx3b0pKR1pDencydWU2cjBHaUNvalVSU2Nj?=
 =?utf-8?B?NVpFbjhYb1Zyc3psL2lYYlhNcjJNM01xcTVHNkhCVC9QTldxbmZmcERSbndK?=
 =?utf-8?B?dXpGcWZ3dkd4ZUxWd3Q4alpyMFVsa2cvYm4xM1EzNVBVNG9LQSttNWhnNWlM?=
 =?utf-8?B?RjYzektLUkZLaHBvYmFHRWxxbURlWGhPY29iL0txQlpDNUozU0plU2FVNTgz?=
 =?utf-8?B?LzBuM0N0aVhJbVUyQUpvRSt2blhOaEh1eG9XWXNYRzcyZEUvSElxTXoyT08w?=
 =?utf-8?B?WnU3QXVyNlRpTGJYTmtZWHJuUWJMQ293bzdRR3lmYkF4TjBjc0k5ejV4Mmxv?=
 =?utf-8?B?aWpudWtVRU1tREhKRnFrZzBWeFpQeTNFY0NFRnVIbDVjVUdFa2JvVmVNakoz?=
 =?utf-8?B?elZQVFl1Zy9RdHVOVnR5b0NVR1FBME5ONFdkK2dyNmZ6WnZJZU1TaDZEa3lI?=
 =?utf-8?B?S2puRXlWRDhOak4xdVBQVjBOaW1iK1hsNEEwTHNqaGg0LzJvOW9tVzFTYnBq?=
 =?utf-8?B?TUdVbTdWMXNNQnBHSlZNclhhMU1KN3RkdEtxTkVXdDJPV0VadnZLazRVbVAy?=
 =?utf-8?B?eWRVWlZJemVCc0ZVdU5CLyt1Q0hFQzVYYW9zZStJeWJ0NWpnNXJtVDhVM2Nr?=
 =?utf-8?B?Uk9qaVBGc3JycDF6THdjajZDNTZyQzdxaHZ6WU9IVUpIY3habDh6V0RvVjRP?=
 =?utf-8?B?bWVRa3owM3lySXFDQkRTY1h5VlBEcnROdGZmUVR1dkpNODJyWEwwTkhUS0NH?=
 =?utf-8?B?dEtoNEdtQUNEUXJQbm8xUXVoNkMwT3VUUy9vNTFDUDc1ZnM0TSsyZFBlY2lF?=
 =?utf-8?B?REd2aDVqTUE1ZUtsaDM5aWlnaElpUlFEVlFDV2c5bVV5ODFCRmZ6RFQ0MDMr?=
 =?utf-8?B?T2lKVHVXdXZTVlJacjM0WEtVUGhBVkpoblNCbENlNC9Vd0J4eWZLRWt3c0Jn?=
 =?utf-8?B?SWF1SXJEd293a1IyLzdsR3ZNeFh4VlEyck1Ybklmck1Jemd2a1Y2NUpSWWNh?=
 =?utf-8?B?Nkw0SWZiNW5pTkU1L2tVRmhkdlJyK0JrVVlaR05ld0hDQXRJVWVrbjdXMTVT?=
 =?utf-8?B?RjNVMDE1LzR6dUd1c0lISEdqblNlUHovUkE4VzUwQ0VnS0VFUjl1UUF3cUkr?=
 =?utf-8?B?bTU4aVloU1Nqd2EzbzBZTmUvdFdYUnlFRnRydU9QUzgzaXJWd01jUWVvbzQ3?=
 =?utf-8?B?K1NzS1RIQXhPRDBCaXZtd0ZqUTMzZjZwMWRkNTJBOGRjTC9RSExpbGJ1VjNT?=
 =?utf-8?B?aXNuZG9LazFKRGJqK2x0Q1owWS9kYTNnSFNGSnR1c285ejAwcDlGZU00akRa?=
 =?utf-8?B?d285TWVHbDhaYjRGWkRXVkpkSXhmNWFQWEpjSHE3YmVvU21janF5MVRPTUlp?=
 =?utf-8?B?eWYwRElJSW10RkxZSG1IVzBUdWZVQjFYdUw5K2xYVVFZbGZLMGdxMWpyU2JD?=
 =?utf-8?B?d2JjY0hHdURDTmhYZldvR1dZenU4azFjT0p6VHNjZGw5L0l1K1FmdERyOU5x?=
 =?utf-8?B?L1U3V0VsQ09kMzc0Q0NZUUVKWVhDUkNXblZNbE5SNzNzLzZpeXVlVmc4Rzlr?=
 =?utf-8?B?ZUpMQy9tQm5qTFFmNDA5cTdXZDcxc0VRNlQyd1JPREtKQnBELzFQanArNDRW?=
 =?utf-8?B?MlpUcDk2ZmNXV3l2SWU5bWhjUGxPYmduQklMZ3RmZFVDRkRVVDdHcXAxaEhs?=
 =?utf-8?B?cm9RbGMyd2tySHFMRDdrRHhyMkFWcGUyOUFHeFkrc2hVQjMzWDRRZHVsLy8v?=
 =?utf-8?Q?HJh8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e22c1f-7856-4d4f-0c29-08dcc8d912bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 09:49:42.7007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLJLw9lUpXepfB3jB1timOS0fjVl0dV/Sp6Hz/PrzruUGyRmebtjjznUayJLtlOX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB10314
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Aug 2024 09:49:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16530

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIFJpY2hhcmQgUHVyZGllDQo+IFNlbnQ6IGRlbiAyOSBhdWd1c3RpIDIwMjQg
MTQ6NDINCj4gVG86IGFkYW0uYmxhbmsuZ0BnbWFpbC5jb207IGJpdGJha2UtZGV2ZWxAbGlzdHMu
b3BlbmVtYmVkZGVkLm9yZw0KPiBTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIFtiaXRiYWtl
XVtraXJrc3RvbmVdWzIuMF0gQXBwZW5kcyBkaXNjYXJkZWQgYnkgZXhwYW5kVmFycmVmDQo+IA0K
PiBPbiBUaHUsIDIwMjQtMDgtMjkgYXQgMDI6NTMgLTA3MDAsIEFkYW0gQmxhbmsgdmlhIGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgd3JvdGU6DQo+ID4gZXhwYW5kVmFycmVmIGlzIGNhbGxlZCBkdXJp
bmcgdGhlIHBhcnNpbmcgc3RhZ2UsIHRvIGV4cGFuZCBzcGVjaWFsIHB1cnBvc2UgdmFyaWFibGVz
LCBpbiBteSBjYXNlIExBWUVSRElSLg0KPiA+IEludGVybmFsbHkgaXQgY2FsbHMgc2V0VmFyIHdp
dGhvdXQgbGV0dGluZyBpdCBrbm93IHRoYXQgcGFyc2luZyBpcyBUcnVlLCB3aGljaCByZW1vdmVz
IGFueSBwb3NzaWJsZSBhcHBlbmRzIGZvciB0aGUgdmFyaWFibGUgYmVpbmcgcHJvY2Vzc2VkIGJ5
IGl0Lg0KPiA+IFRoaXMgaGFzIGludGVyZXN0aW5nIHNpZGUgZWZmZWN0cyAtIEkgZG91YnQgdGhl
eSB3ZXJlIGludGVuZGVkLCBidXQgZml4aW5nIGl0IHNob3dzIGhvdyByaWZlIHRoZXkgYXJlLg0K
PiA+DQo+ID4gMS4gUmVhbCBsaWZlIGV4YW1wbGUgZm9yIEJCTUFTSw0KPiA+IMKgIMKgIC0gQkJN
QVNLOmFwcGVuZDpxZW11YXJtNjQgPSAiIG1ldGEtZm9vL3JlY2lwZXMtYmFyIg0KPiA+IMKgIMKg
IC0gQkJNQVNLICs9ICIke0xBWUVSRElSfS9yZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC15b2N0
b181LjE1LmJiYXBwZW5kIg0KPiA+DQo+ID4gwqAgwqAgV2hlbiB0aGlzIGlzIHBhcnNlZCBpbiBs
YXllci5jb25mLCBPVkVSUklERVMgaGF2ZSBub3QgYmVlbiBhcHBlbmRlZCB3aXRoICdxZW11YXJt
NjQnIHlldC4NCj4gPiDCoCDCoCBCZWZvcmUgdGhlIGNoYW5nZSAoc2VsZi5zZXRWYXIoa2V5LCBy
ZWZlcnJlcnZhbHVlLnJlcGxhY2UocmVmLCB2YWx1ZSkpKToNCj4gPiDCoCDCoCDCoCBUaGUgY2Fs
bCB0byBleHBhbmRWYXJyZWYgZW5kcyB1cCBzZXR0aW5nIEJCTUFTSyB0byBzb21lIGFwcGVuZGVk
IHZhbHVlIHdpdGggTEFZRVJESVIgZXhwYW5kZWQsIGJ1dCByZW1vdmluZyB0aGUgY29uZGl0aW9u
YWwgYXBwZW5kIGZvciBxZW11YXJtNjQuDQo+ID4gwqAgwqAgwqAgVGhlIHFlbXVhcm02NCBhcHBl
bmQgYWx0aG91Z2ggcGVyZmVjdGx5IGdvb2Qgc3ludGF4LXdpc2UsIGlzIG5ldmVyIGFwcGxpZWQu
DQo+ID4gwqAgwqAgQWZ0ZXIgdGhlIGNoYW5nZSAoc2VsZi5zZXRWYXIoa2V5LCByZWZlcnJlcnZh
bHVlLnJlcGxhY2UocmVmLCB2YWx1ZSksIHBhcnNpbmc9VHJ1ZSkpOg0KPiA+IMKgIMKgIMKgIFRo
ZSBjYWxsIHRvIGV4cGFuZFZhcnJlZiBlbmRzIHVwIHNldHRpbmcgQkJNQVNLIHRvIHNvbWUgYXBw
ZW5kZWQgdmFsdWUgd2l0aCBMQVlFUkRJUiBleHBhbmRlZCwgdGhlIGNvbmRpdGlvbmFsIGFwcGVu
ZCBmb3IgcWVtdWFybTY0IHJlbWFpbnMgaW4gcGxhY2UuDQo+ID4gwqAgwqAgwqAgQXMgc29vbiBh
cyB0aGUgT1ZFUlJJREVTIHN0YXJ0IGNvbnRhaW5pbmcgJ3FlbXVhcm02NCcsIHRoZSBjb25kaXRp
b25hbCBhcHBlbmQgYWxzbyBzdGFydHMgYmVpbmcgY29uc2lkZXJlZCAtIGFzIGludGVuZGVkLg0K
PiA+IDIuIFJlYWwgbGlmZSBleGFtcGxlIGZvciBCQkZJTEVTDQo+ID4gwqAgwqAgLSBCQkZJTEVT
OmFwcGVuZCA9ICIgJHtMQVlFUkRJUn0vcmVjaXBlcy1jb3JlL3dwYS1zdXBwbGljYW50L3dwYS1z
dXBwbGljYW50XyUuYmJhcHBlbmQiDQo+ID4NCj4gPiDCoCDCoCBCZWZvcmUgdGhlIGNoYW5nZSAo
c2VsZi5zZXRWYXIoa2V5LCByZWZlcnJlcnZhbHVlLnJlcGxhY2UocmVmLCB2YWx1ZSkpKToNCj4g
PiDCoCDCoCDCoCBUaGUgY2FsbCB0byBleHBhbmRWYXJyZWYgZW5kcyB1cCBzZXR0aW5nIEJCRklM
RVMgdG8gc29tZSBhcHBlbmRlZCB2YWx1ZSB3aXRoIExBWUVSRElSIGV4cGFuZGVkLCBidXQgcmVt
b3ZpbmcgdGhlIGFwcGVuZC4NCj4gPiDCoCDCoCDCoCBUaGlzIHRpbWUgdGhlIGVmZmVjdCBpcyBl
eGFjdGx5IGFzIHRoZSBhdXRob3IgaW50ZW5kZWQsIGJ1dCBvbmx5IGFjY2lkZW50YWxseSAtIGNv
bnRyYXJ5IHRvIHdoYXQgdGhlIHN5bnRheCB3b3VsZCBzdWdnZXN0Lg0KPiA+IMKgIMKgIEFmdGVy
IHRoZSBjaGFuZ2UgKHNlbGYuc2V0VmFyKGtleSwgcmVmZXJyZXJ2YWx1ZS5yZXBsYWNlKHJlZiwg
dmFsdWUpLCBwYXJzaW5nPVRydWUpKToNCj4gPiDCoCDCoCDCoCBUaGUgY2FsbCB0byBleHBhbmRW
YXJyZWYgZW5kcyB1cCBzZXR0aW5nIEJCRklMRVMgdG8gc29tZSBhcHBlbmRlZCB2YWx1ZSB3aXRo
IExBWUVSRElSIGV4cGFuZGVkLCB0aGUgYXBwZW5kIHJlbWFpbnMgaW4gcGxhY2UuDQo+ID4gwqAg
wqAgwqAgRm9yIGV2ZXJ5IHN1YnNlcXVlbnRseSBwYXJzZWQgbGF5ZXIsIHRoZSBCQkZJTEVTIGVu
ZCB1cCBiZWluZyBhcHBlbmRlZCB3aXRoIGdpYmJlcmlzaCAoYmFzZWQgb24gaXRzIG93biBMQVlF
UkRJUikuDQo+ID4gwqAgwqAgwqAgRGVmaW5pdGVseSBub3QgaW50ZW5kZWQgYnkgdGhlIGF1dGhv
ci4NCj4gPg0KPiA+IFNvIG5vdyBJJ20gd29uZGVyaW5nIHdoYXQgdGhlIHNpdHVhdGlvbiBpcyBy
ZWFsbHkuIEFyZSB0aGUgYWJvdmUganVzdCBleGFtcGxlcyBvZiBiYWQgc3R5bGU/IFBlcmhhcHMg
aXQgd291bGQgYmUgd29ydGggaXQgdG8gZXh0ZW5kIHRoZSBkb2N1bWVudGF0aW9uIGZvciBMQVlF
UkRJUiB0eXBlIHZhcmlhYmxlcywgdG8gd2FybiBhYm91dCB0aGVpciBzcGVjaWFsIGhhbmRsaW5n
Pw0KPiA+IE15IGh1bmNoIGlzIHRoYXQgdGhpcyBpcyBhIGRlZmVjdCAoYXQgbGVhc3QgdGhlIGZh
Y3QsIHRoYXQgZXhwYW5kVmFycmVmIGlzIHVzZWQgdHJ1bHkgZHVyaW5nIHBhcnNpbmcsIGFuZCBz
ZXRWYXIgd2hpY2ggaXQgY2FsbHMgaXMgbm90IG5vdGlmaWVkIGFib3V0IGl0KS4NCj4gPiBJdCBj
YW4gYmUgZWFzaWx5IGNpcmN1bXZlbnRlZCBieSBhIHNpbXBsZSBpbmRpcmVjdGlvbiwgaS5lLiBw
bGFjaW5nIHRoZSBleHByZXNzaW9ucyB3aXRoIExBWUVSRElSIGluIHRoZW0gaW4gYSBzZXBhcmF0
ZSB2YXJpYWJsZSwgYW5kIHRoZW4gcmVmZXJlbmNpbmcgdGhpcyB2YXJpYWJsZS4gQnV0IHRoaXMg
ZmVlbHMgbGlrZSBhIGhhY2suDQo+ID4NCj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciBvcGlu
aW9ucy4NCj4gDQo+IEFzIHlvdSBoYXZlIHJlYWxpc2VkLCB0aGUgd2F5IHdlIGV4cGFuZCBMQVlF
UkRJUiBpbiBsYXllci5jb25mIGZpbGVzDQo+IGhhcyBkcmF3YmFja3MuIElkZWFsbHkgd2UnZCBm
aW5kIGEgZGlmZmVyZW50IG1lY2hhbmlzbSB0byBkbyBpdCB3aXRoDQo+IGxlc3Mgc2lkZSBlZmZl
Y3RzIGJ1dCBub2JvZHkgaGFzIGJlZW4gY29uY2VybmVkIGVub3VnaCB0byBkbyB0aGF0IGFzDQo+
IHlldC4gSXQgcHJvYmFibHkgaXMgd29ydGggb3BlbmluZyBhIGJ1ZyBmb3IgdGhlIGlzc3VlLg0K
PiANCj4gQXMgeW91J3ZlIG5vdGVkLCB3ZSBjYW4ndCBqdXN0IGFkZCB0aGUgcGFyc2luZyBwYXJh
bWV0ZXIgYXMgdGhhdCBqdXN0DQo+IGNhdXNlcyBhIGRpZmZlcmVudCBzZXQgb2YgcHJvYmxlbXMg
YW5kIHlvdSBzd2FwIG9uZSBzZXQgb2YgcHJvYmxlbXMgZm9yDQo+IGFub3RoZXIuDQo+IA0KPiBU
byBmaXggaXQgd2UgcmVhbGx5IG5lZWQgdG8gYXZvaWQgZXhwYW5kaW5nIGFueSB2YXJpYWJsZXMg
YXQgYWxsIGFuZA0KPiBqdXN0IGRvIGEgc2VhcmNoL3JlcGxhY2Ugb24gdGhlIHZhcmlhYmxlIGNv
bnRlbnRzLg0KPiANCj4gT3Igd2UgZHJvcCB0aGlzIGlkZWEgZW50aXJlbHkgYW5kIHVzZSBhIG5l
dyBjb252ZW50aW9uIGZvciBMQVlFUkRJUiwNCj4gbWF5YmUgY2hhbmdpbmcgdGhlIG5hbWUgdG8g
YmUgbGF5ZXIgc3BlY2lmaWMuDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBSaWNoYXJkDQoNClJlZ2Fy
ZGluZyBhIGxheWVyIHNwZWNpZmljIExBWUVSRElSLCB3ZSBkbyB0aGlzIGluIGxheWVyLmNvbmYg
Zm9yIGFsbCANCm91ciBsYXllcnM6DQoNCkJCRklMRV9DT0xMRUNUSU9OUyArPSAiZm9vYmFyIg0K
Li4uDQpMQVlFUkRJUl9mb29iYXIgOj0gIiR7TEFZRVJESVJ9Ig0KTEFZRVJESVJfZm9vYmFyW3Zh
cmRlcHZhbHVlXSA9ICIiDQoNClRoaXMgZ2l2ZXMgdXMgYSB3YXkgdG8gYWNjZXNzIGZpbGVzIGZy
b20gb25lIGxheWVyIGluIGFub3RoZXIgbGF5ZXIuIA0KDQovL1BldGVyDQoNCg==

