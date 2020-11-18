Received: from NAM04-CO1-obe.outbound.protection.outlook.com (NAM04-CO1-obe.outbound.protection.outlook.com [40.107.69.59])
 by mx.groups.io with SMTP id smtpd.web08.31068.1605733293752742325
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Nov 2020 13:01:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=wEhE+KkC;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.69.59, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MytmND0sfRar8H2hRVGzB+scsbwWW6fdxUZjrwZaEdEmsLtPK33NpJP+M+lcR/sa0JKf4pwetspJvZ4tqrfJ91I+JojlTk+s0MjuWaVrTll4S+PVI0FXXDjlqvrLOhgLUqWQhhnYQyBTiyZKod3mwqlS3eAa3jsOJ+3vJ+xSR2U6Bem2v3YjkhP3jwLYuuc+Gvt+k+R+Kcdp4zAaicHJ9O51xg9HIGBBzIDErZE0vZIyLW1DOFIxzG+Rs5k0mX0/aysEFr3eelvErvBpr4pwprbQ6gvrEkOOMPb+EGDAGymctVvJDhUCNt54QS0qjGkNShxY4iiR6FBWch70hzZmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWbNmwUYi9FwHW7DG7uuSFPd0IKpK26NK6oeg5jA1Zk=;
 b=OF4mYVxjbszjASpmnsu2iIvepeUK95G1jboNBzijET4BsMtxDAQ5tB+COE1Xgz/PKRZ22248NaHeRa2UbzRV2kDIN1SpfEs3TSms6T87PDj/qmgCdEPesRR6hB510w3Zt0k2eGzNpFOoYnou4d8Dy4K8T4NtzVpGhW55xxLKzUiB8kezJIKBUw8yafeggIT4P6ZnwubJ0FVOqpt5kuSeeb1CNdqSMS0nMZCGsTsF1T0jMueAtEudGUK+KBq+OZEFIvBDUVK17pW2Z8xO3Ni7X6dkR6GZPMKS5xgpTi8oApjubb1gm62oMFQ2PgqeS0fceesomRpQL5cu5RkmgQ6IVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWbNmwUYi9FwHW7DG7uuSFPd0IKpK26NK6oeg5jA1Zk=;
 b=wEhE+KkCtp07WFcrRb8xacaKG7sBYMo/yzriuaqLn1kZfXcTvMHIOVzWD7IJ6wtVxt7F7g64Jz3r+TymvHaqHQcVYvGDUwuKqlMP6zkS0SCStJOYHcN1/pG0xAUAk46KaRTm99pPLHDvXtjIVuKAKXNdQnCS+6TB5H8kFfSWDDPIcD/RG1nhCSWz4xALoM+8fbn6mtQ2AZvOMny3SnyprAYltvG2T/jbPTWNgFaVAx0nNKESjTQJQaQIeUeFH3CydIsy/rvB2M9jVhbQbFw281mUntLLTByaaSTUzp7lWyX19MrhEfI/uJ0kVQ++cyBCa0Qw1wzZNVsm3Q8ENP1tmQ==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 21:01:32 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1%3]) with mapi id 15.20.3589.022; Wed, 18 Nov 2020
 21:01:32 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
Thread-Topic: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
Thread-Index: 
 AQHWthw4kN7CZJaZ2EupBAhsiadueqnB540AgAw8oTCAAAPkAIAAAXzwgAAJngCAADwrsA==
Date: Wed, 18 Nov 2020 21:01:32 +0000
Message-ID: 
 <SN1PR12MB2480E2F3894878B5CC62BE258BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
	 <79ada9503eb003e81ec3f90836837cccc787f836.camel@linuxfoundation.org>
	 <SN1PR12MB248066D339FDC42D95EB16218BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
	 <710819fcc1b29838ea7d2f2b332fdd44495219c7.camel@linuxfoundation.org>
	 <SN1PR12MB24809AE9781F70F9F4ADBCCD8BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
 <989c6ad2362e7763866a566efa6715d66ebc2d0c.camel@linuxfoundation.org>
In-Reply-To: 
 <989c6ad2362e7763866a566efa6715d66ebc2d0c.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a1ce3f0-8249-4623-b289-08d88c0520d6
