Return-Path: <tim.jaacks@garz-fricke.com>
Received: from mailout.artfiles.de (mailout.artfiles.de [80.252.97.80])
	by mail.openembedded.org (Postfix) with ESMTP id 15E22759D5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 09:22:00 +0000 (UTC)
Received: from [89.27.136.47] (helo=mail.garz-fricke.com)
	auth=mx@garz-fricke.com
	by mailout.artfiles.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80.1) id 1Zgr6l-0002y9-5W
	for bitbake-devel@lists.openembedded.org;
	Tue, 29 Sep 2015 11:21:59 +0200
Received: from SRV24.hamburg.garz-fricke.de ([fe80::b591:975a:1787:bdd7]) by
	SRV24.hamburg.garz-fricke.de ([fe80::b591:975a:1787:bdd7%12]) with mapi
	id 14.03.0248.002; Tue, 29 Sep 2015 11:21:58 +0200
From: Tim Jaacks <tim.jaacks@garz-fricke.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Override a "_remove" operator in bbappend file
Thread-Index: AdD6l+IBU+RwKSc7TBKXuPLlESwRjA==
Date: Tue, 29 Sep 2015 09:21:56 +0000
Message-ID: <32EA6B79577EEF4C84CB32305D45A059289F5066@SRV24.hamburg.garz-fricke.de>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.20.3.9]
MIME-Version: 1.0
Subject: Re: Override a "_remove" operator in bbappend file
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
X-List-Received-Date: Tue, 29 Sep 2015 09:22:01 -0000
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgQ2hyaXN0b3BoZXIsDQoNCj4gUmVtZW1iZXIgdGhhdCBfcmVtb3ZlIGlzIHVzYWJsZSBpbiBn
bG9iYWwgY29uZmlndXJhdGlvbiBjb250ZXh0IGFzIHdlbGwuIFdlDQo+IG5lZWQgdGhlIHVzZXIg
dG8gYmUgYWJsZSB0byByZW1vdmUgc29tZXRoaW5nIGZyb20gbG9jYWwuY29uZiB3aGljaCBhZGRl
ZCBpbg0KPiBhIHJlY2lwZSwgYnV0IGlmIHdlIGJsaW5kbHkgZm9sbG93IHRoZSBvcmRlciBvZiBh
cHBlbmQvcHJlcGVuZC9yZW1vdmUNCj4gb3BlcmF0aW9ucywgaXQgd291bGRuJ3Qgd29yayBhcyBl
eHBlY3RlZCwgYXMgdGhlIGNvbmZpZ3VyYXRpb24gbWV0YWRhdGEgaXMNCj4gcGFyc2VkIGxvbmcg
YmVmb3JlIHRoZSByZWNpcGVzLg0KDQpXaHkgd291bGQgdGhhdCBiZSBhIHByb2JsZW0/IE9mIGNv
dXJzZSB0aGUgZ2xvYmFsIGNvbmZpZ3VyYXRpb24gaW4gbG9jYWwuY29uZiBzaG91bGQgaGF2ZSBh
IGhpZ2hlciBwcmlvcml0eSB0aGFuIGFsbCB0aGUgbGF5ZXJzLiBXaGF0IEkgd291bGQgZXhwZWN0
IGlzIGEgY2hhaW4gb2YgX2FwcGVuZCBhbmQgX3JlbW92ZSBvcGVyYXRpb25zLCBvcmRlcmVkIGJ5
IGxheWVyIHByaW9yaXR5LCBhbmQgd2l0aCB0aGUgb3ZlcnJpZGVzIGluIGxvY2FsLmNvbmYgYmVp
bmcgYXBwbGllZCBhdCB0aGUgdmVyeSBlbmQuDQoNCg0KTWl0IGZyZXVuZGxpY2hlbiBHcsO8w59l
biAvIEJlc3QgcmVnYXJkcw0KaS5BLiBUaW0gSmFhY2tzDQoNClNvZnR3YXJlIEVuZ2luZWVyaW5n
DQpHYXJ6ICYgRnJpY2tlIEdtYkgNClRlbXBvd2Vya3JpbmcgMiwgMjEwNzkgSGFtYnVyZyAtIEdl
cm1hbnkNCkFtdHNnZXJpY2h0IEhhbWJ1cmcgSFJCIDYwNTE0DQpHZXNjaMOkZnRzZsO8aHJlcjog
TWFuZnJlZCBHYXJ6LCBNYXR0aGlhcyBGcmlja2UNClBob25lOiArNDkgNDAgNzkxODk5IC0gNTUN
CkZheDrCoMKgwqDCoCArNDkgNDAgNzkxODk5IOKAkyAzOQ0KdGltLmphYWNrc0BnYXJ6LWZyaWNr
ZS5jb20NCnd3dy5nYXJ6LWZyaWNrZS5jb20NCg0KDQo=

