Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3B9CAC5A7
	for <webhook@archiver.kernel.org>; Sat, 20 Sep 2025 15:08:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.11504.1758380898879422427
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 20 Sep 2025 08:08:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 337AD1688
	for <bitbake-devel@lists.openembedded.org>; Sat, 20 Sep 2025 08:08:10 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 03F503F694
	for <bitbake-devel@lists.openembedded.org>; Sat, 20 Sep 2025 08:08:17 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: ensure lockfiles are unlocked on exception
Date: Sat, 20 Sep 2025 16:08:13 +0100
Message-ID: <20250920150813.753989-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 20 Sep 2025 15:08:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18064

Ensure that every time a lockfile is created, it is also unlocked in a
finally: block. Otherwise, the lock file remains open and Python warns:

ResourceWarning: unclosed file <_io.FileIO
name=3D'/tmp/bitbake-fetch-srfv29ek/download/git2/git.openembedded.org.bi=
tbake.lock'
mode=3D'ab+' closefd=3DTrue>

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 60 ++++++++++++++++---------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__=
init__.py
index 0ad987c596c..bdd4973945a 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1067,10 +1067,10 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D=
 False):
     # Return of None or a value means we're finished
     # False means try another url
=20
-    if ud.lockfile and ud.lockfile !=3D origud.lockfile:
-        lf =3D bb.utils.lockfile(ud.lockfile)
-
     try:
+        if ud.lockfile and ud.lockfile !=3D origud.lockfile:
+            lf =3D bb.utils.lockfile(ud.lockfile)
+
         if check:
             found =3D ud.method.checkstatus(fetch, ud, ld)
             if found:
@@ -1864,10 +1864,10 @@ class Fetch(object):
             m =3D ud.method
             done =3D False
=20
-            if ud.lockfile:
-                lf =3D bb.utils.lockfile(ud.lockfile)
-
             try:
+                if ud.lockfile:
+                    lf =3D bb.utils.lockfile(ud.lockfile)
+
                 self.d.setVar("BB_NO_NETWORK", network)
                 if m.verify_donestamp(ud, self.d) and not m.need_update(=
ud, self.d):
                     done =3D True
@@ -2000,18 +2000,20 @@ class Fetch(object):
         unpack_tracer.start(root, self.ud, self.d)
=20
         for u in urls:
-            ud =3D self.ud[u]
-            ud.setup_localpath(self.d)
+            try:
+                ud =3D self.ud[u]
+                ud.setup_localpath(self.d)
=20
-            if ud.lockfile:
-                lf =3D bb.utils.lockfile(ud.lockfile)
+                if ud.lockfile:
+                    lf =3D bb.utils.lockfile(ud.lockfile)
=20
-            unpack_tracer.start_url(u)
-            ud.method.unpack(ud, root, self.d)
-            unpack_tracer.finish_url(u)
+                unpack_tracer.start_url(u)
+                ud.method.unpack(ud, root, self.d)
+                unpack_tracer.finish_url(u)
=20
-            if ud.lockfile:
-                bb.utils.unlockfile(lf)
+            finally:
+                if ud.lockfile:
+                    bb.utils.unlockfile(lf)
=20
         unpack_tracer.complete()
=20
@@ -2024,23 +2026,25 @@ class Fetch(object):
             urls =3D self.urls
=20
         for url in urls:
-            if url not in self.ud:
-                self.ud[url] =3D FetchData(url, self.d)
-            ud =3D self.ud[url]
-            ud.setup_localpath(self.d)
+            try:
+                if url not in self.ud:
+                    self.ud[url] =3D FetchData(url, self.d)
+                ud =3D self.ud[url]
+                ud.setup_localpath(self.d)
=20
-            if not ud.localfile and ud.localpath is None:
-                continue
+                if not ud.localfile and ud.localpath is None:
+                    continue
=20
-            if ud.lockfile:
-                lf =3D bb.utils.lockfile(ud.lockfile)
+                if ud.lockfile:
+                    lf =3D bb.utils.lockfile(ud.lockfile)
=20
-            ud.method.clean(ud, self.d)
-            if ud.donestamp:
-                bb.utils.remove(ud.donestamp)
+                ud.method.clean(ud, self.d)
+                if ud.donestamp:
+                    bb.utils.remove(ud.donestamp)
=20
-            if ud.lockfile:
-                bb.utils.unlockfile(lf)
+            finally:
+                if ud.lockfile:
+                    bb.utils.unlockfile(lf)
=20
     def expanded_urldata(self, urls=3DNone):
         """
--=20
2.43.0


