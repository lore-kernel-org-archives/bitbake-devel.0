Return-Path: <joe.slater@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 3BF6079F4C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jan 2019 20:49:45 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x07Kn9hP011267
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 7 Jan 2019 12:49:20 -0800
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.138]) by
	ALA-HCB.corp.ad.wrs.com ([147.11.189.41]) with mapi id 14.03.0415.000;
	Mon, 7 Jan 2019 12:48:59 -0800
From: "Slater, Joseph" <joe.slater@windriver.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>, 
	"Hatle, Mark" <mark.hatle@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] /run/user/<id>/bb
Thread-Index: AdSjwAZNvzqBZKMyRUWDYcLm1JFf5ADHEBqAAAJ0iIAAAvD1AAAKm+ng
Date: Mon, 7 Jan 2019 20:48:59 +0000
Message-ID: <007BD92917A2324FA403BCF9A464CF84F37255A6@ALA-MBD.corp.ad.wrs.com>
References: <007BD92917A2324FA403BCF9A464CF84F3723F13@ALA-MBD.corp.ad.wrs.com>
	<49a16b88d162e9d3aa3db88deaed47147d914429.camel@linuxfoundation.org>
	<d718f0d7-3834-3b42-2fc2-3667ed4e899c@windriver.com>
	<d87ce682d2a0e2eda230e8b0e7799f2ec68f46db.camel@linuxfoundation.org>
In-Reply-To: <d87ce682d2a0e2eda230e8b0e7799f2ec68f46db.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.11.157.215]
MIME-Version: 1.0
Subject: Re: /run/user/<id>/bb
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
X-List-Received-Date: Mon, 07 Jan 2019 20:49:46 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

