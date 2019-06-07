Return-Path: <Leif.Middelschulte@klsmartin.com>
Received: from ironport.klsmartin.com (ironport.klsmartin.com [212.211.191.11])
	by mail.openembedded.org (Postfix) with ESMTP id 07C026BE39
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2019 09:47:45 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.63,562,1557180000"; 
   d="scan'208";a="1836497"
Received: from unknown (HELO hera.klsmartin.com) ([172.30.5.66])
	by ironport.klsmartin.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
	07 Jun 2019 11:47:46 +0200
Received: from SUMMAIL01.UMK.KLS.zentral ([172.25.1.63])
	by hera.klsmartin.com (8.14.3/8.13.1/SuSE Linux 0.7) with ESMTP id
	x579lZC4014582; Fri, 7 Jun 2019 11:47:37 +0200
Received: from SUMMBX01.UMK.KLS.zentral ([172.25.1.64]) by
	SUMMAIL01.UMK.KLS.zentral ([172.25.1.63]) with mapi id 14.03.0408.000;
	Fri, 7 Jun 2019 11:47:41 +0200
From: "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>
To: "olof.johansson@axis.com" <olof.johansson@axis.com>
Thread-Topic: [bitbake-devel] [PATCH 0/1] bitbake: fetch2/git: fix initial
	http authed clone
Thread-Index: AQHVGu7e9u9w82scP0eX/XBQOXQ4TaaLoWOAgAQzOIA=
Date: Fri, 7 Jun 2019 09:47:47 +0000
Message-ID: <8b8019b30018c147bbfbd40d80cbdc4b00fe936f.camel@klsmartin.com>
References: <20190604160137.5636-1-leif.middelschulte@klsmartin.com>
	<20190604173859.napxayq2tbfvgcx2@axis.com>
In-Reply-To: <20190604173859.napxayq2tbfvgcx2@axis.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.2.60]
x-kse-serverinfo: SUMMAIL01.UMK.KLS.zentral, 9
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 07.06.2019 02:28:00
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/1] bitbake: fetch2/git: fix initial http authed clone
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
X-List-Received-Date: Fri, 07 Jun 2019 09:47:46 -0000
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-ID: <66FEC93B8D98EB4A93013B3A1A21D309@klsmartin.de>
Content-Transfer-Encoding: base64

