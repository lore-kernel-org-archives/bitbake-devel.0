Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr680080.outbound.protection.outlook.com [40.107.68.80])
	by mail.openembedded.org (Postfix) with ESMTP id 840146BE2D;
	Thu,  1 Aug 2019 20:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=Vgubm+TBi1VnwUJYFyEo+sqzEwhSM+OueY5s2WGRh0oVwFqAwmF4IQTMuSvi+nqB9tUS/lWflAjCaoHsVIwKFdWkGoL22eF55qKdCJ280bm/S3O+sET2RAjfrNr8Zcq5kj6DJYveyhKtDS4q5MYsFaMB0oSTvpvGpUHLCgzTkMnvwhjyVbKWxrL9dezR10vlTI/XASbkRT2XLoA7tOYzZ1h/bWKfKzk0IqMdQ6MOyqfkuT33+9L56WWs1UPPqHpT+IhEn7WhqrxShoNMcrpPZD1qFM3nGqJB6VQPY4M+elkKzErnktejEnFF6hCEPFJueMFsGMuX+JzwQLaW9h5F4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=hFuc/035ASI8Wc90apsTwpvKHM9c3XCt2AO386HShRs=;
	b=hvI/QZ0LUhCezb2LJL01Z8C4Wjjua+8lH93UFzuCqHUuJLVnmC1sKxKnP0OZf6RhKkzmXgQbIqsext9qp8tJs7GirxUUAqRFdJHRmOAoo+lvJdeiSLTrZ9jp+STRdC87qab9zo+lIpxpT5nRZUYFj0oqjVKUZFlm/4YawhyOyru03AJQUAPggFISe0goRv7LUQ6+HsKS+vYG075RukFqv5CgE7EUyI484CXSs/mIob1X1MJ5fj2x4urtxtvdJzsnwvMg/Uv33g5epLI000NLs/oE+soncHX3IZIdkeTZxmG8iRsmIWqsVGREnyFq2iXo5KrMNhKnQoo0uYgQdEiepA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=agilent.com;dmarc=pass action=none
	header.from=agilent.com;dkim=pass header.d=agilent.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=hFuc/035ASI8Wc90apsTwpvKHM9c3XCt2AO386HShRs=;
	b=LU5wXb6I9i9JGvClDJWz8svHnscy7wkhLjt9QKgClieZ6k/92wfiFoa8fti4UmbqsKzmIrhnxhEZ+dIYcz6fuZqJKKnldaCy0eki6IFHEdQSHoy6ArC7Sc5LS+wgD6OEirPQQHR8Yk+bBjI/kLfNOyOaXwMmbwXakBzRwLtNuQg=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1158.namprd12.prod.outlook.com (10.168.168.143) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2136.12; Thu, 1 Aug 2019 20:18:59 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc%9]) with mapi id 15.20.2136.010;
	Thu, 1 Aug 2019 20:18:59 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Mark Hatle <mark.hatle@windriver.com>,
	"Openembedded-core@lists.openembedded.org"
	<Openembedded-core@lists.openembedded.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: UNVERIFIED SENDER Re: UNVERIFIED SENDER Re: [bitbake-devel] RFC:
	exposing information about the SRC_URI(s)/branch via
	buildhistory (or similar mechanism)
Thread-Index: AdVIiV4bZ0XUaI6MTqawP3i+Dxw25gAAV48AAAIZtdAAAOWOgAADxTCw
Date: Thu, 1 Aug 2019 20:18:59 +0000
Message-ID: <CY4PR12MB16531320849693B31BF37FFD8BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <CY4PR12MB1653C06268B3B4B862119BE18BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
	<baa880f5-9f42-9364-dd23-325837f791c5@windriver.com>
	<CY4PR12MB1653E78A4333D0184E5A67178BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
	<92bd027a-4edb-f23f-a7c8-cbd3d91543b3@windriver.com>
