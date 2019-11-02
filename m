Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr700063.outbound.protection.outlook.com [40.107.70.63])
	by mail.openembedded.org (Postfix) with ESMTP id 36E49762B3
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  2 Nov 2019 23:11:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=lwy/tj+76EcegHTLFXzYiI0YVvRxigdf6oxk+v0Iw1jUB1CZXTXQn/WM+5Np0MPgr9Ou2paUdkt/7pQ6Upkkaqes0utBDOOhYpd+uT0jCqVbf5Qc9MIEyohyMQ79isFEiVAqE52yd3sCxGlJm+hmFwrwqcrIS4ekJp4oYlh++ydVQaDpIzY+p7/uixVysG3HRD7kSRYwwKBjiZnxoTJGsQeZpFoWkSq4IYhL6w7cUDMzxMpJDUik4RT5MAX4xxn59gR3RlxQMLYDB6hXFizGWhcKKxX4DYDfdAfVdwqu7odEYvrVCOc5EvyzxxnMbitC4Fk3QVTwQdKbAAfFroEvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=2631FLoN1AAzMQMEGltCS9R7ZFwFly6/KCgVRYK6Qq8=;
	b=BdvAyqWiP3caB+mad5H/1EwaDtzH5kAoJ8YaZSrz7tOCpl7FMj7EO6RcUSiMGu1cWUWwb8jUIqx9Qt3FE+vViwqeYZbBNRY3hJtgvcvhK8YyTZVVhe/d5JxIkB1abspcZxKqaqIx+gF5erHo9wkXdS7nNt/+0PwUECJGMkuZfyDFin/MwiCddLEmJ/0l79vbOMuH2zCfkY333qeUwmHaUvWNTXzo2HQ0XSO8Nxe/p4w3YK7iS9oRCgfdxbO7nPQsP0IyMDwDe3HH62ojDpePWrCzmE08aQTCW6LqcHZESNfNIwN/Ju/t2fFtk1cx41yNqcx2KMoIcy8qoQh5Q1kcmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=2631FLoN1AAzMQMEGltCS9R7ZFwFly6/KCgVRYK6Qq8=;
	b=NYnFJkYYjq2M01YsTDFmoYfEJZZUtKEeAh8IZnQqGCEh7cjRiVYYpoIv1V+xJsjOwGF4lWOkUhOsCPOCHmHaO2lcHTb8LEc95JBcaXtI2XQJYMuhcKbM2GcjVYMEqtO43vnrZgv6PD6mNBJPVxBFlzQ3Rm8h8VTM498TFhrbvvI=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1207.namprd12.prod.outlook.com (10.168.165.7) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2408.18; Sat, 2 Nov 2019 23:11:28 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::fdcf:99b9:ab44:4986]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::fdcf:99b9:ab44:4986%5]) with mapi id 15.20.2387.028;
	Sat, 2 Nov 2019 23:11:28 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: command: add getOverrideData
	command
Thread-Index: AQHVkBG+ZtQDzdJ3tkeVmF9E32Yz26d4XCAAgAAmxhA=
Date: Sat, 2 Nov 2019 23:11:28 +0000
Message-ID: <CY4PR12MB16530722ADF132F7AE920D908B7D0@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <1572543354-4229-1-git-send-email-chris.laplante@agilent.com>
	<5375964a726a0a4790c99137a52227a66e09b243.camel@linuxfoundation.org>
