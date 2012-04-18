Received: from mx3.leapfrog.com ([63.114.26.253])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dlazzari@leapfrog.com>) id 1SKeti-0006qx-BJ
	for bitbake-devel@lists.openembedded.org;
	Thu, 19 Apr 2012 02:06:54 +0200
Received: from mx3.leapfrog.com (localhost [127.0.0.1])
	by localhost.leapfrog.com (Postfix) with ESMTP
	id 2FDE85EE4; Wed, 18 Apr 2012 16:57:11 -0700 (PDT)
Received: from NAEXCHHT01.na.leapfrog.com (unknown [10.15.6.13])
	by mx3.leapfrog.com (Postfix) with ESMTP
	id EEA685E83; Wed, 18 Apr 2012 16:57:10 -0700 (PDT)
Received: from NAEMCASHT01.na.leapfrog.com (10.16.4.161) by
	NAEXCHHT01.na.leapfrog.com (10.15.6.13) with Microsoft SMTP Server
	(TLS) id 8.2.254.0; Wed, 18 Apr 2012 16:57:25 -0700
Received: from NAEMMAIL01.na.leapfrog.com ([fe80::252e:28a6:3d8f:6991]) by
	NAEMCASHT01.na.leapfrog.com ([::1]) with mapi id 14.01.0355.002;
	Wed, 18 Apr 2012 16:57:25 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: 'Chris Larson' <kergoth@gmail.com>
Thread-Topic: [bitbake-devel] python function used in variable expansion
	called multiple times per recipe
Thread-Index: Ac0dqUJmIcsujxmfQlyaUhmEaDraqQASVj+AAA3ZuJD//5rzAIAAcVXg
Date: Wed, 18 Apr 2012 23:57:24 +0000
Message-ID: <E7A9054A5ACABE48B0E540E46E862B0F0427C619@NAEMMAIL01.na.leapfrog.com>
References: <E7A9054A5ACABE48B0E540E46E862B0F0427C336@NAEMMAIL01.na.leapfrog.com>
	<671D7BD596E04EE1961D6EA1C734C816@gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0F0427C5FA@NAEMMAIL01.na.leapfrog.com>
	<CABcZANn_xWLbxJRPK68Eu9iLjp6jjxkefPhe61UAcxzu91ZHwA@mail.gmail.com>
In-Reply-To: <CABcZANn_xWLbxJRPK68Eu9iLjp6jjxkefPhe61UAcxzu91ZHwA@mail.gmail.com>
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
X-List-Received-Date: Thu, 19 Apr 2012 00:06:54 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ2hyaXMgTGFyc29uIFttYWlsdG86
a2VyZ290aEBnbWFpbC5jb21dDQo+U2VudDogV2VkbmVzZGF5LCBBcHJpbCAxOCwgMjAxMiA0OjQy
IFBNDQo+VG86IERhbmllbCBMYXp6YXJpDQo+Q2M6ICdiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5l
bWJlZGRlZC5vcmcnIChiaXRiYWtlLQ0KPmRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcpDQo+
U3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBweXRob24gZnVuY3Rpb24gdXNlZCBpbiB2YXJp
YWJsZSBleHBhbnNpb24gY2FsbGVkDQo+bXVsdGlwbGUgdGltZXMgcGVyIHJlY2lwZQ0KPg0KPk9u
IFdlZCwgQXByIDE4LCAyMDEyIGF0IDQ6MzkgUE0sIERhbmllbCBMYXp6YXJpIDxkbGF6emFyaUBs
ZWFwZnJvZy5jb20+DQo+d3JvdGU6DQo+PiBJIHRoaW5rIGltbWVkaWF0ZSBleHBhbnNpb24gaXMg
d2hhdCBJ4oCZbGwgbmVlZCB0byB1c2UsIHRoYW5rcyBmb3IgdGhlIHRpcC4NCj4+IFRoYXQgYXQg
bGVhc3QgYnJpbmdzIHRoZSBpbnZvY2F0aW9uIGRvd24gdG8gb25jZSBwZXIgcnVuLiBVbmZvcnR1
bmF0ZWx5LCB0aGUNCj4+IHZhcmlhYmxlIGRvZXNu4oCZdCBzZWVtIHRvIGdldCBmaWxsZWQgaW4g
d2hlbiBJIGNoYW5nZSB0byBpbW1lZGlhdGUNCj5leHBhbnNpb24uDQo+Pg0KPj4gZGVmIHRlc3RG
dW5jKGJiLCBkKToNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcmludCggYmIu
ZGF0YS5nZXRWYXIoIlBOIiwgZCwgVHJ1ZSkgKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiAiZTEiDQo+Pg0KPj4gRVhURVJOUFYgOj0gIiR7QHRlc3RGdW5jKGJiLCBk
KX0iDQo+Pg0KPj4gTm93IG9ubHkgcHJpbnRzIHRoZSBwYWNrYWdlIG5hbWUgb25jZSwgYnV0IHVz
aW5nIOKAk2UsIEkgZG9u4oCZdCBzZWUgdGhlDQo+PiB2YXJpYWJsZSBFWFRFUk5QViBhdCBhbGwu
DQo+DQo+RG9uJ3Qga25vdyB3aGF0IHRvIHRlbGwgeW91LiBJdCBkb2VzIHdvcmssIHNvIGl0J3Mg
c29tZXRoaW5nIHdyb25nIG9uDQo+eW91ciBlbmQuIEVpdGhlciBpdCdzIHJldHVybmluZyBhbiBl
bXB0eSBzdHJpbmcsIHdoaWNoIHdpbGwgcmVzdWx0IGluDQo+LWUgb25seSBzaG93aW5nIHRoZSBj
b21tZW50ZWQgb3V0IGRlZmluaXRpb24sIG9yIGl0J3MgcmFpc2luZyBhbg0KPmV4Y2VwdGlvbiwg
b3Igc29tZXRoaW5nIGVsc2UgaW4geW91ciBzZXR1cC4gQXNpZGU6IHlvdSBkb24ndCBuZWVkIHRv
DQo+cGFzcyAnYmInIGluLiBUaGF0IG5hbWVzcGFjZSBpcyBhbHdheXMgYWNjZXNzaWJsZSwgZXZl
biBmcm9tIGRlZidkDQo+cHl0aG9uIGZ1bmN0aW9ucy4NCj4tLQ0KPkNocmlzdG9waGVyIExhcnNv
bg0KDQpBaCwgSSB3YXMgZG9pbmcgLWUgb24gdGhlIHdyb25nIHJlY2lwZS4uLiB0aW1lIHRvIGdl
dCBzb21lIG1vcmUgY2FmZmVpbmUuIFRoZSB0ZXN0IGNhc2UgaXMgbm93IHdvcmtpbmcuIE15IGNv
ZGUgaXMgbm90LCBidXQgSSBjYW4gZGVidWcgdGhhdCBwcmV0dHkgZWFzaWx5LiBUaGFua3MgZm9y
IGFsbCBvZiB5b3VyIGhlbHAhDQo=


