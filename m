Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5843CA5FB1
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 10:51:57 +0000 (UTC)
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10638.1790765512798312011
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Sep 2026 03:51:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=uw8JeJxo;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=Pr5uEzZ/;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.146, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D81B0EC021F;
	Wed, 30 Sep 2026 06:51:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 06:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790765511;
	 x=1790851911; bh=EUW9qwBvVZHQbUstt9sLmA8qmrIYCXkfZDgxiKBO9y8=; b=
	uw8JeJxorpIwP69S9qRtcmBxJ0N4T7MQUckMP26gm4NtzuH2qE8pAPNDW5FCIwO9
	HrHr0t2fnBYRaMwVLObuwNy1K4twEcgOEPxOPVH6bYTP5cnARKjvjwDspaT2vrVs
	UZThuEHm9MB08r7kULunnw5QYohe6WLuMFVv3sUUNTRkvVuA/jmVofOq/lURfDpz
	OAqd7nZxgB1Xgq1wt89dlwpuoYOwKqBU85wImndBWMd1Z2jqW+NhkwaGi7K1LOMd
	fA/r+NFj0pIdayXfyp2YN9vagbQ9PUVZNhK23Oc3k/sctBiOeYa1nfe0mr8gtNjC
	AZUpsBgQmvP9hOh4lIsxLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790765511; x=1790851911; bh=E
	UW9qwBvVZHQbUstt9sLmA8qmrIYCXkfZDgxiKBO9y8=; b=Pr5uEzZ/qiYDOL2xG
	oF7kEQqwNq4JfbR7vk//l9+4EbAWwwoqnF/44YwbbJzP1EV9q09B8gm5YebS8e5c
	ShSkBU/gmkm+ZJuFSbEi88odx8HUY87KFb5F4XJXIIl+hhu+623FHRGXo9EKPiyV
	/wyEnq055axvNAtxh+/W+ArWeHH+dJciwp4sF5vqRNH5+6sEtsCO95iHc9RKLJs4
	FUUmkVPWIqsxlPNOVf4a8PFKwWZna78PrUMICPycboD7qsIv4sukxyL443cIyFv5
	uHWDAiU4gpVmwOPoEE5rDUbpd8mFvWywJDQB6XGTJi1XZrpcPPqkDTn30ZPsSpHy
	CftqA==
X-ME-Sender: <xms:x-m8ahzZrJfX2QKKe6d7wmZonNJ4V4M3rTycclrBl_fQVphM5DHd1A>
    <xme:x-m8aouQSf8p_r-sTVu0FhpPtzlNWuMzwQCduGkqoakC5IOOLPFuTHsDQkNjLyHoH
    5eQQLeo_kMmSUB02tFGIBp1mWPqeQPOkV5iNJiVARsoJJKiNqJK4QuLBg>
X-ME-Received: <xmr:x-m8aot10cgRRVAGusweyF7HW_JBF8iqI9kR6V0ct4hNAy7E9gQcduWCebK-WTWZOqSB5ITEOLYka8PXnye6DvRRxviz1HGYGEE1FBI>
X-ME-Proxy-Cause: dmFkZTF58h8e7Yh9ahNQtKY6PjFXKUxmM2E5BjZHlreFUdNdE8W/6I/hl0s3Q5eEc/dCnc
    8PgNd42P3DffNdWGjmYJaNBKylBIK9qDlUhyELh+g5S2TZWeg7ZavCZB+AH7E4ODQs9gw0
    AFeQWGYdr5dYR4eZR59azYyg7qkMq6DwErTlr47tVopcIwtHjemCzhCVBlX95keyLPgTon
    s5tTBMgQ8U6MRmMsRGxcpAfkXnh+AdLREVwWseXjIWG+mp0bSF8gGAJ36yNtFwGOIgzt/8
    lZhlliSy2f+pfobGyJAF1NhshZ4e4VqW5G+244noOnDQA0Cd3UN2UDE2Xf9lWgEd84dlKX
    /VQcbpY8nlslQIFk2DZtag6FLB3+0rxbVAL+UA/O+3ucyECtmz4VQGIzCjqBinVolS47TC
    /zLhudpYNUYH+naK97sBIH1/869FK7JsdsemABP7wX99CIZEc4SIih8tTsPf0i62gFS9ro
    9G//nKcteITRCJHrhe/pUyC9/Jb7JLv4BIO04FaK3Pp0HeMNCP7z1GLuL90RX0bB13sFB6
    BFbhPo8JqOa9NYpaG28KEAD53UKP2+2Af7z8F54Wk9RHN5RP33x0TR6EsDCyPwdc7RCuaK
    rCO3q7ki6ryqdeSw3YEQiXROYbHn9EwgIRont3bjMvztoPlT9FjATOzNc7Aw
