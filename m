Return-Path: <chris.laplante@agilent.com>
X-Greylist: delayed 57619 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 02 Jul 2019 09:46:26 UTC
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr810084.outbound.protection.outlook.com [40.107.81.84])
	by mail.openembedded.org (Postfix) with ESMTP id C18DB7EA62
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Jul 2019 09:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=uKAt51BJXAyE6eHR0v+MaToiSzj6XBERFTgpfcoTFFM=;
	b=GOyXo8BkqYaxdnC3N0o1RBPJ+Pwu9f3y4FJ0vl+GQL5dnDwWS2io91uwbUOsa+INQqY/PqqZTtiB1AKDcmNrcljZEXAeX0bPt8X6oEb6/nnhbeuCuGQKw+SesV94RyEEYYDhIDURVmnYUvL5Kc26y0a0m3l7Kebxg+SfO1M8V/w=
Received: from MW2PR12MB2540.namprd12.prod.outlook.com (52.132.180.159) by
	MW2PR12MB2522.namprd12.prod.outlook.com (52.132.180.153) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2032.20; Mon, 1 Jul 2019 14:13:56 +0000
Received: from MW2PR12MB2540.namprd12.prod.outlook.com
	([fe80::c586:fb2e:bce0:650e]) by
	MW2PR12MB2540.namprd12.prod.outlook.com
	([fe80::c586:fb2e:bce0:650e%6]) with mapi id 15.20.2032.019;
	Mon, 1 Jul 2019 14:13:56 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Alan Kozlay <alan.kozlay@ves-solutions.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Should multiconfig save build time?
