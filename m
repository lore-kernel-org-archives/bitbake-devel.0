Return-Path: <pascal.eberhard@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C388A106ACEC
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 21:48:04 +0000 (UTC)
Received: from de-smtp-delivery-123.mimecast.com (de-smtp-delivery-123.mimecast.com [194.104.109.123])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2156.1773352074573140833
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Mar 2026 14:47:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@se.com header.s=mimecast20240503 header.b=KwZqr/tg;
 spf=pass (domain: se.com, ip: 194.104.109.123, mailfrom: pascal.eberhard@se.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=se.com; s=mimecast20240503;
	t=1773352073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uP//QztBHMGso393wo3CgYFvW2UneuY8kvItKj0UZMA=;
	b=KwZqr/tgTLn4YslIt87PvVoELQ11z6Kq5ziO5RGqSd8lPrppGdILLnohD4steli3VV5+4X
	/jTc5zgVwjXKzrcT492iA0RdAgSD9SD2KnlSorvvmjG6yrqHXA7acx0IjPhfYLtla8zwpk
	gHxn5Y3zehvFRFrJZ8IctUTHiBVEUcYb1+HdFfe8C5UR+WkE30OrU4amxWLtTCFjPI+S7g
	w8BNSb4t8FgLT0sGgQhHKLQgjzE/gaXlxJEJVG6Y9dr03QvEYXwhLBDdX/J+rnYOfw7RxI
	YQ/P0XuIr6FgYHX/0418OVPmB6+gjzqiJm8/9tSTgiB8R7InQLWL0bWCNubKag==
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013008.outbound.protection.outlook.com
 [52.101.83.8]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-79-f3xqxnwzPVWRtJbgIQ7oWg-1; Thu, 12 Mar 2026 22:47:50 +0100
X-MC-Unique: f3xqxnwzPVWRtJbgIQ7oWg-1
X-Mimecast-MFC-AGG-ID: f3xqxnwzPVWRtJbgIQ7oWg_1773352070
Received: from DU0PR04MB9657.eurprd04.prod.outlook.com (2603:10a6:10:31c::22)
 by VI0PR04MB10901.eurprd04.prod.outlook.com (2603:10a6:800:267::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 21:47:42 +0000
Received: from DU0PR04MB9657.eurprd04.prod.outlook.com
 ([fe80::fba9:66b3:49ad:de2c]) by DU0PR04MB9657.eurprd04.prod.outlook.com
 ([fe80::fba9:66b3:49ad:de2c%6]) with mapi id 15.20.9678.023; Thu, 12 Mar 2026
 21:47:48 +0000
From: Pascal EBERHARD <pascal.eberhard@se.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH v2 0/4] fetch2: add alternative fetch
 method based on curl
Thread-Topic: [bitbake-devel] [PATCH v2 0/4] fetch2: add alternative fetch
 method based on curl
Thread-Index: AQHcsBzrhbjFDQGo7UOKNTm7Xu+nrbWqyAMAgACniLU=
Date: Thu, 12 Mar 2026 21:47:48 +0000
Message-ID: <DU0PR04MB9657D2875055B5850A5FD90E8E44A@DU0PR04MB9657.eurprd04.prod.outlook.com>
References: <20260310-add_alt_fetch_method_curl-v2-0-4789639b28f1@se.com>
 <e5911b86ad67a0341afa4e811fcb7dede1c8c9eb.camel@linuxfoundation.org>
In-Reply-To: <e5911b86ad67a0341afa4e811fcb7dede1c8c9eb.camel@linuxfoundation.org>
Accept-Language: fr-FR, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_Enabled=True;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_SiteId=6e51e1ad-c54b-4b39-b598-0ffe9ae68fef;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_SetDate=2026-03-12T21:47:47.874Z;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_Name=General;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_ContentBits=1;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9657:EE_|VI0PR04MB10901:EE_
x-ms-office365-filtering-correlation-id: 23c83681-25d6-4366-4fed-08de808100b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|38070700021
x-microsoft-antispam-message-info: 4ftInzIq/Yc3/FkzDOwjzZINpXfQLkr+saQdZuRh6nGWlTKC9Rna1hGeUwbLTmR6fbCa6hb+uft6Zt/bSua/2j5tRi3b03ujOyXvHY7j7xf+8Q3pc8i65rOPHegFYdC+ETEcylEqCZla/6k++2abO/VieJ6Psql4WD+2ANwHCDZCCozWIrQ8VtU0yEqtmyxUmlaXL+cYjP50ASAgLW42GVx8k1Hg/SJQ2Y6yXynlVQaKgKOO0hHigXlQQsCX48VpEXvd/hosfsgTlaT11ZveiJkhChRv9mLDAhKj9jHZqQAJLlzj9TOGy3pej1Wvddr/zcfEAkWKe2ReenTGZKmEpC4UlnTzGGbfz3+saXaWHIrqhUzjXcy+RCk1/Xpz6V1M0QivqZYus1d5QeoVl0+7Mw6rlEvlynIt4eIZbT9O+z0hq1z8AkD+P3M3Nckszk74Fwffa1F1JJup2S6z7KVolJ9U+55/ID2kXXAeTFZoT/ABlB7Iu2syGi6z40FIHMEfoMp2nMtxZ7KyNpbm+i7u01+8zuwBoofDIAaxbbDDCuHCLGGbv97e7OqMQUfx9iYvNR1gwgpirHuv412H7xA9qUG+T6kkH18T1rNWOmLy8VUSZ4m1qbQH0gcutxYEAGZFReBkiVih6IiHweJwu8iIeov+VPhAfBjS329sfIbF8mkuVIXbC5kwhR46/pLlhk7GSpls1xF48yG3tri5skhR0ghFiKo2TMy095mJZiJJkEUkW0OXc8xtJp9Ect86X5QJgNWmNZXi+ZCnrudfHQhrrpXPyWjXBN7OgF9Rer2JyK0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9657.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWRuT041Z2YxSG0zK3huVmtvQW1oMmk3K0lVOXR2ZGRrcTlhREh4QktPUGFY?=
 =?utf-8?B?a1ArbG9Rc1d2UlVEc09NOXVldDEyV0JOZ0J0WjBuVzJMbXRGcjdRWGUreEFL?=
 =?utf-8?B?cWxXSmJidURxd2h0cFMwZkNFMTRuaUhwN25XOXYwUHk2TGY3N0NzSUVEMjho?=
 =?utf-8?B?K3R0aEFSVnFTU1ZHZkdWMHRIcDJXUHFXQVB3V2dRUVFnVWZQWXArZjBMSFFP?=
 =?utf-8?B?OEtQNEhUdldzK25XWk5UM2xSMjdkdjBYVm9OcmQ1TkI0aW9SLysrZnBEVzNz?=
 =?utf-8?B?UUN6UkRMQldZbHZlWFd5MlhOdE1UdnB1cFh0b1hkY2MzY1hGa2x6UG1qVDdX?=
 =?utf-8?B?bU5WaFZYblFUdHBKa01rbmVybUZSZDF2c2sxVzV2NnQyQk1rZXpGeHZtMU1F?=
 =?utf-8?B?YzJXY1B3dXJ2SGNkVkdvbmM0bzVzR1lScWY1WGd3R0d4NFNkNTFkdHM3V1A3?=
 =?utf-8?B?V2pSNi9XSmRlM3lISEdxZjZKL0R6bnZNT00zcUwwNy9pOUJjemMvTmtYQ0E1?=
 =?utf-8?B?VDMwbWFqQ0VvbGZYRWp1YkEwUTEvQmJhOTRwNlRmSGpOd2MrdkRWbDhvLzd1?=
 =?utf-8?B?bXJYWWxacU4rLzdtUWM5eUlBQUxBTGNSMmE3YmVFQzNyWFBCYS90QmtDNUFH?=
 =?utf-8?B?Uy9kNmgvVnVySW5hSVFtdVorcmxHdkpRWlMzTi9JZmthM0NiMDhsSXRLVlEv?=
 =?utf-8?B?eHhPMjZaa2RseHMzZVpwalZPbnZGRGZ5QjgvNGVyT1QycU9DWURtR2hmL1Yy?=
 =?utf-8?B?eHhqOFkvcm04dEVJVmg4M0NSUkJqdGRlWkZPYXJxc0lFNFpUc3diUExITFA1?=
 =?utf-8?B?V3ZkSWMyUnltTjIzUXM2Y2s0OVlaYXgrdDNjOWJKYlFZbUZYN3h5Y2wzQUN5?=
 =?utf-8?B?aEVhV3NzMGMycmtuMERTS09zRk9OT1VHWGF1eGtuOUdOcUhOYXFMOEtYT0Jv?=
 =?utf-8?B?VXh2V3lMY1ZzSnN6UnpsOEd5Mzd3WW1VZ2UrMm9HcTNUaDVvUjRJWlVVNjgy?=
 =?utf-8?B?YmJEaWp4eUk4WEJ1bzNFeU1MTnFBa0kwY204akRtK1lIdldsTmZIT2VCd2Zo?=
 =?utf-8?B?c2YxYmxqaE1FK2hwajRVSjZYR0UwR0licEt0bzZuUThBWUJUZlpGUmdha0hp?=
 =?utf-8?B?YVAxWU9IWm5zNXlHNFVGaG8yZno1Q3pES3BrUUF1WFBmU3MwYllucFdwSzh5?=
 =?utf-8?B?QmVEY0lCK3FzK2NRWmp2SkpUREFuSkNqV1Y5Z0Fub1N4N3JjOEw4REUwOXpo?=
 =?utf-8?B?U3NnUkhSKzFocXZTb1FXNFJmQXBYZ1k1VFpPTlU1b2FWRVZZY0Y1RzE1NnVs?=
 =?utf-8?B?UmJITlllZ0h5Sk9RdkdYc1lWaEh0cjJFalNFTUQ3ZSt6VXpSaThSSmFiYVpL?=
 =?utf-8?B?WGpqVnZhV0hxeTl0QXJ0bzhHb3czbjJrek9IZTB3Y1haRFFaOGhkTjdKS0lh?=
 =?utf-8?B?Ty8zcGxOcjBwMTFEeVVYd3VpNWtCdFo3VGdudHAxU0ZqR1dXenBkT3pRUGFR?=
 =?utf-8?B?MnNQZk5FckQ3bjBiVkxhdXJzdTV2NVR1Vzd2UDZaR2tML0ZhY0NxY0o2L3gy?=
 =?utf-8?B?OXVQQnRma2dublFqd245TWNIYnMvTWNxMjZmck1zQ2psVjFTY3crQUhHbERk?=
 =?utf-8?B?K1RSS2xQNXB3dW5CajhLQWZNWmcvYzhBcWhwNDRRTTdFUTNQbTJMeTRzSytv?=
 =?utf-8?B?SlhRR0kyU2E2TFROMjJieUNsZENDU3cyU3VBV1A5L3BRbjNScVRKQ0U0eEpq?=
 =?utf-8?B?am1pNWh4bEIrUjVjU1REYVd5RWlRRnhOWHZNendlVU1GbUpGUHlvRGJKVm1s?=
 =?utf-8?B?anE5bHhZNWQ4RDB6NXVmVy9OS2gwK1hCa2g5bTZWc1Z2eDJEbU56VFVkVzNE?=
 =?utf-8?B?djZEdk1US29EQTBqY0F4cHZyNjcxbXJ6MFloMysreGhPUklFcFdnMmlRQmhx?=
 =?utf-8?B?bFFVUTNzNVdFS0o2OTZYVldvS0gwYUEyR1V1RlUwS20ybFljSmhTSTNsY0F1?=
 =?utf-8?B?cWhLU2NnaFhlSFFZc0FBNkdTQWErSU0wdTBHbjFMVVhxU2tUdjlWSzA4a2ZD?=
 =?utf-8?B?NnRqcmZ2bkQrOVMyMHpqeXYvUW1HZ3Y5SjF3RzcyYVA0eTQ3WkltV1plWVl1?=
 =?utf-8?B?dUJmV0Q3NXJsSmNoOTMvS2crVVkrV2pzZmNWblYwSU5UMXZzSXpNUHYzYSsz?=
 =?utf-8?B?eTBkQ2FySWZtVFoyeWJOQnZ0MjZzemZkM1dncEF4YUFBaEgzQUJGMWkrSy9P?=
 =?utf-8?B?QTYrOG1WK21UVW9NRW92Z3doaWlINyt6MC90TXE2SXhlczM5UnBRNXk2R0gx?=
 =?utf-8?Q?duaBvu/3YI8mWSEtMH?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kehHSW/r32uNdFkFeldan9irvodbUbp+8GCQBTguZH7wqPzZH5Te1DYpTjltpGgwquy6T7bJEH1YO2W2D6jAhfZhSqMhX3U0/n5mxpAWvFYz2muZCti26GTMUIJdLA43CFHeyGe1wJbzrG0l6FcVypIwMfd0HNGUj6jpX2cujuAkQhx1NsX3faHeFW3nD2LOo/L0PVqDUYAoEbHotvAXJjmSgn2aEcvjk1bM9BYeUBmjAnlTv4YG1VOQMqlJubn4ccRfJ5gmYHRrRFUXdO8cmvBwUV+BL43mxyVLS1ageWClgkk1VcN2k6j5yUf0bHpj+akSjgkAeSIFERqWX32N8w==
X-OriginatorOrg: se.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9657.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c83681-25d6-4366-4fed-08de808100b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 21:47:48.4181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e51e1ad-c54b-4b39-b598-0ffe9ae68fef
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3ht/nstqGoYu81sws70OULdwishLFBX6CKM3sJkOo3v6KwELABHQ/0T0YA7o/jGYtH/vFWNMsHB7OpcAE4LgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10901
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EQILVdkSRVhSFbGu-eFXRxv_BzhMP24XDSt4EP7nklg_1773352070
X-Mimecast-Originator: se.com
Content-Language: fr-FR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Mar 2026 21:48:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19151

T24gVGh1LCBNYXIgMTIsIDIwMjYgYXQgMTI6MzTigK9SaWNoYXJkIFB1cmRpZSA8cmljaGFyZC5w
dXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cgo+IEhpIFBhc2NhbCwKCkhpIFJpY2hh
cmQsCgo+IE9uIFR1ZSwgMjAyNi0wMy0xMCBhdCAwMDoyOSArMDEwMCwgUGFzY2FsIEViZXJoYXJk
IHZpYSBCNCBSZWxheSB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9yZyB3cm90ZToKPiA+IHdnZXQg
ZmV0Y2ggbWV0aG9kIGlzIHVzZWQgZm9yIHdlYiBkb3dubG9hZHMgd2l0aCBodHRwLCBodHRwcywg
ZnRwLCBmdHBzCj4gPiBwcm90b2NvbHMuIHdnZXQgY21kbGluZSB0b29sIGlzIG1pc3Npbmcgc29t
ZSBmZWF0dXJlcyBzdWNoIGFzIGhvc3RuYW1lCj4gPiByZXNvbHV0aW9uIGJ5IHRoZSBwcm94eSB3
aGVuIHVzaW5nIFNPQ0tTNSBwcm94eS4gU1NIIHR1bm5lbCBwcm92aWRlcwo+ID4gdGhpcyBmZWF0
dXJlIGZvciBleGFtcGxlLgo+ID4KPiA+IFRoaXMgY3VybCBmZXRjaCBtZXRob2QgaXMgYmFzZWQg
b24gY3VybCBjbWRsaW5lIHRvb2wgYW5kIHByb3ZpZGVzIHRoZQo+ID4gc2FtZSBwcm90b2NvbHMg
YXMgd2dldCBhbmQgc3VwcG9ydHMgU09DS1M1IGhvc3RuYW1lIHJlc29sdXRpb24uCj4gPiBUaGlz
IGNsYXNzIGluaGVyaXRzIHdnZXQgbWV0aG9kIGluIG9yZGVyIHRvIGF2b2lkIGNvZGUgZHVwbGlj
YXRpb24gYXMKPiA+IG11Y2ggYXMgcG9zc2libGUuCj4gPgo+ID4gd2dldCByZW1haW5zIHRoZSBk
ZWZhdWx0IGRvd25sb2FkIG1ldGhvZC4gY3VybCBmZXRjaCBtZXRob2QgY2FuIGJlCj4gPiBlbmFi
bGVkIGJ5IHNldHRpbmcgYSBuZXcgYml0YmFrZSB2YXJpYWJsZToKPiA+IMKgIEJCX0ZFVENIX01F
VEhPRF9IVFRQID0gImN1cmwiCj4gPgo+ID4gVGhlIGhvc3RuYW1lIHJlc29sdXRpb24gYnkgU09D
S1M1IHByb3h5IGlzIGFjdGl2YXRlZCBieSBzZXR0aW5nCj4gPiBlbnZpcm9ubWVudCB2YXJpYWJs
ZToKPiA+IMKgIGFsbF9wcm94eT0ic29ja3M1aDovLy4uLiIiCj4gPgo+ID4gYSBwYXRjaCBvbiBj
ZS1jb3JlIHdpbGwgYmUgc2VudCBpZiB0aGlzIHByb3Bvc2FsIGlzIGFjY2VwdGVkIHRvCj4gPiBj
b25kaXRpb25uYWx5IGFkZCBjdXJsIHRvIEhPU1RUT09MUyB2YXJpYWJsZSBpbiBtZXRhL2NvbmYv
Yml0YmFrZS5jb25mOgo+ID4gSE9TVFRPT0xTICs9ICIke0BiYi51dGlscy5jb250YWlucygnQkJf
RkVUQ0hfTUVUSE9EX0hUVFAnLCAnY3VybCcsICdjdXJsJywnJywgZCl9Igo+ID4KPiA+IFNpZ25l
ZC1vZmYtYnk6IFBhc2NhbCBFYmVyaGFyZCA8cGFzY2FsLmViZXJoYXJkQHNlLmNvbT4KPiA+IC0t
LQo+ID4gQ2hhbmdlcyBpbiB2MjoKPiA+IC0gcmVtb3ZlZCB0eXBlIGhpbnQgdW5pb25zIGFuZCB0
ZXN0ZWQgd2l0aCBQeXRob24gMy45LCB0aGFua3MgTWF0aGlldQo+ID4gwqAgRHVib2lzLUJyaWFu
ZCBmb3IgcmVwb3J0aW5nIHRoaXMuCj4gPiAtIGN1cmwgdGVzdHMgYXJlIG5vdyBza2lwcGVkIHdo
ZW4gY3VybCBjbWRsaW5lIHRvb2wgaXMgbm90IGZvdW5kLgo+ID4gLSBMaW5rIHRvIHYxOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYwMzA1LWFkZF9hbHRfZmV0Y2hfbWV0aG9kX2N1cmwt
djEtMC0wZDAyMjBlNWZhNTlAc2UuY29tCj4gCj4gV2UgZGlzY3Vzc2VkIHRoaXMgdG9kYXkgYSBi
aXQgb24gdGhlIHJldmlldyBjYWxsIGFuZCB3ZSdyZSBhbGwgdmVyeQo+IG5lcnZvdXMgYWJvdXQg
dGhpcyBjaGFuZ2UuCj4gCj4gT25lIG9mIG91ciBndWlkaW5nIHByaW5jaXBsZXMgaXMgbm90IHRv
IGhhdmUgbXVsdGlwbGUgd2F5cyBvZiBkb2luZyB0aGUKPiBzYW1lIHRoaW5nLiBUaGUgcmVhc29u
IGlzIHNpbXBsZSwgc28gdGhhdCB3ZSBkb24ndCBlbmQgdXAgd2l0aCB0d28gc2VtaQo+IGZ1bmN0
aW9uYWwgdGhpbmdzIGluc3RlYWQgb2Ygb25lIGdvb2Qgb25lLiBBZGRpbmcgdGhpcyAiY3VybCIg
bW9kZSB0bwo+IHRoZSBmZXRjaGVyIGNyZWF0ZXMgdGhpcyBzY2VuYXJpbyB3aGVyZSBvbmUgdGhp
bmcgd29ya3MgZm9yIHNvbWUgYW5kCj4gdGhlIG90aGVyIHdvcmtzIGZvciBldmVyeW9uZSBlbHNl
LiBXZSdkIHRoZW4gaGF2ZSB0byBkb2N1bWVudCB3aGVuIHRvCj4gdXNlIG9uZSwgd2hlbiB0byB1
c2UgdGhlIG90aGVyIGFuZCBwb3RlbnRpYWxseSB3aGljaCBmdW5jdGlvbmFsaXRpZXMKPiB3b3Jr
IGluIGVhY2ggZGlmZmVyZW50IGNhc2UuCj4gCj4gVGhlIGZldGNoZXIgY2hhbmdlcyBkb24ndCBh
cHBlYXIgdG8gY2hhbmdlIGV2ZXJ5dGhpbmcsIHRoZXkgbG9vayBsaWtlCj4geW91IGNoYW5nZWQg
anVzdCBlbm91Z2ggdG8gZ2V0IHlvdXIgdXNlIGNhc2VzIHRvIHdvcmsuCj4gCj4gVGhlICJ3Z2V0
IiBmZXRjaGVyIGlzIGFscmVhZHkgYSBoeWJyaWQgd2hlcmUgaXQgdXNlcyB3Z2V0IGZvciBzb21l
Cj4gdGhpbmdzIGFuZCB1cmxsaWIgZm9yIG90aGVycy4gSXQgZG9lcyBkbyB0aGF0IGNvbnNpc3Rl
bnRseSB0aG91Z2gsCj4gYWx3YXlzIHVzaW5nIHdnZXQgZm9yIGNlcnRhaW4gb3BlcmF0aW9ucyBh
bmQgdXJsbGliIGZvciB0aGUgc3RhdHVzCj4gdGVzdHMuCj4gCj4gV2UncmUgbm90IHdlZGRlZCB0
byB1c2luZyB3Z2V0LCB3aGF0IHdlIGRvIHdhbnQgdG8gZG8gaXMgcHJvdmlkZSBhCj4gc3Ryb25n
IHN0YWJsZSBhbmQgc2luZ2xlIEFQSSB0byBlbmFibGUgZmV0Y2hpbmcgb2YgaHR0cC9odHRwcyB1
cmxzLgo+IAo+IEdpdmVuIHRoaXMsIGFkZGluZyBpbiB0aGUgc3dpdGNoIGlzbid0IGFuIGFwcHJv
YWNoIHRoZSBwcm9qZWN0IHdhbnRzIHRvCj4gdGFrZS4gRXF1YWxseSwgd2UndmUgdXNlZCB3Z2V0
IHJlbGlhYmx5IGZvciBhIGxvbmcgdGltZSBhbmQgaXQgaXMgdGhlCj4gdGhpbmcgd2Uga25vdy4g
U3dhcHBpbmcgaXQgZm9yIHNvbWV0aGluZyBlbHNlIGlzbid0IHNvbWV0aGluZyB3ZSdkCj4gdW5k
ZXJ0YWtlIGxpZ2h0bHkgZWl0aGVyLiBUaGVyZSBhcmUgbGlrZWx5IHRoaW5ncyB0aGF0IHdnZXQg
ZG9lcyBiZXR0ZXIKPiB0aGFuIGN1cmwgdG9vIGZvciBleGFtcGxlLiBUaGVyZSBhcmUgYWxzbyBm
YWN0b3JzIGxpa2UgZG9jdW1lbnRhdGlvbiB0bwo+IGNvbnNpZGVyIGlmIHdlIHdlcmUgdG8gc3dp
dGNoIHRvIGN1cmwsIG91ciBwcmVyZXF1aXNpdGVzIHdvdWxkIG5lZWQKPiB1cGRhdGluZyBmb3Ig
YWxsIHRoZSBkaXN0cm9zLCBvdXIgYXV0b2J1aWxkZXIgd29ya2VycyB3b3VsZCBuZWVkIHRvIGJl
Cj4gcmVjb25maWd1cmVkIGFuZCBzbyBvbi4KPiAKPiBJIHRoaW5rIHdlIHRoZXJlZm9yZSBuZWVk
IHRvIGhhdmUgYSB3aWRlciBkaXNjdXNzaW9uIGFib3V0IGhvdyB0byBtb3ZlCj4gZm9yd2FyZCBo
ZXJlIGFuZCB3b3JrIG91dCB3aGF0IHRoZSBiZXN0IHNvbHV0aW9uIHdvdWxkIGJlIHRvIGFpbSBm
b3IKPiBsb25nIHRlcm0sIHRoZW4gY29tZSB1cCB3aXRoIGEgcGxhbiB0byBnZXQgdGhlcmUuCj4g
Cj4gSSdtIGNvbnNjaW91cyB0aGUgTFRTL2ZlYXR1cmUgZnJlZXplIGlzIGxvb21pbmcgYnV0IHRo
aXMgaXNuJ3QgdGhlIGtpbmQKPiBvZiBjaGFuZ2Ugd2UgY2FuIHJ1c2ggaW4gYmVmb3JlIHRoZW4g
dW5mb3J0dW5hdGVseSwgd2UgYXJlIHNpbXBseSB0b28KPiBsYXRlIGZvciB0aGF0Lgo+IAo+IEkn
bSBhbHNvIHJlYWxseSBhd2FyZSBvZiB0aGUgbGltaXRlZCBiYW5kd2lkdGggbWFueSBvZiB1cyBo
YXZlIHRvCj4gY29udHJpYnV0ZSB0byBkaXNjdXNzaW9ucyBsaWtlIHRoaXMuIEkgcGVyc29uYWxs
eSBmaW5kIHRoYXQgcmVhbGx5Cj4gZnJ1c3RyYXRpbmcgYXMgSSB3YW50IHRvIHRyeSBhbmQgaGVs
cCBidXQgdGhlcmUgc2ltcGx5IGFyZW4ndCBlbm91Z2gKPiBob3VycyBpbiB0aGUgZGF5IDovLgo+
IAo+IFNvIHdoaWxzdCBJIGFwcHJlY2lhdGUgdGhpcyBpc24ndCB0aGUgYW5zd2VyIHlvdSB3YW50
ZWQgdG8gaGVhciwgSQo+IGRvbid0IHRoaW5rIHdlIGNhbiB0YWtlIHRoZXNlIGNoYW5nZXMgcmln
aHQgbm93IGFuZCB3ZSBuZWVkIHRvIGZpbmQgYQo+IGRpZmZlcmVudCB3YXkgdG8gaGVscCB5b3Ug
c29sdmUgeW91ciBpc3N1ZS4KPiAKCkkgZ3Vlc3MgY29taW5nIHVwIHdpdGggYW4gUkZDIGFmdGVy
IHRoZSByZWxlYXNlIHdvdWxkIGhhdmUgYmVlbiBtb3JlCmFwcHJvcHJpYXRlIHRvIHN0YXJ0IHRo
aXMgZGlzY3Vzc2lvbiA6KS4gVGhhbmsgeW91IGZvciB0YWtpbmcgdGhlIHRpbWUKdG8gcHJvdmlk
ZSB0aGUgcmF0aW9uYWxlIGJlaGluZCB0aGUgYW5zd2VyLCBpdCBpcyBhcHByZWNpYXRlZC4KCkNo
ZWVycywKUGFzY2FsDQo=


