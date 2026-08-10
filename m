Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A49C5AD55
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 14:47:03 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31289.1786373217056177492
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Aug 2026 07:46:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CvynrirA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47de0093c42so1421009f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Aug 2026 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786373215; x=1786978015; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bn4YtsHYru3GFr65QiFlDcl0xkECV+uzio4JN/dKj9o=;
        b=CvynrirAPlp6Gf5qyHyWK4Ty9hBpaq1ZeBJAVaYukuL2bgKSdsNgYcl+Yreq+KZHwk
         O16yeoVs3uv6flwza4joFeOlaLNSmGhnLXDqS+qD1uYuVf9F75vF4fHj0WlMPaFOJkRF
         m1/ZM7Cj87gMdNT5fPMc7fbTqDAQjlLamoIGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786373215; x=1786978015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bn4YtsHYru3GFr65QiFlDcl0xkECV+uzio4JN/dKj9o=;
        b=F3z0UHB1/5JNfCt62tcgM4CPToP+2Zsnj/2BKPv+irT5o0J4YOkODq6efYOh7GXs8g
         bYKMBFQw4j3bdDyqJpUqAyLz6HWyiNxp8xfk8KsplwDdepLvI5boqwEipcXZkrrgvmTd
         GRQEvyW6toluvxktdkxnIwM+KJzhz8ke7fZkTUCfqvmaFGvf0lNbkEFgHnsLvQbd991o
         i99y0XoOdIGLUUskkMctUqlq0ilYCCclRs3kS5exGzrCNDim2Fj8NceOa8N6rStZxWYe
         BGLLe/jySdlv0uKf9YWLRe+leDQsjKKtfK5P8euYdlJ2sM3ISjkSL8oE0ZyJe+/x9mHN
         6mzA==
X-Gm-Message-State: AOJu0YxoUCZuSmI5OiFC0A2Gfm8xRYBBGTDFY/Z8ihKdM76rZdw/UBiY
	Da3gNO1NE/s7b+xYs6CZc5pFv4xWVjDiQostuPgTmQdEQMPqe2C58a5ElY6QLHhSUy4dh0zazgj
	6eSNo0kc=
X-Gm-Gg: AR+sD11aDBnDTcbot79pvglJeiDbOq5RAp8BOCa2Jt2LIuhK/HYSbJ+7ZFEuCyjIsEI
	IYVbgKyNIUFKlmkrd+gF5tDxJAUQ3LfAg0k07n+XHDJPsJRIYk0LW6Tf2M1oxM7u3ViN4yeVyYj
	Qyw26SHwXC8BsROZ8QtlZscccQzaGdvKmj98uSzYXCkBz8ifjHdFNXDNZyqs7xcX3ProgoFOdYa
	Ex3UA2KHKxm49BKq63NSVInibetC3xJSuht2qxWxzqiWJkc/7Il+qjLaLKjIkVJjfAuST944Ycs
	kZFq1/c6jjHyTwHKuad0OvkN5rQocp2+YItzvQuxan52V2UacCQSZk05L8AE1mjvz5qwe+VXuFm
	3R2V/UOXAaS3nDpJQ19XMvMjlQgjqccHhoCWOZLekFOm7HMde8ZfKWyBd57h8HZy8OmT4aGAvNT
	KQ/I/1nMm3dtFWIVvs+M/1NPNzrkwz26Uoc4a+8+WohV/E45EcaKqRs7ItoO3lQV2KFKknMJH5C
	Vtc09ZmGdLM8uv49UU/pf9paiO0
X-Received: by 2002:adf:e9ca:0:b0:47f:fe71:ef24 with SMTP id ffacd0b85a97d-48130efae6fmr23907045f8f.27.1786373215176;
        Mon, 10 Aug 2026 07:46:55 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:96ae:4423:ae88:ca02])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800220ab11sm37431563f8f.35.2026.08.10.07.46.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:46:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data: Fix expandKeys recursion issue
Date: Mon, 10 Aug 2026 15:46:53 +0100
Message-ID: <20260810144653.2803105-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Aug 2026 14:47:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19910