Thread-Index: AQHVLddf8AHEHrG2UEmP5nOP0fJnaqa10kCQ
Date: Mon, 1 Jul 2019 14:13:56 +0000
Message-ID: <MW2PR12MB25406786F78B9051179B2B918BF90@MW2PR12MB2540.namprd12.prod.outlook.com>
References: <CAJE9sG=4MPryg2+h5a-jmhhpqPW=o6E26rte-JSPc31UioNbwQ@mail.gmail.com>
In-Reply-To: <CAJE9sG=4MPryg2+h5a-jmhhpqPW=o6E26rte-JSPc31UioNbwQ@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 494f1c88-5b10-4825-902e-08d6fe2e5aeb
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:MW2PR12MB2522; 
x-ms-traffictypediagnostic: MW2PR12MB2522:
x-microsoft-antispam-prvs: <MW2PR12MB25225C0EF0EAFD91E56C78278BF90@MW2PR12MB2522.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(29502001)(199004)(189003)(6506007)(99286004)(7696005)(76176011)(256004)(66066001)(81156014)(81166006)(8676002)(478600001)(74316002)(305945005)(7736002)(71200400001)(3846002)(6116002)(71190400001)(14454004)(68736007)(52536014)(9686003)(86362001)(6246003)(66446008)(66556008)(66476007)(66946007)(73956011)(2501003)(6436002)(55016002)(2906002)(5660300002)(53936002)(25786009)(64756008)(102836004)(33656002)(8936002)(26005)(110136005)(316002)(476003)(186003)(486006)(446003)(11346002)(229853002)(76116006)(21314003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2522;
	H:MW2PR12MB2540.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I64WQNbMCP4V+qYEWj+7Yjyrjb8NjS9+3FC/WSUFM5/t8ntBiYqLrgRgXf/19MNoIQ5F020jrSgg+BdgvrPQv4YvSH0jnY/zf1EJhMdgZYUtZXe2lEv/Gw4uVL3RkwIEqVYNeMRZZLCuJ2qmz60Ndj2NnN+8TDaLiM9VSyhysoGg/xzJ6NfIwZ6MoNCrlJiY45Hdxkct3trp2Xha3U0onR//FagvaYaTp7nnMDH+gZU4ESUn7ebR+39J4H4VzXpkLBXvoZkP60Gft+7XokoClSEW8gTV4YkgU28s7nxPGrMjT6in9ktuZH0sKzZ7+lg2wmWqidFhxwtygc2F+95+25/JYaRTtNAruUfeLK+I+SIVBkSgj2DjLWl7oDX+oHWDsT3ujUhECa8KAvtx4AJnACWdOOLfupQ1wGkmBpSlNQY=
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494f1c88-5b10-4825-902e-08d6fe2e5aeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 14:13:56.5792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chris.laplante@agilent.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2522
Subject: Re: Should multiconfig save build time?
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
X-List-Received-Date: Tue, 02 Jul 2019 09:46:27 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBXZSBoYXZlIG5lZWQgdG8gZ2VuZXJhdGUgNiBzbGlnaGx5IGRpZmZlcmVudCBpbWFnZXMsIHdp
dGggZGlmZmVyZW50IGRlZGljYXRlZCBhcHBsaWNhdGlvbnMgYW5kIHVzZSBjYXNlcywgYnV0IHRo
ZXkncmUgYWxsIGRlc3RpbmVkIGZvcg0KPiB0aGUgc2FtZSBoYXJkd2FyZS4NCj4gV2UgaGF2ZSBt
dWx0aWNvbmZpZyBzZXQgdG8gYnVpbGQgdGhlc2UgNiB2YXJpYW50cy7CoCBDbGVhcmx5LCB0aGV5
J2xsIGFsbCBzaGFyZSBhIG1ham9yaXR5IG9mIHVuZGVybHlpbmcgcGFja2FnZXMuDQo+IFdoaWxl
IHRoZSBiaXRiYWtlIGluaXRpYWxpemF0aW9uIHRha2VzIGEgbG9uZyB0aW1lICh3aXRoIG11bHRp
Y29uZmlnKSwgd2Ugd2VyZSB1bmRlciB0aGUgaW1wcmVzc2lvbiB0aGF0IGl0IGNvdWxkIHNhdmUg
dGltZSBkdXJpbmcgdGhlDQo+IGFjdHVhbCBidWlsZCBwcm9jZXNzIGJlY2F1c2UgaXQgY291bGQg
aGF2ZSB0aGUgcG90ZW50aWFsIHRvIHJldXNlIHBhY2thZ2VzIGFscmVhZHkgYnVpbHQgZnJvbSBt
YyBBIGZvciBtYyBCIGlmIHRoZSBpbnB1dHMgdG8gdGhlIHJlY2lwZXMNCj4gYXJlIHVuY2hhbmdl
ZCAoaWYgc2FtZSB4eHhfRkVBVFVSRVMsIHNhbWUgYXJjaCwgZXRjLikuDQo+IA0KPiBUaGlzIHdh
cyBhIGd1ZXNzIG9uIG91ciBwYXJ0IHNpbmNlIHdlIGluaXRpYWxseSBkaWRuJ3QgYXNzaWduIGRp
ZmZlcmVudCB0bXAgZGlyZWN0b3JpZXMgZm9yIGVhY2ggY29uZi7CoCBTbywgdGhlIDxXT1JLRElS
PiBkaWRuJ3QgY2hhbmdlDQo+IGJldHdlZW4gbWMgYnVpbGRzLsKgIFRoYXQgYWN0dWFsbHkgd2Fz
IGNhdXNpbmcgc29tZSBpc3N1ZXMgdW50aWwgd2UgcmVhbGl6ZWQgdGhhdCBzZXBhcmF0ZSB0bXAg
ZGlycyB3YXMgcmVjb21tZW5kZWQgZm9yIHRoZW0uDQo+IFNpbmNlIHRoZXkgYWxsIG5vdyBoYXZl
IHNlcGFyYXRlIHRtcCBkaXJzLCB0aGV5IGNsZWFybHkgYXJlIG5vdCBnb2luZyB0byBzaGFyZSB3
b3JrIGRpcnMsIHNvLCBub3cgd2UncmUgcXVlc3Rpb25pbmcgb3VyIG9yaWdpbmFsDQo+IGFzc3Vt
cHRpb24gYWJvdXQgYW55IGJ1aWxkLXRpbWUgc3BlZWQgYmVuZWZpdC4NCg0KSGF2ZSB5b3UgY29u
c2lkZXJlZCB3aGV0aGVyIHlvdSBhY3R1YWxseSBuZWVkIG11bHRpY29uZmlnIGluIHRoaXMgY2Fz
ZT8gSWYgdGhlIGFyY2ggYW5kIGRpc3RybyBmZWF0dXJlcyBkb24ndCBjaGFuZ2UsIHlvdSBzaG91
bGQganVzdCBiZSBhYmxlIHRvIGhhdmUgbXVsdGlwbGUgaW1hZ2UgcmVjaXBlcy4NCg0KQ2hyaXMg
DQo=

