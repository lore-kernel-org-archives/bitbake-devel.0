Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA72C79FB5
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 07:31:14 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6472.1788939066171472512
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2026 00:31:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=kiV1HxWO;
 spf=pass (domain: smile.fr, ip: 209.85.128.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49d0b98d6d0so34874075e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2026 00:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1788939064; x=1789543864; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z6Wl5+FBEJ14tfTnZD/ml3b9Yj2ybFHs1P+REAu7OYc=;
        b=kiV1HxWOuunVefM3LGd60SlgaujDeh5g0RI3HWkHRss9mVQZAcIPilz2kCmGXJB98W
         cOOhvuLtk8PLofsDll0DnlJIx0BOp4fWfts7jT4NP07gNbBco0cLgzcSD7EPBoeAPsq5
         FbmKNm/npUz+WnLMGajqtI5QFlLDVi2b+kWG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788939064; x=1789543864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Z6Wl5+FBEJ14tfTnZD/ml3b9Yj2ybFHs1P+REAu7OYc=;
        b=giDPeIsQm1Dt/3lFtWGpD9tJHSUgRaDp/9EnXyCprMxUUAmyqZqJhwHns19ktxnZPF
         uVhYtTRQ3UJrfEDAwmKSqNPYMTpgeDK5ao9tq6KxexUTO2iNrtdBEi69q+ySA7DX1Tb7
         Zko7d9LFLpk7R+g9v3GKXkMGtGKzSod5jz6xi/6816EjJsECY3sjJ7ItegvMVw4TSdSM
         4uKIYel0MSyGPOLa+qFn60esgcD9O0fILy4FQEwq2UjJAr2IjlL1pUKodlcFMxtQm9fy
         00aN1XUST3Aax64tcnnGSEJQC9iDeIElQVluRBj9qhQOLXnpJhg+zeQ1UW2OiCP9WNtB
         7DNA==
X-Gm-Message-State: AFuF++lc4yathZN35Lo1WQEIylxquwV+0SnEr/l1OI0qjxcV71KMfHDW
	NgPeVAT+/XUr9Ucx8tGCM9ftlfZT+6IOPXfnXQNRjLTnPqarPCAdrDcbVF15+TYaAPVpYNPYMeW
	+l6Tpm6M=
X-Gm-Gg: AYBFou34ctgOxxqlmVoPACifnz6JV9nRChfwOhcLr/raEHvRnDhNfDxGsEG86Ntjdgo
	mIeY83eAZJ4RsHbciHJGU3+Cl+6qZ7lnGuqNIOYnjBc13hSjKqOCZFCYlRETwbK5j/1/PGMmczY
	7tqkFMNprcOrz8bl1rrkl7bAxIvgKfd4ibLUPVdkDoed8eevLVVY33i9jY0Dp88CpFUjVOzRO6H
	d43zzari6Pahx1wmUU/UOjArKiTuTCZJyNEPylrhifS7hhNC9Prsp9L0bQg1kcy/VHGWAIe0zVE
	GmFZ5FzE9tMIc6uj3CSsUW0O/Y7fFCy9zmkTzG38WXyA8iZ42wr9E22j3Qjcj9cyv/hHuKkDhaf
	pgtMsOBU0T5yoe6MaKo8oK6A9E7JXwSWtx6RxH/o8AYFL5qkZji79AVaqsNMq/IHsMCqanY9fdS
	IX9ELMIvh758/9lLpDo5Lx2HCSI1+Ue8m7XvKImu37y2XM4GhCcdzJ42fchzYP9k+cSh0DknmFQ
	dU+ThwfeeL05eyWDyTtKSwFXyGlbdzkXDkSj/DwW/2p9AaYRbyonMo5qAFv6L+HOnX3Z4aX9kQ=
X-Received: by 2002:a05:600c:8b05:b0:49c:edd2:855 with SMTP id 5b1f17b1804b1-49cf823c411mr358311465e9.6.1788939064281;
        Wed, 09 Sep 2026 00:31:04 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm553491385e9.4.2026.09.09.00.31.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:31:03 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 1/4] data: Return a list from exported_vars()
Date: Wed,  9 Sep 2026 09:30:57 +0200
Message-ID: <ec9d2aacc2b3f3b9189a7f55c53abdcd7e5e4964.1788939009.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788939009.git.yoann.congal@smile.fr>
References: <cover.1788939009.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2026 07:31:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20173

From: Alejandro Mery <amery@apptly.co>

