Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id E819F7995D
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 30 Sep 2018 07:06:41 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w8U76dK8013162
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 30 Sep 2018 00:06:39 -0700 (PDT)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.79]) by
	ALA-HCA.corp.ad.wrs.com ([147.11.189.40]) with mapi id 14.03.0415.000;
	Sun, 30 Sep 2018 00:06:39 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: akuster808 <akuster808@gmail.com>, "Belal, Awais" <Awais_Belal@mentor.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [sumo][PATCH] toaster: localhostbecontroller:
	fix bitbake path resolution
Thread-Index: AQHUS0UdM8G0xVWi7EeQqAsalTR7hKTvXz/wgBaVVC6AAoxKYA==
Date: Sun, 30 Sep 2018 07:06:38 +0000
Message-ID: <5E53D14CE4667A45B9A06760DE5D13D0F3ADA18C@ALA-MBD.corp.ad.wrs.com>
References: <1536831336527.93802@mentor.com>
	<5E53D14CE4667A45B9A06760DE5D13D0F3AC15D6@ALA-MBD.corp.ad.wrs.com>
	<1537430385445.98207@mentor.com> <1538034849901.46023@mentor.com>
	<f3a9349906015f5961c688f27b82fa92967e5510.camel@linuxfoundation.org>
	<1538120253384.1227@mentor.com>
	<573089240e7086a6091c1123454a842cec4cff78.camel@linuxfoundation.org>
	<1538131095353.74870@mentor.com>
	<816315bc-4572-6c96-9872-8f19bf511eb1@gmail.com>
In-Reply-To: <816315bc-4572-6c96-9872-8f19bf511eb1@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.11.119.35]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path resolution
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
X-List-Received-Date: Sun, 30 Sep 2018 07:06:43 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpJIGNyZWF0ZWQgbXkgb3duIHZlcnNpb24gb2YgQXdhaXMncyBwYXRjaCBmcm9t
IG15IFN1bW8gYnJhbmNoLiBUaGUgb25seSBkaWZmZXJlbmNlIHdhcyB0aGF0IEkgYmFzZWQgYnkg
cGF0Y2ggZnJvbSB0aGUgImJpdGJha2UiIGRpcmVjdG9yeSAoQXdhaXMgZGlkIGl0IGZyb20gdGhl
IGJpdGJha2UvbGliIiBkaXJlY3RvcnkpLCBwbHVzIEkgZ290IGFuIGV4dHJhIGJsYW5rIGxpbmUg
YXQgdGhlIGVuZC4NCg0KSSBhbSBnb2luZyB0byBzdWJtaXQgbXkgdmVyc2lvbiBvZiB0aGUgcGF0
Y2ggaW4gYSBmZXcgbWludXRlcy4gSXQgc2hvdWxkIGxvb2sgaWRlbnRpY2FsIHRvIHRoZSBvcmln
aW5hbCBmcm9tIEF3YWlzLCBleGNlcHQgZm9yIHRoZSBhYm92ZSBvYnNlcnZhdGlvbnMuDQoNCi0g
RGF2aWQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFrdXN0ZXI4MDggW21h
aWx0bzpha3VzdGVyODA4QGdtYWlsLmNvbV0gDQpTZW50OiBGcmlkYXksIFNlcHRlbWJlciAyOCwg
MjAxOCA5OjA5IEFNDQpUbzogQmVsYWwsIEF3YWlzOyByaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5k
YXRpb24ub3JnOyBSZXluYSwgRGF2aWQ7IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVk
Lm9yZw0KU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBbc3Vtb11bUEFUQ0hdIHRvYXN0ZXI6
IGxvY2FsaG9zdGJlY29udHJvbGxlcjogZml4IGJpdGJha2UgcGF0aCByZXNvbHV0aW9uDQoNCg0K
DQpPbiAwOS8yOC8yMDE4IDAzOjM4IEFNLCBCZWxhbCwgQXdhaXMgd3JvdGU6DQo+Pj4gVGhlIHBh
dGNoIGRvZXNuJ3QgYXBwbHkgdG8gbWFzdGVyIHNvIGNvdWxkIHlvdSBzZW5kIGEgdmVyc2lvbiB3
aGljaA0KPj4+IGFwcGxpZXMgdGhlcmUgcGxlYXNlPw0KPj4+IEkgY2FuIHRoZW4gYXBwbHkgdGhl
IHN1bW8gb25lIGF0IHRoZSBzYW1lIHRpbWUgd2hpY2ggZG9lcyBwcmVzdW1hYmx5DQo+Pj4gYXBw
bHkgdG8gc3VtbyAoSSd2ZSBub3QgdHJpZWQgdGhhdCBhcyB5ZXQpLg0KPiBFeHRyZW1lbHkgc29y
cnksIHRoaXMgaXMgb25seSBuZWVkZWQgZm9yIHN1bW8gKDEuMzgpLCBtYXN0ZXIgZG9lc24ndCBo
YXZlIHRoaXMgcHJvYmxlbS4NCg0KVGhpcyBkb2VzIG5vdCBhcHBseSB0byBzdW1vIGVpdGhlci4g
V2UgaGF2ZSB0aGUgY29tbWl0IGl0IGRlcGVuZHMgb246DQoNCmMxZjVlYzggYml0YmFrZTogdG9h
c3RlcjogdXNlIGEgbW9yZSBmbGV4aWJsZSB3YXkgdG8gZmluZCBiaXRiYWtlDQoNCi0gYXJtaW4N
Cg0KPg0KPg0KPg0KPiBCUiwNCj4gQXdhaXMNCj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KPiBGcm9tOiByaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRpb24u
b3JnIDxyaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiBGcmlkYXks
IFNlcHRlbWJlciAyOCwgMjAxOCAxMjo1MiBQTQ0KPiBUbzogQmVsYWwsIEF3YWlzOyBSZXluYSwg
RGF2aWQ7IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW2JpdGJha2UtZGV2ZWxdIFtzdW1vXVtQQVRDSF0gdG9hc3RlcjogbG9jYWxob3N0YmVjb250
cm9sbGVyOiBmaXggYml0YmFrZSBwYXRoIHJlc29sdXRpb24NCj4NCj4gT24gRnJpLCAyMDE4LTA5
LTI4IGF0IDA3OjM3ICswMDAwLCBCZWxhbCwgQXdhaXMgd3JvdGU6DQo+Pj4+IEknbSBjb25mdXNl
ZC4gRG9lcyBtYXN0ZXIgbmVlZCB0aGUgcGF0Y2g/IG9yIG9ubHkgc3Vtbz8NCj4+IEJvdGguDQo+
IFRoZSBwYXRjaCBkb2Vzbid0IGFwcGx5IHRvIG1hc3RlciBzbyBjb3VsZCB5b3Ugc2VuZCBhIHZl
cnNpb24gd2hpY2gNCj4gYXBwbGllcyB0aGVyZSBwbGVhc2U/DQo+DQo+IEkgY2FuIHRoZW4gYXBw
bHkgdGhlIHN1bW8gb25lIGF0IHRoZSBzYW1lIHRpbWUgd2hpY2ggZG9lcyBwcmVzdW1hYmx5DQo+
IGFwcGx5IHRvIHN1bW8gKEkndmUgbm90IHRyaWVkIHRoYXQgYXMgeWV0KS4NCj4NCj4gVGhhbmtz
LA0KPg0KPiBSaWNoYXJkDQoNCg==

