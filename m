Return-Path: <mirela.rabulea@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
	(mail-db3on0060.outbound.protection.outlook.com [157.55.234.60])
	by mail.openembedded.org (Postfix) with ESMTP id 346D7731A8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Feb 2016 22:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
	s=selector1-nxp-com;
	h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
	bh=ovxrSPF25CHRHDelapcTxXW7SjjeQzTBnTbfpWplpq4=;
	b=t/dOBR1WTOLC5OMU85nfkJui/QbaNjIOHtV4W+N3c3No+eGmjfKC2Iizlfs0VPwqhzowfLEV6B1AOPqiaQhtsYDCxezrhy6uDBSVgNDbt/uFDLmpN+0mgU3a6FG8vNlsY35OogoKQGy7e+1DyoD01NPOB85+xcvr1iXknojeimE=
Received: from VI1PR0401MB1789.eurprd04.prod.outlook.com (10.165.234.151) by
	DB3PR04MB0585.eurprd04.prod.outlook.com (10.160.44.147) with Microsoft
	SMTP Server (TLS) id 15.1.409.15; Tue, 16 Feb 2016 22:09:53 +0000
Received: from VI1PR0401MB1789.eurprd04.prod.outlook.com ([10.165.234.151]) by
	VI1PR0401MB1789.eurprd04.prod.outlook.com ([10.165.234.151]) with
	mapi id 15.01.0409.017; Tue, 16 Feb 2016 22:09:53 +0000
From: Mirela Rabulea <mirela.rabulea@nxp.com>
To: Joshua G Lock <joshua.g.lock@linux.intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] Fix bug 8940 - Alow Hob to run images on
	a custom simulator, other than qemu
Thread-Index: AdFUYtl3YI4m24hVQ1y2SKaptI//vAEqJteAAYcSAQABR/CXgAAYZWPAAE51+FAAY8Ge4ABYib2AAAu+B+A=
Date: Tue, 16 Feb 2016 22:09:53 +0000
Message-ID: <VI1PR0401MB1789CE1105762A738D1777F98FAD0@VI1PR0401MB1789.eurprd04.prod.outlook.com>
References: <AM4PR0401MB1778CA63CBE3FE654CB9EDC78FC30@AM4PR0401MB1778.eurprd04.prod.outlook.com>
	<1453903391.3557.42.camel@linux.intel.com>
	<VI1PR0401MB1789EE35802D99452B8F12638FD10@VI1PR0401MB1789.eurprd04.prod.outlook.com>
	<1455138641.3442.8.camel@linux.intel.com>
	<VI1PR0401MB178927E4A92EFB4DC3E706978FA80@VI1PR0401MB1789.eurprd04.prod.outlook.com>
	<VI1PR0401MB17898F62326CD302A05CD3F38FA90@VI1PR0401MB1789.eurprd04.prod.outlook.com>
	<VI1PR0401MB1789BE8BA7AD90A09B2C23E18FAB0@VI1PR0401MB1789.eurprd04.prod.outlook.com>
	<1455638835.3731.8.camel@linux.intel.com>
In-Reply-To: <1455638835.3731.8.camel@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
	header.d=none; linux.intel.com;
	dmarc=none action=none header.from=nxp.com; 
x-originating-ip: [192.88.146.1]
x-microsoft-exchange-diagnostics: 1; DB3PR04MB0585;
	5:Y2kslJk1n7JEtfcEC/jxbzY8QnzGiMhMypA4sXmBqvzW2VrQzXeVd+JuDvNKeDPKrhtPDrasb+dAb58RWR+qpe5ANvnKYrao5PVXo0ZmoGxZxn12bvXm+i7xIMX7NzhPveQPBPwGOGl/qcHX/6fdjA==;
	24:GGyDcANAdnB2RLLhuPZ8SdJWueDkUAe2rbrGRz2WxePwWOcqgbkrzV5kBAY0qajzWgrybSa8i2pTBZwb9MupUeVaV2er7NlGxz35o3BCMOg=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DB3PR04MB0585;
