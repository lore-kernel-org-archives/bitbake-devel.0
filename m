Received: from mx3.leapfrog.com ([63.114.26.253])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dlazzari@leapfrog.com>) id 1SL0hP-0007p5-3p
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Apr 2012 01:23:39 +0200
Received: from mx3.leapfrog.com (localhost [127.0.0.1])
	by localhost.leapfrog.com (Postfix) with ESMTP
	id A75565F96; Thu, 19 Apr 2012 16:13:41 -0700 (PDT)
Received: from NAEXCHHT01.na.leapfrog.com (unknown [10.15.6.13])
	by mx3.leapfrog.com (Postfix) with ESMTP
	id 81FE85E8A; Thu, 19 Apr 2012 16:13:41 -0700 (PDT)
Received: from NAEMCASHT01.na.leapfrog.com (10.16.4.161) by
	NAEXCHHT01.na.leapfrog.com (10.15.6.13) with Microsoft SMTP Server
	(TLS) id 8.2.254.0; Thu, 19 Apr 2012 16:13:56 -0700
Received: from NAEMMAIL01.na.leapfrog.com ([fe80::252e:28a6:3d8f:6991]) by
	NAEMCASHT01.na.leapfrog.com ([::1]) with mapi id 14.01.0355.002;
	Thu, 19 Apr 2012 16:13:56 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: 'Richard Purdie' <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] python function used in variable expansion
	called multiple times per recipe
Thread-Index: Ac0dqUJmIcsujxmfQlyaUhmEaDraqQASVj+AAA3ZuJD//5rzAP//C9LQgAJx6QCAAGkYEA==
Date: Thu, 19 Apr 2012 23:13:55 +0000
Message-ID: <E7A9054A5ACABE48B0E540E46E862B0F0427CB82@NAEMMAIL01.na.leapfrog.com>
References: <E7A9054A5ACABE48B0E540E46E862B0F0427C336@NAEMMAIL01.na.leapfrog.com>
	<671D7BD596E04EE1961D6EA1C734C816@gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0F0427C5FA@NAEMMAIL01.na.leapfrog.com>
	<CABcZANn_xWLbxJRPK68Eu9iLjp6jjxkefPhe61UAcxzu91ZHwA@mail.gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0F0427CB32@NAEMMAIL01.na.leapfrog.com>
	<1334874480.3028.18.camel@ted>
