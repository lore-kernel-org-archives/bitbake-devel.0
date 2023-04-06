Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A5FC77B6C
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 10:57:04 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web10.155387.1680778618439452232
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 03:56:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=R+EzANpn;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1680778619;
  x=1712314619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J8iOhL2b3X6Hn4iiHd6uIpTzqWR6jXp92xcU3ZVdLns=;
  b=R+EzANpnQFkgD0HORJPZ5Kwitm1h3EGUtk93fjbaUHOmo9svfjO9nqEf
   4Fr+l2eDGbmLmyXw6oC9sCCkJDQY4tPcZxBiEfJa73bgF0wjg+bf5Z3gX
   jcZW8mSOAQhE3FR7LkplvdyMR4xSTtuTN+fj5G5vyPnkL5vCxntlbeunI
   /+TB6EfrgoTHKS1ARUdambP9+qQbrgU4CwQNcHy9o7Mx21OmOxczWSrbB
   IV/nxtHuujmJOCiqILAfw13Eyj0Oa6T+78lvH8B7f/404lCil7+Kt2U3q
   WwHXmaTobVGMoE6456wxpbpqsQ6CrcCwqHf29p8kmNkPhpb/8R7KleB36
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2Lduqhu8QUokA3+D44Iv8X50L6OrIdok8ddcHV0icWNaHnGnhP3oo4OwGuXh1hm4yVRkYjSMQ6XEDfeW2ZFB2M7XL9GUhSDcFBqtI7VYQ/blvQgADvUwzfnJ72kPnwKHi6AroHaT9H1mddXrWtnLZEF0AW1FPwuKEVs0TIw44Cy9Ho0raxoZh0LQF5O4OK0FnEQ23hq+gZ7jIxdTfx2BgiZsIFAPddvTZuVnVN4ojtxFBgCMMw7e9uYugvtvK1JzbFx5qtBzG+lGAwqNbqPcfgiPc56+aqCuLUOf3PgUFd2aXNfPTTZM0onCBckoX+ndeMOz3yKmuvlDQShk7hzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8iOhL2b3X6Hn4iiHd6uIpTzqWR6jXp92xcU3ZVdLns=;
 b=NpW9AmPUkkRPsCuAShuYHvK1PsPlB/vKXnO2KaqPgVfz1jFJVk+nJkz1a0sXXzNp+VeytGGTphpB/I5jnd7ma/NYKebSCLC92V7Yg27Or/H7NEUIvvmo2rpdPbR5AnaB5ZlOszJGfAk1911zStgTO14X3lBJFVpt2W42TZbOsIlbz6Mf138LINka536mbK4fqiUpcwJYjOfvX8HoUBijDta9vmiGU5PnsoDww3HzUsd3zb8e4S0+BAnWmppcgBgVYX2fcz0ukGidSXHriHsavBL07et6V0RwZYFfBZQWBDFFyTrNlK28NVZxHdtK2pfYAvizlC/HGfnQIe9EUMqyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8iOhL2b3X6Hn4iiHd6uIpTzqWR6jXp92xcU3ZVdLns=;
 b=usvR7BX58n0dId57Jv2oJSHB0Lzjdz2dVBqbkNL0LUn0AlrxQASp6I1g8qmHBKDYa4It9RLeuVUONu5a07N81g4/XzqJFBS+XwTEUFvv+kCektuhiP0S0SPdSM/qNWNAq8HAm9dYvocnFJuemueBhUJYrnoxFKcLeKDl8xCdQr8=
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Steve Sakoman
	<steve@sakoman.com>
CC: Frederic Martinsons <frederic.martinsons@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH v2 3/3] crate.py: authorize crate url with
 parameters
Thread-Topic: [bitbake-devel][PATCH v2 3/3] crate.py: authorize crate url with
 parameters
