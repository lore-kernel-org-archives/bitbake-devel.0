Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr680048.outbound.protection.outlook.com [40.107.68.48])
	by mail.openembedded.org (Postfix) with ESMTP id E62137F27D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2019 15:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=AVntQbh4DhPBIfelLVepD9ryIqOXJXnMpwr5wuNn8ld8SNt0GkSfr+rM8LsScOU24OrqR+twoJ3WbFuFMPoBryqJxXLc8EOkoTZ73BPVSl5CcrD+2u7v7avTTfvOCJGUbmm6bsfA9xWz1r4vwWuWhu6P9iVgrzNEOEBvnHUhLT5ktR4RjdlPVec/liJ8tBAmVyXjw7N2JlaMoX0eTwO8uq96YgZNLbWcX7dcgjo44lfgmBnzIq0xaNCaB1Q+h2SaayWQeCbC/twSQLq/5Rp3clGMk0yv2UPcscEpck08A9Is0QxChEG26DvWR4DtDxKgmdwUPoOvSAR0TUkhXr/u6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=DLLMjMOhRdY2UNk9I52kcVY9l9mCfCg9evrXLr+mWKo=;
	b=eSOiSEleNrSwHoVGKAVFAqTMFw5hRMSa4h2h/YuBwAVdcpd6jDw6ckwAVKNb4C/84H8oD0F/mgw15YytpOwWUq0KdBKQ8ijNVB2fapiK3qjVOjiM7RUXkZ53XLGnMKG3w2VeC5EtSUWdAd9ANJ6YXzte9LEB3+FOOpuSxr7nALVfaZaO9JmgsOr4sL+6adpLguPI9vtnIZtRfyqP/KGk8jET8Crz+4ri+2+7w7f6kK8MtmDqWqUfz9TXD7Ano9l+B5t6JI8XkO2OYeitOSWy67AOVXGI4V8q21EhQySN7bZnYPxTvgV6kKFW6KRv9UJaiNMOgRmA2x4ACocm+puZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=agilent.com;dmarc=pass action=none
	header.from=agilent.com;dkim=pass header.d=agilent.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=DLLMjMOhRdY2UNk9I52kcVY9l9mCfCg9evrXLr+mWKo=;
	b=qjXcVuhpSb8jcoyc/LDPx4K1S8VL5/rZE9hJKbkS0odDUYCI2e+tqw1Eevjm7oVmCASmC/wIIqpFlI6LeESoBdoje0TnWqMvxX7Cei124+k1pT1NuYjlUOU3dyGyHUMb+5/fyit4UU9U2RuUZNVyz2hwXaKWUBJXUXpmbKtsGdY=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1720.namprd12.prod.outlook.com (10.175.62.142) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2094.16; Mon, 29 Jul 2019 15:14:03 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc%9]) with mapi id 15.20.2094.013;
	Mon, 29 Jul 2019 15:14:03 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Mark Hatle <mark.hatle@windriver.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Thread-Topic: UNVERIFIED SENDER Re: [bitbake-devel] [PATCH] fetch2: add
	ability to skip recipes when get_srcrev fails via
	BB_FETCH_SKIP_ON_SRCREV_ERROR
Thread-Index: AQHVQ7myBvHQRVvKAU6e6N46xT51eqbc/9MAgAAJKuCAATsbAIADbKcAgAAEqUA=
Date: Mon, 29 Jul 2019 15:14:03 +0000
Message-ID: <CY4PR12MB16531F5005814431DEA66CF58BDD0@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <1564149248-7626-1-git-send-email-chris.laplante@agilent.com>
	<CANNYZj_ykVaOvq4EKtJ=7qpTNt5HcdpYqE+z4dRpqNQH-6ykYA@mail.gmail.com>
	<CY4PR12MB1653B3168D82F8A1E6AC390C8BC00@CY4PR12MB1653.namprd12.prod.outlook.com>
	<67699ebfc6de01ea166ea537a64ff658c9f3b14b.camel@linuxfoundation.org>
	<d7938e72-8955-354a-112a-873a00492eb3@windriver.com>