SGVsbG8gT2xvZiwNCg0KdGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KSSBhcHBvbG9naXplIGZv
ciB0aGUgbGF0ZSByZXBseSwgSSB3YXMgb3V0IG9mIG9mZmljZS4NCg0KQW0gRGllbnN0YWcsIGRl
biAwNC4wNi4yMDE5LCAxOTozOCArMDIwMCBzY2hyaWViIE9sb2YgSm9oYW5zc29uOg0KPiBPbiAx
OS0wNi0wNCAxODowMSArMDIwMCwgTGVpZiBNaWRkZWxzY2h1bHRlIHdyb3RlOg0KPiA+IFRoaXMg
cGF0Y2ggZml4ZXMgaW5pdGlhbCBjbG9uZXMgb2YgZ2l0IHJlcG9zaXRvcmllcyBhdXRoZW50aWNh
dGVkDQo+ID4gdmlhIGJhc2ljIGh0dHAgYXV0aGVudGljYXRpb24uIFRoaXMgYmVjYW1lIGFwcGFy
ZW50IHdoZW4gY29kZSB3YXMNCj4gPiByZXVzZWQgdG8gY2xvbmUgc3VibW9kdWxlcyB0b28uDQo+
ID4gDQo+ID4gVGhlIG1ldGhvZCBpcyB0aGUgcmVjb21tZW5kZWQgd2F5IG9mIGNsb25pbmcgc291
cmNlIGNvZGUgYnkgQ0kNCj4gPiBydW5uZXJzLiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBjdXJyZW50
bHkgYnJva2VuIGJlaHZpb3IuDQo+IA0KPiBIaSwNCj4gDQo+IFJlY29tbWVuZGVkIGJ5IHdob20g
c3BlY2lmaWNhbGx5Pw0KQnkgInJlY29tbWVuZGVkIiwgSSB3YXMgcmVmZXJyaW5nIHRvIGNsb25p
bmcgc291cmNlIGNvZGUgdmlhIEhUVFBzDQp3aXRoaW4gQ0lzLCBieSB1c2luZyBkeW5hbWljYWxs
eSBjcmVhdGVkL3ZhbGlkIHRva2VuczoNCmh0dHBzOi8vZG9jcy5naXRsYWIuY29tL2VlL2NpL3Ry
aWdnZXJzL1JFQURNRS5odG1sI2NpLWpvYi10b2tlbg0KDQpJIHdhcyBub3QgcmVmZXJyaW5nIHRv
IHRoZSBVUkkgc2NoZW1lIHNwZWNpZmljYWxseS4NCg0KPiBFbmNvZGluZyBwYXNzd29yZHMgaW4g
VVJJcyB3YXMNCj4gZGVwcmVjYXRlZCBSRkMgMzk4NiBmb3Igc2VjdXJpdHkgcmVhc29ucy4gU29t
ZSB0b29scyBtYXkgbm90IGJlDQo+IGF3YXJlIG9mIHNlY3VyaXR5IHNlbnNpdGl2ZSBpbmZvcm1h
dGlvbiBjb250YWluZWQgaW4gVVJJcy4NCj4gDQo+IFJGQyAzOTg2Og0KPiA+IEFwcGxpY2F0aW9u
cyBzaG91bGQgbm90IHJlbmRlciBhcyBjbGVhciB0ZXh0IGFueSBkYXRhIGFmdGVyIHRoZQ0KPiA+
IGZpcnN0IGNvbG9uICgiOiIpIGNoYXJhY3RlciBmb3VuZCB3aXRoaW4gYSB1c2VyaW5mbw0KPiA+
IHN1YmNvbXBvbmVudCAuLi4NCj4gDQo+IEhhdmluZyBwYXNzd29yZHMgYW5kIHNlY3VyaXR5IHNl
bnNpdGl2ZSBpbmZvIGluIHRoZSBiaXRiYWtlDQo+IG1ldGFkYXRhIGFsc28gc2VlbXMgYSBiaXQg
d2VpcmQgdG8gbWUsIGJ1dCBiYi5mZXRjaDIuZGVjb2RldXJsKCkNCj4gZG9lcyBzdXBwb3J0IGV4
dHJhY3RpbmcgaXQuIA0KSSdtIHdoaXRlbGlzdGluZyBhbiBlbnZpcm9ubWVudCB2YXJpYWJsZSAo
Q0lfSk9CX1RPS0VOKSBiZWZvcmUgSQ0Kc291cmNlIGEgYml0YmFrZSBlbnZpcm9ubWVudC4gU28g
dGhlIGNyZWRlbnRpYWxzIGFyZSBub3QgaGFyZC1jb2RlZCwNCmJ1dCB1c2UgdGhlIGZvbGxvd2lu
ZyBmb3JtYXQgd2l0aGluIFNSQ19VUklzOg0KdXNlcj1naXRsYWItY2ktcnVubmVyOiR7Q0lfSk9C
X1RPS0VOfTtwcm90b2NvbD1odHRwcw0KSXQgdXNlZCB0byBiZSBzdXBwb3J0ZWQgKHJvY2tvKS4g
QXBwYXJlbnRseSB1bmludGVuZGVkLiBJdCB3YXMganVzdCB0aGlzDQpiZWhhdmlvcmFsIGJyZWFr
IChpbiB3YXJyaW9yKSB0aGF0IGxlYWQgbWUgY3JlYXRpbmcgdGhpcyBwYXRjaC4NCg0KPiBJIHRo
b3VnaHQgdGhlIGdpdCBmZXRjaGVyIGRpZG4ndA0KPiBzdXBwb3J0IGF1dGggZGV0YWlscyAob3Ro
ZXIgdGhhbiB1c2VyKSB2aWEgdGhlIFVSSSBieSBkZXNpZ24sIGJ1dA0KPiB0aGlzIGlzIGp1c3Qg
bXkgYXNzdW1wdGlvbi4NCkFGQUlDUyBnaXQgaW5kZWVkIHN1cHBvcnRzIHNwZWNpZnlpbmcgY29t
cGxldGUgY3JlZGVudGlhbHMgYXMgdmlhDQp0aGUgVVJJLg0KPiANCj4gVGhlIGdpdGNyZWRlbnRp
YWxzIG1hbnBhZ2UgcmVjb21tZW5kcyB1c2luZyB0aGUgZ2xvYmFsDQo+IGNvbmZpZ3VyYXRpb24g
d2l0aCBbY3JlZGVudGlhbC48dXJpLXBhdHRlcm4+XSBibG9ja3MgdG8gc3BlY2lmeQ0KPiB0aGlz
IGluc3RlYWQuDQo+IA0KPiBodHRwczovL2dpdC1zY20uY29tL2RvY3MvZ2l0Y3JlZGVudGlhbHMN
Cj4gDQoNClRoYW5rIHlvdSBmb3IgdGhlIGhpbnQuIEknbGwgdXNlIGdpdCdzIG5hdGl2ZSBpbnRl
Z3JhdGlvbiB0aGVuWzBdLg0KDQpGb3IgdGhlIHJlY29yZDoNCmdpdCBjb25maWcgLS1nbG9iYWwg
Y3JlZGVudGlhbC5odHRwczovL2dpdGxhYi5leGFtcGxlLmNvbS51c2VybmFtZSBnaXRsYWItY2kt
dG9rZW4NCmdpdCBjb25maWcgLS1nbG9iYWwgY3JlZGVudGlhbC5odHRwczovL2dpdGxhYi5leGFt
cGxlLmNvbS5oZWxwZXIgJyFmKCkgeyBlY2hvICJwYXNzd29yZD1gZWNobyAkQ0lfSk9CX1RPS0VO
YCI7IH07IGYnDQoNClswXSBodHRwczovL2dpdC1zY20uY29tL2RvY3MvYXBpLWNyZWRlbnRpYWxz
I19jcmVkZW50aWFsX2hlbHBlcnMNCg0KU28gZmVlbCBmcmVlIHRvIGp1c3QgZHJvcCB0aGlzIHBh
dGNoLg0KDQpBZ2FpbiB0aGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KLS0gDQpCZXN0IFJlZ2Fy
ZHMsDQoNCktMUyBNYXJ0aW4gR21iSCArIENvLiBLRywNCkEgS0xTIE1hcnRpbiBHcm91cCBjb21w
YW55DQogDQpMZWlmIE1pZGRlbHNjaHVsdGUNClNvZnR3YXJlIERldmVsb3BtZW50IEVuZ2luZWVy
DQoNCktMUyBNYXJ0aW4gR21iSCArIENvLiBLRyANCkFtIEZsdWdoYWZlbiAxOCAgNzkxMDggRnJl
aWJ1cmcgaW0gQnJlaXNnYXUgLyBHZXJtYW55DQpUZWxlZm9uICs0OSAoNzYxKSA1NTcgOTk3LTU0
MyAgIEZheCArNDkgKDc2MSkgNTU3IDk5Ny01MjAgDQpsZWlmLm1pZGRlbHNjaHVsdGVAa2xzbWFy
dGluLmNvbTsgd3d3Lmtsc21hcnRpbi5jb20NCg0KUmVnaXN0ZXJnZXJpY2h0OiBGcmVpYnVyZyBp
bSBCcmVpc2dhdTsgSGFuZGVsc3JlZ2lzdGVyOiBIUkEgNDA0NCANCkdlc2Now6RmdHNmw7xocmVy
OiBNaWNoYWVsIE1hcnRpbiwgS2FybCBMZWliaW5nZXIsIENocmlzdGlhbiBMZWliaW5nZXIgDQpQ
ZXJzw7ZubGljaCBoYWZ0ZW5kZSBHZXNlbGxzY2hhZnRlcmluOiBLTFMgTWFydGluIFZlcndhbHR1
bmdzZ2VzZWxsc2NoYWZ0IG1iSCANClJlZ2lzdGVyZ2VyaWNodDogU3R1dHRnYXJ0OyBIYW5kZWxz
cmVnaXN0ZXI6IEhSQiA0NTEzMTYgDQpVU3QuLUlkLU5yLiBERSAyMzc0NjcyODAgDQoNCkRpZXNl
IEUtTWFpbCBlbnRow6RsdCB2ZXJ0cmF1bGljaGUgdW5kLyBvZGVyIHJlY2h0bGljaCBnZXNjaMO8
dHp0ZSBJbmZvcm1hdGlvbmVuLiBXZW5uIFNpZSBuaWNodCBkZXIgcmljaHRpZ2UgQWRyZXNzYXQg
c2luZCBvZGVyIGRpZXNlIEUtTWFpbCBpcnJ0w7xtbGljaCBlcmhhbHRlbiBoYWJlbiwgaW5mb3Jt
aWVyZW4gU2llIGJpdHRlIHNvZm9ydCBkZW4NCkFic2VuZGVyIHVuZCB2ZXJuaWNodGVuIFNpZSBk
aWVzZSBNYWlsLiBEYXMgdW5lcmxhdWJ0ZSBLb3BpZXJlbiBzb3dpZSBkaWUgdW5iZWZ1Z3RlIFdl
aXRlcmdhYmUgZGllc2VyIE1haWwgaXN0IG5pY2h0IGdlc3RhdHRldC4gDQoNClRoaXMgZS1tYWls
IG1heSBjb250YWluIGNvbmZpZGVudGlhbCBhbmQvb3IgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbi4g
SWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCAob3IgaGF2ZSByZWNlaXZlZCB0
aGlzIGUtbWFpbCBpbiBlcnJvcikgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5
IGFuZCBkZXN0cm95IHRoaXMNCmUtbWFpbC4gQW55IHVuYXV0aG9yaXplZCBjb3B5aW5nLCBkaXNj
bG9zdXJlIG9yIGRpc3RyaWJ1dGlvbiBvZiB0aGUgbWF0ZXJpYWwgaW4gdGhpcyBlLW1haWwgaXMg
c3RyaWN0bHkgZm9yYmlkZGVuLg0K

