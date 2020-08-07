Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.55])
 by mx.groups.io with SMTP id smtpd.web12.5018.1596803494848418687
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Aug 2020 05:31:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=wWQvtb58;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.55, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YncqLXtW36Gvsd/1qn4pJOGZJLVFQGKJ5nTwEZc3tP3AJ8GXDNzdJWD6PaTIgceRvIGtoYAt8UlNzZ+irpxHLmlaa6kgd8Ydc0AI0EDob+ZttZ/4LEJuOupU7LigHAvQ3eDa2E7YL1Y0HrLesbH19JunyZl1av10UpTPBqOs0Zk0qZcW70Xt6PYktzk8paENVHLKXbH+IVmY8PPnhU5F4AL8nWh5K2kchOGg9m0kK9eMxJGhm3SWlUP1fGS+ll7bsqmVOxMgSWBQnFLo3whoCg9ob7QU6Xv9DpuV2n6MvdBvXYvADVr/NXe1Wn6l9URR53hHGxl/nZViOVdLUUqEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ9+ruyXi9tx2/E6RUpr+meorDZ9ZXjCRQERos5uG/A=;
 b=HG5Z1omCFx0bUYxyfQKDaFQngcRU9YnMZoR5UhL0YFyafpLCHQ5i4QE38+YwFTMSDm+XRjxxve3YEE9FWYd35Xg0+5KF+zd32ZY+WuJ797npcuwPI+VXkdS1yJP+hXozvpTR/+4uKR/kfFJ1Rgxo6U64WHB6YVW7yzvCndMjclZM02ZfWfVW45LuFLdIcTF5SzqH7ZP0mFTAem7tfz+2EhC4JCk0zASHL8bJpdvjSU9IqWArtDe+TKPGbG3w7YLShcN3Lyba0weB+YDhU3P7r8vbYeommOAnqGfvPCncOAJIaXi5Xw2OJSgRVVcbomQxFOXHtNNaGHyiBogG3bv4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ9+ruyXi9tx2/E6RUpr+meorDZ9ZXjCRQERos5uG/A=;
 b=wWQvtb58QMivxNu2RcbrZYoVI7IeOEyZHz3uKN11I0SmBjYq2Xf8/1btZLH+ULBqQCvMXf2wf6jJsQYTmUX8n0vkVTRjgSY6Qr7fkSnELbJ8ICJhPZf5vxkvbYIUXzcHt/Ol4sXNUVw5f2BF++vgiNU0cjFJhJ8cxTBTyJQoEnUmfyk6xdYvyKwOlNE9TvRP/XqhHAUITovZ9Dp8QxkvFefGptUvdECyZIGC5exNYRipPrfSy33QNFsUEb3b4ayKzH/Rd/ocaKn1YMDxVsOenLAh/Qq/ExoJGHDFLm2PY/+EUetLUNA/zKdc953qoYrPTPXZav5rqjZjOCkoavNjag==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SN6PR12MB2704.namprd12.prod.outlook.com (2603:10b6:805:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 12:31:33 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164%6]) with mapi id 15.20.3239.024; Fri, 7 Aug 2020
 12:31:33 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
Thread-Topic: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
Thread-Index: AQHWaNouv1V2TYM56Eqj6fr3Jx/DCaksmBQAgAAA6PA=
Date: Fri, 7 Aug 2020 12:31:33 +0000
Message-ID: 
 <SN1PR12MB24804872E06CD1410239B8188B490@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20200802143505.88409-1-chris.laplante@agilent.com>
 <75e480197f67f7605180feed70a14f23b4da6f16.camel@linuxfoundation.org>
In-Reply-To: 
 <75e480197f67f7605180feed70a14f23b4da6f16.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e83c91e-2d89-4cad-15cf-08d83acdd1cc
