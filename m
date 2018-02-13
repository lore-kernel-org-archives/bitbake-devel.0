Return-Path: <mvader@victronenergy.com>
X-Greylist: delayed 135642 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 13 Feb 2018 12:46:26 UTC
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr20102.outbound.protection.outlook.com [40.107.2.102])
	by mail.openembedded.org (Postfix) with ESMTP id 1410E71B31
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Feb 2018 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=VICTRONENERGY.onmicrosoft.com; s=selector1-victronenergy-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
	bh=GsqbE9UVon7EeFP/7WD8I/AePJnFV4+3bLqh+wj6qN0=;
	b=gJgCRiU449or0mMVFeWRV/kqnVq7uZc08OvQasZanwVPJpLAzNnbvPPg7jqrdEIwTcSC/o9JVGUJOhktPMptzkWO85hf+zxLsVNMwmqc/JiiHwm6GC9EPvFPrUeUjpFes07jXCPD1mG6eBMz/igxSaoViETX2vNJAoUrUCPWLmk=
Received: from HE1PR07MB1436.eurprd07.prod.outlook.com (10.169.122.22) by
	HE1PR07MB0873.eurprd07.prod.outlook.com (10.162.24.22) with Microsoft
	SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
	15.20.506.7; Tue, 13 Feb 2018 12:46:26 +0000
Received: from HE1PR07MB1436.eurprd07.prod.outlook.com
	([fe80::fce3:9070:a9a8:6b9a]) by
	HE1PR07MB1436.eurprd07.prod.outlook.com
	([fe80::fce3:9070:a9a8:6b9a%14]) with mapi id 15.20.0506.013;
	Tue, 13 Feb 2018 12:46:25 +0000
From: Matthijs Vader <mvader@victronenergy.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] fetch2/npm.py: Fix inverted condition to prevent
	infinite loop
Thread-Index: AdOkyByjrFIsp0rNRSC0pOitpXVCkg==
Date: Tue, 13 Feb 2018 12:46:25 +0000
Message-ID: <HE1PR07MB1436A7A119C97309A002C132C5F60@HE1PR07MB1436.eurprd07.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.126.8.10]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR07MB0873;
	6:HdVzqdd+QdKLxofB5xlORZmdBTSGPNpN3jddXz12pAKmtQXeceA/0dtJ1OcV4BOzGhbbAGpbTuKJH9uZxBdhC1eMHfCRpRwxnmsIXMKKpK54O7aA+IqXDaHReWph9osM/dGNKVe5nXA2ok628jUnWSgSywgKrmZSGY4BBSDxBgbArH7yxd5s6olMLcQqVFMS5neEYcz+rM6EqgOcPticeI9dd+O17uGKzV/u8KQ7Ys6UPlDspeHAYeIXJvJZue+mFiTDHpt6ZV7Ae1cmMaVo4rEXofe017EUUDMRMCZF41L6/uUW+xrYs1dt+0X5hxXWyJ/9Rj2QP4E9csyZ/hMeT9srQ4RuJDi+slWbvN1lNJt2G6Pm9eKLkdqMYbBYXNFn;
	5:WqZ3sL4ntQtpFSxEN04wcPsk3YmoGhthr2emTmhUxEiGRkRgvu1KJJ0XboM2HrVGAXZZ3y0uTcwoaq/pC5BuTdqRprsUhg0PSdvFqVZ0OaMaYdht0eWpSh9tEPbJlOIv1+3guDHIoIpgeMpezZ318zAUnol4U0GwMSikIt51jVI=;
	24:f18+ChUXarwwL68AUgxkd4NZTz3R4TwAbziAFORw59ZYNJAOX8R85jWAh0fvKSZ9c+1styBzHAWyKgQFdMzKEE/vU5CodoEzhLbEto1NbiM=;
	7:a0fhCrMe7DN1rvHaP4x0UlkSEtokhHy4Q2Vr4stWOrrVDlS3zw5AmFd+cXhUvI1TAApjFcyHegbkI1Awh8SxLIcFjBb8hQCTcP2zsw+Jc+xToyqzhkHmvGGgQy+jPkwVotVvMToXOBcrNFMJY7BNwQqiCAXDF4AYs+LS0ZtfbRHwfU7d5kbqIkKyS+NYsiu7qnJw9Mt09ROEm8xCTumS8CfM93oXQ5/8c5IUWFSXZxEJK6op+VWXwv0HJzAHAFub
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 777f8f27-4d0e-4b39-e1b9-08d572dfcb7b
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);
	SRVR:HE1PR07MB0873; 
