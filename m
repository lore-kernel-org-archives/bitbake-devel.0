Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D85C6370C
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:57 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web12.13128.1649950931695883992
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 08:42:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=czJBccu5;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649950932;
  x=1681486932;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ua9/J4CObdtUlKUPcPBkfvnJ+oVKTXa6Y+AMerCdm1I=;
  b=czJBccu5AjBf7tFvbc7szqrI3ORHNyHVR1cHMf4ME05tOZWyNUB/AVvb
   sjyCn4AQJ2Y/8DDjnhTotQeXTKfn3G5/73Bc1n3DKs5C/mQi3X0m2l+3D
   EsNo+w2AwvPoUwWhSDxiVf0eNwUWwbQ4mWbc8ncv5WpCUGhpcLXWUl81x
   QixwjI403YCR/rTmk2fg+1jbNjOtTseTQmbjSfm+exVUNgAvzVwFNfw+E
   SNj9DMvk+K59lFEbdaJZXny1vPYPUlmZzNi7aW28MQuTDaTpyClEaHt8Y
   W1Le7eeu8X7v/YTLbI264dSDk+fDdRiVicV8WNK01zg+m9mTsHRoPrX5v
   w==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] fetch2/git: Simplify the validation of SHA-1 revisions
Date: Thu, 14 Apr 2022 17:42:07 +0200
Message-ID: <20220414154207.25999-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Apr 2022 16:03:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13621

Also correct two comments.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/git.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index b3eb8248d0..90104ac383 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -248,9 +248,10 @@ class Git(FetchMethod):
 
         ud.setup_revisions(d)
 
+        sha1_re = re.compile(r'^[0-9a-f]{40}$')
         for name in ud.names:
-            # Ensure anything that doesn't look like a sha256 checksum/revision is translated into one
-            if not ud.revisions[name] or len(ud.revisions[name]) != 40  or (False in [c in "abcdef0123456789" for c in ud.revisions[name]]):
+            # Ensure any revision that doesn't look like a SHA-1 is translated into one
+            if not sha1_re.match(ud.revisions[name] or ''):
                 if ud.revisions[name]:
                     ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
@@ -259,10 +260,10 @@ class Git(FetchMethod):
         if gitsrcname.startswith('.'):
             gitsrcname = gitsrcname[1:]
 
-        # for rebaseable git repo, it is necessary to keep mirror tar ball
-        # per revision, so that even the revision disappears from the
+        # For a rebaseable git repo, it is necessary to keep a mirror tar ball
+        # per revision, so that even if the revision disappears from the
         # upstream repo in the future, the mirror will remain intact and still
-        # contains the revision
+        # contain the revision
         if ud.rebaseable:
             for name in ud.names:
                 gitsrcname = gitsrcname + '_' + ud.revisions[name]

