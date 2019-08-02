Return-Path: <chris.laplante@agilent.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
	by mail.openembedded.org (Postfix) with ESMTP id EC6E47C7A2;
	Fri,  2 Aug 2019 14:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=WguDU493qMmO2dtQaObJX75Wh7wnneTRAqYNBi1L4hpNR/ieCY4WJVa4M/tmwd2nOlodMe/vClRYQPMWYyNuxOOhe2BwJGC55QMVp7/i7l0hlvbsXEdJ9cbHkNmnPmKte73xbsZQQ/wx4OzkKVx5T9jyrhM/YGXwlN0S9YaBAi6KiOE91jmmwIkwLq8B1/bk/Vskfbb7Vdtsp905TtEKY7I8U250jGyv4Lxin2KrbNr5b1IQdb8pf8KEt9/uY6OnFJ/E2C6gAM92qfVAaKOk0jyheLWhIFXDknhD9rMaon3rttVasTpiEWAdzvIyq15rZp3MNAHz9kgAFyaGwMNK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=y0kr9Z11wZtVzEXgdsRITxnXztBN560h9nIVG47o9kY=;
	b=j7wIqGVkpFlW0mPFUzIzWTpELE/TID6ndDTHwKb0rOuYDytJy98NGKeLiknyK4id9/NJ7h9WARSGT0QhboGXD12JGXBkLEF05+jaAGTzjFlXnp1U/S8BAL/mLvLXg6vgOvRwSq5iGwu1saJ8aV0IFGUgpuUXa5vJRrInzdSLi9hOlTB6lpkvdRO3ANvmfAOYLNfpLklMilaygWC/jS2Dim12xsh8Qowh5Ikg0f2tevkr53zCdAmlhlUubIo4zrk1U7Q9bnxRvoiBpN6j4Ds03yy6xL4UWy4GA8QpBHfBHad/KMp+G9wznsHvzRqeTfug8JfMnESRjeNhXVA+f+jZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=agilent.com;dmarc=pass action=none
	header.from=agilent.com;dkim=pass header.d=agilent.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=y0kr9Z11wZtVzEXgdsRITxnXztBN560h9nIVG47o9kY=;
	b=PbJ8xDjgSon3emII5QfKd2FJ+zoup1Od/VF3sCWXemA+2crIUEguXnaRnnUqyBWbrnsXrQc/qTmhtg7OvphtsnpqiYdND39/YQfQbd6VfHLZ+18PlOZKroT56OVD2SlWbTFxMHyFrE9kt4vKU5e1KQqWkkmZKv65RtAx4lei/f0=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1510.namprd12.prod.outlook.com (10.172.68.147) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2136.17; Fri, 2 Aug 2019 14:03:52 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc%9]) with mapi id 15.20.2136.010;
	Fri, 2 Aug 2019 14:03:52 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: William Bourque <wbourque@gmail.com>, "Mikko.Rapeli@bmw.de"
	<Mikko.Rapeli@bmw.de>
Thread-Topic: [OE-core] RFC: exposing information about the SRC_URI(s)/branch
	via buildhistory (or similar mechanism)
Thread-Index: AdVIiV4bZ0XUaI6MTqawP3i+Dxw25gAawieAABGACQAAAB6ikA==
Date: Fri, 2 Aug 2019 14:03:52 +0000
Message-ID: <CY4PR12MB1653BAE831B8D2E97561E35D8BD90@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <CY4PR12MB1653C06268B3B4B862119BE18BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
	<20190802073741.GI3459@hiutale>
	<CANBSh+OGvD1wqrXGRfufYf2KpKJPM44fUcoeangTBVMSJBKxRg@mail.gmail.com>
