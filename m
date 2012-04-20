Received: from mx4.leapfrog.com ([63.114.26.254])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dlazzari@leapfrog.com>) id 1SL2RT-0001Ue-UF
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Apr 2012 03:15:20 +0200
Received: from mx4.leapfrog.com (localhost [127.0.0.1])
	by localhost.leapfrog.com (Postfix) with ESMTP
	id 8C32C5EAA; Thu, 19 Apr 2012 18:05:34 -0700 (PDT)
Received: from NAEXCHHT01.na.leapfrog.com (unknown [10.15.6.13])
	by mx4.leapfrog.com (Postfix) with ESMTP
	id 787245E73; Thu, 19 Apr 2012 18:05:34 -0700 (PDT)
Received: from NAEMCASHT02.na.leapfrog.com (10.12.2.36) by
	NAEXCHHT01.na.leapfrog.com (10.15.6.13) with Microsoft SMTP Server
	(TLS) id 8.2.254.0; Thu, 19 Apr 2012 18:05:48 -0700
Received: from NAEMMAIL01.na.leapfrog.com ([fe80::252e:28a6:3d8f:6991]) by
	NAEMCASHT02.na.leapfrog.com ([::1]) with mapi id 14.01.0355.002;
	Thu, 19 Apr 2012 18:05:48 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: 'Chris Larson' <kergoth@gmail.com>
Thread-Topic: [bitbake-devel] python function used in variable expansion
	called multiple times per recipe
Thread-Index: Ac0dqUJmIcsujxmfQlyaUhmEaDraqQASVj+AAA3ZuJD//5rzAP//C9LQgAJx6QCAAGkYEP//tByAgABmojA=
Date: Fri, 20 Apr 2012 01:05:48 +0000
Message-ID: <E7A9054A5ACABE48B0E540E46E862B0F0427CC2B@NAEMMAIL01.na.leapfrog.com>
References: <E7A9054A5ACABE48B0E540E46E862B0F0427C336@NAEMMAIL01.na.leapfrog.com>
	<671D7BD596E04EE1961D6EA1C734C816@gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0F0427C5FA@NAEMMAIL01.na.leapfrog.com>
	<CABcZANn_xWLbxJRPK68Eu9iLjp6jjxkefPhe61UAcxzu91ZHwA@mail.gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0F0427CB32@NAEMMAIL01.na.leapfrog.com>
	<1334874480.3028.18.camel@ted>
	<E7A9054A5ACABE48B0E540E46E862B0F0427CB82@NAEMMAIL01.na.leapfrog.com>
	<CABcZANnEFUW0AMdkusU8-RrrNKq2kQmCNyZM=k+9Y8wQbfiLBg@mail.gmail.com>