x-ms-traffictypediagnostic: HE1PR07MB0873:
x-microsoft-antispam-prvs: <HE1PR07MB0873E1844513361D13ABA071C5F60@HE1PR07MB0873.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(944501161)(3002001)(93006095)(93001095)(6041288)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
	SRVR:HE1PR07MB0873; BCL:0; PCL:0; RULEID:; SRVR:HE1PR07MB0873; 
x-forefront-prvs: 0582641F53
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(39850400004)(366004)(396003)(39380400002)(189003)(199004)(14454004)(7736002)(68736007)(316002)(3280700002)(229853002)(3660700001)(8936002)(74316002)(66066001)(3846002)(9686003)(8676002)(2501003)(81156014)(86362001)(5250100002)(99286004)(6246003)(2906002)(81166006)(6116002)(53936002)(55016002)(7696005)(33656002)(6506007)(2351001)(4326008)(6436002)(25786009)(5640700003)(102836004)(6346003)(6916009)(26005)(97736004)(5660300001)(2900100001)(305945005)(105586002)(478600001)(186003)(106356001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR07MB0873;
	H:HE1PR07MB1436.eurprd07.prod.outlook.com; FPR:; SPF:None;
	PTR:InfoNoRecords; MX:1; A:1; LANG:en; 
received-spf: None (protection.outlook.com: victronenergy.com does not
	designate permitted sender hosts)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=mvader@victronenergy.com; 
x-microsoft-antispam-message-info: 09RLSXXUQ6anwzP7rWkdVSsmaPyHBq4hcVjCGLTfsvE+S5OF4AvXjCOLYUVV1d3Wm/wjRcU7t/uRJsO3/UtEPg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777f8f27-4d0e-4b39-e1b9-08d572dfcb7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2018 12:46:25.9491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB0873
Subject: Re: [PATCH] fetch2/npm.py: Fix inverted condition to prevent infinite loop
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
X-List-Received-Date: Tue, 13 Feb 2018 12:46:27 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgQsO2c3rDtnJtw6lueWkgWm9sdMOhbiwNCg0KT24gU3VuZGF5IEZlYiA0dGgsIHlvdSB3cm90
ZToNCiANCj4gQXQgbGVhc3QgdGhlIGNsaS1jb2xvciBub2RlIG1vZHVsZSBoYXMgZGVwZW5kZW5j
aWVzIHRoYXQgaGF2ZSBjeWNsaWMNCj4gZGVwZW5kZW5jeSBhbW9uZyB0aGVtc2VsdmVzLiBucG0u
cHkgaXMgcHJlcGFyZWQgdG8gZGVhbCB3aXRoIHN1Y2ggYSBjYXNlDQo+IGJ1dCB0aGUgY29uZGl0
aW9uIGlzIGhhbmRsZWQgb25seSBmb3IgZG93bmxvYWRpbmcgb3Igbm90IGEgZGVwZW5kZW5jeQ0K
PiBhZ2FpbiwgYnV0IHRoZW4gaXQgZ29lcyBjaGVja2luZyB0aGUgaXRzIGRlcGVuZGVuY3kgd2hp
Y2ggY2F1c2VzIGFuIGluZmluaXRlDQo+IGxvb3AgaW4gX2dldGRlcGVuZGVuY2llcygpLg0KPiBN
YWtlIHRoaXMgZnVuY3Rpb24gc2ltcGx5IHJldHVybiB3aGVuIGEgZGVwZW5kZW5jeSBpcyBhbHJl
YWR5IGRvd25sb2FkZWQNCj4gYW5kIG9ubHkgZG93bmxvYWQgYW5kIGNoZWNrIGl0cyBkZXBlbmRl
bmNpZXMgd2hlbiBub3QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBab2x0w6FuIELDtnN6w7ZybcOp
bnlpIDx6Ym9zem9yQHByLmh1Pg0KPiAtLS0NCj4gICBsaWIvYmIvZmV0Y2gyL25wbS5weSB8IDgg
KysrKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2xpYi9iYi9mZXRjaDIvbnBtLnB5IGIvbGliL2JiL2Zl
dGNoMi9ucG0ucHkgaW5kZXgNCj4gYjVmMTQ4Y2EuLjczMGMzNDZhIDEwMDY0NA0KPiAtLS0gYS9s
aWIvYmIvZmV0Y2gyL25wbS5weQ0KPiArKysgYi9saWIvYmIvZmV0Y2gyL25wbS5weQ0KPiBAQCAt
MTk1LDkgKzE5NSwxMSBAQCBjbGFzcyBOcG0oRmV0Y2hNZXRob2QpOg0KPiAgICAgICAgICAgb3V0
cHV0dXJsID0gcGRhdGFbJ2Rpc3QnXVsndGFyYmFsbCddDQo+ICAgICAgICAgICBkYXRhW3BrZ10g
PSB7fQ0KPiAgICAgICAgICAgZGF0YVtwa2ddWyd0Z3onXSA9IG9zLnBhdGguYmFzZW5hbWUob3V0
cHV0dXJsKQ0KPiAtICAgICAgICBpZiBub3Qgb3V0cHV0dXJsIGluIGZldGNoZWRsaXN0Og0KPiAt
ICAgICAgICAgICAgc2VsZi5fcnVud2dldCh1ZCwgZCwgIiVzIC0tZGlyZWN0b3J5LXByZWZpeD0l
cyAlcyIgJSAoc2VsZi5iYXNlY21kLCB1ZC5wcmVmaXhkaXIsIG91dHB1dHVybCksIEZhbHNlKQ0K
PiAtICAgICAgICAgICAgZmV0Y2hlZGxpc3QuYXBwZW5kKG91dHB1dHVybCkNCj4gKyAgICAgICAg
aWYgb3V0cHV0dXJsIGluIGZldGNoZWRsaXN0Og0KPiArICAgICAgICAgICAgcmV0dXJuDQo+ICsN
Cj4gKyAgICAgICAgc2VsZi5fcnVud2dldCh1ZCwgZCwgIiVzIC0tZGlyZWN0b3J5LXByZWZpeD0l
cyAlcyIgJQ0KPiArIChzZWxmLmJhc2VjbWQsIHVkLnByZWZpeGRpciwgb3V0cHV0dXJsKSwgRmFs
c2UpDQo+ICsgICAgICAgIGZldGNoZWRsaXN0LmFwcGVuZChvdXRwdXR1cmwpDQo+ICAgICAgICAg
ICAgZGVwZW5kZW5jaWVzID0gcGRhdGEuZ2V0KCdkZXBlbmRlbmNpZXMnLCB7fSkNCj4gICAgICAg
ICAgIG9wdGlvbmFsRGVwZW5kZW5jaWVzID0gcGRhdGEuZ2V0KCdvcHRpb25hbERlcGVuZGVuY2ll
cycsIHt9KQ0KPiAtLQ0KPiAyLjE0LjMNCg0KSSB0ZXN0ZWQgeW91ciBjaGFuZ2UsIGFuZCBpdCB3
b3JrcyBPSyAmIGZpeGVzIHRoZSBwcm9ibGVtIG9uIGNsaS1jb2xvci4NCg0KTWF0dGhpanMuDQoN
Cg==