In-Reply-To: <CANBSh+OGvD1wqrXGRfufYf2KpKJPM44fUcoeangTBVMSJBKxRg@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cde42e9e-3cd0-4336-c236-08d71752400b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:CY4PR12MB1510; 
x-ms-traffictypediagnostic: CY4PR12MB1510:
x-microsoft-antispam-prvs: <CY4PR12MB15104D4D8A6171B9BBC83A7F8BD90@CY4PR12MB1510.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(29502001)(199004)(189003)(8936002)(4326008)(76176011)(446003)(486006)(71190400001)(71200400001)(6436002)(476003)(66066001)(7696005)(99286004)(6246003)(229853002)(33656002)(53936002)(5660300002)(26005)(316002)(54906003)(110136005)(186003)(11346002)(55016002)(74316002)(86362001)(9686003)(66946007)(2501003)(66476007)(66446008)(64756008)(66556008)(256004)(305945005)(76116006)(52536014)(53546011)(2906002)(7736002)(68736007)(6116002)(6506007)(478600001)(8676002)(102836004)(3846002)(81166006)(81156014)(25786009)(14454004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1510;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5BFJ9cEKEjJqhxQua3mwhArgo1MG0nu1BEj/flQjtRfMsUnxb5NkHWZctaadXhXoUZFT2VMTGwllCYH8ajlrsTLi4/ClCFamTRxEkift4ifhDkZUbO1tG+dxT2ZVncCz8hpap/7xrg2kQx7NmkkZDaIHHkqgWsXymVZ5ELTKLPFi/NPWVYpPS3qNUwmXexAtP2N2w68n3g2eHQjz4TVaOxxp0h9TGTGx9avkfkdK3dE9hc9pLp4vlo0E0r4Yu4QK64ykeZqrz+djezKamTj+pq0hNnzgZVeX/UoGx/gDNyCRQ5nYnvZtM4JB8jo7vZng7XMvfZJhjBrqAx7rhsyaMCm0hT/ZAFq2JzIquDzExxvtjfZKhtErFfjdkyMwhuVX1PA8zIpN4t+fdRXwVGlYfMqJrrTcsSn9DSaj7nvX5PY=
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde42e9e-3cd0-4336-c236-08d71752400b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 14:03:52.4064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chris.laplante@agilent.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1510
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"Openembedded-core@lists.openembedded.org"
	<Openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] RFC: exposing information about the SRC_URI(s)/branch via buildhistory (or similar mechanism)
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
X-List-Received-Date: Fri, 02 Aug 2019 14:03:53 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBJJ2QgYmUgY3VyaW91cyB0byBzZWUgdGhlIHBhdGNoZXMuDQo+IEl0J3MgZGVmaW5pdGVseSBz
b21ldGhpbmcgd2UgY291bGQgdXNlIGhlcmU7IHdlIHVzZWQgdG8gaGF2ZSBuaWdodGx5DQo+IGJ1
aWxkIGNoZWNraW5nIHRoZSBidWlsZCB1c2luZyBBVVRPUkVWIGFzIHdlbGwuDQo+IA0KPiBPbiBG
cmksIEF1ZyAyLCAyMDE5IGF0IDM6NDMgQU0gPE1pa2tvLlJhcGVsaUBibXcuZGU+IHdyb3RlOg0K
PiA+DQo+ID4gSGksDQo+ID4NCj4gPiBPbiBUaHUsIEF1ZyAwMSwgMjAxOSBhdCAwNDo1MTozOFBN
ICswMDAwLCBjaHJpcy5sYXBsYW50ZS0tLSB2aWEgT3BlbmVtYmVkZGVkLWNvcmUgd3JvdGU6DQo+
ID4gPHNuaXA+DQo+ID4gPiBJJ20gaW50ZXJlc3RpbmcgaW4gYWRkaW5nIFNSQ19VUkkgc3VwcG9y
dCB0byBidWlsZGhpc3RvcnkgKG9yIGEgc2ltaWxhciBtZWNoYW5pc20pLCBhbmQgd291bGQgbGlr
ZSB0byBnZXQgc29tZSBpbnB1dC4NCj4gPg0KPiA+IFllcyB0byB0aGlzLg0KPiA+DQo+ID4gQWxz
byB3b3VsZCBiZSBuaWNlIGlmIHRoZXJlIHdhcyBhbiBlYXN5IHdheSB0byBhZGQgYml0YmFrZSB2
YXJpYWJsZXMgdG8NCj4gPiBidWlsZGhpc3RvcnkuDQo+ID4NCj4gPiBJJ3ZlIHBhdGNoZWQgb3Vy
IHRyZWUgc28gdGhhdCBTUkNfVVJJLCBMSUNFTlNFIGFuZCBDVkVfUFJPRFVDVCBhcmUgYXJjaGl2
ZWQNCj4gPiBpbiBidWlsZGhpc3RvcnkuIFNSQ19VUkkgaGFzIG1hbnkgdXNlcyBhbmQgY2hhbmdl
cyBhbmQgcGF0Y2hlcyBjYW4NCj4gPiBiZSBlYXNpbHkgaWRlbnRpZmllZC4gU2FtZSB3aXRoIExJ
Q0VOU0UsIGFueSBjaGFuZ2VzIHRyaWdnZXIgYSByZXZpZXcuDQo+ID4gQ1ZFX1BST0RVQ1QgaXMg
ZXhwb3J0ZWQgc28gdGhhdCB3ZSBjYW4gZG8gUUEgY2hlY2sgdG8gbWFrZSBzdXJlIG1hcHBpbmcN
Cj4gPiBmcm9tIENWRV9QUk9EVUNUIGZvciBub24gQ0xPU0VEIGxpY2Vuc2VzIGV4aXN0cyB0byBO
VkQgZGF0YWJhc2UgcHJvZHVjdA0KPiA+IG5hbWVzIChtYWludGFpbmluZyBhIHdoaXRlIGxpc3Qg
b2YgcmVjaXBlcyB3aGljaCBkb24ndCBoYXZlIGFueSBDVkVzIHlldCkuDQo+ID4NCj4gPiBXZSd2
ZSBhbHNvIGNoYW5nZWQgdGhlIFNESyBuYW1lIHRvIGJlIHN0YWJsZSBhY3Jvc3MgYnVpbGRzIGFu
ZCBhZGRlZA0KPiA+IERJU1RSTyB0byB0aGUgcGF0aC4gSW4gb3VyIGNhc2UgSU1BR0VfTkFNRSBh
bmQgU0RLX05BTUUgd2lsbCBpbmNsdWRlDQo+ID4gZ2l0IHRyZWUgdGFnIGFuZCBoYXNoIGlmIHRy
ZWUgaXMgZGlydHksIHdoaWNoIGNoYW5nZXMgYnVpbGRoaXN0b3J5IFNESyBwYXRocw0KPiA+IGZv
ciBldmVyeSBidWlsZCB3aXRoIGRpZmZlcmVudCBpbnB1dC4NCj4gPg0KPiA+IEkgY291bGQgc3Vi
bWl0IHRoZSBwYXRjaGVzIGlmIHRoZXJlIGlzIGludGVyZXN0IGluIHRoZW0uDQoNCkkgbGlrZSB0
aGUgaWRlYSBvZiBpbmNsdWRpbmcgTElDRU5TRSBhbmQgQ1ZFX1BST0RVQ1QgYXMgd2VsbC4gSSB3
aWxsIGxvb2sgaW50byB0byBtYWtpbmcgaXQgZXh0ZW5zaWJsZSB2aWEgYSB2YXJpYWJsZSwgZS5n
LiBCVUlMREhJU1RPUllfUEFDS0FHRV9FWFRSQV9WQVJJQUJMRVMgb3Igc29tZXRoaW5nLg0KDQpD
aHJpcw0K

