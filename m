Return-Path: <chris.laplante@agilent.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
	(mail-eopbgr760048.outbound.protection.outlook.com [40.107.76.48])
	by mail.openembedded.org (Postfix) with ESMTP id A3DEF6004D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2019 14:41:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=az5VMYlvfBTZ/NW/Cdv3R5CrlE4Ik9/j/m+kKews4zKqLxDhZQ9b/vkxvNVmNdWYOA3WikeAe5hWYb7TsP6gu3iq4lQeRz7LkgpN8Pu2qd58KFxsBNeAd2vQ9dtmT7qyUGlb59Tn9PXUr8hVe2Su9F7Wkt5hdDPJRjMmoxyGpBZ1c+MbRzF8drOz5SUy3rkICAoQ5TNN2Dxm4ev8xK1+psuNNeM7ZtwkPn56Hukw91d2A9v2wSeaYjjS94JkFTxwFrlliV3W8CqjJP+cNm1mFgJ4TMKz8g7agVmgEIVIHFXwAPGEbFR1TJV1ylXlnVmBjcRnq6zIKGVns59VR7bQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=/nz1cryZczYvr4+A1nIYG54lDIthBFEZ84YoB/CHyAc=;
	b=ocgRj0tk7UejZJVNiLLJhZMjdgIDfT3HjRZxNKUR3VpDIoyzn9OIx22RB2UrpT7uXHj8F5BPxEa7bPQP++WgznT6AHeEcPwWIk1PmLOhzVKitJsrZ5bLz8w/RotR3H+BmEDjkrWCMQ8JfzQwzQNMAR4R7ysJIw/GdN0dvgqvOxXihhFdIHfj1SCudpxthKumfHztAQ4lEC+FGQ9v88XUBy1B2aK8U29o/vIqhWUmMjLimmZFjZt8fDMUkgYjgM6m68JEZfQ1p93t19X7VmVqFBjPZGTPrjju9r16bdUkg5D1k87q0SFx83qasdaDE1BlEO8H5vheOXCspBm6EkCH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=/nz1cryZczYvr4+A1nIYG54lDIthBFEZ84YoB/CHyAc=;
	b=WeUEWVL8Nce2wK0SjOnfIzI5Jlzrb8SJcBXMdtQ/aRlNog4DAJXerL4BSuZGbib7CbOSFz84rT3Gm1PCbQt7wKMGkZhEuc4n0MzEln+alJc7bzSxXuOeGXUSXHP0nV0JrXoEAyI0/nMJSstePW/Q4tNhJ11wX6QZevZ7QDXb7GE=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1175.namprd12.prod.outlook.com (10.168.167.10) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2408.24; Thu, 7 Nov 2019 14:41:45 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::38c8:b362:f0b6:5134]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::38c8:b362:f0b6:5134%8]) with mapi id 15.20.2408.028;
	Thu, 7 Nov 2019 14:41:45 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH v2 0/9] BitBake Vim indentation plugin
Thread-Index: AQHVhQkXgo4MEInU/kOfVjEqhWSO/qd/6Jqw
Date: Thu, 7 Nov 2019 14:41:45 +0000
Message-ID: <CY4PR12MB16530118DE572B2CC64389008B780@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <cover.1571329975.git.chris.laplante@agilent.com>
In-Reply-To: <cover.1571329975.git.chris.laplante@agilent.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17bde97a-f380-428c-dde7-08d763909d24
x-ms-traffictypediagnostic: CY4PR12MB1175:
x-microsoft-antispam-prvs: <CY4PR12MB1175C377A39038E2F5BCF1398B780@CY4PR12MB1175.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(376002)(396003)(136003)(346002)(39860400002)(29502001)(189003)(199004)(51874003)(99286004)(6116002)(256004)(2501003)(6506007)(74316002)(52536014)(2906002)(2351001)(66066001)(81166006)(5660300002)(26005)(6436002)(6916009)(71200400001)(102836004)(55016002)(5640700003)(478600001)(76176011)(14454004)(229853002)(71190400001)(8676002)(9686003)(486006)(305945005)(6246003)(186003)(81156014)(4744005)(25786009)(7736002)(86362001)(7696005)(316002)(8936002)(446003)(66946007)(11346002)(66446008)(76116006)(476003)(64756008)(33656002)(66476007)(66556008)(3846002)(4326008);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1175;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tLJesiJOU/Ay1pEP6tBiwOAJ1xNAzV6abOzQeTFdzUmZCsTodU8b/I8L/oew0F5KJHZQaxvGvj6gJxQbdxlXIemPMJ9GVVQc7wQj0f3zvMvfnW6GJH81WnfEPX6/7rhlxq6mI8q0fnYzkRJEDomiuF3yxvFLg4o/pkDmU6GoWbftc4PXEuuNsVSZ3XTe/k1xDVmZ6ucUI9UpmSvBcv1xhUQBoyY54YXphIwmjaYGE/6gp675gFGvFpN9JTP2A3hP4vjQDR2+s/Ps033+uOorD2rvkFFs4DLSmeg7Oze5g71oBDO0RNyPhY9+6RN/nKcLlAef+wOa3ZJrKu8N8qXCnKdMsluW0y9xFpzLCaDRNDuRHKDaIC+uNJhVY5y0+cTyWiXVrHeZ0VlWPJXbUWkaAI500qesW0RKZ0s0MngLsxtHR0meqIbZZJh2N7b38WIw//7xCI23epOB3n+ic+Ackg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bde97a-f380-428c-dde7-08d763909d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 14:41:45.8114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zclJGFDivhh/vKHdCWlTfqdOBEFT/k55wh9BL+oxmpOLVcPHrQguDdLQE0YZxIYk+7p4MxA3nSmw2lN3HtSk4ZA/rYdDWT3AQPJIUkHjGIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1175
Subject: Re: [PATCH v2 0/9] BitBake Vim indentation plugin
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
X-List-Received-Date: Thu, 07 Nov 2019 14:41:45 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> This patchset adds Vim indentation support for the BitBake language.
>=20
> It supports indenting variable assignments, Python and shell tasks/functi=
ons.
> To accomplish Python indentation, it uses a hacked-up version of the Pyth=
on indenter
> from Vim upstream. The upstream shell indenter is used directly, without
> modification, however in the future it will be necessary to modify the sh=
ell
> indenter to properly support "fakeroot" shell tasks.

Heads up, it seems only the first two commits in this patch series were com=
mitted to Poky. Could someone please commit the remaining 7?

Thanks in advance,
Chris

