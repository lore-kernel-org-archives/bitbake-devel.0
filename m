Received: from mx4.leapfrog.com ([63.114.26.254])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dlazzari@leapfrog.com>) id 1QogQ8-0005t8-6G
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Aug 2011 20:43:56 +0200
Received: from mx4.leapfrog.com (localhost [127.0.0.1])
	by localhost.leapfrog.com (Postfix) with ESMTP
	id 97C355EA3; Wed,  3 Aug 2011 11:21:28 -0700 (PDT)
Received: from naemhtcas02.na.leapfrog.com (unknown [10.12.1.52])
	by mx4.leapfrog.com (Postfix) with ESMTP
	id 849905EA2; Wed,  3 Aug 2011 11:21:28 -0700 (PDT)
Received: from naemmail08.na.leapfrog.com ([10.11.5.92]) by
	naemhtcas02.na.leapfrog.com ([10.12.1.52]) with mapi; Wed, 3 Aug 2011
	11:21:28 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: 'Chris Larson' <clarson@kergoth.com>
Date: Wed, 3 Aug 2011 11:21:27 -0700
Thread-Topic: [bitbake-devel] Bug with clearing SRCREV cache
Thread-Index: AcxRfCGnCIImGHhTRqCiIqTcPLhpxwAjOUlQ
Message-ID: <359B10B9B28B294BAA6405D9320312E0111E934062@naemmail08.na.leapfrog.com>
References: <359B10B9B28B294BAA6405D9320312E0111E93405D@naemmail08.na.leapfrog.com>
	<CABcZANmNObv54E4yW52t1wYt6pyranwAS5Hth8S1cF61ZM5N=g@mail.gmail.com>
