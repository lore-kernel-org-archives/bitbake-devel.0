Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.51])
 by mx.groups.io with SMTP id smtpd.web12.43716.1597673426748704496
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Aug 2020 07:10:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=u0QYjo1u;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.51, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brjeok6sLraj8n7YdFxbeHE6MnjR5UDjuTiKwBAMyjiGPioD8FOmyXtS9xDbTij35cDj23w5pNWIgNKUESz5est8Bry0Fras9ygHpapUEwixzpz8jdTRYEzXA4Jrg997g11Mn371aHtcwRlrPdqOh2ksUS4tX76lQSy5ZlHOJckZs2PGOC2365mgvh9mXuvvSStpM/swtSkNkPnG3xdo9n4mSmyWP5ytGi0VQTa4dO+hHRvTQQol/SwZw98uyEaeUdpX7ThjO46jU6OONJ/cvaXTKLxA/y+A2tMyNm337PuX8Z8/tD5UKlrmgn/0KetujrUWXBmLMqObFclDUkJ/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMCgrue5Jol3m7PMTM1aDLYJQu6hA5gMoXH9jpFvsFw=;
 b=GIQPu5uBBzTcRE7BuVsG2o4GwkylwevBW9dqBuIQECd7DL5qMYWU5DGVjj8DcDMQGNfRwOwqIAQKpH+dgk1SpzlH2BDfCwC/JG0WhziTfYUbfG5lm1rLeGuW5rbgxX2ZjNEsKkTjEOi0Ia2I4Y7bco5Lt6uRAK3y8CzsEhZqwQA1ubokZeT8mShlhG6+iUAU+AnSHO7ZsCKXpTg7B8Y8xk3+bcww+NCK7no7lrMO2zG+KpCoriQwcQnNmGRmbtkQuLPpAh7Lm8QLeZllaMHTVWdlbAj6i1tXGjLvebQ3WnlQ+vlOHHwq1jPl8Ag063nEGNwVrI03ar4i3iFtfnQ77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMCgrue5Jol3m7PMTM1aDLYJQu6hA5gMoXH9jpFvsFw=;
 b=u0QYjo1uiOKWtlVehUykTsLLDd6tk7cKvewDcFyaGvQrWUC4vtY0v3uQgHFtjb+IXUeDNl8zNIXo0qSKPAtelYh8+7T+giMQYePOFi61BTIOWDjswyew3LbaxxRrIUpwrmooChXLZs7uY1Snfz8lI4nhn0i/i3GoXZvH0BCAENFeCOrLAuR1ShgdylIZ2qbP0LHLekqgDjj8Up+//wpidfrBjszfokN4FlFVmWSjz0UX60+EEOBIjahBRYBZ1pYD+k2S0/IoscqHt97c54i5CISKR1IVTxe8UJDHkzqbENQFa3tm8cid0K9836cB5LJdQJmNXkKB08BbJr04XpsPuw==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SN1PR12MB2400.namprd12.prod.outlook.com (2603:10b6:802:2f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Mon, 17 Aug
 2020 14:10:20 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164%6]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 14:10:20 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
Thread-Topic: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
Thread-Index: 
 AQHWaNouv1V2TYM56Eqj6fr3Jx/DCaksmBQAgAAA6PCAAB6fAIAAA4DwgAAGQwCAD6v8YA==
Date: Mon, 17 Aug 2020 14:10:20 +0000
Message-ID: 
 <SN1PR12MB24807DDE924F52AA537FE5C98B5F0@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20200802143505.88409-1-chris.laplante@agilent.com>
	 <75e480197f67f7605180feed70a14f23b4da6f16.camel@linuxfoundation.org>
	 <SN1PR12MB24804872E06CD1410239B8188B490@SN1PR12MB2480.namprd12.prod.outlook.com>
	 <3fb78737e35050c1f441056418e3b56d5b2faf84.camel@linuxfoundation.org>
	 <SN1PR12MB2480A13C1FC1632218BF99898B490@SN1PR12MB2480.namprd12.prod.outlook.com>
 <f595fac3c7d713fe9547c71db32cece879703da9.camel@linuxfoundation.org>