In-Reply-To: <92bd027a-4edb-f23f-a7c8-cbd3d91543b3@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [68.80.99.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c9a7eeb-e4b5-4aae-40b8-08d716bd7ce3
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:CY4PR12MB1158; 
x-ms-traffictypediagnostic: CY4PR12MB1158:
x-microsoft-antispam-prvs: <CY4PR12MB11588128ABF5044F1E430EAD8BDE0@CY4PR12MB1158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(366004)(376002)(136003)(39860400002)(346002)(29502001)(199004)(189003)(54534003)(14444005)(229853002)(71200400001)(86362001)(2201001)(71190400001)(66446008)(256004)(52536014)(53936002)(478600001)(9686003)(55016002)(74316002)(66556008)(66066001)(305945005)(110136005)(64756008)(7736002)(66946007)(6506007)(102836004)(186003)(2906002)(66476007)(14454004)(76116006)(7696005)(26005)(76176011)(11346002)(99286004)(446003)(8676002)(6246003)(476003)(486006)(33656002)(81166006)(81156014)(3846002)(6116002)(68736007)(5660300002)(2501003)(6436002)(25786009)(8936002)(4744005)(316002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1158;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oD6oMWptZr4P2EkpUKNcoy1rlRCjdgwXqe84eA/bb7AfWqglNd+1NFyFe9m4q7kfvYYSw83lW5h36fWggcXtlhfBAS/rSjIh6ZLhD/Uzk1UPEaE9EzwPJzUM+JsxPgLB4lQ3n95He1GufkvX7HGXng0AEKXKaBp6Pvi42FejSvP4PMt6I72OzxWOwGZisMqI8MTed+eofHdTVDExrsFZAsrRtWS8QHlWdj4BLgKyEHkJ1SEw3eO3AoWxQ5zH9yBzj0Atw4uCR9ZPLqLLnOcuys9+7i5IGQvgHAst1+qOozcBDWguJhQI9JzOo2eFxJTnERPfDoB3/x+1HYGJ545YNA0Xqm18BYR8Hh41pn6ft35RwuljtqembuMZjsoeHlXMCRuzs+d6w/fvWrac6eAo5sORr4WJw893TTsnD1rbZ1w=
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9a7eeb-e4b5-4aae-40b8-08d716bd7ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 20:18:59.4793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chris.laplante@agilent.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1158
Subject: Re: UNVERIFIED SENDER Re: UNVERIFIED SENDER Re: RFC: exposing information about the SRC_URI(s)/branch via buildhistory (or similar mechanism)
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
X-List-Received-Date: Thu, 01 Aug 2019 20:19:01 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+IFdvdWxkbid0IGl0IGJlIGEgYml0IG92ZXJraWxsIHRvIGFkZCBhIG5ldyBjbGFzcyBqdXN0
IHRvIGhhbmRsZSBTUkNfVVJJPyBJIHdvdWxkIHRoaW5rIGl0IHdvdWxkIGp1c3QgYmUgYSBsaXR0
bGUgZXh0cmEgY29kZSBpbnNpZGUNCj4gd3JpdGVfbGF0ZXN0X3NyY3Jldi4NCj4gDQo+IE9yZGlu
YXJpbHkgSSdkIHNheSB5ZXMuICBCdXQgUlAgaGFkIGNvbmNlcm5zIHRoYXQgdGhlc2UgY2hhbmdl
cyBhZGQgdXAgYW5kDQo+IHVubGVzcyBldmVyeW9uZSB3YW50cyB0aGVtIGl0IGNvdWxkIHByb3Zl
IHRvIGJlIGEgbWFpbnRlbmFuY2UgcHJvYmxlbS4gIEF0IHRoZQ0KPiB0aW1lIGhlIHdhbnRlZCBh
IHN5c3RlbSBmb3IgcGVvcGxlIHRvIG9wdCBpbiB0byBuZXcgZnVuY3Rpb25hbGl0eS4gIChJJ20g
bm90DQo+IHRyeWluZyB0byBzcGVhayBmb3IgaGltLCBqdXN0IHJlcGVhdGluZyB3aGF0IEkgd2Fz
IHRvbGQgd2hlbiBJIGFza2VkIGhpbSBhDQo+IHNpbWlsYXIgcXVlc3Rpb24uKSAgIEluIG15IGNh
c2UgdGhvdWdoIEkgd2FzIHN1Z2dlc3RpbmcgbXVjaCBtb3JlIGZ1bmN0aW9uYWxpdHkNCj4gdGhl
biBqdXN0IHRoaXMgb25lIGl0ZW0uDQoNCk1ha2VzIHNlbnNlLiBJIGRlZmluaXRlbHkgbGlrZSB0
aGUgaWRlYSBvZiB0aGUgYXV0b21hdGljIGNoYW5nZWxvZy4NCg0KRm9yIG5vdywgYXMgYSBxdWlj
ayBwcm90b3R5cGUgb2YgdGhlIGJhc2ljIGZ1bmN0aW9uYWxpdHkgKGNhcHR1cmluZyBTUkNfVVJJ
KSwgSSB3aWxsIGRvIGFzIHRoZSBiYmNsYXNzIHN1Z2dlc3RzIGFuZCBleHRlbmQgQlVJTERISVNU
T1JZX1BSRVNFUlZFLg0KDQpUaGFua3MsDQpDaHJpcw0K

