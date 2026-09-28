Return-Path: <setairidis@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D9BCA5FA3
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 20:59:50 +0000 (UTC)
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.68425.1790629186306885271
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Sep 2026 13:59:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=AbVPlnB5;
 spf=pass (domain: gmail.com, ip: 74.125.225.99, mailfrom: setairidis@gmail.com)
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48879d4fd8aso2056848f8f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790629184; x=1791233984; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/yX8ie3IWX+fbYmVJG7kEa/mgr3CR/DU8q/0/LvRLI=;
        b=AbVPlnB5fHYp85YghpK5yaTUJla1wRyZTdlOde9YQAzJtER7kdksP5G75OcsuBhv59
         Cfll8xaIDY80rxMDxR4nQbIJ1W4F0gKzzvCyqgBxqo/Jth5CDmPtnJuQql9NrfCIDFNB
         0BQFBYFJR49Pgt3sOV9FBdoKh838THiWL5p5uwr5cefaC4oGh7oo7xIYezJKpw9HcYJG
         n3ifWd3yhSlhdkvLyAXmY8jp/4qMJdH5cO7tqLEwtrSQae52x4ltPVxWHXJ9hueeSMQw
         3Uv5rn7rj2rwkKBUhak9wjGE0P2cpJFM2kcA8MSIq3itJa2tGSVAwnX01MTbKKfPa2GY
         HGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629184; x=1791233984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/yX8ie3IWX+fbYmVJG7kEa/mgr3CR/DU8q/0/LvRLI=;
        b=09P8RzhUHqiHg7oUsLxXIF3EMJcPBqUd7ZY231dyh2FkHQNl5NfYwjDafG8lZgj5gi
         R6q1iTUfW8swn7IMxThaigUNvLmdaXMEJJBpHzFk045mlo9foFHsPE7U0yMD7puYNAhn
         Zq0PF09k6UaZUy6NYFYLOyul/XqertammB07pGlJAg1vKaeBAzKmm7omtw8ET61Z0Gk2
         R6xh5wOWkkGnc8EysvA+BpV0ZHLuGSDoJUAmko4aWWJa2RYje/cPRYOH6uHeYYyoFefo
         KrP7bTN6W/dBG3PIxzq9pRUGYsGuVLnBaO5024yGY/cssl0j6QOWy3MjETA1GWOQSNwN
         9aFQ==
X-Gm-Message-State: AFq9FYIpcPJcaJ/ODDkDQSM6H1vEwd69gEx+a1fQH4i+V8Fos8c18ZJf
	zLf6wGRKNl9D+oYY8InePXFN1FYaOoOgrdnXN39X1FqzihOV4GI5Z38VIRafNP3gAWI=
X-Gm-Gg: AYBFou1yrsPYdroJaonSOrmjHELJjRUUGWteD7nGeLej9KKr+4akJxEy1CYhvDU54ak
	rvjAq1bDkhcLexMwEAdnHMhxPRAwbxj3Qq6uAT21F1iuIH+V8K5UhgHnaozM514AlxxFj+2psEC
	G2FzoZp626QGSTh0l79j8bTmVGu/lxCklXpd7iRdhpXok3GldAgTtYR5MGJZzOFaizYFrx8q+0F
	M0yKBIkzOdPA4Eab4DO6x/Uo9B/1dwkL4UFG5hHqGilv1qNFSqkx39QM88psUg1sk+Pv7RmRgeV
	h/lLX2LnLFBk7MqwkPU1EKw92oXi/2H7OJPS1kjcS/SPXu9/2EfOZTBoCyWFhv18+Et/W+Ir2Gt
	OSdkU2B7gPbS5TZgjBFxx164Oa7UM1SwnOTdcJB5S1YnmrxxnEHAt/ucADDAGnsPzBFenfPjarp
	pA7vzgAKN7VwmhkV7LsNQg2Jq5XmS+YruyjjvmElZ2sptmhhF0ShWEhzBkLvmnMwlKtyLAHueW3
	NpB3kix4O4qdsobCveSI729cLkxHO2eYzDdVr7vOJzvf4sF9a4RX/f7h98rLums8yQYF4SzXZX+
	yU5aCoT0WalxENWPcFk=
X-Received: by 2002:a5d:5e11:0:b0:488:773b:8650 with SMTP id ffacd0b85a97d-488773b8994mr15572938f8f.36.1790629184341;
        Mon, 28 Sep 2026 13:59:44 -0700 (PDT)
