Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.68])
 by mx.groups.io with SMTP id smtpd.web12.34497.1605044418340969417
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2020 13:40:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=hjnXmbHw;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.94.68, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEsctm4ujr3jkF6uj3lLPDw+chhcAqsuTURePzlkVpUC9W/6ZLr3wW14hyoV3sCNZaxJ8Z8qHEVQTJqx1brWKdcSrIfu+5jlSPlz7zbLk85UYSvFwUuwRbptSomo2oyKpjJQ71DIRHkXEBW0jWlomzcMhgzJD34tsHirQRW2RcKODCUF2tKv4ssXwJeL4E2SZEpIdf37f1qYVOA9e/LqWIxU5mab/xf+Jfogdjwxd7LSHLmSfMppvVbZjrTlZRgGoc3kHxDO01BVj7MP2kXFPIwV+EeDlxRw9tV825sPHDQrzsj0J0gek0/2a3Hk0kOrB7skh7jcmKHg/w8wQM8l8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYuTO7UeHQAyFcONc/Iu8grf3GHSpaiIA9Jk+fg2E7g=;
 b=ZOwj+u9oov91aKWlDAJkGypLqaqJxb6Mi2GsCJ4iErXqVYaHKAEpSVFIx6M0d8ruAZFooxlv+QEejkRl8+tow1yMxQHWFIMa4kMZ7rup1zCgBwRgzbArMcZHFsmEjO2IzFepwkMqxhyEYOIWRj4VOoJLo+EMDEvGkZ4EnbLPGMroc7yoXz9MA9EFrxCq39NuCeGEQwvrqdw2K4JOxhQIFnYcuR0DKYyYfmOs4zDmqFSSTJWMjDjvSExZS5WW2DAIt15SnNm4ySCKWymZgn2GYXXW5m05rIh5tobG90t4zLRYjRcq/Woj7caEDEUCyNKaFc0kS0zD5fTPm2QA57QjJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYuTO7UeHQAyFcONc/Iu8grf3GHSpaiIA9Jk+fg2E7g=;
 b=hjnXmbHwjrWKhafsC8lcp6UVH0WF0IR6VBmaEXLGXUtdkkaO5874ESNHKWTIvK4kKN4eWXU1Et5BjI6CS5oeiKvHKsbe0/WiU6TMhPiBOdCXlVhggQ+bm0IaMpTSb50/Hoo1LIZyTowr/sP5pXCooJbQCqbJ0U6jNwPEfGG7odr6zLF/Hr6t+S1+RZtAHWWn8a3XQHDbccwN6g2zjc+n3GwsBqNR55GzB+28LN/ePML9Ju9QUV253hTbdaS/DRz/KMWUyyUYoOROxLqgVBSYQxmcfm/k1/3P4iIL7P1n+uPv6djrcr++ALNsuVOYZ4K4zBxCNM6z2pYbLj7dG1OyXw==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 10 Nov
 2020 21:40:15 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1%3]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 21:40:15 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
Thread-Topic: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
Thread-Index: AQHWthw4kN7CZJaZ2EupBAhsiadueqnB540AgAAAMVA=
Date: Tue, 10 Nov 2020 21:40:15 +0000
Message-ID: 
 <SN1PR12MB248053CD59E54D66AF1C52718BE90@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
 <79ada9503eb003e81ec3f90836837cccc787f836.camel@linuxfoundation.org>
In-Reply-To: 
 <79ada9503eb003e81ec3f90836837cccc787f836.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4214d2a0-a074-4bcc-e07d-08d885c13652