In-Reply-To: 
 <f595fac3c7d713fe9547c71db32cece879703da9.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1954e12f-9379-4dc4-d9a1-08d842b7469c
x-ms-traffictypediagnostic: SN1PR12MB2400:
x-microsoft-antispam-prvs: 
 <SN1PR12MB2400E2C0D4E0E25ABBC0ABB58B5F0@SN1PR12MB2400.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pMpZVhLhPI03p6P7UBUnEiF+WCv/RGIC9qDoUWAm1ZGrwPWquxn9Kkb+JGW7KFX+L6KVRH34Mw/v0CVUWMbD1kX3KwYWLOYxZoPp3JXbBBAsupAqkeJs3/hzvjDrcDEyQUZovAVDRiQHsFHzD2odugIXQSPv0ozE999d7HoCf4a07ejIaVRurXli+2HUaNMiKcfUJNg6VrAN/45K2jXTGIXbgKtm9ZrN5FoVvNXfry6pZSTO4vp+X+y75BesQ5XS3nBKXbXwoN2me7Y/Ut/NA5aip6lmfSNd5BbddjI/R2e5y4Clm6D1zecTcKY2cQ7ixm6MVjmIRLnztyGh6TmYCk0rI04VUyI0ojofCWUuh66dq6+GYNzRlD4fskQ60y6k
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(29502001)(86362001)(7696005)(33656002)(110136005)(2906002)(8676002)(316002)(26005)(6506007)(8936002)(71200400001)(5660300002)(52536014)(186003)(9686003)(66476007)(66556008)(64756008)(66446008)(55016002)(76116006)(66946007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 Hgvno5eWpTCykLLmtsDPu51kgtA1zUYUthE3JJlfQn4Sc22vQdO0bTiwwRY/fmvx7leIHXjrLOqi1BdARM+LvPl59Yc0dS2WFRiNQOKMrpn8IFk0v4JB7Lkph5co/MYuOJabTKRmOec0/PRRnwJIa63HokhDpdt1xGo0u4l3rGgSFABkuXPtDw/mhKHfsSG/GYayhvkNcuMCKc0wGa5/Ptj9kbp5Hcdvsycb/jcwDDvfLQpgNLcAR+d3lipQLd0aqE4WGv5yNLVovATjJNp7pFW6dpnWwUoazFtMb9UF1P9bjPr+AUOGbM0us/7vNKjsp0IN7Cr5DdUCqE/1GPjxswzAALFhRpXcV0aGtUIeJtpH6ELYJjZy7R7EewrI47rPRjH31I6h44Y8kl8VsC0FIHidWq27GPEZY4pt/QK8MiiFeX3XziQw3VU/d6ZmHS/ycLyXwSq0gXxWvSYWI8y5+Pk07K0hV4O7jMHoch/bNATofKTehvpiOajGTr+K33vNoGaMi55wO5IrNS5llgxbh3wkI0Twprqix/+nE1xiY8hIXtaLj5OGCWWose8cV8cvLqRVnmkq7dzFMV0KES2joj3WF4rem/vdJ6AOV058qzb93eD8Dfu2aR8Cc4qGuseqFPxlwU+GVB7zNVY6cOOmjg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1954e12f-9379-4dc4-d9a1-08d842b7469c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 14:10:20.2868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWXh4A9X1PjwsCft0LKC1Vy4W25VyIG0nJBHy020C94vQuz9LOyOspDPY1zBV7+TJcUWfg19EsKqys3O1xX6nOy/w9wn/rhQzNMWkMXgN1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2400
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUmljaGFyZCwNCg0KPiBPbiBGcmksIDIwMjAtMDgtMDcgYXQgMTQ6MzAgKzAwMDAsIGNocmlz
LmxhcGxhbnRlQGFnaWxlbnQuY29tIHdyb3RlOg0KPiA+ID4gPiBVbmZvcnR1bmF0ZWx5IG5vdCwg
c2luY2UgdGhlIHBhcnNlciByZXNldHMgdGhlIGxpbmVuby9mdW5jIHRvICIxLA0KPiA+ID4gPiBh
dXRvZ2VuZXJhdGVkIi4NCj4gPiA+ID4gSSdsbCBoYXZlIHRvIHRlYWNoIHRoZSBwYXJzZXIgdG8g
bWFpbnRhaW4gdGhlIG9yaWdpbmFsIGxvY2F0aW9uDQo+ID4gPiA+IGluZm9ybWF0aW9uLCBwcm9i
YWJseSBhcyBzb21lIHNvcnQgb2YgYXJyYXkgc2luY2UgeW91IGNhbiBvZg0KPiA+ID4gPiBjb3Vy
c2UgaGF2ZSBtdWx0aXBsZSBhcHBlbmRzLg0KPiA+ID4gPg0KPiA+ID4gPiBFdmVuIHRoZW4sIGl0
IHdvbid0IGJlIGFibGUgdG8gdHJhY2Ugd2hlcmUgcGVvcGxlIGRvDQo+ID4gPiA+IGQuYXBwZW5k
VmFyKCJkb19jb21waWxlIiwgLi4uDQo+ID4gPiA+IEkgaGF2ZSBzb21lIGhhbGYtYmFrZWQgaWRl
YXMgb24gaG93IHRvIGhhbmRsZSB0aGF0IGJ1dCBpdCB3b3VsZA0KPiA+ID4gPiBwcm9iYWJseSBy
ZXF1aXJlIGNoYW5nZXMgdG8gZGF0YV9zbWFydC4NCj4gPiA+DQo+ID4gPiBIYXZlIGEgbG9vayBh
dCB3aGF0IHRoZSBkLnZhcmhpc3RvcnkuZW1pdCh2YXIsIG92YWwsIHZhbCwgbywgZCkgY2FsbA0K
PiA+ID4gZG9lcyBpbiBlbWl0KCkgaW4gZGF0YS5weS4gVGhlIGhhcmQgcGFydCBpcyB3ZSBoYXZl
IHRvIGhhdmUgdmFyaWFibGUNCj4gPiA+IHRyYWNraW5nIHR1cm5lZCBvbiBmb3IgdGhhdCB0byB3
b3JrLiBZb3UgY2FuIHNlZSB0aGUgb3V0cHV0IHdpdGgNCj4gPiA+ICJiaXRiYWtlIC1lIi4gV2Ug
ZG9uJ3QgdHVybiBvbiB2YXJpYWJsZSB0cmFja2luZyBieSBkZWZhdWx0IGFzIGl0cyBhDQo+ID4g
PiBoZWF2eSBsb2FkIGZvciBnZW5lcmFsIHBhcnNpbmcgYW5kIG5vdCBuZWVkZWQuIFlvdSBtYXkg
YmUgYWJsZSB0bw0KPiA+ID4gZW5hYmxlIHRoYXQgaW4gd29ya2VyIGNvbnRleHQgdGhvdWdoLg0K
PiA+DQo+ID4gImJpdGJha2UgLWUiIGRvZXNu4oCZdCBzZWVtIHRvIHByaW50IHRoZSBoaXN0b3J5
IGluZm9ybWF0aW9uIGZvciB0YXNrcw0KPiA+IHRob3VnaC4gTWF5YmUgSSBza2ltbWVkIGl0IHRv
byBmYXN0IGJ1dCBJIGRvbid0IHJlbWVtYmVyIGl0IGFsbCB0aGUNCj4gPiBvdGhlciB0aW1lcyBJ
J3ZlIHVzZWQgImJpdGJha2UgLWUiIGVpdGhlci4NCj4gDQo+IEhtbS4gSSB3b25kZXIgd2h5IHdl
IGRvbid0IHNob3cgdGhhdCBmb3IgZnVuY3Rpb25zLiBJdHMgZWFzeSB0byB0dXJuDQo+IG9uOg0K
PiANCj4gZGlmZiAtLWdpdCBhL2JpdGJha2UvbGliL2JiL2RhdGEucHkgYi9iaXRiYWtlL2xpYi9i
Yi9kYXRhLnB5IGluZGV4DQo+IGIwNjgzYzUxODAzLi4wNmJlMzVmYjE0OSAxMDA2NDQNCj4gLS0t
IGEvYml0YmFrZS9saWIvYmIvZGF0YS5weQ0KPiArKysgYi9iaXRiYWtlL2xpYi9iYi9kYXRhLnB5
DQo+IEBAIC0xODUsNyArMTg1LDcgQEAgZGVmIGVtaXRfZW52KG89c3lzLl9fc3Rkb3V0X18sIGQg
PSBpbml0KCksIGFsbD1GYWxzZSk6DQo+ICAgICAgZ3JvdXBlZCA9IGdyb3VwYnkoa2V5cywgaXNm
dW5jKQ0KPiAgICAgIGZvciBpc2Z1bmMsIGtleXMgaW4gZ3JvdXBlZDoNCj4gICAgICAgICAgZm9y
IGtleSBpbiBzb3J0ZWQoa2V5cyk6DQo+IC0gICAgICAgICAgICBlbWl0X3ZhcihrZXksIG8sIGQs
IGFsbCBhbmQgbm90IGlzZnVuYykgYW5kIG8ud3JpdGUoJ1xuJykNCj4gKyAgICAgICAgICAgIGVt
aXRfdmFyKGtleSwgbywgZCwgYWxsKSBhbmQgby53cml0ZSgnXG4nKQ0KPiANCj4gIGRlZiBleHBv
cnRlZF9rZXlzKGQpOg0KPiAgICAgIHJldHVybiAoa2V5IGZvciBrZXkgaW4gZC5rZXlzKCkgaWYg
bm90IGtleS5zdGFydHN3aXRoKCdfXycpIGFuZA0KPiANCj4gUGVyaGFwcyB3ZSBzaG91bGQgZG8g
dGhhdCwgcmVhbGx5IG5vdCBzdXJlIHdoeSB3ZSBkb24ndC4NCj4gDQo+IE15IHBvaW50IGlzIHRo
ZSBkYXRhIGlzIHRoZXJlIChmdW5jdGlvbnMgYXJlIHRyZWF0ZWQgdGhlIHNhbWUgYXMgYW55IG90
aGVyDQo+IHZhcmlhYmxlIGludGVybmFsbHkgaW4gbW9zdCBjb2RlIHBhdGhzLCB0aGV5IGp1c3Qg
aGF2ZSBhbiBleHRyYSB2YXJGbGFnIHNldCkuDQo+IA0KPiA+ID4gRG9uJ3Qgd29ycnkgYWJvdXQg
aXQgdG9vIG11Y2gsIGl0IGp1c3Qgc291bmRlZCBxdWl0ZSBuZWF0IGFuZCBJDQo+ID4gPiBkb24n
dCBsaWtlIHdvcmsgbGlrZSB0aGF0IHRvIGdldCBsb3N0IQ0KPiA+DQo+ID4gSSBzZW50IHRoZSBy
b3VnaCBXSVAgdmVyc2lvbiBJIGhhZCBmb3IgeW91ciBGcmlkYXkgcmVhZGluZyBwbGVhc3VyZQ0K
PiA+IDopDQoNCldoYXQgZG8geW91IHRoaW5rIGlmIHdlIGNoYW5nZWQgZGF0YV9zbWFydCB0byBh
bHdheXMgdHJhY2sgdmFyaWFibGUgaGlzdG9yeSBmb3IgbG93ZXJjYXNlIHZhcmlhYmxlcyAoaS5l
LiBmdW5jdGlvbnMpPyBUaGlzIHdvdWxkIGxldCBtZSBnZW5lcmF0ZSBiYWNrdHJhY2VzIGZvciBl
dmVuIGFwcGVuZGVkL3ByZXBlbmRlZCBmdW5jdGlvbnMuIA0KDQpDaHJpcw0K
