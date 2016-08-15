Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id DDD337665F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 14:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 313732E1B7;
	Mon, 15 Aug 2016 16:44:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id mUY+Z1KgW9h7; Mon, 15 Aug 2016 16:44:49 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id B7FC52E0AC;
	Mon, 15 Aug 2016 16:44:49 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 9A1121C35;
	Mon, 15 Aug 2016 16:44:49 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 8EDCB18A3;
	Mon, 15 Aug 2016 16:44:49 +0200 (CEST)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
	by thoth.se.axis.com (Postfix) with ESMTP id 8CAAD2C9;
	Mon, 15 Aug 2016 16:44:49 +0200 (CEST)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX02.axis.com (10.0.5.16) with
	Microsoft SMTP Server (TLS) id 15.0.1156.6;
	Mon, 15 Aug 2016 16:44:49 +0200
Received: from XBOX02.axis.com ([fe80::d00f:cb52:1b56:20d]) by XBOX02.axis.com
	([fe80::d00f:cb52:1b56:20d%21]) with mapi id 15.00.1156.000;
	Mon, 15 Aug 2016 16:44:49 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: =?utf-8?B?SsOpcsOpbXkgUm9zZW4=?= <jeremy.rosen@enst-bretagne.fr>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/1] add a syntax to clear variable
Thread-Index: AQHR41xDr7733WGCO0CzbeKXW/Pmf6BKP5jg
Date: Mon, 15 Aug 2016 14:44:49 +0000
Message-ID: <14c66145ed854a22bac20bcc53769fc1@XBOX02.axis.com>
References: <1469098538-14867-1-git-send-email-jeremy.rosen@smile.fr>
	<1469098538-14867-2-git-send-email-jeremy.rosen@smile.fr>
