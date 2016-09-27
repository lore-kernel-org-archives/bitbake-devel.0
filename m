Return-Path: <s.lengfeld@phytec.de>
Received: from root.phytec.de (mail.phytec.de [217.6.246.34])
	by mail.openembedded.org (Postfix) with ESMTP id A40D960102
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 08:13:10 +0000 (UTC)
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
	by root.phytec.de (Postfix) with ESMTP id BB301A00244
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 10:13:31 +0200 (CEST)
Received: from lws-christ ([172.16.11.121])
	by idefix.phytec.de (IBM Domino Release 9.0.1FP5 HF413)
	with ESMTP id 2016092710131101-249430 ;
	Tue, 27 Sep 2016 10:13:11 +0200 
Date: Tue, 27 Sep 2016 10:13:11 +0200
From: Stefan Lengfeld <s.lengfeld@phytec.de>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20160927081311.GA3984@lws-christ>
References: <1474373528-5865-1-git-send-email-s.lengfeld@phytec.de>
MIME-Version: 1.0
In-Reply-To: <1474373528-5865-1-git-send-email-s.lengfeld@phytec.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP5
	HF413|March 21, 2016) at 27.09.2016 10:13:11,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP5 HF413|March 21,
	2016) at 27.09.2016 10:13:11
X-TNEFEvaluated: 1
Subject: Re: [PATCH krogoth] bitbake: fetch: copy files with -H
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
X-List-Received-Date: Tue, 27 Sep 2016 08:13:10 -0000
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

*ping.

Is there a way I can help to speed up the backport of this patch to krogoth?
Should I send the patch to a different mailing list? Thanks.

Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards,
	Stefan Lengfeld

On Tue, Sep 20, 2016 at 02:12:08PM +0200, Stefan Lengfeld wrote:
> From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
>=20
> When using a PREMIRROR with plain (non-unpack) files, a SRC=5FURI like
>=20
> SRC=5FURI =3D "file://devmem2.c"
>=20
> will cause devmem2.c to be a symlink in the WORKDIR pointing to the
> local PREMIRROR.
>=20
> Trying to apply a patch on this file will either modify the file on
> the PREMIRROR or will fail due to sanity checks:
>=20
> ERROR: devmem2-1.0-r7 do=5Fpatch: Command Error: 'quilt --quiltrc /cache/=
build-ubuntu/sysroots/x86=5F64-oe-linux/etc/quiltrc push' exited with 1  Ou=
tput:
> Applying patch devmem2-fixups-2.patch
> File devmem2.c is not a regular file -- refusing to patch
>=20
> (Bitbake rev: cfd481fe9799e7a4c6bfac32e56cc91cfcd81088)
>=20
> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> Hi,
>=20
> this patch was already applied on poky's master branch. Can you please ba=
ckport
> it to krogoth. The bug is there, too. I already posted a different patch =
some
> time ago:
>=20
>     http://lists.openembedded.org/pipermail/bitbake-devel/2016-June/00762=
1.html
>=20
> Thanks.
>=20
> Kind regards,
> 	Stefan Lengfeld
> ---
>  bitbake/lib/bb/fetch2/=5F=5Finit=5F=5F.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/=5F=5Finit=5F=5F.py b/bitbake/lib/bb/f=
etch2/=5F=5Finit=5F=5F.py
> index 6ef0c6f..7773c16 100644
> --- a/bitbake/lib/bb/fetch2/=5F=5Finit=5F=5F.py
> +++ b/bitbake/lib/bb/fetch2/=5F=5Finit=5F=5F.py
> @@ -1424,7 +1424,7 @@ class FetchMethod(object):
>                      if urlpath.find("/") !=3D -1:
>                          destdir =3D urlpath.rsplit("/", 1)[0] + '/'
>                          bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir=
))
> -                cmd =3D 'cp -fpPR %s %s' % (file, destdir)
> +                cmd =3D 'cp -fpPRH %s %s' % (file, destdir)
> =20
>          if not cmd:
>              return
> --=20
> 1.9.1
>=20
> --=20
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

