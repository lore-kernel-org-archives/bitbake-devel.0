Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DD1C88E72
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 13:48:13 +0000 (UTC)
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40124.1789652886378736002
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2026 06:48:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aEANmHO4;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.99, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4858bc96fabso686998f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1789652884; x=1790257684; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QYy50OvmHqc2hMxV9ZUzSxzAirYLnvVFpdvqI7jwc6A=;
        b=aEANmHO4NDYordWWcXCoZiH0bKg0WDN/GDTpQMoyEj955nrD4AbyBcHLr0d1kYOzzp
         Cr+5O8am/o6NpYGEztkRQygFw6yykEEC6LJRYdIqpHJIsQvKHG5J1UODpvRDmdFEPEWY
         oervuCK9PHWExVmVYpwiK86SKzJ2CI/cnRybc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789652884; x=1790257684;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYy50OvmHqc2hMxV9ZUzSxzAirYLnvVFpdvqI7jwc6A=;
        b=bPdCfvEb65U5dbARcjEb2EwwQsSz/+5u6hI7Ylkg+nRKSYy06ENCP+Nu8OYWj1hVvA
         O71ZuA07VkDhQ/gQkFxTktiCCCfYMEdUB+cy6EDu7W98GvMQs0tHEKQtiUd9i1RruqDB
         sCfsEir/BH+kBgt3qSOI67kLfpbunId+g8dTQO9RADlQi1xkNDkT1ljQl+lhEA03LC4B
         5/WNA9rOS7SCCbolK/jM5b0VmsVIGt1162G95G6NHTrcBgWvcdY/YQjg/mYOLjU1cfUl
         fxRwUX0gno5fyWPer7n62HFFTpq2EQ6JfGOK5+E0m7pI5wFUiXHnmRz7wTDR1h4Wsn0j
         i1Sw==
X-Forwarded-Encrypted: i=1; AKwUvBxd7i5trOM+Jji4RdjJ9KpHFsPr9ohI3fa4tai7x/UXuWp4Mm3AsyMA6IEicXCmQI7HRhNysVGefgByEv25@lists.openembedded.org
X-Gm-Message-State: AFuF++kHwnjEe8St7CHK4hVA6O1lGPjXQEAdExrf9JtVzw0I9CJHykfP
	uKNWlTLHsO0tip+A1+/0Qe54/SS7z3jGi5yzPk77Wraf1pvQEy9hic9XRaaFLTBZAuw=
X-Gm-Gg: AYBFou19FjIOZVhKiU6Dt8wcxQyazFkwrCxUcO4uIqOushEcFsgSC70bhsRIMa2J2ll
	pVblBoYQ+dmdmxOU1eyze6SvmpBo+No8/A6wXGPCb80J+STDKSfg5a3a/QP79qf2sAX0x5rZoY8
	bsD8ruM4YwWGxHixr+ezslpLP2GJPh+sbHRSVEObMLzrsPnjcFYuDH9cJosCX//I8W7AIQfgm74
	CufCnEBvYCKza1ZZ7vin5SweelREMmSGyhvsz6ioZyyC6JbV14sFO9QW/D67RHwBxVAD2qopLdL
	7ujXiQt+vO7gPZE5+H+slAWl8ANsoH4Fn4SCUT0s/NxoZW1PSK/xDIYEh9qidz63Lb42w80ZL7n
	i9MTk1nEUFOUdJvkfGI3PCDApnQrSk7Q/G9dwes2UzdyxrOF3Y5z+KYkmSqzlUk4zadLK1AG9Ej
	gVSyR5emH3uFqx5LoAyRTOEqSk2jtdOCwOtvqCl5MxeH4qX8Gw2bI8dVSIasFdnf0oWv5ftrs6E
	Qv3Ma8ZY9BHGdT1gG+LoT2XBUb1YxfKaQkomUmucpElTm2436DsXwBhexj4AYo8
