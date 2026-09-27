Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1F0C9833F
	for <webhook@archiver.kernel.org>; Sun, 27 Sep 2026 07:46:58 +0000 (UTC)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32882.1790495202344351560
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Sep 2026 00:46:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Xp9Ink0d;
 spf=pass (domain: smile.fr, ip: 74.125.225.76, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so1149553f8f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790495200; x=1791100000; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gsk/KUe37wis/3Q8ZYT1cBkKFWsg+vh4xy4sd7h1+kI=;
        b=Xp9Ink0d/ClGSndJhceK6h3/l8WlYWlk899fU2rWaaZv4D+AhWV/FnqgXB1NrrHzND
         iAgOCmQFg+3jroUIGc53aIU0pk9NfKuScevuQThqo3bdZzVo2x5Q2cFcG/VFmC+s4I4M
         0meW77B6cpx1hunIlY5znHremEPapd3MulmpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790495200; x=1791100000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gsk/KUe37wis/3Q8ZYT1cBkKFWsg+vh4xy4sd7h1+kI=;
        b=tPsAuPmGAUtmqsRP2BhAv4hwl2umT5MosF2JdhMjZ6On+uW2Z+M3kxhH+W/2TGhEya
         hF4DxXPuJ0wIhAlUT9eewGESLqP+OgZWmRHoOWfqE6H9Y+XL6YMQTIK6BDXfOveG2cV2
         imvlS61ockaOT5chYzfYxd9Q+IML0nsJWt1Dyi5yj75v1cTzlOj/QDRi1T3uYYb+efLE
         DkgwAA9WLd/P73Nb6XR1dXez4+OXsXbJwlgwmF+1zwMcLuILTX5csh0GV9XGHA6KCeYI
         pKmhk5PImt8Sh4Ic8mAvACHu85HuwRiCo1uqCDYqgGrbDiuVdTTK4teU8RRGXc7ERrSp
         N4pw==
X-Gm-Message-State: AFq9FYLHAWJohuLeWP46TkYfJCk/Rk6JocCyEiSpbjS8vFy8InXXFP26
	uMDsYmQJb1L7Ghydc0kOzKhPklIgqk1Mng2VWLsnfZUaq71D7Hm7hVwtIsmZmygKv3bcdG3Uemg
	XjR1Dt84=
X-Gm-Gg: AYBFou0KX/yybrKENadsf0FVQ7PNEEu1mBoLV0zHxi4dJn4JFdmy04a4tdUgwXv8Y/d
	qDJsDxXeJkyn7as3ZZNzAWnLzByqFDcZEtsWnmwjgT/NmnJcynwj9TyCZMRMNwTpjLFkGcVtfml
	JO5u72toaoLTG6lh3YFOvW97ticCcRINlCYUG97hHI+5gViadiQaRXzlBzc1AHf2vPjoo3uaFcd
	Rzx+3L3HnfhWqvnpRuIFZCilaKLu7X+GK60NB3DYFqMyzXj8qE2IlO7J3i8JjdBHcnQ7g+v3igt
	aYCKpYKNamsYPoo9oLe9VI0Uxo3WEbYl7UhLkFoaWfrJevxgRJk90+lxhjJnZMAn5zJFmX8pj/t
	xcqqj6qGyF3cJ7CaLWIKLXu7NDCPJi75a6Iz9tVog6v4Hceij3HWh7u9/Y9BEue8q0aPpWLQIe8
	rKyQH0V/Q2/JMhKZsCP+khCjAcbl6F5A7pw3nxAt81YMuzwigEFNjAsi5XCNXu9Z2GY8WLlaMFo
	gHfFjWb5bmgNqNR8iqzctB7kZlPxMLR6lSyMSYpu1fmMi1GibnKy3jrDo4Gu/NzpffP0yUlNA==
X-Received: by 2002:a05:6000:2888:b0:488:8948:2187 with SMTP id ffacd0b85a97d-48889482da9mr5279506f8f.16.1790495200574;
        Sun, 27 Sep 2026 00:46:40 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm18485266f8f.2.2026.09.27.00.46.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:46:39 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 5/6] data: Fix expandKeys recursion issue
Date: Sun, 27 Sep 2026 09:46:34 +0200
Message-ID: <c7029045baa2fd986e7cb5b52f6ba74571cdf728.1790495161.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790495160.git.yoann.congal@smile.fr>
References: <cover.1790495160.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 07:46:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20264

From: Richard Purdie <richard.purdie@linuxfoundation.org>

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
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a3c6a020da9a352d0474e85bc0591b4a174cb0c0)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/data.py       |  2 +-
 lib/bb/data_smart.py |  5 +++--
 lib/bb/tests/data.py | 25 +++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 7c01e6bf8..f81f44eac 100644
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
index 110dfa111..e26b0659a 100644
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
@@ -693,7 +693,8 @@ class DataSmart(MutableMapping):
             self.overridedata[newkey] = []
             for (v, o) in self.overridedata[key]:
                 self.overridedata[newkey].append([v.replace(key, newkey), o])
-                self.renameVar(v, v.replace(key, newkey))
+                if recurse:
+                    self.renameVar(v, v.replace(key, newkey))
 
         if ':' in newkey and val is None:
             self._setvar_update_overrides(newkey, **loginfo)
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index a83c71e2c..491774747 100644
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

