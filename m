Return-Path: <zhenhua.luo@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
	by mail.openembedded.org (Postfix) with ESMTP id 575D4615AE
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jan 2014 04:25:09 +0000 (UTC)
Received: from DM2PR03MB399.namprd03.prod.outlook.com (10.141.84.148) by
	DM2PR03MB304.namprd03.prod.outlook.com (10.141.54.26) with Microsoft
	SMTP Server (TLS) id 15.0.851.11; Mon, 6 Jan 2014 04:25:01 +0000
Received: from DM2PR03MB399.namprd03.prod.outlook.com ([10.141.84.148]) by
	DM2PR03MB399.namprd03.prod.outlook.com ([10.141.84.148]) with mapi id
	15.00.0847.008; Mon, 6 Jan 2014 04:25:01 +0000
From: "zhenhua.luo@freescale.com" <zhenhua.luo@freescale.com>
To: Martin Jansa <martin.jansa@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH 1/2] bitbake: fetch2/git: Add sanity
	check for SHA validity of tag
Thread-Index: AQHPAH8nLje/Nfxiu0GWw2q/vwMifJpzEqSAgAQV1YA=
Date: Mon, 6 Jan 2014 04:25:00 +0000
Message-ID: <566cdb63dddc4dc28aa269289bf94ea8@DM2PR03MB399.namprd03.prod.outlook.com>
References: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
	<1387872393-4567-2-git-send-email-zhenhua.luo@freescale.com>
	<20140103134343.GF3707@jama>
In-Reply-To: <20140103134343.GF3707@jama>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.151.195.50]
x-forefront-prvs: 0083A7F08A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009001)(189002)(199002)(377454003)(13464003)(51704005)(24454002)(87936001)(15975445006)(19580395003)(83322001)(15202345003)(85306002)(80976001)(87266001)(76786001)(81816001)(90146001)(19580405001)(81686001)(83072002)(85852003)(56816005)(49866001)(33646001)(76796001)(2656002)(51856001)(81342001)(76576001)(46102001)(74502001)(54316002)(47446002)(74662001)(76482001)(77982001)(59766001)(56776001)(79102001)(63696002)(54356001)(69226001)(81542001)(31966008)(50986001)(65816001)(47976001)(74706001)(66066001)(74876001)(80022001)(4396001)(53806001)(47736001)(74316001)(74366001)(24736002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM2PR03MB304;
	H:DM2PR03MB399.namprd03.prod.outlook.com; CLIP:123.151.195.50;
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
X-List-Received-Date: Mon, 06 Jan 2014 04:25:12 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-
> bounces@lists.openembedded.org] On Behalf Of Martin Jansa
> Sent: Friday, January 03, 2014 9:44 PM
>=20
> On Tue, Dec 24, 2013 at 04:06:32PM +0800, Zhenhua Luo wrote:
> > The change add the sanity check for SHA valididy when tag is defined
> > in SRC_URI, the check is useful for rebased git tree in which the
> > referred commit is not valid in branch and is saved in tag.
>=20
> I've tested this patch with corner case reported in:
> http://lists.openembedded.org/pipermail/openembedded-core/2013-
> December/087486.html
>=20
> and now I can "fix" yajl recipe fetch just by adding "tag=3D1.0.12" into
> the SRC_URI.
>=20
> But it's still a bit confusing for SRCREVs which are accessible from some
> tag, but aren't corresponding to that tag directly, people will assume
> that tag=3Dfoo in SRC_URI is really what will be used, but instead some
> older SRCREV can be used.
>=20
> Maybe we need 3rd option to prevent default "master" branch and handle
> SRCREVs not included in any branch and not matching any tag differently?
[Luo Zhenhua-B19537] Do you mean adding a new option to skip the validity c=
heck of SHA?

