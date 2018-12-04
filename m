Return-Path: <jdasilva@ciena.com>
X-Greylist: delayed 68667 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 06 Dec 2018 01:01:17 UTC
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
	(mail-eopbgr800044.outbound.protection.outlook.com [40.107.80.44])
	by mail.openembedded.org (Postfix) with ESMTP id B53D6745F4
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Dec 2018 01:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cienacorp.onmicrosoft.com; s=selector1-ciena-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=scabEqhWAQf7D5WK9vAkhQDrpr3RbZ5yM4wQMAtxQKY=;
	b=KvwsMdaHkqnV6RCeKOfazcyPPH7fTkn0unXwSNdZ3szl8jVdrQfAyFVr++hFO4NX1AZTzwVAbLmEluO0M4uaEe3O9UP4sb8H4vZHG1XsrZpkkQcZC63g9ccZzWh1sGeIP0wJb4VdeQUCsUYbbXFQst2jw92kcMrGVMsP6XbSiqA=
Received: from BN1PR0401MB1060.namprd04.prod.outlook.com (10.160.79.21) by
	BN1PR0401MB0977.namprd04.prod.outlook.com (10.160.79.140) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1382.22; Tue, 4 Dec 2018 20:50:41 +0000
Received: from BN1PR0401MB1060.namprd04.prod.outlook.com
	([fe80::fd0f:9c71:3e4e:ed1e]) by
	BN1PR0401MB1060.namprd04.prod.outlook.com
	([fe80::fd0f:9c71:3e4e:ed1e%2]) with mapi id 15.20.1382.020;
	Tue, 4 Dec 2018 20:50:41 +0000
From: "da Silva Filho, Josias Inacio" <jdasilva@ciena.com>
To: Mark Hatle <mark.hatle@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [**EXTERNAL**] Re: [bitbake-devel] Sumo to Thud migration: Fetch
	failure from gitsm.py
Thread-Index: AdSCeGxGQeNgnFnkSUmdvkivwo5rPgDGSCMAAaBFlKA=
Date: Tue, 4 Dec 2018 20:50:41 +0000
Message-ID: <BN1PR0401MB10607D9453ED3DF24CE8EAC5DBAF0@BN1PR0401MB1060.namprd04.prod.outlook.com>
References: <BY2PR0401MB1062E20E143B0318E7B03B9DDBDB0@BY2PR0401MB1062.namprd04.prod.outlook.com>
	<968bb2a3-b5e0-a2d9-e8fb-3ea86100450d@windriver.com>
