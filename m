Received: from mx4.leapfrog.com ([63.114.26.254])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dlazzari@leapfrog.com>) id 1QogFl-0005dh-0c
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Aug 2011 20:33:17 +0200
Received: from mx4.leapfrog.com (localhost [127.0.0.1])
	by localhost.leapfrog.com (Postfix) with ESMTP
	id E247F5EA6; Wed,  3 Aug 2011 11:28:49 -0700 (PDT)
Received: from NAEXCHHT01.na.leapfrog.com (unknown [10.15.6.13])
	by mx4.leapfrog.com (Postfix) with ESMTP
	id CED5A5EA2; Wed,  3 Aug 2011 11:28:49 -0700 (PDT)
Received: from naexchht.na.leapfrog.com (10.17.2.11) by
	NAEXCHHT01.na.leapfrog.com (10.15.6.13) with Microsoft SMTP Server
	(TLS) id 8.2.254.0; Wed, 3 Aug 2011 11:28:49 -0700
Received: from naemmail08.na.leapfrog.com ([10.11.5.92]) by
	naexchht.na.leapfrog.com ([10.17.2.11]) with mapi;
	Wed, 3 Aug 2011 11:28:49 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: 'Chris Larson' <clarson@kergoth.com>
Date: Wed, 3 Aug 2011 11:28:49 -0700
Thread-Topic: [bitbake-devel] Bug with clearing SRCREV cache
Thread-Index: AcxSCl6KE4eY50a4Qj2HggywlwIepAAAEQSA
Message-ID: <359B10B9B28B294BAA6405D9320312E0111E934063@naemmail08.na.leapfrog.com>
References: <359B10B9B28B294BAA6405D9320312E0111E93405D@naemmail08.na.leapfrog.com>
	<CABcZANmNObv54E4yW52t1wYt6pyranwAS5Hth8S1cF61ZM5N=g@mail.gmail.com>
	<359B10B9B28B294BAA6405D9320312E0111E934062@naemmail08.na.leapfrog.com>
	<CABcZAN=g64xzJXijTwoJN-a6LQODb1itMBcDgtwnZR7kjwdRsg@mail.gmail.com>
