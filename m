Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BB1C433EF
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 20:57:03 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.2.1649968652107749556
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 13:37:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=o1lf1nV5;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649968652;
  x=1681504652;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mBLFuRLmvfq7zOUOg4zuU2LxOcWuso95w5naXt+Itz4=;
  b=o1lf1nV5gWRDpGRvH+/uortwTGV3vJ5usj3XcudMFEhNzfWq1d5rg6fu
   M8jFpVZx286OmkKWYREzdwDRm0vLPijWpJzeS4Wrf/X+ZqXOYJwprxsjF
   Acmtw89MDNPav2Xl4E24PziyIro3mGd+AiGNfgMN3KWTwZfylVoUqeXHC
   xC9uC1i3WDnREKdzA545CvMq3+kHqShQeK/bd39xPnf/gUolFUB9Ky4u9
   frtmBbwIc6lWxzQlaiYs7J8XLKfEMUkeU7WaqoiAPKmafP/mH59JqY70A
   BBNrLyUH3dH/dnwsV6yUAUBnwAq/nmKDwKOZn1C29HT955WSiI8e5fMQl
   g==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2] fetch2/git: Simplify the validation of SHA-1 revisions
Date: Thu, 14 Apr 2022 22:37:27 +0200
Message-ID: <20220414203727.14926-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Apr 2022 20:57:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13627

Also correct two comments, and move slash_re from _revision_key() to
the module top level (together with the new sha1_re).

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCH v2: Move sha1_re and slash_re to the module top level.

 bitbake/lib/bb/fetch2/git.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index b3eb8248d0..bdcfa4978c 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -74,6 +74,9 @@ from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
 
 
+sha1_re = re.compile(r'^[0-9a-f]{40}$')
+slash_re = re.compile(r"/+")
+
 class GitProgressHandler(bb.progress.LineFilterProgressHandler):
     """Extract progress information from git output"""
     def __init__(self, d):
@@ -249,8 +252,8 @@ class Git(FetchMethod):
         ud.setup_revisions(d)
 
         for name in ud.names:
-            # Ensure anything that doesn't look like a sha256 checksum/revision is translated into one
-            if not ud.revisions[name] or len(ud.revisions[name]) != 40  or (False in [c in "abcdef0123456789" for c in ud.revisions[name]]):
+            # Ensure any revision that doesn't look like a SHA-1 is translated into one
+            if not sha1_re.match(ud.revisions[name] or ''):
                 if ud.revisions[name]:
                     ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
@@ -259,10 +262,10 @@ class Git(FetchMethod):
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
@@ -697,7 +700,6 @@ class Git(FetchMethod):
         Return a unique key for the url
         """
         # Collapse adjacent slashes
-        slash_re = re.compile(r"/+")
         return "git:" + ud.host + slash_re.sub(".", ud.path) + ud.unresolvedrev[name]
 
     def _lsremote(self, ud, d, search):

