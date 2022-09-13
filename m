Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E78FC6FA89
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:30 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web09.5464.1663079238452346540
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=3iDVWg/l;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.174,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f174.google.com with SMTP id l10so11989205plb.10
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=+urg61y2Fj3ocDy8sdhqwi7kKvoIxv/p9Fq9PehVjxk=;
        b=3iDVWg/l7V5VG6zySSW6HDyamjuyHWeAjdV3wbRVmApNPRobR/dfb08EuRVGgIKLBn
         eJO+HegHZ7FJdCiMsSjMOkF++iemMIC6cVhZN+ubIivAT8Vy/aVuVRxW7sithvdrzehG
         2Boy3vSyook1Vmm37WOhY/927Y27qbxGAW9YbhuszYMyH8t+v0FA/gDqwNByIDKMJH1M
         AQXlPyR7c9BhJt18lAylAxhugV760VUAmCoxNYUAmofM54X9MmoMFCY6QNXgyTpzeHTP
         8teCS8eeyQAE3gKdIeKCIR6XKHxA7v69Z7pmKNU6zOlgrW3mhhkQ3lLRlEiZGdCn7bZ6
         jxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+urg61y2Fj3ocDy8sdhqwi7kKvoIxv/p9Fq9PehVjxk=;
        b=LvHHnpWDCIPcdhzIgL756rizwJP4vwuytebhWs4D42fIbf9kPofK7BeHSV1d2/aTig
         NC0bK0TF4Q320+D8E5yKPYMjil8AzR8WZW2AxQXRn2ZWruaqyzSxKBd8ENvCgOiSSirP
         xGDgXSi8AVmvbs30VEu2huSvdaf9PhZh1DZkmNQSujqQd7z9o5wwhNIrSyzn2G9JABeU
         tIDKbu5D0Ni2o+11pqnhNjNMm5Ay1E3ebCZxT9Cg9gOYaL9AdgAc5UX5Y9XvkF2VxmdR
         siSX6WtkCABlXhjMxNoyvJJjoMOtsXwy7I8mNGaDWfNWN3UtY+fvD/2ITCPHmL8yOUF/
         tJzA==
X-Gm-Message-State: ACgBeo1vNG6E8kAE6wzAkKSj1dSJT5MuOK7epaZk8oSAB5Q8wPxqTgyL
	GHvHpLHH2as5JH17TUi7YbadNj8mcDcN3PRS
X-Google-Smtp-Source: 
 AA6agR4z7xOGIzZgu97ke43MakV5AeVXJ6othi2rvnV1OkuGY68JqBCeYq6iTfbnH/3InrzzTcKfZw==
X-Received: by 2002:a17:90a:d151:b0:1fa:b2a6:226a with SMTP id
 t17-20020a17090ad15100b001fab2a6226amr4374666pjw.104.1663079241875;
        Tue, 13 Sep 2022 07:27:21 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.27.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:21 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 09/14] ConfHandler/BBHandler: Improve
 comment error messages and add tests
Date: Tue, 13 Sep 2022 04:26:39 -1000
Message-Id: 
 <f8c11121dedd40bcc8d219c028c1a70ada70ebb6.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13970

From: Richard Purdie <richard.purdie@linuxfoundation.org>

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
(cherry picked from commit 712da71b24445c814d79a206ce26188def8fce0a)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/parse/parse_py/BBHandler.py   |  4 ++--
 lib/bb/parse/parse_py/ConfHandler.py |  9 +++++++--
 lib/bb/tests/parse.py                | 23 +++++++++++++++++++++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index ee9bd760..68415735 100644
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
index 810b6011..451e68dd 100644
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
index 2898f9bb..1a3b7493 100644
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
2.25.1