In-Reply-To: <CABcZAN=g64xzJXijTwoJN-a6LQODb1itMBcDgtwnZR7kjwdRsg@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
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
X-List-Received-Date: Wed, 03 Aug 2011 18:33:17 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbToga2VyZ290aEBnbWFpbC5jb20gW21h
aWx0bzprZXJnb3RoQGdtYWlsLmNvbV0gT24gQmVoYWxmIE9mIENocmlzDQo+TGFyc29uDQo+U2Vu
dDogV2VkbmVzZGF5LCBBdWd1c3QgMDMsIDIwMTEgMTE6MjMgQU0NCj5UbzogRGFuaWVsIExhenph
cmkNCj5DYzogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+U3ViamVjdDog
UmU6IFtiaXRiYWtlLWRldmVsXSBCdWcgd2l0aCBjbGVhcmluZyBTUkNSRVYgY2FjaGUNCj4NCj5P
biBXZWQsIEF1ZyAzLCAyMDExIGF0IDExOjIxIEFNLCBEYW5pZWwgTGF6emFyaSA8ZGxhenphcmlA
bGVhcGZyb2cuY29tPg0KPndyb3RlOg0KPj4+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+
PkZyb206IGtlcmdvdGhAZ21haWwuY29tIFttYWlsdG86a2VyZ290aEBnbWFpbC5jb21dIE9uIEJl
aGFsZiBPZiBDaHJpcw0KPj4+TGFyc29uDQo+Pj5TZW50OiBUdWVzZGF5LCBBdWd1c3QgMDIsIDIw
MTEgNjoyNCBQTQ0KPj4+VG86IERhbmllbCBMYXp6YXJpDQo+Pj5DYzogYml0YmFrZS1kZXZlbEBs
aXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+Pj5TdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIEJ1
ZyB3aXRoIGNsZWFyaW5nIFNSQ1JFViBjYWNoZQ0KPj4+DQo+Pj5PbiBUdWUsIEF1ZyAyLCAyMDEx
IGF0IDEyOjA2IFBNLCBEYW5pZWwgTGF6emFyaQ0KPjxkbGF6emFyaUBsZWFwZnJvZy5jb20+DQo+
Pj53cm90ZToNCj4+Pj4gSeKAmW0gbm90IGV4YWN0bHkgc3VyZSBpZiB0aGlzIGlzIGFuIG9lLWNv
cmUgb3IgYSBiaXRiYWtlIGJ1Zywgc28gSeKAmW0NCj4+PnRyeWluZw0KPj4+PiBoZXJlIGZpcnN0
LiBJIG5vdGljZWQgdGhlIG90aGVyIGRheSB0aGF0IG9uZSBvZiBvdXIgcmVjaXBlcyB0aGF0DQo+
cHVsbHMNCj4+Pj4gc291cmNlIGZyb20gc3ZuIGFuZCB1c2VzIFNSQ1JFViA9IOKAnEFVVE9JTkPi
gJ0gd2FzbuKAmXQgcHVsbGluZyB0aGUNCj5sYXRlc3QNCj4+Pj4gcmV2aXNpb24gZXZlbiBhZnRl
ciBhIGNsZWFuYWxsLiBBZnRlciBhIGxvdCBvZiBkaWdnaW5nLCBJIGRpc2NvdmVyZWQNCj4+PnRo
YXQNCj4+Pj4gZmV0Y2hlcl9pbml0KCkgd2FzIGNsZWFyaW5nIHRoZSBzcmNyZXYgY2FjaGUgaW4g
4oCcdG1wLWFuZ3N0cm9tXzIwMTBfeA0KPuKAnA0KPj4+PiByYXRoZXIgdGhhbiDigJx0bXAtYW5n
c3Ryb21fMjAxMF94LXVjbGliY+KAnS4gSXQgYXBwZWFycyB0aGF0IHRoZQ0KPj4+Zm9sbG93aW5n
IGxpbmUNCj4+Pj4gaW4gcGVyc2lzdF9kYXRhLnB5IGlzIHRoZSBjdWxwcml0Og0KPj4+Pg0KPj4+
Pg0KPj4+Pg0KPj4+PiDCoMKgwqAgY2FjaGVkaXIgPSAoYmIuZGF0YS5nZXRWYXIoIlBFUlNJU1RF
TlRfRElSIiwgZCwgVHJ1ZSkgb3INCj4+Pj4NCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJiLmRhdGEuZ2V0VmFyKCJDQUNIRSIsIGQsIFRydWUpKQ0KPj4+Pg0KPj4+Pg0KPj4+
Pg0KPj4+PiBQRVJTSVNURU5UX0RJUiBkb2VzbuKAmXQgZXZhbHVhdGUgdG8gdGhlIGNvcnJlY3Qg
dmFsdWUuIENoYW5naW5nIGl0IHRvDQo+Pj5qdXN0DQo+Pj4+IHB1bGwgZnJvbSBDQUNIRSBzZWVt
cyB0byBmaXggaXQsIGJ1dCBJ4oCZbSBub3Qgc3VyZSBob3cgaW1wb3J0YW50DQo+Pj4+IFBFUlNJ
U1RFTlRfRElSIGlzIG9yIGV2ZW4gd2hhdCBpdCBkb2VzLg0KPj4+DQo+Pj5XaGF0IGRvIHlvdSBt
ZWFuIGJ5ICJ0aGUgY29ycmVjdCB2YWx1ZSIgaGVyZT8gUEVSU0lTVEVOVF9ESVIgaXMNCj4+PmV4
YWN0bHkgd2hhdCBpdCBzb3VuZHMgbGlrZSwgdGhlIGxvY2F0aW9uIHdoZXJlIHBlcnNpc3RfZGF0
YSBzdG9yZXMNCj4+Pml0cyBkYXRhYmFzZShzKSwgdGhhdCdzIGl0Lg0KPj4+LS0NCj4+PkNocmlz
dG9waGVyIExhcnNvbg0KPj4+Y2xhcnNvbiBhdCBrZXJnb3RoIGRvdCBjb20NCj4+PkZvdW5kZXIg
LSBCaXRCYWtlLCBPcGVuRW1iZWRkZWQsIE9wZW5aYXVydXMNCj4+Pk1haW50YWluZXIgLSBUc2xp
Yg0KPj4+U2VuaW9yIFNvZnR3YXJlIEVuZ2luZWVyLCBNZW50b3IgR3JhcGhpY3MNCj4+DQo+PiBX
ZWxsLCBJIG1heSBqdXN0IGJlIGNvbmZ1c2VkIGFzIHRvIHdoYXQgdGhlIGNvcnJlY3QgdmFsdWUg
b2YNCj5QRVJTSVNURU5UX0RJUiBzaG91bGQgYmUsIGJ1dCBJIHdvdWxkIGV4cGVjdCBpdCB0byBi
ZSB0aGUgc2FtZSB2YWx1ZSBhcw0KPkNBQ0hFICJ0bXAtYW5nc3Ryb21fMjAxMF94LXVjbGliYyIg
YW5kIG5vdCAidG1wLWFuZ3N0cm9tXzIwMTBfeCIuIElmIEkNCj5kbyBhICJiaXRiYWtlIC1lIGxp
bnV4LWxpYmMtaGVhZGVycyB8IGdyZXAgUEVSU0lTVEVOVF9ESVIiIEkgZ2V0IHRoZQ0KPnZhbHVl
IEkgZXhwZWN0LCBzbyBtYXliZSBQRVJTSVNURU5UX0RJUiBpcyBjaGFuZ2luZyBhZnRlciBmZXRj
aGVyX2luaXQoKQ0KPih3aGVyZSB0aGUgY2FjaGUgaXMgY2xlYXJlZCkgYnV0IGJlZm9yZSB0aGUg
Zmlyc3QgZG9fZmV0Y2goKSB0YXNrICh3aGVyZQ0KPnRoZSBjYWNoZSBpcyBjaGVja2VkIGZvciB0
aGUgU1JDUkVWKS4NCj4NCj5BcyBraGVtIHBvaW50ZWQgb3V0LCB0aGlzIGlzIGR1ZSB0byB0aGUg
dXNlIG9mIF9hcHBlbmQgd2l0aCBUTVBESVIuDQo+RWFybHkgdXNlcyBvZiB0aGUgdmFyaWFibGUg
YnkgYml0YmFrZSBkbyBub3QgaGF2ZSB0aGUgYXBwZW5kZWQgYml0cw0KPmFwcGxpZWQsIGxhdGVy
IHVzZXMgZG8uDQo+LS0NCj5DaHJpc3RvcGhlciBMYXJzb24NCj5jbGFyc29uIGF0IGtlcmdvdGgg
ZG90IGNvbQ0KPkZvdW5kZXIgLSBCaXRCYWtlLCBPcGVuRW1iZWRkZWQsIE9wZW5aYXVydXMNCj5N
YWludGFpbmVyIC0gVHNsaWINCj5TZW5pb3IgU29mdHdhcmUgRW5naW5lZXIsIE1lbnRvciBHcmFw
aGljcw0KDQpBaCwgdGhhdCBtYWtlcyBzZW5zZS4gSSBrbm93IHRoYXQgdGhlIGxhdGUgYmluZGlu
ZyBvZiB2YXJpYWJsZSB2YWx1ZXMgaW4gYml0YmFrZSBoYXMgYml0dGVuIG1lIGJlZm9yZS4gU3Rp
bGwgdGhvdWdoLCB0aGlzIGJlaGF2aW9yIGlzIGJyZWFraW5nIEJCX1NSQ1JFVl9QT0xJQ1kgPSAi
Y2xlYXIiIGJlY2F1c2UgdGhlIHdyb25nIFNSQ1JFViBjYWNoZSBlbmRzIHVwIGdldHRpbmcgY2xl
YXJlZC4gVGhpcyBtYW5pZmVzdHMgYXMgU1JDUkVWID0gIkFVVE9JTkMiIG5vdCBnZXR0aW5nIHRo
ZSBsYXRlc3QgcmV2aXNpb24gaWYgYSByZXZpc2lvbiBudW1iZXIgd2FzIHByZXZpb3VzbHkgY2Fj
aGVkLCBhbmQgSSdtIG5vdCBzdXJlIGhvdyBiZXN0IHRvIGZpeCBpdC4NCg==


