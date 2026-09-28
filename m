Return-Path: <setairidis@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0551ECA5FA2
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 21:02:40 +0000 (UTC)
Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.68514.1790629350833399612
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Sep 2026 14:02:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=QDAHuj8G;
 spf=pass (domain: gmail.com, ip: 74.125.229.205, mailfrom: setairidis@gmail.com)
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8d47b5987so3180097e87.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 14:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790629349; cv=none;
        d=google.com; s=arc-20260327;
        b=b7UCyXIkwh4iCpVsCQyGZT5ysIY3Vk2O2mRUiA3QkLUDBtY1wV1RnzVCw+MqRZbIyB
         ekdzzCabI7mKPIYpWF3HPCvYdJ6qbqIe2Q75myzn27mkCixRv4BbBpe4jh8bfQbYOD4B
         dQ2CORKEGUKcpPtUDnouj+dZlg5aY/TlAtj1MOZiIC/D2DYu6s/d3G/4QbbCY6V9mgun
         A1JTA1fdjPX+dfAMM5V4BnlAHgMAck4y3qKqwjyTp/XeZ2gNShh1or0T2Kvxc8PWU5pq
         IKXxFkIIW3j5xvZriWPMbo8KumOkmO8DPdX4Av0iQMtTUFNWrwCLtORqtZHzQkw/3ABC
         cksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=O0KDe88Rpf8h+L3zqzy3uNCTuOUNtrxweReSPzwCBv8=;
        fh=xMmghtGxy1ZVs+Kfirz4rI+IRsJojXop3b7othHqLi4=;
        b=cSqqN6Hj5FJ3PiGzMZlwtYzKsYUkxeVoBv33mTBLgGq/LWySTRRNZDgt5sgKDk5uwY
         5QE9Ukm0KmccggdT/xJyuDtJGZ6sfF+rmuTXfFT9SZQcXgFGr7Hm/KxhKBE4a6LL1W+4
         u328rbG6rOrG22ieVDWWhdz9KdjIhFlP51CWGKgfshngd1SQuPYnauQ/J9j7z6FAFuBR
         YJiKZ0L3ytfNpbT7gRjwb3MGqOPQdBbN68oGmK7tImE9Ph6rFjT2r5nvKyrLj+vPt72h
         iyHlPy0KvVCeatgWyNHdowlmRROTyAYqyNY7WLrHibqftfTUsyMyRZ9K8GNGCNdT7Gbw
         OMUw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790629349; x=1791234149; darn=lists.openembedded.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O0KDe88Rpf8h+L3zqzy3uNCTuOUNtrxweReSPzwCBv8=;
        b=QDAHuj8G0D3dHyDMj97CM2JG9i+ZM5mijHqvHF7IyIoUe1dXRSzUmX4zzAEkcMXXZj
         EW3C9kNNW771qR7YkpyJh2bQdRjzMgTx4hVROTCvJr5xph0wbUNLvh2b6yPtGfVt4l0u
         6g+aI619nbw6VExL54Skj4fpI67wcBariAUiu34Fg7dSNimnCpnsGcuLpF4IJKDYMKu4
         0SsZhUag+XVuQ17L1C9t2W5Efh1M8yIkZBXqL61wwVB7lWsQm5J0mVQtbIDJY8jvzjtn
         Az6v3yUds3aBEJ9ypmVrwBF32TMa6cQFOi7ur4h/nLBdDVOLMRc63BEbXe1beTUhoyWX
         K4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629349; x=1791234149;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O0KDe88Rpf8h+L3zqzy3uNCTuOUNtrxweReSPzwCBv8=;
        b=PP54HU/Kj+ovoL/eq4+CitNylH0B3/mNz1DxnYf5QrTmNonhDJF/gfZG45dot9E267
         fmuX1mQ7a09/H31pLpMZD2BRGC6VPFWxsl0bpXA87lH7dxWOBvFawPKEZwk7pzJiv9gH
         I/L76xl/Ww1BOQimkfI7DJ10WMdiuIUJuqXG62/hqelVw3HaaDDZskQfoUX3wW17GnyY
         yQxGUvPTf1Q4S6/T4uyqMhxvNhIVAZI9tM+DkcnfVlZ7DbhuoY8LIWYwMPIQyGmy95DB
         2YUXBrRIuIesWmPJZ9vsoiulfpiCD4DfcGWqAMu6gpj89yXgEiVsEpTJCWuHlr1hnlQH
         YkuA==
