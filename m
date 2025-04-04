Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EA9C3601E
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 19:00:25 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.5095.1743793216385866306
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Apr 2025 12:00:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=e84JO4f8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-256628-20250404190014f3a451e2bdedfee1a7-6wgwhv@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250404190014f3a451e2bdedfee1a7
        for <bitbake-devel@lists.openembedded.org>;
        Fri, 04 Apr 2025 21:00:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=x9M0cepR0Oq5d3+W6/RbRDlQ6m5uq5XXStqO72MIZFA=;
 b=e84JO4f8QY8OHgLB+7g8HAScS6Nbu26CCN7EFHOc3S2L06nhxtDdcP1knJw9nCrkGuwRJn
 7myXlC9qgQruYJU8Cx9zCqX3cB+RD2xXjpWYf7MkwH1oiHDXu7cYwHGxCxbfwncxaXPCVOWa
 TNHI09ZKP/f9oo2DDALlUTZH7jjjY3T/tBIgKH2iIPKXjXJ4OgEZsWsERIm3qu4nXcRTsZqr
 lY4su10z7lsh64SoB0QXZp51MvdOC98v7qfoJVCzWkOQnLcHaWrOKzq1uPIqkA2c82kOw1iy
 B1sEq3akNTG3dp15myxlt88tLuiebXf5/fpnTUAp6y++PuHMvCssiCug==;
From: Peter Marko <peter.marko@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [PATCH 2/2] fetch/git: correct typo in comment and style
Date: Fri,  4 Apr 2025 20:59:11 +0200
Message-Id: <20250404185911.137153-2-peter.marko@siemens.com>
In-Reply-To: <20250404185911.137153-1-peter.marko@siemens.com>
References: <20250404185911.137153-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Apr 2025 19:00:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17519

From: Peter Marko <peter.marko@siemens.com>

Correct typo Fash -> Fast.
With it also delete some trailing spaces which are unnecessary and
editors are trying to remove when changing anything in the file.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 bitbake/lib/bb/fetch2/git.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 587a16994a..b47a53e3be 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -182,7 +182,7 @@ class Git(FetchMethod):
         ud.bareclone = ud.parm.get("bareclone","0") == "1"
         if ud.bareclone:
             ud.nocheckout = 1
-  
+
         ud.unresolvedrev = ""
         ud.branch = ud.parm.get("branch", "")
         if not ud.branch and not ud.nobranch:
@@ -557,7 +557,7 @@ class Git(FetchMethod):
             try:
                 self.clone_shallow_local(ud, shallowclone, d)
             except:
-                logger.warning("Fash shallow clone failed, try to skip fast mode now.")
+                logger.warning("Fast shallow clone failed, try to skip fast mode now.")
                 bb.utils.remove(tempdir, recurse=True)
                 os.mkdir(tempdir)
                 ud.shallow_skip_fast = True
@@ -871,7 +871,7 @@ class Git(FetchMethod):
         """
         # Note that we do not support passwords directly in the git urls. There are several
         # reasons. SRC_URI can be written out to things like buildhistory and people don't
-        # want to leak passwords like that. Its also all too easy to share metadata without 
+        # want to leak passwords like that. Its also all too easy to share metadata without
         # removing the password. ssh keys, ~/.netrc and ~/.ssh/config files can be used as
         # alternatives so we will not take patches adding password support here.
         if ud.user:

