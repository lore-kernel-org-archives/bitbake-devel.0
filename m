Return-Path: <Joakim.Tjernlund@infinera.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B0C7619A
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 09:46:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (NAM02-BN1-obe.outbound.protection.outlook.com [40.107.212.59])
 by mx.groups.io with SMTP id smtpd.web11.126096.1680687985695782830
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 02:46:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@infinera.com header.s=selector2 header.b=lJFFWKXG;
 spf=pass (domain: infinera.com, ip: 40.107.212.59, mailfrom: joakim.tjernlund@infinera.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csBxU8bA4Xksk+1CaaUxgklMq2agAqZSczSWutHTdVkmpTpbKy3klFHHg2Z1YtUX4ugRXhaPOXAq7AffLLl6MsA68A8nsGqCEc+wuUZ8FxXiSheTClzIca6ZDLJtDAUVW5106vmNyRhyLLpsSK9t1Dw//K7IctfXzSeke5iZJhnRKUwtJkYe03DO3hz2fhbm8F2dWC3zdJLOVXIXJEHHtRafjVvtTPlcqf03kFrw5jKUlOkAeoV1bx0pXqH33E2L+qqHUlxmVF3B/qzyAYTtZKrHbUmqWZEAyWfHZu3ob/inLYKpa7Eh8DFhujtCQRwrqxGV1ci/U5Tc5udDAQLGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNVStA3UnFw+Y4axouziWArczs7wAA9c64iDGSJ/WYI=;
 b=jr/qSLoZEkc1JW/SnXnHuSxytIH1cd8WSuC8u5vMrsm4atU6a+n6ZzQd7eASM59WqNmbdgz1CdgVF6BnY0g2ugRTYTPoslsX6N+/DMQ7fCNz14M2FeZ6ug5rMBPO1UmokcFOAB20P7wF+3HqEb3YBzAaaqgAccvOdPJp9cqZjsfyK9qQUWTyqliZsO7CaKAccIUNk7m2WUA9BS2bmSB3Ar0bQaX7OmvNXYIA8ycDnUXSzNovFZ11qBr5sQEu8ze/ZOcBssfXVBmuehtbkVymaNUpbrWCcmIb6GOHg4d3WyiYA4iJ4fZUrgpIBz+nMJJrmfJ4vUmQsCAe8bM4Ru2aCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNVStA3UnFw+Y4axouziWArczs7wAA9c64iDGSJ/WYI=;
 b=lJFFWKXGdNd1uaHwHokmlELIm1fLgu8UNV09d9ihrUhMqartig5TmXOHsnd3/pt5tisqSWy6PikTQP1nZDBe1eLxs6Y7OHSplyfQJOMDjfg8DQeS/a8wOQZmEobUapooqLzEbf8FBKQ8nefXrsZB2BtbBGMuLowKU8Vm6ORV4EVTtQ/s2xUrXnc/AJwMfY2YF3VrfkgORw7WxWgCtZt8CQtDfbMHEoiJCoQsG+3Qb0iC+rSBLHOeApoU2p0CaAlNIZBbrzWUzLLgo5/nXKWhvR2VOHTCiMrPnVVKu/SyZXq/LNfIND73MkNA9inu2TCs8QmO2YFvLcWF5Esy3hG/7w==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by DS0PR10MB7150.namprd10.prod.outlook.com (2603:10b6:8:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 09:46:22 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::75fa:a159:8722:b9f9]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::75fa:a159:8722:b9f9%5]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 09:46:22 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "ernstp@gmail.com" <ernstp@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] building python-inflect ?
Thread-Topic: [bitbake-devel] building python-inflect ?
Thread-Index: AQHZZzMLji7qD3GRKECuFCU/tl240q8b0KOAgACdi4CAAApggA==
Date: Wed, 5 Apr 2023 09:46:22 +0000
Message-ID: <0ee560cd83d3a5c0ddaf2a413cf885d550da5f47.camel@infinera.com>
References: <43210b1ce3260a74b29f28db3125aad206612ac9.camel@infinera.com>
	 <CAD=4a=VVXxX-OW2sSzsNaji8uqRsp15yxkYpgDZUgdwFqsK-qQ@mail.gmail.com>
	 <1752FECABD82DFDB.3977@lists.openembedded.org>
