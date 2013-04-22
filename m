Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]
	helo=am1outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B43198@freescale.com>) id 1UUETr-0006te-Hr
	for bitbake-devel@lists.openembedded.org;
	Mon, 22 Apr 2013 13:00:25 +0200
Received: from mail110-am1-R.bigfish.com (10.3.201.244) by
	AM1EHSOBE011.bigfish.com (10.3.207.133) with Microsoft SMTP Server id
	14.1.225.23; Mon, 22 Apr 2013 09:42:29 +0000
Received: from mail110-am1 (localhost [127.0.0.1])	by
	mail110-am1-R.bigfish.com (Postfix) with ESMTP id 81080E0249;
	Mon, 22 Apr 2013 09:42:29 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: -6
X-BigFish: VS-6(zz98dI9371I1431J936eI542I1432Izz1f42h1fc6h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ahzz8275dhz2dh2a8h668h839h8e2h8e3h93fhd25hf0ah1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh15d0h162dh1631h1758h18e1h1946h19b5h1ad9h1b0ahbe9i1155h)
Received: from mail110-am1 (localhost.localdomain [127.0.0.1]) by mail110-am1
	(MessageSwitch) id 1366623729683618_32226;
	Mon, 22 Apr 2013 09:42:09 +0000 (UTC)
Received: from AM1EHSMHS017.bigfish.com (unknown [10.3.201.254])	by
	mail110-am1.bigfish.com (Postfix) with ESMTP id 9AD58C02BD;
	Mon, 22 Apr 2013 09:42:09 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by AM1EHSMHS017.bigfish.com
	(10.3.207.155) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Mon, 22 Apr 2013 09:42:09 +0000
Received: from 039-SN2MPN1-023.039d.mgd.msft.net ([169.254.3.123]) by
	039-SN1MMR1-003.039d.mgd.msft.net ([10.84.1.16]) with mapi id
	14.02.0328.011; Mon, 22 Apr 2013 09:42:08 +0000
From: Purcareata Bogdan-B43198 <B43198@freescale.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] bitbake clean / cleanall / cleansstate not
	working
Thread-Index: Ac47T+pIaPJdHV4DTyGjcsswekyYHwCSlcCAAGjAqmA=
Date: Mon, 22 Apr 2013 09:42:07 +0000
Message-ID: <E7E317BD5B5D764682EEAC13B01676E26731F2@039-SN2MPN1-023.039d.mgd.msft.net>
References: <E7E317BD5B5D764682EEAC13B01676E2650BB2@039-SN2MPN1-021.039d.mgd.msft.net>
	<1366443597.10502.140.camel@ted>