X-Received: by 2002:a05:6000:40de:b0:485:8a46:7057 with SMTP id ffacd0b85a97d-4870d048028mr8503355f8f.41.1789652884460;
        Thu, 17 Sep 2026 06:48:04 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4507:59aa:c79a:ecab? ([2001:8b0:aba:5f3c:4507:59aa:c79a:ecab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7678sm16440393f8f.2.2026.09.17.06.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:48:02 -0700 (PDT)
Message-ID: <df5f2f7e6a2de4cc9fc819696b87f17ec62b6f69.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] fetch/git: unpack from premirror
 when cached clone is stale
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Sep 2026 14:48:01 +0100
In-Reply-To: <18D61ACAADC01AEF.668921@lists.openembedded.org>
References: 
	<DM6PR11MB39620862AF1ED3401C93F429CBBB2@DM6PR11MB3962.namprd11.prod.outlook.com>
	 <18D61ACAADC01AEF.668921@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 13:48:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20219

On Thu, 2026-09-17 at 13:15 +0100, Richard Purdie via lists.openembedded.or=
g wrote:
> On Mon, 2026-09-14 at 11:00 +0000, Fredrik Svensson (svsvenss) wrote:
> > The failure happens as follows:
> >=20
> > 1. BitBake has an old Git clone for the original URL.
> > 2. That clone does not contain the commit being built.
> > 3. BitBake successfully fetches the commit from a premirror into anothe=
r clone.
> > 4. BitBake tries to unpack from the old clone and fails.
> >=20
> > Remember the clone used by the successful premirror fetch and unpack fr=
om it.
> > Leave both clones unchanged and preserve the premirror clone during cle=
an.
> >=20
> > Add a test for this case.
> >=20
> > Signed-off-by: Fredrik Svensson <fredriks@meraki.com>
> > ---
> > Thanks for the feedback.
> >=20
> > This version leaves the stale clone untouched. It remembers the clone u=
sed by
> > the successful premirror fetch and uses that clone for unpacking.
> >=20
> > It also removes update_mirror_links. A symlink is still created when th=
e
> > original clone path is absent, but clean no longer follows that symlink=
, so it
> > does not remove the premirror clone.
> >=20
> > The updated self-test verifies that unpack uses the premirror revision,=
 the old
> > clone is unchanged, and clean preserves the premirror clone.
> >=20
> > Changes in v3:
> > - do not delete or replace the stale clone;
> > - use origud to remember the successful premirror path;
> > - remove update_mirror_links;
> > - preserve the premirror clone during clean; and
> > - update the self-test for the new behavior.
> >=20
> > lib/bb/fetch/__init__.py | 48 +++++++++++++-------------------
> > =C2=A0lib/bb/fetch/git.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 60 ++++++++++=
+++++++++---------------------
> > =C2=A0lib/bb/tests/fetch.py=C2=A0=C2=A0=C2=A0 | 49 ++++++++++++++++++++=
++++++++++++
> > =C2=A03 files changed, 97 insertions(+), 60 deletions(-)
>=20
> Thanks, I spent quite a bit of time looking at this and I'm not
> convinced the code will work well. You're adjusting localpath to
> mirrorpath deep in try_mirror_url and there is no guarantee that the
> codepath will always run and adjust ud.localpath before it gets
> referenced. Yes, the test case works but the code is full of
> assumptions about what localpath means and we can't just change the
> behaviour like this. I therefore cannot merge this.
>=20
> I did caveat that you were pressuring me for review and I did my best
> but didn't dive into details. I'm not entirely convinced I've given you
> good advice on the route to take :(.
>=20
> Perhaps the best approach may be to take the original v2 patch approach
> but error if the directory overlap occurs rather than delete anything?
> At least that way the user can get a clear error message about the
> issue.
>=20
> The better option would be to update the out of date clone from the
> premirror but I'm not quite sure which part of the codepaths would need
> tweaking for that or how invasive it would be.

The patch below is perhaps more what I was thinking. The difference is
that it only changes the internal mirror urldata entry and causes the
code to update the original clone directory. It uses your own testcase,
with the link check removed as there isn't one but that doesn't matter.

Cheers,

Richard

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index 55ab710f3..60045b04b 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -1054,12 +1054,12 @@ def build_mirroruris(origud, mirrors, ld):
                 localmirrors.remove(line)
=20
                 try:
-                    newud =3D FetchData(newuri, ld)
+                    newud =3D FetchData(newuri, ld, origud=3Dorigud)
                     newud.ignore_checksums =3D True
                     newud.setup_localpath(ld)
                     if hasattr(ud, 'unpack_tracer'):
                         newud.unpack_tracer =3D ud.unpack_tracer
-                    newud.origud =3D ud
+
                 except bb.fetch.BBFetchException as e:
                     logger.debug("Mirror fetch failure for url %s (origina=
l url: %s)" % (newuri, origud.url))
                     logger.debug(str(e))
@@ -1321,7 +1321,7 @@ class FetchData(object):
     """
     A class which represents the fetcher state for a given URI.
     """
-    def __init__(self, url, d, localonly =3D False):
+    def __init__(self, url, d, localonly=3DFalse, origud=3DNone):
         # localpath is the location of a downloaded result. If not set, th=
e file is local.
         self.donestamp =3D None
         self.needdonestamp =3D True
@@ -1373,6 +1373,9 @@ class FetchData(object):
         if not self.method:
             raise NoMethodError(url)
=20
+        if origud:
+            self.origud =3D origud
+
         if localonly and not isinstance(self.method, local.Local):
             raise NonLocalMethod()
=20
diff --git a/lib/bb/fetch/git.py b/lib/bb/fetch/git.py
index dc1b31b58..fa43e1d5d 100644
--- a/lib/bb/fetch/git.py
+++ b/lib/bb/fetch/git.py
@@ -277,6 +277,8 @@ class Git(FetchMethod):
         dl_dir =3D d.getVar("DL_DIR")
         gitdir =3D d.getVar("GITDIR") or (dl_dir + "/git2")
         ud.clonedir =3D os.path.join(gitdir, gitsrcname)
+        if hasattr(ud, "origud") and ud.origud.type =3D=3D "git":
+            ud.clonedir =3D ud.origud.clonedir
         ud.localfile =3D ud.clonedir
=20
         mirrortarball =3D 'git2_%s.tar.gz' % gitsrcname
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 773876453..d69ad6bbd 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -616,6 +616,48 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
         self.assertIn(self.recipe_dir, dir)
=20
=20
+class GitPremirrorStaleCloneTest(FetcherTest):
+
+    def test_premirror_replaces_stale_clone(self):
+        source =3D os.path.join(self.tempdir, "source")
+        os.mkdir(source)
+        self.git_init(cwd=3Dsource)
+
+        testfile =3D os.path.join(source, "testfile")
+        with open(testfile, "w") as f:
+            f.write("first\n")
+        self.git(["add", "testfile"], cwd=3Dsource)
+        self.git(["commit", "-m", "first commit"], cwd=3Dsource)
+
+        recipe_url =3D "git://upstream.invalid/project.git;branch=3Dmaster=
;protocol=3Dhttps"
+        self.d.setVar("SRCREV", self.git(["rev-parse", "HEAD"], cwd=3Dsour=
ce).strip())
+        fetcher =3D bb.fetch.Fetch([recipe_url], self.d)
+        ud =3D fetcher.ud[recipe_url]
+        ud.setup_localpath(self.d)
+        os.makedirs(os.path.dirname(ud.clonedir), exist_ok=3DTrue)
+        self.git(["clone", "--bare", "--mirror", source, ud.clonedir], cwd=
=3Dself.tempdir)
+
+        with open(testfile, "a") as f:
+            f.write("second\n")
+        self.git(["commit", "-am", "second commit"], cwd=3Dsource)
+        revision =3D self.git(["rev-parse", "HEAD"], cwd=3Dsource).strip()
+
+        self.d.setVar("SRCREV", revision)
+        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
+        self.d.setVar("BB_NO_NETWORK", "1")
+        self.d.setVar("PREMIRRORS", "%s git://%s;protocol=3Dfile" % (recip=
e_url, source))
+
+        fetcher =3D bb.fetch.Fetch([recipe_url], self.d)
+        ud =3D fetcher.ud[recipe_url]
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        self.assertTrue(os.path.islink(ud.clonedir))
+        unpack_revision =3D self.git(["rev-parse", "HEAD"],
+                                   cwd=3Dos.path.join(self.unpackdir, "git=
")).strip()
+        self.assertEqual(revision, unpack_revision)
+
+
 class TarballNamingTest(FetcherTest):
     def setUp(self):
         super(TarballNamingTest, self).setUp()