In-Reply-To: <1752FECABD82DFDB.3977@lists.openembedded.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.0 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|DS0PR10MB7150:EE_
x-ms-office365-filtering-correlation-id: b32b2c34-2e33-4d06-3be9-08db35ba9d85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NfjySnWX9Hjcj5JOSgQ5yPDYy5iuuOFH4hDVENPIbk7fIoKZL2i3WxfqWGjn6WGEIGnbXzIuruP6e1QkpSed71Ua6lLCZXXpY1YMggFpNSboJi8OLjnw5STc4+5E+j41TL+pV2jWkHXibjSNfiA1BHNExI5WK+iBBcvfRj3knewk6CBaqhkugj+SXoAW/gj/nzAbEaQXhRVDRgFjw++ALsJB8QEe8PkUrWnR0fd8ePAtMUCBkf8vAbN2Z42YrAuBdUqDclMnOfo3vl5eWtQMuQ2IJGzPmC73HvDKYDjSAl2LaCc+YjujmUSQFXSEfd2gd3lDGnh2d1YvlGzI5GswFKBwi+PPA9Sq5WsmznVJPvzrqix1lxTKdUT/HwcpyMfwv1yQM/70tg67PRcu5YrOvaA1RwcguLx+1SBy7sh0HSpp39bpWuQiwlAHAPh38O6Jo6IlG7aH/zmexx4NKfabPHBIf1DMnhRsPAwXiFNFfdEDc5ndQoqSIZb0fFlAf2zL0yAzHUKg7ZtwPiLgIlMGkkGHPNTcatOGPrOp/A+4Pa3dRA6B+5jYXt/XkuXhSEix0Fdo6MHwdDRvRBpIfglPVrBwji9pFhYEkAk1J8xyPvc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(36756003)(4326008)(8676002)(316002)(6916009)(64756008)(66446008)(66476007)(66946007)(66556008)(76116006)(966005)(6486002)(91956017)(478600001)(71200400001)(45080400002)(8936002)(41300700001)(5660300002)(2906002)(38070700005)(122000001)(86362001)(38100700002)(2616005)(6506007)(186003)(6512007)(83380400001)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NU1zYWhtSzRleVNjNkZUbEd6RUQrVk96dWNQa2RybVZrLzZZS1g4OXUxaW1U?=
 =?utf-8?B?L2VYYVRmaGNBRGlodUQ2SldmR2FCNEJvb0NaY3VuY2wrWXdPZm9KR1BMeUVD?=
 =?utf-8?B?ZGovRUI0bkd0REV3MkN6eVNTSWpnU2wybkhJY1MxNjVSQmRLWXJobytGdFZp?=
 =?utf-8?B?ZTNYcWNPTG1LY2wvb1UzNmYvK29tUDJzaFg4Wmt5MXJHd1dOZmZxcWQxT2VL?=
 =?utf-8?B?Sys2ZndreW5EYmlKdHlIQnhKdFFHOWFNWnhsd3ZlZFRXZXgvMWdWUkhIVFN6?=
 =?utf-8?B?M25zWXNDN2dsT1Awdk9yWkxsOWRFMEtpNy9Ua0VqWmk0SkpzeE0rWENEWnFK?=
 =?utf-8?B?WEU0T0E4aDR5aFRXNUczNXdhYjNBSTV5bFA3YlRQSDZMTFRmeHRKYktqMDB6?=
 =?utf-8?B?dSs2ZWladmx2VzYxbCtYN29uTEFoMVJHUENJUUxoN1B4RjZua28xSytxa1dN?=
 =?utf-8?B?WEttaU4va2NGd0FaZDh2amRaUTNJUWhlSWdMU09FUTVQMXVsU1pERmZHRG91?=
 =?utf-8?B?ZkpZclF4WTNUWmVNVXRWZmpzL0FPM2Z2VmJNWVhxYTBBUTVsRnR0WDNQdG40?=
 =?utf-8?B?YUpxZWdmNTlDV3d6NEE4LzFML1QyQzI4aUhjeUJ5QUdTVFVKSzdDc0hXMDRD?=
 =?utf-8?B?NWpCb1lTYkdLU0JJVVhsVU4xdlBqV3N5YmtVbWQ0SjlYeDN3TENLMVB0c2Z3?=
 =?utf-8?B?RE1vQmVEYkZSOXFKZWt6elhmclpZKzVxWDVEMXRJVkplVTE0M1Nqd3ZIY2hF?=
 =?utf-8?B?ZTllRWZtOHNtbEVzeHR0eVFjMGpLdGdBTEY2QnU0UTRSczRadSs2M0JLZ0ly?=
 =?utf-8?B?MlFBT1k1Z2h6Q2ovcWpBZU4wcEhFMExvMDdiOWlUbTNkNXRlK21oZmdoVlB5?=
 =?utf-8?B?ZXVDdWhkY2lGZXQ3V3RvT1FRYUVnTkIrdks3UUpubVJrR05wWllibWR3ZFBH?=
 =?utf-8?B?ckNzcW56MkF4bnRicFEyd1BHUlhSQnU0RGFUTlBJQ2tjNDdsSEloSnNGNXBO?=
 =?utf-8?B?WEFZMktpdHY5bmhaSk5OK3A2NXRoRHFxMDh2YU44TDRwV3QwelJFMitLQ1lx?=
 =?utf-8?B?MU0wdnlEbEhlYjZPakdLZnJZbHZWMHFlTUxhcFgvbWovNUsrVllMNTlNc2RG?=
 =?utf-8?B?dHBPdWxIZWorVmp4RVFQQ05mS21NQVhWdG5iTlZoNlNaWHVXVTVvZS9WbG56?=
 =?utf-8?B?dmtYaE5WNlZmTlBxT2E3bllZeWdkMVNuMUNocXRFU1NwVTI3V0kwRmphRWdS?=
 =?utf-8?B?M3VWdHJlS0s3TVVTaTM2eXRyWjkwOENiZ2srR21rRmNrY1g0STJKOGc5ajZR?=
 =?utf-8?B?b2toc2JFT2dlN3plcXR6V3hmZlBuZDJ5ZFR5eUdYSWtMQWdXeFRtKzlFTzlB?=
 =?utf-8?B?ZURVTjRteU5FTTlBR2dHVjFYazMyT0RZNnFGSVo1RmxVNmJoc0JYN0NvSHJm?=
 =?utf-8?B?Y2tqek5SS3hUN01ydGUwd1JadXZVcTJJRWUrL0YrZXdrUnl3ZGhoK28yYWY3?=
 =?utf-8?B?R2gyZTJYdmUzZjU1V1RXaEsyV0NUZGJuOW8rcW80NEVMOG1qcDc5TU1aV3du?=
 =?utf-8?B?UmwvVElrNFc5YmREOE1RdytYYmRCaTZEdXhweGFJWkVleGFRcjFOb1pIc25V?=
 =?utf-8?B?Wkx1MTRGcmdxNkZUbmRZYXZjYjBGWngzdVBGcE50YUFoRnpicGdjL1I1VlZD?=
 =?utf-8?B?RTQ3VnhiM1hYUnc2Q0ZlejJueWF4V3BFRDZGR2xhakRtRUpOa1F0NkdqY3VP?=
 =?utf-8?B?bHVWcVVpb3dWQzdhd1ZpRFhrbWxwY2NJcnQyakIvck1PWnc1a1JqYmtEcWNx?=
 =?utf-8?B?Z2J4V3FsQlc0V0RTUkZoanBIbFE2aWhjMS8vYW8yQXhQcDBiSklkMXROdExB?=
 =?utf-8?B?UzFEWkE1VGhkQnVEZXFLY1pjUnJFZ296d1k2UFBwOEF5T0dLOFQ4cjc3YUNo?=
 =?utf-8?B?dTkvMWxIQkgwYm4xZ1g2Y0IrNXN3ajF5TjU3U205TnBYRXFnRkxzZ3lEeEcz?=
 =?utf-8?B?UHl5QzhwNVlFNGNsSjA5S1VYdHo5bk1uUTdCb3RmWHIvOTNRVFF3MVErWjRZ?=
 =?utf-8?B?Mm5hYjRoUWlGK3Jod1l2WlFvdk12MG50dmg5QlZEZlgrdkcwU3Z3eWhiTjVG?=
 =?utf-8?B?cnZyN3FESys1aUhjMFNCRkZLNkdLd09iUzRMRnhkdUdmL3pNQjh2WGt3Z0U4?=
 =?utf-8?Q?VLGBKVcQ5kywhg9OTMFYXxRyAaO/7Ky98uMlKgFgVnYR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1127D4B36913E74A9851807D098AD6C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32b2c34-2e33-4d06-3be9-08db35ba9d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 09:46:22.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ROSGo5xVRCEBcenCDx7uiNGTfP/TGwCeazccOlT62tA/bHKeSkvQ6Cprw4zerUuo5dPMYtgY0QfQg/AIKbrwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7150
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 09:46:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14642