Received: from DESKTOP-LR19VKC.localdomain (ipservice-092-209-186-125.092.209.pools.vodafone-ip.de. [92.209.186.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a35607bsm27662163f8f.16.2026.09.28.13.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:59:43 -0700 (PDT)
From: Savvas Etairidis <setairidis@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	jhonata.poma@gmail.com
Cc: Savvas Etairidis <setairidis@gmail.com>
Subject: [PATCH v5] fetch/local: verify checksums for file:// urls
Date: Mon, 28 Sep 2026 22:59:40 +0200
Message-Id: <20260928205940.14169-1-setairidis@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2b5b8d1a56b5db173667efa839208df83188a7ca.camel@pbarker.dev>
References: <2b5b8d1a56b5db173667efa839208df83188a7ca.camel@pbarker.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 20:59:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20275

[YOCTO #9993]

Local.urldata_init() always cleared needdonestamp, so a checksum given
in a file:// url (e.g. UNINATIVE_CHECKSUM when UNINATIVE_URL points at
a local file://) was never verified. Keep the donestamp when the url
carries a checksum so verify_checksum runs, and make
rename_bad_checksum() a FetchMethod method that Local overrides as a
no-op, so a mismatch doesn't rename the user's source file.

Based on a patch by Jhonata Poma-Hansen.

Signed-off-by: Savvas Etairidis <setairidis@gmail.com>

---
changes in v5:
- Rebased on top of master, added changelog entry

changes in v4:
- Rebased on top of master

changes in v3:
- Cherry-picked the patch from Jhonata Poma-Hansen

---
---
 lib/bb/fetch/__init__.py | 36 ++++++++++++++++++------------------
 lib/bb/fetch/local.py    | 18 ++++++++++++++++--
 lib/bb/tests/fetch.py    | 30 ++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index 55ab710f3..a9f0add78 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -742,7 +742,7 @@ def verify_donestamp(ud, d, origud=None):
         logger.warning("Checksum mismatch for local file %s\n"
                        "Cleaning and trying again." % ud.localpath)
         if os.path.exists(ud.localpath):
-            rename_bad_checksum(ud, e.checksum)
+            ud.method.rename_bad_checksum(ud, e.checksum)
         bb.utils.remove(ud.donestamp)
     return False
 
@@ -775,7 +775,7 @@ def update_stamp(ud, d):
             logger.warning("Checksum mismatch for local file %s\n"
                            "Cleaning and trying again." % ud.localpath)
             if os.path.exists(ud.localpath):
-                rename_bad_checksum(ud, e.checksum)
+                ud.method.rename_bad_checksum(ud, e.checksum)
             bb.utils.remove(ud.donestamp)
             raise
 
@@ -1079,20 +1079,6 @@ def build_mirroruris(origud, mirrors, ld):
 
     return uris, uds
 
-def rename_bad_checksum(ud, suffix):
-    """
-    Renames files to have suffix from parameter
-    """
-
-    if ud.localpath is None:
-        return
-
-    new_localpath = "%s_bad-checksum_%s" % (ud.localpath, suffix)
-    bb.warn("Renaming %s to %s" % (ud.localpath, new_localpath))
-    if not bb.utils.movefile(ud.localpath, new_localpath):
-        bb.warn("Renaming %s to %s failed, grep movefile in log.do_fetch to see why" % (ud.localpath, new_localpath))
-
-
 def try_mirror_url(fetch, origud, ud, ld, check = False):
     # Return of None or a value means we're finished
     # False means try another url
@@ -1163,7 +1149,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
             logger.warning("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (ud.url, origud.url))
             logger.warning(str(e))
             if os.path.exists(ud.localpath):
-                rename_bad_checksum(ud, e.checksum)
+                ud.method.rename_bad_checksum(ud, e.checksum)
         elif isinstance(e, NoChecksumError):
             raise
         else:
@@ -1479,6 +1465,20 @@ class FetchMethod(object):
         """
         return True
 
+    def rename_bad_checksum(self, ud, suffix):
+        """
+        Rename ud.localpath with the given suffix on checksum mismatch.
+        Local overrides this to a no-op since its localpath points at the
+        user's source tree.
+        """
+        if ud.localpath is None:
+            return
+
+        new_localpath = "%s_bad-checksum_%s" % (ud.localpath, suffix)
+        bb.warn("Renaming %s to %s" % (ud.localpath, new_localpath))
+        if not bb.utils.movefile(ud.localpath, new_localpath):
+            bb.warn("Renaming %s to %s failed, grep movefile in log.do_fetch to see why" % (ud.localpath, new_localpath))
+
     def verify_donestamp(self, ud, d):
         """
         Verify the donestamp file
@@ -1943,7 +1943,7 @@ class Fetch(object):
                             logger.warning("Checksum failure encountered with download of %s - will attempt other sources if available" % u)
                             logger.debug(str(e))
                             if os.path.exists(ud.localpath):
-                                rename_bad_checksum(ud, e.checksum)
+                                ud.method.rename_bad_checksum(ud, e.checksum)
                         elif isinstance(e, NoChecksumError):
                             raise
                         else:
diff --git a/lib/bb/fetch/local.py b/lib/bb/fetch/local.py
index dfc5b564c..a92c0d267 100644
--- a/lib/bb/fetch/local.py
+++ b/lib/bb/fetch/local.py
@@ -17,7 +17,7 @@ import os
 import urllib.request, urllib.parse, urllib.error
 import bb
 import bb.utils
-from   bb.fetch import FetchMethod, FetchError, ParameterError
+from   bb.fetch import CHECKSUM_LIST, FetchMethod, FetchError, ParameterError
 from   bb.fetch import logger
 
 class Local(FetchMethod):
@@ -31,11 +31,25 @@ class Local(FetchMethod):
         # We don't set localfile as for this fetcher the file is already local!
         ud.basename = os.path.basename(ud.path)
         ud.basepath = ud.path
-        ud.needdonestamp = False
+        # Honor explicit checksum params (UNINATIVE_CHECKSUM, recipe
+        # ;sha256sum=) by leaving needdonestamp at FetchData's default so
+        # verify_checksum runs.
+        name = ud.parm.get("name")
+        ud.needdonestamp = any(
+            (name and "%s.%ssum" % (name, a) in ud.parm)
+            or "%ssum" % a in ud.parm
+            for a in CHECKSUM_LIST
+        )
         if "*" in ud.path:
             raise bb.fetch.ParameterError("file:// urls using globbing are no longer supported. Please place the files in a directory and reference that instead.", ud.url)
         return
 
+    def rename_bad_checksum(self, ud, suffix):
+        # file:// urls point at the user's source tree (recipe-shipped files
+        # under FILESPATH or an absolute path the user passed in); skip the
+        # rename so a ChecksumError surfaces without mutating their files.
+        return
+
     def localpath(self, urldata, d):
         """
         Return the local filename of a given url assuming a successful fetch.
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 71b0a63fe..60d356fc6 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -876,6 +876,36 @@ class FetcherLocalTest(FetcherTest):
             with self.subTest(striplevel=repr(value)):
                 self.assertInvalidStriplevel(value)
 
+    def test_local_checksum_match(self):
+        # Correct sha256 must run verify_checksum to completion; donestamp
+        # lands in DL_DIR.
+        import hashlib
+        content = b"file:// checksum match test\n"
+        with open(os.path.join(self.localsrcdir, 'sumfile'), 'wb') as f:
+            f.write(content)
+        good = hashlib.sha256(content).hexdigest()
+        fetcher = bb.fetch.Fetch(['file://sumfile;sha256sum=' + good], self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
+        self.assertTrue(ud.needdonestamp)
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.donestamp))
+
+    def test_local_checksum_mismatch(self):
+        # Bad sha256 raises ChecksumError without renaming the user's
+        # source file to the <localpath>_bad-checksum_<sha> sibling.
+        content = b"file:// checksum mismatch test\n"
+        srcpath = os.path.join(self.localsrcdir, 'sumfile')
+        with open(srcpath, 'wb') as f:
+            f.write(content)
+        bad = "0" * 64
+        fetcher = bb.fetch.Fetch(['file://sumfile;sha256sum=' + bad], self.d)
+        with self.assertRaises(bb.fetch.FetchError):
+            fetcher.download()
+        self.assertTrue(os.path.exists(srcpath))
+        with open(srcpath, 'rb') as f:
+            self.assertEqual(f.read(), content)
+        self.assertFalse(os.path.exists(srcpath + '_bad-checksum_' + bad))
+
     def dummyGitTest(self, suffix):
         # Create dummy local Git repo
         src_dir = tempfile.mkdtemp(dir=self.tempdir,
-- 
2.34.1


