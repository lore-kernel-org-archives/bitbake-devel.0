Return-Path: <prvs=6310d3f3e4=michael.davis@essvote.com>
Received: from m2.essvote.com (m2.essvote.com [66.37.226.14])
	by mail.openembedded.org (Postfix) with ESMTP id 709566FF78
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 May 2017 13:48:52 +0000 (UTC)
X-AuditID: 0a00029b-a9d6e9a000003f55-b1-591c54c5dcba
Received: from ESS-EX01.essvote.corp.local (Unknown_Domain [172.16.110.40])
	by m2.essvote.com (Symantec Messaging Gateway) with SMTP id
	FA.9F.16213.5C45C195; Wed, 17 May 2017 08:48:53 -0500 (CDT)
Received: from ESS-EX01.essvote.corp.local ([::1]) by
	ESS-EX01.essvote.corp.local ([::1]) with mapi id 14.03.0301.000;
	Wed, 17 May 2017 08:48:51 -0500
From: "Davis, Michael" <michael.davis@essvote.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] lib/bb/fetch2: Fix npm tarball fetch
Thread-Index: AQHSzY8pyBNEjmAWFEmvs8X/rUTRaqH4jSjA
Date: Wed, 17 May 2017 13:48:50 +0000
Message-ID: <655290B7709079438B7932553958E60DA1305561@ESS-EX01.essvote.corp.local>
References: <20170512205203.20459-1-michael.davis@essvote.com>
	<1494861784.27342.18.camel@linuxfoundation.org>
In-Reply-To: <1494861784.27342.18.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.20.77]
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWyRiBPQ/doiEykQf8EY4vrR0MtfjybyOrA
	5LF/7hp2j3MbVzAGMEVx2yQllpQFZ6bn6dslcGccnfCSueCZcMWSK60sDYxLhLsYOTkkBEwk
	fm09w9jFyMUhJHCUUWLHw8esEM4sRomGScdZQKrYBIwkzl3fBFYlItDBKHH2+W12kISwgKfE
	6Un9bCC2iICXxPa3J1khbCOJi+uawOIsAqoSq77+AYvzCgRJvL16GSwuJFAgcWX9ArAFnAI2
	Eof/HQCzGQXEJL6fWsMEYjMLiEvcejKfCeJUAYkle84zQ9iiEi8f/2OFsOUk3jW1AdkcQPWa
	Eut36UO0KkpM6X7IDrFWUOLkzCcsExhFZiGZOguhYxaSjllIOhYwsqxi5Ms10kstLi7LL0nV
	S87P3cQIjAAuBqbZOxj3THA4xCjAwajEw3tBTCpSiDWxrLgy9xCjNAeLkjjvs5XMkUIC6Ykl
	qdmpqQWpRfFFpTmpxYcYmTg4DzFKcHBJiRSn5qWkFiWWlmTEg6IqvhgYV1INjJHrav4cy5Fm
	MN20jPn3S/ktN+cm3fPYvuHsX8GEi12nDrGnTe7nm3BhzZLV3FP4txxb9KF73lXG32InD6c+
	0/t8zoTF7kDU2QuMM9bMj12WGxo/m2Hn6gaF5gUPHc2t9jab6B1ZYN3d36+btUZqifWC/xKn
	/64svp69PuFWvPo+uxgpz76IJaeUWIozEg21mIuKEwFL+OgSfAIAAA==
