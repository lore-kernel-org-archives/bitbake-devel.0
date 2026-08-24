Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB560C5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 13:52:27 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com (BL0PR03CU003.outbound.protection.outlook.com [52.101.53.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17202.1787579544848404860
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2026 06:52:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=OryxyOZo;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.53.42, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5H9pdMmZSYsBGz18OJVcRzFpXozje6asVZfRWMhjY7hNLasMJolWCMrrwB606eELrth4Y5f4Y8TkcJsmwcVgA4wbNu6nZ1SLZWAn3iJMgajK9gG6V+PG0JV2MjVXajsXIkxYjm+1JkUnpoLGRMJWoTK1OLYzyxi9tPVWOgZ4d+DdcpXGz8yNUl8UO3nmwF/F22/yt7TnE7gENalnon0IzwHjj3LZMhpKL2g2EsFF3JRG+q2LOX1O6W17cVcSzgk1Z27JcNg8VSDSbtL4UGOXpxQAREH7Leclq8z/o0OLtGSQYPp38dh9/Ahh3V4NUthZZP3gUAjjtHPpb4PyPdXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFLVQqUrqf8KJn6GsMMnkGYn1lA51UAYq5i7uARnOmA=;
 b=R/+Ih6gFM+A6oVlSNGGohCvjxv/vpTlqFT8A67KEoY8PzIQ9iGxIUzkrCfaEZLgds3woDvcB2J4KkPIobdMYydErfh2lb1uc9CHBH4WFc1KPxBwPji21/YH2SmZYFHYuA42h0Smohzz1Zu7+1Pu3CdsHI34hUrNfqy7bh9Wosrdx/qAsXiZoXlngYm7G537rDWS2u8bn+N51nK33ILdqWix7CElUx1up4rzR/RtZFtJPaF1Xc4j2NP65cOcy40aqU1qeHAZtu/9QuX43bkaNRMnMPdrSOTPddzD9fUkADTMY4QvuMjw/CnyWTv9gtklhl78y8mF7NmL/Eb8MnXn87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFLVQqUrqf8KJn6GsMMnkGYn1lA51UAYq5i7uARnOmA=;
 b=OryxyOZoQSa8jWmaloI04XFkXZ/aZg4b2Whlzm9RqEeR3ydDNQQXHaP7NPRKxZYR2mKuxPbG95ruNy2xwkUb9Ugx3EjwX9VVFEKgwXukzljkwiAVQ/zhulELJXy+LFaJtf5Pnso0MQJkm/erV5x0yjUsdzaf5iXzUyJ/b6akgRus4ghX+qJoqg2X1bY6H7S920I8TCgHKwWRAfetvRo09AwOKaNg/861JO01Rtg9AwxMYz7yU5nVJVv6qJ6bN7owXXB+5BT5Q6hc4Su1pIDg0snpQpjEnXW+vystcuaHdKKxchx1dA81CZBnmOESrwcKtavXpj4unsLVo9PKSiJgqg==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 24 Aug
 2026 13:52:18 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:52:18 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] runqueue: Fix pending_hash_index not
 including taskname
Thread-Topic: [bitbake-devel] [PATCH] runqueue: Fix pending_hash_index not
 including taskname
Thread-Index: AQHdMa6SLiM2LnZM9k28bjipqW8HZrapBO8AgAQ2TIA=
Date: Mon, 24 Aug 2026 13:52:18 +0000
Message-ID: 
 <DM8PR12MB54309E7F72B6CC078D0D6BA58BA02@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20260821204901.48802-1-chris.laplante@agilent.com>
 <80f16c343f0b695970c6c93218e67eabd9648914.camel@linuxfoundation.org>
In-Reply-To: 
 <80f16c343f0b695970c6c93218e67eabd9648914.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=311ccd35-435c-43e6-8c76-8be371e8f1a6;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-24T13:48:52Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|PH8PR12MB7025:EE_
x-ms-office365-filtering-correlation-id: 9ee480bb-e667-4b3d-cd01-08df01e6e986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|38070700021|4143699003|11063799006;
x-microsoft-antispam-message-info: 
 128wyakiRW6BBiAUGGwzMD5O4aoZSarUlm24rQ1JeY+PJ4z5qvi++I415YsvA/vE3eCEzNgvoowA632Bx63QwK1NWqkLqvbvwMZM6dsn4BtAZxpTRy07oZrhMBwBMkQoh+h5j/W07eJd9+sTr46yF89CP2nnVuMP8EJ6eJLLSP4cQGe3FwzRWmIsY2GktAGBdKTx/np36SXqcOK2cFjH8cEJn83RRSS9GIl4Y4GMSrskPK28eQ8BGYXdQJruRfQWHqaZE59x0wY1lAobX2jbJ7OLvOOWHy1pXQBYJCvFCL5yZA+H0MJ4MxwxBGmccGWoTkc6aifQHy4hxH2bmYgdVMxO6S2PLi4wabOsWcJxQUg1b7DOSjc0NT1Ot1orygDQ1jV5x4G7AijSXVNM9CPLMaetxU2T/nVCMUaSkJfx53cz4WLVR4x9+4nUufBYAA1sMyQ0zZQtTv48eYl8nNcbuiAswMsviRwXod9FjUWcnJxvXZhMxJmd785ave5LX1rkqZoZckk/HiPdM6JB3nVcy+JeLGBVHmYqEuoEFcTdaf1W7eLTTtqEyjmT13kSsgtUzGRmZZpAY1dMprfJl60hV+wk2aqv3CYrVoliJaE1tuaMgt1cLipHvHD+2plgNtL3eybOH0eGEAYvytUIH0CpabkqlMq33NSV4lfSoE5HMjvW1ElDQB3u6x98/UH4jofvxED/k/EF+s7doiLTdyQ3zM4kAtrOCQzXkTb1Py16hso=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(38070700021)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dUVRL3ovbEx2U2tONytlR1AyckVNYjh0WGdkKzZibG9GUmk5TFIyWHF0UkdC?=
 =?utf-8?B?YXhNdEk2Ums5NHNjaXJNbUdrQ2ZheW5sR0I5enhBVloyZFRSeEhJVllJTzR5?=
 =?utf-8?B?dFBTTlRlM1h1TFpVWi9vM2d5b3RUSUFnSk9ZcUtwczdXbGliVEJRZ2VjUzdU?=
 =?utf-8?B?MFBMcGY3WUYyTlJja3VJTHFBdDJralcrSzdBaWNWeCtCK2Q1QzdOdnRmUTZj?=
 =?utf-8?B?Uy9uSGxxR3BwU2s3bUlrTk5tSzF4UndLSXNPNXBOei9kRzlrdlVnd1A5NU9w?=
 =?utf-8?B?Q3BGRjNpVnQ2MExmd0xTald2WHZIdVFpWm9yOStOTnlHNDg1R2MvdURCQUlQ?=
 =?utf-8?B?NXp2cnIwSXZFelR4YjBaR1BaSWpCUGlqY1A3ZHZlOWxsSUEvalcwUnV1S2Z4?=
 =?utf-8?B?UWw5cXBXeEIrcGdnOFlicWxYT1NiNjE4NFIyNWlDSktWSGwzZmZpOUYxb3ZY?=
 =?utf-8?B?MlptV1ZXWjFaOG5yN1Y4VTRVU3NBYW9pa3JZU2p2dVl3M0xFSjZjUm1TZ3JS?=
 =?utf-8?B?M0wyUVZ3MEd6akV3L25nZFZqdUh3ZDNUVk1MYlVWS05iMDRvOFR3cTR2N09z?=
 =?utf-8?B?R1NsUnFwMG9lSzdmL0ZhOHJZeEl1b1Z0WjM2ZFNaNUl3ZFJXTUpiWi8rMWps?=
 =?utf-8?B?cG54eldrNkI4ajRZWThURXN1aU5CNVFNN0RDNDlCYnRiK1R2MUFsTU4zcjE3?=
 =?utf-8?B?L3FnMk01NHF0enpXK0ZTa2dmbDA1NjMwRnRvemRweDE5T2NaQ2krM29qMTRK?=
 =?utf-8?B?OUxpSUtFOUhuNytMTEUvWkhwV1dIM2Urd1E5cXN2c202TEtrT3VZZzFVOWZ3?=
 =?utf-8?B?ZXJNMWVYeVFLNUMxMVZOQXpYMlpzQnRHQkN1SU1HbGVzTFdmelhtTjVJUDdV?=
 =?utf-8?B?cE5QbGJOYjlPeHhmMDE0allxcWY4QWpMNjlqRjBLS25sTis4cml2dGVRcnhW?=
 =?utf-8?B?QUYzcnZUazIvK1dlY2g5a2Y5RHVBdkhqTE5TNDJSMkdjTlhOZ0VVWEUrY1J5?=
 =?utf-8?B?RVJ5VEV5NnBTK2hFSk5LQVcvZ05UV0hxYzRSaXhpRkhpK0paNkh4MGtJaGZY?=
 =?utf-8?B?ZVpQVXpBaUpaVGtkOUZsU3E3SXZoeWlLR0NNN0gyZ0t0U2dDVEs4Zk5rSVFM?=
 =?utf-8?B?ZDlmYmdyN0N4UVJDWmxheldYMDEyak9QQ1I2QkRwYWJmNm1uVERVZmRJbzYw?=
 =?utf-8?B?dmxzbGdqN2dRS3NhZFR4TkpUQ3VCOHM1MVlub3czbUowV3gwV1NGWXpENEEw?=
 =?utf-8?B?YjA1V05FYXQ2eThBS2lEV2xmZlR6SC9sbXZ2dUZ0QlNXNy9zNEgwYXlEUUpq?=
 =?utf-8?B?OWtNYU9hbWIrMzBEeXpRaUFKYlRRVnVZazlvVUlPQkNKZ2dGcExtRlJzcFBN?=
 =?utf-8?B?QXNrdGowUlFkMWVrbjV0dnpIUklGNVg2dGVpRm9oMWVUZXZSTFFoSEF3dTEy?=
 =?utf-8?B?TldmSlZ3a3Q2ZmZINFZBR25ubTZwaDZjQUxoR3BrdjE3QVkzbUZNdDAzU0dm?=
 =?utf-8?B?R0tUSFZ1VU42MjJBdUZoRXdiMUFEc0VOZXZPRUNZdVIxK2VBbEh2VmRhYms4?=
 =?utf-8?B?Q3RYT3hNWjJwWkU2SXI4S2FGK0FCa3hEYkJUc0t2dFVjRzIzOG9NVGQ5em42?=
 =?utf-8?B?NHVoeUcxK0wxTXl3L1NQcHpkbzRidG9qSWc1SHJwV29DeTJiWTRHZzkraERa?=
 =?utf-8?B?YUZmNElJTVk5OFVnMkdqYVg0Wk5vejBUOVhpRkF4WXBwMzZuSlgvT3F0QzZV?=
 =?utf-8?B?dXdjNElhc1NXVzM1K2NqYmVBYnhPVk9mNUlOMWVlUS9kdkJQZ29MR2FLM2ZL?=
 =?utf-8?B?NHVDMHA1RFhkT2Fpd3RtZkVOZ0l5WjA1VmNBV0t3NVFlRDNONVZqbnlGY2tT?=
 =?utf-8?B?WkdyYkJHYzl4a01wSXJIaTE2NjJZU3Y0KzRGek9YdjNrY0F2RlQvVHlDdDVr?=
 =?utf-8?B?dW5NV1pNMVRTK0Rpa1dCcXBIU0JxYmxvdy9HV2VxK1J2Y0FOc2c3SE5ySmJ2?=
 =?utf-8?B?Q2U2SURqSE9vZU01MW1sUEcveUx6eHJJUTNDb0J3Um5ZYlcvUFpBdk1Tajgz?=
 =?utf-8?B?WWxhdW02Qjl1SGJsbU54VzMrbHpra0NGdFZwSkVYZnNCVFFwK0cvbWVuUXNj?=
 =?utf-8?B?WjhFTHRPQzFrWnJoUHpPVndVYXp0ZlhGd29MeWtYTTZkUnZRU3lDcFI2REhp?=
 =?utf-8?B?RkoreXdVNjN5MXFQelI4UVBLMTQ1Rnh6akw5Vk9tc1l2UjVPeEY4RzAzeGdJ?=
 =?utf-8?B?d3BTU08yNjNXRnd2aEF3ZFIvQWtqTzE1cWJJbSsrL1lCcFNYYjlXc1NxZHkx?=
 =?utf-8?B?U3Y0MjZqSk5teVBsUDJWTmI0K2tRTFlERTlscndia1RLWm9KNURpUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee480bb-e667-4b3d-cd01-08df01e6e986
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 13:52:18.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPTltrKAUoG8m09g5ywM0W9Xk/juP5nWllj2JHaXjDh+WZWSEasH8V/Vc8vCGcaHwtF8P7qCNIw7ecM1z+Zu0nFoH7XOUgRzR1mE/nhGb/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 13:52:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20028

PiA+IFRoZSBpbnRlbnRpb24gd2FzIHByb2JhYmx5IG5vdCB0byB1c2UgdGhlIGxpdGVyYWwgc3Ry
aW5nLCAidGFza25hbWUiDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBMYXBsYW50ZSA8
Y2hyaXMubGFwbGFudGVAYWdpbGVudC5jb20+DQo+ID4gLS0tDQo+ID4gIGxpYi9iYi9ydW5xdWV1
ZS5weSB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbGliL2JiL3J1bnF1ZXVlLnB5IGIvbGliL2Ji
L3J1bnF1ZXVlLnB5IGluZGV4DQo+ID4gYTQ2ODllMTM0Li41NDQwODEwNTMgMTAwNjQ0DQo+ID4g
LS0tIGEvbGliL2JiL3J1bnF1ZXVlLnB5DQo+ID4gKysrIGIvbGliL2JiL3J1bnF1ZXVlLnB5DQo+
ID4gQEAgLTg0LDcgKzg0LDcgQEAgZGVmIHBlbmRpbmdfaGFzaF9pbmRleCh0aWQsIHJxZGF0YSk6
DQo+ID4gICAgICAobWMsIGZuLCB0YXNrbmFtZSwgdGFza2ZuKSA9IHNwbGl0X3RpZF9tY2ZuKHRp
ZCkNCj4gPiAgICAgIHBuID0gcnFkYXRhLmRhdGFDYWNoZXNbbWNdLnBrZ19mblt0YXNrZm5dDQo+
ID4gICAgICBoID0gcnFkYXRhLnJ1bnRhc2tlbnRyaWVzW3RpZF0udW5paGFzaA0KPiA+IC0gICAg
cmV0dXJuIHBuICsgIjoiICsgInRhc2tuYW1lIiArIGgNCj4gPiArICAgIHJldHVybiBwbiArICI6
IiArIHRhc2tuYW1lICsgaA0KPiA+DQo+ID4gIGNsYXNzIFJ1blF1ZXVlU3RhdHM6DQo+ID4gICAg
ICAiIiINCj4gDQo+IFllcywgdGhhdCBsb29rcyBsaWtlIGEgZnVuIGJ1Zy4gV2FzIHRoYXQgYnJl
YWtpbmcgbXVsdGljb25maWc/DQoNCkFzIGZhciBhcyBJIGNhbiB0ZWxsLCBpdCBkaWRuJ3QgYnJl
YWsgYW55dGhpbmcsIGFuZCBJJ20gbm90IHN1cmUgd2h5LiBUaGUgY29kZSBoYXMgYmVlbiBsaWtl
IHRoaXMgc2luY2UgMjAxOSwgY29tbWl0IGE3NWM1ZmQ2ZDQuIA0KDQpJIGd1ZXNzIHRoZSBoYXNo
IHdhcyBzYXZpbmcgdXMuDQoNClRoYW5rcywNCkNocmlzDQo=

