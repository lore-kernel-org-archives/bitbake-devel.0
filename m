Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA935FEA82C
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 07:14:12 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17081.1774422847651794276
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2026 00:14:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=eYULxNBk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1329275-20260325071404843bff407c00020798-ybzcwt@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260325071404843bff407c00020798
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 25 Mar 2026 08:14:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8O+FyGoyAEK3XM0zpeEfEsfhcm7A85XV6lfCA+ddus0=;
 b=eYULxNBkKagr6qsJv6bHTEUK3A1F8TOTYn/9XYyGmNZZ3Mgb4EHFLtTT3iaw0xqS2kVJv4
 wTMWibVWNaFMgX85NmUwljXUgoE8h82Ba1O2llNSOtRwUg2SLy0obc4Qoh8nDAGQTeK3M7hU
 Ps5BgkOz+hSHVaxYeGQYwp2f6HxAUtHzPCv1nUEftw2uQprkAWWPzzgqesTm9qvJfqlt9Ec6
 LoX4JPXwWt+hceJcNl4j9zwiznGUSqVPsL1ffxC5vQmcidsoqUQtIgAeXGW9Xtqjo7IiqdI2
 hofG+fzF590TXY+2Tt37gvAQKsVuaMbzAXMVYDNFQEvVN8ok35xqbG/w==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 01/10] fetch2: add LocalModificationsError for uncommitted changes blocking update
Date: Wed, 25 Mar 2026 07:51:43 +0100
Message-ID: <20260325071342.47272-2-adrian.freihofer@siemens.com>
In-Reply-To: <20260325071342.47272-1-adrian.freihofer@siemens.com>
References: <20260325071342.47272-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 07:14:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19228

From: Adrian Freihofer <adrian.freihofer@siemens.com>

When unpack_update() detects uncommitted changes in a layer repository
it now raises LocalModificationsError, a new subclass of UnpackError,
instead of a plain UnpackError. The new exception:
- takes (repodir, url, git_output) as arguments
- builds the full user-facing message in its __init__, combining the
  git status output with guidance to commit, stash or discard changes
- keeps the is-a relationship with UnpackError so existing callers are
  not broken

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/fetch2/__init__.py | 8 ++++++++
 lib/bb/fetch2/git.py      | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 909ae9814..b39cfcd45 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -96,6 +96,14 @@ class UnpackError(BBFetchException):
         BBFetchException.__init__(self, msg)
         self.args = (message, url)
 
+class LocalModificationsError(UnpackError):
+    """Exception raised when a checkout cannot be updated due to local modifications"""
+    def __init__(self, repodir, url, git_output):
+        message = ("Repository at %s has uncommitted changes, unable to update:\n%s\n"
+                   "Please commit, stash or discard your changes and re-run the update." % (repodir, git_output))
+        UnpackError.__init__(self, message, url)
+        self.args = (repodir, url, git_output)
+
 class NoMethodError(BBFetchException):
     """Exception raised when there is no method to obtain a supplied url or set of urls"""
     def __init__(self, url):
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 84fecdad0..c398f7e9d 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -730,7 +730,7 @@ class Git(FetchMethod):
 
             output = runfetchcmd("%s status --untracked-files=no --porcelain" % (ud.basecmd), d, workdir=destdir)
             if output:
-                raise bb.fetch2.UnpackError("Repository at %s has uncommitted changes, unable to update:\n%s" % (destdir, output), ud.url)
+                raise bb.fetch2.LocalModificationsError(destdir, ud.url, output)
 
             # Set up remote for the download location if it doesn't exist
             try:
-- 
2.53.0


