Return-Path: <zhenhua.luo@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
	(mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
	by mail.openembedded.org (Postfix) with ESMTP id B9FFF6C6D4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jan 2014 10:21:55 +0000 (UTC)
Received: from DM2PR03MB399.namprd03.prod.outlook.com (10.141.84.148) by
	DM2PR03MB303.namprd03.prod.outlook.com (10.141.54.14) with Microsoft
	SMTP Server (TLS) id 15.0.851.11; Wed, 8 Jan 2014 10:21:54 +0000
Received: from DM2PR03MB399.namprd03.prod.outlook.com ([10.141.84.148]) by
	DM2PR03MB399.namprd03.prod.outlook.com ([10.141.84.148]) with mapi id
	15.00.0847.008; Wed, 8 Jan 2014 10:21:54 +0000
From: "zhenhua.luo@freescale.com" <zhenhua.luo@freescale.com>
To: Martin Jansa <martin.jansa@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH 1/2] bitbake: fetch2/git: Add sanity
	check for SHA validity of tag
Thread-Index: AQHPAH8nLje/Nfxiu0GWw2q/vwMifJpzEqSAgAQV1YCAAFV0gIABJCPAgADLlICAAUcSUA==
Date: Wed, 8 Jan 2014 10:21:53 +0000
Message-ID: <10ed04d1db504750b8a54f0786735f50@DM2PR03MB399.namprd03.prod.outlook.com>
References: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
	<1387872393-4567-2-git-send-email-zhenhua.luo@freescale.com>
	<20140103134343.GF3707@jama>
	<566cdb63dddc4dc28aa269289bf94ea8@DM2PR03MB399.namprd03.prod.outlook.com>
	<20140106091245.GE3709@jama>
	<c4d074a69c9d4c29b77cdf0bd01f7f20@DM2PR03MB399.namprd03.prod.outlook.com>
	<20140107144659.GR3709@jama>
In-Reply-To: <20140107144659.GR3709@jama>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.88.158.216]
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009001)(51704005)(189002)(199002)(51914003)(13464003)(24454002)(377454003)(51444003)(76576001)(76786001)(74706001)(81342001)(33646001)(74876001)(74366001)(74662001)(69226001)(76796001)(81542001)(74316001)(4396001)(31966008)(19580405001)(83322001)(47446002)(59766001)(77982001)(74502001)(19580395003)(54356001)(56776001)(54316002)(87266001)(87936001)(2656002)(81816001)(80976001)(81686001)(49866001)(47736001)(50986001)(90146001)(47976001)(56816005)(83072002)(85306002)(85852003)(76482001)(46102001)(66066001)(79102001)(63696002)(65816001)(53806001)(80022001)(15202345003)(51856001)(15975445006)(92566001)(24736002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM2PR03MB303;
	H:DM2PR03MB399.namprd03.prod.outlook.com; CLIP:192.88.158.216;
	FPR:; RD:InfoNoRecords; MX:1; A:1; LANG:en; 
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: "Zongchun.Yu@freescale.com" <Zongchun.Yu@freescale.com>,
	"B40290@freescale.com" <B40290@freescale.com>,
	"ting.liu@freescale.com" <ting.liu@freescale.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Richard Schmitt <richard.schmitt@freescale.com>
Subject: Re: [PATCH 1/2] bitbake: fetch2/git: Add sanity check for SHA validity of tag
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
X-List-Received-Date: Wed, 08 Jan 2014 10:21:56 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Martin Jansa [mailto:martin.jansa@gmail.com]
> Sent: Tuesday, January 07, 2014 10:47 PM
>=20
> On Tue, Jan 07, 2014 at 03:29:22AM +0000, zhenhua.luo@freescale.com wrote=
:
> > It is a simple way to add "nobranch" option to skip the SHA validity
> check. I have posted a patch, please review.
> >
> > http://patches.openembedded.org/patch/64197/
>=20
> The v2 looks good and it's already merged :).
>=20
> > > > 	When tag is defined in SRC_URI, there are three SHA
> definition
> > > scenarios:
> > > > 	* SRCREV is set to SHA corresponding to the tag, commit
> > > corresponding
> > > > to the tag will be used
> > >
> > > This is OK, but you cannot check that it really corresponds and show
> > > warning if not, because it could be now allowed variant with older
> > > SHA as bellow.
>=20
> Be aware that for this to work correctly you need to run "git fetch --
> tags" or equivalent, because with lightweight tags you can have repo like
> this:
>=20
> SHA-1
> A123  <- tag-1.0
> B123
> C123  <- master HEAD
>=20
> You're building C123 or tag-1.0 when C123 revision already exists, so
> fetcher creates clone including all 3 SHA-1s, it creates tarball with
> checkout and puts it on PREMIRROR.
>=20
> Someone in upstream adds tag-1.1 pointing to B123
>=20
> SHA-1
> A123  <- tag-1.0
> B123  <- tag-1.1
> C123  <- master HEAD
>=20
> Someone changes recipe to use:
> SRCREV =3D "B123"
> SRC_URI =3D "git://foo;tag=3Dtag-1.1"
>=20
> Current fetcher starts by checking if "B123" SHA-1 exists in checkout in
> downloads directory (or even downloaded from PREMIRROR) and it returns
> yes, so it doesn't try to update it, but then if you try to check that
> B123 corresponds with "tag-1.1" it fails, because tag-1.1 doesn't exist
> yet in current checkout/premirror.
>=20
> With annotated tags it's not problem because every new tag has new SHA-1,
> so fetcher always updates the checkout first when checking for new tag.
[Luo Zhenhua-B19537] Thanks for the explanation.=20

> > > > 	* SRCREV is set to an older SHA in the tag, the older commit
> in
> > > > the tag will be used
> > >
> > > This one is IMHO a bit confusing, because people can notice
> > > SRC_URI=3D.*;tag=3Dfoo
> > >
> > > and then they don't notice SRCREV in the recipe (or don't expect it
> > > to be older commit in foo tag) and they just assume that tag=3Dfoo
> > > means the tip of the tag will be used in build.
> > >
> > > In most cases such commit is also included in some branch and using
> > > just SRC_URI=3D.*;branch=3Dfoo + SRCREV would be less confusing.
> > >
> > > So I would show warning in this case.
> > >
> > > In very few exceptions (if any) where you really want SRCREV not
> > > included in any branch and included in some tag, but not
> > > corresponding to that tag you would use SRC_URI=3D.*;nobranch + SRCRE=
V
>=20
> I think that with nobranch patch now merged we should show warning when
> this case happens, people shouldn't use tag parameter when they don't
> want exactly that tag.
[Luo Zhenhua-B19537] You point is to show warning when SRCREV and tag are s=
et, meanwhile SRCREV is not corresponding to the tag, right?


Best Regards,

Zhenhua

