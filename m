Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.web09.930.1616287136395713829
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 20 Mar 2021 17:38:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id 0C4D340BEC;
	Sun, 21 Mar 2021 00:38:55 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5FgKA2oAjCzr; Sun, 21 Mar 2021 00:38:54 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-86-127.washdc.fios.verizon.net [100.15.86.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id D05AA40BA8;
	Sun, 21 Mar 2021 00:38:52 +0000 (UTC)
Received: by mail.denix.org (Postfix, from userid 1000)
	id 396BF174557; Sat, 20 Mar 2021 20:38:52 -0400 (EDT)
Date: Sat, 20 Mar 2021 20:38:52 -0400
From: "Denys Dmytriyenko" <denis@denix.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Christopher Larson <kergoth@gmail.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: make sure clonedir is empty when trying next fullmirror
Message-ID: <20210321003852.GG18041@denix.org>
References: <1616099999-47367-1-git-send-email-denis@denix.org>
 <336663df14ccfcaddd49f5ae3345ffef5a44d658.camel@linuxfoundation.org>
 <CABcZANnicqNdbiV-mkDsChRp=sT2_PA_Y+YS5CEoxU3adAdpig@mail.gmail.com>
 <19e8629424d911ac9aa6f53f4825834e694c6ddd.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <19e8629424d911ac9aa6f53f4825834e694c6ddd.camel@linuxfoundation.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 18, 2021 at 10:32:34PM +0000, Richard Purdie wrote:
> On Thu, 2021-03-18 at 15:28 -0700, Christopher Larson wrote:
> >=20
> >=20
> > On Thu, Mar 18, 2021 at 3:23 PM Richard Purdie <richard.purdie@linuxf=
oundation.org> wrote:
> > > On Thu, 2021-03-18 at 16:39 -0400, Denys Dmytriyenko wrote:
> > > > When first mirror returns an outdated fullmirror tarball, its clo=
nedir stays
> > > > behind for successive mirror tries. Even when latest tarball gets=
 fetched
> > > > next, it doesn't get unpacked, as clonedir already exists. Cleanu=
p old
> > > > clonedir and unpack the new fullmirror tarball, when the old clon=
edir is
> > > > no good and requires update.
> > > >=20
> > > > Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> > > > ---
> > > > =A0lib/bb/fetch2/git.py | 3 ++-
> > > > =A01 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > > > index e3ba80a..cb62dcc 100644
> > > > --- a/lib/bb/fetch2/git.py
> > > > +++ b/lib/bb/fetch2/git.py
> > > > @@ -337,7 +337,8 @@ class Git(FetchMethod):
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0if ud.shallow and os.path.exists(ud.fu=
llshallow) and self.need_update(ud, d):
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ud.localpath =3D ud.fullsh=
allow
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return
> > > > -=A0 =A0 =A0 =A0 elif os.path.exists(ud.fullmirror) and not os.pa=
th.exists(ud.clonedir):
> > > > +=A0 =A0 =A0 =A0 elif os.path.exists(ud.fullmirror) and (not os.p=
ath.exists(ud.clonedir) or
> > > self.clonedir_need_update(ud, d)):
> > > > +=A0 =A0 =A0 =A0 =A0 =A0 bb.utils.remove(ud.clonedir, recurse=3DT=
rue)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0bb.utils.mkdirhier(ud.clon=
edir)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0runfetchcmd("tar -xzf %s" =
% ud.fullmirror, d, workdir=3Dud.clonedir)
> > >=20
> > > I talked a little with Denys about this. I'm worried that if you sp=
ecify=A0
> > > SRCREV incorrectly it will start blowing away clone directories and
> > > for large ones like linux-yocto, the failure mode is *really* annoy=
ing=20
> > > and has the potential for data loss (you shouldn't be putting impor=
tant data
> > > here, but...).
> > >=20
> > > I agree that we do need a test case. We can put artefacts on yp.org=
 urls
> > > if needed.
> > >=20
> > > I also wonder if we can't check the new mirror tarball is any bette=
r before
> > > we blow away the existing directory.
> > >=20
> >=20
> >=20
> > I'm assuming this is for the case where the clonedir can't be updated
> > directly, ie premirrorsonly?
>=20
> Effectively. If I understand Denys' case, the upstream is down, the fir=
st mirror
> tarball it out of date and the second mirror tarball found is not.

Yes, that was exactly my case.


> > That's a good idea, unpack the new one to a temporary location, see i=
f=A0
> > that one is good enough first. It makes me wonder if there's a way to=
=A0
> > use git bundles or something that can be interacted with more directl=
y.=A0
> > I'm assuming this is for the case where the clonedir=A0can't be direc=
tly=A0
> > updated, i.e. premirrorsonly?
>=20
> Right, yes. For whatever reason the original source is unavailable and =
we=A0
> have multiple conflicting mirror data sources we can't immediately insp=
ect.

Shouldn't need_update() be sufficient indication that clonedir doesn't ha=
ve=20
the required SRCREV we are looking for?

I believe you also mentioned cases of locally-modified clonedir that we d=
on't=20
want to blow away here. Is there an execution path that would come here t=
o=20
do_fetch() with fullmirror? E.g. you got it previously fetched and unpack=
ed=20
successfully, modified the recipe with new (potentially bad) SRCREV, and =
now=20
bitbake while trying to fetch that, ends up blowing away good clonedir an=
d=20
replace it with potentially outdated mirror clone, correct?

So, how about we always untar fullmirror into a new clonedir2, then run=20
need_update() on it and if False, replace clonedir with clonedir2, otherw=
ise=20
wipe out bad clonedir2. Would that work?

Are there any other checks besides need_update() that determine if cloned=
ir=20
is good or not?

--=20
Denys
