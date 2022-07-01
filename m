Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98BEC433EF
	for <webhook@archiver.kernel.org>; Fri,  1 Jul 2022 16:57:20 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web09.41314.1656694637250389464
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Jul 2022 09:57:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aka5Wnhh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id l68so1654370wml.3
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Jul 2022 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dV/JKeB68C3s7dy+bWs5a3HZgbwaXqJ3UFBG4K2bu34=;
        b=aka5WnhhuiF2rnyGYWW4tuVn8xI86A6YdaGqRYtQ8UNipN8Gpd/A+uDoGskx/q6L6J
         qBOKj/OLOjxZIoGl9SzBae191hPIZljwtPJDOwXF/ZRltL5224czdNhch3CcyLvMUbOt
         2vna1tx5DpI0epfPGAfZPa5ucLBRi1yc4KpXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dV/JKeB68C3s7dy+bWs5a3HZgbwaXqJ3UFBG4K2bu34=;
        b=YOr85jsJrtnv3QBQ1Mk27OcelN/U8qFAWY3f0rGdATWCVazT7T86tDHN4z8PO10ind
         1BvW0ksYirG0QhOXBp8RHTp3ChMDeFyEq5SBgm7ncr+Tc7WAXyGQhNVMo5+LWHYBt1iR
         ZuTPfeRSGOEtUDiEwsak2uCBVsCCjbPX3N8i/I8LpKZKuaOqXbU7iAe9ANX91oKvvCWK
         RyML4GB4+f+HouwV3yz+RigLDZlrll76J9l+riHOx1lX1jNUaMU+rbCdjFOBXun9aTbl
         Kj4Pqaq/gJPXUJXG30rqnmS+Kug44T9eq5I7hktjEFXboyy/IW+WJo6SsaXgm5fNSYwY
         YxPw==
X-Gm-Message-State: AJIora+BUK/DNCR94J6DOX4ltH3zOjP2oy6FDw4Waj9X3rdwVA2U7ppe
	4FeGoXEI3FFAbM+EviisLPzcA6EWdNdjEA==
X-Google-Smtp-Source: 
 AGRyM1udu+lNmW1CfYDRkbpSC2NqvBcPrqOMu4ygIwbZzLH1ujeaQh7ZB6M1vwxoiRbSBplZ97d3Hg==
X-Received: by 2002:a05:600c:3c83:b0:39c:9039:852c with SMTP id
 bg3-20020a05600c3c8300b0039c9039852cmr17609700wmb.187.1656694635264;
        Fri, 01 Jul 2022 09:57:15 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a49f:615b:a613:6a47])
        by smtp.gmail.com with ESMTPSA id
 h13-20020adff4cd000000b002103aebe8absm22811347wrp.93.2022.07.01.09.57.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:57:13 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] ConfHandler/BBHandler: Improve comment error messages and add
 tests
Date: Fri,  1 Jul 2022 17:57:10 +0100
Message-Id: <20220701165710.797159-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Jul 2022 16:57:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13794

Currently if you trigger one of the comment errors, the newline characters
are stripped and the line numbers are incorrect. In one case it prints
the empty line which is also unhelpful.

Rework the code around these errors so the line numbers are correct
and the lines in question are more clearly displayed complete with newlines
so the user can more clearly see the error.

I also added a couple of simplistic test cases to ensure that errors
are raised by the two known comment format errors.

[YOCTO #11904]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/parse_py/BBHandler.py   |  4 ++--
 lib/bb/parse/parse_py/ConfHandler.py |  9 +++++++--
 lib/bb/tests/parse.py                | 23 +++++++++++++++++++++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index ee9bd760ce..68415735fd 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -178,10 +178,10 @@ def feeder(lineno, s, fn, root, statements, eof=False):
 
     if s and s[0] == '#':
         if len(__residue__) != 0 and __residue__[0][0] != "#":
-            bb.fatal("There is a comment on line %s of file %s (%s) which is in the middle of a multiline expression.\nBitbake used to ignore these but no longer does so, please fix your metadata as errors are likely as a result of this change." % (lineno, fn, s))
+            bb.fatal("There is a comment on line %s of file %s:\n'''\n%s\n'''\nwhich is in the middle of a multiline expression. This syntax is invalid, please correct it." % (lineno, fn, s))
 
     if len(__residue__) != 0 and __residue__[0][0] == "#" and (not s or s[0] != "#"):
-        bb.fatal("There is a confusing multiline, partially commented expression on line %s of file %s (%s).\nPlease clarify whether this is all a comment or should be parsed." % (lineno, fn, s))
+        bb.fatal("There is a confusing multiline partially commented expression on line %s of file %s:\n%s\nPlease clarify whether this is all a comment or should be parsed." % (lineno - len(__residue__), fn, "\n".join(__residue__)))
 
     if s and s[-1] == '\\':
         __residue__.append(s[:-1])
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 810b6011cf..451e68dd66 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -125,16 +125,21 @@ def handle(fn, data, include):
             s = f.readline()
             if not s:
                 break
+            origlineno = lineno
+            origline = s
             w = s.strip()
             # skip empty lines
             if not w:
                 continue
             s = s.rstrip()
             while s[-1] == '\\':
-                s2 = f.readline().rstrip()
+                line = f.readline()
+                origline += line
+                s2 = line.rstrip()
                 lineno = lineno + 1
                 if (not s2 or s2 and s2[0] != "#") and s[0] == "#" :
-                    bb.fatal("There is a confusing multiline, partially commented expression on line %s of file %s (%s).\nPlease clarify whether this is all a comment or should be parsed." % (lineno, fn, s))
+                    bb.fatal("There is a confusing multiline, partially commented expression starting on line %s of file %s:\n%s\nPlease clarify whether this is all a comment or should be parsed." % (origlineno, fn, origline))
+
                 s = s[:-1] + s2
             # skip comments
             if s[0] == '#':
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 2898f9bb14..1a3b74934d 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -194,3 +194,26 @@ deltask ${EMPTYVAR}
         self.assertTrue('addtask ignored: " do_patch"' in stdout)
         #self.assertTrue('dependent task do_foo for do_patch does not exist' in stdout)
 
+    broken_multiline_comment = """
+# First line of comment \\
+# Second line of comment \\
+
+"""
+    def test_parse_broken_multiline_comment(self):
+        f = self.parsehelper(self.broken_multiline_comment)
+        with self.assertRaises(bb.BBHandledException):
+            d = bb.parse.handle(f.name, self.d)['']
+
+
+    comment_in_var = """
+VAR = " \\
+    SOMEVAL \\
+#   some comment \\
+    SOMEOTHERVAL \\
+"
+"""
+    def test_parse_comment_in_var(self):
+        f = self.parsehelper(self.comment_in_var)
+        with self.assertRaises(bb.BBHandledException):
+            d = bb.parse.handle(f.name, self.d)['']
+
-- 
2.34.1


