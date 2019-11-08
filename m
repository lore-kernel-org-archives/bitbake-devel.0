Return-Path: <chris.laplante@agilent.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr740051.outbound.protection.outlook.com [40.107.74.51])
	by mail.openembedded.org (Postfix) with ESMTP id DBCF67FC6E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Nov 2019 15:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=YY3yLNUsENhz89mibaUNVbo0Z7ZsWIk9sTndn19dOIL0hN4JdwBOM/SaBdnbw5e35+LebzOqgFrSWCz1McUv6nnMRf/NJW+G+kJklvu/DizvkW8RW4vBpuvumcdRqxvybt39tqPZrkvEjsV6DKJdpinOfIhV+EhP8O+YLenrXwW+6qK7VULaDgRSozjpCXpXvyy69pHhyV1gwkXk2vHNU6Nl2TcbLyCYEIOr/6K6UGx6u9madmf3MBjtHPDayTGtdePXW00aklrZQ/Ci2IW6ZaAS80IS13G85SIwzkO7ASIfuGO6RJtKGudAqjzvRiS2+rIwzp4hXZBIKG4PSJKX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=KTcVKeoCTYbFVF/wT2fgNiygFKG0yTuBDkfJ6BxiCkI=;
	b=IdhavEb/Qi1gSgU4WkBhzVhVr9MVjoyQSNfNOG73gG1SXb2ATVpFgCzyrIDJl7u1Gm0VYE1IBAIkRZzyBwPUT1xSE210YDmnhp52BFC5herLSALbQIiYu1vNGc03jDZWpoCa56rn0XNPQOmF8nCFNqnQ0NyNjNwlP0r3LAKvaEgv2RHTMn/0YSfboHZQUi9lKKhANSi+qnkPGVynARpaCpCmMkBCeliOPzqegPFGvtHBko/2bMghRGOfrFBr0BfgBZtSQj2eSBnlFzhfOALhDfyXeuVM4m/AUH966kR2gSiXepw6abMyd5DIVLos6AdhP+lFNBqJN43oAlF9SnZxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=KTcVKeoCTYbFVF/wT2fgNiygFKG0yTuBDkfJ6BxiCkI=;
	b=PBPoKh21U/EgchAFZ3XtaXiQeOtZZQjwXNVTJkgTF5tcnG1V3T2zoW8M6ynxW3UwPOkRL7FhJ76uVOrwpcY0tBW1GcHKQ2s9o+2AJYgyejDWTg/K5LRpJ2gGgzreVGZT+qolgFh0ZcpZ8bTwZPD7ojEhi9FUMdR6qpKdMFv1t5A=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1623.namprd12.prod.outlook.com (10.172.67.16) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2430.24; Fri, 8 Nov 2019 15:19:20 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::38c8:b362:f0b6:5134]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::38c8:b362:f0b6:5134%8]) with mapi id 15.20.2430.023;
	Fri, 8 Nov 2019 15:19:20 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Yi Zhao <yi.zhao@windriver.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] contrib/vim/indent/bitbake.vim: move it
	to	correct directory
Thread-Index: AQHVlecQ9fxbIU3m40+JsmmIspMBoqeBY2Uw
Date: Fri, 8 Nov 2019 15:19:20 +0000
Message-ID: <CY4PR12MB16535F784360503E5D9A9AAB8B7B0@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <20191108034600.13103-1-yi.zhao@windriver.com>
In-Reply-To: <20191108034600.13103-1-yi.zhao@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9864282d-fb02-49c7-0580-08d7645f0747
x-ms-traffictypediagnostic: CY4PR12MB1623:
x-microsoft-antispam-prvs: <CY4PR12MB162327D57B957D6DEC7460558B7B0@CY4PR12MB1623.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(29502001)(66446008)(71200400001)(53546011)(6506007)(102836004)(71190400001)(76176011)(7696005)(7736002)(256004)(305945005)(478600001)(8936002)(81156014)(81166006)(33656002)(74316002)(6116002)(3846002)(99286004)(2906002)(14454004)(9686003)(316002)(55016002)(66946007)(86362001)(110136005)(2501003)(66066001)(25786009)(6436002)(229853002)(66556008)(4744005)(26005)(76116006)(11346002)(186003)(64756008)(52536014)(6246003)(476003)(446003)(486006)(66476007)(5660300002)(4326008);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1623;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:3; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0yKT0auG2UdSZ5VkIbDZE87Bz6LztYQSJGkPqjO1pg6zCOYKZnwF5MWlHiXEhC5boeActVR7ZFdx6DaNXU0Nx9tJI8OCXdktpD2IBjxLwJtf492R6cyyTrD2s+hNkCcwm67cLCfWKq4OZLTvZh1imWWpsmqKoILk+4CjdfDp+LT5jEt8E3GFaFQxMLPT3u7Z81atpCn4rcZZsEMgAxhPR6jfYyQe27zp24MmjvwLGCRIvENORAf65e42vXA02G1RJ3btZqa1L22KJzo1axJQxR8/K9wBCednwAu0IMnWpvRDdbxCIsxVn5HSi66ODvB3MKnih2w937Odbpva+iwLy9FmpYLtEgIAf4q0dQBok+S57VqTNn/UGdaS52fhyQdc9oh6JozP4YesSMrJzBrGDLNeSfIIcKHdjIl6msmUAbZH1T5h1Rv3jdESmtcDlzIIvwRor4gJH04k6oD/hF7Jg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9864282d-fb02-49c7-0580-08d7645f0747
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 15:19:20.1460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4d0g1y8a7Z4cF8qjEK0yPrnAijnPxVWQ/Ud4WOesT48I3OjbO6P0oMfCdlquS2no4IdxECmjfQIW6x9nKlYntwQe0ZgzcaSP3IFMU7yre/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1623
Subject: Re: [PATCH] contrib/vim/indent/bitbake.vim: move it to	correct directory
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
X-List-Received-Date: Fri, 08 Nov 2019 15:19:23 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-bounces=
@lists.openembedded.org> On Behalf Of Yi Zhao
> Sent: Thursday, November 07, 2019 10:46 PM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] contrib/vim/indent/bitbake.vim: move it =
to correct directory
>=20
> Move bitbake.vim from bitbake/contrib/vim/indent to contrib/vim/indent.
>=20
> Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> ---
>  {bitbake/contrib =3D> contrib}/vim/indent/bitbake.vim | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename {bitbake/contrib =3D> contrib}/vim/indent/bitbake.vim (100%)


Oof, good catch! Thanks.

Chris