In-Reply-To: <1366443597.10502.140.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.171.74.6]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake clean / cleanall / cleansstate not working
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 22 Apr 2013 11:00:31 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCkJvZ2RhbiBQLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJp
Y2hhcmQgUHVyZGllIFttYWlsdG86cmljaGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZ10N
Cj4gU2VudDogU2F0dXJkYXksIEFwcmlsIDIwLCAyMDEzIDEwOjQwIEFNDQo+IFRvOiBQdXJjYXJl
YXRhIEJvZ2Rhbi1CNDMxOTgNCj4gQ2M6IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVk
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIGJpdGJha2UgY2xlYW4gLyBjbGVh
bmFsbCAvIGNsZWFuc3N0YXRlIG5vdCB3b3JraW5nDQo+IA0KPiBPbiBXZWQsIDIwMTMtMDQtMTcg
YXQgMDk6NDIgKzAwMDAsIFB1cmNhcmVhdGEgQm9nZGFuLUI0MzE5OCB3cm90ZToNCj4gPiBIZWxs
bywNCj4gPg0KPiA+IEkgYW0gdXNpbmcgWW9jdG8gd2l0aCBCQl9WRVJTSU9OID0gIjEuMTguMCIg
YW5kIHRoZSBjb21tYW5kcyBpbiB0aGUgc3ViamVjdCBkbyBub3Qgc2VlbSB0byB3b3JrIC0NCj4g
dGhleSBkb24ndCBkbyBhbnl0aGluZy4gVGhlIGltYWdlIGhhcyB0aGUgcGFja2FnZXMgYnVpbHQu
DQo+ID4NCj4gPiAkIGJpdGJha2UgLWMgY2xlYW5hbGwgZ2NjDQo+ID4gWyAuLi4gXQ0KPiA+IE5P
VEU6IFRhc2tzIFN1bW1hcnk6IEF0dGVtcHRlZCAzIHRhc2tzIG9mIHdoaWNoIDAgZGlkbid0IG5l
ZWQgdG8gYmUgcmVydW4gYW5kIGFsbCBzdWNjZWVkZWQuDQo+ID4NCj4gPiAkIGJpdGJha2UgLWMg
Y2xlYW4gZ2NjDQo+ID4gWyAuLi4gXQ0KPiA+IE5PVEU6IFRhc2tzIFN1bW1hcnk6IEF0dGVtcHRl
ZCAxIHRhc2tzIG9mIHdoaWNoIDAgZGlkbid0IG5lZWQgdG8gYmUgcmVydW4gYW5kIGFsbCBzdWNj
ZWVkZWQuDQo+ID4NCj4gPiAkIGJpdGJha2UgLWMgY2xlYW5zc3RhdGUgZ2NjDQo+ID4gWyAuLi4g
XQ0KPiA+IE5PVEU6IFRhc2tzIFN1bW1hcnk6IEF0dGVtcHRlZCAyIHRhc2tzIG9mIHdoaWNoIDAg
ZGlkbid0IG5lZWQgdG8gYmUgcmVydW4gYW5kIGFsbCBzdWNjZWVkZWQuDQo+ID4NCj4gPiBUaGUg
aW5mb3JtYXRpb24gaW4gWyAuLi4gXSBpcyBub3QgcmVhbGx5IHJlbGV2YW50LiBJIGp1c3Qgd2Fu
dGVkIHRvDQo+ID4gZ2l2ZSB0aGUgb3V0cHV0IG1lc3NhZ2UuIEkga25vdyB0aGUgZXJyb3IgZGVz
Y3JpcHRpb24gaXMgdmFndWUsIGJ1dCBzbw0KPiA+IGlzIHRoaXMgYmVoYXZpb3IuIEkgZG9uJ3Qg
a25vdyB3aGF0IGl0IGNvdWxkIGJlIGZ1cnRoZXIgcmVsYXRlZCB0by4NCj4gDQo+IFdoYXQgZXhh
Y3RseSBhcmUgeW91IHRyeWluZyB0byBjbGVhbj8gVGhlIGFib3ZlIG1lc3NhZ2VzIHNheSBpdCBy
YW4gMSwgMg0KPiBvciAzIHRhc2tzIGFuZCB0aGV5IGFsbCBzdWNjZWVkZWQuDQoNCkluIG15IGV4
YW1wbGUsICJnY2MiIGNhbiBiZSByZXBsYWNlZCB3aXRoIGFueSBwYWNrYWdlIHByb3ZpZGVkIGJ5
IHRoZSBZb2N0byByZWNpcGVzLg0KVGhlIHByb2JsZW0gaXMgdGhhdCBub3RoaW5nIGlzIGJlaW5n
IHJ1biAtICIwIGRpZG4ndCBuZWVkIHRvIGJlIHJlcnVuICIgLSBzbyB0aGUgYnVpbHQgcGFja2Fn
ZSBpcyBuZXZlciBjbGVhbmVkLg0KVGhpcyBpc3N1ZSBpcyBwcmVzZW50IHdoZW4gcnVubmluZyBh
bGwgY2xlYW4gY29tbWFuZHMgLSBjbGVhbiwgY2xlYW5hbGwsIGNsZWFuc3N0YXRlLg0KDQo+IA0K
PiBLZWVwIGluIG1pbmQgdGhlcmUgYXJlIHNldmVyYWwgImdjYyIgY29tcG9uZW50cyBzdWNoIGFz
IGdjYy1jcm9zcywNCj4gZ2NjLWNyb3NzLWluaXRpYWwgYW5kIHNvIG9uLiAiZ2NjIiBpcyB0aGUg
b25lIHVzZWQgb24gdGFyZ2V0Lg0KDQpEbyB5b3UgdGhpbmsgdGhhdCBhIGNlcnRhaW4gcGFja2Fn
ZSBjYW4ndCBiZSBjbGVhbmVkIGJlY2F1c2Ugb2YgaXRzIGRlcGVuZGVuY2llcz8NCg0KPiANCj4g
Q2hlZXJzLA0KPiANCj4gUmljaGFyZA0KPiANCg0K