exported_vars() was a generator, so each value expanded when the result
was iterated rather than when it was called. bitbake-worker binds it
before bb.utils.empty_environment() and iterates it afterwards, so any
expansion deferred until iteration ran against the wiped environment
rather than the one bitbake started with.

The corruption is not uniform. The worker writes each variable into
os.environ as it goes, so only the first value expands against a fully
empty environment and the rest see it partially rebuilt, in
exported_keys() order.

Recipes whose exported variables expand a command during that loop hit
this. A gitver-style PV such as "${@get_git_pv(d, ...)}" runs git while
PATH is empty, so the git wrapper on PATH is bypassed and the real git
runs directly. Under pseudo this fakes uid 0 against a repository owned
by the real user, and git aborts with "detected dubious ownership",
failing do_package intermittently (only on reparse, when the value is
re-expanded rather than served from cache).

Build and return the list in exported_vars() itself, so the expansion is
complete before it returns and no caller has to know it was ever
deferred. A value that fails to expand now warns at that point rather
than during iteration, and a result nothing consumes is expanded anyway;
neither is a change for the one caller, which consumes all of it. Update
the comment at the worker's call site, which documented the generator
that is now gone, and add tests for the expansion timing and for the
warning that moved with it.

Signed-off-by: Alejandro Mery <amery@apptly.co>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c870f5bd96ad02efc02c58133c27bdae3a300e3e)
Signed-off-by: Alejandro Mery <amery@apptly.co>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
[YC: removed patch history from the commit message]
---
 bin/bitbake-worker   |  6 ++++--
 lib/bb/data.py       | 10 +++++++++-
 lib/bb/tests/data.py | 28 ++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index aa14ef191..ae21f277f 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -288,8 +288,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
                     else:
                         logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
 
-                # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
-                # successfully. We also need to unset anything from the environment which shouldn't be there 
+                # exported_vars() expands each value, so it must be called before
+                # empty_environment() below: an expansion that shells out needs the
+                # environment bitbake was started with. We also need to unset
+                # anything from the environment which shouldn't be there
                 exports = bb.data.exported_vars(the_data)
 
                 bb.utils.empty_environment()
diff --git a/lib/bb/data.py b/lib/bb/data.py
index b12972c03..7c01e6bf8 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -193,6 +193,12 @@ def exported_keys(d):
                                       not bb.utils.to_boolean(d.getVarFlag(key, 'unexport')))
 
 def exported_vars(d):
+    """Return the exported variables as a list of (key, value) pairs.
+
+    Every value is expanded before returning, so a caller that changes the
+    environment afterwards still gets what the expansion saw.
+    """
+    exported = []
     k = list(exported_keys(d))
     for key in k:
         try:
@@ -202,7 +208,9 @@ def exported_vars(d):
             continue
 
         if value is not None:
-            yield key, str(value)
+            exported.append((key, str(value)))
+
+    return exported
 
 def emit_func(func, o=sys.__stdout__, d = init()):
     """Emits all items in the data store in a format such that it can be sourced by a shell."""
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index fd690a9e2..a83c71e2c 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -723,3 +723,31 @@ class EmitVar(unittest.TestCase):
         self.assertEqual(self.get_output(out), ['bad_chars="a\\"b \\',
                                                 'c\\`d \\',
                                                 'e\\$f"'])
+
+class ExportedVars(unittest.TestCase):
+    def test_expanded_before_returning(self):
+        # Called while the variable is set, read once it is gone: the value
+        # has to be the one from the call, not from the read.
+        d = bb.data.init()
+        d.setVar("TESTVAR", "${@os.environ.get('BB_TEST_EXPORT', 'gone')}")
+        d.setVarFlag("TESTVAR", "export", "1")
+
+        with bb.utils.environment(BB_TEST_EXPORT="present"):
+            exported = bb.data.exported_vars(d)
+
+        self.assertEqual(dict(exported), {"TESTVAR": "present"})
+        self.assertIsInstance(exported, list)
+
+    def test_unexpandable_value_warns_and_is_skipped(self):
+        # The warning belongs to the call, not to a later iteration.
+        d = bb.data.init()
+        d.setVar("TESTVAR", "value")
+        d.setVarFlag("TESTVAR", "export", "1")
+        d.setVar("TESTBROKEN", "${@int('not a number')}")
+        d.setVarFlag("TESTBROKEN", "export", "1")
+
+        with LogRecord() as logs:
+            exported = bb.data.exported_vars(d)
+
+        self.assertEqual(dict(exported), {"TESTVAR": "value"})
+        self.assertTrue(logContains("Unable to export ${TESTBROKEN}", logs))

