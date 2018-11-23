Return-Path: <jdasilva@ciena.com>
X-Greylist: delayed 154523 seconds by postgrey-1.34 at layers.openembedded.org;
	Sat, 24 Nov 2018 03:37:18 UTC
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
	(mail-eopbgr750043.outbound.protection.outlook.com [40.107.75.43])
	by mail.openembedded.org (Postfix) with ESMTP id 8F2D779B67
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Nov 2018 03:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cienacorp.onmicrosoft.com; s=selector1-ciena-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=OtYxO7H/NrzqdV5T+B4yYhy6Ff422vYt6lOE7VB9ZEI=;
	b=TrwhQ3BcwITjZn6JK7RoGGYigHlGNQDMxBdfphyX+a7wJZRgFTj0B0930x4GJwSMn6M5zBzZCtWV23ojGhJjMMqAQINXleFWzIXCyR5+0i4Vzd/5/OIOsN65JdCUiqFjwc7kn6gDX+uYfFAHV3AHpbRlp7KyASLDviczBGAWGSo=
Received: from BN1PR0401MB1060.namprd04.prod.outlook.com (10.160.79.21) by
	BN1PR0401MB0929.namprd04.prod.outlook.com (10.160.78.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1339.26; Fri, 23 Nov 2018 23:03:36 +0000
Received: from BN1PR0401MB1060.namprd04.prod.outlook.com
	([fe80::85b5:1aaa:a797:bcb4]) by
	BN1PR0401MB1060.namprd04.prod.outlook.com
	([fe80::85b5:1aaa:a797:bcb4%4]) with mapi id 15.20.1361.016;
	Fri, 23 Nov 2018 23:03:36 +0000
From: "da Silva Filho, Josias Inacio" <jdasilva@ciena.com>
To: Robert Yang <liezhi.yang@windriver.com>
Thread-Topic: [**EXTERNAL**] Re: [bitbake-devel] Sumo to Thud migration: Fetch
	failure from gitsm.py
Thread-Index: AdSCeGxGQeNgnFnkSUmdvkivwo5rPgAnyQWAABmdP2A=
Date: Fri, 23 Nov 2018 23:03:35 +0000
Message-ID: <BN1PR0401MB10601D5F83AF548351B1B594DBD40@BN1PR0401MB1060.namprd04.prod.outlook.com>
References: <BY2PR0401MB1062E20E143B0318E7B03B9DDBDB0@BY2PR0401MB1062.namprd04.prod.outlook.com>
	<2ca14555-de68-244a-7b86-459ae916a08f@windriver.com>
In-Reply-To: <2ca14555-de68-244a-7b86-459ae916a08f@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=jdasilva@ciena.com; 
x-originating-ip: [66.48.12.176]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN1PR0401MB0929;
	6:qq45D6PejzcCINeEiWca8AoqTBKVVy6LSRtvFxwBxRmKl9qzAU7t3acgC6CZGwT7Nz06SymSAcdAryaSBhjKHU8I0zsZadmd09XIYI0ruRDHEkF+6t12udMy91U1y1bPzS1xyreoB8U/RjcMSY7rVZcdYbyyYWHzTU751k3Vk51OYDFfGHG71WqHoNv+iMnRTzsL39CjVmGpZcafjFchoBiWFxoSyD788nl83F0n+wEBtVZkBXbVIUw+j26omv4kMONw9AGQMqFqRhaEahIphR3mN7I6kSWvCQrJDN33EGjZ5745MUD/LhaBYYADtwRJ+IntOGzNqcu1F9ncGobg6oDubsjq2XOSke9vQwJxkLvKQs9Af8t3OBE80moO/VOiXErwi4y7dRA0C8dq3r2btoj+3oyOIzlSFknl4neCAWuhm7J7ANQIGsgEUMf0PxSv2tvSvftE4f0XG85BsZpr1ng+D4an0SbFRJKXiefvq1c=;
	5:mmKrcMLYnCcBusykDWXL0LF49OCm2PevVaA0st35bWhTivFS6dGKnby5wYZpu8xFs2G4E3F3+bxt/fJra9yrdhsjk3EsGh7yqCP+8IsDMIAWucNUdMOzc+di1c/bzGKB3NKaAdvgT+xris7+a95XuKvWe1Y/zuTtxzy+rCee3/A=;
	7:ZsbIYZjQjmAxokbgpqpZYOdeBynIDzOY+nhWCjrI06tuPBHf94eGTV8JzjffzGOXSYd546JDA6GNY076E4s0BAtZRVY+4tejZBaeVCccv3IJwEvCuLdD04u9BT8OkhL7u9W2FiJwP/vxfkxh17ZxlQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c40d9414-c989-4316-7582-08d65197e62b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:BN1PR0401MB0929; 
x-ms-traffictypediagnostic: BN1PR0401MB0929:
x-microsoft-antispam-prvs: <BN1PR0401MB09296C4404D3082CE8B5A079DBD40@BN1PR0401MB0929.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231442)(944501410)(4982022)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);
	SRVR:BN1PR0401MB0929; BCL:0; PCL:0; RULEID:;
	SRVR:BN1PR0401MB0929; 
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39860400002)(199004)(189003)(13464003)(53546011)(3846002)(26005)(81156014)(66066001)(33656002)(97736004)(54906003)(229853002)(8936002)(81166006)(6116002)(9686003)(105586002)(7736002)(14454004)(99286004)(53936002)(5660300001)(186003)(305945005)(316002)(11346002)(74316002)(256004)(14444005)(25786009)(71190400001)(486006)(6916009)(476003)(446003)(71200400001)(106356001)(4326008)(2906002)(76176011)(8676002)(6246003)(68736007)(575784001)(6306002)(478600001)(102836004)(6506007)(7696005)(55016002)(6436002)(86362001)(966005);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BN1PR0401MB0929;
	H:BN1PR0401MB1060.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: ciena.com does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: t7dH8Lvcr5//ten/ZzN/Lg9tckeUvAMJ8Rczpx2i5DaQJFgne0RiaVwOYiYzs9tXr0dUbeIx8sQBTdm5I+2Nxggc4tJMHIOSSAi8uXs0/IrZwHSVTGpWypDxWBQTVBX1UyjlVDcqeQgYyeHV6WHjHguU3ph0H0q79p80L6PdT2WRikPV9mYQdZXDOW4W2Sf4oc8AKlhLY9tTvXhAEsxjvWhnjdiPGW/p0weUF/tHy8cpad2T+gUQZEgqcnCOz+6B2m9mT8/uaQyxfKijm/C52dH57yuF2MrL0/ncKycsmWeWMGGylcr99xQHomfDxhlBB4C64xzwj8kkkR2/ZhNdI3odiKjKkew0nG/tvYKcLz8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: ciena.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40d9414-c989-4316-7582-08d65197e62b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 23:03:36.0523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 457a2b01-0019-42ba-a449-45f99e96b60a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0401MB0929
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [**EXTERNAL**] Re: Sumo to Thud migration: Fetch failure from gitsm.py
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
X-List-Received-Date: Sat, 24 Nov 2018 03:37:19 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Robert,