In-Reply-To: <d7938e72-8955-354a-112a-873a00492eb3@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7da21298-f78a-471c-4859-08d714376479
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:CY4PR12MB1720; 
x-ms-traffictypediagnostic: CY4PR12MB1720:
x-microsoft-antispam-prvs: <CY4PR12MB1720F65DF90C0552DF1CFEA78BDD0@CY4PR12MB1720.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(366004)(199004)(189003)(29502001)(2906002)(9686003)(71200400001)(71190400001)(53936002)(33656002)(6246003)(66446008)(68736007)(8936002)(25786009)(64756008)(55016002)(5660300002)(4326008)(52536014)(476003)(486006)(81166006)(6436002)(81156014)(74316002)(8676002)(305945005)(7736002)(66556008)(54906003)(110136005)(7696005)(76116006)(76176011)(66066001)(66476007)(66946007)(229853002)(3846002)(6116002)(446003)(11346002)(102836004)(478600001)(6506007)(256004)(14444005)(186003)(99286004)(86362001)(26005)(14454004)(316002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1720;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IQLy+SRuSICFcwkmNnRb0yDBBEp9235SPIPQvL9q3AEX4SooOu6bVURBRgDVpLxKTQiiIVqm3Zghl91CkARQeNgW21MRzhA9rcroEwxdt/N1ZPwoCW0LGTnNh0QQvq0O6QtT/EQ+2kG4ZiSgteGnGmrhS6Ru7wJxGihxVlm4PHaZDnrzSpdiPUP6vkpjhEe6Ae1/AgjBlhpct25Q/BCVvGddRS3CL22y0/JLDLFBY3n6pNwpdXYqIp8U0MtJ8w0bS/6fCT8Y6BRxOEgc+ILjdB3evRDxeBznrXYvrtCdsyqMtuBoqCzbEOstbp4ePi4dAW093b2wzz/xRAlAa8RGxGJkkBlfpQKpyJW3htyES6ZHCigE+UPIvxN9vVmqpaPlnjFRvC/r8b0TzDGdnqBYXEkHdW33mBODWyrVNwtKB7o=
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da21298-f78a-471c-4859-08d714376479
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 15:14:03.6901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chris.laplante@agilent.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1720
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: UNVERIFIED SENDER Re: [PATCH] fetch2: add ability to skip recipes when get_srcrev fails via BB_FETCH_SKIP_ON_SRCREV_ERROR
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
X-List-Received-Date: Mon, 29 Jul 2019 15:14:05 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBJIGFncmVlLCBJIGRvbid0IHJlYWxseSBsaWtlIGF1dG8gc2tpcHBpbmcgaW4gdGhpcyBjYXNl
IGFzIGl0IHdpbGwgbWFrZSBpdA0KPiBkaWZmaWN1bHQgdG8gZGV0ZXJtaW5lIG9yIHJlc29sdmUg
aXNzdWVzIGZyb20gZGlmZmVyZW50IHVzZXJzLg0KPiANCj4gQnV0IEkgZG8gd29uZGVyIGlmIHRo
aXMgaXMgYSBzcGVjaWZpYyBVUkwvU1JDUkVWIHRoYXQgaXNuJ3QgYXZhaWxhYmxlIHRvIHRoaXMN
Cj4gdXNlciwgb3IgaXMgdGhpcyByZWxhdGVkIHRvIEFVVE9SRVY/DQo+IA0KDQpJdCdzIGEgYml0
IG9mIGJvdGguIEZvciBzb21lIG9mIHRoZXNlIHJlY2lwZXMsIHRoZSBub24tcHJpdmlsZWdlZCB1
c2VycyBoYXZlIGFjY2VzcyB0byB0aGUgdXBzdHJlYW0gc291cmNlIGNvZGUgdXNpbmcgYSBkaWZm
ZXJlbnQgbG9naW4gbmFtZS4gRm9yIGEgaGFuZGZ1bCBvZiBvdGhlcnMsIHRoZXkgaGF2ZSBubyBh
Y2Nlc3Mgd2hhdHNvZXZlci4NCg0KRm9yIHRoZSBmb3JtZXIgY2FzZSwgSSBoYXZlIGEgY2xhc3Mg
dGhhdCByZXdyaXRlcyB0aGUgU1JDX1VSSXMgaW4gYSBSZWNpcGVQcmVGaW5hbGlzZSBldmVudCBo
YW5kbGVyLiBGb3IgdGhlIGxhdHRlciBjYXNlIEkgYW0gY3VycmVudGx5IHVzaW5nIHRoZSBmb2xs
b3dpbmcgY2xhc3MgKHdoaWNoIHR1cm5zIG91dCB0byBiZSBzaW1pbGFyIHRvIHdoYXQgUmljaGFy
ZCBzdWdnZXN0ZWQpOg0KDQphZGRoYW5kbGVyIHNraXBfZXZlbnRoYW5kbGVyDQpweXRob24gc2tp
cF9ldmVudGhhbmRsZXIoKSB7DQogICAgdHJ5Og0KICAgICAgICBiYi5mZXRjaDIuRmV0Y2goZC5n
ZXRWYXIoIlNSQ19VUkkiKS5zcGxpdCgpLCBkKQ0KICAgIGV4Y2VwdCBiYi5mZXRjaDIuRmV0Y2hF
cnJvcjoNCiAgICAgICAgcmFpc2UgYmIucGFyc2UuU2tpcFJlY2lwZSgic2tpcC1pbmFjY2Vzc2li
bGU6IGNvdWxkIG5vdCBhY2Nlc3MgdXBzdHJlYW0gcmVwbzsgY2hlY2sgU1JDX1VSSSwgYWNjZXNz
IHJpZ2h0cywgYW5kIG5ldHdvcmsgYXZhaWxhYmlsaXR5IikNCn0NCnNraXBfZXZlbnRoYW5kbGVy
W2V2ZW50bWFza10gPSAiYmIuZXZlbnQuUmVjaXBlUHJlRmluYWxpc2UiDQoNCkkgaGF2ZSBoZWFy
ZCBhbmQgZnVsbHkgYWdyZWUgdGhhdCBzdWNoIHN0dWZmIHNob3VsZG4ndCBiZSBpbiB0aGUgY29y
ZS4gSXQncyBjZXJ0YWlubHkgbm90aGluZyBJIHdhbnRlZCB0byBoYXZlIHRvIGltcGxlbWVudCA6
KQ0KDQpIb3dldmVyLCBJIGZlZWwgbGlrZSBpdCB3b3VsZCBiZSBuaWNlIHRvIGhhdmUgc29tZXdo
ZXJlIHRvIGRvY3VtZW50IHRoZXNlIGtpbmRzIG9mIHJlYWwtd29ybGQgcHJvYmxlbXMgd2l0aCBu
b24tb3B0aW1hbCBzb2x1dGlvbnMsIGZvciB0aGUgYmVuZWZpdCBvZiBvdGhlciBwZW9wbGUgZGVh
bGluZyB3aXRoIGFjY2VzcyBjb250cm9sbGVkIHNvdXJjZSBjb2RlLiBQZXJoYXBzIHRoaXMgZW1h
aWwgY2hhaW4gaXMgZG9jdW1lbnRhdGlvbiBlbm91Z2g/DQoNClRoYW5rcywNCkNocmlzDQo=

