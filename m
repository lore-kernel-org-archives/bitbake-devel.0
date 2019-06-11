Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2E3847DA9A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jun 2019 08:24:52 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x5B8Oqbn002190
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 11 Jun 2019 01:24:52 -0700 (PDT)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.194]) by
	ALA-HCB.corp.ad.wrs.com ([147.11.189.41]) with mapi id 14.03.0439.000;
	Tue, 11 Jun 2019 01:24:51 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/1] [THUD] toaster: Fix Thud Bitbake
	release for YP-2.6
Thread-Index: AQHVH2kOLmmPzXZcikCBtOTr8Es/pqaWG22A
Date: Tue, 11 Jun 2019 08:24:51 +0000
Message-ID: <5E53D14CE4667A45B9A06760DE5D13D0F3CA1F08@ALA-MBD.corp.ad.wrs.com>
References: <cover.1560127238.git.David.Reyna@windriver.com>
	<2784075cbd0cc105c8c6ecdced2226de94d4b343.1560127238.git.David.Reyna@windriver.com>
	<8b6337f60aa01cc8e4c940f6fb20f4d8207d2b5c.camel@linuxfoundation.org>
In-Reply-To: <8b6337f60aa01cc8e4c940f6fb20f4d8207d2b5c.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.11.119.52]
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] [THUD] toaster: Fix Thud Bitbake release for YP-2.6
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
X-List-Received-Date: Tue, 11 Jun 2019 08:24:52 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUmljaGFyZCwNCg0KPiBXaGVuIHdlIGZpeCBhbiBpc3N1ZSBsaWtlIHRoaXMgd2UgcmVhbGx5
IG5lZWQgdG8gZml4IGl0IG9uIG1hc3RlciBmaXJzdC4uLg0KDQpJIHdhcyBhY3R1YWxseSBub3Qg
Z29pbmcgdG8gZml4IG1hc3RlciBiZWNhdXNlICJUaHVkIiBkaXNhcHBlYXJzIGZyb20gdGhlc2Ug
ZmlsZXMgYW5kIGdldHMgcmVwbGFjZWQgYnkgIlpldXMiIHdoZW4gbWFzdGVyIGZpbmFsbHkgYmVj
b21lcyAiWmV1cyIsIGJ1dCBJIHVuZGVyc3RhbmQgeW91ciBwb2ludC4NCg0KPiAuLi4gdGhlbiBi
YWNrcG9ydGVkIGl0IHRvIHRoZSAxLjQyIGFuZCAxLjQwIGJyYW5jaGVzIHdpdGggYSBzdHJhaWdo
dGZvcndhcmQgY2hlcnJ5LXBpY2suDQoNClRoYXQgc2hvdWxkIHdvcmsuIFRoZSBhZmZlY3RlZCBm
aWxlcyBhcmUgc2xpZ2h0bHkgZGlmZmVyZW50IG5lYXJieSwgYnV0IHNpbmNlIHRoZSBjaGVycnkg
cGljayB3b3JrZWQgdGhvc2UgZGlmZmVyZW5jZXMgYXJlIGZvcnR1bmF0ZWx5IG91dHNpZGUgdGhl
IGZ1enogem9uZSwgc28gYWxsIGlzIGdvb2QuDQoNCj4gQ2FuIHlvdSBjaGVjayBJJ3ZlIGdvdCB0
aGUgcmlnaHQgY2hhbmdlcyBpbiBwbGVhc2U/DQoNClllcyB0aGV5IGFyZSENCg0KLSBEYXZpZA0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUmljaGFyZCBQdXJkaWUgW21haWx0
bzpyaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRpb24ub3JnXSANClNlbnQ6IE1vbmRheSwgSnVu
ZSAxMCwgMjAxOSAxOjQ3IEFNDQpUbzogUmV5bmEsIERhdmlkOyBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcNClN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gW1BBVENIIDEv
MV0gW1RIVURdIHRvYXN0ZXI6IEZpeCBUaHVkIEJpdGJha2UgcmVsZWFzZSBmb3IgWVAtMi42DQoN
Ck9uIFN1biwgMjAxOS0wNi0wOSBhdCAxNzo0NCAtMDcwMCwgRGF2aWQgUmV5bmEgd3JvdGU6DQo+
IEZyb206IERhdmlkIFJleW5hIDxEYXZpZC5SZXluYUB3aW5kcml2ZXIuY29tPg0KPiANCj4gRml4
IHRoZSBCaXRiYWtlIHZlcnNpb24gSUQgZm9yIFRodWQgKDEuNDApLg0KPiANCj4gW1lPQ1RPICMx
MzM1Nl0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFJleW5hIDxEYXZpZC5SZXluYUB3aW5k
cml2ZXIuY29tPg0KPiAtLS0NCj4gIGxpYi90b2FzdGVyL29ybS9maXh0dXJlcy9vZS1jb3JlLnht
bCB8IDIgKy0NCj4gIGxpYi90b2FzdGVyL29ybS9maXh0dXJlcy9wb2t5LnhtbCAgICB8IDIgKy0N
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpU
aGFua3MgZm9yIHRoZXNlIERhdmlkLg0KDQpXaGVuIHdlIGZpeCBhbiBpc3N1ZSBsaWtlIHRoaXMg
d2UgcmVhbGx5IG5lZWQgdG8gZml4IGl0IG9uIG1hc3Rlcg0KZmlyc3QsIHRoZW4gYmFja3BvcnQg
dGhlIGZpeCB0byB0aGUgd2FycmlvciBhbmQgdGhlbiB0aHVkIGJyYW5jaGVzLg0KDQpJbiB0aGlz
IGNhc2UgSSd2ZSBhcHBsaWVkIHRoZSBmaXggdG8gbWFzdGVyICh3aXRoIHNvbWUgdGVha3MgdG8g
dGhlDQpjb21taXQgbWVzc2FnZSksIHRoZW4gYmFja3BvcnRlZCBpdCB0byB0aGUgMS40MiBhbmQg
MS40MCBicmFuY2hlcyB3aXRoDQphIHN0cmFpZ2h0Zm9yd2FyZCBjaGVycnktcGljay4NCg0KQ2Fu
IHlvdSBjaGVjayBJJ3ZlIGdvdCB0aGUgcmlnaHQgY2hhbmdlcyBpbiBwbGVhc2U/DQoNCkNoZWVy
cywNCg0KUmljaGFyZA0KDQo=

