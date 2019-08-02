Return-Path: <chris.laplante@agilent.com>
Received: from NAM05-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr710085.outbound.protection.outlook.com [40.107.71.85])
	by mail.openembedded.org (Postfix) with ESMTP id 31E146BDE3;
	Fri,  2 Aug 2019 15:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=VN9LMAwPTQQaNFWSzJgLoCwyFHBuAij/QCC4Et7O6gGPT7MFVjEtFs5DAlW/BQH1q5qPY5eB2eZD1pyyxlcR8OUZv+69Amr7Y03CIG5ulVGzF4odhnf7CL1nl8uAhOVPQjyC2lXf/2jVSZaNPrgAMAKlojBAhObyAyy3eeqIOJ9cYhG+SVFsdHDDKtjXyPJ9Ch/Lg6O4fSCAXWrN2TirF0EMUD3kb7/FsXPoIkRXRad7GNJCFhQPff+058zV8ATFxAyaRxvpiV99cqZlRcWKNLNWl3+0FwJGb7aSA7Sp4kt0B0gptFKFWE+HhD/tGSx+YNBZl/cd+HrjnvK+gqT4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=H5xJIVWOyajwiB8gcJQDDoPwjoPFDKh/zHkcWialN2U=;
	b=VxWpoaz9PjKJKevFMQ/IfZmbS41GKJkLm8sCbeKExc9QuhmIRI9BX6L3/PgPuVylwdaD++wEaZi78s0WZthffxn6BhqrZrsWu106B224LTWkM2BOvzlBT0eKGBPNwSoCJniCdB782EBKmVYEtcdLEaw2FfwhK+nzMaTMg89t6nApf9mp3d7tYrUBnPEGcuWA5/QsDsyRy096sLwx/jhOwlM1a+gUKr4u46CpCNAkQIuZUYPE77wPtT7x9BbFQOiQtZdjKcuTKuOCUNWu55JjsFpmgPFHj3KYnyqKLWY5EBePKVxIPj9qSEGTbv2gV9SiYVwj81dl28x4lPpQPQh5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=agilent.com;dmarc=pass action=none
	header.from=agilent.com;dkim=pass header.d=agilent.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=H5xJIVWOyajwiB8gcJQDDoPwjoPFDKh/zHkcWialN2U=;
	b=FaB5JJq+/MFqb5Yhd8WPjxhTMxajGVxZDGl0JhS9QD01JAbp8BBvzwdX+jSPt5wBWx4TcOCSZs1DBBU35GDoDiNi3KA22Qf6c4fk5D3d4+q0vQiqhXc3G0/zaCUQAK9NDx4N9gSlmtR6pGVHKW6Xj7YSqBqHcJwajx303/0OcBw=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1495.namprd12.prod.outlook.com (10.172.71.21) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2136.16; Fri, 2 Aug 2019 15:14:39 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc%9]) with mapi id 15.20.2136.010;
	Fri, 2 Aug 2019 15:14:39 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, "Mikko.Rapeli@bmw.de"
	<Mikko.Rapeli@bmw.de>
Thread-Topic: [OE-core] RFC: exposing information about the SRC_URI(s)/branch
	via buildhistory (or similar mechanism)
Thread-Index: AdVIiV4bZ0XUaI6MTqawP3i+Dxw25gAawieAABMidgAAAP8zcA==
Date: Fri, 2 Aug 2019 15:14:39 +0000
Message-ID: <CY4PR12MB1653701CE975ABAE431D26848BD90@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <CY4PR12MB1653C06268B3B4B862119BE18BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
	<20190802073741.GI3459@hiutale>
	<7c7ee5f23029cdc0d421e6e50db145276d92ff80.camel@linuxfoundation.org>
