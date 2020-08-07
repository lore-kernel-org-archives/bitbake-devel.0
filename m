Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.76])
 by mx.groups.io with SMTP id smtpd.web12.7252.1596810620407796462
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Aug 2020 07:30:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=E6WrhkCG;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.76, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/hqvuzx+UsFEKA9ceGHiWY6rSd3weJ3Q0yhZB9N312feybKKajTyvW+pHtFGF/yfKNwbsS/Z1NSyBQfiLPWlA4eI0fHD5TnbAfqkuIhozRUzwr1Vz6qE2QQeqodKBTZiI+b3KBBuMv+ZFv9Qxc44m0CJsa+Lsu2x+gPsxxt8rU1aaORDx8wuwaq6r2/IuqsxmTCKatIqgkrU3nkw0YTCxheu6JRbJPuUDO5TaVErlqfcXI0rPIN16p4h1AD8zeYkBu9BUj9hWwOQMfyTWRGh0iZ6a25Xp30LSbAS7YbmWY5rKme1pCfwY91OikACwmSFkexDqMfkM2ZoQx1/+3AJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85UqMNxP+278i6BmYY6FF4ve9n0Bi1BWDdw3TMHU1QA=;
 b=Z5lCUhOdNGZQKmb6OngOvtEejQElbjnMHQALe1pCHc1LPrpgiTbbzRBBeZZi2Sa1jUj+KZoJYOqeQRLqR/8SwLNVDJxFiHJCsCYT4uBheWBE2ITLLQcTJ9A4OvwBARtySwabn8uTJ/RrVP1dWmcMVdWjiZccYSZ1qO+rnDuJNzFhT28FMxDcmtrLmkiQZ4z4XFabORUgrg+csCAbnk3Bf1S0tit473VpY4GMYZOgosj0nlQ02Yj7LhK7/zmEHdhFR2sFp2ilWzt7ERgcqHtcd+JYcO6fY1KHwIN0vESmB2br6CxiepN+jgMq4ZrCjbM14CRFX1Ad18IlPuTaGtm52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85UqMNxP+278i6BmYY6FF4ve9n0Bi1BWDdw3TMHU1QA=;
 b=E6WrhkCGTr6/sN1o86li/HHn+DuxG3kopzDTXAEWkAA+cJ/GkrVwpNTRCuvGFn7KOphF/wYcuftPcmFv90PT0kW/+54b+1Y4fquuXo+gqclGebGDP8N/NY88Nb5RdjDTEMJgRCGBItroftIIBpYJTnzDXX3mNWRvWE0EKKERvrRiT0moOj27QiddS5ru6l5j2x51FOWZbwZSWBbtSW/wxGqQUFPPzdWH9JGUcH0Nz+J9sUYacuJbwSi74g9clMcRtoYiaYZkwgiaugfX4FEXNdFi8x4AdFUHLuXBmQXjT33fQ+x2ULGz99v5Vu4yJs5lZhD4AaXMXMcbfI+f3JQnYQ==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Fri, 7 Aug
 2020 14:30:18 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164%6]) with mapi id 15.20.3239.024; Fri, 7 Aug 2020
 14:30:18 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
Thread-Topic: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
Thread-Index: AQHWaNouv1V2TYM56Eqj6fr3Jx/DCaksmBQAgAAA6PCAAB6fAIAAA4Dw
Date: Fri, 7 Aug 2020 14:30:18 +0000
Message-ID: 
 <SN1PR12MB2480A13C1FC1632218BF99898B490@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20200802143505.88409-1-chris.laplante@agilent.com>
	 <75e480197f67f7605180feed70a14f23b4da6f16.camel@linuxfoundation.org>
	 <SN1PR12MB24804872E06CD1410239B8188B490@SN1PR12MB2480.namprd12.prod.outlook.com>
 <3fb78737e35050c1f441056418e3b56d5b2faf84.camel@linuxfoundation.org>
In-Reply-To: 
 <3fb78737e35050c1f441056418e3b56d5b2faf84.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d8d212b-ca16-4635-166a-08d83ade68c4