U3BlY2lmaWNhbGx5LCBsaWJhc3N1YW4sIHdoaWNoIGlzIHVzZWQgYnkgZ3BnLCBwdXRzIG5hbWVk
IHNvY2tldHMgdW5kZXIgR1BHX1BBVEggYW5kIHRoYXQgaXMgc2V0IGJ5IHNpZ25fcnBtX2V4dC5i
YmNsYXNzIHRvIGJlIHVuZGVyIFRNUERJUiwgYWx0aG91Z2ggd2UgY291bGQgb3ZlcnJpZGUgdGhh
dC4gIEkgdGhpbmsgdGhhdCBsaWJhc3N1YW4gY29tcHV0ZXMgdGhlIGFic29sdXRlIHBhdGhuYW1l
IHRvIGNyZWF0ZSB0aGUgc29ja2V0LiAgSSBhZG1pdCB0aGF0IEkgZGlkIG5vdCBsb29rIHZlcnkg
aGFyZCBhdCBsaWJhc3N1YW4sIGJ1dCBhIGZpeCBkaWQgbm90IHNlZW0gaW1tZWRpYXRlbHkgb2J2
aW91cy4NCg0KSGF2aW5nIGEgUlVORElSIG1pZ2h0IG5vdCBiZSBhIGdvb2QgaWRlYSwgdGhvdWdo
LCBiZWNhdXNlIGl0IG9wZW5zIHRoZSBpc3N1ZSBvZiBob3cgaXQgZ2V0cyBjbGVhbmVkIHVwIGlm
IHRoZSB1c2VyIG5ldmVyIGxvZ3Mgb3V0Lg0KDQpKb2UNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogcmljaGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZyBbbWFpbHRv
OnJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmddIA0KU2VudDogTW9uZGF5LCBKYW51
YXJ5IDA3LCAyMDE5IDk6MzEgQU0NClRvOiBIYXRsZSwgTWFyazsgU2xhdGVyLCBKb3NlcGg7IGJp
dGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KU3ViamVjdDogUmU6IFtiaXRiYWtl
LWRldmVsXSAvcnVuL3VzZXIvPGlkPi9iYg0KDQpPbiBNb24sIDIwMTktMDEtMDcgYXQgMTA6MDcg
LTA2MDAsIE1hcmsgSGF0bGUgd3JvdGU6DQo+IE9uIDEvNy8xOSA4OjU2IEFNLCBSaWNoYXJkIFB1
cmRpZSB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMTktMDEtMDMgYXQgMjM6NTcgKzAwMDAsIFNsYXRl
ciwgSm9zZXBoIHdyb3RlOg0KPiA+ID4gVE1QRElSIGlzIHVzZWZ1bCwgYnV0IG5hbWVkIHNvY2tl
dHMgbmVlZCBhICJzaG9ydCIgcGF0aG5hbWUsIHNvDQo+ID4gPiBpdCBpdA0KPiA+ID4gbWlnaHQg
YmUgbmljZSB0byBoYXZlIGEgUlVORElSLCBvciBzb21ldGhpbmcgc2ltaWxhciwgdW5kZXINCj4g
PiA+IC9ydW4vdXNlci88aWQ+L2JiLiAgQ291bGQgdGhpcyBiZSBhZGRlZD8gIEkgd291bGQgZG8g
aXQgaWYgdGhlDQo+ID4gPiBjb25jZXB0IGlzIGFjY2VwdGVkLg0KPiA+IA0KPiA+IFdoYXQgcHJv
YmxlbSBhcmUgd2Ugc29sdmluZyB3aXRoIHRoaXM/DQo+ID4gDQo+ID4gSSdtIGd1ZXNzaW5nIHBy
b2JsZW1zIHdpdGggbWVtb3J5IHJlc2lkZW50IGJpdGJha2UgaW4gZW52dmFycyBidXQgSQ0KPiA+
IGFtDQo+ID4gaGF2aW5nIHRvIGd1ZXNzISA6KQ0KPiANCj4gSSdtIGFzc3VtaW5nIGl0J3MgYSBj
b21iaW5hdGlvbiBvZiBtZW1vcnkgcmVzaWRlbnQgYml0YmFrZSwgYW5kIG92ZXJhbGwgcGF0aA0K
PiBsZW5ndGggaW4gVE1QRElSIHRvIHRoZSBzb2NrZXRzLiAgU29ja2V0cyBoYXZlIGEgbWF4aW11
bSBmaWxlc3lzdGVtIHBhdGggbGVuZ3RoDQo+ICgxMDcgY2hhcmFjdGVycyBpbiBMaW51eCkgdGhh
dCBpcyBtdWNoIHNob3J0ZWQgdGhlbiBvdGhlciBjb21wb25lbnRzIGluIHRoZQ0KPiBzeXN0ZW0g
KDRrIG9yIGxlc3MpLg0KPiANCj4gVGhlIHR5cGljYWwgd2F5IHBlb3BsZSB3b3JrIGFyb3VuZCB0
aGlzIGlzIHdoZW5ldmVyIHlvdSB1c2UgYSBzb2NrZXQNCj4geW91IGNkIHRvIHRoZSBwYXRoIG9m
IHRoZSBzb2NrZXQgYW5kIHRoZW4gb3BlbiBpdCByZWxhdGl2ZSB0byB0aGUNCj4gY3VycmVudCBs
b2NhdGlvbi4NCg0KVGhlIGNvZGUgaW4gYml0YmFrZSBhbHJlYWR5IGRvZXMgdGhhdCBhcyBpdCBo
YXBwZW5zLi4uDQoNCj4gaW4gZWl0aGVyIHRoZSBUTVBESVIgb3IgUlVORElSIHR5cGUgY29uZmln
dXJhdGlvbiwgdGhhdCAnY2QgOyBvcGVuJw0KPiB0eXBlIGJlaGF2aW9yIHdpbGwgc3RpbGwgbGlr
ZWx5IGJlIG5lZWRlZC4gIFNvIEknbSBub3Qgc3VyZSBpZiBSVU5ESVINCj4gYWN0dWFsbHkgZml4
ZXMgYW55dGhpbmcgd2hlbiBpdCBjb21lcyB0byBwYXRoIGxlbmd0aCBpc3N1ZXMuICBJdCBqdXN0
DQo+IG1vdmVzIHRoZSBzb2NrZXQgdG8gYSBrbm93biBsb2NhdGlvbiwgZnJvbSAnY3VycmVudCcg
cGF0aC4NCg0KSSdtIGhvcGluZyBKb2UgY2FuIGV4cGxhaW4gdGhlIHByb2JsZW0gcmF0aGVyIHRo
YW4gdXMgZ3Vlc3NpbmcsDQpwYXJ0aWN1bGFybHkgYXMgdGhlIGNvZGUgZm9yIHdoZXJlIEkgdGhv
dWdodCB0aGUgcHJvYmxlbSBtYXkgYmUgYWxyZWFkeQ0KZG9lcyBhIGNoZGlyKCkuDQoNCkNoZWVy
cywNCg0KUmljaGFyZA0KDQo=