In-Reply-To: <7c7ee5f23029cdc0d421e6e50db145276d92ff80.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.14.114.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ae75bb5-f23f-4b27-57fa-08d7175c236c
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:CY4PR12MB1495; 
x-ms-traffictypediagnostic: CY4PR12MB1495:
x-microsoft-antispam-prvs: <CY4PR12MB149581F6C00AC090D70AB1B18BD90@CY4PR12MB1495.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(29502001)(71200400001)(71190400001)(74316002)(7736002)(229853002)(305945005)(14454004)(4744005)(53936002)(5660300002)(7696005)(8676002)(81166006)(6506007)(110136005)(68736007)(52536014)(102836004)(316002)(81156014)(54906003)(99286004)(6436002)(64756008)(66446008)(66946007)(66556008)(66476007)(55016002)(86362001)(6246003)(76176011)(2906002)(3846002)(8936002)(256004)(186003)(6116002)(9686003)(4326008)(33656002)(66066001)(478600001)(11346002)(486006)(25786009)(2501003)(26005)(476003)(76116006)(446003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1495;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zwnalg8OQ8t/syCMUJZVylZTG7daa7lJ5Gm4Sun87Je1PAVAKGwyyOLepD8k23lQAZt+ofRufXPFRPDMslh6M1xiv3Ccu5OFReofeSTVmoml4Aq0TFIWldMxiJg0e39N3VRxFaQ/VnlGyx5L7LQwYMkZb9Fp5VR4JOn79iJ7LBMdAEKMgRYnhUAgNxoGquHvmnLBC5k5pCG4qhM1DAVQ1S17h2WOLeHuT82z4wOBxnbcaCFGus/QutseBaf/fwdtHMA3xmmt5IcZCXlenpTpqRumbEiWPEao3SqvHHz8G2Fk93zrRJc3Xge3dDXwZThXoSKY6IOdo4Whijf/MsTRaV/HQ8UV2RGasI8qRpKrcUNH+Czf5F/uKB5SE8lUccc4B0P2NQCKphlSU1US+2gj5Cxyerkrbm5QwEYGhqJMMN8=
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae75bb5-f23f-4b27-57fa-08d7175c236c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 15:14:39.3368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chris.laplante@agilent.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1495
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
X-List-Received-Date: Fri, 02 Aug 2019 15:14:40 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+IEkndmUgcGF0Y2hlZCBvdXIgdHJlZSBzbyB0aGF0IFNSQ19VUkksIExJQ0VOU0UgYW5kIENW
RV9QUk9EVUNUIGFyZQ0KPiA+IGFyY2hpdmVkIGluIGJ1aWxkaGlzdG9yeS4gU1JDX1VSSSBoYXMg
bWFueSB1c2VzIGFuZCBjaGFuZ2VzIGFuZA0KPiA+IHBhdGNoZXMgY2FuIGJlIGVhc2lseSBpZGVu
dGlmaWVkLiBTYW1lIHdpdGggTElDRU5TRSwgYW55IGNoYW5nZXMNCj4gPiB0cmlnZ2VyIGEgcmV2
aWV3LiBDVkVfUFJPRFVDVCBpcyBleHBvcnRlZCBzbyB0aGF0IHdlIGNhbiBkbyBRQSBjaGVjaw0K
PiA+IHRvIG1ha2Ugc3VyZSBtYXBwaW5nIGZyb20gQ1ZFX1BST0RVQ1QgZm9yIG5vbiBDTE9TRUQg
bGljZW5zZXMgZXhpc3RzDQo+ID4gdG8gTlZEIGRhdGFiYXNlIHByb2R1Y3QgbmFtZXMgKG1haW50
YWluaW5nIGEgd2hpdGUgbGlzdCBvZiByZWNpcGVzDQo+ID4gd2hpY2ggZG9uJ3QgaGF2ZSBhbnkg
Q1ZFcyB5ZXQpLg0KPiANCj4gSSB0aGluayB0aGlzIHN1cHBvcnRzIG15IHBvaW50IGFib3V0IGJl
aW5nIG1vcmUgaW50ZXJlc3RlZCBpbiBwYXRjaGVzDQo+IGFsbG93aW5nIHBlb3BsZSB0byBleHRl
bmQvY3VzdG9taXNlIGJ1aWxkaGlzdG9yeSB0aGFuIGp1c3QgYWRkaW5nIFguDQo+IA0KPiBXaGls
c3Qgd2Ugd2FudCB0byBoYXZlIGdvb2QgZGVmYXVsdHMsIHRoZXJlIGFyZSBhbHdheXMgZ29pbmcg
dG8gYmUNCj4gbmljaGUgY2FzZXMgZm9yIHBlb3BsZSB3YW50aW5nIHRvIGV4dGVuZCBpdC4uLg0K
DQoNCkFncmVlZC4gVGhlbiB3ZSBjYW4gaW1wbGVtZW50IG91ciBCUkFOQ0ggc2NoZW1lIHdpdGhv
dXQgcG9sbHV0aW5nIHRoZSBjb3JlIGNvZGUgd2l0aCBpdC4gDQoNCkNocmlzDQo=

