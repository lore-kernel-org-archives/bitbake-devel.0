Return-Path: <mirela.rabulea@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
	(mail-db3on0093.outbound.protection.outlook.com [157.55.234.93])
	by mail.openembedded.org (Postfix) with ESMTP id 5F25A731E7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Feb 2016 11:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
	s=selector1-nxp-com;
	h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
	bh=sf4AmQlizmRgZKpySN+wD6lb4iNKBj090pRrkRHioHk=;
	b=xGUSs0H9NOWuDxaL5ROtcTmd3E2aTxf3yWFCtnHQKCi3vDv28jB8lS9iJYNyREzkEJxfY8GX0WEP1C5YOwFPiNsZ1AgyMSLs/w2Pq48GCus1JkhkOOXlFmBRThqIIoikpaQdobA0AZdIvSiF0lojHnba9++4kE3orJmnlNpxnvs=
Received: from VI1PR0401MB1789.eurprd04.prod.outlook.com (10.165.234.151) by
	AM3PR04MB0583.eurprd04.prod.outlook.com (10.141.47.152) with Microsoft
	SMTP Server (TLS) id 15.1.403.16; Thu, 11 Feb 2016 11:19:14 +0000
Received: from VI1PR0401MB1789.eurprd04.prod.outlook.com ([10.165.234.151]) by
	VI1PR0401MB1789.eurprd04.prod.outlook.com ([10.165.234.151]) with
	mapi id 15.01.0403.017; Thu, 11 Feb 2016 11:19:13 +0000
From: Mirela Rabulea <mirela.rabulea@nxp.com>
To: Joshua G Lock <joshua.g.lock@linux.intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] Fix bug 8940 - Alow Hob to run images on
	a custom simulator, other than qemu
Thread-Index: AdFUYtl3YI4m24hVQ1y2SKaptI//vAEqJteAAYcSAQABR/CXgAAYZWPA
Date: Thu, 11 Feb 2016 11:19:13 +0000
Message-ID: <VI1PR0401MB178927E4A92EFB4DC3E706978FA80@VI1PR0401MB1789.eurprd04.prod.outlook.com>
References: <AM4PR0401MB1778CA63CBE3FE654CB9EDC78FC30@AM4PR0401MB1778.eurprd04.prod.outlook.com>
	<1453903391.3557.42.camel@linux.intel.com>
	<VI1PR0401MB1789EE35802D99452B8F12638FD10@VI1PR0401MB1789.eurprd04.prod.outlook.com>
	<1455138641.3442.8.camel@linux.intel.com>
In-Reply-To: <1455138641.3442.8.camel@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
	header.d=none; linux.intel.com;
	dmarc=none action=none header.from=nxp.com; 
x-originating-ip: [192.88.146.1]
x-microsoft-exchange-diagnostics: 1; AM3PR04MB0583;
	5:42QJKfZuFonO5mjiW+MV4Lw64Dc37Tmfeiezsd0JJO2zpGvgZML3y2jd4HFdjchL4lIhztBbXrcn2R93JyC2RMiaQkuQfEMfBl75Sif8TBtqoxivhOFd5AXQaYs3u3jOCC/DKw4xV1azHahKhAwpxw==;
	24:6O9502Ffg2x4PxxPvMqSmMr1Zrz4Cue+NJNNCbWowXzCvf3wiCEnWEpONdnrbZ+W7ek6hCsJKll4Xebf9nQwBnFK25xCN/0cVnml8Z64BjQ=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0583;