x-ms-office365-filtering-correlation-id: 403926ef-2231-4aca-91b4-08d3371de599
x-microsoft-antispam-prvs: <DB3PR04MB05859945223362E1971DAFFE8FAD0@DB3PR04MB0585.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);
	SRVR:DB3PR04MB0585; BCL:0; PCL:0; RULEID:; SRVR:DB3PR04MB0585; 
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(6009001)(377454003)(13464003)(164054003)(93886004)(3846002)(102836003)(6116002)(54356999)(50986999)(189998001)(76176999)(92566002)(122556002)(4326007)(586003)(2501003)(10400500002)(2950100001)(86362001)(2906002)(5001960100002)(77096005)(5004730100002)(2900100001)(40100003)(76576001)(19580395003)(33656002)(5003600100002)(1096002)(19580405001)(5008740100001)(87936001)(1220700001)(5002640100001)(5001770100001)(74316001)(11100500001)(66066001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR04MB0585;
	H:VI1PR0401MB1789.eurprd04.prod.outlook.com; FPR:; SPF:None;
	MLV:sfv; LANG:en; 
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2016 22:09:53.2497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR04MB0585
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
X-List-Received-Date: Tue, 16 Feb 2016 22:09:55 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSm9zaHVhLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvc2h1
YSBHIExvY2sgW21haWx0bzpqb3NodWEuZy5sb2NrQGxpbnV4LmludGVsLmNvbV0NCj4gU2VudDog
VHVlc2RheSwgRmVicnVhcnkgMTYsIDIwMTYgNjowNyBQTQ0KDQo+IA0KPiBUaGlzIHZlcnNpb24g
c2VlbXMgdG8gd29yayBtdWNoIGJldHRlciwgdGhhbmtzLg0KPiANCj4gSSd2ZSBoYWQgYW5vdGhl
ciBsb29rIG92ZXIgdGhlIHBhdGNoIGFuZCBpdCBsb29rcyBPSyB0byBtZS4gVGhlIG9ubHkgdGhp
bmcNCj4gd2hpY2ggc2VlbXMgYSBsaXR0bGUgc3RyYW5nZSBpcyB0aGF0IGluIHNldmVyYWwgcGFy
dHMgb2YgdGhlIHBhdGNoIHlvdSdyZQ0KPiBhY2Nlc3NpbmcgYW5kIHNldHRpbmcgYSBzZWxmLmlz
X3J1bm5hYmxlIHByb3BlcnR5IGJ1dCBhdCBMbiAyMTcsIExuIDIyMCAmIExuDQo+IDIzNyBpbiBJ
bWFnZURldGFpbHNQYWdlwqB5b3UncmUgdXNpbmcgYSBsb2NhbCB2YXJpYWJsZSBjYWxsZWQgaXNf
cnVubmFibGUg4oCUIGlzDQo+IHRoYXQgY29ycmVjdC9pbnRlbmRlZD8NCj4gDQoNClRoZSBsb2Nh
bCB2YXJpYWJsZSAiaXNfcnVubmFibGUiIHdhcyB1c2VkIGluIGNyZWF0ZV9ib3R0b21fYnV0dG9u
cygpLCBJIGRpZCBub3QgY2hhbmdlIHRoaXMuIEkganVzdCBzYXZlZCB0aGUgcmV0dXJuIHZhbHVl
IG9mIGNyZWF0ZV9ib3R0b21fYnV0dG9ucygpIGluIHNlbGYuaXNfcnVubmFibGUgcHJvcGVydHks
IGluc3RlYWQgb2YgYW5vdGhlciBsb2NhbCwgc28gdGhhdCBJIGNhbiB1c2UgdGhlIHByb3BlcnR5
IGxhdGVyLCBsaWtlIGluIHJ1bl9idXR0b25fY2xpY2tlZF9jYigpLiBUaGlzIHdhcyBteSBpbnRl
bnRpb24uDQoNClRoYW5rcywNCk1pcmVsYQ0K