x-ms-traffictypediagnostic: SN6PR12MB2847:
x-microsoft-antispam-prvs: 
 <SN6PR12MB28475C0D69F640DEDE2065378BE10@SN6PR12MB2847.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 LDRj+lkKCe4Ow5l/4QHfN/GzPC6bAKjPgkirl0daKmO3Q/upFmSiBX95pcpWH+M3xsolaOQ2lNSUp0A8nhLaI7Oj7NJN+wJ6Mtu9eOICQ0G1lCLkLzTLZj2aUdpv4h3xSaSVC1Vt8PPYXyLI2G0QFuBJh6jXCP7bkravqioUB+SuXItFZi7MeSYdxxjswLsGJH4+ZhQMND/SCWdBcyvNh2ln8dkptopxP/LyUykRMHJvqbnLOj57wb3ObE/WE+PX3AZL2Cm/pWBRy7zct2gb9p6acsDfkK4yXkRiIHtVLL3kYRenceqwSh3onk66ojZNxBIv9WTzcdG2/sK8587pzT1lZLtt16j8xR3PuKo9HV/r59/DYHLhrbI8FMTEqAY+
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(29502001)(83380400001)(33656002)(7696005)(9686003)(76116006)(8676002)(66556008)(26005)(64756008)(66446008)(66476007)(6916009)(2906002)(186003)(8936002)(4326008)(66946007)(86362001)(6506007)(316002)(478600001)(52536014)(5660300002)(55016002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 d+N1RL88y++ufPdAoRz+cxvj2y5qf1Tv7jw6Ww0aE+CEJhtVqnmpVXtUK4Vha/bVrLbXGWaGvSfuesNKWBhGrYdZuBe5DfnCeqOVsyN4KSqMZXLYqyUNC0AviIW0xavqXI+QEhxjFWUa3HbZMaFct0wJ0Zez1HnKZW0D+SCPpB3BgUZmrk+JuNX5yyPoWhNk1MHbrjSQD0T9Nu+V/lp4tMD4HcclQeODux3cR3QvymKSCvr2G7PSVKYclr5flEL019aYPDciZaDkwjx4BjFLcxUJKDo9NtKk9K7J/W0qEzPSLrJZV7Anl8qKVSOV5jQpddzJnDVWRyou0Ym11kADJUTk6aMxiZ2hdaby9KKukgLaMBTaZr8Jys6NWrn1R5oMROQSAG/lh3hw9k31Xho8ZboxAxsh3qEBv/Ritg70gIMPt7LQqixWqcL2WwrDh/HydZU8KnqoBYvM1BBK91YfZfqB8/1Gc2TjNVjyD84VCtz1mgsPMTL8l5JkSyYBdb6Df6moTn0lGFtjEgHWUbMtt4uqJYjpdoQ48Cl0AkDJMpJ0FFt50EqlLUXzxm8bh0N6JUzlSy/qMJZxejJxUIs5ABVIVcQHcZOcUS4/cdY8C7wFgalmI6SExcHU36mqdE2/jON+4SA4YpcSCyiTR3/wFCH3kzMOxLtANscA7s8CzffeexcHzSyoObuCY3SWA0YofEjxcoLYVAexJ0uxSYYqazWf9xSezLGVNTa4lcwQu9aliuZ0BuOLduBrT/6UnHhtHFWmC7Pm71pLqkQ30U7F/wQNAAWVpQbB0kGrlJdpRgNjdE+CS8LsBn/xSJVK38bYAeF6M2KrMMSjyNqlOIOQZxpI7S2hWTzOdzKwsqs2QXoImqWVhp1iuH+P1w7Q+mPWfBGrK18aNp+Gf0Tr/nlpcQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1ce3f0-8249-4623-b289-08d88c0520d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 21:01:32.5272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //ORARi6WgWnoZu5IxlQwVnM9ZwiVczm9BYI82FYVWORNkZEJfMiLZ2UEYAk50uSI1GB4Q4NHyj34ITj0J2DBWv18IEhJaTKfcebv8umDac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2847
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBZb3UgYXJlbid0IHRoZSBvbmx5IG9uZSEgTW9zdCBvZiBvdXIgcmVndWxhciBjb250cmlidXRv
cnMgZG9uJ3QgaGF2ZSB0aGUNCj4gcHJvYmxlbSBhbmQgaXQgaGFzIGltcHJvdmVkIGZvciBvdGhl
cnMgb3ZlciB0aW1lIGFzIHBlb3BsZSB1bmRlcnN0YW5kIHRoZQ0KPiBpc3N1ZXMgYW5kIHNldCB0
aGUgU1BGIG1vcmUgZmF2b3VyYWJseS4gSSBkb24ndCBrbm93IHRoZSBkZXRhaWxzLCBJJ3ZlIGp1
c3QNCj4gbm90aWNlZCBzb21lIHBlb3BsZSB3aG8gaGFkIHRoZSBpc3N1ZSBkb24ndCBub3cuDQo+
IA0KPiBJdHMgbm90IGJlZW4gcHJvYmxlbWF0aWMgZW5vdWdoIHRoYXQgSSd2ZSBoYWQgdG8gYWRk
IHNjcmlwdHMsIEkndmUganVzdCBoYWNrZWQNCj4gdGhlIG9kZCBwYXRjaCBidXQgaXRzIHByb2Jh
Ymx5IGluZXZpdGFibGUgSSdsbCByZWFjaCBhIHRocmVzaG9sZCBhdCBzb21lIHBvaW50Lg0KPiAN
Cj4gSXJvbmljYWxseSB3aGlsc3QgbXkgZW1haWxzIHRvIHRoZSBsaXN0cyBub3cgd29yayAoSSB0
aGluay9ob3BlKSwgdGhlIGNvcGllcyBJDQo+IGdldCBiYWNrIG9mIG15IGVtYWlscyBhcmUgYWx3
YXlzIG1hbmdsZWQgYW5kIG5vdGhpbmcgY2FuIGJlIGRvbmUgYWJvdXQNCj4gdGhhdC4NCj4gDQo+
ID4gTi5CLjogSSByZWFsbHkgd2lzaCBnaXQgaGFkIGEgaG9vayB0aGF0IHJ1bnMgYXQgJ3NlbmQt
ZW1haWwnIHRpbWUuIEFzDQo+ID4gSSB1bmRlcnN0YW5kIGl0LCB0aGF0IHdvdWxkIGJlIHRoZSBj
b3JyZWN0IHBsYWNlIHRvIGF1dG9tYXRpY2FsbHkNCj4gPiBwcmVmaXggdGhlIG1lc3NhZ2UgYm9k
eSB3aXRoIHRoZSAnRnJvbTogJyBoZWFkZXIuIEkgdHJpZWQgdXNpbmcNCj4gPiAncHJlcGFyZS1j
b21taXQtbXNnJyB0byBwcmVmaXggdGhlIGVudGlyZSBjb21taXQgbWVzc2FnZSB3aXRoICdGcm9t
Og0KPiA+ICcgYnV0IHRoYXQgZGlydGllcyB0aGUgbG9nIGFuZCBicmVha3MgJ2dpdCBsb2cgLS1v
bmVsaW5lJy4gTWF5YmUgSSdtDQo+ID4gbWlzc2luZyBzb21ldGhpbmcgYnV0IEkganVzdCBkb24n
dCBzZWUgYSB3YXkgdG8gZG8gdGhpcyBhdXRvbWF0aWNhbGx5DQo+ID4gd2l0aG91dCB3cml0aW5n
IGEgd3JhcHBlciBzY3JpcHQgYXJvdW5kIHNlbmQtZW1haWwsIHdoaWNoIEknbGwNCj4gPiBwcm9i
YWJseSBlbmQgdXAgZG9pbmcuDQo+IA0KPiBJIHdpc2ggSSBoYWQgZ29vZCBhbnN3ZXJzIGJ1dCBp
dHMgYSBwYWluLiBNYWlsaW5nIGxpc3RzIGFyZSBiZWNvbWluZyBoYXJkZXIgdG8NCj4gcnVuIGFu
ZCBtYWludGFpbiAob25lIHJlYXNvbiB3ZSBzd2l0Y2hlZCB0byBncm91cHMuaW8pLg0KPiANCj4g
VGhhbmtzIGZvciBsb29raW5nIGF0IGl0IQ0KDQoNCkkgaGFja2VkIHVwIGEgc21hbGwgUHl0aG9u
IHNjcmlwdCBhcyBteSAuZ2l0L2hvb2tzL3NlbmRlbWFpbC12YWxpZGF0ZSB0byBlbnN1cmUgdGhl
IEZyb206IGxpbmUgaXMgdGhlIGZpcnN0IGxpbmUgaW4gdGhlIG1lc3NhZ2UgYm9keS4gSSBqdXN0
IHRlc3RlZCBpdCBieSBzZW5kaW5nIGEgcGF0Y2ggdG8gT0UtQ29yZSBmb3Igc29tZXRoaW5nIEkg
Zm91bmQgYSBjb3VwbGUgZGF5cyBhZ28uDQoNCklmIGl0IGxvb2tzIE9LIHBsZWFzZSBsZXQgbWUg
a25vdy4gSSBjYW4gc2hhcmUgdGhlIHNlbmRlbWFpbC12YWxpZGF0ZSBpZiB5b3UgdGhpbmsgaXQg
Y291bGQgYmUgdXNlZnVsIHRvIG90aGVycy4NCg0KVGhhbmtzLA0KQ2hyaXMNCg==