In-Reply-To: <1469098538-14867-2-git-send-email-jeremy.rosen@smile.fr>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Cc: =?utf-8?B?SsOpcsOpbXkgUm9zZW4=?= <jeremy.rosen@openwide.fr>
Subject: Re: [PATCH 1/1] add a syntax to clear variable
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
X-List-Received-Date: Mon, 15 Aug 2016 14:44:56 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SG93IHdpbGwgdGhpcyBpbnRlcmFjdCB3aXRoID89LCA/Pz0sIF9hcHBlbmQgYW5kIF9yZW1vdmU/
DQoNClNob3VsZG4ndCB0aGVyZSBiZSB1bml0IHRlc3RzIGZvciB0aGlzPyBJdCBzZWVtcyBsaWtl
IGl0IGNhbiBlYXNpbHkgDQpicmVhayBhbmQvb3IgYmUgYnJva2VuIGJ5IG90aGVyIGNoYW5nZXMu
DQoNCi8vUGV0ZXINCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRi
YWtlLWRldmVsLWJvdW5jZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyBbbWFpbHRvOmJpdGJha2Ut
DQo+IGRldmVsLWJvdW5jZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZ10gT24gQmVoYWxmIE9mIErD
qXLDqW15IFJvc2VuDQo+IFNlbnQ6IGRlbiAyMSBqdWxpIDIwMTYgMTI6NTYNCj4gVG86IGJpdGJh
a2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBDYzogSsOpcsOpbXkgUm9zZW4NCj4g
U3ViamVjdDogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSCAxLzFdIGFkZCBhIHN5bnRheCB0byBjbGVh
ciB2YXJpYWJsZQ0KPiANCj4gRnJvbTogSsOpcsOpbXkgUm9zZW4gPGplcmVteS5yb3NlbkBvcGVu
d2lkZS5mcj4NCj4gDQo+IHVuc2V0IFZBUg0KPiB3aWxsIGNsZWFyIHZhcmlhYmxlIFZBUg0KPiB1
bnNldCBWQVJbZmxhZ10NCj4gd2lsbCBjbGVhciBmbGFnICJmbGFnIiBmcm9tIHZhciBWQVINCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IErDqXLDqW15IFJvc2VuIDxqZXJlbXkucm9zZW5Ab3BlbndpZGUu
ZnI+DQo+IC0tLQ0KPiAgLi4uL2JpdGJha2UtdXNlci1tYW51YWwtbWV0YWRhdGEueG1sICAgICAg
ICAgICAgICAgfCAxNyArKysrKysrKysrKw0KPiAgYml0YmFrZS9saWIvYmIvcGFyc2UvYXN0LnB5
ICAgICAgICAgICAgICAgICAgICAgICAgfCAzMw0KPiArKysrKysrKysrKysrKysrKysrKysrDQo+
ICBiaXRiYWtlL2xpYi9iYi9wYXJzZS9wYXJzZV9weS9Db25mSGFuZGxlci5weSAgICAgICB8IDEy
ICsrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9iaXRiYWtlL2RvYy9iaXRiYWtlLXVzZXItbWFudWFsL2JpdGJha2UtdXNlci1t
YW51YWwtDQo+IG1ldGFkYXRhLnhtbCBiL2JpdGJha2UvZG9jL2JpdGJha2UtdXNlci1tYW51YWwv
Yml0YmFrZS11c2VyLW1hbnVhbC0NCj4gbWV0YWRhdGEueG1sDQo+IGluZGV4IDYzMjljZDYuLmM0
MjkwN2UgMTAwNjQ0DQo+IC0tLSBhL2JpdGJha2UvZG9jL2JpdGJha2UtdXNlci1tYW51YWwvYml0
YmFrZS11c2VyLW1hbnVhbC1tZXRhZGF0YS54bWwNCj4gKysrIGIvYml0YmFrZS9kb2MvYml0YmFr
ZS11c2VyLW1hbnVhbC9iaXRiYWtlLXVzZXItbWFudWFsLW1ldGFkYXRhLnhtbA0KPiBAQCAtMzMz
LDYgKzMzMywyMyBAQA0KPiAgICAgICAgICAgICAgPC9wYXJhPg0KPiAgICAgICAgICA8L3NlY3Rp
b24+DQo+IA0KPiArICAgICAgICA8c2VjdGlvbiBpZD0ndW5zZXRpbmctdmFyaWFibGVzJz4NCj4g
KyAgICAgICAgICAgIDx0aXRsZT5VbnNldGluZyB2YXJpYWJsZXM8L3RpdGxlPg0KPiArDQo+ICsg
ICAgICAgICAgICA8cGFyYT4NCj4gKyAgICAgICAgICAgICAgICBJdCBpcyBwb3NzaWJsZSB0byBj
b21wbGV0ZWx5IHJlbW92ZSBhIHZhcmlhYmxlIG9yIGENCj4gdmFyaWFibGUgZmxhZw0KPiArICAg
ICAgICAgICAgICAgIGZyb20gQml0QmFrZSdzIGludGVybmFsIGRhdGEgZGljdGlvbmFyeSB1c2lu
ZyB0aGUNCj4gInVuc2V0IiBrZXl3b3JkDQo+ICsgICAgICAgICAgICAgICAgSGVyZSBpcyBhbiBl
eGFtcGxlOg0KPiArICAgICAgICAgICAgICAgIDxsaXRlcmFsbGF5b3V0IGNsYXNzPSdtb25vc3Bh
Y2VkJz4NCj4gKyAgICAgICAgdW5zZXQgREFURQ0KPiArICAgICAgICB1bnNldCBkb19mZXRjaFtu
b2V4ZWNdDQo+ICsgICAgICAgICAgICAgICAgPC9saXRlcmFsbGF5b3V0Pg0KPiArICAgICAgICAg
ICAgICAgIFRoaXMgZXhhbXBsZSByZXN1bHRzIGluIHRoZSA8ZmlsZW5hbWU+REFURTwvZmlsZW5h
bWU+DQo+IGJlaW5nIHVuc2V0IGFuZCB0aGUgZmxhZw0KPiArICAgICAgICAgICAgICAgIDxmaWxl
bmFtZT5kb19mZXRjaFtub2V4ZWNdPC9maWxlbmFtZT4gdG8gYmUgY2xlYXJlZA0KPiArICAgICAg
ICAgICAgPC9wYXJhPg0KPiArDQo+ICsgICAgICAgIDwvc2VjdGlvbj4NCj4gKw0KPiAgICAgICAg
ICA8c2VjdGlvbiBpZD0ncHJvdmlkaW5nLXBhdGhuYW1lcyc+DQo+ICAgICAgICAgICAgICA8dGl0
bGU+UHJvdmlkaW5nIFBhdGhuYW1lczwvdGl0bGU+DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYml0YmFr
ZS9saWIvYmIvcGFyc2UvYXN0LnB5IGIvYml0YmFrZS9saWIvYmIvcGFyc2UvYXN0LnB5DQo+IGlu
ZGV4IDhiOWJhYTcuLmI0MDdiMDkgMTAwNjQ0DQo+IC0tLSBhL2JpdGJha2UvbGliL2JiL3BhcnNl
L2FzdC5weQ0KPiArKysgYi9iaXRiYWtlL2xpYi9iYi9wYXJzZS9hc3QucHkNCj4gQEAgLTY5LDYg
KzY5LDMzIEBAIGNsYXNzIEV4cG9ydE5vZGUoQXN0Tm9kZSk6DQo+ICAgICAgZGVmIGV2YWwoc2Vs
ZiwgZGF0YSk6DQo+ICAgICAgICAgIGRhdGEuc2V0VmFyRmxhZyhzZWxmLnZhciwgImV4cG9ydCIs
IDEsIG9wID0gJ2V4cG9ydGVkJykNCj4gDQo+ICtjbGFzcyBVbnNldE5vZGUoQXN0Tm9kZSk6DQo+
ICsgICAgZGVmIF9faW5pdF9fKHNlbGYsIGZpbGVuYW1lLCBsaW5lbm8sIHZhcik6DQo+ICsgICAg
ICAgIEFzdE5vZGUuX19pbml0X18oc2VsZiwgZmlsZW5hbWUsIGxpbmVubykNCj4gKyAgICAgICAg
c2VsZi52YXIgPSB2YXINCj4gKw0KPiArICAgIGRlZiBldmFsKHNlbGYsIGRhdGEpOg0KPiArICAg
ICAgICBsb2dpbmZvID0gew0KPiArICAgICAgICAgICAgJ3ZhcmlhYmxlJzogc2VsZi52YXIsDQo+
ICsgICAgICAgICAgICAnZmlsZSc6IHNlbGYuZmlsZW5hbWUsDQo+ICsgICAgICAgICAgICAnbGlu
ZSc6IHNlbGYubGluZW5vLA0KPiArICAgICAgICB9DQo+ICsgICAgICAgIGRhdGEuZGVsVmFyKHNl
bGYudmFyLCoqbG9naW5mbykNCj4gKw0KPiArY2xhc3MgVW5zZXRGbGFnTm9kZShBc3ROb2RlKToN
Cj4gKyAgICBkZWYgX19pbml0X18oc2VsZiwgZmlsZW5hbWUsIGxpbmVubywgdmFyLCBmbGFnKToN
Cj4gKyAgICAgICAgQXN0Tm9kZS5fX2luaXRfXyhzZWxmLCBmaWxlbmFtZSwgbGluZW5vKQ0KPiAr
ICAgICAgICBzZWxmLnZhciA9IHZhcg0KPiArICAgICAgICBzZWxmLmZsYWcgPSBmbGFnDQo+ICsN
Cj4gKyAgICBkZWYgZXZhbChzZWxmLCBkYXRhKToNCj4gKyAgICAgICAgbG9naW5mbyA9IHsNCj4g
KyAgICAgICAgICAgICd2YXJpYWJsZSc6IHNlbGYudmFyLA0KPiArICAgICAgICAgICAgJ2ZpbGUn
OiBzZWxmLmZpbGVuYW1lLA0KPiArICAgICAgICAgICAgJ2xpbmUnOiBzZWxmLmxpbmVubywNCj4g
KyAgICAgICAgfQ0KPiArICAgICAgICBkYXRhLmRlbFZhckZsYWcoc2VsZi52YXIsIHNlbGYuZmxh
ZywgKipsb2dpbmZvKQ0KPiArDQo+ICBjbGFzcyBEYXRhTm9kZShBc3ROb2RlKToNCj4gICAgICAi
IiINCj4gICAgICBWYXJpb3VzIGRhdGEgcmVsYXRlZCB1cGRhdGVzLiBGb3IgdGhlIHNha2Ugb2Yg
c2FuaXR5DQo+IEBAIC0yNzAsNiArMjk3LDEyIEBAIGRlZiBoYW5kbGVJbmNsdWRlKHN0YXRlbWVu
dHMsIGZpbGVuYW1lLCBsaW5lbm8sIG0sDQo+IGZvcmNlKToNCj4gIGRlZiBoYW5kbGVFeHBvcnQo
c3RhdGVtZW50cywgZmlsZW5hbWUsIGxpbmVubywgbSk6DQo+ICAgICAgc3RhdGVtZW50cy5hcHBl
bmQoRXhwb3J0Tm9kZShmaWxlbmFtZSwgbGluZW5vLCBtLmdyb3VwKDEpKSkNCj4gDQo+ICtkZWYg
aGFuZGxlVW5zZXQoc3RhdGVtZW50cywgZmlsZW5hbWUsIGxpbmVubywgbSk6DQo+ICsgICAgc3Rh
dGVtZW50cy5hcHBlbmQoVW5zZXROb2RlKGZpbGVuYW1lLCBsaW5lbm8sIG0uZ3JvdXAoMSkpKQ0K
PiArDQo+ICtkZWYgaGFuZGxlVW5zZXRGbGFnKHN0YXRlbWVudHMsIGZpbGVuYW1lLCBsaW5lbm8s
IG0pOg0KPiArICAgIHN0YXRlbWVudHMuYXBwZW5kKFVuc2V0RmxhZ05vZGUoZmlsZW5hbWUsIGxp
bmVubywgbS5ncm91cCgxKSwNCj4gbS5ncm91cCgyKSkpDQo+ICsNCj4gIGRlZiBoYW5kbGVEYXRh
KHN0YXRlbWVudHMsIGZpbGVuYW1lLCBsaW5lbm8sIGdyb3VwZCk6DQo+ICAgICAgc3RhdGVtZW50
cy5hcHBlbmQoRGF0YU5vZGUoZmlsZW5hbWUsIGxpbmVubywgZ3JvdXBkKSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9iaXRiYWtlL2xpYi9iYi9wYXJzZS9wYXJzZV9weS9Db25mSGFuZGxlci5weQ0KPiBi
L2JpdGJha2UvbGliL2JiL3BhcnNlL3BhcnNlX3B5L0NvbmZIYW5kbGVyLnB5DQo+IGluZGV4IGI5
NzEyOTIuLjg3NTI1MGQgMTAwNjQ0DQo+IC0tLSBhL2JpdGJha2UvbGliL2JiL3BhcnNlL3BhcnNl
X3B5L0NvbmZIYW5kbGVyLnB5DQo+ICsrKyBiL2JpdGJha2UvbGliL2JiL3BhcnNlL3BhcnNlX3B5
L0NvbmZIYW5kbGVyLnB5DQo+IEBAIC01Nyw2ICs1Nyw4IEBAIF9fY29uZmlnX3JlZ2V4cF9fICA9
IHJlLmNvbXBpbGUoIHIiIiINCj4gIF9faW5jbHVkZV9yZWdleHBfXyA9IHJlLmNvbXBpbGUoIHIi
aW5jbHVkZVxzKyguKykiICkNCj4gIF9fcmVxdWlyZV9yZWdleHBfXyA9IHJlLmNvbXBpbGUoIHIi
cmVxdWlyZVxzKyguKykiICkNCj4gIF9fZXhwb3J0X3JlZ2V4cF9fID0gcmUuY29tcGlsZSggciJl
eHBvcnRccysoW2EtekEtWjAtOVwtXysuJHt9L10rKSQiICkNCj4gK19fdW5zZXRfcmVnZXhwX18g
PSByZS5jb21waWxlKCByInVuc2V0XHMrKFthLXpBLVowLTlcLV8rLiR7fS9dKykkIiApDQo+ICtf
X3Vuc2V0X2ZsYWdfcmVnZXhwX18gPSByZS5jb21waWxlKCByInVuc2V0XHMrKFthLXpBLVowLTlc
LQ0KPiBfKy4ke30vXSspXFsoW2EtekEtWjAtOVwtXysuJHt9L10rKVxdJCIgKQ0KPiANCj4gIGRl
ZiBpbml0KGRhdGEpOg0KPiAgICAgIHRvcGRpciA9IGRhdGEuZ2V0VmFyKCdUT1BESVInLCBGYWxz
ZSkNCj4gQEAgLTE4NSw2ICsxODcsMTYgQEAgZGVmIGZlZWRlcihsaW5lbm8sIHMsIGZuLCBzdGF0
ZW1lbnRzKToNCj4gICAgICAgICAgYXN0LmhhbmRsZUV4cG9ydChzdGF0ZW1lbnRzLCBmbiwgbGlu
ZW5vLCBtKQ0KPiAgICAgICAgICByZXR1cm4NCj4gDQo+ICsgICAgbSA9IF9fdW5zZXRfcmVnZXhw
X18ubWF0Y2gocykNCj4gKyAgICBpZiBtOg0KPiArICAgICAgICBhc3QuaGFuZGxlVW5zZXQoc3Rh
dGVtZW50cywgZm4sIGxpbmVubywgbSkNCj4gKyAgICAgICAgcmV0dXJuDQo+ICsNCj4gKyAgICBt
ID0gX191bnNldF9mbGFnX3JlZ2V4cF9fLm1hdGNoKHMpDQo+ICsgICAgaWYgbToNCj4gKyAgICAg
ICAgYXN0LmhhbmRsZVVuc2V0RmxhZyhzdGF0ZW1lbnRzLCBmbiwgbGluZW5vLCBtKQ0KPiArICAg
ICAgICByZXR1cm4NCj4gKw0KPiAgICAgIHJhaXNlIFBhcnNlRXJyb3IoInVucGFyc2VkIGxpbmU6
ICclcyciICUgcywgZm4sIGxpbmVubyk7DQo+IA0KPiAgIyBBZGQgdXMgdG8gdGhlIGhhbmRsZXJz
IGxpc3QNCj4gLS0NCj4gMi44LjENCj4gDQo+IC0tDQo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQo+IGJpdGJha2UtZGV2ZWwgbWFpbGluZyBsaXN0DQo+
IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBodHRwOi8vbGlzdHMub3Bl
bmVtYmVkZGVkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JpdGJha2UtZGV2ZWwNCg==