x-ms-traffictypediagnostic: SN6PR12MB2704:
x-microsoft-antispam-prvs: 
 <SN6PR12MB2704FE92692DBB0FCD88469C8B490@SN6PR12MB2704.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3swgOEXJTmlzcdwCtvr98i/nuVPb07qHnFcioXiWM1F/4ZlVXOli58v0qGwKHjJ3lGm6RqZzu9bGqLS5MWa0nkdLZfE8m4b9rzPzJyQgrM8Si5PVvLdlxsX71fQFA67PlcOmbpk42E9h5zIRpA0pxYQ8BQf4CAh2UB+9lgKRh3pajfoVvsABoGPHTzwEX7zqcDnH9WSoTz2U044/nLROJmPij552Q/1avXALjZ1gQU1E34fl5hAOMd8tKZxopstnYds2s3nvkC37Hp2VueFjHy4bIRjCOtK57oovVYRZJrrv8ug5mfTx9dzajpKBgbM/ahBRmWwVTucaDTZj5YjWsNGEEqprkQw57Fj4bRld4HzBHdigHvoIcnXLW51Itu1+
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(366004)(136003)(39860400002)(376002)(29502001)(9686003)(52536014)(33656002)(55016002)(26005)(8936002)(8676002)(6506007)(5660300002)(110136005)(478600001)(7696005)(2906002)(66446008)(76116006)(66556008)(66946007)(71200400001)(316002)(186003)(86362001)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 +ORsJJ5vuiB95b1N/60XnuaZKJoqotTu256a5qT3IS73Pm1jkyRcZJQrEBxOiPI0CdTxYVMXn2w/7gsSvHUqjHB5jwq7oD3+zpY+FXJSUVxWduhUeHZcv3n4ZMgwmT8bkFg5QF26PX3srfM/bdMEZSd8AhHSCgCBdviYfQ217eDbJd0oFsjPf0Rxzq8HoDvvaVvbWE17RoUBpqRCQ0n/Rm53TgvejeCsHu6V3d5+rq0C9jJ1WpEmzqE8jAVlsIAbEc8h+hXP1m/t095Phvl3uZJubzuPhmPoH76zQbycUsJEaBADbO7eJqvBv+dj5N44czIeQnWQ5xj1OG72U3p6L0rPJXTjowEW6rbw7tRi950v3F5MEFRm90KWPm3Q7cbvw8IIW6ZPp+eBkpzw8NmAOwP4qo8cp0OKy9eQ60skXVJQRez68RIpxn2PJQ62dNyRIfB1gcEYCEXUHSumDs66QJuQjn+FMn8inO4qC1VDUYe9NCmaoYb0FaXwxOAlcBFloxPYeQVPCellyGk2m3+8mtJJVUHdmoi6kBN10DoHiYhJMNIHPA4szWUL7o4eUGgsOXeUux4rRagZDelAfPyGO79OFWjqf5hMPLZohWJ+3El00CSTJVZxm79+ItsKxgre61ZplFOA9Ee3dM+vJ+XffA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e83c91e-2d89-4cad-15cf-08d83acdd1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 12:31:33.3576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BuNbi+uOJ96TJTNWoZEjtMAV0/6gmeMDOmZdjuOP+SqwE43a0B50D7LQfCxdPXNZdXYm27q+8wpP39DGOeSa7nqz2ObdNja6seaXOZcwBbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2704
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUmljaGFyZCwNCg0KPiBUaGlzIGRvZXMgbG9vayByZWFsbHkgaW50ZXJlc3RpbmcvdXNlZnVs
LCB0aGFua3MuIEkgaGF2ZSBhIGxvbmcgc3RhbmRpbmcgYnVnIHRvDQo+IGFkZCBtb3JlIGluZm9y
bWF0aW9uIGxpa2UgdGhpcyB0byBmdW5jdGlvbnMhDQo+IA0KPiBUaGUgb25lIHBpZWNlIEkgY2Fu
J3QgcXVpdGUgc2VlIHRoZXJlIGlzIHdoZXRoZXIgdGhpbmdzIGxpa2UgYXBwZW5kcyB0byBhIHNo
ZWxsDQo+IGZ1bmN0aW9uIGFyZSBoYW5kbGVkPw0KDQpVbmZvcnR1bmF0ZWx5IG5vdCwgc2luY2Ug
dGhlIHBhcnNlciByZXNldHMgdGhlIGxpbmVuby9mdW5jIHRvICIxLCBhdXRvZ2VuZXJhdGVkIi4g
DQpJJ2xsIGhhdmUgdG8gdGVhY2ggdGhlIHBhcnNlciB0byBtYWludGFpbiB0aGUgb3JpZ2luYWwg
bG9jYXRpb24gaW5mb3JtYXRpb24sIHByb2JhYmx5DQphcyBzb21lIHNvcnQgb2YgYXJyYXkgc2lu
Y2UgeW91IGNhbiBvZiBjb3Vyc2UgaGF2ZSBtdWx0aXBsZSBhcHBlbmRzLg0KDQpFdmVuIHRoZW4s
IGl0IHdvbid0IGJlIGFibGUgdG8gdHJhY2Ugd2hlcmUgcGVvcGxlIGRvIGQuYXBwZW5kVmFyKCJk
b19jb21waWxlIiwgLi4uDQpJIGhhdmUgc29tZSBoYWxmLWJha2VkIGlkZWFzIG9uIGhvdyB0byBo
YW5kbGUgdGhhdCBidXQgaXQgd291bGQgcHJvYmFibHkgcmVxdWlyZSANCmNoYW5nZXMgdG8gZGF0
YV9zbWFydC4gDQoNCj4gDQo+IEkgZG8gc29tZXRpbWVzIHJ1biB0aGUgc2NyaXB0cyBieSBoYW5k
IG15c2VsZi4gQW5vdGhlciBsb25nIHN0YW5kaW5nIGlkZWEgSQ0KPiBrZWVwIG1lYW5pbmcgdG8g
c29ydCBvdXQgaXMgYWRkaW5nIHRoZSBjb3JyZWN0IHBzZXVkbyBlbnZpcm9ubWVudCB0byB0aG9z
ZQ0KPiBmdW5jdGlvbnMsIGV2ZW4gYXMgY29tbWVudHMgdGhlIHVzZXIgY291bGQgZW5hYmxlIGZv
ciBkZWJ1Z2dpbmcuDQo+IA0KPiBEaWQgeW91IGZpbmlzaCB0aGUgb3RoZXIgc2hlbGwgdHJhcCBj
b2RlPyBJIHRoaW5rIHdlJ3JlIHByb2JhYmx5IG9rIHdpdGhvdXQgdGhhdA0KPiBidXQgaWYgeW91
IGhhZCBpdCB3b3JraW5nIGl0IG1pZ2h0IGJlIGdvb2QgdG8gcHV0IGluIHRoZSBhcmNoaXZlcz8N
Cg0KSSBuZWFybHkgZmluaXNoZWQgaXQuIEknbGwgc3VibWl0IGEgdjMgd2l0aCBpdC4gTXkgb3Jp
Z2luYWwgZGVzaWduIGZvciB0aGUgc2hlbGwgdHJhcCANCndhcyB0aGF0IGl0IHdvdWxkIGxvY2F0
ZSB0aGUgY29tbWVudCBieSBkZXRlcm1pbmluZyB3aGVyZSB0aGUgZnVuY3Rpb24gaXMgDQpkZWZp
bmVkIChieSB1c2luZyAic2hvcHQgLXMgZXh0ZGVidWciIGFuZCAiZGVmaW5lIC1GIikgYW5kIHRo
ZW4ganVzdCBncmFiIHRoZQ0KY29tbWVudCBieSBzdWJ0cmFjdGluZyBvbmUgZnJvbSB0aGUgbGlu
ZSBudW1iZXIuIEJ1dCBpdCBkb2VzbuKAmXQgcXVpdGUgd29yayANCmZvciBuZXN0ZWQgc2hlbGwg
ZnVuY3Rpb25zLiBTbyBJIHRoaW5rIEknbGwganVzdCBoYXZlIHRvIGRvIHdoYXQgSSBkbyBpbiBi
dWlsZC5weSwNCnNjYW4gYmFja3dhcmRzIGZyb20gdGhlIGZyYW1lIGxpbmUgbnVtYmVyIHRvIGxv
Y2F0ZSB0aGUgY29tbWVudC4NCg0KPiANCj4gSSdtIGEgYml0IGJlaGluZCBvbiBwYXRjaCByZXZp
ZXcgYnV0IHdpbGwgZ2V0IHRoZXNlIHF1ZXVlZC90ZXN0ZWQuDQo+IFRoYW5rcyBhZ2FpbiENCj4g
DQo+IENoZWVycywNCj4gDQo+IFJpY2hhcmQNCg0K