X-ME-Proxy: <xmx:x-m8atNxuH_kRZtOg9v7lMWwzdxFLpSs4k-tnI7hSvPOoOY-OisWEw>
    <xmx:x-m8am2EsWqb8ta6YitqOgRJFnURGt1pGt4MTlVU55pMjG_9m4pzqg>
    <xmx:x-m8apPRnI-xuzgZDugePjsOaPpPxOsPxQewPtrBDNc5LSCJ5jhVhg>
    <xmx:x-m8am1XZiVFo3zk-XYj7ZPK5luysvXE9Klgm1Uz8OhGl1lqDpx6ug>
    <xmx:x-m8aoZ-TLKVnRVXKk2z8sbUBFcwKc-dZL5hVo0GANNPbMfFXhdsSO9Q>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 06:51:51 -0400 (EDT)
Message-ID: <0aca7b91f894803dcb2e436d98ecb2c404c610d3.camel@pbarker.dev>
Subject: Re: [PATCH v5] fetch/local: verify checksums for file:// urls
From: Paul Barker <paul@pbarker.dev>
To: Savvas Etairidis <setairidis@gmail.com>, 
	bitbake-devel@lists.openembedded.org, jhonata.poma@gmail.com
Date: Wed, 30 Sep 2026 11:51:49 +0100
In-Reply-To: <20260928205940.14169-1-setairidis@gmail.com>
References: <2b5b8d1a56b5db173667efa839208df83188a7ca.camel@pbarker.dev>
	 <20260928205940.14169-1-setairidis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Sep 2026 10:51:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20284

Hi Savvas,

Some review comments inline.

On Mon, 2026-09-28 at 22:59 +0200, Savvas Etairidis wrote:
> [YOCTO #9993]
>=20
> Local.urldata_init() always cleared needdonestamp, so a checksum given
> in a file:// url (e.g. UNINATIVE_CHECKSUM when UNINATIVE_URL points at
> a local file://) was never verified. Keep the donestamp when the url
> carries a checksum so verify_checksum runs, and make
> rename_bad_checksum() a FetchMethod method that Local overrides as a
> no-op, so a mismatch doesn't rename the user's source file.

This commit message is incredibly terse, and it has changed from v3
without any explanation as to why.

>=20
> Based on a patch by Jhonata Poma-Hansen.
>=20
> Signed-off-by: Savvas Etairidis <setairidis@gmail.com>
>=20
> ---
> changes in v5:
> - Rebased on top of master, added changelog entry
>=20
> changes in v4:
> - Rebased on top of master
>=20
> changes in v3:
> - Cherry-picked the patch from Jhonata Poma-Hansen
>=20
> ---
> ---
>  lib/bb/fetch/__init__.py | 36 ++++++++++++++++++------------------
>  lib/bb/fetch/local.py    | 18 ++++++++++++++++--
>  lib/bb/tests/fetch.py    | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+), 20 deletions(-)
>=20
> diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
> index 55ab710f3..a9f0add78 100644
> --- a/lib/bb/fetch/__init__.py
> +++ b/lib/bb/fetch/__init__.py
> @@ -742,7 +742,7 @@ def verify_donestamp(ud, d, origud=3DNone):
>          logger.warning("Checksum mismatch for local file %s\n"
>                         "Cleaning and trying again." % ud.localpath)
>          if os.path.exists(ud.localpath):
> -            rename_bad_checksum(ud, e.checksum)
> +            ud.method.rename_bad_checksum(ud, e.checksum)
>          bb.utils.remove(ud.donestamp)
>      return False
> =20
> @@ -775,7 +775,7 @@ def update_stamp(ud, d):
>              logger.warning("Checksum mismatch for local file %s\n"
>                             "Cleaning and trying again." % ud.localpath)
>              if os.path.exists(ud.localpath):
> -                rename_bad_checksum(ud, e.checksum)
> +                ud.method.rename_bad_checksum(ud, e.checksum)
>              bb.utils.remove(ud.donestamp)
>              raise
> =20
> @@ -1079,20 +1079,6 @@ def build_mirroruris(origud, mirrors, ld):
> =20
>      return uris, uds
> =20
> -def rename_bad_checksum(ud, suffix):
> -    """
> -    Renames files to have suffix from parameter
> -    """
> -
> -    if ud.localpath is None:
> -        return
> -
> -    new_localpath =3D "%s_bad-checksum_%s" % (ud.localpath, suffix)
> -    bb.warn("Renaming %s to %s" % (ud.localpath, new_localpath))
> -    if not bb.utils.movefile(ud.localpath, new_localpath):
> -        bb.warn("Renaming %s to %s failed, grep movefile in log.do_fetch=
 to see why" % (ud.localpath, new_localpath))
> -
> -
>  def try_mirror_url(fetch, origud, ud, ld, check =3D False):
>      # Return of None or a value means we're finished
>      # False means try another url
> @@ -1163,7 +1149,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D=
 False):
