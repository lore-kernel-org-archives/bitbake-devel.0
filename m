Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.41])
 by mx.groups.io with SMTP id smtpd.web08.15642.1604945339686235625
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Nov 2020 10:09:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=zz/vxk02;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.41, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krsfSma/pjMtSuaiVNWSj5DfCkKegUZvceJFCPy7HwZwLd0JefSSNaEW0Ldvl6eF60Y3txNALlKrjdzBKIox/ejqmHg8wlFcpHdF0SOEntnvoFqOEDnWzLIzcImpKFUlkn3X+fWMaTVmaHheLG1GSA7Gh6RH95iB0FXsnk3hC/7l0y4pynQdhdaYntFUMaGgTJRaie1NJMGMSdD66ADBs57qDVCXH2BEk6UnzRGaqVFwZ1N88CoZXcr1ox1kterOp/PQ97vwQ+wL1qDLMTkLLZXfctsX+ciRAJMVSb/NkIwFyNzIZpReGs5ymvbZYTS7vY/JPrdoP5NP3o+z7ET3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJZSiG32y4c4vkXUSi40Pq9QJLL0gvZnlo2G1m2DUpI=;
 b=RWhNJb2VQvAQR5vZegd3lRJNtLOZwY4PGhl8nPmVIL2zteTyEkSNnhxBgukUqcb1ozkS72Puxc/0MzG/8fmr7/0viFk1RURwKVaugx5AZt3J8P9jUH3pnaeFnuVA8/yIqQFYwU/IS65K/DDCaHljjgatoWoWFu+e7JJvmWAZdkfTM6B1HdnqJ2yssdwWOQJ46csE9atoGBo6wukfvTL0uafMMoGf3Jd0ssQ9r5zaXHVSeVqGQRGW40nJBmaDWyf1WA/eEjNax+5OhGksZH05lErpyv0/38dTFT3vw2SAcRmE3SSklEw1Ac5h3ukABbA/urQrDt2lnUiZfEYjAzacsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJZSiG32y4c4vkXUSi40Pq9QJLL0gvZnlo2G1m2DUpI=;
 b=zz/vxk02cPAq3lttVHaMG4GFphTDwHzO8peMD6QESWZs6miPY/zrAdv/QehDJMEMag3oLVf03DB+YjfzBLCR3QNmxtxlpRZCAtIATuLGVj4WvBqIvex/p08AqljWFj13138ISf0wBl3WXa8VAacL1AUKSeKyWWkBRcwGrOJnQpbXtm3ddVFk//CgfesAun5hjtcju8AItbxcUQiRcJ3RipSkFrxfKslqgmNEbstfaYrUAW/eYAjzUTCTCCez24TGNYSv4n/sxS8kGkS68ykg0mEVf/Lh/m26830Tgw0/LarO9wFQ1yv8e1+eS46iGJNe1NcSvRh9LS+H8GOjXTzMHw==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Mon, 9 Nov
 2020 18:08:58 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1%3]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 18:08:58 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] build: defer processing of cleandirs until after lockfiles are acquired
Thread-Topic: [bitbake-devel] [PATCH] build: defer processing of cleandirs
 until after lockfiles are acquired
Thread-Index: AQHWsfRoMhm/XIzvH0aYJAycu5GxLqm9TSuAgALUscA=
Date: Mon, 9 Nov 2020 18:08:58 +0000
Message-ID: 
 <SN1PR12MB248037DDEABD10624D2924C78BEA0@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201103151537.19348-1-chris.laplante@agilent.com>
 <940c12c0b27567eab634098ac0de1c7dbffaed65.camel@linuxfoundation.org>
In-Reply-To: 
 <940c12c0b27567eab634098ac0de1c7dbffaed65.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edb55750-a9e9-40bf-ddf9-08d884da878a
