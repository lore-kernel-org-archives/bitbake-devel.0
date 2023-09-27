Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA029E82CB3
	for <webhook@archiver.kernel.org>; Wed, 27 Sep 2023 17:15:15 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.79])
 by mx.groups.io with SMTP id smtpd.web10.22943.1695834910952448734
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Sep 2023 10:15:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=rMJth0rZ;
 spf=pass (domain: axis.com, ip: 40.107.22.79, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlIFDdOJt9ZkqMgKpPnzeRbdIwl+DDe8lSYIkbqi/26nv2hQiL5MnJK2fs1njwO/vQLHT+rqZzs4ELXs62LNAXzp646UWoAZ1u312drKaYX7tVD35AuOP/tnwR4lpFTk0NAtQCHo8TyazIl8jtKl4nUc8m6eY1oCEFo678e94vUR2A1eKKOjXsr53+OgArxXqBEuiiuZejfmj4j0TWjwWGJWvEBzt04+bQEUgBGlB2G4kVPDvHfjCislgBGNrJXzwBb87Q2lAwiCvh91ugz8MQc2Nvs88QZ6DGnpcK+f75okNltpgBqfZJ7SsclyIKHiFhrpmbiSMirMjuD0lEuLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBKm12BzFmbFYY89193qZLL7EK3+p96/+1ag0tybcMc=;
 b=Sf4ZnyOOWsi+YIm8pnnD+e5L06zQhuMpg2Ld+CXb4kVfqYqh7FqsXSGiyilOt03rSwSJGoaDMMSDJsGuvj58wR+PomK7qWEcf8EzuLFda7Je0Wmw+ZRlMcLiqvQo8xaq44yyALZaUcWcy4ymOumEX5D5ttdYjoEVIvTXc46CQ7ehO8/0IPzCab/47r+gMUrc8I+85Ko8wKl8vok05HD5V9e60t3pdLxBXUDdzeaYEQtR4iH8GThBMrljOsqKk+LRYuRevPf7K5c5/RnemgasiVt7tZlyqkaWnRZllgqCkwOtYwk/0hNsfl6B5zqXUP2cEXk/6XXGNMQbHjym2+4DPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBKm12BzFmbFYY89193qZLL7EK3+p96/+1ag0tybcMc=;
 b=rMJth0rZqmN+4n1aJCBEBJ6IjFE/GDQq/bHHHrfVEPr/jYvJdxeB7XA2mbedwhrxeeq56uvv+enEgd6BZv6bfVA3nR3fRi1QsIh79tUez+C4Gb4G/Y+mgxtDV7WreXoTZmqlARS2cNsJ0c/31u8h0PrYLi1/GIp9542l1XfZfJU=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by DB8PR02MB5883.eurprd02.prod.outlook.com (2603:10a6:10:116::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 17:15:07 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::46e8:4a9e:ea9a:7861]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::46e8:4a9e:ea9a:7861%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 17:15:07 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCHv2] bitbake-getvar: Add an option to
 specify a default value
Thread-Topic: [bitbake-devel] [PATCHv2] bitbake-getvar: Add an option to
 specify a default value
Thread-Index: AQHZ8TeavGEF1WFky0aI5va1elMJi7Au3xgQ
Date: Wed, 27 Sep 2023 17:15:07 +0000
Message-ID: 
 <DB5PR02MB1021358C534272BFC4FC752D5EFC2A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230925203128.73512-1-pkj@axis.com>
 <f5feb7f61e67b89f298cc0a8051d2e1547e2a45e.camel@linuxfoundation.org>
In-Reply-To: 
 <f5feb7f61e67b89f298cc0a8051d2e1547e2a45e.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DB8PR02MB5883:EE_