In-Reply-To: <1334874480.3028.18.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.100.2.5]
MIME-Version: 1.0
Cc: "'bitbake-devel@lists.openembedded.org'
	\(bitbake-devel@lists.openembedded.org\)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: python function used in variable expansion called multiple times per recipe
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
X-List-Received-Date: Thu, 19 Apr 2012 23:23:39 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj5PbiBUaHUsIDIwMTItMDQtMTkgYXQgMjE6MjQgKzAwMDAsIERhbmllbCBMYXp6YXJpIHdy
b3RlOg0KPj4gPj4gSSB0aGluayBpbW1lZGlhdGUgZXhwYW5zaW9uIGlzIHdoYXQgSeKAmWxsIG5l
ZWQgdG8gdXNlLCB0aGFua3MgZm9yIHRoZSB0aXAuDQo+PiA+PiBUaGF0IGF0IGxlYXN0IGJyaW5n
cyB0aGUgaW52b2NhdGlvbiBkb3duIHRvIG9uY2UgcGVyIHJ1bi4gVW5mb3J0dW5hdGVseSwNCj50
aGUNCj4+ID4+IHZhcmlhYmxlIGRvZXNu4oCZdCBzZWVtIHRvIGdldCBmaWxsZWQgaW4gd2hlbiBJ
IGNoYW5nZSB0byBpbW1lZGlhdGUNCj4+ID5leHBhbnNpb24uDQo+PiA+Pg0KPj4gPj4gZGVmIHRl
c3RGdW5jKGJiLCBkKToNCj4+ID4+ICAgICAgICAgICAgICAgICBwcmludCggYmIuZGF0YS5nZXRW
YXIoIlBOIiwgZCwgVHJ1ZSkgKQ0KPj4gPj4gICAgICAgICAgICAgICAgIHJldHVybiAiZTEiDQo+
PiA+Pg0KPj4gPj4gRVhURVJOUFYgOj0gIiR7QHRlc3RGdW5jKGJiLCBkKX0iDQo+PiA+Pg0KPj4g
Pj4gTm93IG9ubHkgcHJpbnRzIHRoZSBwYWNrYWdlIG5hbWUgb25jZSwgYnV0IHVzaW5nIOKAk2Us
IEkgZG9u4oCZdCBzZWUgdGhlDQo+PiA+PiB2YXJpYWJsZSBFWFRFUk5QViBhdCBhbGwuDQo+PiA+
DQo+PiA+RG9uJ3Qga25vdyB3aGF0IHRvIHRlbGwgeW91LiBJdCBkb2VzIHdvcmssIHNvIGl0J3Mg
c29tZXRoaW5nIHdyb25nIG9uDQo+PiA+eW91ciBlbmQuIEVpdGhlciBpdCdzIHJldHVybmluZyBh
biBlbXB0eSBzdHJpbmcsIHdoaWNoIHdpbGwgcmVzdWx0IGluDQo+PiA+LWUgb25seSBzaG93aW5n
IHRoZSBjb21tZW50ZWQgb3V0IGRlZmluaXRpb24sIG9yIGl0J3MgcmFpc2luZyBhbg0KPj4gPmV4
Y2VwdGlvbiwgb3Igc29tZXRoaW5nIGVsc2UgaW4geW91ciBzZXR1cC4gQXNpZGU6IHlvdSBkb24n
dCBuZWVkIHRvDQo+PiA+cGFzcyAnYmInIGluLiBUaGF0IG5hbWVzcGFjZSBpcyBhbHdheXMgYWNj
ZXNzaWJsZSwgZXZlbiBmcm9tIGRlZidkDQo+PiA+cHl0aG9uIGZ1bmN0aW9ucy4NCj4+ID4tLQ0K
Pj4gPkNocmlzdG9waGVyIExhcnNvbg0KPj4NCj4+IEp1c3QgdGhvdWdodCBJJ2QgcHJvdmlkZSBh
biB1cGRhdGUgcmVhbCBxdWljayBvbiB0aGlzLiBJIGRpc2NvdmVyZWQsDQo+PiB0byBteSBkaXNt
YXksIHRoYXQgZXZlbiBkb2luZyBhbiBpbW1lZGlhdGUgZXhwYW5zaW9uIHN0aWxsIHJhbiB0aGUN
Cj4+IGNvZGUgYmVmb3JlIGV2ZXJ5IHRhc2sgZm9yIHRoYXQgcmVjaXBlLiBJIHN3aXRjaGVkIHRv
IHVzaW5nIGFuIGV2ZW50DQo+PiBoYW5kbGVyLCBidXQgdGhlIFJlY2lwZVBhcnNlZCBldmVudCBv
Y2N1cnMgYmVmb3JlIGV2ZXJ5IHRhc2sgZm9yIHRoYXQNCj4+IHJlY2lwZS4gRXZlbnR1YWxseSBJ
IGRpc2NvdmVyZWQgdGhhdCB0aGUgdmFyaWFibGUgQkJfV09SS0VSQ09OVEVYVCBpcw0KPj4gc2V0
IGZvciBSZWNpcGVQYXJzZWQgZXZlbnRzIHdoZW4gdGhleSBhcmUgb2NjdXJyaW5nIGJlZm9yZSBh
IHRhc2ssIGJ1dA0KPj4gbm90IGZvciB0aGUgaW5pdGlhbCBwYXJzZS4gQWxzbywgSSBkaXNjb3Zl
cmVkIHRoYXQgc2V0dGluZyBhIHZhcmlhYmxlDQo+PiBpbiB0aGUgZXZlbnQgaGFuZGxlciB3b3Vs
ZCBub3QgbmVjZXNzYXJpbHkga2VlcCBpdCBzZXQgdGhyb3VnaA0KPj4gYnVpbGRpbmcgdGhlIHJl
Y2lwZS4gVGh1cyBJIGRldmlzZWQgdGhlIGJlbG93IGNvZGUgdG8gcnVuIHRoZSB0aW1lDQo+PiBp
bnRlbnNpdmUgY29kZSBkdXJpbmcgaW5pdGlhbCBwYXJzZSBhbmQgY2FjaGUgdGhlIHZhbHVlIGlu
IGEgZmlsZSBzbw0KPj4gaXQgY2FuIGJlIHBpY2tlZCB1cCBhZ2FpbiBpbiBsYXRlciBldmVudHMu
IEknbSBsZWF2aW5nIHRoaXMgaGVyZSBpbg0KPj4gY2FzZSBpdCBoZWxwcyBzb21lb25lIGVsc2Uu
DQo+DQo+SnVzdCBhcyBhIG5vdGUsIHdlIGhhdmUgdGhlIHBlcnNpc3RfZGF0YSBjb2RlIGluIGJp
dGJha2Ugd2hpY2ggd2FzDQo+d3JpdHRlbiBmb3IgdGhpcyBraW5kIG9mIHJlYXNvbiBpbiByZWxh
dGlvbiB0byBTUkNSRVYgYW5kIEFVVE9JTkMgd2hpY2gNCj51c2VzIGEgc3FsaXRlIGJhY2tlbmQg
YXMgdGhlIHN0b3JhZ2UuIFRoZXJlIGlzbid0IGFueXRoaW5nIHdyb25nIHdpdGgNCj53aGF0IHlv
dSdyZSBkb2luZywgSSBqdXN0IHRob3VnaHQgSSdkIG1lbnRpb24gaXQuDQo+DQo+Q2hlZXJzLA0K
Pg0KPlJpY2hhcmQNCg0KVGhhdCBzb3VuZHMgbGlrZSBhIGJldHRlciBhbHRlcm5hdGl2ZSwgYnV0
IEkgaGF2ZSBubyBpZGVhIGhvdyB0byBpbXBsZW1lbnQgaXQuIElzIHRoZXJlIGRvY3VtZW50YXRp
b24gZm9yIGl0PyBJJ20gbm90IGV2ZW4gc3VyZSBob3cgdG8gZ2V0IGF0IHRoZSBwZXJzaXN0X2Rh
dGEgZnJvbSB0aGUgZXZlbnQgaGFuZGxlci4gSXMgdGhlcmUgYSB3YXkgdG8gYWNjZXNzIGl0IHVz
aW5nIGQgb3Igc29tZXRoaW5nPw0K