X-Gm-Message-State: AFq9FYIx9ZNfTnRLkn7EFKYFovfnebZGNDieiEQJBVp4yZ1b4dYH4iqU
	lyz4R1nUuy2qG1+enUDlhFeGzYsC0jpylxtSeRC9GhMb9ku4htgEvr52R6pap2OQIEEeyiytaUy
	86Szog5GrztkuwDO5Kjl3AMKiAOAtSF5l1bEKEREEww==
X-Gm-Gg: AYBFou0HQDSvEoNwon09/QdkTMIg0Q+QhFFn69D36QbGiM8Myp4BmDlsF1Am1rpFD7I
	sIXMLxb5K+D0cSVoF0vSmfypTH9hMW25WvcoK52saw5TcPe9FitaeEiMNXbLdk3ZvLjQZFg9iw/
	0yRXIBjkLNtzynN4v+CRfNz5qwWmShB5g8j4iR/y8oZeUnZRlWw83DJNmwITQ2xDUCt2HFgMF5W
	Zynh7e+G2sKbSrVZBamI448vBgwdlkgAW+K7MzrEZoIPdyZ3sL7iQT/yELRO5CFAY6/ZplBAPD3
	xwueyHVhFcKbVSlCrWYj8T7pTthiRd/Zi95lLzSsKGtIa+Jf8Wo5MK11ec+gF2g2uilScXrc43w
	txxvosbeohReUvw==
X-Received: by 2002:a05:6512:3416:b0:5b8:f279:88a7 with SMTP id
 2adb3069b0e04-5b8f27989a4mr2616331e87.54.1790629348524; Mon, 28 Sep 2026
 14:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <2b5b8d1a56b5db173667efa839208df83188a7ca.camel@pbarker.dev> <20260928205940.14169-1-setairidis@gmail.com>
In-Reply-To: <20260928205940.14169-1-setairidis@gmail.com>
From: Sawas Etairidis <setairidis@gmail.com>
Date: Mon, 28 Sep 2026 23:02:19 +0200
X-Gm-Features: AclHuK-b4_pP1Li7BClPWDYP4xP8aAEinOyl5r7ENvPTAAQvGOuYn9cqcShtcXg
Message-ID: <CAKJXz6eaBv_9C9+4O0p=YN_NUJBBLsQo1Q1SN5uos41bcWt7qA@mail.gmail.com>
Subject: Re: [PATCH v5] fetch/local: verify checksums for file:// urls
To: bitbake-devel@lists.openembedded.org, jhonata.poma@gmail.com
Content-Type: multipart/alternative; boundary="0000000000003e4584065c9162bf"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 21:02:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20276

--0000000000003e4584065c9162bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

My bad I assumed that Jhonata stopped working on this based on the ticket
comments.
I send him a personal email about this.

Regards,
Savvas


=CE=A3=CF=84=CE=B9=CF=82 =CE=94=CE=B5=CF=85 28 =CE=A3=CE=B5=CF=80 2026 =CF=
=83=CF=84=CE=B9=CF=82 10:59=E2=80=AF=CE=BC.=CE=BC., =CE=BF/=CE=B7 Savvas Et=
airidis <
setairidis@gmail.com> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:

