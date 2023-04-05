Return-Path: <Joakim.Tjernlund@infinera.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC66C76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 09:09:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.46])
 by mx.groups.io with SMTP id smtpd.web10.125617.1680685757048751779
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 02:09:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@infinera.com header.s=selector2 header.b=rXcp65c9;
 spf=pass (domain: infinera.com, ip: 40.107.93.46, mailfrom: joakim.tjernlund@infinera.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCQj0k0+6LjlzpbvP91ChkBH30a6WhTXf4th7crhYw89IRlRIHf7Vd4I/LNVQ0aFHLl5Uf8ggfktQGr6urWxTL6amahOIwNhh2M6uywu4JQlRAeyfBcU3zL+JQVWWFNguUHpIGzjjBxgfQTsjyrbv428pXCjDxMa0/2WHuGmrMfeKxtGvELV0wLpD92ol35nimOAcn01sOyaEFDvEenRd0OIwaXIpCbjzPEuw/+oVZhk+kc2M2XcF/XeLpDoB0FjkqwhQ+huMiYngdhTZSD0/Ov+KLj3zcQn3UNfyXaYRQpJcgfLt92DFugzn9irDGe1bAqT6ub75jwAf/kVjm/pqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZH3H/yuvTaTgZaFaZU+x6jB+r5UtrOV7qMwX5VlLA4=;
 b=aUt/juGVJ9Zc/PGwTfGZ9JsNWg6W7Osr2y5P5GYTflUuIixc6dM5j1lKjR5hNhqmnpAq1fzxRM1UHklmozScoSGSj6JFN5lE1CRdodvyMEyktyu1aEfsZxCkEOaWJeAeTsr093TGCfogq7Fw6BUlDCZBMhmhblpodwKW6vMnxaIbLlKqUuhM0nF2ofwNdBLvYdB24lV5Rs357fIgkEwUVViDh8WLOhtTYG/oxby0TbI16atmL7avvx2wlrb/i546aJehYOrLr1IgPfenzKcaqaSjeyjvXPaVDNOJERs7rxeSmALRfvok8Aqxbotw2d7/w6OZ3/tSXafd0KJbZ32VZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZH3H/yuvTaTgZaFaZU+x6jB+r5UtrOV7qMwX5VlLA4=;
 b=rXcp65c9dQy+B10hNo8aB7FeRwO5H29dCvZksaHYOQWf0qSK+BrBVsnQ+Sf1blk8p+MfVw0t2XlF4PXL/PDPj6YnW29dAh+pvHyvvTETMAd8XOWdy6PER0tAnRv5DdVrNneibaMI/2RRXxONwOukKlpHksJGQPoB5upIh3eLwA95ThfWaUN5DM/TMVBOJNRZuyBw+TwnC7BMk2rv2I7CmTmUjGKAuy1Y+R51ltkZ4agD6+JZzLZaYQulk+JYKjENjc33C2nzSS2dI9u7h9Yd39dGXSipm2H5+QBOC+eCVAOjRhaSc2+C/HoQ5GfIQll0w+u7FJe6vY/ER35XjjSDlg==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by PH0PR10MB6957.namprd10.prod.outlook.com (2603:10b6:510:285::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Wed, 5 Apr
 2023 09:09:14 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::75fa:a159:8722:b9f9]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::75fa:a159:8722:b9f9%5]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 09:09:14 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "ernstp@gmail.com" <ernstp@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] building python-inflect ?
Thread-Topic: [bitbake-devel] building python-inflect ?
Thread-Index: AQHZZzMLji7qD3GRKECuFCU/tl240q8b0KOAgACdi4A=
Date: Wed, 5 Apr 2023 09:09:14 +0000
Message-ID: <3b5cd3a10aafb8392dcf26d38ab5437a4d3ae1d9.camel@infinera.com>
References: <43210b1ce3260a74b29f28db3125aad206612ac9.camel@infinera.com>
	 <CAD=4a=VVXxX-OW2sSzsNaji8uqRsp15yxkYpgDZUgdwFqsK-qQ@mail.gmail.com>
