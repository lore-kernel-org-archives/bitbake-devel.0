Return-Path: <chris.laplante@agilent.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
	(mail-eopbgr760082.outbound.protection.outlook.com [40.107.76.82])
	by mail.openembedded.org (Postfix) with ESMTP id 272087F7E9;
	Wed, 11 Dec 2019 15:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=Sip0wQ1FjuJ58/riTVwKSjklrdl6oKWpdHoPVjXhm7ys0CE7ypQvLlhtTYyvasRs2qnjY5A0aaHXisx5OPnejB0oDc5wzHq4328Ief5ZOw70Y6VLHNVRyKSewJQw42oH8Ga6ZPLrY51WOsQqQU1zHROaEAu8WljHfxoMdbiEhpHmm9vb9FPz5Q/YCv0ty4jvld2xwIc6a3+a9anJU2U65i/UmeOg6m6a8MQXYr9iUgk4KCKp6/ntIsniw6RKTBs3Sto+vlLDkZ7Fq8tk742j5D+A8+20zEOmvQfd3WIIpQq0gfamakhVNeveT46HmIiMjaGZ5LPHafGHVdK+sYMY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=tgXwSChr9Kdg+1vbvudq6DIImpIT+YrZm4l5YW2FeM4=;
	b=Pe87St40hjQiArVhd0CmqFYKi8khSHykALm/d0aLqEY1VssKI9XKvi8N4jACbCAgHCb2zKujOzUOUYML3zAT1y/JXdvcAJfnE7SUJ0Gkeepkcd/KC8agJnVaYXby9a4+rv0ymQn9JsXaiI24mt6NbGOQhRQmFIvKfPo2b3kg2aJ/r1IYuPJVDJYjWpD/K2U3O8kQUJTCBF1jigbuFty8F8J/liPt9h1ayjcjkHUGKPrBuA+bbkexZma+IhwU/eAYIgi/PzaKy7pLx6fGMnBE9Tyvu6kolpK/U08uETK0fur7ia4A5czT7KWsOAm88s8Ss0DwUSmPYrvk1wVi4dx7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=tgXwSChr9Kdg+1vbvudq6DIImpIT+YrZm4l5YW2FeM4=;
	b=ZIiia1XmsF7/mWcQ4BhQSiStaD6wCUayHiPHxHNRLD/z2DmPOWFrt+g0LGvu4LbCtISei1LpFIxQEjCPkMSioF+JgPVqu+Xy5Qa+g0FX9G49QncxixZoFduIhpQBmNBlnDVsK84q6P6NeVGePzWoZ6CL1aIvPcz+dWtDbDED2GM=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1174.namprd12.prod.outlook.com (10.168.163.148) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2538.15; Wed, 11 Dec 2019 15:01:47 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::8048:9c4a:16a1:f584]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::8048:9c4a:16a1:f584%4]) with mapi id 15.20.2516.018;
	Wed, 11 Dec 2019 15:01:47 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"Openembedded-core@lists.openembedded.org"
	<Openembedded-core@lists.openembedded.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] hashequiv, pseudo, and GIDs
Thread-Index: AdWvxXGeOYsqYFTMSCmAlM1iHqCZyQATYWMAAAgKjzA=
Date: Wed, 11 Dec 2019 15:01:47 +0000
Message-ID: <CY4PR12MB1653E9BDF3FC06D7853CBE008B5A0@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <CY4PR12MB16537AC33CB9D19F94A126458B5A0@CY4PR12MB1653.namprd12.prod.outlook.com>
	<1df3964a46e8e91cb702ec16f732abad0f019302.camel@linuxfoundation.org>
