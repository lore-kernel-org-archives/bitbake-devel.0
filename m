Return-Path: <s.christ@phytec.de>
Received: from root.phytec.de (mail.rapiddevelopmentkit.de [217.6.246.34])
	by mail.openembedded.org (Postfix) with ESMTP id 36E3D731AC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jun 2016 11:00:38 +0000 (UTC)
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
	by root.phytec.de (Postfix) with ESMTP id 4AD90A00439;
	Thu, 23 Jun 2016 13:01:46 +0200 (CEST)
Received: from lws-christ ([172.16.11.131])
	by idefix.phytec.de (IBM Domino Release 9.0.1FP5 HF413)
	with ESMTP id 2016062313003872-1687 ;
	Thu, 23 Jun 2016 13:00:38 +0200 
Date: Thu, 23 Jun 2016 13:00:38 +0200
From: Stefan Christ <s.christ@phytec.de>
To: akuster <akuster@mvista.com>
Message-ID: <20160623110038.GD2346@lws-christ>
References: <1466588072-37331-1-git-send-email-s.christ@phytec.de>
	<576AB396.3020207@mvista.com>
MIME-Version: 1.0
In-Reply-To: <576AB396.3020207@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP5
	HF413|March 21, 2016) at 23.06.2016 13:00:38,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP5 HF413|March 21,
	2016) at 23.06.2016 13:00:38
X-TNEFEvaluated: 1
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH krogoth+] fetch2: fix unpack of symbolic links
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
X-List-Received-Date: Thu, 23 Jun 2016 11:00:39 -0000
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Armin,

On Wed, Jun 22, 2016 at 08:49:42AM -0700, akuster wrote:
> Does the "Krogoth+" mean "master" too?
>=20
> - armin
>=20

Yes. The patch applies on master and krogoth.

Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards,
	Stefan Christ

> On 06/22/2016 02:34 AM, Stefan Christ wrote:
> > Files in the download directory can be symbolic links to the real file.
> > The fetcher must copy the real file instead of copying the symbolic
> > link. Otherwise other tasks will fail, like patching, or the recipe will
> > modify files in the download directory.
> >=20
> > This patch fixes commit 865d2fef ("bitbake: fetch2: fixes copying of
> > file://dir; subdir=3Dfoo, bug 6128 and bug 6129").
> >=20
> > Signed-off-by: Stefan Christ <s.christ@phytec.de>
> > ---
> >  bitbake/lib/bb/fetch2/=5F=5Finit=5F=5F.py | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/bitbake/lib/bb/fetch2/=5F=5Finit=5F=5F.py b/bitbake/lib/bb=
/fetch2/=5F=5Finit=5F=5F.py
> > index e8fbe89..a1819e7 100644
> > --- a/bitbake/lib/bb/fetch2/=5F=5Finit=5F=5F.py
> > +++ b/bitbake/lib/bb/fetch2/=5F=5Finit=5F=5F.py
> > @@ -1423,7 +1423,9 @@ class FetchMethod(object):
> >                      if urlpath.find("/") !=3D -1:
> >                          destdir =3D urlpath.rsplit("/", 1)[0] + '/'
> >                          bb.utils.mkdirhier("%s/%s" % (unpackdir, destd=
ir))
> > -                cmd =3D 'cp -fpPR %s %s' % (file, destdir)
> > +                # Use -L to always resolve symbolic links. Files in do=
wnload
> > +                # directory can be links to the real file.
> > +                cmd =3D 'cp -fpLR %s %s' % (file, destdir)
> > =20
> >          if not cmd:
> >              return
> >=20

