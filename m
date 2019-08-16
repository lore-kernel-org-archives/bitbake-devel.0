Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr700076.outbound.protection.outlook.com [40.107.70.76])
	by mail.openembedded.org (Postfix) with ESMTP id E29897F331;
	Fri, 16 Aug 2019 15:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=lJ4ZJ9moDS4Qg6e3PDQKKzuMyP9ht4fCuyJaZLwwS07n1Nvs0AElreSLjPaGpw94msB71py4nW6p0k+onLS/HMPX9+Kw9hAvFWXwqgYYvnljKMsfyB3qVq5qgVUSUSG6YAPdbnc2aIz5NAGwgjBWqBxmPFW4l/Cil5FYxrISzE6HWvS/cjUHQLWFKrnL0H2FSCFpUa7/QZ8ZoZLvW4Z3LbvANYxFJ6VFLN0S46AyaYp9K5XUjpmv7Q8krao42anHuP0XOEgrz094pP/e7PuFoL3S+mm1HMvE20olgspQZwRnFW3FotGO2c0sWkzOQ9Rnq0G9JAaacLv9cmNj5VA9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=TZZtAlTcEw5VyfmeSvD/q2pt+ukEXMmOEDnZVjHaLR0=;
	b=CFpGlJW/7DvLLwjSvHRw0+Qi9/EHiQ+BpIPPghpcZeQIKayTMc4WkQ6LMHaiwOXidRIvREiXtlQ34FWdY/alEz+JfVlPEdexAUsfGtyBdaUN8szhS/49WPNjzvZiZHxD2lBNeyfjOu+b8Re2fRvVJfoHVqfgWKW5C73W3yuQ1/JlhiYR+2xzhDgxCjywXpuzh+g3ALyiMqSOgMN6wE4GgkrW8rQwomQo7j/n2yNiKQVPQ4CVtJeqXIppteNXHy04Hayk48RhcV82QLsOiHINdb4x7KPH3xXPhG919djeZSsv/oXoK3HA0DGvnHeVSkdD42cZ9hkURdK4mw4iv8TS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=TZZtAlTcEw5VyfmeSvD/q2pt+ukEXMmOEDnZVjHaLR0=;
	b=RGpUFvGt24y4EvDCkzjEHb+wAJAgylfTGicx3teeMCTxc8P+UJqPd1VUvp2vC0jLhIXR18xJLZZ2Ty3XTPelzDqqodlhNSXaA68buMBZU5z/p1ZYwonVxj4w5n+cAJmgbRZYnX9n3RKoT2eWZqMWCQF6O3uX5Njy46Mf0v5v27w=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1478.namprd12.prod.outlook.com (10.172.72.14) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2157.20; Fri, 16 Aug 2019 15:03:01 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::c90e:a285:aaf1:79d4]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::c90e:a285:aaf1:79d4%9]) with mapi id 15.20.2178.016;
	Fri, 16 Aug 2019 15:03:01 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, "Mikko.Rapeli@bmw.de"
	<Mikko.Rapeli@bmw.de>
Thread-Topic: [bitbake-devel] [OE-core] RFC: exposing information about the
	SRC_URI(s)/branch via buildhistory (or similar mechanism)
Thread-Index: AdVIiV4bZ0XUaI6MTqawP3i+Dxw25gAawieAABMidgAAAP8zcAK97q/A
Date: Fri, 16 Aug 2019 15:03:01 +0000
Message-ID: <CY4PR12MB1653A4DAC3C08CF08C3200208BAF0@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <CY4PR12MB1653C06268B3B4B862119BE18BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
	<20190802073741.GI3459@hiutale>
	<7c7ee5f23029cdc0d421e6e50db145276d92ff80.camel@linuxfoundation.org>
	<CY4PR12MB1653701CE975ABAE431D26848BD90@CY4PR12MB1653.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1653701CE975ABAE431D26848BD90@CY4PR12MB1653.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.14.114.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 863ad5d4-69ef-4c9b-fe2e-08d7225ad558
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:CY4PR12MB1478; 
x-ms-traffictypediagnostic: CY4PR12MB1478:
x-microsoft-antispam-prvs: <CY4PR12MB1478D9EC38328508C393BCB98BAF0@CY4PR12MB1478.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(979002)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(29502001)(54094003)(66446008)(33656002)(25786009)(14454004)(6506007)(6116002)(26005)(4326008)(102836004)(86362001)(256004)(186003)(6436002)(53936002)(316002)(229853002)(76176011)(54906003)(3846002)(7696005)(81156014)(110136005)(6246003)(478600001)(66066001)(55016002)(81166006)(305945005)(7736002)(8676002)(11346002)(74316002)(71200400001)(71190400001)(8936002)(486006)(2501003)(446003)(5660300002)(64756008)(66556008)(99286004)(9686003)(52536014)(76116006)(476003)(66946007)(66476007)(2906002)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1478;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wXTjxTCDGTYlE306UKn33tdP9mEa9MM1QIxR6H+yu2uMgPY+D28cJsOtn3/ewhpuD5KvXNBL9LI/tegqiNymfn1sryijY1X9zejb6w1w4ydhEYHGFAYTzfNto9Q+Eb+fTWaaAmWKcf5mTbp5R75SCz347xHaKT7t1dnvpH2wizwym/8NJv+M46NABiwOvPWWHi30Ms0+wUCl6yJUskgMN09sQ0PsU8NYnKafAdHeopesf5lCSORuPIssU7PsGHrOzkgHM54pwwA8UKVlGUvW3KEXtUljfcmkvXfk16nvpB3fiA/mCSq9Jpp6e4KtzrFxJKS+kOMtKc6mXX47uP55fBgUZdoioTpx5YTIbWGXeZrN9qxBEWvusFSJ6x29eRr3MODBcmTN/CNvB70ddg8lOikqH/+/C77417ugoE1x6aE=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863ad5d4-69ef-4c9b-fe2e-08d7225ad558
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 15:03:01.6855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rne6idOTwtMjMASPQQINVPVQMBt33O5x6WuJlqmeBcHqAODHnVbZwoQv9lr8OvGdIlkht7CY2+VsYH3yzbcQ/UJujuYpmDytX2J4YaROIjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1478
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
X-List-Received-Date: Fri, 16 Aug 2019 15:03:02 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> > I think this supports my point about being more interested in patches
> > allowing people to extend/customise buildhistory than just adding X.
> >
> > Whilst we want to have good defaults, there are always going to be
> > niche cases for people wanting to extend it...
>=20
>=20
> Agreed. Then we can implement our BRANCH scheme without polluting the cor=
e code with it.

