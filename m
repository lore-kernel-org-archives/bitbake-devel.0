Return-Path: <chris.laplante@agilent.com>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	by mail.openembedded.org (Postfix) with ESMTP id 866737FD84
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jan 2020 16:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=LrJeby1ZV7LHCVkmMTT7d3ndqXUevryzHiIzklFjoLxJDplbltaS18yS0beX87ILcWh6lpoxzkVcdLtMjUib3EGPLu6B0G6Wip3PCoR8HK5shztej8sh59f9K3nmrH+ajj0QypvQkegvZF2d0fTqYyq3SOYyQsLmi/Mwjgw11EQEj5+gYPNMWMV7TUIKOTQPH5bMsw6cAOu/ZbeHOGBf+1klLR+nmnwzvPJGErACFfYMiH5gm9g5/u39p2J2gpxcm8vhBucvSCe3nCfM8w/qTqzIsoSLWUCMn9wv1zUDBghveaGjMUFf51fxX6s8efZXvYCUi2656IG5M41ZBHu+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=lVLlhMh3hSQSBjO2ZI/gtOFWVXDEgdWRGXlh9f1WPLU=;
	b=ltjpqmZsIvCSRU5fAd++QI8VXMIHR5vnlP1QblSN8ifFHxgomy68DHy+z8tMiOyXc5fxWdz9jwBwfBFEpow5U2hIklLHgiSw0ZFBCEkIonBuPehPgRYDT6x1H/E+nWfGXBJx3vqLycDR+YdhaE0i9bJwsGOXlCNslu3HjMHNKbk/focwEnMJJcFH9PAccp3ZMY/ye5DKBDTTojI/CY9cNvrSk3lv0nAIpIcav1yEG1v0BZOB5eqHdEIw2r9VpIMHFSoYD7ggXQcG3w7kB945qr11pIanx/DeQ77ac1kCK5HBjXBf0iR2BJo6YnMfkJ5HgLWEv/J5rohuNnC7l7tp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=lVLlhMh3hSQSBjO2ZI/gtOFWVXDEgdWRGXlh9f1WPLU=;
	b=MkyRt+j+r4d1Cj0RqXumXyqzDTFCZ3ciq58FekTLzS903soqCeFwldyfenZIV5HkLisJgmMiJu1+WHmgc43uIQPSXnKmXgmBqQ7EZxjw/smoH3ITLiM1MZKuyEDQH05jvjD2SWZbykowgDU0hoUFZoUaI8bj8uxrgshTDOEHW8s=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1207.namprd12.prod.outlook.com (10.168.165.7) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2644.24; Fri, 24 Jan 2020 16:11:17 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::3c16:3c42:ee9f:b486]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::3c16:3c42:ee9f:b486%9]) with mapi id 15.20.2644.028;
	Fri, 24 Jan 2020 16:11:17 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: akuster808 <akuster808@gmail.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/1] ui/teamcity: add a TeamCity service
	message frontend
Thread-Index: AQHV0slMZ7xATRCQ70+vdYhZirmKfKf595IAgAABFjA=
Date: Fri, 24 Jan 2020 16:11:17 +0000
Message-ID: <CY4PR12MB16539949F474DD1C2691D84B8B0E0@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <1579878983-121851-1-git-send-email-chris.laplante@agilent.com>
	<1579878983-121851-2-git-send-email-chris.laplante@agilent.com>
	<53c09892-ad7a-9a16-bfbc-80189d668933@gmail.com>
