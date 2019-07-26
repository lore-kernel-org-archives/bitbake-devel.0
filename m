Return-Path: <chris.laplante@agilent.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr740048.outbound.protection.outlook.com [40.107.74.48])
	by mail.openembedded.org (Postfix) with ESMTP id 9C5D67F13D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2019 15:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=OVhcAC//q1OCHI7dXOgT9tabUxkslZ/6Qh0ZNBzAMEnal6/vlm4bC1SRF5B4Bs8iL6N3E7ACCjfTODl3y9e6W/zIzxcov0H3Mh65CY8hsztKuNNXNW5XjvvyrwIU3iIAxQ2CLfhKNA6rsWMKPEIDJbBn4zat7Yx7E/MLPlx1mW0e5rcgBl0Z2xy5kNXG+COJxjuGPhJb86fcNOCH0z0uGOcxnIbNuaMh73PoZ7AJqMd9/H0FNEe3Ux6OCvPfYtBbtDPFDB2hEGblQvg0kMlEp86pqPE6Vyz3A0H5wYxUGaxHHA3rtWvCTEahtPI32wEJaf5B75h3t4uOdhQgQLH1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=gowqIpvoQf8Urneiidk+/6sMnRNAHhaG6zo8YChWcqc=;
	b=hJLbTqk3ULvx8DF9IbPXwhufqznESM1lrH6fMkjQMOJXUDoA+BJIQ+zJp7HWSWjbc98wRd4R3VMoMCKXjWjvwf8S1hId/G4Hd9wRlUw1lbe03941ansrzXbW0zmFCsN3NEuYd3+SrhT6hiZplPCUfhYqexpSWmmfzuo43yhbcMNr9JwXL6aV4NxHQtmhPSHYDtY403a0Pghhn2W4gv0hnTHBDCKF093JbHwuALGWEF5XIELvriJ5lObf5kuo4NBSrXa21KhZzjvm6eJxrj9JXjEegeEWUmDIfyjDqcLHk3CzzzRedefOmLKldqiZ0X5BEbxrNUR6eph2HuNH3A5YzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=agilent.com;dmarc=pass action=none
	header.from=agilent.com;dkim=pass header.d=agilent.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=gowqIpvoQf8Urneiidk+/6sMnRNAHhaG6zo8YChWcqc=;
	b=TCKzkFKZgd2yME0793cDU/zvSBsOdE9+gP0WGdoDja2VmbHqb0M1Uq2A1Ap02IOVp4d4wOb6Lk2H7v20lrufbUoEgkVYTrPPuEJ/ku7vxXvTNpstkCxVhiJ8QM4QXHVa3T1XSd5jRV0DHKtcRflM98QHX31rNQkv7wyWI1CCnaY=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1511.namprd12.prod.outlook.com (10.172.66.15) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2094.17; Fri, 26 Jul 2019 15:46:56 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc%9]) with mapi id 15.20.2094.013;
	Fri, 26 Jul 2019 15:46:56 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH] fetch2: add ability to skip recipes when
	get_srcrev fails via BB_FETCH_SKIP_ON_SRCREV_ERROR
Thread-Index: AQHVQ7myBvHQRVvKAU6e6N46xT51eqbc/9MAgAAJKuA=
Date: Fri, 26 Jul 2019 15:46:56 +0000
Message-ID: <CY4PR12MB1653B3168D82F8A1E6AC390C8BC00@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <1564149248-7626-1-git-send-email-chris.laplante@agilent.com>
	<CANNYZj_ykVaOvq4EKtJ=7qpTNt5HcdpYqE+z4dRpqNQH-6ykYA@mail.gmail.com>