In-Reply-To: <1df3964a46e8e91cb702ec16f732abad0f019302.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c8e32c3-4aa5-47c4-8ae8-08d77e4b0b6d
x-ms-traffictypediagnostic: CY4PR12MB1174:
x-microsoft-antispam-prvs: <CY4PR12MB1174C7BD160C8E55C74EE6CC8B5A0@CY4PR12MB1174.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(396003)(376002)(346002)(136003)(39860400002)(29502001)(189003)(199004)(81166006)(81156014)(66946007)(4326008)(110136005)(478600001)(66446008)(316002)(66476007)(8676002)(186003)(66556008)(6506007)(64756008)(71200400001)(26005)(76116006)(52536014)(55016002)(7696005)(2906002)(86362001)(8936002)(5660300002)(33656002)(9686003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1174;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0uzsG4TaUOruTbmprcLVmiuOatTcE85EkCTtFD7zccM2o2+wqnfr6I3T9ZXxSOdAQwkoJUM8yB+61nJziI+zxjUC/z5Of61CXKmFMPn6fP1wvNppTJ70+QUIw74Zd8j4nO2VYeBicaYBOBM00GdmKoDfgslEarqmYJVKDGBoirM049ZgvTRzBCt6xUPPWTfdYLKZiqSAwCmtXJxrZQwh8u+O4xq9ITGXnx8SAhTmWhtC3EyHYHkPC7G0yBmbYdZc2OSfQP3AKvsWFoby3coYBb0RWTbDEvZJKfXCS96pbhnsuvSNINNsf2OnIHqK3lZhhaoMCroMiOVIQRhVYH0eXnP21AsYmVc2K7f0SzGqF7xKj53y+HiVPdWKnT9Aqxv2nlQ/8D034Fof4xbd7kl9B8WXuovXXjSb65yRFEciGT4jPaNDRkU0JgXxOzGF5aBh9sNEKWSQSLcRt5POhPll1hfNLKyH1pQRdGPNVdWl4/251UULjZUCQslJncgyn54C
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8e32c3-4aa5-47c4-8ae8-08d77e4b0b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 15:01:47.4470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvAeRCWxu34oBPSsRQW4GGfowM/wmEAqeZ06SAwohU3/pxJcizZffh7ExXMRyys6KgqmUYtkh7OL3ExUhysOCo+q9Z1ltj3GQPjcWoJ0yZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1174
Subject: Re: hashequiv, pseudo, and GIDs
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
X-List-Received-Date: Wed, 11 Dec 2019 15:01:48 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+IEEgd29ya2Fyb3VuZCBpcyB0byBhZGQ6DQo+ID4gICAgIERFUEVORFMgKz0gIkIiDQo+ID4g
dG8gcmVjaXBlIEEsIHNvIHRoYXQgdGhlIGdyb3VwIGVuZHMgdXAgaW4gQSdzIHBzZXVkbyBkYXRh
YmFzZS4gVGhpcw0KPiA+IHdvcmtzLCBidXQgc2VlbXMgcmVhbGx5IHJlYWxseSBoYWNreSwgc2lu
Y2UgaXQncyBvbmx5IG5lY2Vzc2FyeSB3aGVuDQo+ID4gaGFzaGVxdWl2IGlzIGFjdGl2ZS4NCj4g
DQo+IEkgc3VzcGVjdCB0aGlzIGlzbid0IGEgaGFjaywgYnV0IG5lY2Vzc2FyeSBhbmQgeW91J3Jl
IGZpbmRpbmcgYQ0KPiBkZXRlcm1pbmlzbS9taXNzaW5nIGRlcGVuZGVuY3kgaXNzdWUgdGhhdCBo
YXNoZXF1aXYgaXMgaGlnaGxpZ2h0aW5nPw0KPiANCj4gPiBTbyB3aHkgaXMgdGhlIGdyb3VwIG5h
bWUgdXNlZCBpbiB0aGUgaGFzaCwgYXMgb3Bwb3NlZCB0byB0aGUgR0lEPyAoSQ0KPiA+IGFsc28g
aGF2ZSB0aGUgc2FtZSBxdWVzdGlvbiByZWdhcmRpbmcgdXNlciBuYW1lIHZzIFVJRCkuIElmIHRo
ZSBHSUQNCj4gPiB3YXMgdXNlZCB3ZSB3b3VsZG4ndCBoYXZlIHRoaXMgaXNzdWUuDQo+IA0KPiBU
aGUgb25seSB3YXkgSSBjYW4gdGhpbmsgdGhpcyBtaWdodCB3b3JrIGlzIHRoYXQgeW91J3JlIHN0
YXRpY2FsbHkNCj4gYXNzaWduaW5nIEdJRHMgYW5kIHVzaW5nIHRoZSBHSUQgZGlyZWN0bHkgaW4g
ZG9faW5zdGFsbD8gVGhhdCBpc24ndCB0aGUNCj4gd2F5IHRoZSBkZWZhdWx0cyBhcmUgc2V0dXAu
DQo+IA0KPiBJZiB0aGF0IGlzIHRoZSBjYXNlIHdlIHByb2JhYmx5IGhhdmUgdG8gZGV0ZWN0IGl0
IGFuZCBjaGFuZ2UgdGhlDQo+IGJlaGF2aW91ciBvZiBoYXNoZXF1aXYncyBjb21wYXJpc29uIGZ1
bmN0aW9uIHRvIHVzZSBVSUQvR0lEIGJ1dCBpdCBkb2VzDQo+IGRlcGVuZCBvbiB0aGUgd2lkZXIg
c3lzdGVtIHNldHVwLg0KDQoNClllcywgeW91IGFuZCBKb3NoIGFyZSBjb3JyZWN0LiBUaGUgcmVj
aXBlIHdhcyBkb2luZyAiY2hncnAgMzAwNCIuIEl0IGRlZmluaXRlbHkgbWFrZXMgc2Vuc2UgZm9y
IG1lIHRvIGFkZCB0aGUgZGVwIG9uIEIsIGFuZCBjaGFuZ2UgaXQgImNoZ3JwIGFjdHVhbC1ncm91
cC1uYW1lIi4gQnV0IGxpa2UgeW91IHNhaWQgSSB0aGluayBpdCBkb2VzIGV4cG9zZSBhIHByb2Js
ZW0gaW4gaGFzaGVxdWl2Lg0KDQpDaHJpcyANCg==

