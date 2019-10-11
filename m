Return-Path: <chris.laplante@agilent.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr820045.outbound.protection.outlook.com [40.107.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 9B3657F5C0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 17:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=Dr3asycgKGBZvfNeJFrI1qxFLfgY8C5FWc5oFOst4WHfkHZTq8DfT9o68X7xke1Fh8kPZoiv3uNDnVv4BduBejMkFupy1XQYI3NXrnaR9zjBdjFMDbkhPynCTyNPzikq9ajt3LElaHMSJq7HgKBT79BMA5z9jfi2+6DEYHlRz6MTYA1f2IccAYkpYgfzd9Q9sn4SNXffgXAB7a2y6NZRvcnWxEtxN0qj+6HCW7bwWBXPFPkEC0Qj3MngvpLOidwSPYqSCUKOMONgAHOfK0vTbZtvy9OoNZgmU7uvXSavRq+21irOOZ3zlHgc0NPElQyK2ZFwsDQMTWK6cL72O3X9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ITmH1mT+Udx6FJeGIUBQyLmNaDpyk5TYmis7wJKDgS4=;
	b=RGz76AzIEeVKXbyjamLjFHn9BX4hGc+TIfK11ZwFmWn6wepu3U0S2MweIyPQiETZ4JbCyxAkUnzn+0EllE8SBmkdXqkd5EW+oVefKUVmGxE22ttNLGyIgHlRTpWGcJ1WQssYNAc1CNx4GDQWBoGPgvLmm9DdA0VBevzBf5hLzHksLIUdZluw2Wg95LIx0XcuD+0VYVm1xGi1S1E4gUzXTneyInB/8okprBC0Vj/9oV2T7M+VKU4FeiwMzKFz9fF2t9+HoV55fAaXN+9ryl/vV6wqghneU0vpfEPSdQsVbTtvT0qscv6YySZWFBoBIozsy0JiTboDiGu8UViYPldcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ITmH1mT+Udx6FJeGIUBQyLmNaDpyk5TYmis7wJKDgS4=;
	b=DuVtpqxhtgCT7x9EAtVZ99UC3TM790JCT5HutcOBvIIEO4uRAlN+WTFZy3YTACltubi56xTTSBogD7weoY+N/aci8hKbW8SLDfWrNLzRbpZvz0/Hg7edBpFQEHuhBIfrgdCgHQvjKBVh+TdeMZ9jkYG5x/0KyJkCsPCszaEbUlE=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1623.namprd12.prod.outlook.com (10.172.67.16) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2347.16; Fri, 11 Oct 2019 17:52:04 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::fdcf:99b9:ab44:4986]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::fdcf:99b9:ab44:4986%5]) with mapi id 15.20.2347.021;
	Fri, 11 Oct 2019 17:52:04 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Martin Jansa <martin.jansa@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH 0/9] BitBake Vim indentation plugin
Thread-Index: AQHVgFtyeEUVfFcZN0ytFKxbyomEcKdVtoKQ
Date: Fri, 11 Oct 2019 17:52:03 +0000
Message-ID: <CY4PR12MB165321DBBFA7D2109755B8D38B970@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <cover.1570810590.git.chris.laplante@agilent.com>
	<20191011174351.GA1563@jama>
In-Reply-To: <20191011174351.GA1563@jama>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d4b6e83-6030-4945-9382-08d74e73b9bf
x-ms-traffictypediagnostic: CY4PR12MB1623:
x-microsoft-antispam-prvs: <CY4PR12MB1623CCC086EC9FE12BF9E7628B970@CY4PR12MB1623.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(39860400002)(366004)(376002)(346002)(136003)(29502001)(189003)(199004)(66476007)(66066001)(71200400001)(71190400001)(8676002)(81156014)(81166006)(316002)(486006)(11346002)(446003)(14454004)(478600001)(6246003)(66946007)(8936002)(4326008)(5660300002)(476003)(76116006)(52536014)(66556008)(64756008)(66446008)(25786009)(6116002)(3846002)(55016002)(6436002)(9686003)(7696005)(99286004)(2906002)(76176011)(33656002)(186003)(6506007)(256004)(102836004)(229853002)(26005)(6916009)(86362001)(74316002)(7736002)(305945005);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1623;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNjVURn39altiNp9ccmWoGw6baW84q6whw+P31lGtN5AJd0kLtM9x/GFP8s/pQOmIWRm05NYNaCP7unEwUj89HS1eLRVafrSrdjntLb2b69/ZSZ18tXXic5j4c6y6svS/AzkUEdWXIbUXujoRY28hNFKZSHaTiYDx93Gwc6t66PaGc+b3rBjil163+9oxtxPTC7y+BDahTxo+6siy3mAn7Z6eFtlgOA2oUXqP4V7rpHgpbNFTWppKRdVsWF1cKBKLaOGqXbO6kqmin2lTe230SokRci76W/PQYmel5jIue3+jThfovTWZoIIACe6j02e/lUJIMERvOThBkA4atlDEqoyTxIE1+eJf75Iue6HJbb0zTdRyi7eZdTwmoeuh+DmudO9Rvp/sFTT11BSBbPIK8ab6h+2AUWPS0CzBF2M8NU=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4b6e83-6030-4945-9382-08d74e73b9bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 17:52:03.8971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJXX9WaEVkGVUWkogIsDQULhUXzt7CyFf+cZtHCeiBFiaYNftm4Gk1p6oG6DDxj+8F1fUhb7+JTBdIa3oJLKZ5A2IYGWW31O0tjkoEJ8uWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1623
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/9] BitBake Vim indentation plugin
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
X-List-Received-Date: Fri, 11 Oct 2019 17:52:05 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Martin,

> > It supports indenting variable assignments, Python and shell tasks/func=
tions.
> > To accomplish Python indentation, it uses a hacked-up version of the Py=
thon indenter
> > from Vim upstream. The upstream shell indenter is used directly, withou=
t
> > modification, however in the future it will be necessary to modify the =
shell
> > indenter to properly support "fakeroot" shell tasks.
>=20
> Thank you. As vim user I'll test this soon.
>=20
> Does the above mean that it will use 4 spaces for python and tabs for
> shell tasks like oe-core is using?

It currently doesn't specifically enforce either of those. The plugin is ba=
sed on autoindent, so the expandtab, tabstop, and shiftwidth are respected.=
 My editor is currently configured for 4 spaces everywhere, and that is use=
d even for shell tasks. Unfortunately I don't know enough about Vim plugins=
 to quickly answer how simple (or possible) it would be to change tab/space=
s mode on a per-region basis. I'll add it to my TODO list though.

Thanks,
Chris