x-ms-office365-filtering-correlation-id: 558c1142-eefc-4445-3732-08dbbf7d4c0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JvRomc8UOlSQRhN5SS2YNqYMRazS+MUNRpOV2WEbaJ1q29+6nJnXhoBeKrmpfv6u9WhtSkIOHqLOfdhJPRAeWDF4kXcrL/JbNsqZOyig8Ar7+fl/mxp1GdGtBwMM745E3GMBACWRl2SCmi8JLvx9k5XflVQd5tyObl+mKzJdovJhrra5uFaaeOFOs9r5G2sdgksQbMdZQxmV0tCpALJSObmiDPh9EMAqDLrLDkgHsV9rhukR1ItnydGetVWii7pG7ULVnAwk3for8j3+0iXlgXT00clFUN9UolwtSP7J6M35bL02z08Wfbr1tCt02dMDu9hDTd9E6EpvbdSKDFGFnF4IgkKviYR28GcgplEQ8WLODZwBA+UQptefjq9FZKLLPY1WKmzO18FLq+X8cmUuZ8UPzaXssPhyQupd61XcyyKjNO6P442hHwemcBs/pBPgW3HkSNpVcmLb6iB75WeG1H1886e/0xaUxFEy9Ixg2fwq6EIorEMLfOCEdJm7BYmeblnKXs5OUoOOuwq/9Mx7wENULUSL7X3QwWB3yO4FUjisPSCJMDz8zeVjAJa2yTLlqn+COaBF1ycNQI5+7H/c/uJW7QQlC4dV3aY5wytl7c5mWQwMhaJkZ+5svI8VVSEn
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(2906002)(86362001)(38070700005)(38100700002)(71200400001)(33656002)(7696005)(9686003)(6506007)(5660300002)(83380400001)(53546011)(478600001)(122000001)(55016003)(8936002)(8676002)(41300700001)(44832011)(26005)(52536014)(76116006)(110136005)(66946007)(66556008)(64756008)(66446008)(66476007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dDZqRnRWMmxsaGJka3ZYN0NOV3JCaTZhd0k3OG9TdTh2c0taakxEODZWWXBL?=
 =?utf-8?B?NVQ3L2Z5b01kekhKNHMxMGJYbmo2Y0NHZzMvdVlJRi9DelQ0TEw4THozcUJM?=
 =?utf-8?B?OE5RMjVjMDEzZUlCWDlMNEJNMmQ4SkhSSEc2VVlzS3ArOWdXTkVUeE1ac0ds?=
 =?utf-8?B?emdyVWdMa09UVDQ1R1g0cTEzZUhmNjF2RUJsV3J4UFVtamhsMS9JZWZKekpk?=
 =?utf-8?B?Zm1tUFVYOUtZZXBQK05pVzJnUnRSaytDQzUzNDFMaDlKTHFKdEs2bnRpejhw?=
 =?utf-8?B?YktCVHNRUFRoN0VrbDdUMG1FYjV6b3Z4anBuajlXVDJxNlI2cUpCb2RZSWFo?=
 =?utf-8?B?eWRlSTdnYzFYOUNXeGFXY1NPOXIvK1QwTDNNSXFqaDdvbVUvZEQ3SVZIUjRs?=
 =?utf-8?B?QzRlbENBTTI5UmRIZDJFLzlwL05KREhKaHhUckltK2tSRnlHVm1ZU0hBV2Ja?=
 =?utf-8?B?OWFnWW8zU052eWRjUGx1ZmtMUm8xTklSZ0VCRTc3VlBLTnBxZlVsMlJBaFhF?=
 =?utf-8?B?Mm5LbFhHa0J0ejJTQmJKYm9FVGVxSXpkeTRBYVVpbkYzN2RFZXVZS3RtUWtL?=
 =?utf-8?B?Q0d2TkNzQ1d0MWF0MWhHRk4ySkh0VEkyRmFDODduTnFydTh4T00vWDNkMGZP?=
 =?utf-8?B?R3h6eVF5R3dxVmttSkhGdFpaSzlKSzZOZkc1U2w2c0YzaTJDUjRQK3U4OE9U?=
 =?utf-8?B?RVdCU1pRd00xVndtYTJTVy9kRDVPZXBVZVRhMEo2Nkk1SkxWb3Q0WmI1UGdP?=
 =?utf-8?B?OFZja0t6NUhHOWJIUzg3YTVUQ0JuRlZJYkV4aFVXRjMvSXk2WEZDSjluQmZM?=
 =?utf-8?B?ZHJ6alhTc0JrUzN3Z1VzRWR4MUJWbEVnZjUxWnlsRUsrd0RQKzIrcXFHc0F4?=
 =?utf-8?B?N0lwenVSN21YZzI1alFQT1RHRDFkWnV1d1Z6UGlLOXBwZ2pkSjRSL21odnBv?=
 =?utf-8?B?cDdrWktaU1BDRFlpVmxZU3pZaHlWMS9PSjlFOTdCbklVUU9SeEwwMzk5MHZM?=
 =?utf-8?B?emx2cklDZ20zQ1JwcEhFVkUzTUx1WFRPeXpqSmVySUQrVU5LL0xKb3RPQlh5?=
 =?utf-8?B?T3dURi9RZjdYWWRiN3lvU3JrOERSMEc3UVJTa3NrODVndm9lWHhrR1p5VjNh?=
 =?utf-8?B?QkhmUDFxMVFLWUxDWlNSYzN1NGpjTk03d0kvdWFrMzQ1S0xmVG41eVVZYjJw?=
 =?utf-8?B?RHNiVmJkWEZLK1pBZVB6bTA3bnZMYU5QK25xZVpWNnFLTFNMQVhMUUErazVu?=
 =?utf-8?B?bHo1cjg1eVJaZlhrbHg5aGhFSWcwSGlvcUI0dFp1QzJNOVFXUURydndScGMy?=
 =?utf-8?B?V2hhMzQ1aWFBbUFMSWJjLzJZSFJnZC9oUnRZL0l1SDAwQWtMM0tJVk5ZeGo3?=
 =?utf-8?B?b2xtbDExQ1dXOHVGaFNzNlJGR0FGekJDbUdYNUJGV2xSVVVZUmswZ1VwUENh?=
 =?utf-8?B?cVVXekhOYVNmUjI2YWhZMnhXMVliVFhDTnp5eEU3Q3VrSHk3cTRwQkU2ZVZO?=
 =?utf-8?B?YzcyOUZtTkRMbUx4QktlNjJZZENYN0NaVm5ZaFE4RVB6UGFyNkpXdjRlQmRI?=
 =?utf-8?B?T0tlaDYrdEF1WmlzV0IyNmdSSThtWkpwUEYrb1E4Nm1RV1RXWHoxOGs0K3Rp?=
 =?utf-8?B?aVpUSDQ3QktpcU9yTUJtVVNINFkxdTFnUDJwUmNMQ1VvTDY3OEN5ajhLb1E1?=
 =?utf-8?B?RVpVMFV2UGVsQjFaRjdUUHVQc1Fpd0ZxMXJwNXcrVlJoVEp1clE0L2lhQmdZ?=
 =?utf-8?B?Uno0alpRQ0JUdHExK1dGekwrSWZNamQ3SzBHMGtPZjBrTzExazFybkd6VEo5?=
 =?utf-8?B?VjUxL2RtZVFBclZwNXdJOW9xdkx4M3pwNzV3eEwydmlWclZnckdRTVNTajZJ?=
 =?utf-8?B?NEFTVXN5ZFg2ay9SUk5wdWkzb1NFejd4SjJFYUorWUQ2TC84RWpZZFlqNXU0?=
 =?utf-8?B?cDhhdTdlcEFVclVxSklDbklhNEVwUC91WnplYmdPNGR3eCtCM09PVW9wVlBw?=
 =?utf-8?B?M3Q4bVR6NW02QXZtMzAxaHgrS2xOVDNJRGdacHhIUzJVZW1vL0Fjbm1zdUk1?=
 =?utf-8?B?QlFEKzZ4b3JOVURlRnUwNXBsRk5LTkh0Q2ZFVnRVUGcraHVPaGFCQkUvZEJG?=
 =?utf-8?Q?LgxQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558c1142-eefc-4445-3732-08dbbf7d4c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 17:15:07.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCzCbMKQfBYRp1dv3ku9cIS85X4FmO+i1FpG0sBDa5b/fwnTGwz1oxbaqt76hVlR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5883
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 17:15:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15137

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIFJpY2hhcmQgUHVyZGllDQo+IFNlbnQ6IGRlbiAyNyBzZXB0ZW1iZXIgMjAy
MyAxMzo0Mg0KPiBUbzogUGV0ZXIgS2plbGxlcnN0ZWR0IDxwZXRlci5ramVsbGVyc3RlZHRAYXhp
cy5jb20+OyBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gU3ViamVjdDog
UmU6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0h2Ml0gYml0YmFrZS1nZXR2YXI6IEFkZCBhbiBvcHRp
b24gdG8gc3BlY2lmeSBhIGRlZmF1bHQgdmFsdWUNCj4gDQo+IEhpIFBldGVyLA0KPiANCj4gT24g
TW9uLCAyMDIzLTA5LTI1IGF0IDIyOjMxICswMjAwLCBQZXRlciBLamVsbGVyc3RlZHQgd3JvdGU6
DQo+ID4gVGhlIGRlZmF1bHQgdmFsdWUgaXMgcmV0dXJuZWQgaW4gY2FzZSB0aGUgc3BlY2lmaWVk
IHZhcmlhYmxlIG9yIHZhcmlhYmxlDQo+ID4gZmxhZyBpcyBub3QgZGVmaW5lZC4NCj4gPg0KPiA+
IEluIGNhc2Ugbm8gZGVmYXVsdCBvcHRpb24gaGFzIGJlZW4gc3BlY2lmaWVkLCBiaXRiYWtlLWdl
dHZhciBmYWlscyB3aXRoDQo+ID4gYW4gZXJyb3IgaW5zdGVhZC4NCj4gPg0KPiA+IFN1Z2dlc3Rl
ZC1ieTogTWFyaW8gRG9tZW5lY2ggR291bGFydCA8bWFyaW9AcGFyZW50ZXNlcy5vcmc+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUGV0ZXIgS2plbGxlcnN0ZWR0IDxwZXRlci5ramVsbGVyc3RlZHRAYXhp
cy5jb20+DQo+ID4gLS0tDQo+ID4NCj4gPiBQQVRDSHYyOiBOZXcgc29sdXRpb24gYmFzZWQgb24g
dGhlIGRpc2N1c3Npb24gYWZ0ZXIgdGhlIHByZXZpb3VzIHBhdGNoLg0KPiA+DQo+ID4gIGJpdGJh
a2UvYmluL2JpdGJha2UtZ2V0dmFyIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPiANCj4gSSd2ZSBiZWVuIHRoaW5raW5nIGFib3V0IHRoaXMgYW5kIEkgZGlkIHBvbGwg
YSBmZXcgb3RoZXJzLg0KPiANCj4gVGhlIGxvZ2ljIGZvciBpbXBsZW1lbnRpbmcgdGhlICJkZWZh
dWx0IiBpcyBwcmV0dHkgdWdseSwgSSB1bmRlcnN0YW5kDQo+IHdoeSB0aGF0IHdhcyBuZWNlc3Nh
cnkgYnV0IEknbSBub3Qga2VlbiBvbiB3aGF0IGl0IGRvZXMgdG8gdGhlIGNvZGUsIG9yDQo+IHRo
ZSBwb3RlbnRpYWwgY29uZnVzaW9uIG9uIHRoZSBvdXRwdXQgb24gdGhlIG5vcm1hbCBjYXNlIHdp
dGhvdXQgLS0NCj4gdmFsdWUuDQoNCk9rLCB0aGVuIGxldCdzIGRyb3AgdGhhdCBpZGVhLiBXaGls
ZSBJIGxpa2VkIHRoZSBpZGVhIHRvZ2V0aGVyIHdpdGggDQotLXZhbHVlLCB0aGUgbmVlZCB0byBp
bmplY3QgdGhlIHZhbHVlIHRvIGdldCB0aGUgY29ycmVjdCBvdXRwdXQgd2hlbiANCi0tdmFsdWUg
aXMgbm90IHVzZWQgZmVsdCB3ZWlyZC4NCg0KPiBBbGwgdGhpbmdzIGNvbnNpZGVyZWQgSSB0aGlu
ayBJJ2QgcHJlZmVyIHRvIGFkZCB0aGUgLS1pZ25vcmUtdW5kZWZpbmVkDQo+IG9wdGlvbiwgd2l0
aCBOb25lIGJlaW5nIHRyYW5zbGF0ZWQgdG8gIiIuIFRoYXQgaXMgYXQgbGVhc3QgcmVhbGx5IGNs
ZWFyDQo+IGF0IHRoZSBjYWxsZXIgc2l0ZXMuDQoNCk9rLCBJIHdpbGwgZG8gdGhhdC4NCg0KPiBD
aGVlcnMsDQo+IA0KPiBSaWNoYXJkDQoNCk9uZSB0aGluZyBJIHdvdWxkIGFzayB5b3UgdG8gcmVj
b25zaWRlciB0aG91Z2ggaXMgeW91ciB3aXNoIHRvIG9ubHkgDQpzdXBwb3J0IGEgbG9uZyBvcHRp
b24gZm9yIC0taWdub3JlLXVuZGVmaW5lZC4gSSBiZWxpZXZlIHRoZSBjaG9pY2UgDQpzaG91bGQg
YmUgd2l0aCB0aGUgdXNlciBvZiB0aGUgdG9vbC4NCg0KVHlwaWNhbGx5IHdoZW4gSSB3cml0ZSBz
Y3JpcHRzIHRoYXQgY2FsbCBvdGhlciB0b29scywgSSB0ZW5kIHRvIGJlIA0KbW9yZSBleHBsZXRp
dmUgYW5kIHVzZSBsb25nIG9wdGlvbnMgKGF0IGxlYXN0IGZvciBjb21tYW5kcyB0aGF0IGFyZSAN
Cm5vdCBhcyBjb21tb24gYXMsIGUuZy4sIGBybSAtcmZgKS4gSG93ZXZlciwgd2hlbiB0eXBpbmcg
dGhlIGNvbW1hbmRzIA0Kb24gdGhlIGNvbW1hbmQgbGluZSBJIG11Y2ggcHJlZmVyIHRvIGJlIGFi
bGUgdG8gdXNlIHNob3J0IG9wdGlvbnMgdG8gDQpzYXZlIG9uIHR5cGluZyAoZXNwZWNpYWxseSBm
b3IgY29tbWFuZHMgd2hlcmUgSSBkbyBub3QgaGF2ZSBhbnkgWnNoIA0KY29tcGxldGlvbiBzdXBw
b3J0KS4NCg0KQW5kIG9uIHRoYXQgbm90ZSwgSSB3b3VsZCBsaWtlIHRvIGFkZCBhIHNob3J0IG9w
dGlvbiBmb3IgLS12YWx1ZSBhcyANCndlbGwgc2luY2UgSSBmb3VuZCBpdCBvZGQgdGhhdCBpdCB3
YXMgbWlzc2luZyB3aGVuIEkgc3RhcnRlZCB1c2luZyANCmJpdGJha2UtZ2V0dmFyLiBUaGUgb2J2
aW91cyBjaG9pY2UgaXMgLXYuLi4NCg0KTm93LCBzaW5jZSBJIGV4cGVjdCB0aGUgYWJvdmUgdG8g
YmUgcG90ZW50aWFsbHkgY29udHJvdmVyc2lhbCAoZXZlbiANCnRob3VnaCB0byBtZSBpdCBpcyBq
dXN0IG5hdHVyYWwgdG8gaGF2ZSBzaG9ydCBvcHRpb25zIGZvciBhbGwgbG9uZyANCm9wdGlvbnMp
LCBJIGhhdmUgc3BsaXQgdGhlIGNoYW5nZSBpbnRvIGZvdXIgY29tbWl0cywgb25lIGZvciB0aGUg
DQpuZXcgZXJyb3JzLCBvbmUgdG8gY2hhbmdlIHRoZSBvdXRwdXQgZm9yIHVuZGVmaW5lZCB2YXJp
YWJsZXMsIGFuZCANCnR3byBmb3IgdGhlIHNob3J0IG9wdGlvbnMuIFNvIHdoaWxlIEkgb2YgY291
cnNlIHdvdWxkIGxpa2UgdG8gc2VlIA0KYWxsIG9mIHRoZW0gaW50ZWdyYXRlZCwgdGhpcyBsZWF2
ZXMgdGhlIGRlY2lzaW9uIHdpdGggeW91Lg0KDQovL1BldGVyDQoNCg==

