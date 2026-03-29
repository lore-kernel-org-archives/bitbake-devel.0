Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E999BFC97E6
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:30 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34711.1774809263055890021
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2026 11:34:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=W/akWgDe;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1329275-20260329183419d7365fead000020754-0sjrd0@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260329183419d7365fead000020754
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 29 Mar 2026 20:34:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NPm4s7iKzEDeuqxpl9IVYBGfOkpj6hREhHtW5vkvOt8=;
 b=W/akWgDeylNu55Zx0OwcukWwOv68PeQdhPaBC2oZKB1MDiA2Lzy7dbFWc9OA51gVkHyJTA
 GC6rcj3jjVgR6AxgP9WPkiuEDZOXoHxUpcnBfaJCQgT86xGa5enLYHyD1ibVO14PZQVGuOhW
 MK/evhXDZjV96djx1/69WGYdkAVo2CiNAqLfK2n0UCRF6RswW9sUIjq8f9aDJhtt+CKTqoeK
 wc7eYFMS/2N4308kd0vfW0zAz0Es7UMTL6KRtoERSuzhFT4Bf33U1hr5ZXqlqJoC8BULbb7G
 DKqw7fkB1wnDpnCB8uZThE9BuQ60OCsyFGdjVemmooNh3Jcdmf/e5f5A==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 02/14] fetch2: add LocalModificationsError and RebaseError exceptions
Date: Sun, 29 Mar 2026 20:32:49 +0200
Message-ID: <20260329183332.1996183-3-adrian.freihofer@siemens.com>
In-Reply-To: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
References: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 29 Mar 2026 18:34:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19270

From: Adrian Freihofer <adrian.freihofer@siemens.com>

When unpack_update() detects either of two blocking conditions, it now
raises a dedicated exception subclass of UnpackError instead of a
generic UnpackError:

- LocalModificationsError: for uncommitted changes in the working tree
  that prevent the update. Includes git status output and instructs
  the user to commit, stash or discard changes.

- RebaseError: for local commits that could not be rebased onto the
  new upstream revision. Includes the git rebase output and a hint
  that the 'dldir' remote points to the local download cache and may
  be used to resolve conflicts manually.

Both exceptions take (repodir, url, git_output) as arguments, build
the full user-facing message in __init__, and preserve the is-a
relationship with UnpackError so existing callers are not broken.

The fetch and rebase operations are also split into separate
try/except blocks so that a failure to fetch from dldir raises a
plain UnpackError while a failed rebase raises RebaseError.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/fetch2/__init__.py | 17 +++++++++++++++++
 lib/bb/fetch2/git.py      |  7 +++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index e7213dea4..d104dfaf3 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -96,6 +96,23 @@ class UnpackError(BBFetchException):
         BBFetchException.__init__(self, msg)
         self.args = (message, url)
 
+class LocalModificationsError(UnpackError):
+    """Exception raised when a checkout cannot be updated due to local modifications"""
+    def __init__(self, repodir, url, git_output):
+        message = ("Repository at %s has uncommitted changes, unable to update:\n%s\n"
+                   "Commit, stash or discard your changes and re-run the update." % (repodir, git_output))
+        UnpackError.__init__(self, message, url)
+        self.args = (repodir, url, git_output)
+
+class RebaseError(UnpackError):
+    """Exception raised when a checkout has local commits that could not be rebased onto the new upstream revision"""
+    def __init__(self, repodir, url, git_output):
+        message = ("Repository at %s has local commits that could not be rebased onto the new upstream revision:\n%s\n"
+                   "Note: the 'dldir' remote points to the local download cache and may be used to resolve the conflict manually.\n"
+                   "Once resolved, re-run the update." % (repodir, git_output))
+        UnpackError.__init__(self, message, url)
+        self.args = (repodir, url, git_output)
+
 class NoMethodError(BBFetchException):
     """Exception raised when there is no method to obtain a supplied url or set of urls"""
     def __init__(self, url):
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 645746340..6ed14005b 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -730,7 +730,7 @@ class Git(FetchMethod):
 
             output = runfetchcmd("%s status --untracked-files=no --porcelain" % (ud.basecmd), d, workdir=destdir)
             if output:
-                raise bb.fetch2.UnpackError("Repository at %s has uncommitted changes, unable to update:\n%s" % (destdir, output), ud.url)
+                raise bb.fetch2.LocalModificationsError(destdir, ud.url, output)
 
             # Set up remote for the download location if it doesn't exist
             try:
@@ -740,6 +740,9 @@ class Git(FetchMethod):
                     runfetchcmd("%s remote add dldir file://%s" % (ud.basecmd, ud.clonedir), d, workdir=destdir)
             try:
                 runfetchcmd("%s fetch dldir" % (ud.basecmd), d, workdir=destdir)
+            except bb.fetch2.FetchError as e:
+                raise bb.fetch2.UnpackError("Failed to fetch from dldir remote: %s" % str(e), ud.url)
+            try:
                 runfetchcmd("%s rebase --no-autosquash --no-autostash %s" % (ud.basecmd, ud.revision), d, workdir=destdir)
             except bb.fetch2.FetchError as e:
                 # If rebase failed, abort it
@@ -747,7 +750,7 @@ class Git(FetchMethod):
                     runfetchcmd("%s rebase --abort" % (ud.basecmd), d, workdir=destdir)
                 except Exception:
                     pass
-                raise bb.fetch2.UnpackError("Failed to update checkout in place: %s" % str(e), ud.url)
+                raise bb.fetch2.RebaseError(destdir, ud.url, str(e))
             return True
 
         # If there is a tag parameter in the url and we also have a fixed srcrev, check the tag
-- 
2.53.0


