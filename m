Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id CCB7660438
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Aug 2014 13:19:01 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 13 Aug 2014 06:18:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,857,1400050800"; d="scan'208";a="587540241"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
	by orsmga002.jf.intel.com with ESMTP; 13 Aug 2014 06:18:35 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
	ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server
	(TLS) id 14.3.195.1; Wed, 13 Aug 2014 06:18:34 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.102]) by
	ORSMSX153.amr.corp.intel.com ([169.254.12.101]) with mapi id
	14.03.0195.001; Wed, 13 Aug 2014 06:18:34 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, Christopher Larson
	<clarson@kergoth.com>
Thread-Topic: [bitbake-devel] bitbake user manual: shouldn't "Events"
	mention "[eventmask]"?
Thread-Index: AQHPtYmcu7PLXpzE4EeNMo6j1iL5C5vOhrEA
Date: Wed, 13 Aug 2014 13:18:33 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FDCFDD@ORSMSX101.amr.corp.intel.com>
References: <alpine.LFD.2.11.1408110806310.9162@localhost>
	<CABcZANkvKtcEfNBHJ3VfDV_A61WZ6H=bm_MgtJ4EbPcRgOdW0w@mail.gmail.com>
	<alpine.LFD.2.11.1408111320560.6960@localhost>
In-Reply-To: <alpine.LFD.2.11.1408111320560.6960@localhost>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake user manual: shouldn't "Events" mention "[eventmask]"?
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
X-List-Received-Date: Wed, 13 Aug 2014 13:19:02 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIA0KDQpJIHVwZGF0ZWQgdGhlIEJCIG1hbnVhbCBoZXJlIHRvIGFjY291bnQgZm9yIHRoaXMg
ZmxhZy4gIENoZWNrIGl0IG91dCBhbmQgbGV0IG1lIGtub3cgaWYgdGhpcyBhZGVxdWF0ZWx5IGNv
dmVycyB0aGlzIGlzc3VlOg0KDQpodHRwOi8vd3d3LnlvY3RvcHJvamVjdC5vcmcvZG9jcy8xLjcv
Yml0YmFrZS11c2VyLW1hbnVhbC9iaXRiYWtlLXVzZXItbWFudWFsLmh0bWwjZXZlbnRzDQoNClRo
YW5rcywgDQpTY290dA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBiaXRi
YWtlLWRldmVsLWJvdW5jZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyBbbWFpbHRvOmJpdGJha2Ut
DQo+ZGV2ZWwtYm91bmNlc0BsaXN0cy5vcGVuZW1iZWRkZWQub3JnXSBPbiBCZWhhbGYgT2YgUm9i
ZXJ0IFAuIEouIERheQ0KPlNlbnQ6IE1vbmRheSwgQXVndXN0IDExLCAyMDE0IDEwOjI3IEFNDQo+
VG86IENocmlzdG9waGVyIExhcnNvbg0KPkNjOiBCaXRCYWtlIGRldmVsb3BlciBsaXN0DQo+U3Vi
amVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBiaXRiYWtlIHVzZXIgbWFudWFsOiBzaG91bGRuJ3Qg
IkV2ZW50cyIgbWVudGlvbg0KPiJbZXZlbnRtYXNrXSI/DQo+DQo+T24gTW9uLCAxMSBBdWcgMjAx
NCwgQ2hyaXN0b3BoZXIgTGFyc29uIHdyb3RlOg0KPg0KPj4NCj4+IE9uIE1vbiwgQXVnIDExLCAy
MDE0IGF0IDU6MDggQU0sIFJvYmVydCBQLiBKLiBEYXkgPHJwamRheUBjcmFzaGNvdXJzZS5jYT4N
Cj53cm90ZToNCj4+DQo+PiDCoCByZWFkaW5nIHVwIG9uIGV2ZW50cyBpbiBCQiBtYW51YWwgYW5k
IHNlY3Rpb24gMy43LCAiRXZlbnRzIiwgdGFsa3MNCj4+IG9mIGRlZmluaW5nIGV2ZW50IGhhbmRs
ZXJzLCBidXQgY2xhaW1zOg0KPj4NCj4+ICJUaGlzIGV2ZW50IGhhbmRsZXIgZ2V0cyBjYWxsZWQg
ZXZlcnkgdGltZSBhbiBldmVudCBpcyB0cmlnZ2VyZWQuIg0KPj4NCj4+IGJ1dCBkb24ndCB5b3Ug
aGF2ZSB0byBhc3NvY2lhdGUgYW4gZXZlbnQgaGFuZGxlciB3aXRoIG9uZSBvciBtb3JlDQo+PiBl
dmVudHMgdXNpbmcgdGhlICJbZXZlbnRtYXNrXSIgZmxhZz8gdGhhdCBzZWVtcyBsaWtlIGEgZmFp
cmx5DQo+PiBzaWduaWZpY2FudCBvbWlzc2lvbiBmcm9tIHRoYXQgc2VjdGlvbi4gb3IgYW0gaSBq
dXN0IG1pc3VuZGVyc3RhbmRpbmcNCj4+IGhvdyBldmVudHMgd29yaz8NCj4+DQo+PiBldmVudG1h
c2sgaXMgYSBmYWlybHkgcmVjZW50IGFkZGl0aW9uLiBJZiBldmVudG1hc2sgaXMgdW5kZWZpbmVk
LCB0aGUNCj4+IGhhbmRsZXIgaXMgY2FsbGVkIGZvciBhbGwgZXZlbnRzLCBhbmQgaXRzIGxlZnQg
dG8gdGhlIGV2ZW50IGhhbmRsZXIgdG8NCj4+IG1ha2Ugc3VyZSBpdCdzIG9ubHkgZG9pbmcgaXRz
IGxvZ2ljIGZvciB0aGUgcmlnaHQgZXZlbnRzIChlLmcuIGNhbGwNCj4+IGlzaW5zdGFuY2UoKSBv
biAnZScgdG8gY2hlY2sgd2hhdCBldmVudCBpdCBpcykuIFRoZSBkb2NzIGxpa2VseSB3ZXJlDQo+
PiBuZXZlciB1cGRhdGVkIHRvIGluY2x1ZGUgaXQuDQo+DQo+ICB5ZWFoLCB0aGF0J3MgcHJvYmFi
bHkgc29tZXRoaW5nIHRoYXQgc2hvdWxkIGJlIGluIHRoZSBiaXRiYWtlIG1hbnVhbA0KPnNvbWV3
aGVyZS4gOi0pDQo+DQo+cmRheQ0KPg0KPi0tDQo+DQo+PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj49PT09PT09PT09PT09DQo+Um9i
ZXJ0IFAuIEouIERheSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE90dGF3YSwgT250
YXJpbywgQ0FOQURBDQo+ICAgICAgICAgICAgICAgICAgICAgICAgaHR0cDovL2NyYXNoY291cnNl
LmNhDQo+DQo+VHdpdHRlcjogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBo
dHRwOi8vdHdpdHRlci5jb20vcnBqZGF5DQo+TGlua2VkSW46ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGh0dHA6Ly9jYS5saW5rZWRpbi5jb20vaW4vcnBqZGF5DQo+PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj49PT09PT09
PT09PT09DQo=