x-ms-office365-filtering-correlation-id: 8ab4c8d0-66ac-496e-d05d-08d332d52bca
x-microsoft-antispam-prvs: <AM3PR04MB0583FE2D4002298795809D138FA80@AM3PR04MB0583.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);
	SRVR:AM3PR04MB0583; BCL:0; PCL:0; RULEID:; SRVR:AM3PR04MB0583; 
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(6009001)(43784003)(377454003)(164054003)(13464003)(55674003)(93886004)(92566002)(122556002)(3280700002)(50986999)(5003600100002)(586003)(76176999)(5001960100002)(102836003)(5002640100001)(54356999)(3660700001)(2900100001)(74316001)(2906002)(40100003)(66066001)(77096005)(1096002)(2950100001)(1220700001)(189998001)(5008740100001)(33656002)(4326007)(3846002)(19580395003)(19580405001)(10400500002)(5004730100002)(87936001)(6116002)(76576001)(2501003)(86362001)(5001770100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM3PR04MB0583;
	H:VI1PR0401MB1789.eurprd04.prod.outlook.com; FPR:; SPF:None;
	MLV:sfv; LANG:en; 
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2016 11:19:13.1631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0583
Cc: Nicolae Manescu <nicu.manescu@nxp.com>,
	Alexandru Purice <alexandru.purice@nxp.com>, "Roman,
	Alexandru CostinX" <alexandru.costinx.roman@intel.com>,
	"Voiculescu, BogdanX A" <bogdanx.a.voiculescu@intel.com>
Subject: Re: [PATCH] Fix bug 8940 - Alow Hob to run images on a custom simulator, other than qemu
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
X-List-Received-Date: Thu, 11 Feb 2016 11:19:16 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSm9zaHVhDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9zaHVh
IEcgTG9jayBbbWFpbHRvOmpvc2h1YS5nLmxvY2tAbGludXguaW50ZWwuY29tXQ0KPiBTZW50OiBX
ZWRuZXNkYXksIEZlYnJ1YXJ5IDEwLCAyMDE2IDExOjExIFBNDQo+IFRvOiBNaXJlbGEgUmFidWxl
YSA8bWlyZWxhLnJhYnVsZWFAbnhwLmNvbT47IGJpdGJha2UtDQo+IGRldmVsQGxpc3RzLm9wZW5l
bWJlZGRlZC5vcmcNCj4gQ2M6IFJvbWFuLCBBbGV4YW5kcnUgQ29zdGluWCA8YWxleGFuZHJ1LmNv
c3Rpbngucm9tYW5AaW50ZWwuY29tPjsNCj4gVm9pY3VsZXNjdSwgQm9nZGFuWCBBIDxib2dkYW54
LmEudm9pY3VsZXNjdUBpbnRlbC5jb20+OyBOaWNvbGFlDQo+IE1hbmVzY3UgPG5pY3UubWFuZXNj
dUBueHAuY29tPjsgQWxleGFuZHJ1IFB1cmljZQ0KPiA8YWxleGFuZHJ1LnB1cmljZUBueHAuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSF0gRml4IGJ1ZyA4OTQwIC0g
QWxvdyBIb2IgdG8gcnVuIGltYWdlcw0KPiBvbiBhIGN1c3RvbSBzaW11bGF0b3IsIG90aGVyIHRo
YW4gcWVtdQ0KPiANCj4gVGhlc2UgY2hhbmdlcyBsb29rIGdvb2QsIHRoYW5rcy4NCj4gDQoNClRo
YW5rcyBhZ2FpbiBmb3IgcmV2aWV3aW5nLg0KDQo+IEkndmUgdGVzdGVkIHRoaXMgcGF0Y2ggYSBj
b3VwbGUgb2Ygd2F5cy4gSWYgSSBsYXVuY2ggSG9iIGFuZCBwcmVzcyAiSW1hZ2VzIiB0bw0KPiBs
b2FkIGFuIGV4aXN0aW5nIGltYWdlIGZyb20gc29tZXdoZXJlIGluIG15IGZpbGVzeXN0ZW0gdGhp
bmdzIHNlZW0gdG8NCj4gd29yayBhcyBleHBlY3RlZC4NCj4gDQoNClRoaXMgaXMgdGhlIHdheSBJ
IHVzZWQgaXQgdG9vLCBhdCBsZWFzdCBmb3IgdGhlICJjdXN0b20iIGNhc2UuDQoNCj4gSG93ZXZl
ciBpZiBJIGJ1aWxkIGFuIGltYWdlIChjb3JlLWltYWdlLW1pbmltYWwpIGZvciBhIG5vbi1xZW11
IG1hY2hpbmUNCj4gKGdlbmVyaWN4ODYtNjQpLCBvbmNlIHRoZSBidWlsZCBpcyBkb25lIEkgY2Fu
IHNlZSAnUnVuIGN1c3RvbSBpbWFnZScNCj4gYnV0dG9uIChiZXR3ZWVuICdCdWlsZCBuZXcgaW1h
Z2UnIGFuZCAnRGVwbG95IGltYWdlJykuDQo+IA0KDQpJIG5ldmVyIHJlYWNoZWQgYSBzY2VuYXJp
byBpbiB3aGljaCAnRGVwbG95IGltYWdlJyBidXR0b24gYmVjYW1lIGF2YWlsYWJsZSwgSSBob3Bl
IHRoaXMgaXMgb2ssIEkgbWVhbiBydW4gYW5kIGRlcGxveSBhcmUgbm90IG11dHVhbGx5IGV4Y2x1
c2l2ZS4uLg0KDQo+IFRoZSAnUnVuIHNjcmlwdCcgYm94IGluZGljYXRlcyB0aGF0IHRoZSBzY3Jp
cHQgaXMgcG9pbnRpbmcgdG8gJ3J1bnFlbXUnDQoNClllcywgdGhpcyB3YXMgbXkgaW50ZW50aW9u
LCBhbHRob3VnaCB0aGUgdXNlciBzaG91bGQgcGljay11cCBoZXJlIGhpcyBvd24gc2NyaXB0LCB0
aGUgJ3J1bnFlbXUnIGlzIHNlcnZlZCBoZXJlIGFzIGFuIGV4YW1wbGUgdG8gc3RhcnQgd2l0aC4N
Cg0KPiBidXQgd2hlbiBJIGNsaWNrICdSdW4gY3VzdG9tIGltYWdlJyBJIGdldCBhIGRpYWxvZ3Vl
IGFza2luZyB0byAnU2VsZWN0IHRoZQ0KPiBpbWFnZSBmaWxlIHlvdSB3YW50IHRvIHJ1bjonIHdp
dGggJ0NhbmNlbCcgYW5kICdSdW4gaW1hZ2UnIGJ1dHRvbnMgYnV0DQo+IG5vdGhpbmcgbGlzdGlu
ZyBzZWxlY3RhYmxlIGltYWdlcyAoSSBldmVuIHRyaWVkIHJlc2l6aW5nIHRoZSBkaWFsb2d1ZSwg
dG8gbm8NCj4gYXZhaWwpLiBJZiBJIHByb2NlZWQgdG8gY2xpY2sgJ1J1biBpbWFnZScgYnV0dG9u
IHRoZSAnVXNiIGltYWdlIG1ha2VyJw0KPiBkaWFsb2d1ZSBpcyBwcmVzZW50ZWQuDQo+IA0KDQpU
aGF0IG11c3QgY29tZSBmcm9tIHBva3lcYml0YmFrZVxsaWJcYmJcdWlcY3J1bWJzXGltYWdlZGV0
YWlsc3BhZ2UucHksIHNob3dfYnVpbGRlZF9pbWFnZXNfZGlhbG9nKCkuIEknbSBub3Qgc3VyZSBo
b3cgSSBjYW4gcmVwcm9kdWNlIHRoaXMgd2l0aG91dCB3YWl0aW5nIGEgZGF5IHRvIGJ1aWxkIGFu
b3RoZXIgaW1hZ2UsIGFuZCB3aXRob3V0IHNvbWUgdGVucyBvZiBHQiB3aGljaCBJIGRvbid0IGtu
b3cgaWYgSSBoYXZlLiBJIHdpbGwgdHJ5IGl0IGJ1dCBpdCB3aWxsIHRha2UgYSB3aGlsZS4gSW4g
dGhlIG1lYW50aW1lLCBpZiB5b3Ugc3RpbGwgaGF2ZSB0aGUgZW52aXJvbm1lbnQsIGNvdWxkIHlv
dSBhZGQgdGhpcyBwcmludCBpbiB5b3VyIGltYWdlZGV0YWlsc3BhZ2UucHksIGl0IHdpbGwgbGV0
IHVzIHNlZSBob3cgbWFueSB0b2dnbGVkIGltYWdlcyB5b3UgaGF2ZSAoSSBzdXNwZWN0IGlzIG1v
cmUgdGhhbiAxKSwgYW5kIHdoaWNoIG9uZXMgKGl0IHNob3dzIHVwIGluIHRoZSB0ZXJtaW5hbCB3
aGVyZSBob2Igd2FzIHN0YXJ0ZWQpOg0KICAgICAgICAgICAgc2VsZi5pbWFnZV9zdG9yZS5hcHBl
bmQoeyduYW1lJzogaW1hZ2VfbmFtZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICd0eXBlJzogaW1hZ2VfdHlwZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICdzaXplJzogaW1hZ2Vfc2l6ZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICdpc190b2dnbGVkJzogaXNfdG9nZ2xlZCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICdhY3Rpb25fYXR0cic6IGltYWdlX2F0dHIsfSkNCg0KICAgICAgICAgICAgcHJp
bnQgImltYWdlX3N0b3JlLmFwcGVuZChpbWFnZV9uYW1lPSIsIGltYWdlX25hbWUsICIgaW1hZ2Vf
dHlwZT0iLCBpbWFnZV90eXBlLCAiIGltYWdlX3NpemU9IiwgaW1hZ2Vfc2l6ZSwgIiBpc190b2dn
bGVkPSIsIGlzX3RvZ2dsZWQsICIgaW1hZ2VfYXR0cj0iLCBpbWFnZV9hdHRyLCAiKSIgDQoNClRo
YW5rcywNCk1pcmVsYQ0K

