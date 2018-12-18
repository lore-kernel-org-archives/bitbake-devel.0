Return-Path: <raphael.lisicki@siemens.com>
X-Greylist: delayed 10734 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 19 Dec 2018 05:53:40 UTC
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
	(mail-eopbgr30064.outbound.protection.outlook.com [40.107.3.64])
	by mail.openembedded.org (Postfix) with ESMTP id 4C42679F02
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Dec 2018 05:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=siemens.onmicrosoft.com; s=selector1-siemens-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=URpAdz+a0TKvzb3+NyXwCmcDp7dWyAa1x9m008TjQi0=;
	b=VArBZv6QF3zQB0UHzwh7rx7aREGwqPOs7QqvqsgU6wM9Bb2MyIUbZgaBPllgWlYNuxxTC9phG7TFGZiWjq9+Bo1h06T5jwtDnbc9HMdfq4OzG12WHW/ZihBFYo0HWlKNrhhjD1fOfGfKYesOdV2d6RCknrLij53ATOrALgIj8S8=
Received: from DB6PR10MB1607.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:39::25) by
	DB6PR10MB1607.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:39::25) with
	TransportReplication id Version 15.20 (Build 1425.22); Wed, 19 Dec 2018
	00:21:19 +0000
Received: from VI1PR10MB2287.EURPRD10.PROD.OUTLOOK.COM (20.177.62.75) by
	VI1PR10MB1613.EURPRD10.PROD.OUTLOOK.COM (10.165.191.158) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1425.18; Tue, 18 Dec 2018 14:13:48 +0000
Received: from VI1PR10MB2287.EURPRD10.PROD.OUTLOOK.COM
	([fe80::d123:4e05:1797:3a0e]) by
	VI1PR10MB2287.EURPRD10.PROD.OUTLOOK.COM
	([fe80::d123:4e05:1797:3a0e%2]) with mapi id 15.20.1425.021;
	Tue, 18 Dec 2018 14:13:48 +0000
From: "raphael.lisicki@siemens.com" <raphael.lisicki@siemens.com>
To: Mark Hatle <mark.hatle@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] gitsm: orphaned submodules WAS: Sumo to Thud
	migration: Fetch failure from gitsm.py
Thread-Index: AdSTqV0UDYxI9dewTkCcHKa88UwW7gChDIQAACuAZFA=
Date: Tue, 18 Dec 2018 14:13:48 +0000
Message-ID: <VI1PR10MB228780ACA5DE9111589D5307ECBD0@VI1PR10MB2287.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR10MB2287E378DA3E6ADDEB09F8FDECA10@VI1PR10MB2287.EURPRD10.PROD.OUTLOOK.COM>
	<6b892c12-ecd1-91ac-4f7a-f61d0dc8a0ec@windriver.com>