> Then we can add sanity check that when tag=3D and SRCREV are both used th=
an
> SRCREV should point to SHA-1 of annotated tag or dereferrenced tag.
[Luo Zhenhua-B19537] I submitted another patch to adjust the revision defin=
ition priority(http://patches.openembedded.org/patch/63703/).=20
	SHA define priority sequence.=20
	a) a source revision if SHA is specified by SRCREV
	b) a source revision if revision is specified in SRC_URI
	c) latest revision if SRCREV=3D"AUTOINC"
	d) None if not specified

	When tag is defined in SRC_URI, there are three SHA definition scenarios:=
=20
	* SRCREV is set to SHA corresponding to the tag, commit corresponding to t=
he tag will be used
	* SRCREV is set to an older SHA in the tag, the older commit in the tag wi=
ll be used
	* SRCREV is not set, commit corresponding to the tag will be used.=20
	Does above implementation make sense? Or any other better method?=20


Best Regards,

Zhenhua

> > Signed-off-by: Zhenhua Luo <zhenhua.luo@freescale.com>
> > ---
> >  lib/bb/fetch2/git.py | 29 +++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py index
> > bd107db..1c2d5d3 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -116,6 +116,15 @@ class Git(FetchMethod):
> >              ud.branches[name] =3D branch
> >              ud.unresolvedrev[name] =3D branch
> >
> > +        tags =3D ud.parm.get("tag", "").split(',')
> > +        if len(tags) !=3D len(ud.names):
> > +            raise bb.fetch2.ParameterError("The number of name and tag
> parameters is not balanced", ud.url)
> > +        ud.tags =3D {}
> > +        for name in ud.names:
> > +            tag =3D tags[ud.names.index(name)]
> > +            ud.tags[name] =3D tag
> > +            ud.unresolvedrev[name] =3D tag
> > +
> >          ud.basecmd =3D data.getVar("FETCHCMD_git", d, True) or "git"
> >
> >          ud.write_tarballs =3D
> > ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") !=3D "0")
> or ud.rebaseable @@ -218,7 +227,10 @@ class Git(FetchMethod):
> >          os.chdir(ud.clonedir)
> >          for name in ud.names:
> >              if not self._contains_ref(ud, d, name):
> > -                raise bb.fetch2.FetchError("Unable to find revision %s
> in branch %s even from upstream" % (ud.revisions[name],
> ud.branches[name]))
> > +                if ud.tags[name]:
> > +                    raise bb.fetch2.FetchError("Unable to find
> revision %s in tag %s even from upstream" % (ud.revisions[name],
> ud.tags[name]))
> > +                else:
> > +                    raise bb.fetch2.FetchError("Unable to find
> > + revision %s in branch %s even from upstream" % (ud.revisions[name],
> > + ud.branches[name]))
> >
> >      def build_mirror_data(self, ud, d):
> >          # Generate a mirror tarball if needed @@ -288,6 +300,18 @@
> > class Git(FetchMethod):
> >          return True
> >
> >      def _contains_ref(self, ud, d, name):
> > +        if len(ud.tags[name]) !=3D 0:
> > +            cmd =3D  "%s tag --contains %s --list %s 2> /dev/null | wc=
 -
> l" % (
> > +                ud.basecmd, ud.revisions[name], ud.tags[name])
> > +            try:
> > +                output =3D runfetchcmd(cmd, d, quiet=3DTrue)
> > +            except bb.fetch2.FetchError:
> > +                return False
> > +            if len(output.split()) > 1:
> > +                raise bb.fetch2.FetchError("The command '%s' gave
> output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
> > +            else:
> > +                return output.split()[0] !=3D "0"
> > +
> >          cmd =3D  "%s branch --contains %s --list %s 2> /dev/null | wc =
-
> l" % (
> >              ud.basecmd, ud.revisions[name], ud.branches[name])
> >          try:
> > @@ -296,7 +320,8 @@ class Git(FetchMethod):
> >              return False
> >          if len(output.split()) > 1:
> >              raise bb.fetch2.FetchError("The command '%s' gave output
> with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
> > -        return output.split()[0] !=3D "0"
> > +        else:
> > +            return output.split()[0] !=3D "0"
> >
> >      def _revision_key(self, ud, d, name):
> >          """
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

