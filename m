Return-Path: <praveenreddy.p@hcl.com>
Received: from GWS07.hcl.com (gws07.hcl.com [192.8.186.130])
	by mail.openembedded.org (Postfix) with ESMTP id E981A602D9
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Mar 2016 07:03:22 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.22,555,1449513000"; d="scan'208";a="46679300"
Received: from unknown (HELO CHN-CORP-HT01.CORP.HCL.IN) ([10.249.2.33])
	by GWS07.hcl.com with ESMTP/TLS/AES128-SHA; 08 Mar 2016 12:33:19 +0530
Received: from CHN-HCLT-CSHT03.HCLT.CORP.HCL.IN (10.150.12.28) by
	CHN-CORP-HT01.CORP.HCL.IN (10.249.2.33) with Microsoft SMTP Server
	(TLS) id 14.3.235.1; Tue, 8 Mar 2016 12:33:19 +0530
Received: from CHN-HCLT-MBS02.HCLT.CORP.HCL.IN ([fe80::45e7:d7f7:b243:fdd9])
	by CHN-HCLT-CSHT03.HCLT.CORP.HCL.IN ([::1]) with mapi id 14.03.0235.001;
	Tue, 8 Mar 2016 12:33:19 +0530
From: Praveenreddy Padamati <praveenreddy.p@hcl.com>
To: 'Gary Thomas' <gary@mlbassoc.com>, 'Khem Raj' <raj.khem@gmail.com>
Thread-Topic: [bitbake-devel] chromium browser
Thread-Index: AQHReGFDlNN7EeNKf0OQDnoPRvoa6p9NgCsAgAGfsUA=
Date: Tue, 8 Mar 2016 07:03:19 +0000
Message-ID: <09856974BCEE6F48AB378E52E4CAA73C226D8C07@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>
References: <09856974BCEE6F48AB378E52E4CAA73C226D79DD@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>
	<56DD45D3.5030506@mlbassoc.com>
	<09856974BCEE6F48AB378E52E4CAA73C226D7C15@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>
	<CAMKF1spOi8RbduxxwJHtUx_Xv69YO9nX7kr3fWBd4haMsL8OGQ@mail.gmail.com>
	<56DD6960.40902@mlbassoc.com>