In-Reply-To: <6b892c12-ecd1-91ac-4f7a-f61d0dc8a0ec@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-document-confidentiality: Restricted
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=raphael.lisicki@siemens.com; 
x-originating-ip: [80.146.228.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR10MB1607;
	6:r8jMOOHzoumV9Vx9lJfi8mhA9cOikly5LCgaXJBT+5Unj/YrW1WvMRxCvW/FyB7lsKwsoi1LlmQiCT01EtjF71DLFEG+F1cNn00cNlBt+E+1RJp8UVkJWKkJUeREXX00wf4jo1oQxigbAtw3LUX+DBcDgc9jtP5C8QBHBoKAyTn1PLyELLK9EaC4i5DTArH343cOEO7wd2jfirJxCElCAxxVRJM/0/cUZoPm7eZQTrSKDk6tjfXbTD6Rty4ZyXVSqz4Gh8ZOVKmKWA9MfSMuQgMX4NFz640GwZPV/4y7YVIxeyS4M3qJ9NphPPd07+XdNj4QLrKJ8WH+7nTlzC37Ug0j0zMU2Rkg4MF5cdU7QuXgpc1RY96XGaE2BfQc0SP2Sqd7Goq8e81huX/at+kzwPWAu6NlRSHlBfwsShp4D0r0e049J6ruM/+Fd5xB6VREeHrRmhaF30p8R9mKA1cuoA==;
	5:x8I5MlPllwJP+9NM+vmx+HyvQullMK+CUv/1TcJSUfDZ1llIsHlioLYm2f+YjsA0saB3xRZOwDrjNP0UdsQtgkzMVvCfC9EJwAxdN0fHxmrEVnTA/5fiBpmw8Z/AFQOemUztP6OjKhKDL4haweLNOCkV2Hn7G4/DmNIxp44d87c=;
	7:NZIJQtZLKoEYyvfD8RUq5AeReOGrly3Ev4W6YZDv9QzbC3aQkxblO6NEYr5jt/oPZ47kcFcUQLsf8iv8O87DB/qyDXtgxp5IgDxOfwOjqAHGiFpgC/B064ZOpFCSO3foQlIE+v4yg7us7/sMGyoqzg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c68cce2a-2ad3-4b3f-c69d-08d664f30760
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
	SRVR:VI1PR10MB1613; 
x-ms-traffictypediagnostic: DB6PR10MB1607:
x-microsoft-antispam-prvs: <DB6PR10MB16073174D3C83DC947543A01ECBE0@DB6PR10MB1607.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(4982022)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
	SRVR:DB6PR10MB1607; BCL:0; PCL:0; RULEID:; SRVR:DB6PR10MB1607; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(376002)(136003)(366004)(39860400002)(346002)(189003)(199004)(6246003)(14454004)(53936002)(53546011)(229853002)(11346002)(68736007)(99286004)(105586002)(478600001)(8676002)(110136005)(106356001)(446003)(33656002)(3846002)(316002)(55016002)(8936002)(6116002)(966005)(7736002)(256004)(305945005)(6436002)(2906002)(786003)(6306002)(81166006)(9686003)(81156014)(2501003)(74316002)(86362001)(66066001)(76176011)(97736004)(102836004)(186003)(26005)(25786009)(71200400001)(476003)(71190400001)(7696005)(6506007)(5660300001)(486006);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR10MB1607;
	H:VI1PR10MB2287.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: siemens.com does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: TdGSj6cyPM4+z1muYStFNTKzUlvBqulYGe6m/CV7LfHJspoevvot8QeqiSzUz3CGhYK2ocHlmYJs3EJCecp0R4nwup3kLmMvmTKyDKc+CFcPSJQGibQWKxKtyDwDyeFrxVOnwK5OBDwqcvz962rF5rUGK76KZrXjqL1mQrwqIDtfK8BNB0M8MM4KoP2TgjoHlK1DR8LqWyWNZQRQx6CFun7LUmZhwkhlanMdQqEnRmclnhTp1IFLK6tdPGvuXOldN2RwDd7epWYGkuWYYLhro6gQ72mJ/e42ByVVHrB0karuG8FUyjw2Le+qwhmKt6Ms
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68cce2a-2ad3-4b3f-c69d-08d664f30760
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 14:13:48.2476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1607
Subject: Re: gitsm: orphaned submodules WAS: Sumo to Thud migration: Fetch failure from gitsm.py
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
X-List-Received-Date: Wed, 19 Dec 2018 05:53:40 -0000
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

>=20
> On 12/14/18 6:37 AM, raphael.lisicki@siemens.com wrote:
> > Hello,
> >
> > as Josias has already pointed out, the new gitsm fetcher fails if there=
 is a
> submodule entry in .gitmodules, for which no actual submodule exists.
> >
> > I created a dummy module that shows the respective issue:
> https://github.com/ralisi/submodule-test
> >
> > This repository is shown correctly by github and cloning it with git ca=
uses no
> problem. I think it should be possible to fetch this repository with the =
gitsm
> module.
> > To do so, I think the loop iteration at
> http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/bb/fetch2=
/git
> sm.py#n87 can be skipped if module_hash is indeed an empty string.
>=20
> So to be clear, you are proposing that is the response is blank, then we
> simply
> run a 'continue', avoiding any setup/download for this item as there is n=
o
> specific hash to download?

Exactly.

>=20
> That would be easy enough to implement, likely:
>=20
>             try:
>                 module_hash =3D runfetchcmd("%s ls-tree -z -d %s %s" %
> (ud.basecmd, ud.revisions[name], paths[module]), d, quiet=3DTrue,
> workdir=3Dud.clonedir)
>             except ???:
>                 module_hash =3D None
>=20
>             if not module_hash:
>                 continue
>=20
>             module_hash =3D module_hash.split()[2]
>=20
>=20
> (Not sure if the try/except is needed.. if it is, not sure which exceptio=
n to
> capture here..)

As I have not experienced any throws within runfetchcmd, I don't see the ne=
ed for a try/catch. Apart from that, this is exactly what I had on my mind.

>=20
> --Mark
>=20

Best regards
Raphael Lisicki