In-Reply-To: 
 <CAD=4a=VVXxX-OW2sSzsNaji8uqRsp15yxkYpgDZUgdwFqsK-qQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.0 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|PH0PR10MB6957:EE_
x-ms-office365-filtering-correlation-id: c8a7c2a0-e511-4742-4194-08db35b56d5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 n1PRPqW25hoIeQGV1BdpbxT8GmeWXZHJKRJaD5o+KV341r8VTGWrSQ75Gt9du6KVZ1sh3t0XvV9Lm9J1f+cQnZUPlVRKNduB3auc4K9O8V4bH8V/csNm9YX8Ntrq4CSbWeDpGtMopSObIqegm2fk9rvo36/Ybl6+fx2ceMs3K0vhCqUW0aTR+cqnTQ+dMu2IyXHjpUoSbKA7F9jLrygVRk/vXV6B5nty09ibCZv+5rVd5pO0F1gVY3z98sZ9VhMdSE/JmN+UY7Q52gYxbOVpqVcFCozahffHm0eqB6TFSaCzehdXYeChX3IcVKLtqaP8yRB8dnsSvPvNX/w1cfSdkMUUDgkPd8qjwULAVh4nEhXKFGtrNlAEj7nJD8NvGPHnoHBSz+yLyS5yrE+N6rveQanow4Ula68doH2u4Akvh2QIES1TMJp5d5HvzjuiEq92Mdm/fBRtMQtiVRYHTDr2CzPuaAtkyblBwr0gdTZZneyJXUOr+8RkVBHIQB5bLMO12z8fWOrDBDG8b18Unr+gJQTBaKfDF8WUo2cIxqap2CXBfdtVSxmhTDURdCn+wNCZGRpaqnxkfk+6zoLHmHE3eW76LBHNQD3/zLCx+UyWv14=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(45080400002)(2906002)(4326008)(478600001)(6916009)(316002)(8676002)(5660300002)(66446008)(66946007)(91956017)(66476007)(66556008)(76116006)(64756008)(6486002)(41300700001)(8936002)(71200400001)(66899021)(86362001)(966005)(38070700005)(6506007)(6512007)(122000001)(38100700002)(83380400001)(186003)(36756003)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SGZuOHhibWlPMTd2MnhJaklYTlNHN29mRnBWdzBvb2QxSElXSlhJaGhrUWZK?=
 =?utf-8?B?WG1pRjRtUk5WUjJtbWh6bXpMcHlWMFBrcnpNdTFKRnk0aGh3ZE5KUFlRQ2ZZ?=
 =?utf-8?B?d3Jya3ozWENndFZtWHJ5RE9WTDB5RmZvQWpwc3BnZ0hSZUhyZFdDMWdIVUxH?=
 =?utf-8?B?eVZ3VzRCVU5Ed255dFJ4Q01iTE12emtyYS9HNE8yZWd5eWdCM24xV2pjR2do?=
 =?utf-8?B?ZUMwekV3YmFiYW1HVW9PWTJ1YVlFaHVGZzNaRXRlWE5NYlB4SnZFVlo0bllV?=
 =?utf-8?B?OUdhd1c5QXNOb0dIcUllSWxwZFF3cDlpZ2JIMWdmbGd3UEFaK1Q1cXhEbCtn?=
 =?utf-8?B?YjdCVkNUUkJ6WXpPNW53M0pBdUdXenp1cjJ0ajNJWVl3OTFPOWo4L3pweklt?=
 =?utf-8?B?ekhsSlJCbzJaMkpQRWxVSTA2VW9RQThCWGdQV2twVjAzNi9zZ2pxK2R0N0Mw?=
 =?utf-8?B?Y2NDYjBLZ2ZHanhoUzQ4bld2a1FJMW4rMGlVNURKbi9PZEtiLzFDV1ZpVHUx?=
 =?utf-8?B?MWNhNlJHK2pSYXF6QVNHa0JvdUVzOGVXYnBMQXRyczlYTjN1OEI2eVpZS25X?=
 =?utf-8?B?cDRiTXRFSkZVMnBreVRFZG50bVhJNVZqRVVkeEZTSkZWbWQ1eXFJZ1FsSnN6?=
 =?utf-8?B?RjV2NW1KOGRyR3JESkVDQi8zNzM3a1FSL1p5TWw5VlBuMWJ2YmVDeTlXMUkx?=
 =?utf-8?B?UUN1a1dGMTR1ak1kK2VuRzJUdjNEQVJ6bEFxbGlKU29tdUFIMkxDUkEwRmV4?=
 =?utf-8?B?ZG1CekpkOGE0NCtTU0VXU1N4dElETGlLRU5icHRkWlVaaiswVnpYMlczU0hP?=
 =?utf-8?B?SXM3bXJMUnRDQnhJMys4SEJ3ZFJGTTlBTnN4VG11LzFkUTZHQ2RTKzJTWldE?=
 =?utf-8?B?anB4VUZSd3VnY1BpS2pheXdVSlR4OFJuUndaVlYybXA5UXNKdXRjY2c5Ri9m?=
 =?utf-8?B?OGhUZTl1QkcrOWpMYUI3Vy9mK0JhZjZZa08rN0JNMGpHZTZFZlN3TlJwaCtk?=
 =?utf-8?B?bjBOM2s0c2JWNVNMQUZpRTgrb21USVB0Vm9xeEhZMndTZENDejJaWnQrWGRS?=
 =?utf-8?B?cW0zOWtXQ0l0WDVPUklWTnFuajc1S2tzOUJhazRLNHJyUVFveFZQb2xTZzJH?=
 =?utf-8?B?ejFLV3F4cFVXOXVVcko5YUw1QzVtSzlSZ0Q3T1pteGR5cGNVUktXU01McEpw?=
 =?utf-8?B?WkRTdnVBNUQ3RFhSZkRKZ2M1aDJMWlEvMkg3K1JjZC9scWN0c00xV2tCOUta?=
 =?utf-8?B?aDlKWENvdlVhMmNBZjRYbmtzMFhOSDlRT0lqWGUwZ2FjeTIyUjdjOHJIZWZr?=
 =?utf-8?B?WUEwRzFLOVVwRG1ScEl3TlVOa3ZOeTVDMXJUTFoxbDViM2p2bE9GTk1VZllr?=
 =?utf-8?B?UnF2cllpcGJtcTNVa3grODlLelVod25OUFR1UDFhcUU3MzdJM1pOVURDZ2x3?=
 =?utf-8?B?aGY3K1Y0L3ZpWGFTZUZLczRHOWZIMTAwaENSckcyYjRyKzFCbFE3ODJjWjB6?=
 =?utf-8?B?MHNvQjJjWVlaUlVKRGJCR2ZjbzRuZzV5SzVLcHBPQkw4VERHRTZQV1dINko0?=
 =?utf-8?B?aWdjTjF1ekNBejRrcFVwalBiT0NqT1dPanR1K2tFQ1laTDQrZ0M4RTRRTUFO?=
 =?utf-8?B?bU1aSENXOEw4NHJieWNyWmhqRElyMUZ2dmUyRXdoQi9PeEZyM3A1QVJUS3VJ?=
 =?utf-8?B?VVdOcDJoMm55WXhlbmRFQ29IczhKMFRhOVQwNTRwd2hqRkNSQWFKQmZtajY2?=
 =?utf-8?B?c20yVGM2OUdIWUQ1QW9sNTlMUElyVjBrVXRsL0s2QjVWZ1h2UENLZlNZUVRF?=
 =?utf-8?B?L3hKZnloL3dOT3VQWXd5cGRrV0tvelRQZDZoL1A4dlpaY2dNUlRLbzVkRzBU?=
 =?utf-8?B?ZnNvQitoQjFJOWhiT1h3L2lNa3JYYkhLYjRLUytmZktmTEQ4Tkt2MllGdWFL?=
 =?utf-8?B?a0VhNzQvdE5IL2VRa3ArKy8zOXdDWXJQSW5rV01McHp5SExmSEkvQ1lDV1BE?=
 =?utf-8?B?VmYyL1k3SHNNZGQ3S2tVMElMMi9Td3RWdDdzVXhpTHlNUnRWL3R2cnoyb0Jz?=
 =?utf-8?B?ZnJNYTFvbDZuUWhHMnFtZ2preVJTb1NKeDBkSkpMdmI0RGdEYWx0Z0VOeFpx?=
 =?utf-8?B?NklVYytoRG5ybks2by9JU2JOOHpGSHBIb2tYS3lZVnA4d0l4bmFnaWU1aE1x?=
 =?utf-8?Q?0HHCX92vRfnEp/5SPNxg7I5fj1FoKb7KlN9dE6UbZjpp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6B2BAF3B66A4840B4CBB3677403B93F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a7c2a0-e511-4742-4194-08db35b56d5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 09:09:14.2894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtQfkrevezaaG4YvSHZ8H6yrr8yXNzgFZlp8jrQzEqZ5Aa+f3igLvyFFBjwl2c4lEVk0TYTL4V1cHTsf5rpiug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6957
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 09:09:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14640