Richard, et al. -=20

I have created the cpl/buildhistory branch on poky-contrib to share a draft=
 of my ideas for making buildhistory more modular and extensible. Would app=
reciate any comments.

The first change was to break up buildhistory.bbclass. Previously it was ~1=
000 lines, one of the biggest bbclasses in meta/classes. Now, buildhistory =
just contains common functionality and plumbing for the buildhistory featur=
es. Each feature listed in BUILDHISTORY_FEATURES causes a class to be autom=
atically inherited, with a naming convention of "buildhistory-{feature}". I=
 created buildhistory-package, buildhistory-task, buildhistory-sdk, and bui=
ldhistory-image.

Users could extend buildhistory by inheriting from buildhistory directly (e=
.g. if they have a completely new type of buildhistory to implement), or th=
ey can inherit from a feature class. For example, buildhistory-my-custom-pa=
ckaging.bbclass. Then, they would use something like the following:

    BUILDHISTORY_FEATURES_remove =3D "package"
    BUILDHISTORY_FEATURES_append =3D " my-custom-packaging"

Alternatively, they could just add "buildhistory-my-custom-packaging" to IN=
HERIT.=20

Some features need to do additional things in the buildhistory event handle=
r, e.g. "task" writes task signatures during commit. For this, I created BU=
ILDHISTORY_COMMIT_PREFUNCS, which nicely decouples "task" from the base bui=
ldhistory class.

The only other big change (for now) on this branch is to abstract the build=
history-packaging feature a bit. I do this by introducing several "hooks":

    BUILDHISTORY_PACKAGE_HOOKS - Python functions or BB functions run at th=
e end of buildhistory_emit_pkghistory. Currently used to invoke buildhistor=
y_list_pkg_files.=20
    BUILDHISTORY_PACKAGE_RECIPEHISTORY_HOOKS - Python functions invoked in =
write_recipehistory, providing an opportunity to write additional lines to =
the per-recipe "latest" file.=20
    BUILDHISTORY_PACKAGE_PACKAGEHISTORY_HOOKS - Python functions invoked in=
 write_packagehistory providing an opportunity to write additional lines to=
 the per-package "latest" file.
    BUILDHISTORY_PACKAGE_SRCREV_HOOKS - Python functions invoked in write_l=
atest_srcrev, called once per srcrev-supporting SRC_URI.=20
    BUILDHISTORY_PACKAGE_TAGSRCREV_HOOKS - Python functions invoked in writ=
e_latest_srcrev, called once per tag srcrev SRC_URI.

Additionally, I have re-implemented the latest_srcrev functionality in term=
s of BUILDHISTORY_PACKAGE_SRCREV_HOOKS and BUILDHISTORY_PACKAGE_TAGSRCREV_H=
OOKS.

An example usage of BUILDHISTORY_PACKAGE_SRCREV_HOOKS could be the followin=
g:

    def branch_hook(d, name, srcrev, ud, total_count, f):=20
        if total_count =3D=3D 1:
            f.write('BRANCH =3D "{0}"\n'.format(ud.branches[name]))
        else:
            f.write('BRANCH_{0} =3D "{1}"\n'.format(name, ud.branches[name]=
))

    BUILDHISTORY_PACKAGE_SRCREV_HOOKS_append =3D " branch_hook"


Things I'm currently unsure about:
    1. Variable naming - I thought about calling them _PREFUNCS or _POSTFUN=
CS instead of _HOOKS, or something like that. But the problem is that some =
of them can only be Python functions, not BB functions. Which leads me to:
    2. Most hooks are intended to be Python functions that are found via lo=
oking in globals(). If someone has a better solution I'd be interested. But=
 I also don't think this one is necessarily bad.
    3. I'm trying to err on the side of not adding too many hooks for the f=
irst release. Hopefully the set I have chosen to add is seen as useful.
    4. I wonder if I should create a "buildhistory" directory under "classe=
s" into which I would move the feature classes. To avoid polluting the "cla=
sses" directory.

Additional stuff to explore:
    1. Adding a buildhistory-logs feature class, which archives the log.do_=
{TASK} for a user-configurable selection of tasks. Default would be compile=
, configure, and install.=20
    2. Adding other extension points where it makes sense.

Thanks,
Chris