In-Reply-To: <53c09892-ad7a-9a16-bfbc-80189d668933@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec68fa01-cb79-4701-c1e2-08d7a0e80b34
x-ms-traffictypediagnostic: CY4PR12MB1207:
x-microsoft-antispam-prvs: <CY4PR12MB1207974FE44FABD685434FF88B0E0@CY4PR12MB1207.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(29502001)(9686003)(6506007)(110136005)(8936002)(186003)(33656002)(52536014)(55016002)(478600001)(316002)(2906002)(26005)(71200400001)(5660300002)(86362001)(7696005)(66556008)(81166006)(66446008)(76116006)(4744005)(64756008)(66476007)(81156014)(66946007)(8676002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1207;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YSHlJzoa6YM21k80+ulcZvvlv2nydlgnQb2l7qpIA3kFQc15dyL4DL4OVlFOjZsH4Z+XnA2KWtNLC95eEwv4zix28UkdcUaEJ074KZy5BZdndQPKargSMX/RqhRdqnK2kwXyY9GMqSBi1ir/2gC0Ygh7Lj8y2nrUMrrLNilmyEY1sJ8cVAf2YUfWBPz4Mh8dpW4ECrH8vNiNfbnmvzGEp0KR4R1KVC6+R2VCNPdvpwB5VXjUHZN3elp7ZxSiu2bRIRgJRVULIf9rYbkDLcbUdtqpuB3+DRV4xgi+j2Sb+nzru4fxJEgeGDvbKC+lvvphxKyXbyRAg/vwmhFWS69ZauI8h+5QT7VeqObP76aeOSFgcr+twb976bxnKib4A+UZ5lK7stp0q8bYcV+cwWqBrWrM+dv+rnmaJJW5CEoFTKRxmwCG5E4peCzOTDy/e1HPWOzUyflgPBJiq5COt+kbPuBrY+TvxnhW2xQb3H+WNcaMVil2f7u9LAWtEoNVjDs+
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec68fa01-cb79-4701-c1e2-08d7a0e80b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 16:11:17.5818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBpTxr3nVD7inMnBkb2NEMN7t57gv2ZsRw5VlPZj7GiFqI/Fn18EjJeEljm56bJh2Zz05UD9BGM75ILQb2InkNty1qaeB6z/3Sr6laKLavY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1207
Subject: Re: [PATCH 1/1] ui/teamcity: add a TeamCity service message frontend
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
X-List-Received-Date: Fri, 24 Jan 2020 16:11:18 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgQXJtaW4sDQoNCj4gSSBhbSBub3Qgc3VyZSBob3cgQml0YmFrZSBhY2NlcHRzIG5ldyBVSSdz
IGJ1dCBjYW4geW91IGV4cGxhaW4gd2h5IHRoaXMNCj4gaXMgdXNlZnVsIGFuZCBob3cgaXQgZGlm
ZmVycyBmcm9tIFRvYXN0ZXI/DQoNCkl0J3MgdXNlZnVsIGZvciBhbnlvbmUgdXNpbmcgVGVhbUNp
dHkgdGhhdCB3YW50cyB0byBydW4gQml0QmFrZSBidWlsZHMgOikuIFRoZXJlIGFyZSBudW1lcm91
cyByZWFzb25zIHdoeSB3ZSBjaG9zZSBUZWFtQ2l0eSByYXRoZXIgdGhhbiBUb2FzdGVyLCBub3Qg
YWxsIG9mIHdoaWNoIHJlbGF0ZWQgdG8gWW9jdG86IExEQVAgaW50ZWdyYXRpb24sIGFiaWxpdHkg
dG8gZG8gV2luZG93cyAmIExpbnV4IGJ1aWxkcywgZXRjLiBTbyBJIGNob3NlIHRvIHNldCB1cCBv
bmUgYnVpbGQgc2VydmVyIChUZWFtQ2l0eSkgcmF0aGVyIHRoYW4gdHdvIChUZWFtQ2l0eSBhbmQg
VG9hc3RlcikuIEkgaW1hZ2luZSB3ZSBhcmUgbm90IHRoZSBvbmx5IG9uZXMgd2hvIHRvb2sgYSBz
aW1pbGFyIGFwcHJvYWNoLg0KDQo+IEFyZSB5b3Ugd2lsbGluZyB0byBtYWludGFpbiB0aGlzIFVJ
Lg0KDQpZZXMuIEkgaGF2ZSBiZWVuIGZvciB0aGUgcGFzdCB0d28geWVhcnMgaW50ZXJuYWxseSwg
YW55d2F5Lg0KDQo+IElmIHRoZXJlIHNvbWUgc29ydCBvZiB0ZXN0aW5nIHRoYXQgZW5zdXJlcyB0
aGUgY29udGludWVkIG9wZXJhdGlvbiBvZg0KPiB0aGlzIGNvZGU/DQoNCk5vLCBidXQgaXQncyBv
YnZpb3VzbHkgYSBnb29kIGlkZWEgc28gSSdsbCBhZGQgaXQgdG8gbXkgVE9ETyBsaXN0LiANCg0K
VGhhbmtzLA0KQ2hyaXMNCg==

