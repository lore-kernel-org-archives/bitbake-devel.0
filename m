Return-Path: <zhenhua.luo@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
	(mail-bn1lp0157.outbound.protection.outlook.com [207.46.163.157])
	by mail.openembedded.org (Postfix) with ESMTP id 4611C6BE7A
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 10:47:41 +0000 (UTC)
Received: from DM2PR03MB399.namprd03.prod.outlook.com (10.141.84.148) by
	DM2PR03MB304.namprd03.prod.outlook.com (10.141.54.26) with Microsoft
	SMTP Server (TLS) id 15.0.851.11; Tue, 7 Jan 2014 10:47:40 +0000
Received: from DM2PR03MB399.namprd03.prod.outlook.com ([10.141.84.148]) by
	DM2PR03MB399.namprd03.prod.outlook.com ([10.141.84.148]) with mapi id
	15.00.0847.008; Tue, 7 Jan 2014 10:47:40 +0000
From: "zhenhua.luo@freescale.com" <zhenhua.luo@freescale.com>
To: Martin Jansa <martin.jansa@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: fetch2/git: add nobranch
	option for SRC_URI to skip validating SHA
Thread-Index: AQHPC1eIwILDvyuyw0u1PAzfQMCcgZp47+0AgAAkp/A=
Date: Tue, 7 Jan 2014 10:47:40 +0000
Message-ID: <b2d835d57a00442e9a2b1a374c67fcab@DM2PR03MB399.namprd03.prod.outlook.com>
References: <1389064866-26141-1-git-send-email-zhenhua.luo@freescale.com>
	<20140107083440.GM3709@jama>
In-Reply-To: <20140107083440.GM3709@jama>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.88.158.212]
x-forefront-prvs: 008421A8FF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009001)(13464003)(51704005)(377454003)(164054003)(24454002)(51444003)(189002)(199002)(59766001)(77982001)(76482001)(63696002)(56776001)(79102001)(47446002)(74502001)(54316002)(46102001)(74662001)(74876001)(53806001)(74706001)(66066001)(47976001)(65816001)(74316001)(47736001)(74366001)(80022001)(4396001)(50986001)(54356001)(31966008)(69226001)(81542001)(80976001)(76786001)(87266001)(15975445006)(87936001)(15202345003)(85306002)(83322001)(19580395003)(76576001)(76796001)(49866001)(33646001)(81342001)(51856001)(2656002)(19580405001)(81686001)(90146001)(83072002)(81816001)(56816005)(85852003)(24736002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM2PR03MB304;
	H:DM2PR03MB399.namprd03.prod.outlook.com; CLIP:192.88.158.212;
	FPR:; RD:InfoNoRecords; MX:1; A:1; LANG:en; 
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: "Zongchun.Yu@freescale.com" <Zongchun.Yu@freescale.com>,
	"B40290@freescale.com" <B40290@freescale.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Richard Schmitt <richard.schmitt@freescale.com>
Subject: Re: [PATCH] bitbake: fetch2/git: add nobranch option for SRC_URI to skip validating SHA
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
X-List-Received-Date: Tue, 07 Jan 2014 10:47:42 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks, v2 is submitted, please review.=20

http://patches.openembedded.org/patch/64209/


Best Regards,

Zhenhua


> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-
> bounces@lists.openembedded.org] On Behalf Of Martin Jansa
> Sent: Tuesday, January 07, 2014 4:35 PM
> To: Luo Zhenhua-B19537
> Cc: Schmitt Richard-B43082; Guo Chunrong-B40290; bitbake-
> devel@lists.openembedded.org; Yu Zongchun-B40527
> Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2/git: add nobranch
> option for SRC_URI to skip validating SHA
>=20
> On Tue, Jan 07, 2014 at 11:21:06AM +0800, Zhenhua Luo wrote:
> > For rebased git tree, some commits can be found in tag rather than
> > branch, the change is useful for such case.
> >
> > Signed-off-by: Zhenhua Luo <zhenhua.luo@freescale.com>
> > ---
> >  lib/bb/fetch2/git.py | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py index
> > b4b9368..6d74dbb 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -101,6 +101,8 @@ class Git(FetchMethod):
> >
> >          ud.rebaseable =3D ud.parm.get("rebaseable","0") =3D=3D "1"
> >
> > +        ud.nobranch =3D ud.parm.get("nobranch","0") =3D=3D "1"
> > +
> >          # bareclone implies nocheckout
> >          ud.bareclone =3D ud.parm.get("bareclone","0") =3D=3D "1"
> >          if ud.bareclone:
> > @@ -217,7 +219,7 @@ class Git(FetchMethod):
> >              ud.repochanged =3D True
> >          os.chdir(ud.clonedir)
> >          for name in ud.names:
> > -            if not self._contains_ref(ud, d, name):
> > +            if not ud.nobranch and not self._contains_ref(ud, d, name)=
:
>=20
> I think that even with nobranch param set you need to check that SHA-1 is
> included, you just don't care in which branch if it's even included in
> any.
>=20
> Something like
>   def _contains_ref(self, tag, branch, d):
> was doing before 89abfbc1953e3711d6c90aff793ee622c22609b1, so the
> conditional should be in _contains_ref not skipping it completely.
>=20
> >                  raise bb.fetch2.FetchError("Unable to find revision
> > %s in branch %s even from upstream" % (ud.revisions[name],
> > ud.branches[name]))
> >
> >      def build_mirror_data(self, ud, d):
> > --
> > 1.8.4.2
> >
> >
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>=20
> --
> Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

