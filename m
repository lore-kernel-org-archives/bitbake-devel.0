Return-Path: <zhenhua.luo@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
	by mail.openembedded.org (Postfix) with ESMTP id 3C8A26BFFE
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 03:29:31 +0000 (UTC)
Received: from DM2PR03MB399.namprd03.prod.outlook.com (10.141.84.148) by
	DM2PR03MB304.namprd03.prod.outlook.com (10.141.54.26) with Microsoft
	SMTP Server (TLS) id 15.0.851.11; Tue, 7 Jan 2014 03:29:24 +0000
Received: from DM2PR03MB399.namprd03.prod.outlook.com ([10.141.84.148]) by
	DM2PR03MB399.namprd03.prod.outlook.com ([10.141.84.148]) with mapi id
	15.00.0847.008; Tue, 7 Jan 2014 03:29:24 +0000
From: "zhenhua.luo@freescale.com" <zhenhua.luo@freescale.com>
To: Martin Jansa <martin.jansa@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH 1/2] bitbake: fetch2/git: Add sanity
	check for SHA validity of tag
Thread-Index: AQHPAH8nLje/Nfxiu0GWw2q/vwMifJpzEqSAgAQV1YCAAFV0gIABJCPA
Date: Tue, 7 Jan 2014 03:29:22 +0000
Message-ID: <c4d074a69c9d4c29b77cdf0bd01f7f20@DM2PR03MB399.namprd03.prod.outlook.com>
References: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
	<1387872393-4567-2-git-send-email-zhenhua.luo@freescale.com>
	<20140103134343.GF3707@jama>
	<566cdb63dddc4dc28aa269289bf94ea8@DM2PR03MB399.namprd03.prod.outlook.com>
	<20140106091245.GE3709@jama>