T24gV2VkLCAyMDIzLTA0LTA1IGF0IDA5OjA5ICswMDAwLCBKb2FraW0gVGplcm5sdW5kIHZpYSBs
aXN0cy5vcGVuZW1iZWRkZWQub3JnIHdyb3RlOg0KPiBPbiBXZWQsIDIwMjMtMDQtMDUgYXQgMDE6
NDUgKzAyMDAsIEVybnN0IFNqw7ZzdHJhbmQgd3JvdGU6DQo+ID4gSSB0aGluayB5b3Ugd2FudCB0
byBhZGQNCj4gPiBpbmhlcml0IHB5dGhvbl9zZXR1cHRvb2xzX2J1aWxkX21ldGENCj4NCj4gVGhh
bmsgZm9yIHlvdXIgaGVscCwgSSBsb29rZWQgZm9yIHB5dGhvbl9zZXR1cHRvb2xzX2J1aWxkX21l
dGEgaW4gZHVuZmVsbCBidXQgc2VlbSBvbmx5IHRvIGJlIGluIGtpcmtzdG9uZSA6KA0KPiBJcyB0
aGVyZSBzb21lIG90aGVyIHdheSBpbiBkdW5mZWxsID8NCj4NCj4gVGhlIGV4YWN0IHByb2JsZW0g
d2UgaGF2ZSBpcyB0aGF0IGl0IGJ1aWxkcy9pbnN0YWxscyBmaW5lIGluIGJvdGggbmF0aXZlIGFu
ZCBuYXRpdmVzZGsgYnV0IGlzIG9ubHkNCj4gdXNlYWJsZSBpbiBuYXRpdmUsIGluIG5hdGV0aXZz
ZGsgb25lIGdldCBhIE5vIHN1Y2ggbW9kdWxlIHdoZW4gdHJ5aW5nIHRvIGltcG9ydCB0aGUgbW9k
dWxlLg0KDQpJIHNob3VsZCBhbHNvIG1lbnRpb24gdGhhdCAiaW5oZXJpdCBzZXR1cHRvb2xzMyIg
bWFrZSB0aGUgYnVpbGQgZmFpbCB3aXRoIHdpdGggbWlzc2luZyBzZXR1cC5weSBlcnJvciBtc2cu
DQoNCj4NCj4gIEpvY2tlDQo+ID4NCj4gPiBSZWdhcmRzDQo+ID4gLy9Fcm5zdA0KPiA+DQo+ID4g
RGVuIHRpcyA0IGFwci4gMjAyMyBrbCAyMjoyMSBza3JldiBKb2FraW0gVGplcm5sdW5kDQo+ID4g
PEpvYWtpbS5UamVybmx1bmRAaW5maW5lcmEuY29tPjoNCj4gPiA+DQo+ID4gPiBUcnlpbmcgdG8g
bWFrZSBhIC5iYiBmb3IgcHl0aG9uLWluZmxlY3QsIGh0dHBzOi8vZ2l0aHViLmNvbS9qYXJhY28v
aW5mbGVjdCBidXQgdGhpcyBwa2cNCj4gPiA+IGRvZXMgbm90IGhhdmUgYSBzZXR1cC5weSwgb25s
eSBhIHNldHVwLmNmZw0KPiA+ID4NCj4gPiA+IEkgZG8gbm90IHNwZWFrIHB5dGhvbiBhbmQgY2Fu
bm90IHdvcmsgb3V0IHdoYXQgdG8gZG8sIEkgZ290KGNhbiBzb21lb25lIGhlbHAgbWUgZmlsbCBp
biB0aGUgbWlzc2luZyBwYXJ0Pyk6DQo+ID4gPg0KPiA+ID4gU1VNTUFSWSA9ICJBIHBvcnQgb2Yg
UnVieSBvbiBSYWlscycgaW5mbGVjdGlvbiB0byBQeXRob24uIg0KPiA+ID4gSE9NRVBBR0UgPSAi
aHR0cHM6Ly9weXBpLm9yZy9wcm9qZWN0L2luZmxlY3QiDQo+ID4gPiBMSUNFTlNFID0gIk1JVCIN
Cj4gPiA+IFNFQ1RJT04gPSAiZGV2ZWwvcHl0aG9uIg0KPiA+ID4gI0xJQ19GSUxFU19DSEtTVU0g
PSAiZmlsZTovL0xJQ0VOU0U7bWQ1PTJmYjZmYTFhNmYxNzkyZDc4ZGUxOWFkMWJiNjUzYzMxIg0K
PiA+ID4gTElDX0ZJTEVTX0NIS1NVTSA9ICJmaWxlOi8vTElDRU5TRTttZDU9N2E3MTI2ZTA2ODIw
NjI5MGYzZmU5ZjhkNmM3MTNlYTYiDQo+ID4gPg0KPiA+ID4gU1JDX1VSSVttZDVzdW1dID0gImU3
YWFkOGYxNjFlZTljODVjN2QxMjVhZjY5YWU2NjFmIg0KPiA+ID4gU1JDX1VSSVtzaGEyNTZzdW1d
ID0gImYxYTZiY2IwMTA1MDQ2Zjg5NjE5ZmRlMWE3ZDA0NGM2MTJjNjE0YzJkODVlZjE4MjU4MmQ5
ZGM5Yjg2ZDMwOWEiDQo+ID4gPg0KPiA+ID4gaW5oZXJpdCBweXBpIHB0ZXN0DQo+ID4gPg0KPiA+
ID4gU1JDX1VSSSArPSIgXA0KPiA+ID4gICAgICAgICBmaWxlOi8vcnVuLXB0ZXN0IFwNCj4gPiA+
ICINCj4gPiA+ICNERVBFTkRTID0gInB5dGhvbjMtcHlkYW50aWMiDQo+ID4gPiBSREVQRU5EUzok
e1BOfSA9ICJweXRob24zLXB5ZGFudGljIg0KPiA+ID4NCj4gPiA+IFJERVBFTkRTOiR7UE59X3B0
ZXN0ICs9IiBcDQo+ID4gPiAgICAgICAgICR7UFlUSE9OX1BOfV9weXRlc3QgXA0KPiA+ID4gIg0K
PiA+ID4NCj4gPiA+IGRvX2luc3RhbGxfcHRlc3QoKSB7DQo+ID4gPiAgICAgICAgIGNwIC1mICR7
U30vdGVzdF9pbmZsZWN0aW9uLnB5ICR7RH0ke1BURVNUX1BBVEh9Lw0KPiA+ID4gfQ0KPiA+ID4N
Cj4gPiA+DQo+ID4gPiBSREVQRU5EUzoke1BOfSArPSAiJHtQWVRIT05fUE59LXB5dGVzdCINCj4g
PiA+DQo+ID4gPiBCQkNMQVNTRVhURU5EID0gIm5hdGl2ZSBuYXRpdmVzZGsiDQo+ID4gPg0KPiA+
ID4NCj4gPiA+DQo+ID4gPg0KPg0KPiAtPS09LT0tPS09LT0tPS09LT0tPS09LQ0KPiBMaW5rczog
WW91IHJlY2VpdmUgYWxsIG1lc3NhZ2VzIHNlbnQgdG8gdGhpcyBncm91cC4NCj4gVmlldy9SZXBs
eSBPbmxpbmUgKCMxNDY0MCk6IGh0dHBzOi8vbGlzdHMub3BlbmVtYmVkZGVkLm9yZy9nL2JpdGJh
a2UtZGV2ZWwvbWVzc2FnZS8xNDY0MA0KPiBNdXRlIFRoaXMgVG9waWM6IGh0dHBzOi8vbGlzdHMu
b3BlbmVtYmVkZGVkLm9yZy9tdC85ODA2ODYzNi83NDcyMDQ5DQo+IEdyb3VwIE93bmVyOiBiaXRi
YWtlLWRldmVsK293bmVyQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gVW5zdWJzY3JpYmU6IGh0
dHBzOi8vbGlzdHMub3BlbmVtYmVkZGVkLm9yZy9nL2JpdGJha2UtZGV2ZWwvdW5zdWIgW0pvYWtp
bS5UamVybmx1bmRAaW5maW5lcmEuY29tXQ0KPiAtPS09LT0tPS09LT0tPS09LT0tPS09LQ0KPg0K
DQo=