T24gV2VkLCAyMDIzLTA0LTA1IGF0IDAxOjQ1ICswMjAwLCBFcm5zdCBTasO2c3RyYW5kIHdyb3Rl
Og0KPiBJIHRoaW5rIHlvdSB3YW50IHRvIGFkZA0KPiBpbmhlcml0IHB5dGhvbl9zZXR1cHRvb2xz
X2J1aWxkX21ldGENCg0KVGhhbmsgZm9yIHlvdXIgaGVscCwgSSBsb29rZWQgZm9yIHB5dGhvbl9z
ZXR1cHRvb2xzX2J1aWxkX21ldGEgaW4gZHVuZmVsbCBidXQgc2VlbSBvbmx5IHRvIGJlIGluIGtp
cmtzdG9uZSA6KA0KSXMgdGhlcmUgc29tZSBvdGhlciB3YXkgaW4gZHVuZmVsbCA/DQoNClRoZSBl
eGFjdCBwcm9ibGVtIHdlIGhhdmUgaXMgdGhhdCBpdCBidWlsZHMvaW5zdGFsbHMgZmluZSBpbiBi
b3RoIG5hdGl2ZSBhbmQgbmF0aXZlc2RrIGJ1dCBpcyBvbmx5DQp1c2VhYmxlIGluIG5hdGl2ZSwg
aW4gbmF0ZXRpdnNkayBvbmUgZ2V0IGEgTm8gc3VjaCBtb2R1bGUgd2hlbiB0cnlpbmcgdG8gaW1w
b3J0IHRoZSBtb2R1bGUuDQoNCiBKb2NrZQ0KPg0KPiBSZWdhcmRzDQo+IC8vRXJuc3QNCj4NCj4g
RGVuIHRpcyA0IGFwci4gMjAyMyBrbCAyMjoyMSBza3JldiBKb2FraW0gVGplcm5sdW5kDQo+IDxK
b2FraW0uVGplcm5sdW5kQGluZmluZXJhLmNvbT46DQo+ID4NCj4gPiBUcnlpbmcgdG8gbWFrZSBh
IC5iYiBmb3IgcHl0aG9uLWluZmxlY3QsIGh0dHBzOi8vZ2l0aHViLmNvbS9qYXJhY28vaW5mbGVj
dCBidXQgdGhpcyBwa2cNCj4gPiBkb2VzIG5vdCBoYXZlIGEgc2V0dXAucHksIG9ubHkgYSBzZXR1
cC5jZmcNCj4gPg0KPiA+IEkgZG8gbm90IHNwZWFrIHB5dGhvbiBhbmQgY2Fubm90IHdvcmsgb3V0
IHdoYXQgdG8gZG8sIEkgZ290KGNhbiBzb21lb25lIGhlbHAgbWUgZmlsbCBpbiB0aGUgbWlzc2lu
ZyBwYXJ0Pyk6DQo+ID4NCj4gPiBTVU1NQVJZID0gIkEgcG9ydCBvZiBSdWJ5IG9uIFJhaWxzJyBp
bmZsZWN0aW9uIHRvIFB5dGhvbi4iDQo+ID4gSE9NRVBBR0UgPSAiaHR0cHM6Ly9weXBpLm9yZy9w
cm9qZWN0L2luZmxlY3QiDQo+ID4gTElDRU5TRSA9ICJNSVQiDQo+ID4gU0VDVElPTiA9ICJkZXZl
bC9weXRob24iDQo+ID4gI0xJQ19GSUxFU19DSEtTVU0gPSAiZmlsZTovL0xJQ0VOU0U7bWQ1PTJm
YjZmYTFhNmYxNzkyZDc4ZGUxOWFkMWJiNjUzYzMxIg0KPiA+IExJQ19GSUxFU19DSEtTVU0gPSAi
ZmlsZTovL0xJQ0VOU0U7bWQ1PTdhNzEyNmUwNjgyMDYyOTBmM2ZlOWY4ZDZjNzEzZWE2Ig0KPiA+
DQo+ID4gU1JDX1VSSVttZDVzdW1dID0gImU3YWFkOGYxNjFlZTljODVjN2QxMjVhZjY5YWU2NjFm
Ig0KPiA+IFNSQ19VUklbc2hhMjU2c3VtXSA9ICJmMWE2YmNiMDEwNTA0NmY4OTYxOWZkZTFhN2Qw
NDRjNjEyYzYxNGMyZDg1ZWYxODI1ODJkOWRjOWI4NmQzMDlhIg0KPiA+DQo+ID4gaW5oZXJpdCBw
eXBpIHB0ZXN0DQo+ID4NCj4gPiBTUkNfVVJJICs9IiBcDQo+ID4gICAgICAgICBmaWxlOi8vcnVu
LXB0ZXN0IFwNCj4gPiAiDQo+ID4gI0RFUEVORFMgPSAicHl0aG9uMy1weWRhbnRpYyINCj4gPiBS
REVQRU5EUzoke1BOfSA9ICJweXRob24zLXB5ZGFudGljIg0KPiA+DQo+ID4gUkRFUEVORFM6JHtQ
Tn1fcHRlc3QgKz0iIFwNCj4gPiAgICAgICAgICR7UFlUSE9OX1BOfV9weXRlc3QgXA0KPiA+ICIN
Cj4gPg0KPiA+IGRvX2luc3RhbGxfcHRlc3QoKSB7DQo+ID4gICAgICAgICBjcCAtZiAke1N9L3Rl
c3RfaW5mbGVjdGlvbi5weSAke0R9JHtQVEVTVF9QQVRIfS8NCj4gPiB9DQo+ID4NCj4gPg0KPiA+
IFJERVBFTkRTOiR7UE59ICs9ICIke1BZVEhPTl9QTn0tcHl0ZXN0Ig0KPiA+DQo+ID4gQkJDTEFT
U0VYVEVORCA9ICJuYXRpdmUgbmF0aXZlc2RrIg0KPiA+DQo+ID4NCj4gPiAtPS09LT0tPS09LT0t
PS09LT0tPS09LQ0KPiA+IExpbmtzOiBZb3UgcmVjZWl2ZSBhbGwgbWVzc2FnZXMgc2VudCB0byB0
aGlzIGdyb3VwLg0KPiA+IFZpZXcvUmVwbHkgT25saW5lICgjMTQ2MzQpOiBodHRwczovL2xpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcvZy9iaXRiYWtlLWRldmVsL21lc3NhZ2UvMTQ2MzQNCj4gPiBNdXRl
IFRoaXMgVG9waWM6IGh0dHBzOi8vbGlzdHMub3BlbmVtYmVkZGVkLm9yZy9tdC85ODA2ODYzNi80
OTQ3MjY2DQo+ID4gR3JvdXAgT3duZXI6IGJpdGJha2UtZGV2ZWwrb3duZXJAbGlzdHMub3BlbmVt
YmVkZGVkLm9yZw0KPiA+IFVuc3Vic2NyaWJlOiBodHRwczovL2xpc3RzLm9wZW5lbWJlZGRlZC5v
cmcvZy9iaXRiYWtlLWRldmVsL3Vuc3ViIFtlcm5zdHBAZ21haWwuY29tXQ0KPiA+IC09LT0tPS09
LT0tPS09LT0tPS09LT0tDQo+ID4NCg0K