In-Reply-To: <CANNYZj_ykVaOvq4EKtJ=7qpTNt5HcdpYqE+z4dRpqNQH-6ykYA@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b4757e5-fe80-4532-8728-08d711e07d3a
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:CY4PR12MB1511; 
x-ms-traffictypediagnostic: CY4PR12MB1511:
x-microsoft-antispam-prvs: <CY4PR12MB151158C4D00404F371BCBA288BC00@CY4PR12MB1511.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(199004)(189003)(13464003)(29502001)(305945005)(229853002)(256004)(6116002)(81166006)(14444005)(33656002)(7736002)(71190400001)(3846002)(8676002)(81156014)(14454004)(8936002)(74316002)(476003)(68736007)(53546011)(26005)(316002)(66066001)(71200400001)(11346002)(66476007)(5660300002)(478600001)(2906002)(186003)(66556008)(55016002)(64756008)(102836004)(99286004)(66446008)(52536014)(66946007)(6436002)(9686003)(446003)(76116006)(4326008)(76176011)(25786009)(6246003)(53936002)(86362001)(7696005)(6916009)(6506007)(486006);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1511;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xlkB3bifRiu98v4lifIPtRE6t5a1KLzH1euPwB0idE9x9Mp7UQOGu2A0wK09ziV/2FXXnpLy2HU0LYU3LRhB6BUks8JuGMeO8YuvWQiauUHqwkn4+lShCUxvT1BaRS2rGM5BwkuhQY50GRtmff+t2XrvniD7NPtfe8/aAjkNOQNqarOxmmD/oRCzmSYe4CN7v9oZ4rBogStXJ8J8KTqJxMp8ephM4BJrSDA1IPVUob9lcAvNUDsxVPc4B/bh09WBLyczv2sSoxUqTbYmChhAWm/FXFUFFSQc2DKIWrF6ZSfK0cMonx9e+0DYiCqarsUWzhu54CFajlHz8tBttKYtgl4j3qVUq49HIlht7vz90Wp+JxPlo2kT7Ud3lRcbnrm5nQqn35Y+36psy7BkQpLntFRpplZf/yRvmd5W1y0tQDo=
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4757e5-fe80-4532-8728-08d711e07d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 15:46:56.6199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chris.laplante@agilent.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1511
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: add ability to skip recipes when get_srcrev fails via BB_FETCH_SKIP_ON_SRCREV_ERROR
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
X-List-Received-Date: Fri, 26 Jul 2019 15:46:57 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgS2FuYXZpbiA8
YWxleC5rYW5hdmluQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDI2LCAyMDE5IDEx
OjA2IEFNDQo+IFRvOiBMQVBMQU5URSxDSFJJUyAoQWdpbGVudCBVU0EpIDxjaHJpcy5sYXBsYW50
ZUBhZ2lsZW50LmNvbT4NCj4gQ2M6IGJpdGJha2UtZGV2ZWwgPGJpdGJha2UtZGV2ZWxAbGlzdHMu
b3BlbmVtYmVkZGVkLm9yZz4NCj4gU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0hd
IGZldGNoMjogYWRkIGFiaWxpdHkgdG8gc2tpcCByZWNpcGVzIHdoZW4gZ2V0X3NyY3JldiBmYWls
cyB2aWEgQkJfRkVUQ0hfU0tJUF9PTl9TUkNSRVZfRVJST1INCj4gDQo+IEkgdGhpbmsgaXQncyBi
ZXR0ZXIgdG8gcmVhcnJhbmdlIHRoZSBsYXllciBpdHNlbGYsIGFuZCBzcGxpdCBpdCBpbnRvIGEg
cHJpdmlsZWdlZCBhbmQgYSBub24tcHJpdmlsZWdlZCBvbmUuDQo+IA0KDQpZZXMsIHRoYXQncyB0
aGUgImNsZWFuZXN0IiBzb2x1dGlvbiwgYnV0IGl0IGRvZXNu4oCZdCBuZWNlc3NhcmlseSBzY2Fs
ZSB3ZWxsIHdoZW4geW91IGFkZCBtb3JlIGFuZCBtb3JlIGRpc2pvaW50IHNldHMgb2YgdXNlcnMg
dGhhdCBjYW4vY2FuJ3QgYWNjZXNzIHBhcnRpY3VsYXIgcmVjaXBlcy4gDQoNCkFsc28sIGp1c3Qg
dG8gYWRkIHNvbWUgbW9yZSBjb250ZXh0IHRvIGhvdyB3ZSBhcmUgdXNpbmcgdGhpczogZm9yIGVh
Y2ggb2Ygb3VyICJza2lwcGFibGUiIHJlY2lwZXMsIHdlIGhhdmUgYWx0ZXJuYXRpdmUgcHJvdmlk
ZXJzIHRoYXQgcHVsbCBwcmUtY29tcGlsZWQgYXJ0aWZhY3RzIGZyb20gInBvb2wiIHJlcG9zaXRv
cmllcy4gSXQgaXMgbmljZSB0byBrZWVwIHRoZSBwcm92aWRlcnMnIHJlY2lwZXMgaW4gb25lIHBs
YWNlLg0KDQo+IFRoaXMgcGF0Y2ggc2VlbXMgdG8gZW5hYmxlIHNraXBwaW5nIHRoZSByZWNpcGUs
IHJlZ2FyZGxlc3Mgb2Ygd2hhdCB0aGUgYWN0dWFsIGlzc3VlIHdpdGggZmV0Y2hpbmcgd2FzICh3
aGljaCBtYXkgb3IgbWF5IG5vdCBiZSAnYWNjZXNzDQo+IGRlbmllZCcpLiBTa2lwcGluZyBvbiBh
bnkgZXJyb3IgZG9lc24ndCBzZWVtIHJpZ2h0IHRvIG1lIGFzIGl0IG1heSBtYXNrIG90aGVyIHR5
cGVzIG9mIHByb2JsZW1zLg0KDQpJIHNlZSB5b3VyIHBvaW50IChpbiBnZW5lcmFsKSwgYnV0IG5v
dGUgdGhhdCB0aGlzIG9ubHkgc2tpcHMgdGhlIHJlY2lwZSBpZiBhbiBlcnJvciBvY2N1cnMgaW4g
Z2V0X3NyY3JldiBkdXJpbmcgdGhlIHBhcnNpbmcgc3RhZ2UgKGFuZCB3ZSBhcmUgbm90IGV4ZWN1
dGluZyBpbiBhIHRhc2spLiBUaGUgb3JpZ2luYWwgZXhjZXB0aW9uIHdpbGwgc3RpbGwgYmUgZGlz
cGxheWVkIHRvIHRoZSB1c2VyLiANCg0KQnV0IGl0IGNlcnRhaW5seSB3b3VsZCBiZSBiZXR0ZXIg
dG8gYmUgbW9yZSBzZWxlY3RpdmUgd2l0aCB3aGljaCBraW5kIG9mIGVycm9ycyBnZXQgc3dhbGxv
d2VkLiBJIHdpbGwgdHJ5IHRvIGxvb2sgaW50byB0aGF0Lg0KDQpUaGFua3MsDQpDaHJpcw0K