x-ms-traffictypediagnostic: SA0PR12MB4494:
x-microsoft-antispam-prvs: 
 <SA0PR12MB4494209D8F617CD767349E5D8B490@SA0PR12MB4494.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vGL7IlgJsWYH6Xayriij01LcJ9ZH9PZ6FAtiqGGaZ9MkxZkNvXZggeWpg1MzOZZS4JpMsivRiHIOAV5f+kgvn7Md+A2M/U0tlgon68iu+/PIMkBxOGYrMbKqHonmCFwl1DvBoJ8gn8S7MBSIUMKW23d5Zrpx8IyCD/PWuvko4savRYaNT8UlUDzE2PC2mHqoEJX8AFr4Z5LnWH2pmo7Mx0FmU/CmFr2v3uWWPzSSXC15p40rn1E1oXhRJAkQlvgfzH+Wla5ffOefrmW4nmj4ApVNUWV7aFTKZCTl93UGgU9uxBUsxCRh2+hhqcgmcVJt0E8qjrGBgfdQ1XUyvQGDuc3UIajP5N6ggLOTWzV3T+k7x8kx/7oAKqxSNrO9rcTz
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(29502001)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(6506007)(5660300002)(52536014)(33656002)(110136005)(26005)(478600001)(7696005)(8676002)(316002)(71200400001)(86362001)(55016002)(9686003)(2906002)(186003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 hlPg+SeKMd4zCJB8emqWKqnfWwym+2B8Wh3DcF4tBis4DbuEC/wAdh0R8LCiH4JdsEyGHBOR013XJBRIRGzMGVOd2R4wzwQ/p2bqupxDtKiPLuPys1zJYKsihb3NTx/XOHObjQjnx/rQDuJLIv44CWnU/RZybHmBDf6vgThxkhXSxuQSFlzyy61IyzT+sm6gEILn7Y+4+/cEzUd23hCGubUUga/Rci4Wiq6Bzw4t1qAQHmWqRgG16lbjA8mxhbtYKRmLDotdPIwW4fOphfLURBfZdnJibIYX669zGhM43icpEKm4/NKNKbwbW56Cr5m4V0kid1Gs2hSKw1KjmQyNvnbY0ayMHIJ4eDofHwK9Eo7tU0SaVKyTmnK9ZuIQfa1+qpUS7rxMhAm00B+A8ypSn8iWYCI0nTVjOXu42MLcikcrGZyuYmvAnOzSIqdu0b1gnDV3XnPe3G/BnxrTPsiaMxMT/f0JtLXnxTK5sPr/1AsxCvIDp8q96ypBBD0Xa2d8ipCvzbjN8PnSV2caoXxvoDguPDwncD4Fwb3Zb75Re8xGaG1ejXH+i+NztYBBeH1NEvP7MqK/cu3Ya66w+OCiuglharSeH45wQvNnFP5LbgODEVqvoqQ05JInvdb4o08mYd1EXkVLKf83s6GnXFocCw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8d212b-ca16-4635-166a-08d83ade68c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 14:30:18.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9goHz9t5ZXhpbS4h5S95Z+84S+1ODKqxlCyU5NdIIAuGFS1D6vzwXNmAZ/kKPJy5kF8U2tNYAmJLzNTCTax009YbxLF71K14W80O3kpxkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+IFVuZm9ydHVuYXRlbHkgbm90LCBzaW5jZSB0aGUgcGFyc2VyIHJlc2V0cyB0aGUgbGluZW5v
L2Z1bmMgdG8gIjEsDQo+ID4gYXV0b2dlbmVyYXRlZCIuDQo+ID4gSSdsbCBoYXZlIHRvIHRlYWNo
IHRoZSBwYXJzZXIgdG8gbWFpbnRhaW4gdGhlIG9yaWdpbmFsIGxvY2F0aW9uDQo+ID4gaW5mb3Jt
YXRpb24sIHByb2JhYmx5IGFzIHNvbWUgc29ydCBvZiBhcnJheSBzaW5jZSB5b3UgY2FuIG9mIGNv
dXJzZQ0KPiA+IGhhdmUgbXVsdGlwbGUgYXBwZW5kcy4NCj4gPg0KPiA+IEV2ZW4gdGhlbiwgaXQg
d29uJ3QgYmUgYWJsZSB0byB0cmFjZSB3aGVyZSBwZW9wbGUgZG8NCj4gPiBkLmFwcGVuZFZhcigi
ZG9fY29tcGlsZSIsIC4uLg0KPiA+IEkgaGF2ZSBzb21lIGhhbGYtYmFrZWQgaWRlYXMgb24gaG93
IHRvIGhhbmRsZSB0aGF0IGJ1dCBpdCB3b3VsZA0KPiA+IHByb2JhYmx5IHJlcXVpcmUgY2hhbmdl
cyB0byBkYXRhX3NtYXJ0Lg0KPiANCj4gSGF2ZSBhIGxvb2sgYXQgd2hhdCB0aGUgZC52YXJoaXN0
b3J5LmVtaXQodmFyLCBvdmFsLCB2YWwsIG8sIGQpIGNhbGwgZG9lcyBpbiBlbWl0KCkNCj4gaW4g
ZGF0YS5weS4gVGhlIGhhcmQgcGFydCBpcyB3ZSBoYXZlIHRvIGhhdmUgdmFyaWFibGUgdHJhY2tp
bmcgdHVybmVkIG9uIGZvcg0KPiB0aGF0IHRvIHdvcmsuIFlvdSBjYW4gc2VlIHRoZSBvdXRwdXQg
d2l0aCAiYml0YmFrZSAtZSIuIFdlIGRvbid0IHR1cm4gb24NCj4gdmFyaWFibGUgdHJhY2tpbmcg
YnkgZGVmYXVsdCBhcyBpdHMgYSBoZWF2eSBsb2FkIGZvciBnZW5lcmFsIHBhcnNpbmcgYW5kIG5v
dA0KPiBuZWVkZWQuIFlvdSBtYXkgYmUgYWJsZSB0byBlbmFibGUgdGhhdCBpbiB3b3JrZXIgY29u
dGV4dCB0aG91Z2guDQoNCiJiaXRiYWtlIC1lIiBkb2VzbuKAmXQgc2VlbSB0byBwcmludCB0aGUg
aGlzdG9yeSBpbmZvcm1hdGlvbiBmb3IgdGFza3MgdGhvdWdoLiBNYXliZSBJIHNraW1tZWQgaXQg
dG9vIGZhc3QgYnV0IEkgZG9uJ3QgcmVtZW1iZXIgaXQgYWxsIHRoZSBvdGhlciB0aW1lcyBJJ3Zl
IHVzZWQgImJpdGJha2UgLWUiIGVpdGhlci4gDQoNCj4gPiA+IEkgZG8gc29tZXRpbWVzIHJ1biB0
aGUgc2NyaXB0cyBieSBoYW5kIG15c2VsZi4gQW5vdGhlciBsb25nIHN0YW5kaW5nDQo+ID4gPiBp
ZGVhIEkga2VlcCBtZWFuaW5nIHRvIHNvcnQgb3V0IGlzIGFkZGluZyB0aGUgY29ycmVjdCBwc2V1
ZG8NCj4gPiA+IGVudmlyb25tZW50IHRvIHRob3NlIGZ1bmN0aW9ucywgZXZlbiBhcyBjb21tZW50
cyB0aGUgdXNlciBjb3VsZA0KPiA+ID4gZW5hYmxlIGZvciBkZWJ1Z2dpbmcuDQo+ID4gPg0KPiA+
ID4gRGlkIHlvdSBmaW5pc2ggdGhlIG90aGVyIHNoZWxsIHRyYXAgY29kZT8gSSB0aGluayB3ZSdy
ZSBwcm9iYWJseSBvaw0KPiA+ID4gd2l0aG91dCB0aGF0IGJ1dCBpZiB5b3UgaGFkIGl0IHdvcmtp
bmcgaXQgbWlnaHQgYmUgZ29vZCB0byBwdXQgaW4NCj4gPiA+IHRoZSBhcmNoaXZlcz8NCj4gPg0K
PiA+IEkgbmVhcmx5IGZpbmlzaGVkIGl0LiBJJ2xsIHN1Ym1pdCBhIHYzIHdpdGggaXQuIE15IG9y
aWdpbmFsIGRlc2lnbiBmb3INCj4gPiB0aGUgc2hlbGwgdHJhcCB3YXMgdGhhdCBpdCB3b3VsZCBs
b2NhdGUgdGhlIGNvbW1lbnQgYnkgZGV0ZXJtaW5pbmcNCj4gPiB3aGVyZSB0aGUgZnVuY3Rpb24g
aXMgZGVmaW5lZCAoYnkgdXNpbmcgInNob3B0IC1zIGV4dGRlYnVnIiBhbmQNCj4gPiAiZGVmaW5l
IC1GIikgYW5kIHRoZW4ganVzdCBncmFiIHRoZSBjb21tZW50IGJ5IHN1YnRyYWN0aW5nIG9uZSBm
cm9tDQo+ID4gdGhlIGxpbmUgbnVtYmVyLiBCdXQgaXQgZG9lc27igJl0IHF1aXRlIHdvcmsgZm9y
IG5lc3RlZCBzaGVsbCBmdW5jdGlvbnMuDQo+ID4gU28gSSB0aGluayBJJ2xsIGp1c3QgaGF2ZSB0
byBkbyB3aGF0IEkgZG8gaW4gYnVpbGQucHksIHNjYW4gYmFja3dhcmRzDQo+ID4gZnJvbSB0aGUg
ZnJhbWUgbGluZSBudW1iZXIgdG8gbG9jYXRlIHRoZSBjb21tZW50Lg0KPiANCj4gRG9uJ3Qgd29y
cnkgYWJvdXQgaXQgdG9vIG11Y2gsIGl0IGp1c3Qgc291bmRlZCBxdWl0ZSBuZWF0IGFuZCBJIGRv
bid0IGxpa2Ugd29yaw0KPiBsaWtlIHRoYXQgdG8gZ2V0IGxvc3QhDQoNCkkgc2VudCB0aGUgcm91
Z2ggV0lQIHZlcnNpb24gSSBoYWQgZm9yIHlvdXIgRnJpZGF5IHJlYWRpbmcgcGxlYXN1cmUgOikN
Cg0KPiANCj4gQ2hlZXJzLA0KPiANCj4gUmljaGFyZA0KPiANCg0K
