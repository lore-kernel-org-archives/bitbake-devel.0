Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id 1B08E7FA20
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2019 12:20:18 +0000 (UTC)
IronPort-SDR: MXIiWECRkQ22rRWtf5g2ZgTsrdZYopFiFsZ1TUTCQaB0XBiWuo8uX/JpE1uPMDhuWXB6OtTkPK
	kyONmdBcidi+KPvPo4SyslcfMRtfsvoVrEHIFxPbgkpW9WsyUxxzca6n6FnLIQDkLPuGCokkef
	y2KVsrjpBLoIkMlJ2+NyCc4n0EBV4bRDmGJk+/n5rH8ap1cYHXVdn54qM1hSpCKxirSL+9Ohhc
	ROdS1/oFuRSSokTKTcD5/OwATx83uPzSZAdnWz+DptU+xY1F2KInA4810juPfSCwHm+umV86+8
	6FA=
X-IronPort-AV: E=Sophos;i="5.69,375,1571695200"; 
   d="scan'208";a="3858205"
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Ola x Nilsson
	<Ola.x.Nilsson@axis.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/2] bitbake: prserv/serv: Use with while
	reading pidfile
Thread-Index: AQHVt0IZbLc9zLhLlkCY/JpmjdqcT6fDRI+QgA881wCAACNyAA==
Date: Mon, 30 Dec 2019 12:20:18 +0000
Message-ID: <6a86529855cc4276944551773f09e266@XBOX03.axis.com>
References: <20191220142320.17724-1-olani@axis.com>
	<e512728a2ecb4ba68e0cbd3005596a99@XBOX03.axis.com>
	<d7d728082189ea9cde744cac1ab40b9bb11cd64e.camel@linuxfoundation.org>