Using an variable expansion in override such as:

RDEPENDS:${PN}:append:pn-packagegroup-cross-canadian-${MACHINE} = ' XXX'

wasn't functioning correctly. Looking through the code, renameVar does
work correctly but it doesn't work if called multiple times on the sub
components of the variable.

expandKeys will already recurse variables so we need to ensure renameVar
doesn't also do that as things break if we do it multiple times.

Change the code to avoid recursion in renameVar which should also have
a small performance improvement.

Test case from Nguyen Minh Tien <zizuzacker@gmail.com>

[YOCTO #14867]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py       |  2 +-
 lib/bb/data_smart.py |  5 +++--
 lib/bb/tests/data.py | 25 +++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 7c01e6bf81c..f81f44eaccd 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -94,7 +94,7 @@ def expandKeys(alterdata, readdata = None):
             val = alterdata.getVar(key, False)
             if val is not None:
                 bb.warn("Variable key %s (%s) replaces original key %s (%s)." % (key, val, ekey, newval))
-        alterdata.renameVar(key, ekey)
+        alterdata.renameVar(key, ekey, recurse=False)
 
 def inheritFromOS(d, savedenv, permitted):
     """Inherit variables from the initial environment."""
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 9961269a3f8..cbace852021 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -661,7 +661,7 @@ class DataSmart(MutableMapping):
     def getVar(self, var, expand=True, noweakdefault=False, parsing=False):
         return self.getVarFlag(var, "_content", expand, noweakdefault, parsing)
 
-    def renameVar(self, key, newkey, **loginfo):
+    def renameVar(self, key, newkey, recurse=True, **loginfo):
         """
         Rename the variable key to newkey
         """
@@ -698,7 +698,8 @@ class DataSmart(MutableMapping):
             self.overridedata[newkey] = []
             for (v, o) in self.overridedata[key]:
                 self.overridedata[newkey].append([v.replace(key, newkey), o])
-                self.renameVar(v, v.replace(key, newkey))
+                if recurse:
+                    self.renameVar(v, v.replace(key, newkey))
 
         if not found:
             # No variable to rename so not worth the work in writing extra
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index a83c71e2c25..49177474778 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -406,6 +406,31 @@ class TestOverrides(unittest.TestCase):
         bb.data.expandKeys(self.d)
         self.assertEqual(self.d.getVar("VERSION"), "2")
 
+    # Test an :append whose override name is only resolved by key expansion
+    def test_append_in_expanded_override(self):
+        self.d.setVar("MACHINE", "qemux86")
+        self.d.setVar("PN", "gizmo")
+        self.d.setVar("OVERRIDES", "gizmo:pn-gizmo-qemux86")
+        self.d.setVar("TEST:${PN}", "base")
+        self.d.setVar("TEST:${PN}:append:pn-gizmo-${MACHINE}", " appended")
+        bb.data.expandKeys(self.d)
+        self.assertEqual(self.d.getVar("TEST"), "base appended")
+
+    # Test renaming to a key which is itself not expanded yet, as native.bbclass
+    # does. The dependent override keys must be left for expandKeys() to rename.
+    def test_rename_to_unexpanded_key_with_override(self):
+        self.d.setVar("BPN", "gizmo")
+        self.d.setVar("PN", "gizmo-native")
+        self.d.setVar("OVERRIDES", "class-target")
+        self.d.setVar("TEST:${PN}-lib", "base")
+        self.d.setVar("TEST:${PN}-lib:class-target", "target")
+        with LogRecord() as logs:
+            self.d.renameVar("TEST:${PN}-lib", "TEST:${BPN}-lib-native")
+            bb.data.expandKeys(self.d)
+            self.assertFalse(logContains("renameVar with equivalent keys", logs))
+            self.assertFalse(logContains("replaces original key", logs))
+        self.assertEqual(self.d.getVar("TEST:gizmo-lib-native"), "target")
+
     def test_remove_with_override(self):
         self.d.setVar("TEST:bar", "testvalue2")
         self.d.setVar("TEST:some_val", "testvalue3 testvalue5")