x-ms-traffictypediagnostic: SA0PR12MB4541:
x-microsoft-antispam-prvs: 
 <SA0PR12MB454116D8639E875372CAC1EE8BEA0@SA0PR12MB4541.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wS/OWxl1JEv99WQEXnbkdMfnx/tACP/qilChJo1jspjIr54/ARp3WRH+XtE7b1IRIDYkr5t9X9r3M0nBrateDzpg7yqD4r40Bnb3WNwy+K/+q8xup1ELZM8tqkYjDOIgwfeXgj0S0Ff6thgOCzoEa3VQRzMtuJZ3bXuCU01n/+VInu53+TXjNOiI8sFiyWvDKBGDWjubc6nDaxMCNdBYUTd/udksSmd6ylLAejZhQJvdFYLKLZRMURXOcQG7SASln2XAyUIoqpnSs1rVJjz0ssXyGY6pdNlghzbCANawxS6VPb9VsuiORxG6R/IPbrC36OmLx1fTjfOqdzJXalR4JTby3xTCh3BSTPsXwRTaraw1WUPj+KKIfEkcG0BgBSNle8I1XwuByZVvxkCnDdxBy0TcOxwPjXpE4HKMjz5mAv/EnUImyOzvzYacL43uQAtrYDFcGT/vAyO/SmI6c60LYQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(29502001)(478600001)(316002)(110136005)(55016002)(52536014)(64756008)(66446008)(6506007)(26005)(66556008)(66476007)(8676002)(83380400001)(2906002)(8936002)(7696005)(966005)(86362001)(33656002)(66946007)(5660300002)(9686003)(71200400001)(76116006)(45080400002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 +eE1XGBRocywWpuVquHVEm5LE1YIUjAvoZD3CBko5S960tfgtpaCwnlpj3cRcCxyN8DNLJWGXTaahh3PPLBIboZJkmGNDBNgu/vnToIGEXH6adFiA2xRc8f+veclq6GWVm+slnKg8YmnoM6bbG66oQZvxAUIEFi4YWzzNV/pTvKl+++16WChq9pab91yqdDj2zbYsxjZrBQWARUlEb4Ivv0dHdb06VmnbInkqmvlRlw+wBWwLltavSoaHjkdoT88BsPQAP0kuG3Kgy0UzYqokVVvynOy0ughYYrnE6xTVo6CM4H3oTL3FJ1SGqeN+qa0jW0cMoBDv/Q1QTDNlH0KvGhSqIDyGHEZ3/7Trq0NgHac4ui7oZjCawst2X//vXt0izTb6ObiCHtcbZPYJaWdSesp53r0NS4QhhcHugNr4/lXBUaa6MnL+KLAjNcQbFb4b5m1knmruLjimL31tQCqtLwnlfJvp8vsGjzGMPt2tbnDMwO1nL9wiOC7hRikISr/e8zKX3hvIVaRwitk5P8MrOi0LkylzLE/qvJTpL6iAf9a2dKdEmslC9D9xtlCk1JN8zJqcNopsK7FHKbAk8BJRwAblpdjrkG8h4KdNoXwWdcWoj3PCJ5cku1cxf07nGKODQZzGasxGm9xMfIFCp81+w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb55750-a9e9-40bf-ddf9-08d884da878a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 18:08:58.4107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7zXZXtYRdynICMAnz9fyHEvXP8y32in74ekjN2bt37jc9szGg/tHDemjAtxouAqiLh7lCvC/9rRY1//AOYHgMlsY0+37k1gwYz2A1LDtsFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4541
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+IEl0IGlzIGN1cnJlbnRseSBiZWxpZXZlZCB0aGF0IG5vcm1hbCBbZGlyc10gaGFuZGxpbmcg
aXMgZmluZSBhcy1pcy4NCj4gDQo+IFVuZm9ydHVuYXRlbHkgdGhpcyBjYXVzZWQgYWxsIGtpbmRz
IG9mIHdlaXJkIGJ1aWxkIGZhaWx1cmVzIGluIHRlc3Rpbmc6DQo+IA0KPiBTZWUgdGhlIGJ1aWxk
cyB0cmlnZ2VyZWQgYnk6DQo+IGh0dHBzOi8vbmFtMTIuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmF1dG8NCj4gYnVpbGRlci55b2N0b3Byb2plY3Qu
b3JnJTJGdHlwaG9vbiUyRiUyMyUyRmJ1aWxkZXJzJTJGODMlMkZidWlsZHMlMg0KPiBGMTU1MCZh
bXA7ZGF0YT0wNCU3QzAxJTdDY2hyaXMubGFwbGFudGUlNDBhZ2lsZW50LmNvbSU3Q2VlOTQ3NTY5
DQo+IGUxMDA0NmU2ZmFkYzA4ZDg4MzZmYWRkOCU3Q2E5YzBiYzA5OGI0NjQyMDY5MzUxMmJhMTJm
YjRhNWMwJTdDDQo+IDAlN0MwJTdDNjM3NDAzODYyOTcyMjk3MDMyJTdDVW5rbm93biU3Q1RXRnBi
R1pzYjNkOGV5SldJam9pDQo+IE1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklr
MWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMA0KPiAwMCZhbXA7c2RhdGE9bzBhRGkxeTM5SFpWRW12
alNNUmN3YjRDWEk2aWdzU3JwYWFROGVmR0pyWSUzRCZhbQ0KPiBwO3Jlc2VydmVkPTANCj4gDQo+
IEkgcmV2ZXJ0ZWQgdGhpcyBjb21taXQgYW5kIHRoaW5ncyBzdGFydGVkIHdvcmtpbmcgc28gdGhl
cmUgaXMgc29tZXRoaW5nDQo+IHdyb25nLg0KDQpJJ3ZlIGdvdHRlbiB0byB0aGUgYm90dG9tIG9m
IHdoeSBhdCBsZWFzdCBzb21lIG9mIHRoZXNlIGZhaWxlZC4gSXQgdHVybnMgb3V0IHdlIGRvIG5l
ZWQgdG8gbW92ZSBbZGlyc10gcHJvY2Vzc2luZyBhZnRlciBbY2xlYW5kaXJzXSwgc2luY2UgdGhl
cmUgbWlnaHQgYmUgc29tZXRoaW5nIGxpa2U6DQoNCmRvX3Rhc2tbY2xlYW5kaXJzXSA9ICIke01Z
X0RJUn0iDQpkb190YXNrW2RpcnNdICs9ICIke01ZX0RJUn0vc3ViZGlyIg0KDQpXaGVuIFtkaXJz
XSBoYXBwZW5zIGJlZm9yZSBbY2xlYW5kaXJzXSwgdGhlbiAke01ZX0RJUn0vc3ViZGlyIGlzIGNy
ZWF0ZWQsIGJ1dCB0aGVuIHRoZSBlbnRpcmUgZGlyZWN0b3J5IGlzIHdpcGVkIGJ5IFtjbGVhbmRp
cnNdIGhhbmRsaW5nIGxlYXZpbmcganVzdCAke01ZX0RJUn0uIA0KDQpJIGFtIHdvcmtpbmcgb24g
YSB2MiBvZiB0aGUgcGF0Y2ggdG8gZml4IHRoaXMuIEkgYW0gYWxzbyBnb2luZyB0byBhZGQgYSBz
YW5pdHkgY2hlY2sgdG8gZW5zdXJlIHRoYXQgW2xvY2tmaWxlc10gZG9uJ3QgaW50ZXJzZWN0IHdp
dGggW2NsZWFuZGlyc10sIHNpbmNlIG90aGVyd2lzZSBwcm9jZXNzaW5nIG9mIFtjbGVhbmRpcnNd
IHdvdWxkIHJlc3VsdCBpbiB0aGUgZGVsZXRpb24gb2YgbG9ja2ZpbGVzIHRoYXQgYXJlIGFjdGl2
ZWx5IGJlaW5nIHVzZWQuIEkgaGF2ZSBubyByZWFzb24gdG8gYmVsaWV2ZSB0aGF0IHRoaXMgaXMg
Y3VycmVudGx5IGEgcHJvYmxlbSBpbiBwb2t5LCBidXQgSSB0aGluayBpdCdzIGEgZ29vZCBpZGVh
IHRvIGNhdGNoIHRoaXMuDQoNCkNocmlzDQoNCg==