In-Reply-To: <56DD6960.40902@mlbassoc.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.150.5.114]
MIME-Version: 1.0
Cc: 'bitbake-devel' <bitbake-devel@lists.openembedded.org>
Subject: Re: chromium browser
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
X-List-Received-Date: Tue, 08 Mar 2016 07:03:24 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpNeSBidWlsZCBzeXN0ZW0gaGFzIDRnYiByYW0uIA0KQW5kIEkgZm91bmQgbWFu
eSBsb2cuZG9fY29tcGlsZSBmaWxlcy4gQ2FuIHlvdSB0ZWxsIG1lIHdoaWNoIGxvZyBmaWxlIEkg
bmVlZCB0byBzZWUgZm9yIHRoZSBjb3JlIGltYWdlIHNhdG8uIA0KDQpUaGFua3MNClByYXZlZW4g
UmVkZHkgUA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogR2FyeSBUaG9tYXMg
W21haWx0bzpnYXJ5QG1sYmFzc29jLmNvbV0gDQpTZW50OiBNb25kYXksIE1hcmNoIDA3LCAyMDE2
IDU6MTMgUE0NClRvOiBLaGVtIFJhajsgUHJhdmVlbnJlZGR5IFBhZGFtYXRpDQpDYzogYml0YmFr
ZS1kZXZlbA0KU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBjaHJvbWl1bSBicm93c2VyDQoN
Ck9uIDIwMTYtMDMtMDcgMTI6MDUsIEtoZW0gUmFqIHdyb3RlOg0KPiBXaGF0IGlzIHlvdXIgYnVp
bGQgbWFjaGluZSBjb25maWd1cmF0aW9uIGFuZCBsb29rIGF0IGxvZy5kb19jcG1waWxlIGl0IA0K
PiBtaWdodCBoYXZlIHNvbWUgaW5mbw0KPg0KDQpBbHNvIG5vdGUgdGhhdCBkZXBlbmRpbmcgb24g
eW91ciBsaW5rZXIgY2hvaWNlIHRoZSBidWlsZCBjYW4gbmVlZCBhIGxvdCBvZiBSQU0gYW5kIGlm
IHlvdXIgYnVpbGQgbWFjaGluZSBkb2Vzbid0IGhhdmUgZW5vdWdoIHlvdSdsbCBzcGVuZCBhIGxv
dCBvZiB0aW1lIHN3YXBwaW5nLiAgSSB3b3VsZCBzdWdnZXN0IHRoYXQgeW91ciBidWlsZCBob3N0
IGhhcyBhdCBsZWFzdCA0R0IgUkFNIHRvIGJ1aWxkIGNocm9taXVtLg0KDQo+IE9uIE1hciA3LCAy
MDE2IDU6NTcgUE0sICJQcmF2ZWVucmVkZHkgUGFkYW1hdGkiIDxwcmF2ZWVucmVkZHkucEBoY2wu
Y29tIDxtYWlsdG86cHJhdmVlbnJlZGR5LnBAaGNsLmNvbT4+IHdyb3RlOg0KPg0KPiAgICAgSGks
DQo+DQo+ICAgICBUaGFua3MgZm9yIHRoZSByZXBseS4gSXQgdG9vayBtb3JlIHRoYW4gMjQgaG91
cnMgYW5kIHRoZW4gd2Ugc3RvcHBlZCBpdC4NCj4NCj4gICAgIFRoYW5rcw0KPiAgICAgUHJhdmVl
biBSZWRkeSBQDQo+DQo+ICAgICAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiAgICAgRnJv
bTogYml0YmFrZS1kZXZlbC1ib3VuY2VzQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcgPG1haWx0bzpi
aXRiYWtlLWRldmVsLWJvdW5jZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4NCj4gICAgIFttYWls
dG86Yml0YmFrZS1kZXZlbC1ib3VuY2VzQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcgPG1haWx0bzpi
aXRiYWtlLWRldmVsLWJvdW5jZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz5dIE9uDQo+ICAgICBC
ZWhhbGYgT2YgR2FyeSBUaG9tYXMNCj4gICAgIFNlbnQ6IE1vbmRheSwgTWFyY2ggMDcsIDIwMTYg
Mjo0MiBQTQ0KPiAgICAgVG86IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyA8
bWFpbHRvOmJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4NCj4gICAgIFN1Ympl
Y3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gY2hyb21pdW0gYnJvd3Nlcg0KPg0KPiAgICAgT24gMjAx
Ni0wMy0wNyAwOTozMCwgUHJhdmVlbnJlZGR5IFBhZGFtYXRpIHdyb3RlOg0KPiAgICAgID4gSGks
DQo+ICAgICAgPg0KPiAgICAgID4gV2hlbiBJIGFkZGVkIGNocm9taXVtIGJyb3dzZXIgaW4geW9j
dG8gYnVpbGQgY29uZmlndXJhdGlvbiB0aGVuIGJpdGJha2UgaXMgc3R1Y2tpbmcgYXQgZG8gY29t
cGlsZS4gQ2FuIHlvdSBwbGVhc2UNCj4gICAgIGhlbHAgbWU/DQo+ICAgICAgPg0KPg0KPiAgICAg
SG93IGxvbmcgaGF2ZSB5b3Ugd2FpdGVkPyAgRGVwZW5kaW5nIG9uIHlvdXIgdGFyZ2V0IGFuZCBo
b3N0L2J1aWxkIHNldHRpbmdzLCBidWlsZGluZyBjaHJvbWl1bSBjYW4gdGFrZSBhIExPTkcgdGlt
ZQ0KPiAgICAgKG1lYXN1cmVkIGluIGhvdXJzKQ0KPg0KDQotLQ0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpHYXJ5IFRob21hcyAg
ICAgICAgICAgICAgICAgfCAgQ29uc3VsdGluZyBmb3IgdGhlDQpNTEIgQXNzb2NpYXRlcyAgICAg
ICAgICAgICAgfCAgICBFbWJlZGRlZCB3b3JsZA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoKCjo6RElTQ0xBSU1FUjo6Ci0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KClRoZSBjb250ZW50cyBvZiB0aGlzIGUtbWFp
bCBhbmQgYW55IGF0dGFjaG1lbnQocykgYXJlIGNvbmZpZGVudGlhbCBhbmQgaW50ZW5kZWQgZm9y
IHRoZSBuYW1lZCByZWNpcGllbnQocykgb25seS4KRS1tYWlsIHRyYW5zbWlzc2lvbiBpcyBub3Qg
Z3VhcmFudGVlZCB0byBiZSBzZWN1cmUgb3IgZXJyb3ItZnJlZSBhcyBpbmZvcm1hdGlvbiBjb3Vs
ZCBiZSBpbnRlcmNlcHRlZCwgY29ycnVwdGVkLApsb3N0LCBkZXN0cm95ZWQsIGFycml2ZSBsYXRl
IG9yIGluY29tcGxldGUsIG9yIG1heSBjb250YWluIHZpcnVzZXMgaW4gdHJhbnNtaXNzaW9uLiBU
aGUgZSBtYWlsIGFuZCBpdHMgY29udGVudHMKKHdpdGggb3Igd2l0aG91dCByZWZlcnJlZCBlcnJv
cnMpIHNoYWxsIHRoZXJlZm9yZSBub3QgYXR0YWNoIGFueSBsaWFiaWxpdHkgb24gdGhlIG9yaWdp
bmF0b3Igb3IgSENMIG9yIGl0cyBhZmZpbGlhdGVzLgpWaWV3cyBvciBvcGluaW9ucywgaWYgYW55
LCBwcmVzZW50ZWQgaW4gdGhpcyBlbWFpbCBhcmUgc29sZWx5IHRob3NlIG9mIHRoZSBhdXRob3Ig
YW5kIG1heSBub3QgbmVjZXNzYXJpbHkgcmVmbGVjdCB0aGUKdmlld3Mgb3Igb3BpbmlvbnMgb2Yg
SENMIG9yIGl0cyBhZmZpbGlhdGVzLiBBbnkgZm9ybSBvZiByZXByb2R1Y3Rpb24sIGRpc3NlbWlu
YXRpb24sIGNvcHlpbmcsIGRpc2Nsb3N1cmUsIG1vZGlmaWNhdGlvbiwKZGlzdHJpYnV0aW9uIGFu
ZCAvIG9yIHB1YmxpY2F0aW9uIG9mIHRoaXMgbWVzc2FnZSB3aXRob3V0IHRoZSBwcmlvciB3cml0
dGVuIGNvbnNlbnQgb2YgYXV0aG9yaXplZCByZXByZXNlbnRhdGl2ZSBvZgpIQ0wgaXMgc3RyaWN0
bHkgcHJvaGliaXRlZC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciBw
bGVhc2UgZGVsZXRlIGl0IGFuZCBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseS4KQmVmb3Jl
IG9wZW5pbmcgYW55IGVtYWlsIGFuZC9vciBhdHRhY2htZW50cywgcGxlYXNlIGNoZWNrIHRoZW0g
Zm9yIHZpcnVzZXMgYW5kIG90aGVyIGRlZmVjdHMuCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCg==