> [YOCTO #9993]
>
> Local.urldata_init() always cleared needdonestamp, so a checksum given
> in a file:// url (e.g. UNINATIVE_CHECKSUM when UNINATIVE_URL points at
> a local file://) was never verified. Keep the donestamp when the url
> carries a checksum so verify_checksum runs, and make
> rename_bad_checksum() a FetchMethod method that Local overrides as a
> no-op, so a mismatch doesn't rename the user's source file.
>
> Based on a patch by Jhonata Poma-Hansen.
>
> Signed-off-by: Savvas Etairidis <setairidis@gmail.com>
>
> ---
> changes in v5:
> - Rebased on top of master, added changelog entry
>
> changes in v4:
> - Rebased on top of master
>
> changes in v3:
> - Cherry-picked the patch from Jhonata Poma-Hansen
>
> ---
> ---
>  lib/bb/fetch/__init__.py | 36 ++++++++++++++++++------------------
>  lib/bb/fetch/local.py    | 18 ++++++++++++++++--
>  lib/bb/tests/fetch.py    | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+), 20 deletions(-)
>
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
>
> @@ -775,7 +775,7 @@ def update_stamp(ud, d):
>              logger.warning("Checksum mismatch for local file %s\n"
>                             "Cleaning and trying again." % ud.localpath)
>              if os.path.exists(ud.localpath):
> -                rename_bad_checksum(ud, e.checksum)
> +                ud.method.rename_bad_checksum(ud, e.checksum)
>              bb.utils.remove(ud.donestamp)
>              raise
>
> @@ -1079,20 +1079,6 @@ def build_mirroruris(origud, mirrors, ld):
>
>      return uris, uds
>
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
> -        bb.warn("Renaming %s to %s failed, grep movefile in log.do_fetch
> to see why" % (ud.localpath, new_localpath))
> -
> -
>  def try_mirror_url(fetch, origud, ud, ld, check =3D False):
>      # Return of None or a value means we're finished
>      # False means try another url
> @@ -1163,7 +1149,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D
> False):
>              logger.warning("Mirror checksum failure for url %s (original
> url: %s)\nCleaning and trying again." % (ud.url, origud.url))
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
>
> +    def rename_bad_checksum(self, ud, suffix):
> +        """
> +        Rename ud.localpath with the given suffix on checksum mismatch.
> +        Local overrides this to a no-op since its localpath points at th=
e
> +        user's source tree.
> +        """
> +        if ud.localpath is None:
> +            return
> +
> +        new_localpath =3D "%s_bad-checksum_%s" % (ud.localpath, suffix)
> +        bb.warn("Renaming %s to %s" % (ud.localpath, new_localpath))
> +        if not bb.utils.movefile(ud.localpath, new_localpath):
> +            bb.warn("Renaming %s to %s failed, grep movefile in
> log.do_fetch to see why" % (ud.localpath, new_localpath))
> +
>      def verify_donestamp(self, ud, d):
>          """
>          Verify the donestamp file
> @@ -1943,7 +1943,7 @@ class Fetch(object):
>                              logger.warning("Checksum failure encountered
> with download of %s - will attempt other sources if available" % u)
>                              logger.debug(str(e))
>                              if os.path.exists(ud.localpath):
> -                                rename_bad_checksum(ud, e.checksum)
> +                                ud.method.rename_bad_checksum(ud,
> e.checksum)
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
> +from   bb.fetch import CHECKSUM_LIST, FetchMethod, FetchError,
> ParameterError
>  from   bb.fetch import logger
>
>  class Local(FetchMethod):
> @@ -31,11 +31,25 @@ class Local(FetchMethod):
>          # We don't set localfile as for this fetcher the file is already
> local!
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
>          if "*" in ud.path:
>              raise bb.fetch.ParameterError("file:// urls using globbing
> are no longer supported. Please place the files in a directory and
> reference that instead.", ud.url)
>          return
>
> +    def rename_bad_checksum(self, ud, suffix):
> +        # file:// urls point at the user's source tree (recipe-shipped
> files
> +        # under FILESPATH or an absolute path the user passed in); skip
> the
> +        # rename so a ChecksumError surfaces without mutating their file=
s.
> +        return
> +
>      def localpath(self, urldata, d):
>          """
>          Return the local filename of a given url assuming a successful
> fetch.
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 71b0a63fe..60d356fc6 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -876,6 +876,36 @@ class FetcherLocalTest(FetcherTest):
>              with self.subTest(striplevel=3Drepr(value)):
>                  self.assertInvalidStriplevel(value)
>
> +    def test_local_checksum_match(self):
> +        # Correct sha256 must run verify_checksum to completion; donesta=
mp
> +        # lands in DL_DIR.
> +        import hashlib
> +        content =3D b"file:// checksum match test\n"
> +        with open(os.path.join(self.localsrcdir, 'sumfile'), 'wb') as f:
> +            f.write(content)
> +        good =3D hashlib.sha256(content).hexdigest()
> +        fetcher =3D bb.fetch.Fetch(['file://sumfile;sha256sum=3D' + good=
],
> self.d)
> +        ud =3D fetcher.ud[fetcher.urls[0]]
> +        self.assertTrue(ud.needdonestamp)
> +        fetcher.download()
> +        self.assertTrue(os.path.exists(ud.donestamp))
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
,
> self.d)
> +        with self.assertRaises(bb.fetch.FetchError):
> +            fetcher.download()
> +        self.assertTrue(os.path.exists(srcpath))
> +        with open(srcpath, 'rb') as f:
> +            self.assertEqual(f.read(), content)
> +        self.assertFalse(os.path.exists(srcpath + '_bad-checksum_' + bad=
))
> +
>      def dummyGitTest(self, suffix):
>          # Create dummy local Git repo
>          src_dir =3D tempfile.mkdtemp(dir=3Dself.tempdir,
> --
> 2.34.1
>
>

--0000000000003e4584065c9162bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>My bad I assumed that=C2=A0<span st=
yle=3D"background-color:transparent">Jhonata</span><span style=3D"backgroun=
d-color:transparent">=C2=A0stopped working on this based on the ticket comm=
ents.</span></div><div><span style=3D"background-color:transparent">I send =
him a personal email about this.</span></div><div><span style=3D"background=
-color:transparent"><br></span></div><div><span style=3D"background-color:t=
ransparent">Regards,</span></div><div><span style=3D"background-color:trans=
parent">Savvas</span></div><div><span style=3D"background-color:transparent=
"><br></span></div></div><br><div class=3D"gmail_quote gmail_quote_containe=
r"><div dir=3D"ltr" class=3D"gmail_attr">=CE=A3=CF=84=CE=B9=CF=82 =CE=94=CE=
=B5=CF=85 28 =CE=A3=CE=B5=CF=80 2026 =CF=83=CF=84=CE=B9=CF=82 10:59=E2=80=
=AF=CE=BC.=CE=BC., =CE=BF/=CE=B7 Savvas Etairidis &lt;<a href=3D"mailto:set=
airidis@gmail.com">setairidis@gmail.com</a>&gt; =CE=AD=CE=B3=CF=81=CE=B1=CF=
=88=CE=B5:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">[YOCT=
O #9993]<br>
<br>
Local.urldata_init() always cleared needdonestamp, so a checksum given<br>
in a file:// url (e.g. UNINATIVE_CHECKSUM when UNINATIVE_URL points at<br>
a local file://) was never verified. Keep the donestamp when the url<br>
carries a checksum so verify_checksum runs, and make<br>
rename_bad_checksum() a FetchMethod method that Local overrides as a<br>
no-op, so a mismatch doesn&#39;t rename the user&#39;s source file.<br>
<br>
Based on a patch by Jhonata Poma-Hansen.<br>
<br>
Signed-off-by: Savvas Etairidis &lt;<a href=3D"mailto:setairidis@gmail.com"=
 target=3D"_blank">setairidis@gmail.com</a>&gt;<br>
<br>
---<br>
changes in v5:<br>
- Rebased on top of master, added changelog entry<br>
<br>
changes in v4:<br>
- Rebased on top of master<br>
<br>
changes in v3:<br>
- Cherry-picked the patch from Jhonata Poma-Hansen<br>
<br>
---<br>
---<br>
=C2=A0lib/bb/fetch/__init__.py | 36 ++++++++++++++++++------------------<br=
>
=C2=A0lib/bb/fetch/local.py=C2=A0 =C2=A0 | 18 ++++++++++++++++--<br>
=C2=A0lib/bb/tests/fetch.py=C2=A0 =C2=A0 | 30 +++++++++++++++++++++++++++++=
+<br>
=C2=A03 files changed, 64 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py<br>
index 55ab710f3..a9f0add78 100644<br>
--- a/lib/bb/fetch/__init__.py<br>
+++ b/lib/bb/fetch/__init__.py<br>
@@ -742,7 +742,7 @@ def verify_donestamp(ud, d, origud=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warning(&quot;Checksum mismatch fo=
r local file %s\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;Cleaning and trying again.&quot; % ud.localpath)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(ud.localpath):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rename_bad_checksum(ud, e.checks=
um)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.method.rename_bad_checksum(ud=
, e.checksum)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.remove(ud.donestamp)<br>
=C2=A0 =C2=A0 =C2=A0return False<br>
<br>
@@ -775,7 +775,7 @@ def update_stamp(ud, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warning(&quot;Checks=
um mismatch for local file %s\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Cleaning and trying again.&quot; % ud.localp=
ath)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(ud.localp=
ath):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rename_bad_checksu=
m(ud, e.checksum)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.method.rename_b=
ad_checksum(ud, e.checksum)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.remove(ud.donestam=
p)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
<br>
@@ -1079,20 +1079,6 @@ def build_mirroruris(origud, mirrors, ld):<br>
<br>
=C2=A0 =C2=A0 =C2=A0return uris, uds<br>
<br>
-def rename_bad_checksum(ud, suffix):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 Renames files to have suffix from parameter<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 if ud.localpath is None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
-<br>
-=C2=A0 =C2=A0 new_localpath =3D &quot;%s_bad-checksum_%s&quot; % (ud.local=
path, suffix)<br>
-=C2=A0 =C2=A0 bb.warn(&quot;Renaming %s to %s&quot; % (ud.localpath, new_l=
ocalpath))<br>
-=C2=A0 =C2=A0 if not bb.utils.movefile(ud.localpath, new_localpath):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Renaming %s to %s failed, grep m=
ovefile in log.do_fetch to see why&quot; % (ud.localpath, new_localpath))<b=
r>
-<br>
-<br>
=C2=A0def try_mirror_url(fetch, origud, ud, ld, check =3D False):<br>
=C2=A0 =C2=A0 =C2=A0# Return of None or a value means we&#39;re finished<br=
>
=C2=A0 =C2=A0 =C2=A0# False means try another url<br>
@@ -1163,7 +1149,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D F=
alse):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warning(&quot;Mirror=
 checksum failure for url %s (original url: %s)\nCleaning and trying again.=
&quot; % (ud.url, origud.url))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warning(str(e))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(ud.localp=
ath):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rename_bad_checksu=
m(ud, e.checksum)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.method.rename_b=
ad_checksum(ud, e.checksum)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif isinstance(e, NoChecksumError):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
@@ -1479,6 +1465,20 @@ class FetchMethod(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
<br>
+=C2=A0 =C2=A0 def rename_bad_checksum(self, ud, suffix):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Rename ud.localpath with the given suffix on c=
hecksum mismatch.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Local overrides this to a no-op since its loca=
lpath points at the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 user&#39;s source tree.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.localpath is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_localpath =3D &quot;%s_bad-checksum_%s&quo=
t; % (ud.localpath, suffix)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Renaming %s to %s&quot; % (ud.lo=
calpath, new_localpath))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not bb.utils.movefile(ud.localpath, new_loc=
alpath):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Renaming %s to %s =
failed, grep movefile in log.do_fetch to see why&quot; % (ud.localpath, new=
_localpath))<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def verify_donestamp(self, ud, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Verify the donestamp file<br>
@@ -1943,7 +1943,7 @@ class Fetch(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warning(&quot;Checksum failure encoun=
tered with download of %s - will attempt other sources if available&quot; %=
 u)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug(str(e))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(ud.localpath):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rename_bad_checksum(ud, e.checksum)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.method.rename_bad_checksum(ud, e.=
checksum)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0elif isinstance(e, NoChecksumError):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0else:<br>
diff --git a/lib/bb/fetch/local.py b/lib/bb/fetch/local.py<br>
index dfc5b564c..a92c0d267 100644<br>
--- a/lib/bb/fetch/local.py<br>
+++ b/lib/bb/fetch/local.py<br>
@@ -17,7 +17,7 @@ import os<br>
=C2=A0import urllib.request, urllib.parse, urllib.error<br>
=C2=A0import bb<br>
=C2=A0import bb.utils<br>
-from=C2=A0 =C2=A0bb.fetch import FetchMethod, FetchError, ParameterError<b=
r>
+from=C2=A0 =C2=A0bb.fetch import CHECKSUM_LIST, FetchMethod, FetchError, P=
arameterError<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch import logger<br>
<br>
=C2=A0class Local(FetchMethod):<br>
@@ -31,11 +31,25 @@ class Local(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# We don&#39;t set localfile as for this =
fetcher the file is already local!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.basename =3D os.path.basename(ud.path)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.basepath =3D ud.path<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.needdonestamp =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Honor explicit checksum params (UNINATIVE_CH=
ECKSUM, recipe<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # ;sha256sum=3D) by leaving needdonestamp at F=
etchData&#39;s default so<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # verify_checksum runs.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D ud.parm.get(&quot;name&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.needdonestamp =3D any(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (name and &quot;%s.%ssum&quot; %=
 (name, a) in ud.parm)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or &quot;%ssum&quot; % a in ud.p=
arm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for a in CHECKSUM_LIST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;*&quot; in ud.path:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise bb.fetch.ParameterErr=
or(&quot;file:// urls using globbing are no longer supported. Please place =
the files in a directory and reference that instead.&quot;, ud.url)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
<br>
+=C2=A0 =C2=A0 def rename_bad_checksum(self, ud, suffix):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # file:// urls point at the user&#39;s source =
tree (recipe-shipped files<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # under FILESPATH or an absolute path the user=
 passed in); skip the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # rename so a ChecksumError surfaces without m=
utating their files.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def localpath(self, urldata, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Return the local filename of a given url =
assuming a successful fetch.<br>
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py<br>
index 71b0a63fe..60d356fc6 100644<br>
--- a/lib/bb/tests/fetch.py<br>
+++ b/lib/bb/tests/fetch.py<br>
@@ -876,6 +876,36 @@ class FetcherLocalTest(FetcherTest):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with self.subTest(stripleve=
l=3Drepr(value)):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertIn=
validStriplevel(value)<br>
<br>
+=C2=A0 =C2=A0 def test_local_checksum_match(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Correct sha256 must run verify_checksum to c=
ompletion; donestamp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # lands in DL_DIR.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 import hashlib<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 content =3D b&quot;file:// checksum match test=
\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(os.path.join(self.localsrcdir, &#39;=
sumfile&#39;), &#39;wb&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(content)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 good =3D hashlib.sha256(content).hexdigest()<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher =3D bb.fetch.Fetch([&#39;file://sumfil=
e;sha256sum=3D&#39; + good], self.d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud =3D fetcher.ud[fetcher.urls[0]]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(ud.needdonestamp)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.download()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(os.path.exists(ud.donestamp))<=
br>
+<br>
+=C2=A0 =C2=A0 def test_local_checksum_mismatch(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Bad sha256 raises ChecksumError without rena=
ming the user&#39;s<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # source file to the &lt;localpath&gt;_bad-che=
cksum_&lt;sha&gt; sibling.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 content =3D b&quot;file:// checksum mismatch t=
est\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 srcpath =3D os.path.join(self.localsrcdir, &#3=
9;sumfile&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(srcpath, &#39;wb&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(content)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bad =3D &quot;0&quot; * 64<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher =3D bb.fetch.Fetch([&#39;file://sumfil=
e;sha256sum=3D&#39; + bad], self.d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with self.assertRaises(bb.fetch.FetchError):<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.download()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(os.path.exists(srcpath))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(srcpath, &#39;rb&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(f.read(), conte=
nt)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertFalse(os.path.exists(srcpath + &#39=
;_bad-checksum_&#39; + bad))<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def dummyGitTest(self, suffix):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Create dummy local Git repo<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src_dir =3D tempfile.mkdtemp(dir=3Dself.t=
empdir,<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--0000000000003e4584065c9162bf--