Thread-Index: AQHZWKlEMyO8sRYQxUK+C8NUZJA/aq8dv+zAgABWNICAACKWoA==
Date: Thu, 6 Apr 2023 10:56:53 +0000
Message-ID: <DB5PR02MB10213AA7D4BB051D113ED80A5EF919@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230317081916.1857201-1-frederic.martinsons@gmail.com>
	 <20230317081916.1857201-3-frederic.martinsons@gmail.com>
	 <DB5PR02MB10213D211F48E6ACF5D4505BFEF919@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <37f0b57bb3fc25c4232378f94fb8d30929c53e6d.camel@linuxfoundation.org>
In-Reply-To: <37f0b57bb3fc25c4232378f94fb8d30929c53e6d.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DB9PR02MB6524:EE_
x-ms-office365-filtering-correlation-id: c02f68d6-9f0f-445b-3ea4-08db368da210
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8Pyw4r2THLn4SVZ4DV4wV7Qu9X6svG3DZhinjP34DfUOzX6K/GPxgYdLm9Dzfgl/aFFRrJ7v4IpcbCEfKkTAB5OGo3l28bdJgVhQYUhmdszqkmBa3GR4lbL16Gr6fhWs/aRP8/mCbhKdG/8mScrw9O8Kr/ePMOrCzp7YiMfNw/WPi4OJpjv/ac/mpGj9ZNv1HhRUWcMOoLGekjzSZuwKh6MgoaXiLE4lL/esAYMiEqNBbIuiOIJUvDpcwBgGxtjES+kWZmWxBqELt/uYCyLBjBCfb3MCggXYLaf2iGvVLrYzGs578JQBZIphhRVOuVtcRjxB6FKWiMz6S++kROGUlgvQDB2GHl7N+aRbcGd4Lrh2ZLlyIxwSC73aA17OXhF4kkqMMTvxKutS7DpUmOuRX2xALwAOwTFRAQmtWonOtqaqnC+iSCZuqmlO1JA0hrBOPDPGxpNmcqU/7qJ6ZcXxPN49IzsYOvv2jGOeX0/pe4HEcDC9ft9LS7jy5mGgVYewYtuO95FFUdnbWn0DCH7piW9Fl9Xn05/HWx7BgYkkM1G2UIjSNoSsQlpdrWgbIeZF+JV1iQZPJJ715ZKQmtaEK3Ymq79/2P5PXpAbgfYuWFx1goadn3OtA7NFFMG17Lq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(55016003)(64756008)(316002)(76116006)(66476007)(66446008)(4326008)(66556008)(122000001)(66946007)(110136005)(54906003)(41300700001)(186003)(6506007)(83380400001)(478600001)(71200400001)(7696005)(53546011)(9686003)(86362001)(26005)(33656002)(2906002)(44832011)(8936002)(38100700002)(52536014)(5660300002)(8676002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0htR3UrWGx3TVB4MnEzREt4VFoxeUVGd2VXVENoUTB5b2RzUWEyYTd3YlZN?=
 =?utf-8?B?S0svZGpTZzdNWXhpdndxUkNxWE90RmNtS2lwbVJvaWlsdHhhR0VnNVF0c0dC?=
 =?utf-8?B?MnFWS0xkSUNDVGRuaHFYemZ1QzRRSkU0bUc5K3JWbFIxdlB4R1ZYVU1YbmVS?=
 =?utf-8?B?b0VhUWhMZFp2cnBHMGtaaW5VNTVlMnNUWnhCU2JFTXBRSmU1YVJEMlRudEhK?=
 =?utf-8?B?a3IxZEV4S0QvVjlVdHJaTUdiVnN4VkdzWHpKZjdsdStiRi8wMllPWGZFM1Rx?=
 =?utf-8?B?UFhDdmIzV1ZXazRNSTltVlJCOXNIaHN2QjdjN2NMa3FwUmdTQ0EwNnRxazBW?=
 =?utf-8?B?MzFXdk44V2l6UEpBTGprSitDR0FhY3l5U0FNNnU4Z2w2aXZndHUwRHBWOHNJ?=
 =?utf-8?B?YWdwU2k0R1B3NEVYQnRlK3FKWXBjcld3c2NzNDh4dnBYMVVxa3NEamhaRzRk?=
 =?utf-8?B?SUw2Z3J5M3lTWHVNT1VSZ2JzY3EzQVFRTDBvUmtyaFQxNkxpa0hKbmNoVEdN?=
 =?utf-8?B?QVlINzdwSmlZU25OdE9EVHNXUE9SRTY0Tnk1OHU4SzVqQXZxazg2eWZiUHRK?=
 =?utf-8?B?TTVXczhVUXZibkRIU0FIZFlMV01pZ1NKL1daeGN1OCtld1JQeU9GdVdkL0FI?=
 =?utf-8?B?UlVhV1E2ajQwV3dRS2F6VzJURkxlZ013cVRyRndQL1JoZHJWV1RxbFFPSEls?=
 =?utf-8?B?S3p6S0VUNjhnekNUVmx0cGJpMEZjd3ZHUXYyZzZMY0dxZ0N1Z3gxVUxCR2V1?=
 =?utf-8?B?U1hFUG9xNmdLNldCaDFHdmJidEdSWWZ4RGxqdVNvZzA3K3VIUXZOdjloeE1F?=
 =?utf-8?B?L05nYTIxMGEwVUVVbmFDamJtclcvSlJLYnNaK0RIU3pTTlMwYzJJTjh2SFVq?=
 =?utf-8?B?R0d0SEk1d1UrNmUyczFEYjNaS21SY1pneTJkV0txc25tdTJ1bFkydE9WdC83?=
 =?utf-8?B?dUJRR3laa1JyUklIQlYxTU1rTkpvTVpXemZmM2cyQUo2SnRJQjcxQWdzN2Nk?=
 =?utf-8?B?Z3lPQzRzUEM2UzNmMDFabWFBOE92NUlpUm5tcUZ1RFp0ZmFiTU4vYzNXUUpX?=
 =?utf-8?B?VTM0N3h1M2tHTXZuRWhZaHNtQ1l1K09DcWhWWXpOYzljRXY4Uk44eTVjOWhw?=
 =?utf-8?B?RmJqQlZWY0dhUmY1dXJaQ3VRUk5lZkFBK3krS05CNk9rWnJDcUdWYTY3cHB3?=
 =?utf-8?B?dmhqMTFudm1oTHg3ajBBRFdnTmtzVmc3ZXkyMTBIM2FTSkhQWmlQZXpxakJ0?=
 =?utf-8?B?cGtoY09LM253T1ptdjZva0pLT1I0a215TUVHN1Z5aVg5K0NUVzdVTzkySzZk?=
 =?utf-8?B?Y1pZcElwTGVSNjM4VU9GWmhmZHYvSUQvR3FkRUdveGpJd1NTSDgzb0tvNVVt?=
 =?utf-8?B?MVpyWTE4cWpvaHUwWVFWU21pbDRDVlFpaWFIbytZTm1HbVl0OWppWTdzQ0VY?=
 =?utf-8?B?NFA4RFpzZzJKQitaeWwzUUJJWnBZckt2aEpEc1VKOERFcmlGOTBXN3h1aG0y?=
 =?utf-8?B?MFRTN3hYNU9TWkdheGtSTE9lT1hsRW9vdXpJTGV6YmVRcUFva05MMnl2YUdv?=
 =?utf-8?B?cHI3elM1L1RwMHEzdS9UT3l5SHJCRWpSRC9STTdyWDFPT2dHSzVyRXo2ZEM2?=
 =?utf-8?B?OVE1Z0FzZkdGaDVaeUFta05pbWswTGl1VGh0UHl3UGErK0xjY2dFN0k1Z0NF?=
 =?utf-8?B?bXVWbnNYSjZnQzFnWm1mZ2RwTUpLYmVhRFlYZkl0MFJ0Q0RHZU54a09ScnY3?=
 =?utf-8?B?QlZDMzBIRkRvNEVETXJya2hzbEJMZjNjT1dEeEtMYmYveUJNUkpINkZXN1F3?=
 =?utf-8?B?NldNSnZmSGdVYUIwV0kvU2tVdkJ0V3dxWitWOHdDVVdvdlE2SWtCMzJxN3VP?=
 =?utf-8?B?RCtubzI3STlBeWo4NEdpZCs0ZlRDU2FtZG82aHpPSTlEdzRKcXc0N3NmbWlQ?=
 =?utf-8?B?WWlsdlJBRjBCKzZrWDJmSDBCQ1NPTnJVSnA3SjhaKzN6YnUwTll5NzVpTGkx?=
 =?utf-8?B?M2hrdFNseEJZaTZEcHRNWVowd3l0b2dhdnZib1ZJbHpNcGJPQlJ5Qi9FamJH?=
 =?utf-8?B?MTdLR1NtU0owaWJ5RkI5NklNc3FtZG95MlN1ZUNRdzRwTUZ5cWdyb1VibkNJ?=
 =?utf-8?Q?uAiE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02f68d6-9f0f-445b-3ea4-08db368da210
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 10:56:53.9947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwJr/5nr9O6ZIpBF8cSxTnIG6udhdQBTvdv2d9HM4Qeb/E6LEXC0DSZaKeTemBaB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6524
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 10:57:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14669

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmlj
aGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogZGVuIDYgYXByaWwgMjAy
MyAxMDo0Mw0KPiBUbzogUGV0ZXIgS2plbGxlcnN0ZWR0IDxwZXRlci5ramVsbGVyc3RlZHRAYXhp
cy5jb20+OyBTdGV2ZSBTYWtvbWFuDQo+IDxzdGV2ZUBzYWtvbWFuLmNvbT4NCj4gQ2M6IEZyZWRl
cmljIE1hcnRpbnNvbnMgPGZyZWRlcmljLm1hcnRpbnNvbnNAZ21haWwuY29tPjsgYml0YmFrZS0N
Cj4gZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBTdWJqZWN0OiBSZTogW2JpdGJha2Ut
ZGV2ZWxdW1BBVENIIHYyIDMvM10gY3JhdGUucHk6IGF1dGhvcml6ZSBjcmF0ZSB1cmwNCj4gd2l0
aCBwYXJhbWV0ZXJzDQo+IA0KPiBPbiBUaHUsIDIwMjMtMDQtMDYgYXQgMDM6NDAgKzAwMDAsIFBl
dGVyIEtqZWxsZXJzdGVkdCB3cm90ZToNCj4gPiBQbGVhc2UgY2hlcnJ5LXBpY2sgdGhpcyB0byBL
aXJrc3RvbmUgYW5kIExhbmdkYWxlIHNvIHRoYXQgdGhleSBjYW4gcmVhZA0KPiA+IHVwZGF0ZWQg
cmVjaXBlcyB0aGF0IHVzZSBjcmF0ZTovLyBVUklzIHdpdGggcGFyYW1ldGVycy4NCj4gPg0KPiA+
IEkgYXNzdW1lIGl0IHNob3VsZCBiZSBvayB0byBjaGVycnktcGljayBwYXJ0IG9uZSBvZiB0aGlz
IHNlcmllcyB0b28sIGFzDQo+ID4gbG9uZyBhcyB5b3UgZG8gbm90IGNoZXJyeS1waWNrIHBhcnQg
dHdvLCBhcyBpdCB3b3VsZCBiZSBhIGJyZWFraW5nDQo+IGNoYW5nZS4NCj4gDQo+IElmIHdlIGRv
IHRoaXMgZG9lcyB0aGlzIG1lYW4gd2UncmUgY29tbWl0dGluZyB0byBmb3J3YXJkcyBjb21wYXRp
YmlsaXR5PyANCj4gSSdtIG5vdCBzdXJlIEkgbGlrZSB0aGF0IHByZWNlZGVudC4uLg0KDQpXaGls
ZSBub3QgYSByZXF1aXJlbWVudCwgSSBzdXJlIGhvcGUgd2UgY2FuIHN0cml2ZSBmb3IgZm9yd2Fy
ZCBjb21wYXRpYmlsaXR5IA0Kd2hlcmUgaXQgZG9lcyBub3QgaW1wYWN0IHRoZSBvbGRlciBicmFu
Y2hlcyBuZWdhdGl2ZWx5LiBBdCBsZWFzdCBpbiBjYXNlcyANCndoZXJlIGl0IGFmZmVjdHMgcGFy
c2FiaWxpdHkgb3IgaW52b2x2ZXMgcGFydHMgdGhhdCBhcmUgaGFyZCB0byBvdmVycmlkZSANCmlu
IGEgaGlnaGVyIGxheWVyLg0KDQpUaGUgcHJvYmxlbSBmb3IgbWUgaW4gdGhpcyBjYXNlIGlzIHRo
YXQgTWlja2xlZG9yZSBub3cgcmVxdWlyZXMgdGhhdCBhbGwgDQpVUklzIGhhdmUgYSBjaGVja3N1
bSwgd2hpY2ggYmFzaWNhbGx5IHJlcXVpcmVzIHRoYXQgcGFyYW1ldGVycyBhcmUgdXNlZCANCmZv
ciB0aGUgY3JhdGU6Ly8gVVJJcyBzaW5jZSBpdCBpcyBxdWl0ZSBjb21tb24gdGhhdCByZWNpcGVz
IGRlcGVuZCBvbiANCm11bHRpcGxlIHZlcnNpb25zIG9mIHRoZSBzYW1lIGNyYXRlIGFuZCB0aHVz
IHJlcXVpcmVzIHRoZSBuYW1lPSBwYXJhbWV0ZXIuIA0KQXQgdGhlIHNhbWUgdGltZSB0aGUgY3Jh
dGUgZmV0Y2hlciBpbiBLaXJrc3RvbmUgYW5kIExhbmdkYWxlIHdpbGwgZmFpbCANCmlmIGFueSBw
YXJhbWV0ZXJzIGFyZSBzcGVjaWZpZWQgZm9yIHRoZSBVUklzLiBUaGlzIG1lYW5zIGl0IGlzIG5v
dCBwb3NzaWJsZSANCnRvIHVzZSB0aGUgc2FtZSB2ZXJzaW9uIG9mIHRoZSBnZW5lcmF0ZWQgY3Jh
dGVzLmluYyBmaWxlcywgd2hpY2ggY2F1c2VzIA0KYSBsb3Qgb2YgbWFpbnRlbmFuY2UgYnVyZGVu
Lg0KDQpJdCBpcyBhbHNvIHZlcnkgaGFyZCB0byBtb2RpZnkgdGhlIGNyYXRlIGZldGNoZXIgd2l0
aG91dCBhY3R1YWxseSBtb2RpZnlpbmcgDQpPRS1Db3JlLiBBdCBsZWFzdCBJIGZpbmQgbXkgUHl0
aG9uLWZ1IGxhY2tpbmcgaW4gcmVnYXJkcyB0byBob3cgSSBjYW4gDQptb25rZXlwYXRjaCB0aGUg
ZmV0Y2hlciB0byB1c2UgYSBtb2RpZmllZCB2ZXJzaW9uIG9mIGNyYXRlLnB5Lg0KDQpPbiB0aGUg
b3RoZXIsIGl0IGlzIHRyaXZpYWwgZm9yIHlvdSB0byBiYWNrcG9ydCB0aGlzIHBhdGNoIHRvIHRo
ZSB0d28gDQpicmFuY2hlcyBpbiBPRS1Db3JlLiBBbmQgYXMgbG9uZyBhcyB0aGUgc2Vjb25kIHBh
dGNoIGluIHRoZSBzZXJpZXMgKHdoaWNoIA0KcmVxdWlyZXMgdGhhdCBjaGVja3N1bXMgYXJlIHVz
ZWQpIGlzIG5vdCBiYWNrcG9ydGVkLCBJIGNhbm5vdCBzZWUgdGhhdCBpdCANCnNob3VsZCBoYXZl
IGFueSBuZWdhdGl2ZSBpbXBhY3QuDQoNCj4gDQo+IENoZWVycywNCj4gDQo+IFJpY2hhcmQNCg0K
Ly9QZXRlcg0KDQo=

