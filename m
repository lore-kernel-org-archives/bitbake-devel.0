Received: from mx3.leapfrog.com ([63.114.26.253])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dlazzari@leapfrog.com>) id 1Qogp2-00070J-Bm
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Aug 2011 21:09:40 +0200
Received: from mx3.leapfrog.com (localhost [127.0.0.1])
	by localhost.leapfrog.com (Postfix) with ESMTP
	id 0F06C5EE0; Wed,  3 Aug 2011 12:05:00 -0700 (PDT)
Received: from NAEXCHHT01.na.leapfrog.com (unknown [10.15.6.13])
	by mx3.leapfrog.com (Postfix) with ESMTP
	id C975C5E8C; Wed,  3 Aug 2011 12:04:59 -0700 (PDT)
Received: from naexchht.na.leapfrog.com (10.17.2.11) by
	NAEXCHHT01.na.leapfrog.com (10.15.6.13) with Microsoft SMTP Server
	(TLS) id 8.2.254.0; Wed, 3 Aug 2011 12:04:59 -0700
Received: from naemmail08.na.leapfrog.com ([10.11.5.92]) by
	naexchht.na.leapfrog.com ([10.17.2.11]) with mapi;
	Wed, 3 Aug 2011 12:04:59 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: 'Chris Larson' <clarson@kergoth.com>
Date: Wed, 3 Aug 2011 12:04:58 -0700
Thread-Topic: [bitbake-devel] Bug with clearing SRCREV cache
Thread-Index: AcxSCl6KE4eY50a4Qj2HggywlwIepAAAEQSAAAFQD/A=
Message-ID: <359B10B9B28B294BAA6405D9320312E0111E934065@naemmail08.na.leapfrog.com>
References: <359B10B9B28B294BAA6405D9320312E0111E93405D@naemmail08.na.leapfrog.com>
	<CABcZANmNObv54E4yW52t1wYt6pyranwAS5Hth8S1cF61ZM5N=g@mail.gmail.com>
	<359B10B9B28B294BAA6405D9320312E0111E934062@naemmail08.na.leapfrog.com>
	<CABcZAN=g64xzJXijTwoJN-a6LQODb1itMBcDgtwnZR7kjwdRsg@mail.gmail.com>
	<359B10B9B28B294BAA6405D9320312E0111E934063@naemmail08.na.leapfrog.com>