x-ms-traffictypediagnostic: SA0PR12MB4461:
x-microsoft-antispam-prvs: 
 <SA0PR12MB4461F631D4344F1D845C6F688BE90@SA0PR12MB4461.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 k4PWQe63gVeXKMTc+lgjdR4J8iogbRmLOd3rgqB0xU4wuvr2IUnjF/hRMxx/tsqPT7yNDywAkL4oPKoJFUIZz++bqw9ob/ZRvO/6GHHwkrAtS/w/2jkDtXlzvhwffafRP4PF4RaVaZKaZmR7dfUJO0rldo2yJ49hwRfi1069nwFCMh1YkzvLY13rmcZu5X+B2PF4IDxRJG1xHQnIP4GFaM+xEHHiVluEeHJtXr07EtpxJayOzClxKNgm7a8aHh5aRVB8R3jFccmklLGTrVPS5nEfbJja7senkfuVe7B6qvUxcIx/4rLE/61AfwF/AMu1wb81mV4XJuSbqny/eH9ny+Fg6q7fFVWSodnpAjNilfT5Y8j+yULcyk72bwaXOPcJ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(29502001)(110136005)(55016002)(9686003)(4744005)(66556008)(316002)(5660300002)(66446008)(66946007)(8676002)(86362001)(8936002)(64756008)(76116006)(66476007)(71200400001)(6506007)(478600001)(186003)(2906002)(26005)(33656002)(7696005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 GfvMotqLZea2ZlzbxboyrNwi3Pa1YWGFWPGsfZTclWfyBWAfBkZ5VuKYqyLneGAJe73c9Ynw6r3jBAXxFdW6/WSZIE19DUlRZfpEPk9vUUxmcUUxeSmE9WTEV1AU5jyXaj0P3Xd+Yi1duIqKdgcf3/KWDmKlZd9MyCzSPdcxOeo4aq2+3ZHC9A+aGLZUirdF2688yTEAHGRPl0r/9K6VEuIJF2BCFnHNVSExmMAgN/Bf81ca2E9MlfQNpbCq5OWJwTnd5oeVXvNu31WOM4vxAx0YdUJZrBgkpHmhnXfIcDIG1IGoq74eRiI6aJmiedL209zGH7npBWn0/Hf7tdZnw9p2NE/iTmi96ID2qmAyNzaJtBhrh1zaETdgRb3128FdG/TjSGoxk0mSE0vnV5hkSqh8z2UuH4fU+UcNfnNVvfGeeMiRYrZD4eQ1w0mVKSU2nskLEZmyBDsbQ4Cd/Z9fPyNV3Mt3oA6VlKmWaZMmjTsUh4KSFWYVV3OC0S6+ffZBI8yu3tq04CXyOjSrl+PcERtZmhUgAtcKWuJToDugk35dE6mJzXnu2Pf300tuvofOKRsG8CnqGR9wW6f6Sn18f2RYmdb/ePTZmKajWhGVNvSTQLwb50Fhy1iwPzB7TeI4+ft1WjXwl5kuDpZWdKAwghECHU2O9IKGfmXM7IF+cbrP3GNPbY5q3T1hoaDZAtoNjBGM2bGqUYtyIVMsdqd9wssx+mZ2sNVH6FEFVUcX4KpfCoxTbuHaD19Uye4zm7Fns/yJPGBdjnUiZ9uwaGj3+7dMrfVDcM3M1WNzRWKHw0KV+mpbP/KbfzeoU4CJIFAQfzAqDj8WKhvx1gkBMtoo6bi8sg5toffdTSm3FT0zVRZhtZhD8FSAVtb+lVifmd/oPxAqDyFJHrdjAoFC2XqL0A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4214d2a0-a074-4bcc-e07d-08d885c13652
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 21:40:15.8819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKVziZBSq6c9JhvV/E+eF1eJIPmkzDcWto2cVURqJKcNqiDhVE3IrkWrQq9aQok1nsRdMd+9NJBb4G8HGRPdewB+FUm7slxXDpyc5XwL7CE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBPbmUgb3RoZXIgdGhpbmcgd2hpY2ggd291bGQgcmVhbGx5IGhlbHAgbWUgaXMgaWYgeW91IGNv
dWxkIGVpdGhlciBmaXggeW91cg0KPiBTTVRQIHNlcnZlciBzZXR1cCBzbyB0aGUgbGlzdCBpc24n
dCBhcyB1bmhhcHB5IGFuZCB0aGVyZWZvcmUgZG9lc24ndCBwcmVzZW50DQo+IHlvdSBhcyAiQ2hy
aXMgTGFwbGFudGUgdmlhIGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcgPA0KPiBjaHJpcy5sYXBsYW50
ZT1hZ2lsZW50LmNvbUBsaXN0cy5vcGVuZW1iZWRkZWQub3JnPiIsIG9yIGFkZCBGcm9tOiBsaW5l
cyB0bw0KPiB0aGUgc3RhcnQgb2YgdGhlIHBhdGNoZXMgc28gdGhlIGF1dGhvciBpcyBzZXQgY29y
cmVjdGx5LCBvciBDQzogbWUgZGlyZWN0bHkgb24NCj4gdGhlIHBhdGNoZXMgc28gSSBnZXQgYSBj
b3B5IHdoaWNoIGhhc24ndCBoaXQgdGhlIG1haWxpbmcgbGlzdCBhbmQgYmVlbg0KPiBtYW5nbGVk
Lg0KPiANCj4gSSd2ZSBiZWVuIGZpeGluZyB0aGVzZSB1cCBtYW51YWxseSBidXQgaXRzIGdldHRp
bmcgYSBiaXQgd2VhcmluZyBnaXZlbiB0aGUNCj4gbnVtYmVyIHlvdSd2ZSBzZW50LiBJIGd1ZXNz
IHRoZSBhbHRlcm5hdGl2ZSBpcyBJIGltcHJvdmUgbXkgc2NyaXB0aW5nIHdoaWNoDQo+IG1heSBi
ZSB0aGUgb3RoZXIgb3B0aW9ucywgaXRzIGtpbmQgb2YgaW5ldml0YWJsZS4NCg0KU29ycnkgYWJv
dXQgdGhhdCAtIEknbGwgbWFrZSBzdXJlIHRvIGFkZCB0aGUgIkZyb206IiBsaW5lcy4gDQoNCkNo
cmlzDQo=
