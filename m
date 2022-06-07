Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2012C43334
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 11:36:20 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web12.11401.1654601776089953527
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jun 2022 04:36:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eMbi9GD1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id p10so23747952wrg.12
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jun 2022 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=o0b7sIyqks/0KDtvHKZJVSnSTnPDtgvZANraXmSqZdQ=;
        b=eMbi9GD13He0XGkJiHiSfNfsY7PDEonm0C8f8SqeuE0Hp95TNt3jSRMlQr2tomwBQn
         f+S4n/50tYeoCCrC8b2oEN5E9RWO3pAWi2cU0GAxq0KP10rHGhMsLKFL69WWFhkcncu4
         7sCNkp9RxGLojXEQtLW7lRlMZrz4PJjaPmbn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=o0b7sIyqks/0KDtvHKZJVSnSTnPDtgvZANraXmSqZdQ=;
        b=NYyQYkP3Fjb/BD4M7RdxHelGUw4rz//bcoq9v2mlf4rpDYR3zuXZIzUg5TB1twJRXB
         8cNYEMRu8oVu10nSCT2CcU4tyFwdvx+smZ0sKDAjhU7SokRi5bwhPVZPqW2zhNAKXSbt
         BNv+I4jNlZX8qsAON9efZc5bWWeFIKtCqA7RDoJUsd3g9zhh7iRETvQxh9zsfyRxb6hc
         tCNcEgPNeT6nfDF/ybmlrqddg2pn14XIo83Oso4LXPDHk7oUVPDfMMcdee+FxMrtglDR
         CFeDn8+EG6AzwlQTBz6m6TABQWuD+zFHeErqj2R+uV9lzUjPV4rVHQZ6tpIuHlGpc6JP
         AOWw==
X-Gm-Message-State: AOAM531Vi8a32Dnal/HbyN10wJdR6e5dgTfB5p9WbF3Ky8ssInkhZHLv
	6grvu2O6WxBoBimJYA6KgZk1rg==
X-Google-Smtp-Source: 
 ABdhPJyf1VloRWk6JaGzMr23K8+JXHRgz4RGV7lGUVXx6Qjev3vuMug9Ml0IQla6VS/RSiMCpa/iHQ==
X-Received: by 2002:a05:6000:2cf:b0:212:27f4:5f80 with SMTP id
 o15-20020a05600002cf00b0021227f45f80mr26807819wry.545.1654601774400;
        Tue, 07 Jun 2022 04:36:14 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e835:fc94:6c5b:fc12?
 ([2001:8b0:aba:5f3c:e835:fc94:6c5b:fc12])
        by smtp.gmail.com with ESMTPSA id
 ay1-20020a5d6f01000000b0020fee88d0f2sm23277686wrb.0.2022.06.07.04.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 04:36:13 -0700 (PDT)
Message-ID: 
 <2c0eaba3e77b0313ad4d861076e52a2e51fe4656.camel@linuxfoundation.org>
Subject: Re: [PATCH v4] Honour BB_FETCH_PREMIRRORONLY option
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Pavel Zhukov <pavel@zhukoff.net>, bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel.zhukov@huawei.com>
Date: Tue, 07 Jun 2022 12:36:12 +0100
In-Reply-To: <20220525144243.19999-1-pavel@zhukoff.net>
References: 
	<f09538e33bbae7eca1ff6365492f165c2da32b0b.camel@linuxfoundation.org>
	 <20220525144243.19999-1-pavel@zhukoff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jun 2022 11:36:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13733