>              logger.warning("Mirror checksum failure for url %s (original=
 url: %s)\nCleaning and trying again." % (ud.url, origud.url))
>              logger.warning(str(e))
>              if os.path.exists(ud.localpath):
> -                rename_bad_checksum(ud, e.checksum)
> +                ud.method.rename_bad_checksum(ud, e.checksum)
>          elif isinstance(e, NoChecksumError):
>              raise
>          else:
> @@ -1479,6 +1465,20 @@ class FetchMethod(object):
>          """
>          return True
> =20
> +    def rename_bad_checksum(self, ud, suffix):
> +        """
> +        Rename ud.localpath with the given suffix on checksum mismatch.
> +        Local overrides this to a no-op since its localpath points at th=
e
> +        user's source tree.
> +        """

The docstring for a method explaining how another class overrides this
function is an AI-generated code smell. It makes no sense to document
this here.

> +        if ud.localpath is None:
> +            return
> +
> +        new_localpath =3D "%s_bad-checksum_%s" % (ud.localpath, suffix)
> +        bb.warn("Renaming %s to %s" % (ud.localpath, new_localpath))
> +        if not bb.utils.movefile(ud.localpath, new_localpath):
> +            bb.warn("Renaming %s to %s failed, grep movefile in log.do_f=
etch to see why" % (ud.localpath, new_localpath))
> +
>      def verify_donestamp(self, ud, d):
>          """
>          Verify the donestamp file
> @@ -1943,7 +1943,7 @@ class Fetch(object):
>                              logger.warning("Checksum failure encountered=
 with download of %s - will attempt other sources if available" % u)
>                              logger.debug(str(e))
>                              if os.path.exists(ud.localpath):
> -                                rename_bad_checksum(ud, e.checksum)
> +                                ud.method.rename_bad_checksum(ud, e.chec=
ksum)
>                          elif isinstance(e, NoChecksumError):
>                              raise
>                          else:
> diff --git a/lib/bb/fetch/local.py b/lib/bb/fetch/local.py
> index dfc5b564c..a92c0d267 100644
> --- a/lib/bb/fetch/local.py
> +++ b/lib/bb/fetch/local.py
> @@ -17,7 +17,7 @@ import os
>  import urllib.request, urllib.parse, urllib.error
>  import bb
>  import bb.utils
> -from   bb.fetch import FetchMethod, FetchError, ParameterError
> +from   bb.fetch import CHECKSUM_LIST, FetchMethod, FetchError, Parameter=
Error
>  from   bb.fetch import logger
> =20
>  class Local(FetchMethod):
> @@ -31,11 +31,25 @@ class Local(FetchMethod):
>          # We don't set localfile as for this fetcher the file is already=
 local!
>          ud.basename =3D os.path.basename(ud.path)
>          ud.basepath =3D ud.path
> -        ud.needdonestamp =3D False
> +        # Honor explicit checksum params (UNINATIVE_CHECKSUM, recipe
> +        # ;sha256sum=3D) by leaving needdonestamp at FetchData's default=
 so
> +        # verify_checksum runs.
> +        name =3D ud.parm.get("name")
> +        ud.needdonestamp =3D any(
> +            (name and "%s.%ssum" % (name, a) in ud.parm)
> +            or "%ssum" % a in ud.parm
> +            for a in CHECKSUM_LIST
> +        )

This expression is a bit confusing, can we instead check for the
presence of %s_name attributes set by configure_checksum() calls in
FetchData.__init__()?

The comment can also be simpler, perhaps something like "We need a done
stamp file only if a checksum is provided". We should also separate
things with a blank line if we need a comment before the
ud.needdonestamp assignment.

>          if "*" in ud.path:
>              raise bb.fetch.ParameterError("file:// urls using globbing a=
re no longer supported. Please place the files in a directory and reference=
 that instead.", ud.url)
>          return
> =20
> +    def rename_bad_checksum(self, ud, suffix):
> +        # file:// urls point at the user's source tree (recipe-shipped f=
iles
> +        # under FILESPATH or an absolute path the user passed in); skip =
the
> +        # rename so a ChecksumError surfaces without mutating their file=
s.
> +        return

Again the comment can be simpler, perhaps "Don't rename the user's
files".

> +
>      def localpath(self, urldata, d):
>          """
>          Return the local filename of a given url assuming a successful f=
etch.
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 71b0a63fe..60d356fc6 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -876,6 +876,36 @@ class FetcherLocalTest(FetcherTest):
>              with self.subTest(striplevel=3Drepr(value)):
>                  self.assertInvalidStriplevel(value)
> =20
> +    def test_local_checksum_match(self):
> +        # Correct sha256 must run verify_checksum to completion; donesta=
mp
> +        # lands in DL_DIR.

This comment is also an AI-generated code smell. Please ensure that
you're following our AI-assisted contribution policy [1]. If the
original patch from Jhonata was AI-generated then you need to document
this.

[1]: https://docs.yoctoproject.org/contributor-guide/submit-changes.html#ac=
ceptance-of-ai-generated-code

> +        import hashlib
> +        content =3D b"file:// checksum match test\n"
> +        with open(os.path.join(self.localsrcdir, 'sumfile'), 'wb') as f:
> +            f.write(content)
> +        good =3D hashlib.sha256(content).hexdigest()
> +        fetcher =3D bb.fetch.Fetch(['file://sumfile;sha256sum=3D' + good=
], self.d)
> +        ud =3D fetcher.ud[fetcher.urls[0]]
> +        self.assertTrue(ud.needdonestamp)
> +        fetcher.download()
> +        self.assertTrue(os.path.exists(ud.donestamp))

We shouldn't need either of the assertTrue() calls here. The checksum
mismatch case will catch failure to check the checksum, and
fetcher.download() will raise an error if it fails.

> +
> +    def test_local_checksum_mismatch(self):
> +        # Bad sha256 raises ChecksumError without renaming the user's
> +        # source file to the <localpath>_bad-checksum_<sha> sibling.
> +        content =3D b"file:// checksum mismatch test\n"
> +        srcpath =3D os.path.join(self.localsrcdir, 'sumfile')
> +        with open(srcpath, 'wb') as f:
> +            f.write(content)
> +        bad =3D "0" * 64
> +        fetcher =3D bb.fetch.Fetch(['file://sumfile;sha256sum=3D' + bad]=
, self.d)
> +        with self.assertRaises(bb.fetch.FetchError):
> +            fetcher.download()
> +        self.assertTrue(os.path.exists(srcpath))
> +        with open(srcpath, 'rb') as f:
> +            self.assertEqual(f.read(), content)

Why are we checking the content of the file? We're just looking for a renam=
e.

> +        self.assertFalse(os.path.exists(srcpath + '_bad-checksum_' + bad=
))
> +
>      def dummyGitTest(self, suffix):
>          # Create dummy local Git repo
>          src_dir =3D tempfile.mkdtemp(dir=3Dself.tempdir,

Best regards,

--=20
Paul Barker


