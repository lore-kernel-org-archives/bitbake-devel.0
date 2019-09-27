Return-Path: <chris.laplante@agilent.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
	(mail-eopbgr760054.outbound.protection.outlook.com [40.107.76.54])
	by mail.openembedded.org (Postfix) with ESMTP id CEE1960720;
	Fri, 27 Sep 2019 22:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=Ik4P4f94gY2J6kpDFudsDspJDGvU/3EW8ErULRel9D1qvtMp+ERZmu2xx0pC1jdpgIW4P8J7uFKxHXLz544K6OjuiNYcRnKmjkAmyK/GdOiiYQXb62SLZT3p1OvD7j4QFIjBaOLH5J55fAq/Ets9X8wX0+h6Sq6qUwZEAlMRG7BqwTn1eyGB9ZK11My9DIXsVrElGcqaWX84llRheBrNiWDYv2tvibfvxmM0+272XEgkzhQmZS94l2gxbwvIYU/V626YMCxgwDdY5uj+0ccpWSnmnEqVkwnZVBEdqZT0SewH6a3P2z2Yq6c/eeeSCl9Xg4Yt2n4sU0JFY/on4LL0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fyS1119Sh6iZGOJn/VcnbcF/+Fae/v7shiKkon9zHh0=;
	b=gNb3uUqEBL83MzdU4fFb4dcGvKDcuHET850WULKuf36Wbpn48mxGxnZm+52dYsVg+W58tz4y/qGQa4NW6rkgtvA8hbKVfMFherXORB1W8p6jTa5tsec7N+ucwz6BA1WfxLNcbb8+35YUGI46yLOmagKJPaZk7NG4fswome+PEQgA1PtFSViJUUiUAKacmUtJTJQXRBW6Lf0yuKpxEOdGl0jNX6qd8Ll6Z/tuUhdjHL36jnva5ctBV6MMotgPmJtJGIUz8SYjBUwhf4xOk96owE5hSYJJ+E0pOdofFhXjzoAnqFT1JlCd/KxrJBOQYUI6NXx31FLvDZOzJ1O+FNf/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fyS1119Sh6iZGOJn/VcnbcF/+Fae/v7shiKkon9zHh0=;
	b=pCQLlG42VBd5nIQ7o6Vc3jCo3aGMuAfnAkkgqtyWHTB3VrtP4QyLFmzPh/wlCbS+Dz0pyLq4BlvWLVRhEThb5M1a/hvtv8Bcs5JLgLdqBP44ks+b8HR5dAPIs0W/D3L3XdibaUkJwxXeffk75HOnuHclRt5aXLUJVkXA5nw5G1c=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1848.namprd12.prod.outlook.com (10.175.60.151) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2284.25; Fri, 27 Sep 2019 22:34:56 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::482a:ace:8e58:d90]) by CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::482a:ace:8e58:d90%12]) with mapi id 15.20.2284.028;
	Fri, 27 Sep 2019 22:34:56 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"Openembedded-core@lists.openembedded.org"
	<Openembedded-core@lists.openembedded.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Keeping multiconfig config files in sync
Thread-Index: AdVzAyq6fYyA3QQ+TrmlUxM8RoagYQBqTEIAACSmGwA=
Date: Fri, 27 Sep 2019 22:34:56 +0000
Message-ID: <CY4PR12MB1653C7060E19B23DF3E264AF8B810@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <CY4PR12MB16531DD24CCB0C838C7906608B840@CY4PR12MB1653.namprd12.prod.outlook.com>
	<b1f2e008047cb4c75b7e23fc8b3e92410c8f183f.camel@linuxfoundation.org>