On Wed, 2022-05-25 at 16:42 +0200, Pavel Zhukov wrote:
> This should fix [Yocto 13353] and related to [Yocto 13233] as well.
> Previously if git repo mirror has been updated in between of two builds
> fetcher of the second build didn't try updated mirror but switched to
> git clone from upstream instead. This is problem for offline builds.
> Fix this to raise MirrorException if BB_FETCH_PREMIRRORONLY has been
> specified by the mirror doesn't contain SRC_REV.
>=20
> Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
> ---
>  lib/bb/fetch2/__init__.py |  2 ++
>  lib/bb/fetch2/git.py      | 16 ++++++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index ac557176..c99cd104 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1745,6 +1745,8 @@ class Fetch(object):
>                              done =3D False
> =20
>                  if premirroronly:
> +                    if not done:
> +                        raise FetchError("Failed to download premirror {=
} and BB_FETCH_PREMIRRORONLY has been set to 1.".format(self.d.getVar("PREM=
IRRORS")))
>                      self.d.setVar("BB_NO_NETWORK", "1")
> =20
>                  firsterr =3D None
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 23f8c0da..bf7c9d26 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -353,10 +353,18 @@ class Git(FetchMethod):
>          if ud.shallow and os.path.exists(ud.fullshallow) and self.need_u=
pdate(ud, d):
>              ud.localpath =3D ud.fullshallow
>              return
> -        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clo=
nedir):
> -            bb.utils.mkdirhier(ud.clonedir)
> -            runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3Dud.c=
lonedir)
> -
> +        elif os.path.exists(ud.fullmirror) and self.need_update(ud, d):
> +            if not os.path.exists(ud.clonedir):
> +                bb.utils.mkdirhier(ud.clonedir)
> +                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3D=
ud.clonedir)
> +            else:
> +                tmpdir =3D tempfile.mkdtemp(dir=3Dd.getVar('DL_DIR'))
> +                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3D=
tmpdir)
> +                fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s " % (u=
d.basecmd, shlex.quote(tmpdir))
> +                runfetchcmd(fetch_cmd, d, workdir=3Dud.clonedir)
> +            if self.try_premirror(ud, d) and self.need_update(ud, d):
> +                    raise bb.fetch2.FetchError("Premirror doesn't contai=
n revisions {} and "\
> +                            "upstream cannot be used due to BB_FETCH_PRE=
MIRRORONLY setting".format(ud.revisions))
>          repourl =3D self._get_repo_url(ud)
> =20
>          # If the repo still doesn't exist, fallback to cloning it


Sorry about the delay in reviewing this, I finally ran some tests I
wanted to run to check a couple of things. I think there are two
changes in here and they should really be separated out. The mirror
unpack and fetch piece in a temp directory is great and just what I
think is needed here.

The piece I worry a little more about is the raising of fetch errrors
if premirrors are configured. The code currently disables the network
but continues, this changes that behaviour to a hard stop.

I tested with the patch below applied and things still work as expected
so if you're ok with that, I'd like to merge this with these tweaks,
preserving the network disabled behaviour?

Cheers,

Richard

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py
index 9ef7fd037cc..616c67e99a0 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1745,8 +1745,6 @@ class Fetch(object):
                             done =3D False
=20
                 if premirroronly:
-                    if not done:
-                        raise FetchError("Failed to download premirror {} =
and BB_FETCH_PREMIRRORONLY has been set to 1.".format(self.d.getVar("PREMIR=
RORS")))
                     self.d.setVar("BB_NO_NETWORK", "1")
=20
                 firsterr =3D None
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index bf7c9d26b5c..07b3d9a7ffe 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -362,9 +362,6 @@ class Git(FetchMethod):
                 runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3Dtm=
pdir)
                 fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s " % (ud.=
basecmd, shlex.quote(tmpdir))
                 runfetchcmd(fetch_cmd, d, workdir=3Dud.clonedir)
-            if self.try_premirror(ud, d) and self.need_update(ud, d):
-                    raise bb.fetch2.FetchError("Premirror doesn't contain =
revisions {} and "\
-                            "upstream cannot be used due to BB_FETCH_PREMI=
RRORONLY setting".format(ud.revisions))
         repourl =3D self._get_repo_url(ud)
=20
         # If the repo still doesn't exist, fallback to cloning it
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 56f21f8e149..7ba866520ad 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2883,5 +2883,5 @@ class FetchPremirroronlyLocalTest(FetcherTest):
     def test_mirror_tarball_nonexistent(self):
         self.d.setVar("SRCREV", "0"*40)
         fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()