In-Reply-To: <5375964a726a0a4790c99137a52227a66e09b243.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.14.114.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27de2c89-dcfd-486a-de09-08d75fe9fdc6
x-ms-traffictypediagnostic: CY4PR12MB1207:
x-microsoft-antispam-prvs: <CY4PR12MB1207E65D2D1786E61D2DB0FA8B7D0@CY4PR12MB1207.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(29502001)(189003)(199004)(6246003)(6506007)(52536014)(7736002)(5660300002)(186003)(74316002)(305945005)(99286004)(86362001)(14454004)(25786009)(446003)(81156014)(8936002)(110136005)(11346002)(478600001)(486006)(71190400001)(66066001)(476003)(71200400001)(66946007)(66556008)(76116006)(66476007)(64756008)(66446008)(8676002)(55016002)(33656002)(81166006)(3846002)(2906002)(9686003)(316002)(229853002)(7696005)(102836004)(26005)(76176011)(2501003)(256004)(6436002)(6116002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1207;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fSDYbaY93Cv7gcee85iB/nK6oH0U2HaN7rDFdTvgpiQuL4tqqrsvwxFqPbXS38Q+gdbBybKP4yFnZnv5dUhHf3xchHTWiBiirMy29nBYvQ5hevNU3hTdyB1b0KgXi1ipxAjlOW/qx6PZbEsHzMvOUV34LBfCQYRE56FmeSDIVZnU5pqWAaSrdJU19gGjC9EXeEXobT78cOTxzUOxDzkdMZ3PfEfloR47pfv9v/8JUQi1+JLb/vUBWCR2wepN5/202idk3PUp5YRG1/29lkksVZbhvEchS8Yc0vAgR1dGT6NwfIGY7S6X7/wf7sN8i4YbzOHpopo/0zE7zz3idXnHfBK0fuQ/6bkYAFv8BSd2ah5v5lMPJ8SPhuY2vpwZ3AJCVviocbmIabVzu2/ISANm2NMruKtHCdgbtKMEzNUOmkxYKhBC3Ngc0EaeowLVKrLH2/FifD5CtKf067H/yll5dQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27de2c89-dcfd-486a-de09-08d75fe9fdc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 23:11:28.4982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b72XN0MJR7Lzk2glYsNg742NOV/B51raihPJDNBe2NwOz+GNrIeYFlHU/JKcdFsF9na8qCFd1XpjIjx63SW6fCyQtdm/qOH6IjQnBoeqWxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1207
Subject: Re: [PATCH] bitbake: command: add getOverrideData command
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
X-List-Received-Date: Sat, 02 Nov 2019 23:11:29 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUmljaGFyZCwNCg0KPiBUaGUgcXVlc3Rpb24gaGVyZSBpcyB3aGF0IGlzIHRoZSB1c2VjYXNl
Pw0KPiANCj4gVGhlIG92ZXJyaWRlIGRhdGEgaW4gdGhpcyBmb3JtIGlzIHJlYWxseSBhIGRhdGFz
dG9yZSBpbnRlcm5hbCBhbmQNCj4gc2hvdWxkbid0IGJlIHNvbWV0aGluZyB3ZSBleHBvc2UgYW4g
ZXh0ZXJuYWwgQVBJIGZvci4gSXQgaGFwcGVucyB0bw0KPiBleGlzdCBpbiB0aGlzIGZvcm0gZm9y
IHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIHRoZSBkYXRhc3RvcmUgYnV0DQo+IGl0IGRp
ZG4ndCB1c2VkIHRvIGFuZCBtYXkgbm90IGFnYWluLCBkZXBlbmRpbmcgb24gaG93IHdlIGNoYW5n
ZSB0aGF0DQo+IGltcGxlbWVudGF0aW9uLCBwYXJ0aWN1bGFybHkgYXMgcGVvcGxlIGxvb2sgYXQg
cGFyc2luZyBwZXJmb3JtYW5jZS4NCg0KV291bGQgaXQgbWFrZSBtb3JlIHNlbnNlIHRvIGNvbWUg
dXAgd2l0aCBhbiBleHRlcm5hbCByZXByZXNlbnRhdGlvbiBvZiB0aGUgZGF0YSB0aGF0IHdlIGNv
dWxkIGV4cG9zZSBhcyBhIHN0YWJsZSBBUEk/DQoNCk15IHBhcnRpY3VsYXIgdXNlIGNhc2UgaXMg
dGhhdCBJIG5lZWRlZCB0byBpZGVudGlmeSBpZiBhbmQgd2hlcmUgU1JDUkVWIGlzIGdldHRpbmcg
b3ZlcnJpZGRlbiBmb3IgcGFydGljdWxhciByZWNpcGVzLiBGb3IgaW5zdGFuY2UsIHNvbWVvbmUg
bWlnaHQgaGF2ZSBhZGRlZCBhIFNSQ1JFVl9wbi1yZWNpcGUgdG8gdGhlaXIgbG9jYWwuY29uZi4g
SSBhbSB3b3JraW5nIG9uIGEgdG9vbCB0aGF0IHByb2R1Y2VzICJidWlsZGhpc3RvcnktY29sbGVj
dC1zcmNyZXZzIi1zdHlsZSBvdXRwdXQgZnJvbSB0aGUgU1JDUkVWIGNhY2hlIGl0c2VsZiwgd2l0
aG91dCBhY3R1YWxseSByZXF1aXJpbmcgdGhhdCBidWlsZGhpc3RvcnkgaXMgZW5hYmxlZC4gSXQn
cyBhY3R1YWxseSBhIGdlbmVyYWwgdG9vbCB0byBpbnNwZWN0IGFuZCBtYW5pcHVsYXRlIHRoZSBT
UkNSRVYgY2FjaGUuIE15IHRlYW0gdXNlcyBBVVRPUkVWIHByZXR0eSBleHRlbnNpdmVseSwgc28g
dGhpcyBraW5kIG9mIHRvb2wgd2lsbCBiZSB2ZXJ5IHVzZWZ1bCB0byB1cy4NCg0KQ2hyaXMNCg==