In-Reply-To: <CABcZANnEFUW0AMdkusU8-RrrNKq2kQmCNyZM=k+9Y8wQbfiLBg@mail.gmail.com>
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
X-List-Received-Date: Fri, 20 Apr 2012 01:15:20 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Pg0KPk9uIFRodSwgQXByIDE5LCAyMDEyIGF0IDQ6MTMgUE0sIERhbmllbCBMYXp6YXJpIDxkbGF6
emFyaUBsZWFwZnJvZy5jb20+DQo+d3JvdGU6DQo+Pg0KPj4NCj4+Pk9uIFRodSwgMjAxMi0wNC0x
OSBhdCAyMToyNCArMDAwMCwgRGFuaWVsIExhenphcmkgd3JvdGU6DQo+Pj4+ID4+IEkgdGhpbmsg
aW1tZWRpYXRlIGV4cGFuc2lvbiBpcyB3aGF0IEnigJlsbCBuZWVkIHRvIHVzZSwgdGhhbmtzIGZv
ciB0aGUgdGlwLg0KPj4+PiA+PiBUaGF0IGF0IGxlYXN0IGJyaW5ncyB0aGUgaW52b2NhdGlvbiBk
b3duIHRvIG9uY2UgcGVyIHJ1bi4NCj5VbmZvcnR1bmF0ZWx5LA0KPj4+dGhlDQo+Pj4+ID4+IHZh
cmlhYmxlIGRvZXNu4oCZdCBzZWVtIHRvIGdldCBmaWxsZWQgaW4gd2hlbiBJIGNoYW5nZSB0byBp
bW1lZGlhdGUNCj4+Pj4gPmV4cGFuc2lvbi4NCj4+Pj4gPj4NCj4+Pj4gPj4gZGVmIHRlc3RGdW5j
KGJiLCBkKToNCj4+Pj4gPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQoIGJiLmRhdGEu
Z2V0VmFyKCJQTiIsIGQsIFRydWUpICkNCj4+Pj4gPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cmV0dXJuICJlMSINCj4+Pj4gPj4NCj4+Pj4gPj4gRVhURVJOUFYgOj0gIiR7QHRlc3RGdW5jKGJi
LCBkKX0iDQo+Pj4+ID4+DQo+Pj4+ID4+IE5vdyBvbmx5IHByaW50cyB0aGUgcGFja2FnZSBuYW1l
IG9uY2UsIGJ1dCB1c2luZyDigJNlLCBJIGRvbuKAmXQgc2VlIHRoZQ0KPj4+PiA+PiB2YXJpYWJs
ZSBFWFRFUk5QViBhdCBhbGwuDQo+Pj4+ID4NCj4+Pj4gPkRvbid0IGtub3cgd2hhdCB0byB0ZWxs
IHlvdS4gSXQgZG9lcyB3b3JrLCBzbyBpdCdzIHNvbWV0aGluZyB3cm9uZyBvbg0KPj4+PiA+eW91
ciBlbmQuIEVpdGhlciBpdCdzIHJldHVybmluZyBhbiBlbXB0eSBzdHJpbmcsIHdoaWNoIHdpbGwg
cmVzdWx0IGluDQo+Pj4+ID4tZSBvbmx5IHNob3dpbmcgdGhlIGNvbW1lbnRlZCBvdXQgZGVmaW5p
dGlvbiwgb3IgaXQncyByYWlzaW5nIGFuDQo+Pj4+ID5leGNlcHRpb24sIG9yIHNvbWV0aGluZyBl
bHNlIGluIHlvdXIgc2V0dXAuIEFzaWRlOiB5b3UgZG9uJ3QgbmVlZCB0bw0KPj4+PiA+cGFzcyAn
YmInIGluLiBUaGF0IG5hbWVzcGFjZSBpcyBhbHdheXMgYWNjZXNzaWJsZSwgZXZlbiBmcm9tIGRl
ZidkDQo+Pj4+ID5weXRob24gZnVuY3Rpb25zLg0KPj4+PiA+LS0NCj4+Pj4gPkNocmlzdG9waGVy
IExhcnNvbg0KPj4+Pg0KPj4+PiBKdXN0IHRob3VnaHQgSSdkIHByb3ZpZGUgYW4gdXBkYXRlIHJl
YWwgcXVpY2sgb24gdGhpcy4gSSBkaXNjb3ZlcmVkLA0KPj4+PiB0byBteSBkaXNtYXksIHRoYXQg
ZXZlbiBkb2luZyBhbiBpbW1lZGlhdGUgZXhwYW5zaW9uIHN0aWxsIHJhbiB0aGUNCj4+Pj4gY29k
ZSBiZWZvcmUgZXZlcnkgdGFzayBmb3IgdGhhdCByZWNpcGUuIEkgc3dpdGNoZWQgdG8gdXNpbmcg
YW4gZXZlbnQNCj4+Pj4gaGFuZGxlciwgYnV0IHRoZSBSZWNpcGVQYXJzZWQgZXZlbnQgb2NjdXJz
IGJlZm9yZSBldmVyeSB0YXNrIGZvciB0aGF0DQo+Pj4+IHJlY2lwZS4gRXZlbnR1YWxseSBJIGRp
c2NvdmVyZWQgdGhhdCB0aGUgdmFyaWFibGUgQkJfV09SS0VSQ09OVEVYVCBpcw0KPj4+PiBzZXQg
Zm9yIFJlY2lwZVBhcnNlZCBldmVudHMgd2hlbiB0aGV5IGFyZSBvY2N1cnJpbmcgYmVmb3JlIGEg
dGFzaywgYnV0DQo+Pj4+IG5vdCBmb3IgdGhlIGluaXRpYWwgcGFyc2UuIEFsc28sIEkgZGlzY292
ZXJlZCB0aGF0IHNldHRpbmcgYSB2YXJpYWJsZQ0KPj4+PiBpbiB0aGUgZXZlbnQgaGFuZGxlciB3
b3VsZCBub3QgbmVjZXNzYXJpbHkga2VlcCBpdCBzZXQgdGhyb3VnaA0KPj4+PiBidWlsZGluZyB0
aGUgcmVjaXBlLiBUaHVzIEkgZGV2aXNlZCB0aGUgYmVsb3cgY29kZSB0byBydW4gdGhlIHRpbWUN
Cj4+Pj4gaW50ZW5zaXZlIGNvZGUgZHVyaW5nIGluaXRpYWwgcGFyc2UgYW5kIGNhY2hlIHRoZSB2
YWx1ZSBpbiBhIGZpbGUgc28NCj4+Pj4gaXQgY2FuIGJlIHBpY2tlZCB1cCBhZ2FpbiBpbiBsYXRl
ciBldmVudHMuIEknbSBsZWF2aW5nIHRoaXMgaGVyZSBpbg0KPj4+PiBjYXNlIGl0IGhlbHBzIHNv
bWVvbmUgZWxzZS4NCj4+Pg0KPj4+SnVzdCBhcyBhIG5vdGUsIHdlIGhhdmUgdGhlIHBlcnNpc3Rf
ZGF0YSBjb2RlIGluIGJpdGJha2Ugd2hpY2ggd2FzDQo+Pj53cml0dGVuIGZvciB0aGlzIGtpbmQg
b2YgcmVhc29uIGluIHJlbGF0aW9uIHRvIFNSQ1JFViBhbmQgQVVUT0lOQyB3aGljaA0KPj4+dXNl
cyBhIHNxbGl0ZSBiYWNrZW5kIGFzIHRoZSBzdG9yYWdlLiBUaGVyZSBpc24ndCBhbnl0aGluZyB3
cm9uZyB3aXRoDQo+Pj53aGF0IHlvdSdyZSBkb2luZywgSSBqdXN0IHRob3VnaHQgSSdkIG1lbnRp
b24gaXQuDQo+Pj4NCj4+PkNoZWVycywNCj4+Pg0KPj4+UmljaGFyZA0KPj4NCj4+IFRoYXQgc291
bmRzIGxpa2UgYSBiZXR0ZXIgYWx0ZXJuYXRpdmUsIGJ1dCBJIGhhdmUgbm8gaWRlYSBob3cgdG8g
aW1wbGVtZW50DQo+aXQuIElzIHRoZXJlIGRvY3VtZW50YXRpb24gZm9yIGl0PyBJJ20gbm90IGV2
ZW4gc3VyZSBob3cgdG8gZ2V0IGF0IHRoZQ0KPnBlcnNpc3RfZGF0YSBmcm9tIHRoZSBldmVudCBo
YW5kbGVyLiBJcyB0aGVyZSBhIHdheSB0byBhY2Nlc3MgaXQgdXNpbmcgZCBvcg0KPnNvbWV0aGlu
Zz8NCj4NCj5UaGUgYmIucGVyc2lzdF9kYXRhIHB5dGhvbiBtb2R1bGUganVzdCBwcm92aWRlcyBh
IGNvbnZlbmllbmNlDQo+ZGljdGlvbmFyeSB3cmFwcGVyIGFyb3VuZCBhbiBzcWxpdGUzIGRhdGFi
YXNlLg0KPg0KPnBlcnNpc3QgPSBiYi5wZXJzaXN0X2RhdGEucGVyc2lzdCgnc29tZV9pZGVudGlm
aWVyJywgZCkNCj5wZXJzaXN0Wydmb28nXSA9ICdiYXInDQo+LS0NCj5DaHJpc3RvcGhlciBMYXJz
b24NCg0KVGhhdCB3b3JrZWQgd29uZGVyZnVsbHkhIFRoYW5rcyB0byBib3RoIG9mIHlvdSBmb3Ig
YWxsIG9mIHlvdXIgaGVscC4NCg==