In-Reply-To: <359B10B9B28B294BAA6405D9320312E0111E934063@naemmail08.na.leapfrog.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
Cc: "'bitbake-devel@lists.openembedded.org'"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Bug with clearing SRCREV cache
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
X-List-Received-Date: Wed, 03 Aug 2011 19:09:40 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGFuaWVsIExhenphcmkNCj5TZW50
OiBXZWRuZXNkYXksIEF1Z3VzdCAwMywgMjAxMSAxMToyOSBBTQ0KPlRvOiAnQ2hyaXMgTGFyc29u
Jw0KPkNjOiBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj5TdWJqZWN0OiBS
RTogW2JpdGJha2UtZGV2ZWxdIEJ1ZyB3aXRoIGNsZWFyaW5nIFNSQ1JFViBjYWNoZQ0KPg0KPj4t
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj5Gcm9tOiBrZXJnb3RoQGdtYWlsLmNvbSBbbWFp
bHRvOmtlcmdvdGhAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YgQ2hyaXMNCj4+TGFyc29uDQo+PlNl
bnQ6IFdlZG5lc2RheSwgQXVndXN0IDAzLCAyMDExIDExOjIzIEFNDQo+PlRvOiBEYW5pZWwgTGF6
emFyaQ0KPj5DYzogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+PlN1Ympl
Y3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gQnVnIHdpdGggY2xlYXJpbmcgU1JDUkVWIGNhY2hlDQo+
Pg0KPj5PbiBXZWQsIEF1ZyAzLCAyMDExIGF0IDExOjIxIEFNLCBEYW5pZWwgTGF6emFyaSA8ZGxh
enphcmlAbGVhcGZyb2cuY29tPg0KPj53cm90ZToNCj4+Pj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4+PkZyb206IGtlcmdvdGhAZ21haWwuY29tIFttYWlsdG86a2VyZ290aEBnbWFpbC5j
b21dIE9uIEJlaGFsZiBPZiBDaHJpcw0KPj4+PkxhcnNvbg0KPj4+PlNlbnQ6IFR1ZXNkYXksIEF1
Z3VzdCAwMiwgMjAxMSA2OjI0IFBNDQo+Pj4+VG86IERhbmllbCBMYXp6YXJpDQo+Pj4+Q2M6IGJp
dGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPj4+PlN1YmplY3Q6IFJlOiBbYml0
YmFrZS1kZXZlbF0gQnVnIHdpdGggY2xlYXJpbmcgU1JDUkVWIGNhY2hlDQo+Pj4+DQo+Pj4+T24g
VHVlLCBBdWcgMiwgMjAxMSBhdCAxMjowNiBQTSwgRGFuaWVsIExhenphcmkNCj4+PGRsYXp6YXJp
QGxlYXBmcm9nLmNvbT4NCj4+Pj53cm90ZToNCj4+Pj4+IEnigJltIG5vdCBleGFjdGx5IHN1cmUg
aWYgdGhpcyBpcyBhbiBvZS1jb3JlIG9yIGEgYml0YmFrZSBidWcsIHNvIEnigJltDQo+Pj4+dHJ5
aW5nDQo+Pj4+PiBoZXJlIGZpcnN0LiBJIG5vdGljZWQgdGhlIG90aGVyIGRheSB0aGF0IG9uZSBv
ZiBvdXIgcmVjaXBlcyB0aGF0DQo+PnB1bGxzDQo+Pj4+PiBzb3VyY2UgZnJvbSBzdm4gYW5kIHVz
ZXMgU1JDUkVWID0g4oCcQVVUT0lOQ+KAnSB3YXNu4oCZdCBwdWxsaW5nIHRoZQ0KPj5sYXRlc3QN
Cj4+Pj4+IHJldmlzaW9uIGV2ZW4gYWZ0ZXIgYSBjbGVhbmFsbC4gQWZ0ZXIgYSBsb3Qgb2YgZGln
Z2luZywgSQ0KPmRpc2NvdmVyZWQNCj4+Pj50aGF0DQo+Pj4+PiBmZXRjaGVyX2luaXQoKSB3YXMg
Y2xlYXJpbmcgdGhlIHNyY3JldiBjYWNoZSBpbiDigJx0bXAtDQo+YW5nc3Ryb21fMjAxMF94DQo+
PuKAnA0KPj4+Pj4gcmF0aGVyIHRoYW4g4oCcdG1wLWFuZ3N0cm9tXzIwMTBfeC11Y2xpYmPigJ0u
IEl0IGFwcGVhcnMgdGhhdCB0aGUNCj4+Pj5mb2xsb3dpbmcgbGluZQ0KPj4+Pj4gaW4gcGVyc2lz
dF9kYXRhLnB5IGlzIHRoZSBjdWxwcml0Og0KPj4+Pj4NCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gwqDC
oMKgIGNhY2hlZGlyID0gKGJiLmRhdGEuZ2V0VmFyKCJQRVJTSVNURU5UX0RJUiIsIGQsIFRydWUp
IG9yDQo+Pj4+Pg0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJiLmRhdGEu
Z2V0VmFyKCJDQUNIRSIsIGQsIFRydWUpKQ0KPj4+Pj4NCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gUEVS
U0lTVEVOVF9ESVIgZG9lc27igJl0IGV2YWx1YXRlIHRvIHRoZSBjb3JyZWN0IHZhbHVlLiBDaGFu
Z2luZyBpdA0KPnRvDQo+Pj4+anVzdA0KPj4+Pj4gcHVsbCBmcm9tIENBQ0hFIHNlZW1zIHRvIGZp
eCBpdCwgYnV0IEnigJltIG5vdCBzdXJlIGhvdyBpbXBvcnRhbnQNCj4+Pj4+IFBFUlNJU1RFTlRf
RElSIGlzIG9yIGV2ZW4gd2hhdCBpdCBkb2VzLg0KPj4+Pg0KPj4+PldoYXQgZG8geW91IG1lYW4g
YnkgInRoZSBjb3JyZWN0IHZhbHVlIiBoZXJlPyBQRVJTSVNURU5UX0RJUiBpcw0KPj4+PmV4YWN0
bHkgd2hhdCBpdCBzb3VuZHMgbGlrZSwgdGhlIGxvY2F0aW9uIHdoZXJlIHBlcnNpc3RfZGF0YSBz
dG9yZXMNCj4+Pj5pdHMgZGF0YWJhc2UocyksIHRoYXQncyBpdC4NCj4+Pj4tLQ0KPj4+PkNocmlz
dG9waGVyIExhcnNvbg0KPj4+PmNsYXJzb24gYXQga2VyZ290aCBkb3QgY29tDQo+Pj4+Rm91bmRl
ciAtIEJpdEJha2UsIE9wZW5FbWJlZGRlZCwgT3BlblphdXJ1cw0KPj4+Pk1haW50YWluZXIgLSBU
c2xpYg0KPj4+PlNlbmlvciBTb2Z0d2FyZSBFbmdpbmVlciwgTWVudG9yIEdyYXBoaWNzDQo+Pj4N
Cj4+PiBXZWxsLCBJIG1heSBqdXN0IGJlIGNvbmZ1c2VkIGFzIHRvIHdoYXQgdGhlIGNvcnJlY3Qg
dmFsdWUgb2YNCj4+UEVSU0lTVEVOVF9ESVIgc2hvdWxkIGJlLCBidXQgSSB3b3VsZCBleHBlY3Qg
aXQgdG8gYmUgdGhlIHNhbWUgdmFsdWUgYXMNCj4+Q0FDSEUgInRtcC1hbmdzdHJvbV8yMDEwX3gt
dWNsaWJjIiBhbmQgbm90ICJ0bXAtYW5nc3Ryb21fMjAxMF94Ii4gSWYgSQ0KPj5kbyBhICJiaXRi
YWtlIC1lIGxpbnV4LWxpYmMtaGVhZGVycyB8IGdyZXAgUEVSU0lTVEVOVF9ESVIiIEkgZ2V0IHRo
ZQ0KPj52YWx1ZSBJIGV4cGVjdCwgc28gbWF5YmUgUEVSU0lTVEVOVF9ESVIgaXMgY2hhbmdpbmcg
YWZ0ZXINCj5mZXRjaGVyX2luaXQoKQ0KPj4od2hlcmUgdGhlIGNhY2hlIGlzIGNsZWFyZWQpIGJ1
dCBiZWZvcmUgdGhlIGZpcnN0IGRvX2ZldGNoKCkgdGFzaw0KPih3aGVyZQ0KPj50aGUgY2FjaGUg
aXMgY2hlY2tlZCBmb3IgdGhlIFNSQ1JFVikuDQo+Pg0KPj5BcyBraGVtIHBvaW50ZWQgb3V0LCB0
aGlzIGlzIGR1ZSB0byB0aGUgdXNlIG9mIF9hcHBlbmQgd2l0aCBUTVBESVIuDQo+PkVhcmx5IHVz
ZXMgb2YgdGhlIHZhcmlhYmxlIGJ5IGJpdGJha2UgZG8gbm90IGhhdmUgdGhlIGFwcGVuZGVkIGJp
dHMNCj4+YXBwbGllZCwgbGF0ZXIgdXNlcyBkby4NCj4+LS0NCj4+Q2hyaXN0b3BoZXIgTGFyc29u
DQo+PmNsYXJzb24gYXQga2VyZ290aCBkb3QgY29tDQo+PkZvdW5kZXIgLSBCaXRCYWtlLCBPcGVu
RW1iZWRkZWQsIE9wZW5aYXVydXMNCj4+TWFpbnRhaW5lciAtIFRzbGliDQo+PlNlbmlvciBTb2Z0
d2FyZSBFbmdpbmVlciwgTWVudG9yIEdyYXBoaWNzDQo+DQo+QWgsIHRoYXQgbWFrZXMgc2Vuc2Uu
IEkga25vdyB0aGF0IHRoZSBsYXRlIGJpbmRpbmcgb2YgdmFyaWFibGUgdmFsdWVzIGluDQo+Yml0
YmFrZSBoYXMgYml0dGVuIG1lIGJlZm9yZS4gU3RpbGwgdGhvdWdoLCB0aGlzIGJlaGF2aW9yIGlz
IGJyZWFraW5nDQo+QkJfU1JDUkVWX1BPTElDWSA9ICJjbGVhciIgYmVjYXVzZSB0aGUgd3Jvbmcg
U1JDUkVWIGNhY2hlIGVuZHMgdXANCj5nZXR0aW5nIGNsZWFyZWQuIFRoaXMgbWFuaWZlc3RzIGFz
IFNSQ1JFViA9ICJBVVRPSU5DIiBub3QgZ2V0dGluZyB0aGUNCj5sYXRlc3QgcmV2aXNpb24gaWYg
YSByZXZpc2lvbiBudW1iZXIgd2FzIHByZXZpb3VzbHkgY2FjaGVkLCBhbmQgSSdtIG5vdA0KPnN1
cmUgaG93IGJlc3QgdG8gZml4IGl0Lg0KDQpBbHJpZ2h0LCBJJ3ZlIGZpbmFsbHkgZmlndXJlZCBv
dXQgYSBmaXguIEkgY2hhbmdlZCBkZWZhdWx0c2V0dXAuY29uZiBpbiBvZS1jb3JlIGZyb20gVE1Q
RElSX2FwcGVuZCA9ICIke1RDTElCQ0FQUEVORH0iIHRvIFRNUERJUiA6PSAiJHtUTVBESVJ9JHtU
Q0xJQkNBUFBFTkR9Ig0KDQpJJ2xsIHN1Ym1pdCB0aGUgcGF0Y2ggdG8gb2UtY29yZS4gVGhhbmtz
IGZvciBldmVyeW9uZSdzIGhlbHAgaW4gdHJhY2tpbmcgdGhpcyBkb3duIGFuZCBmaXhpbmcgaXQu
IEkgcmVhbGx5IGFwcHJlY2lhdGUgaXQhDQo=