In-Reply-To: <968bb2a3-b5e0-a2d9-e8fb-3ea86100450d@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=jdasilva@ciena.com; 
x-originating-ip: [66.48.12.176]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN1PR0401MB0977;
	6:AmQC5QmGEC/Ch8rhYJG0WXBu+DpgCsUo8m9ZPVk5nx/+i9PXU1oRpmU6R8mUM1IjZnq2bQ9fMAyT0lSxZfNU1YkvOtAMmfUWefFhfLdEB1wjBhqEIw05YXQel6PjSNpU4Lr7YxzZZOOH+mH4BAEodWu4FQTOZSD7SX/yGs9+DK2YSs6VlLqNuzrZqarHdJO9gNiSr1WDUxz+uBnPl7hesuEBj65BZDy0V8qX0kNvezrFgE3M19c5cSoe1uyA0IFbUdpZ8HariyHz/Q5RmfqtJKivFhM86aew6/+8/wHo6Zz7akywcCm0+viqQfPlqxiG8+JbNq1OHAW/s0cRLj398OuoNfD1rDSGiXkTmarsK5MByPzyYsF0a91MC4qvQ48pAHR5qtkC8VZgEr+51BXaQePVHSAnZ9+oKDe5QQUlD6EjerpUPNZHwZrqyYbErzL8bOsEEPKj/jhPdhCOSueo/w==;
	5:GuS/aQej5TR72YHnTiTftr5bv+oM2/8ffPaU8NJqDzvTU5IH1ifrJTYmvU+kx5h/sknhtEUmYXv1OfqpZ0gHGnTQUW5FnSeyXM5VbsECLArD/SqPzTMDTqoBsIPgw8VRXEe07qSwbC+S/r5d+M1aL27BI07OJnc5uzTg79SdSpw=;
	7:shZfX9yUIU6vUQ4fGaUkenLI6aHozJmymD7h+AjnbPfp/wtEIgS0vXTpg2ydeH903WiI2gypx93sK9Z5YCbos/CcAnA9beQje+F12C8w2qlvi2PORDGiPfHheOBsgpV7JR4zD2iSS85jXb8s5uWa7A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ccf1bd1b-fe56-4a22-d5f3-08d65a2a2751
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:BN1PR0401MB0977; 
X-MS-TrafficTypeDiagnostic: BN1PR0401MB0977:|BN1PR0401MB0977:
x-microsoft-antispam-prvs: <BN1PR0401MB0977E534D89C3BA831AE767ADBAF0@BN1PR0401MB0977.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(4982022)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
	SRVR:BN1PR0401MB0977; BCL:0; PCL:0; RULEID:;
	SRVR:BN1PR0401MB0977; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(13464003)(74316002)(6306002)(81156014)(9686003)(55016002)(8676002)(53936002)(81166006)(68736007)(66066001)(5660300001)(305945005)(105586002)(106356001)(8936002)(229853002)(33656002)(478600001)(966005)(14454004)(7736002)(2906002)(476003)(6436002)(2501003)(71200400001)(316002)(3846002)(6246003)(97736004)(102836004)(110136005)(25786009)(71190400001)(6116002)(6506007)(53546011)(256004)(11346002)(486006)(14444005)(26005)(76176011)(99286004)(446003)(86362001)(7696005)(186003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BN1PR0401MB0977;
	H:BN1PR0401MB1060.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: ciena.com does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: sVtKMbH1BPq5dqxuDujlc/UtwWonq53Isd2DhfT5+L9R1OEU/MmhBeIeaAW8Ur4YJScxi8QuZs07RRkUyFY90hLcPmPw0tqdWOHzAXM3tfjUHgkHTb1NJcUpPykaWLfgO8RudZNzOoY6yzKCp+nNw5v0dSDflZahdeYd687/4MAOyYKa3ZidHCeLm8Mf7VQ9dUCngd4kep57+dSYtUU8sXzRHBJg0Qi+zLpvPzJBzvwvPJgAu6j4ah+Z1/WFrmrA5kYD4q46CZsYU4WQ4SHK5mkHvyrbYkwAubJC6/WU3ReOtNA6+fSSqqesoOcMSpiM0zNG0NTRFI5L73quyna+C8KKfqSuGJTKOFRMKTkMHvE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf1bd1b-fe56-4a22-d5f3-08d65a2a2751
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 20:50:41.2742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 457a2b01-0019-42ba-a449-45f99e96b60a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0401MB0977
X-Microsoft-Exchange-Diagnostics: 1; BN1PR0401MB0977;
	23:XyhHOo4cgQgIxmr8n111JOhfU0+Xh+gaMPRGNnUlR8YPyAdHcNEc7jkni7TDewWQt3WatuYOs8t/TsMKhWTjpbX8WBjq+2o6l3PKDvcCBWacRzovQlDkr63CzQTxmPUFTVj5/Db7hRVj848pFLJVew==
X-OriginatorOrg: ciena.com
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
X-List-Received-Date: Thu, 06 Dec 2018 01:01:18 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Bingo! Indeed the module was added into .gitmodules but not added in the re=
po itself.

I will get someone to add the repo then I will re-test, but that looks to b=
e the issue.

Thanks Mark!


-----Original Message-----
From: Mark Hatle <mark.hatle@windriver.com>=20
Sent: Monday, November 26, 2018 9:09 AM
To: da Silva Filho, Josias Inacio <jdasilva@ciena.com>; bitbake-devel@lists=
.openembedded.org
Subject: [**EXTERNAL**] Re: [bitbake-devel] Sumo to Thud migration: Fetch f=
ailure from gitsm.py

On 11/22/18 9:31 AM, da Silva Filho, Josias Inacio wrote:
> Hi folks,
>=20
> =A0
>=20
> I'm working on migrating my environment from Sumo to Thud. After=20
> fixing a few quirks, it seems the fetch is failing for my foo.bb which us=
es gitsm.
>=20
> =A0
>=20
> *.gitmodules content in foo repo:*
>=20
> [submodule "common-lib"]
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 path =3D common-lib
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 url =3D ssh://git@<url_to_c=
ommon-lib>/common-lib.git
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
>=20
> *foo.bb:*
>=20
> SRC_URI=3D"gitsm://git@b<url_to_foo>.git;protocol=3Dssh;branch=3Dmaster"
>=20
> SRCREV=3D"f55fae9dc9b476f8ed193f15e2d5cd6747777451"
>=20
> =A0
>=20
> Digging inside gitsm.py it looks like module_hash is not being set=20
> correctly
> (empty) and that causes the issue:
>=20
> http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/bb/fet
> ch2/gitsm.py#n87
>=20
> =A0
>=20
> I added the following right after line 87, so I could dump the=20
> variables content. This is how I confirmed module_hash is empty:
>=20
> *raise bb.fetch2.FetchError('module: %s, submodules: %s, module_hash:=20
> %s,
> basecmd: %s, revisions: %s, paths: %s, clonedir: %s ' % ( module,=20
> submodules, module_hash, ud.basecmd, ud.revisions[name],=20
> paths[module], ud.clonedir))*

Run the cloning steps manually.  And run the same git instructions as what =
the gitsm fetcher does to find the hash for the submodule.


git clone --bare <url> <destination>
cd <destination>
git show <commit>:.gitmodules

for each of the modules listed:
  git ls-tree -z -d <commit> <module path>

It's the bit in the for loop that doesn't seem to be returning anything.  T=
he only time I've ever seen this not work is when a module is defined in th=
e .gitmodules file, but was never actually added to the repository.

> =A0
>=20
> And the output:
>=20
> ERROR: Fetcher failure: module: common-lib, submodules:=20
> ['common-lib'],
> *module_hash*: , basecmd: git -c core.fsyncobjectfiles=3D0, revisions:
> f55fae9dc9b476f8ed193f15e2d5cd6747777451, paths: common-lib, clonedir:
> /localdata/yocto/downloads/git2/<foo's path>.git

git clone --bare ssh://git@b<url_to_foo>.git my_repo cd my_repo git show f5=
5fae9dc9b476f8ed193f15e2d5cd6747777451:.gitmodules

for each of the modules listed: (focusing on common-lib)
  git ls-tree -z -d f55fae9dc9b476f8ed193f15e2d5cd6747777451 common-lib

BTW my suggestion is to throw an exception or at least do a warning in the =
for loop if module_hash is empty... since this is clearly an invalid config=
uration.

(after the split line)

if not module_hash:
   logger.warning("Submodule %s of %s does not appear to have a commit defi=
ned."
% ( ud.url, module ))

--Mark

> Any ideas why module_hash is not being set correctly?
>=20
> =A0
>=20
>=20
>=20