In-Reply-To: <d7d728082189ea9cde744cac1ab40b9bb11cd64e.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] bitbake: prserv/serv: Use with while	reading pidfile
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
X-List-Received-Date: Mon, 30 Dec 2019 12:20:19 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmlj
aGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogZGVuIDMwIGRlY2VtYmVy
IDIwMTkgMTI6MDANCj4gVG86IFBldGVyIEtqZWxsZXJzdGVkdCA8cGV0ZXIua2plbGxlcnN0ZWR0
QGF4aXMuY29tPjsgT2xhIHggTmlsc3Nvbg0KPiA8T2xhLnguTmlsc3NvbkBheGlzLmNvbT47IGJp
dGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBTdWJqZWN0OiBSZTogW2JpdGJh
a2UtZGV2ZWxdIFtQQVRDSCAxLzJdIGJpdGJha2U6IHByc2Vydi9zZXJ2OiBVc2Ugd2l0aA0KPiB3
aGlsZSByZWFkaW5nIHBpZGZpbGUNCj4gDQo+IE9uIEZyaSwgMjAxOS0xMi0yMCBhdCAxNzoyMiAr
MDAwMCwgUGV0ZXIgS2plbGxlcnN0ZWR0IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiA+IEZyb206IGJpdGJha2UtZGV2ZWwtYm91bmNlc0BsaXN0cy5vcGVuZW1i
ZWRkZWQub3JnIDxiaXRiYWtlLWRldmVsLQ0KPiA+ID4gYm91bmNlc0BsaXN0cy5vcGVuZW1iZWRk
ZWQub3JnPiBPbiBCZWhhbGYgT2YgT2xhIHggTmlsc3Nvbg0KPiA+ID4gU2VudDogZGVuIDIwIGRl
Y2VtYmVyIDIwMTkgMTU6MjMNCj4gPiA+IFRvOiBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJl
ZGRlZC5vcmcNCj4gPiA+IFN1YmplY3Q6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0ggMS8yXSBiaXRi
YWtlOiBwcnNlcnYvc2VydjogVXNlIHdpdGgNCj4gPiA+IHdoaWxlDQo+ID4gPiByZWFkaW5nIHBp
ZGZpbGUNCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBPbGEgeCBOaWxzc29uIDxvbGFuaUBh
eGlzLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGxpYi9wcnNlcnYvc2Vydi5weSB8IDUgKystLS0N
Cj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9saWIvcHJzZXJ2L3NlcnYucHkgYi9saWIvcHJzZXJ2
L3NlcnYucHkNCj4gPiA+IGluZGV4IDMxMjRiMDc5Li43MDhiMmUwYSAxMDA2NDQNCj4gPiA+IC0t
LSBhL2xpYi9wcnNlcnYvc2Vydi5weQ0KPiA+ID4gKysrIGIvbGliL3Byc2Vydi9zZXJ2LnB5DQo+
ID4gPiBAQCAtMzUzLDkgKzM1Myw4IEBAIGRlZiBzdGFydF9kYWVtb24oZGJmaWxlLCBob3N0LCBw
b3J0LCBsb2dmaWxlKToNCj4gPiA+ICAgICAgaXAgPSBzb2NrZXQuZ2V0aG9zdGJ5bmFtZShob3N0
KQ0KPiA+ID4gICAgICBwaWRmaWxlID0gUElEUFJFRklYICUgKGlwLCBwb3J0KQ0KPiA+ID4gICAg
ICB0cnk6DQo+ID4gPiAtICAgICAgICBwZiA9IG9wZW4ocGlkZmlsZSwncicpDQo+ID4gPiAtICAg
ICAgICBwaWQgPSBpbnQocGYucmVhZGxpbmUoKS5zdHJpcCgpKQ0KPiA+ID4gLSAgICAgICAgcGYu
Y2xvc2UoKQ0KPiA+ID4gKyAgICAgICAgd2l0aCBvcGVuKHBpZGZpbGUpIGFzIHBmOg0KPiA+ID4g
KyAgICAgICAgICAgIHBpZCA9IGludChwZi5yZWFkbGluZSgpLnN0cmlwKCkpDQo+ID4gPiAgICAg
IGV4Y2VwdCBJT0Vycm9yOg0KPiA+ID4gICAgICAgICAgcGlkID0gTm9uZQ0KPiA+ID4NCj4gPiA+
IC0tDQo+ID4gPiAyLjExLjANCj4gPg0KPiA+IFRoaXMgb25seSBoYWxmIHRoZSBwYXRjaC4gUGxl
YXNlIGFkZCB0aGUgZm9sbG93aW5nOg0KPiA+DQo+ID4gQEAgLTI5MiwxMCArMjkyLDkgQEAgY2xh
c3MgUFJTZXJ2ZXIoU2ltcGxlWE1MUlBDU2VydmVyKToNCj4gPiAgICAgICAgICBsb2dnZXIuYWRk
SGFuZGxlcihzdHJlYW1oYW5kbGVyKQ0KPiA+DQo+ID4gICAgICAgICAgIyB3cml0ZSBwaWRmaWxl
DQo+ID4gLSAgICAgICAgcGlkID0gc3RyKG9zLmdldHBpZCgpKQ0KPiA+IC0gICAgICAgIHBmID0g
b3BlbihzZWxmLnBpZGZpbGUsICd3JykNCj4gPiAtICAgICAgICBwZi53cml0ZSgiJXNcbiIgJSBw
aWQpDQo+ID4gLSAgICAgICAgcGYuY2xvc2UoKQ0KPiA+ICsgICAgICAgIHBpZCA9IHN0cihvcy5n
ZXRwaWQoKSkNCj4gPiArICAgICAgICB3aXRoIG9wZW4oc2VsZi5waWRmaWxlLCAndycpIGFzIHBm
Og0KPiA+ICsgICAgICAgICAgICBwZi53cml0ZSgiJXNcbiIgJSBwaWQpDQo+ID4NCj4gPiAgICAg
ICAgICBzZWxmLndvcmtfZm9yZXZlcigpDQo+ID4gICAgICAgICAgc2VsZi5kZWxwaWQoKQ0KPiA+
DQo+IA0KPiBJJ3ZlIGhhbmRsZWQgdGhpcyBidXQgYXNraW5nIG1lIHRvIG1hbnVhbGx5IG1lcmdl
IGh1bmtzIG9mIHBhdGNoZXMNCj4gdG9nZXRoZXIgYmVmb3JlIGFwcGx5aW5nIHRoZW0gc2VlbXMg
YSBsaXR0bGUgcG90ZW50aWFsbHkgZXJyb3IgcHJvbmU/DQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBS
aWNoYXJkDQoNCldlbGwsIEkgbWFpbmx5IG1lYW50IGZvciBPbGEgdG8gc2VuZCBhbiB1cGRhdGVk
IHBhdGNoIHdpdGggYm90aCBodW5rcywgYnV0IA0KSSBndWVzcyBJIHNob3VsZCBoYXZlIHN0YXRl
ZCB0aGF0IGluIG15IHJlc3BvbnNlLiBBbnl3YXksIHRoYW5rcyBmb3IgdGFraW5nIA0KY2FyZSBv
ZiBpdC4NCg0KLy9QZXRlcg0KDQo=

