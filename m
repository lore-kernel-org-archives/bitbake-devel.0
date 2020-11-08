Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.49])
 by mx.groups.io with SMTP id smtpd.web09.1656.1604866052392767395
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2020 12:07:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=nodpfvcW;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.49, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHYT/06nEI5dM/3XQKcmewwDMvaxezScCfKI11Leh8cD6O5fLtg5tGnzAlnFjOEpRLpu5s+I3WK6pzGeF/b4tlreS1DAdchtxbQhco40fNlLI26WsTHW9bN3r2k538Doh7mmKyRuXl0J7mMuXAoDE6lD64vW5Pw4slOYD84plHXDAVsabV5erPK68B16K2gw5aOL1JphSJF1xvdyGWoncFek/LyP36ytHCugtt8fgvzcVX3CJm8NAeMzL9YUcenShujJlPu22xdMaPeB1lXBABxkkw/k2ZMJWrXJOyLh56ItgslfMuoJgHsXtjRSaCbRlcbKuESVI6vZ+/VxDB1eYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAWD29RNRDHO4DozcHLYgozg3491/c4HwACPQF6ahDs=;
 b=W0ZcxLxBaZbR3UNvZDqbiINfU3WKytI6naTWEbnQhHTVVdWSC7ArD9IzI32rku6g07KkmOyny6aZuJ2HR29beoOIyAc8xNuFtv1/5kKznH4XjgKI3QDV+cy6aQWz1irFySHPd2NlMF/T1s+r3ay43nhm65TpsKXOGhe1J8MWGPtcTIXHJB6Mxs3h4HhmrwxRHcDpyxf7vguvpEpfyqhUMyptaa88IPVTDx1IZ1ZreUhbIZVeelNAHUSA8YcqDWBXv2wFExSyDDTU2jfFi0CxTbE+CKTVG0Aifw/LipfK3rzdUdVD0wzf3gw1Y79yS00vYnyMzYslPy0IszYBxTwP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAWD29RNRDHO4DozcHLYgozg3491/c4HwACPQF6ahDs=;
 b=nodpfvcWKbLDslipAE+uBrrKrQRGHFziCs33kSmUDy2tnd/GJ+cyr//mQZFh4p3CsQKi4KKNEFGoQStYv+w6zh5e2WmRZNgJW4KTGBztJkxw9+TyUYfuELxTpaKbv17PKadBEBJ/8t1qVWTlZ8bqRCsmFXrBJgdMZiet207+zd8yAOoeAtgHFrocGYH0B+IxAMPnoQkb0xrlIf7trsBWst/OMf8G5RaYgZZBBymj1qPPzBIoPVPh1acarW/wMvmFN2Px+KbgkAjYCv9JIO2ug8aHHvcIx3KbXJuy9p/Yr0WZH6WmABB1ZOw2Jjz/2DYAuJCBfzeP3Zgl5i0XaJgWsA==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 20:07:30 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1%3]) with mapi id 15.20.3541.024; Sun, 8 Nov 2020
 20:07:30 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/5] optparse => argparse
Thread-Topic: [bitbake-devel] [PATCH v2 0/5] optparse => argparse
Thread-Index: AQHWtKyryzZ/lY5OUky4A++HgjLt4Km+baCAgAA+UxA=
Date: Sun, 8 Nov 2020 20:07:30 +0000
Message-ID: 
 <SN1PR12MB2480AFF5381B01CD820B27FD8BEB0@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201107022106.84056-1-chris.laplante@agilent.com>
 <c332c4a65509274710a782edf25d9f47af4aa7d9.camel@linuxfoundation.org>
In-Reply-To: 
 <c332c4a65509274710a782edf25d9f47af4aa7d9.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8897ee5-3dfa-4bd0-954b-08d88421ec30