In-Reply-To: <20140106091245.GE3709@jama>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.88.158.212]
x-forefront-prvs: 008421A8FF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009001)(189002)(199002)(377454003)(13464003)(51704005)(24454002)(87936001)(19580395003)(83322001)(15202345003)(85306002)(15975445006)(80976001)(87266001)(76786001)(81816001)(90146001)(81686001)(19580405001)(83072002)(56816005)(85852003)(49866001)(33646001)(76576001)(76796001)(2656002)(51856001)(81342001)(46102001)(74502001)(54316002)(47446002)(74662001)(76482001)(77982001)(59766001)(56776001)(79102001)(63696002)(54356001)(69226001)(81542001)(31966008)(47976001)(65816001)(66066001)(74876001)(74706001)(53806001)(80022001)(50986001)(4396001)(47736001)(74316001)(74366001)(24736002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM2PR03MB304;
	H:DM2PR03MB399.namprd03.prod.outlook.com; CLIP:192.88.158.212;
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
X-List-Received-Date: Tue, 07 Jan 2014 03:29:31 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

It is a simple way to add "nobranch" option to skip the SHA validity check.=
 I have posted a patch, please review.=20

http://patches.openembedded.org/patch/64197/


Best Regards,

Zhenhua

> -----Original Message-----
> From: Martin Jansa [mailto:martin.jansa@gmail.com]
> Sent: Monday, January 06, 2014 5:13 PM
> To: Luo Zhenhua-B19537
> Cc: Guo Chunrong-B40290; bitbake-devel@lists.openembedded.org; Yu
> Zongchun-B40527; Schmitt Richard-B43082; Liu Ting-B28495
> Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake: fetch2/git: Add sanity
> check for SHA validity of tag
>=20
> On Mon, Jan 06, 2014 at 04:25:00AM +0000, zhenhua.luo@freescale.com wrote=
:
> > > -----Original Message-----
> > > From: bitbake-devel-bounces@lists.openembedded.org
> > > [mailto:bitbake-devel- bounces@lists.openembedded.org] On Behalf Of
> > > Martin Jansa
> > > Sent: Friday, January 03, 2014 9:44 PM
> > >
> > > On Tue, Dec 24, 2013 at 04:06:32PM +0800, Zhenhua Luo wrote:
> > > > The change add the sanity check for SHA valididy when tag is
> > > > defined in SRC_URI, the check is useful for rebased git tree in
> > > > which the referred commit is not valid in branch and is saved in
> tag.
> > >
> > > I've tested this patch with corner case reported in:
> > > http://lists.openembedded.org/pipermail/openembedded-core/2013-
> > > December/087486.html
> > >
> > > and now I can "fix" yajl recipe fetch just by adding "tag=3D1.0.12"
> > > into the SRC_URI.
> > >
> > > But it's still a bit confusing for SRCREVs which are accessible from
> > > some tag, but aren't corresponding to that tag directly, people will
> > > assume that tag=3Dfoo in SRC_URI is really what will be used, but
> > > instead some older SRCREV can be used.
> > >
> > > Maybe we need 3rd option to prevent default "master" branch and
> > > handle SRCREVs not included in any branch and not matching any tag
> differently?
> > [Luo Zhenhua-B19537] Do you mean adding a new option to skip the
> validity check of SHA?
>=20
> Yes, I was thinking about something like nobranch parameter which will
> explicitly say that selected SRCREV is known to be not included in any
> branch or any tag.
>=20
> In most cases it shouldn't be needed but still such corner cases exist
> (e.g. rebased repos).
>=20
> > > Then we can add sanity check that when tag=3D and SRCREV are both use=
d
> > > than SRCREV should point to SHA-1 of annotated tag or dereferrenced
> tag.
> > [Luo Zhenhua-B19537] I submitted another patch to adjust the revision
> definition priority(http://patches.openembedded.org/patch/63703/).
> > 	SHA define priority sequence.
> > 	a) a source revision if SHA is specified by SRCREV
> > 	b) a source revision if revision is specified in SRC_URI
> > 	c) latest revision if SRCREV=3D"AUTOINC"
> > 	d) None if not specified
> >
> > 	When tag is defined in SRC_URI, there are three SHA definition
> scenarios:
> > 	* SRCREV is set to SHA corresponding to the tag, commit
> corresponding
> > to the tag will be used
>=20
> This is OK, but you cannot check that it really corresponds and show
> warning if not, because it could be now allowed variant with older SHA as
> bellow.
>=20
> > 	* SRCREV is set to an older SHA in the tag, the older commit in the
> > tag will be used
>=20
> This one is IMHO a bit confusing, because people can notice
> SRC_URI=3D.*;tag=3Dfoo
>=20
> and then they don't notice SRCREV in the recipe (or don't expect it to be
> older commit in foo tag) and they just assume that tag=3Dfoo means the ti=
p
> of the tag will be used in build.
>=20
> In most cases such commit is also included in some branch and using just
> SRC_URI=3D.*;branch=3Dfoo + SRCREV would be less confusing.
>=20
> So I would show warning in this case.
>=20
> In very few exceptions (if any) where you really want SRCREV not included
> in any branch and included in some tag, but not corresponding to that tag
> you would use SRC_URI=3D.*;nobranch + SRCREV
>=20
> > 	* SRCREV is not set, commit corresponding to the tag will be used.
> > 	Does above implementation make sense? Or any other better method?
>=20
> We're doing something similar
> https://github.com/openwebos/meta-
> webos/blob/master/classes/webos_enhanced_submissions.bbclass
> with the advantage that we can say that all our components which inherit
> this class have to use annotated tags (with lightweight tags you can use
> SRCREV corresponding with tag which exists only in remote repository, but
> isn't in your downloads/premirror version, even when the SRCREV exists
> already - annotated tag has always new SRCREV so fetcher will always
> update the repo and we don't need to use git ls-remote to verify that
> SRCREV is matching the tag.
>=20
> > > > Signed-off-by: Zhenhua Luo <zhenhua.luo@freescale.com>
> > > > ---
> > > >  lib/bb/fetch2/git.py | 29 +++++++++++++++++++++++++++--
> > > >  1 file changed, 27 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py index
> > > > bd107db..1c2d5d3 100644
> > > > --- a/lib/bb/fetch2/git.py
> > > > +++ b/lib/bb/fetch2/git.py
> > > > @@ -116,6 +116,15 @@ class Git(FetchMethod):
> > > >              ud.branches[name] =3D branch
> > > >              ud.unresolvedrev[name] =3D branch
> > > >
> > > > +        tags =3D ud.parm.get("tag", "").split(',')
> > > > +        if len(tags) !=3D len(ud.names):
> > > > +            raise bb.fetch2.ParameterError("The number of name
> > > > + and tag
> > > parameters is not balanced", ud.url)
> > > > +        ud.tags =3D {}
> > > > +        for name in ud.names:
> > > > +            tag =3D tags[ud.names.index(name)]
> > > > +            ud.tags[name] =3D tag
> > > > +            ud.unresolvedrev[name] =3D tag
> > > > +
> > > >          ud.basecmd =3D data.getVar("FETCHCMD_git", d, True) or "gi=
t"
> > > >
> > > >          ud.write_tarballs =3D
> > > > ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") !=3D
> > > > "0")
> > > or ud.rebaseable @@ -218,7 +227,10 @@ class Git(FetchMethod):
> > > >          os.chdir(ud.clonedir)
> > > >          for name in ud.names:
> > > >              if not self._contains_ref(ud, d, name):
> > > > -                raise bb.fetch2.FetchError("Unable to find
> revision %s
> > > in branch %s even from upstream" % (ud.revisions[name],
> > > ud.branches[name]))
> > > > +                if ud.tags[name]:
> > > > +                    raise bb.fetch2.FetchError("Unable to find
> > > revision %s in tag %s even from upstream" % (ud.revisions[name],
> > > ud.tags[name]))
> > > > +                else:
> > > > +                    raise bb.fetch2.FetchError("Unable to find
> > > > + revision %s in branch %s even from upstream" %
> > > > + (ud.revisions[name],
> > > > + ud.branches[name]))
> > > >
> > > >      def build_mirror_data(self, ud, d):
> > > >          # Generate a mirror tarball if needed @@ -288,6 +300,18
> > > > @@ class Git(FetchMethod):
> > > >          return True
> > > >
> > > >      def _contains_ref(self, ud, d, name):
> > > > +        if len(ud.tags[name]) !=3D 0:
> > > > +            cmd =3D  "%s tag --contains %s --list %s 2> /dev/null =
|
> > > > + wc -
> > > l" % (
> > > > +                ud.basecmd, ud.revisions[name], ud.tags[name])
> > > > +            try:
> > > > +                output =3D runfetchcmd(cmd, d, quiet=3DTrue)
> > > > +            except bb.fetch2.FetchError:
> > > > +                return False
> > > > +            if len(output.split()) > 1:
> > > > +                raise bb.fetch2.FetchError("The command '%s' gave
> > > output with more then 1 line unexpectedly, output: '%s'" % (cmd,
> > > output))
> > > > +            else:
> > > > +                return output.split()[0] !=3D "0"
> > > > +
> > > >          cmd =3D  "%s branch --contains %s --list %s 2> /dev/null |
> > > > wc -
> > > l" % (
> > > >              ud.basecmd, ud.revisions[name], ud.branches[name])
> > > >          try:
> > > > @@ -296,7 +320,8 @@ class Git(FetchMethod):
> > > >              return False
> > > >          if len(output.split()) > 1:
> > > >              raise bb.fetch2.FetchError("The command '%s' gave
> > > > output
> > > with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
> > > > -        return output.split()[0] !=3D "0"
> > > > +        else:
> > > > +            return output.split()[0] !=3D "0"
> > > >
> > > >      def _revision_key(self, ud, d, name):
> > > >          """
> > > > --
> > > > 1.8.4.2
> > > >
> > > >
> > > > _______________________________________________
> > > > bitbake-devel mailing list
> > > > bitbake-devel@lists.openembedded.org
> > > > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> > >
> > > --
> > > Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com
>=20
> --
> Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