I had a look at those two commits before, also tried reverting them but got=
 the same error.

I reverted a few other changes in gitsm.py for testing, but the error only =
went away once I reverted this one:

commit 5cd00e3e53819f3c10d1733480077ce9f3cc2ca8
Author: Mark Hatle <mark.hatle@windriver.com>
Date:   Tue Sep 25 13:15:25 2018 -0400

    bitbake: fetch2/gitsm.py: Rework the git submodule fetcher




-----Original Message-----
From: Robert Yang <liezhi.yang@windriver.com>=20
Sent: Friday, November 23, 2018 5:31 AM
To: da Silva Filho, Josias Inacio <jdasilva@ciena.com>
Cc: bitbake-devel@lists.openembedded.org; Mark Hatle <mark.hatle@windriver.=
com>
Subject: [**EXTERNAL**] Re: [bitbake-devel] Sumo to Thud migration: Fetch f=
ailure from gitsm.py

Hi,

Please refer to the following 2 commits in bitbake which may help:

commit a042179a784bab6a6f4bd5d63db80c1c02624b1c
Author: Mark Hatle <mark.hatle@windriver.com>
Date:   Wed Oct 31 15:21:44 2018 -0400

     bitbake: fetch2/gitsm.py: Fix the references when the module and path =
are different

commit a28637abbceb05b52a6e38ab2340d3da9d0b1b37
Author: Mark Hatle <mark.hatle@windriver.com>
Date:   Wed Oct 31 15:21:43 2018 -0400

     bitbake: fetch2/gitsm.py: Disable branch checking on submodules


// Robert

On 11/22/18 11:31 PM, da Silva Filho, Josias Inacio wrote:
> Hi folks,
>=20
> I'm working on migrating my environment from Sumo to Thud. After=20
> fixing a few quirks, it seems the fetch is failing for my foo.bb which us=
es gitsm.
>=20
> *.gitmodules content in foo repo:*
>=20
> [submodule "common-lib"]
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 path =3D common-lib
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 url =3D ssh://git@<url_to_=
common-lib>/common-lib.git
>=20
> *foo.bb:*
>=20
> SRC_URI=3D"gitsm://git@b<url_to_foo>.git;protocol=3Dssh;branch=3Dmaster"
>=20
> SRCREV=3D"f55fae9dc9b476f8ed193f15e2d5cd6747777451"
>=20
> Digging inside gitsm.py it looks like module_hash is not being set=20
> correctly
> (empty) and that causes the issue:
>=20
> http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/bb/fet
> ch2/gitsm.py#n87
>=20
> I added the following right after line 87, so I could dump the=20
> variables content. This is how I confirmed module_hash is empty:
>=20
> *raise bb.fetch2.FetchError('module: %s, submodules: %s, module_hash:=20
> %s,
> basecmd: %s, revisions: %s, paths: %s, clonedir: %s ' % ( module,=20
> submodules, module_hash, ud.basecmd, ud.revisions[name],=20
> paths[module], ud.clonedir))*
>=20
> And the output:
>=20
> ERROR: Fetcher failure: module: common-lib, submodules:=20
> ['common-lib'],
> *module_hash*: , basecmd: git -c core.fsyncobjectfiles=3D0, revisions:=20
> f55fae9dc9b476f8ed193f15e2d5cd6747777451, paths: common-lib, clonedir:=20
> /localdata/yocto/downloads/git2/<foo's path>.git
>=20
> Any ideas why module_hash is not being set correctly?
>=20
>=20