x-ms-traffictypediagnostic: SA0PR12MB4542:
x-microsoft-antispam-prvs: 
 <SA0PR12MB45422E6EB18C633704665C9F8BEB0@SA0PR12MB4542.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SHhm/qdr4fRlkc8h8g7jM5IgmAouXgRjbXR2RsGMq/escl9W/LHYr3rGUCn7snke+fjJzUGuwrkrw5nLjIxDF6HY2sQO9XPZjURk05FCLpzFuBGrdS3FA5L/s9iOVpbF4U8KIOb0jyWjNu/ud8GTicOKtEht9AVaOJEDeZSxRqkUjcgoJz/vbZavRYYge6K8148G4einmZ9IZth4owGkL1AcssmW1l3hWQK7RzhQjoS74qQWKpyVt+XfspM+NGQueEq3bqbxe0Pe5B6DOuDk9r6dyEAT1t+52sJ5ergUV0rwiSD/Ou2BioVBJ77NcmjEPw0Uog6cPHu0NZ3xyfqXmJSrvYLxZ8hjX/XKP7uTr94DqDI4itnBKq0KZZlT77k97Zcwp+P4VrNJ7IxpFpKcQETCv4rvslY6Bn/sEbwFOgd8uoj887sQfDfVAJOPIhQJHOMAfL7nckHj3UYquSihFQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(29502001)(33656002)(2906002)(55016002)(71200400001)(52536014)(8936002)(8676002)(316002)(186003)(4744005)(6506007)(7696005)(26005)(966005)(478600001)(45080400002)(5660300002)(66946007)(64756008)(66556008)(66476007)(66446008)(9686003)(86362001)(83380400001)(110136005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 NO2EEPiNGCqzO9l3VU13niyZ5Nk+H+TSt+XA1ysKBOONxnZaVqptWoHNNoz9dnqqNIwfk7kLgZUZbyt8D3bGZADLCnZv26zaP8ksZg/S9dc16VWfnkVweA7QmzShaRIl7PitAdn24F006LuoJIVLT3si6ejDMxOid9YETNlHIaMD9ZX/O8UhUhcxr86gH7loR539J0mR6uCW1RZ/a1lPSBcg3FGtWwIqC+vA9zsZ4szOy7clAxeWO52uZxcEqKNybskoG3uZ8TOXpDZ5v1ih4JbaYWHhiu8c3NUmomC5CPR/oG6ntOF8Xg72MBDgKTBIjRj/2UIlFpr1ebTSr/k/gaTHeYnwbS3y7Uk/hpSJK2HT+m7ROqPjUpQWOqPLeBG5kEukbF6Q83aFLqnuD3N2F88sN2EqTerlPz8yKZckkb80Vyi8El4cedQ+8KdIa+hz6HQtAWtLnM8QKbTFmaeKCly8ofm49fZU5nLZK1pRRY6cc1uWHFeBcSpj2A+WTLn7M3m43XgJsQHSS9z91zB+FpUBt8kdm9LvyJNmTnntgbcMBnF4Ht3J0kp1jSh55opVie4oejKOhRmJ0zalHKBi3waJdbgMz06aK9lq4yK8fE1Cuc34EVPrPbYOwv6UFgqLt1IyFb2HxGFnHPwApmznBA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8897ee5-3dfa-4bd0-954b-08d88421ec30
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2020 20:07:30.3100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCsZo5QccuKoWZnS+oiUhSquQYiY+xC2UmavJCi6S2KLYVJFGkUjSL4Y689NIblBycvH9DZuK+itfWStuUHXPfVm7XDvslHg/E7CIGxjohU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+IHYxOiBpbml0aWFsDQo+ID4gdjI6IGZpeCBpbnRlcm1peGVkIGFyZ3VtZW50IHBhcnNpbmcN
Cj4gDQo+IFRoYW5rcyBmb3IgdGhlIG5ldyB2ZXJzaW9uLiBJIGRpZCBydW4gdGhpcyB0aHJvdWdo
IHRlc3RpbmcgYnV0IGl0IGxvb2tzIGxpa2UNCj4gdGhlcmUgYXJlIHN0aWxsIHNvbWUgaXNzdWVz
IHRvIHJlc29sZToNCj4gDQo+IGh0dHBzOi8vbmFtMTIuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmF1dG8NCj4gYnVpbGRlci55b2N0b3Byb2plY3Qu
b3JnJTJGdHlwaG9vbiUyRiUyMyUyRmJ1aWxkZXJzJTJGODMlMkZidWlsZHMlMg0KPiBGMTU2NyZh
bXA7ZGF0YT0wNCU3QzAxJTdDY2hyaXMubGFwbGFudGUlNDBhZ2lsZW50LmNvbSU3Q2UwM2NmNjk3
Yg0KPiBmMmM0ZmI0ZGVmNjA4ZDg4NDAyYTIzYSU3Q2E5YzBiYzA5OGI0NjQyMDY5MzUxMmJhMTJm
YjRhNWMwJTdDMA0KPiAlN0MwJTdDNjM3NDA0NDk0MTI4OTkyNjM2JTdDVW5rbm93biU3Q1RXRnBi
R1pzYjNkOGV5SldJam9pTQ0KPiBDNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklr
MWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDANCj4gMCZhbXA7c2RhdGE9ajB2UlU1cGtyTHZKYUNQ
S3phM1Fxa3R2YVZDZSUyQjFLWkNteDRFZW0lMkJpJTJCYw0KPiAlM0QmYW1wO3Jlc2VydmVkPTAN
Cg0KSXMgdGhlcmUgYSB3YXkgSSBjYW4gd29yayBvbiBhIGJyYW5jaCBhbmQgZG8gYXV0b2J1aWxk
ZXIgcnVucz8gSSBoYXZlbid0IGNhdWdodCBhbnkgb2YgdGhlc2UgcHJvYmxlbXMgeWV0IHdpdGgg
Yml0YmFrZS1zZWxmdGVzdC4gSSdkIGxpa2UgdG8gYmUgYWJsZSB0byBpdGVyYXRlIGFuZCB1c2Ug
dGhlIGZhaWx1cmVzIHRvIGFkZCBuZXcgc2VsZnRlc3RzLg0KDQpGb3IgZXhhbXBsZSwgSSB3aWxs
IGFkZCBhIHNlbGZ0ZXN0IHRvIGNhdGNoIHRoZSBpbXByb3BlciBwYXJzaW5nIG9mICdiaXRiYWtl
IC1TIG5vbmUgd29ybGQnLg0KDQpUaGFua3MsDQpDaHJpcw0K
