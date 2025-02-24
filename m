Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9613C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 12:55:56 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.74])
 by mx.groups.io with SMTP id smtpd.web10.87934.1740401754222467270
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Feb 2025 04:55:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=T9P3eqcQ;
 spf=pass (domain: siemens.com, ip: 40.107.20.74, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzR34lfZ8yvKrisSjvBYT4N8dEpIm+5RwadPSwxQtrNm7f2pwPCjhsbhmMpWjKCxRH+g1paVXANSwg1R0xvNzbIy/XVaoh9getZurm42ALe+gpv3ulx2UTR/fnGyAY4ujCjnj76+0e98zpzqKfp1yj3M5Zjg0fYX2e1tO2yzhgr6Knt1/OtdRhGU4KuiPqo1yeasLGUXOy4AAgSEE29fhOvQAtp2JrJFvzD5+lxIhmHxd20dQIMmgSgLUO5TpveCKZodridNAEh4pQrJfEEGYjrt+UGZowBgBBs2NqNkk6RPT4IZ7Q91wIT1m8/04MXXXoCVdHfVHDmYTcl3JtsBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM9etT+wcswAjLt84pl3Y3oqQOF6N355bop7dE2ywCw=;
 b=B6/CCy7VoPFrjmhGkjbuM90OizD1aSqqndSSh1ISOUkSN8l5+0uri/b/YyNXc3NG+Kvorqwwkqh5+JA4IUPr1mF+Az0Af9XaRevnHlwie86Se6cZ/E3tHWTnGtl5Jj5fnTsRkwWlqS6FzliJ04v2wtWITj98nBGFOCXKpHB+IVMevKGSD0HCvnTTdY6KiUZo8EY+2W9NBNDzYiO8lPYFzIP7UJFbtTnOpvaekvt2menMnM0QBkNRcqj6z+0+Z/FIsZc6F10kl11C/9gxoGjmNuxgIbyXgtiTiKLsb+Cv0Jz2khtxtzYifJAhdwJx/pyuBleZ+PWGK1VwAF6LtxQFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM9etT+wcswAjLt84pl3Y3oqQOF6N355bop7dE2ywCw=;
 b=T9P3eqcQbGrKK6ix4fK0JHgZ/jhKZxbuO10E8PNXPilTM4gQP+n5LJ/NY53APHoz3o2/FkJzFb/gESdsIKyr8WcSJa3xg9UOychcKOy003mv8f0ug0MQ8/CsVqgWNRuD+LidoB0htRqyta2YBiNtuXhgggesu3wkKKTYa5aGm41fWn2ixI+IAaXgyS1ZBkpkjoTBqnKZMuatfz77HzFCILkMnDYQmjJIO6KMTAdh/NrA53v2h9neouWHYQClorA5cgnH4LYcJGhRqb8NxVmp42ziSeDGygxo9IbSiQl04+1jhnpjO3EWBt24x6Bes4cICaMQID/agtNkJ+8deR81+g==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AM9PR10MB3990.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 12:55:50 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:55:50 +0000
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
Thread-Index: AQHbg7ywZJqt9JvQhESFPikUXBi+bLNWX0eAgAAQGoA=
Date: Mon, 24 Feb 2025 12:55:50 +0000
Message-ID: <e041fd346c069847c11899777503721d0dfaf952.camel@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
	 <D80NPDG5BAOJ.21VFGTXZZIRP5@bootlin.com>
In-Reply-To: <D80NPDG5BAOJ.21VFGTXZZIRP5@bootlin.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|AM9PR10MB3990:EE_
x-ms-office365-filtering-correlation-id: 74cb802d-9461-4361-2f8e-08dd54d290e1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?S1JCM1ZaY05RcGZURkVyYWo1WUpCblVoczdPZ2dMY3p6Q0JtaDd0UlpROVBX?=
 =?utf-8?B?TVVRN1JNYXgyZWNFUldCdEd0emdzRERaa3hqNjZQYW5BZGhHQ3N4djdFMGZK?=
 =?utf-8?B?WStiRk5SL1pVTWFsN3V3eUxHMXFkY2hqZTBnSXhnM2x4Um9XS0lKWWFqOGhD?=
 =?utf-8?B?Y3g3RFBxVHJRVVpkRlJaRDdMeXFKUUlqL2ZGaFIzRStOZnZ5V0RZRVA2MXB5?=
 =?utf-8?B?UHIyRnl1RFlBUUlGR1B3TlRHaGhZeXJMc0ljMSt2TVEvbWhDU1dxRHlTRk9Y?=
 =?utf-8?B?KzRmaC82U05uQStsWldQeHIxZDNPT05MMDdnbzhRYWVuYUtaazQ5Vk1ITXcr?=
 =?utf-8?B?djdablFZZXBNUC9zdExzd2VQcG9BZ0dEMml1eGc4QjJDZGVlaGtQRVBtRWox?=
 =?utf-8?B?K2w3VjM5Y2MxMyttbzVyeGZiRWRMcjkxYTNCMEg1blJxOC9qczNhV21FSDEy?=
 =?utf-8?B?a2NJZXh2bk9aSFJncjgrd1FqWWo5V2NjOWp1OFlnRUQ0eHQ5Qk80S2tjQzBP?=
 =?utf-8?B?YWV5Q2dqMXJmL0lERU9xVlNKSzRWaWRKVWt2SVRRYzlLdS9vZHpyUTVKY2t4?=
 =?utf-8?B?N2h3VUtwaUVUWDlTdHBsaWJHSmY0NVZ3Y08xM2N4d002NzVlcjlCRkVhYnBy?=
 =?utf-8?B?NDRoTVMvODNiV3JyR0FlMXlTaFRiMTBOOGtwYlV1enJzbWkvdlM1VEIvUkhP?=
 =?utf-8?B?UFQ3NkdHTDg1dTZIMk1XYzZ0bTZVOGIxbFFQdGp4cW9FR3BibzlhdlRVVW9W?=
 =?utf-8?B?ZGNIZG43SnF1NkkvUGRsbHdTbmlCZmdCdk1qZ2UydEJZc3h4MXkwRGY0d2pk?=
 =?utf-8?B?S1B0TThHWDdtNzQ0bWpVRUNLTjlMd0E2bnlTRFJCamFsWDFmRVNaMjRZNko4?=
 =?utf-8?B?ck1oV3ppNGJ0ZnBMZWRQVHUvcUlkRW9FVHRWQU1td2VDMk0rcjhBSUFqYzla?=
 =?utf-8?B?dEppdXZIMkRwM2M1UEFLRG9LUktaVWZKQUoyblFvSU5zUzBiL1VCVDZwU1A4?=
 =?utf-8?B?dnBsaC96d2tEcFRkSlg3ZFpuVC8zWndHMUJLQm1GTTFMaHZsZGl2MmZyQms3?=
 =?utf-8?B?WkxoVDFaWVUzNlRnRzBFbSswNnlwTVdINWdGczgvMkhHZGJDMjV2NCsydnRP?=
 =?utf-8?B?cVg4N2QrM01VRnNua1NRcTZtTzdYNm9raTd5czZpTDIzQjE3OHhoeXN0YXdV?=
 =?utf-8?B?YXgrZXFhay9Ra01vdlgwNVJ2YUExRHBkN3Z5d28rQ1ZmODQ4M1pjMk9BUUM0?=
 =?utf-8?B?c25YMjQwNHl3RURRSzNzSlFQditnbjhvWE5qQVFZSWFjYlVpbnZvWjVCTnUy?=
 =?utf-8?B?WlppdHpjQjc4R0NmbmNZcGNWT1IrUlNYNWRjcmN4ZFBEU1dKSHoyQTV6dVd3?=
 =?utf-8?B?M1R0eVEveHNObk0vUlNQaGIxRExOTXU3a1RuTVZUSjFlUHZGc09EN2xOKzMr?=
 =?utf-8?B?VGRwTkhiWWppVCsyWmpiaUFjT1RlYUoxOWkxeGRJOStYOW9CbCtteHZNbWRa?=
 =?utf-8?B?RkErcG91L09MaUFWWStDYzJOT3VTajMvVDhNTmd4WGRKQUI0ZUxhQkFQSkd6?=
 =?utf-8?B?a01zN0QyZS80SjJ2SXM3Z2xzRXl6a3liMFlUZ01TY2pXVmdvUy92Y05ISVNI?=
 =?utf-8?B?dS9zSmlWdW5FTnptNFZVaUNpbGU3dkkya051a1N6VldsMzlWYTFxZXdsL2NJ?=
 =?utf-8?B?ME9YWENRc2d3YWZhNEVLUUxDeG9nUkR1UEZWL1Z0V3U0UlliRE9pcys1dzJJ?=
 =?utf-8?B?c2RYNlZqRmY5aDJTS1ZVQWZXSzB6RWZPaTl1aTBobFNyS0hQOHRwVmk5d0xs?=
 =?utf-8?B?ay9zZ0ZkSkw0VC95SDd3TTRkM3FycDRCeTNTZ3dnWklhVjBEZTQ5REs2c1ph?=
 =?utf-8?Q?ZCnUZ+GQPfVMP?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UEl2aHVmb1Q5L040UEJORE9hQjZ6NUpicTJYNllEZnlWc0JidjRtZFg4QjVV?=
 =?utf-8?B?bnZBN0hhYWVweHRNZjlwTi96RHcrQ1ZXQlI4eUVnQzhjRDJiODZlV1kxRTY2?=
 =?utf-8?B?ZDRKMHpaRW1GRWU0SmpFNDRnYjlLUlNVQ0NzV01ycnJYYThiTjhTMXlnaVdt?=
 =?utf-8?B?WmplV0dGNlhLaUhwZ1h2RVg5N0dHbDFlckNCajl5MEtlWlV0YXJpWHpDRW9U?=
 =?utf-8?B?WUZBdUFLc3VkTitZYk44TDNuMWlpRjBFSzFyUEJ2TTlYYkVoVEprbFBVaCtz?=
 =?utf-8?B?cGdPb09ZbjdMaTZPNkowZlQ1RXVIdUYwRXNMdnRjeW5RaU96RjJGRGVyS0xk?=
 =?utf-8?B?M29DWTc4NGlqTldJWGpGVFJTSE05eDFaUGNvWE9SL2FzVW5CTFYrQkxucUhD?=
 =?utf-8?B?MlFRTlhLc2Qzb3pUWjhaMm9vYngvVTFrYkZvNW1mN05EaWVJMWJUMDRtaHlD?=
 =?utf-8?B?UVhSeDBvTTRlekNlK2R2RUM1Y3FJU2lKMlR4YWpuWkVXNmh3SS82Z2d3MURK?=
 =?utf-8?B?ckptOGNFb1ZKRlhBbDBqYXVDQS9wS0RqUkpsVElNdmR4Y1FZc0dOQXBsMEtN?=
 =?utf-8?B?OXgzRFNqSTArRWlESlpjYU1aOGlIc01MMWhvN2FDMTdkNVZISVRxT3N1bnpw?=
 =?utf-8?B?UU9OdXRoYXdhUy8veUpMYzltZk9QT0lPU2tqVkdSV2gvNDZFd0JObVJxZm05?=
 =?utf-8?B?cGM0OWNTdkdHQzFtUjZEaUJJY3BNNjJLdEMyKzRPNjZ5bE9ZNDVmSThLR09G?=
 =?utf-8?B?NjcyQXRBMFBGL29qcElWdEswQzlMZEpqanZVS2VqWnozcTBhbS9NaU1sSTVU?=
 =?utf-8?B?eUxhaXJraFVGWEJnODBoaG0xbmx6bU9hWGZVWjcza3JpT3M4N2Q1MHQ1c0lG?=
 =?utf-8?B?Zzc4VU5IZjdlcklnSnpDL2VKdVQ2Yjh2Tmp6VlpNZ0NhSTNiWHlUNGJ5cnZ0?=
 =?utf-8?B?YmpYcFlZeGRvNnZ3U0xhaEtvQ2tteWs5ODNNaDZ6V1cxb0tMaGg1ZEY1cUdi?=
 =?utf-8?B?TEwvbEljVUg0NFpvS2JMRS8zQm5lMGNBcUs5VmF1cGc0RlVBZUZ6WWt6WnVS?=
 =?utf-8?B?eVpINWRVVGJFM3dlUElUWkpiUG8yb1ZKUVZ6NkRFTlBPZWRMRzQ0bUd4bTlZ?=
 =?utf-8?B?UWd0aFlhVUhHR2dCNmllS3lwZmJneVMyT2FOcml1TkZCb2dmVTk3NHI5aFNh?=
 =?utf-8?B?M3dXaWh4ekhBTzlvR28wTkFkMjB4dko0eGRYZmZMWW16aGVxSFlOeC9hQlRU?=
 =?utf-8?B?VnJRYjFUaE1udGlGOXRtL3RsN3NOQlpVQUVURFhZZUlqK3dRL29kSkw0amJL?=
 =?utf-8?B?c0VERWZvdHhYZ0tsa081azlFTHRFcDNqUjI3MktOV0JGem1xd1o2MnVxRmtL?=
 =?utf-8?B?b3Z1eUhYKytOc05OR2R6Q1BrZHQrOFpPZUkweGtsd0NvV1NjSy95OFJCakIr?=
 =?utf-8?B?V0ZNVXlUSytVZ0xoOG8raUpaakNTNmZBWWJuWStjOXdaUjE5Y0o5bmZKNTBH?=
 =?utf-8?B?dDd2RXJWV0o1V0hWS2dqQWk4ZE8rYWhQT240UThOWkgwRHVJeVlRMnhFd3lB?=
 =?utf-8?B?aXhSU0VHbjQzM0puVmFJNUl5anErSWdnL0VueVlOWWJKK3MzNU1ncC9DdTQ0?=
 =?utf-8?B?UE9zSTd6UVFtcmw0ZllQTTRYUFhwSW8rRHMvcFZFQnVFRVNuZ29uOVhhcU56?=
 =?utf-8?B?eUNidTltNmNhemF3cU9LOWVTemtnM2taOS9OeW9GVTBLNnpKVFRNbVRqcnpS?=
 =?utf-8?B?aHFSNzlsTkIwQ0VpSEo1aUd3WStpbEtSKzRNSzltT2VCQ0gxQ0t3blZ5L3U4?=
 =?utf-8?B?YThaNW9iTW52UGZ4VnZwZUxIRThQb2IxUEZlZlA1QWRWcnpmL0ZGWVY4VTV5?=
 =?utf-8?B?TkZDdlkzMVBabGVVTVVLV0JuQkdKRkZnZTFRQW12ZEtYKyttWkpkZVdMeUtV?=
 =?utf-8?B?VjVHY282MkY1NVltOWtCL0RydDVlb2paMjN6M3pHc1hVWG4wZHN0Y2NrZE9S?=
 =?utf-8?B?eVkxZnhXZDAveWJVdVZ6RlFaU0R6TE1WV2tTVnlXNVk4amVJNFVWbFVzblRq?=
 =?utf-8?B?TllMS0swTWFGcStDeVpnOVg1MkNLTDFMQTBMVTExakNhQitnMU8zZTMvYXhr?=
 =?utf-8?B?d2lER3lmUTRiS1hsWk1aZlhYWWRvWDJVZEFuRVhXYVdORjFwZUxoQVhaRUlq?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7832CCC9DD96244E88C6BE7E5ECD1BBC@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cb802d-9461-4361-2f8e-08dd54d290e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 12:55:50.6603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtFYnXeDhJbA3glLpjg8zYRu7EpV9ucYRWkTBDziyVgd8QNpfd1bsgP6O5K0SZRn4aK6l51mzUoA128nXnWONw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB3990
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Feb 2025 12:55:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17294

T24gTW9uLCAyMDI1LTAyLTI0IGF0IDEyOjU4ICswMTAwLCBNYXRoaWV1IER1Ym9pcy1CcmlhbmQg
d3JvdGU6DQo+IE9uIFRodSBGZWIgMjAsIDIwMjUgYXQgNjoyNyBQTSBDRVQsIFN0ZWZhbiB2aWEg
bGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBLb2NoIHdyb3RlOg0KPiA+IFdoZW4gYHVkLnNoYWxs
b3cgPT0gMWA6DQo+ID4gLSBQcmVmZXIgYW4gaW5pdGlhbCBzaGFsbG93IGNsb25lIG92ZXIgYW4g
aW5pdGlhbCBmdWxsIGJhcmUgY2xvbmUsDQo+ID4gICB3aGlsZSBzdGlsbCB1dGlsaXppbmcgYW55
IGFscmVhZHkgZXhpc3RpbmcgZnVsbCBiYXJlIGNsb25lcy4NCj4gPg0KPiA+IFRoaXMgaW1wcm92
ZXM6DQo+ID4gLSBSZXNvbHZlIHRpbWVvdXQgaXNzdWVzIGR1cmluZyBpbml0aWFsIGNsb25lcyBv
biBzbG93IGludGVybmV0DQo+ID4gY29ubmVjdGlvbnMNCj4gPiAgIGJ5IHJlZHVjaW5nIHRoZSBh
bW91bnQgb2YgZGF0YSB0cmFuc2ZlcnJlZC4NCj4gPiAtIEVsaW1pbmF0ZSB0aGUgbmVlZCB0byB1
c2UgYW4gSFRUUFMgdGFyYmFsbCBgU1JDX1VSSWANCj4gPiAgIHRvIHJlZHVjZSBkYXRhIHRyYW5z
ZmVyLg0KPiA+IC0gQWxsb3cgU1NILWJhc2VkIGF1dGhlbnRpY2F0aW9uIChlLmcuIGNlcnQgYW5k
IGFnZW50LWJhc2VkKSB3aGVuDQo+ID4gICB1c2luZyBub24tcHVibGljIHJlcG9zLCBzbyBhZGRp
dGlvbmFsIEhUVFBTIHRva2VucyBtYXkgbm90IGJlDQo+ID4gcmVxdWlyZWQuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTdGVmYW4gS29jaCA8c3RlZmFuLWtvY2hAc2llbWVucy5jb20+DQo+ID4g
LS0tDQo+DQo+IEhpIFN0ZWZhbiwNCj4NCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KPg0KPiBX
ZSBnb3QgYSBuZXcgZmFpbHVyZSBvbiB0aGUgYXV0b2J1aWxkZXIsIHNwZWNpZmljYWxseSB3aXRo
IHRoZQ0KPiBvZS1zZWxmdGVzdC11YnVudHUgYnVpbGQuIEknbSBub3QgZW50aXJlbHkgc3VyZSB0
aGlzIGNvbWVzIGZyb20gdGhpcw0KPiBzZXJpZXMsIHNvIEkgd2lsbCB0cnkgYSBidWlsZCB3aXRo
b3V0IGl0IHRvIGNvbmZpcm0uDQo+DQo+IEhlcmUgaXMgdGhlIGVycm9yOg0KPg0KPiBOT1RFOiBS
dW5uaW5nIHRhc2sgMiBvZiA0ICgvc3J2L3Bva3lidWlsZC95b2N0by13b3JrZXIvb2Utc2VsZnRl
c3QtDQo+IHVidW50dS9idWlsZC9idWlsZC1zdC0zNTAyOTQzL21ldGEtc2VsZnRlc3QvcmVjaXBl
cy10ZXN0L2dpdC0NCj4gc3VibW9kdWxlLXRlc3QvZ2l0LXN1Ym1vZHVsZS10ZXN0LmJiOmRvX2Zl
dGNoKQ0KPiBOT1RFOiByZWNpcGUgZ2l0LXN1Ym1vZHVsZS10ZXN0LTEuMC1yMDogdGFzayBkb19m
ZXRjaDogU3RhcnRlZA0KPiBXQVJOSU5HOiBnaXQtc3VibW9kdWxlLXRlc3QtMS4wLXIwIGRvX2Zl
dGNoOiBDcmVhdGluZyBmYXN0IGluaXRpYWwNCj4gc2hhbGxvdyBjbG9uZSBmYWlsZWQsIHRyeSBp
bml0aWFsIHJlZ3VsYXIgY2xvbmUgbm93Lg0KPiBXQVJOSU5HOiBnaXQtc3VibW9kdWxlLXRlc3Qt
MS4wLXIwIGRvX2ZldGNoOiBGYWlsZWQgdG8gZmV0Y2ggVVJMDQo+IGdpdHNtOi8vZ2l0Lm9wZW5l
bWJlZGRlZC5vcmcvYml0YmFrZTtwcm90b2NvbD1naXQ7bmFtZT1iaXRiYWtlO3N1YnBhdA0KPiBo
PWJpdGJha2U7bm9icmFuY2g9MTtsZnM9RmFsc2U7YmFyZWNsb25lPTE7bm9icmFuY2g9MSwgYXR0
ZW1wdGluZw0KPiBNSVJST1JTIGlmIGF2YWlsYWJsZQ0KPiBFUlJPUjogZ2l0LXN1Ym1vZHVsZS10
ZXN0LTEuMC1yMCBkb19mZXRjaDogRmV0Y2hlciBmYWlsdXJlOiBGZXRjaA0KPiBjb21tYW5kIGV4
cG9ydCBQU0VVRE9fRElTQUJMRUQ9MTsgZXhwb3J0IFBBVEg9Ii9zcnYvcG9reWJ1aWxkL3lvY3Rv
LQ0KPiB3b3JrZXIvb2Utc2VsZnRlc3QtdWJ1bnR1L2J1aWxkL2J1aWxkLXN0LTM1MDI5NDMvdG1w
L3N5c3Jvb3RzLQ0KPiB1bmluYXRpdmUveDg2XzY0LWxpbnV4L3Vzci9iaW46L3Nydi9wb2t5YnVp
bGQveW9jdG8td29ya2VyL29lLQ0KPiBzZWxmdGVzdC11YnVudHUvYnVpbGQvc2NyaXB0czovc3J2
L3Bva3lidWlsZC95b2N0by13b3JrZXIvb2UtDQo+IHNlbGZ0ZXN0LXVidW50dS9idWlsZC9idWls
ZC1zdC0zNTAyOTQzL3RtcC93b3JrL2NvcmUyLTY0LXBva3ktDQo+IGxpbnV4L2dpdC1zdWJtb2R1
bGUtdGVzdC8xLjAvcmVjaXBlLXN5c3Jvb3QtbmF0aXZlL3Vzci9iaW4veDg2XzY0LQ0KPiBwb2t5
LWxpbnV4Oi9zcnYvcG9reWJ1aWxkL3lvY3RvLXdvcmtlci9vZS1zZWxmdGVzdC0NCj4gdWJ1bnR1
L2J1aWxkL2J1aWxkLXN0LTM1MDI5NDMvdG1wL3dvcmsvY29yZTItNjQtcG9reS1saW51eC9naXQt
DQo+IHN1Ym1vZHVsZS10ZXN0LzEuMC9yZWNpcGUtDQo+IHN5c3Jvb3QvdXNyL2Jpbi9jcm9zc3Nj
cmlwdHM6L3Nydi9wb2t5YnVpbGQveW9jdG8td29ya2VyL29lLXNlbGZ0ZXN0LQ0KPiB1YnVudHUv
YnVpbGQvYnVpbGQtc3QtMzUwMjk0My90bXAvd29yay9jb3JlMi02NC1wb2t5LWxpbnV4L2dpdC0N
Cj4gc3VibW9kdWxlLXRlc3QvMS4wL3JlY2lwZS1zeXNyb290LQ0KPiBuYXRpdmUvdXNyL3NiaW46
L3Nydi9wb2t5YnVpbGQveW9jdG8td29ya2VyL29lLXNlbGZ0ZXN0LQ0KPiB1YnVudHUvYnVpbGQv
YnVpbGQtc3QtMzUwMjk0My90bXAvd29yay9jb3JlMi02NC1wb2t5LWxpbnV4L2dpdC0NCj4gc3Vi
bW9kdWxlLXRlc3QvMS4wL3JlY2lwZS1zeXNyb290LQ0KPiBuYXRpdmUvdXNyL2Jpbjovc3J2L3Bv
a3lidWlsZC95b2N0by13b3JrZXIvb2Utc2VsZnRlc3QtDQo+IHVidW50dS9idWlsZC9idWlsZC1z
dC0zNTAyOTQzL3RtcC93b3JrL2NvcmUyLTY0LXBva3ktbGludXgvZ2l0LQ0KPiBzdWJtb2R1bGUt
dGVzdC8xLjAvcmVjaXBlLXN5c3Jvb3QtbmF0aXZlL3NiaW46L3Nydi9wb2t5YnVpbGQveW9jdG8t
DQo+IHdvcmtlci9vZS1zZWxmdGVzdC11YnVudHUvYnVpbGQvYnVpbGQtc3QtMzUwMjk0My90bXAv
d29yay9jb3JlMi02NC0NCj4gcG9reS1saW51eC9naXQtc3VibW9kdWxlLXRlc3QvMS4wL3JlY2lw
ZS1zeXNyb290LQ0KPiBuYXRpdmUvYmluOi9zcnYvcG9reWJ1aWxkL3lvY3RvLXdvcmtlci9vZS1z
ZWxmdGVzdC0NCj4gdWJ1bnR1L2J1aWxkL2JpdGJha2UvYmluOi9zcnYvcG9reWJ1aWxkL3lvY3Rv
LXdvcmtlci9vZS1zZWxmdGVzdC0NCj4gdWJ1bnR1L2J1aWxkL2J1aWxkLXN0LTM1MDI5NDMvdG1w
L2hvc3R0b29scyI7IGV4cG9ydA0KPiBIT01FPSIvc3J2L3Bva3lidWlsZCI7IGdpdCAtYyBnYy5h
dXRvRGV0YWNoPWZhbHNlIC1jIGNvcmUucGFnZXI9Y2F0IC0NCj4gYyBzYWZlLmJhcmVSZXBvc2l0
b3J5PWFsbCAtYyBjbG9uZS5kZWZhdWx0UmVtb3RlTmFtZT1vcmlnaW4gZmV0Y2gNCj4gb3JpZ2lu
IDUyYTE0NGE3ZGFhOTRiMmJkMjM5ZDU4MmNiNzFkMWYwMzExOTkxOGYgLS1kZXB0aCAxIGZhaWxl
ZCB3aXRoDQo+IGV4aXQgY29kZSAxLCBvdXRwdXQ6DQo+IGVycm9yOiBTZXJ2ZXIgZG9lcyBub3Qg
YWxsb3cgcmVxdWVzdCBmb3IgdW5hZHZlcnRpc2VkIG9iamVjdA0KPiA1MmExNDRhN2RhYTk0YjJi
ZDIzOWQ1ODJjYjcxZDFmMDMxMTk5MThmDQo+DQo+IGh0dHBzOi8vYXV0b2J1aWxkZXIueW9jdG9w
cm9qZWN0Lm9yZy92YWxreXJpZS8jL2J1aWxkZXJzLzU0L2J1aWxkcy8xMDMxL3N0ZXBzLzE0L2xv
Z3Mvc3RkaW8NCj4NCj4gQ2FuIHlvdSBoYXZlIGEgbG9vayBhdCB0aGlzIGlzc3VlIHBsZWFzZT8N
CkRvIHlvdSB1c2luZyAxNzE2YWQ2N2JiZTlmNGNlY2YxZTNiY2ZjMjAwN2IxNTBiYTc3NzQxIGZy
b20gYml0YmFrZXMNCm1hc3Rlci1uZXh0IGJyYW5jaD8gQmVjYXVzZSB0aGF0IGlzIFBBVENIIHYy
IHdpdGggdGhhdCBpc3N1ZSBzcGVjaWFsbHkNCm9uIHVidW50dSAyMC4wNC4uLg0KPg0KDQotLQ0K
U3RlZmFuIEtvY2gNClNpZW1lbnMgQUcNCmh0dHA6Ly93d3cuc2llbWVucy5jb20vDQo=

