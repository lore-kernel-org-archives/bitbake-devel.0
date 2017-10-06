Return-Path: <AMardegan@luxoft.com>
Received: from ORO-EDGE-01.luxoft.com (oro-edge-01.luxoft.com [109.166.244.21])
	by mail.openembedded.org (Postfix) with ESMTP id CA5FC6FFFE
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Oct 2017 06:13:06 +0000 (UTC)
Received: from ORO-HUBT-01.luxoft.com (172.30.115.41) by
	oro-edge-01.luxoft.com (172.30.19.21) with Microsoft SMTP Server (TLS)
	id 14.3.319.2; Fri, 6 Oct 2017 09:13:04 +0300
Received: from ORO-MBOX-01.luxoft.com ([fe80::387f:bf07:869c:b95e]) by
	ORO-HUBT-01.luxoft.com ([::1]) with mapi id 14.03.0319.002;
	Fri, 6 Oct 2017 09:13:05 +0300
From: "Mardegan, Alberto" <AMardegan@luxoft.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/1] toaster: build missing
	toaster.conf settings
Thread-Index: AQHTPmosWlSx0yeQa06oEcNAdXii6A==
Date: Fri, 6 Oct 2017 06:13:05 +0000
Message-ID: <ac9effab-dfa2-1204-8613-e2a25e90dd5e@luxoft.com>
References: <cover.1507244747.git.paul.eggleton@linux.intel.com>
	<68417f805b782bb5e35ce413542b85898149fdbc.1507244747.git.paul.eggleton@linux.intel.com>
In-Reply-To: <68417f805b782bb5e35ce413542b85898149fdbc.1507244747.git.paul.eggleton@linux.intel.com>
Accept-Language: it-IT, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.21.44.132]
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] toaster: build missing toaster.conf settings
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
X-List-Received-Date: Fri, 06 Oct 2017 06:13:07 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <54B89D4394AE5A4A9DE63841CBE8F72B@luxoft.com>
Content-Transfer-Encoding: base64

SGksDQoNCj4gZGlmZiAtLWdpdCBhL2xpYi90b2FzdGVyL2JsZGNvbnRyb2wvbG9jYWxob3N0YmVj
b250cm9sbGVyLnB5IGIvbGliL3RvYXN0ZXIvYmxkY29udHJvbC9sb2NhbGhvc3RiZWNvbnRyb2xs
ZXIucHkNCj4gaW5kZXggYTJjYTk1Yi4uODNjYjcwMyAxMDA2NDQNCj4gLS0tIGEvbGliL3RvYXN0
ZXIvYmxkY29udHJvbC9sb2NhbGhvc3RiZWNvbnRyb2xsZXIucHkNCj4gKysrIGIvbGliL3RvYXN0
ZXIvYmxkY29udHJvbC9sb2NhbGhvc3RiZWNvbnRyb2xsZXIucHkNCj4gQEAgLTM4MSw5ICszODEs
MTAgQEAgY2xhc3MgTG9jYWxob3N0QkVDb250cm9sbGVyKEJ1aWxkRW52aXJvbm1lbnRDb250cm9s
bGVyKToNCj4gICAgICAgICAgbG9jYWxfYml0YmFrZSA9IG9zLnBhdGguam9pbihvcy5wYXRoLmRp
cm5hbWUob3MuZ2V0ZW52KCdCQkJBU0VESVInKSksDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgJ2JpdGJha2UnKQ0KPiAgICAgICAgICBzZWxmLl9zaGVsbGNtZChbJ2Jh
c2ggLWMgXCIoVE9BU1RFUl9CUkJFPSIlcyIgQkJTRVJWRVI9IjAuMC4wLjA6JXMiICcNCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICclcyAlcyAtdSB0b2FzdGVydWkgLS10b2tlbj0iIiA+PiVz
IDI+JjE7Jw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgJyVzICVzIC11IHRvYXN0ZXJ1aSAg
LS1yZWFkICVzIC0tcmVhZCAlcyAtLXRva2VuPSIiID4+JXMgMj4mMTsnDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAnQklUQkFLRV9VST0ia25vdHR5IiBCQlNFUlZFUj0wLjAuMC4wOiVzICVz
IC1tKSZcIicgXA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgJSAoYnJiZSwgc2VsZi5iZS5i
YnBvcnQsIGxvY2FsX2JpdGJha2UsIGJidGFyZ2V0cywgbG9nLCBzZWxmLmJlLmJicG9ydCwgYml0
YmFrZSldLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgJSAoYnJiZSwgc2VsZi5iZS5iYnBv
cnQsIGxvY2FsX2JpdGJha2UsIGJidGFyZ2V0cywgY29uZnBhdGgsIHRvYXN0ZXJsYXllcnMsIGxv
ZywNCg0KYmV0dGVyIGFkZCBxdW90ZXMgYXJvdW5kIHRoZSAlcyBpbiB0aGUgLS1yZWFkIHBhcmFt
ZXRlcnMsIGFzIHRoZXNlIHBhdGhzDQptaWdodCBjb250YWluIHNwYWNlcy4NCg0KQ2lhbywNCiAg
QWxiZXJ0bw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQpUaGlzIGUtbWFp
bCBhbmQgYW55IGF0dGFjaG1lbnQocykgYXJlIGludGVuZGVkIG9ubHkgZm9yIHRoZSByZWNpcGll
bnQocykgbmFtZWQgYWJvdmUgYW5kIG90aGVycyB3aG8gaGF2ZSBiZWVuIHNwZWNpZmljYWxseSBh
dXRob3JpemVkIHRvIHJlY2VpdmUgdGhlbS4gVGhleSBtYXkgY29udGFpbiBjb25maWRlbnRpYWwg
aW5mb3JtYXRpb24uIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFz
ZSBkbyBub3QgcmVhZCB0aGlzIGVtYWlsIG9yIGl0cyBhdHRhY2htZW50KHMpLiBGdXJ0aGVybW9y
ZSwgeW91IGFyZSBoZXJlYnkgbm90aWZpZWQgdGhhdCBhbnkgZGlzc2VtaW5hdGlvbiwgZGlzdHJp
YnV0aW9uIG9yIGNvcHlpbmcgb2YgdGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50KHMpIGlz
IHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGlu
IGVycm9yLCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmVwbHlpbmcg
dG8gdGhpcyBlLW1haWwgYW5kIHRoZW4gZGVsZXRlIHRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNo
bWVudChzKSBvciBjb3BpZXMgdGhlcmVvZiBmcm9tIHlvdXIgc3lzdGVtLiBUaGFuayB5b3UuDQo=