In-Reply-To: <b1f2e008047cb4c75b7e23fc8b3e92410c8f183f.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.59.252.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2eb3f9ee-1cc6-4662-ef49-08d7439aec25
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:CY4PR12MB1848; 
x-ms-traffictypediagnostic: CY4PR12MB1848:
x-microsoft-antispam-prvs: <CY4PR12MB18482C5F2C0FEB85E91AFFBF8B810@CY4PR12MB1848.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(396003)(366004)(136003)(376002)(39860400002)(199004)(29502001)(189003)(256004)(8676002)(64756008)(66446008)(25786009)(316002)(66556008)(66476007)(7736002)(81166006)(81156014)(229853002)(8936002)(74316002)(3846002)(2501003)(110136005)(446003)(11346002)(486006)(6436002)(52536014)(71200400001)(71190400001)(476003)(5660300002)(2201001)(33656002)(6506007)(6246003)(186003)(76116006)(66946007)(102836004)(86362001)(478600001)(55016002)(305945005)(7696005)(6116002)(14454004)(76176011)(99286004)(26005)(66066001)(2906002)(9686003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1848;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CMQ2rdyny1ylZ8N3XA/jZpES5BCXpXqijeH/7ta/oEo5XUTZJsxf2uc/pu8KyQijUmYI8BOlAV0N8Zto63Tua1Y1DsRBw33Ynzx3y9vIKr17VOkb+cS5PqlvL/PPubziqLhZIpBmOKnK39Ori8i1r8RHgPol67Kks1PI+5dRurXrb/Hn0ePTEAcGToz4UXYL8tUgbj2jeN+b0KjxYAyp7cN3dJnN31tNJxiJvmfD5rQQI9WFbm3IBHSb5o24/YBEvCdfVW5UIZ8xUJB6S6re3KaqKVy+8PBOecMS3g+Sb+WpuBjsgzmBe0DWNGCC0GrhVVYl9ph0v1mkC33lfp9rJ/vLOqn2dkb0Y+/F9nQv2gW7gjj/AMU2knWVdaraBatr0oonHfj/VDO0u+D1KQqDu7QmY1M0FNSonAXcJuC5xc0=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb3f9ee-1cc6-4662-ef49-08d7439aec25
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 22:34:56.1328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHIRe3FZ/bQQSxpUXrsNbMBZh0cvLd8/AokbW6CL3HUWrnsVxPElyyfeDqjoNEga2VYuwp8eP7PrhiXUuthS7uS7OVPE2VBrdn42F+eulMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1848
Subject: Re: Keeping multiconfig config files in sync
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
X-List-Received-Date: Fri, 27 Sep 2019 22:34:58 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmljaGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9y
Zz4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyNiwgMjAxOSA0OjUzIFBNDQo+IA0KPiBU
aGlzIGhhcyBidWdnZWQgbWUgc2luY2Ugd2UgZmlyc3QgY3JlYXRlZCBtdWx0aWNvbmZpZy4gSXQg
d2FzIGFsd2F5cw0KPiBpbnRlbmRlZCB3ZSdkIGhhdmUgY29uZmlncyB5b3UgY291bGQgcmVmZXJl
bmNlLiBJdCB0dXJuZWQgb3V0IHRvIGJlDQo+IGhhcmQgdG8gY29kZSBhbmQgd2UgKHdlbGwsIEkp
IGRlY2lkZWQgdG8gImNvbWUgYmFjayB0byBpdCIuIFRoYXQgaGFzbid0DQo+IGhhcHBlbmVkIHll
dC4NCj4gDQo+IEknZCB3ZWxjb21lIHByb3Bvc2FscyBvbiBob3cgaXQgY291bGQgd29yayAoaXRz
IGhhcmRlciB0aGFuIGl0IGZpcnN0DQo+IGFwcGVhcnMpLiBJdCdkIGJlIGdvb2QgdG8gY2hlY2sg
d2UgZG8gaGF2ZSBhIGJ1ZyBvcGVuIGZvciBpdCB0b28uDQoNCkhtbSwgSSBqdXN0IHRyaWVkIG1v
dmluZyBteSBtdWx0aWNvbmZpZyBkaXJlY3RvcnkgZnJvbSBidWlsZC9jb25mIHRvIHRoZSANCmNv
bmYgZGlyZWN0b3J5IG9mIGFuIGFyYml0cmFyeSBsYXllciwgYW5kIGl0IHdvcmtlZC4gSSBhZGRl
ZCAzIG11bHRpY29uZmlncywNCmVhY2ggd2l0aCBhIGRpZmZlcmVudCBNQUNISU5FIHNldC4gVGhl
biBJIGFkZGVkIGFuIGFub255bW91cyBQeXRob24NCmZ1bmMgdGhhdCBqdXN0IGJiLndhcm4nZCBv
dXQgdGhlIG1hY2hpbmUuIFdoZW4gSSByYW4gaW4gcGFyc2Utb25seSBtb2RlLA0KaXQgcHJpbnRl
ZCBvdXQgNCB3YXJuaW5ncyAoaW5jbHVkaW5nIG9uZSBmb3IgdGhlIGRlZmF1bHQgY29uZmlnIEkg
Z3Vlc3MpLCB3aXRoDQp0aGUgbWFjaGluZSBkaWZmZXJlbnQgZWFjaCB0aW1lLg0KDQpUaGUgQkIg
bWFudWFsIHNheXMgIlRoZSByZWFzb24gZm9yIHRoaXMgcmVxdWlyZWQgZmlsZSBoaWVyYXJjaHkg
aXMgYmVjYXVzZSB0aGUgDQpCQlBBVEggdmFyaWFibGUgaXMgbm90IGNvbnN0cnVjdGVkIHVudGls
IHRoZSBsYXllcnMgYXJlIHBhcnNlZC4gQ29uc2VxdWVudGx5LCANCnVzaW5nIHRoZSBjb25maWd1
cmF0aW9uIGZpbGUgYXMgYSBwcmUtY29uZmlndXJhdGlvbiBmaWxlIGlzIG5vdCBwb3NzaWJsZSB1
bmxlc3MgaXQgDQppcyBsb2NhdGVkIGluIHRoZSBjdXJyZW50IHdvcmtpbmcgZGlyZWN0b3J5LiIN
Cg0KWW91IGFjdHVhbGx5IGZpeGVkIHRoaXMgbGltaXRhdGlvbiBpbiAyMDE3IHdoZW4geW91IHJl
d29ya2VkIHRoZSBzZXJ2ZXIgQVBJIA0KKHBva3kgY29tbWl0cyA2MmJkMmUzNiBhbmQgNDYwMjQw
OGMpLiANCg0KU28sIGhhcHBpbHksIEkgdGhpbmsgdGhpcyBpcyBqdXN0IGEgY2FzZSBvZiBkb2N1
bWVudGF0aW9uIHRoYXQgbmVlZHMgdXBkYXRpbmcgOikgDQoNCkNocmlzDQo=

