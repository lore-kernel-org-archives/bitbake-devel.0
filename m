Return-Path: <yang-mark.zhang@nokia-sbell.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934B3C30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 08:58:36 +0000 (UTC)
Received: from CNSHPPMGWESA01.NOKIA-SBELL.COM (CNSHPPMGWESA01.NOKIA-SBELL.COM [116.246.26.71])
 by mx.groups.io with SMTP id smtpd.web11.13353.1720169908593982425
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jul 2024 01:58:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: nokia-sbell.com, ip: 116.246.26.71, mailfrom: yang-mark.zhang@nokia-sbell.com)
X-CSE-ConnectionGUID: /TT10x/tRUidJ0MFIze/1w==
X-CSE-MsgGUID: Waqh8CcwQ26vdC+q/rBLBw==
X-IronPort-AV: E=Sophos;i="6.09,184,1716220800"; 
   d="scan'208";a="29190879"
Received: from unknown (HELO CNSHPPEXCH1610.nsn-intra.net) ([135.251.51.110])
  by CNSHPPMGWESA01.NOKIA-SBELL.COM with ESMTP; 05 Jul 2024 16:58:27 +0800
Received: from CNSHPPEXCH1609.nsn-intra.net (135.251.51.109) by
 CNSHPPEXCH1610.nsn-intra.net (135.251.51.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 16:58:27 +0800
Received: from CNSHPPEXCH1609.nsn-intra.net ([135.251.51.109]) by
 CNSHPPEXCH1609.nsn-intra.net ([135.251.51.109]) with mapi id 15.01.2507.039;
 Fri, 5 Jul 2024 16:58:27 +0800
From: "Yang-Mark Zhang (NSB)" <yang-mark.zhang@nokia-sbell.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [External] Re: [bitbake-devel] [PATCH] fix wrong http response
 for sstate cache checkstatus
Thread-Topic: [External] Re: [bitbake-devel] [PATCH] fix wrong http response
 for sstate cache checkstatus
Thread-Index: AdrN0vlXfayUKe18ST2naTm3p/nrBf//yqKAgABWggD//lSXIA==
Date: Fri, 5 Jul 2024 08:58:27 +0000
Message-ID: <2decaeba0ced4e538d8f66983c5153a7@nokia-sbell.com>
References: <a69fcf65d7994a728b5e2e1791f32a38@nokia-sbell.com>
	 <CANNYZj__8rYA09zo713LdmdbVYazsaajj74a--aAdvP-ZdoX3g@mail.gmail.com>
 <c20dab609d4943dc3aa9e678a25117523346cc18.camel@linuxfoundation.org>
In-Reply-To: <c20dab609d4943dc3aa9e678a25117523346cc18.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [135.251.51.115]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jul 2024 08:58:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16392

SGkgUmljaGFyZCwNCg0KYWZ0ZXIgdGVhbSBtZW1iZXIncyBoZWxwDQp3ZSBmaW5hbGx5IGNhbiBz
ZW5kIG91dCB0aGUgZW1haWwgdGhyb3VnaCAnZ2l0IHNlbmQtZW1haWwnDQpodHRwczovL2xpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcvZy9iaXRiYWtlLWRldmVsL21lc3NhZ2UvMTYzOTENCg0KdGhhbmsg
eW91IHZlcnkgbXVjaCBmb3IgeW91ciBuaWNlIGhlbHBpbmcNCg0KDQpZYW5nIHpoYW5nDQoNCg0K
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmlj
aGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4gDQpTZW50OiAyMDI05bm0N+aciDTml6Ug
MjM6MjcNClRvOiBhbGV4LmthbmF2aW5AZ21haWwuY29tOyBZYW5nLU1hcmsgWmhhbmcgKE5TQikg
PHlhbmctbWFyay56aGFuZ0Bub2tpYS1zYmVsbC5jb20+DQpDYzogYml0YmFrZS1kZXZlbEBsaXN0
cy5vcGVuZW1iZWRkZWQub3JnDQpTdWJqZWN0OiBbRXh0ZXJuYWxdIFJlOiBbYml0YmFrZS1kZXZl
bF0gW1BBVENIXSBmaXggd3JvbmcgaHR0cCByZXNwb25zZSBmb3Igc3N0YXRlIGNhY2hlIGNoZWNr
c3RhdHVzDQoNCkNhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2
ZXJ5IGNhcmVmdWwgd2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBT
ZWUgaHR0cDovL25vay5pdC9uc2IgZm9yIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQoNCk9uIFRo
dSwgMjAyNC0wNy0wNCBhdCAxMjoxNyArMDIwMCwgQWxleGFuZGVyIEthbmF2aW4gdmlhIGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgd3JvdGU6DQo+IE5vdGUgdGhhdCByZXZpZXdpbmcgcGF0Y2hlcyBz
ZW50IGFzIGF0dGFjaG1lbnRzIGlzIHZlcnkgZGlmZmljdWx0LCBhcyANCj4gd2UgY2FuJ3QgY29t
bWVudCBvbiB3aGF0IGlzIHNwZWNpZmljYWxseSBpbiB0aGUgcGF0Y2guIENhbiB5b3UgbWFrZSBh
biANCj4gYWNjb3VudCBvbiBnbWFpbCBwZXJoYXBzIGFuZCB1c2UgdGhhdCB0byBzZW5kIHRoZW0/
ICdnaXQgc2VuZC1lbWFpbCcNCj4gd2lsbCBlbnN1cmUgdGhlIHBhdGNoIGNyZWRlbnRpYWxzIHdp
bGwgYmUgdGhlIHNhbWUsIGl0J3Mgb25seSBmb3IgdGhlIA0KPiBwYXRjaCB0cmFuc3BvcnQuDQoN
ClRoZSBpc3N1ZSBpbiB0aGlzIG9uZSBsb29rcyBxdWl0ZSBzZXJpb3VzIHNvIHdlJ3ZlIGV4dHJh
Y3RlZCB0aGUgcGF0Y2ggYW5kIHF1ZXVlZCBmb3IgdGVzdGluZy4gSW4gZ2VuZXJhbCB3ZSBjYW4n
dCBhbHdheXMgY29tbWl0IHRvIGRvaW5nIHRoYXQgdGhvdWdoLg0KDQpDaGVlcnMsDQoNClJpY2hh
cmQNCg==