In-Reply-To: <CABcZANmNObv54E4yW52t1wYt6pyranwAS5Hth8S1cF61ZM5N=g@mail.gmail.com>
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
X-List-Received-Date: Wed, 03 Aug 2011 18:43:56 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbToga2VyZ290aEBnbWFpbC5jb20gW21h
aWx0bzprZXJnb3RoQGdtYWlsLmNvbV0gT24gQmVoYWxmIE9mIENocmlzDQo+TGFyc29uDQo+U2Vu
dDogVHVlc2RheSwgQXVndXN0IDAyLCAyMDExIDY6MjQgUE0NCj5UbzogRGFuaWVsIExhenphcmkN
Cj5DYzogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+U3ViamVjdDogUmU6
IFtiaXRiYWtlLWRldmVsXSBCdWcgd2l0aCBjbGVhcmluZyBTUkNSRVYgY2FjaGUNCj4NCj5PbiBU
dWUsIEF1ZyAyLCAyMDExIGF0IDEyOjA2IFBNLCBEYW5pZWwgTGF6emFyaSA8ZGxhenphcmlAbGVh
cGZyb2cuY29tPg0KPndyb3RlOg0KPj4gSeKAmW0gbm90IGV4YWN0bHkgc3VyZSBpZiB0aGlzIGlz
IGFuIG9lLWNvcmUgb3IgYSBiaXRiYWtlIGJ1Zywgc28gSeKAmW0NCj50cnlpbmcNCj4+IGhlcmUg
Zmlyc3QuIEkgbm90aWNlZCB0aGUgb3RoZXIgZGF5IHRoYXQgb25lIG9mIG91ciByZWNpcGVzIHRo
YXQgcHVsbHMNCj4+IHNvdXJjZSBmcm9tIHN2biBhbmQgdXNlcyBTUkNSRVYgPSDigJxBVVRPSU5D
4oCdIHdhc27igJl0IHB1bGxpbmcgdGhlIGxhdGVzdA0KPj4gcmV2aXNpb24gZXZlbiBhZnRlciBh
IGNsZWFuYWxsLiBBZnRlciBhIGxvdCBvZiBkaWdnaW5nLCBJIGRpc2NvdmVyZWQNCj50aGF0DQo+
PiBmZXRjaGVyX2luaXQoKSB3YXMgY2xlYXJpbmcgdGhlIHNyY3JldiBjYWNoZSBpbiDigJx0bXAt
YW5nc3Ryb21fMjAxMF94IOKAnA0KPj4gcmF0aGVyIHRoYW4g4oCcdG1wLWFuZ3N0cm9tXzIwMTBf
eC11Y2xpYmPigJ0uIEl0IGFwcGVhcnMgdGhhdCB0aGUNCj5mb2xsb3dpbmcgbGluZQ0KPj4gaW4g
cGVyc2lzdF9kYXRhLnB5IGlzIHRoZSBjdWxwcml0Og0KPj4NCj4+DQo+Pg0KPj4gwqDCoMKgIGNh
Y2hlZGlyID0gKGJiLmRhdGEuZ2V0VmFyKCJQRVJTSVNURU5UX0RJUiIsIGQsIFRydWUpIG9yDQo+
Pg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJiLmRhdGEuZ2V0VmFyKCJDQUNI
RSIsIGQsIFRydWUpKQ0KPj4NCj4+DQo+Pg0KPj4gUEVSU0lTVEVOVF9ESVIgZG9lc27igJl0IGV2
YWx1YXRlIHRvIHRoZSBjb3JyZWN0IHZhbHVlLiBDaGFuZ2luZyBpdCB0bw0KPmp1c3QNCj4+IHB1
bGwgZnJvbSBDQUNIRSBzZWVtcyB0byBmaXggaXQsIGJ1dCBJ4oCZbSBub3Qgc3VyZSBob3cgaW1w
b3J0YW50DQo+PiBQRVJTSVNURU5UX0RJUiBpcyBvciBldmVuIHdoYXQgaXQgZG9lcy4NCj4NCj5X
aGF0IGRvIHlvdSBtZWFuIGJ5ICJ0aGUgY29ycmVjdCB2YWx1ZSIgaGVyZT8gUEVSU0lTVEVOVF9E
SVIgaXMNCj5leGFjdGx5IHdoYXQgaXQgc291bmRzIGxpa2UsIHRoZSBsb2NhdGlvbiB3aGVyZSBw
ZXJzaXN0X2RhdGEgc3RvcmVzDQo+aXRzIGRhdGFiYXNlKHMpLCB0aGF0J3MgaXQuDQo+LS0NCj5D
aHJpc3RvcGhlciBMYXJzb24NCj5jbGFyc29uIGF0IGtlcmdvdGggZG90IGNvbQ0KPkZvdW5kZXIg
LSBCaXRCYWtlLCBPcGVuRW1iZWRkZWQsIE9wZW5aYXVydXMNCj5NYWludGFpbmVyIC0gVHNsaWIN
Cj5TZW5pb3IgU29mdHdhcmUgRW5naW5lZXIsIE1lbnRvciBHcmFwaGljcw0KDQpXZWxsLCBJIG1h
eSBqdXN0IGJlIGNvbmZ1c2VkIGFzIHRvIHdoYXQgdGhlIGNvcnJlY3QgdmFsdWUgb2YgUEVSU0lT
VEVOVF9ESVIgc2hvdWxkIGJlLCBidXQgSSB3b3VsZCBleHBlY3QgaXQgdG8gYmUgdGhlIHNhbWUg
dmFsdWUgYXMgQ0FDSEUgInRtcC1hbmdzdHJvbV8yMDEwX3gtdWNsaWJjIiBhbmQgbm90ICJ0bXAt
YW5nc3Ryb21fMjAxMF94Ii4gSWYgSSBkbyBhICJiaXRiYWtlIC1lIGxpbnV4LWxpYmMtaGVhZGVy
cyB8IGdyZXAgUEVSU0lTVEVOVF9ESVIiIEkgZ2V0IHRoZSB2YWx1ZSBJIGV4cGVjdCwgc28gbWF5
YmUgUEVSU0lTVEVOVF9ESVIgaXMgY2hhbmdpbmcgYWZ0ZXIgZmV0Y2hlcl9pbml0KCkgKHdoZXJl
IHRoZSBjYWNoZSBpcyBjbGVhcmVkKSBidXQgYmVmb3JlIHRoZSBmaXJzdCBkb19mZXRjaCgpIHRh
c2sgKHdoZXJlIHRoZSBjYWNoZSBpcyBjaGVja2VkIGZvciB0aGUgU1JDUkVWKS4NCg==