Subject: Re: [PATCH] lib/bb/fetch2: Fix npm tarball fetch
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 17 May 2017 13:48:53 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RG8geW91IGhhdmUgYW55IHJlY29tbWVuZGF0aW9ucyBvciB0aXBzIHRvIGJldHRlciBpbXBsZW1l
bnQgdGhpcz8NCkkgd291bGQgcmVhbGx5IGxpa2UgdG8gZ2V0IG9mZmxpbmUgbnBtIGRvd25sb2Fk
cyB3b3JraW5nIHByb3Blcmx5Lg0KDQpUaGFua3MsDQpNaWtlDQoNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IFJpY2hhcmQgUHVyZGllIFttYWlsdG86cmljaGFyZC5wdXJkaWVA
bGludXhmb3VuZGF0aW9uLm9yZ10gDQpTZW50OiBNb25kYXksIE1heSAxNSwgMjAxNyAxMDoyMyBB
TQ0KVG86IERhdmlzLCBNaWNoYWVsOyBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5v
cmcNClN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gW1BBVENIXSBsaWIvYmIvZmV0Y2gyOiBG
aXggbnBtIHRhcmJhbGwgZmV0Y2gNCg0KT24gRnJpLCAyMDE3LTA1LTEyIGF0IDIwOjUyICswMDAw
LCBEYXZpcywgTWljaGFlbCB3cm90ZToNCj4gVGFyYmFsbHMgZ2VuZXJhdGVkIGJ5IGVuYWJsaW5n
IG1pcnJvciB0YXJiYWxscyBjb3VsZCBub3QgYmUgZm91bmQgYnkNCj4gdGhlDQo+IGZldGNoIGZv
ciB0aGUgbnBtLsKgwqBUaGlzIGZpeGVzIHNldHRpbmcgdGhlIHBhdGggdmFyaWFibGUgaW4gZGVj
b2RlDQo+IHVybA0KPiBzbyB0aGV5IGNhbiBiZSBtYXRjaGVkLg0KDQpXb3VsZCB5b3UgYmUgYWJs
ZSB0byBwcm92aWRlIGFuIGV4YW1wbGUgb2YgYSB1cmwgd2hpY2ggaXMgaW5jb3JyZWN0IGFuZA0K
d2hhdCB0aGUgY29ycmVjdCB2ZXJzaW9uIHdvdWxkIGJlPw0KDQpJIGdldCB3b3JyaWVkIGFib3V0
IGZldGNoZXIgc3BlY2lmaWMgdXJsIGhhbmRsaW5nIGFuZCB3ZSBwcm9iYWJseSBjb3VsZA0KZG8g
d2l0aCBhZGRpbmcgYSB0ZXN0IGNhc2UgZm9yIHRoaXMgdG9vIGJ1dCBpdHMgaGFyZCB0byB1bmRl
cnN0YW5kDQp3aXRob3V0IHNlZWluZyBhbiBleGFtcGxlIGZhaWx1cmUuDQoNCkNoZWVycywNCg0K
UmljaGFyZA0KDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgRGF2aXMgPG1pY2hhZWwuZGF2aXNA
ZXNzdm90ZS5jb20+DQo+IC0tLQ0KPiDCoGxpYi9iYi9mZXRjaDIvX19pbml0X18ucHkgfCAyICsr
DQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkgYi9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5DQo+
IGluZGV4IDEzNmZjMjkuLjExN2M4OTAgMTAwNjQ0DQo+IC0tLSBhL2xpYi9iYi9mZXRjaDIvX19p
bml0X18ucHkNCj4gKysrIGIvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQ0KPiBAQCAtMzkzLDYg
KzM5Myw4IEBAIGRlZiBkZWNvZGV1cmwodXJsKToNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmFpc2UgTWFsZm9ybWVkVXJsKHVybCwgIlRoZSBVUkw6ICclcycg
aXMNCj4gaW52YWxpZDogcGFyYW1ldGVyICVzIGRvZXMgbm90IHNwZWNpZnkgYSB2YWx1ZSAobWlz
c2luZyAnPScpIiAlICh1cmwsDQo+IHMpKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgczEsIHMyID0gcy5zcGxpdCgnPScpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBwW3MxXSA9IHMyDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
IHR5cGUgPT0gJ25wbScgYW5kIHMxID09ICduYW1lJzoNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBwYXRoID0gJy8nICsgczINCj4gwqANCj4gwqDCoMKgwqDCoHJl
dHVybiB0eXBlLCBob3N0LCB1cmxsaWIucGFyc2UudW5xdW90ZShwYXRoKSwgdXNlciwgcHN3ZCwg
cA0KPiDCoA0KPiAtLcKgDQo+IDIuOS4zDQo=

