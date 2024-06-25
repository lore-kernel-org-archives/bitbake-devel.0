Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B0CC41513
	for <webhook@archiver.kernel.org>; Tue, 25 Jun 2024 19:40:25 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.6071.1719344416735739846
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Jun 2024 12:40:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=grqn6flD;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-202406251940148d2bc6dc13a2704d6e-yrsqox@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202406251940148d2bc6dc13a2704d6e
        for <bitbake-devel@lists.openembedded.org>;
        Tue, 25 Jun 2024 21:40:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=uFrSeVNprB4u+zE8Ob6OHkesFZQkqLLTwTHgtEkt29g=;
 b=grqn6flD3qsfkLHdwlb5J/9IbI5XfKTS8Lzkdz6Md15eiY6MhPjqAzD0elYnuGbDFhGfsd
 jnbZPMtdtdNLhS19oSiTjlyCHlw/rflxgf5hviIT+pY/eVD7U16y6rztQNlN06EIrD5QZROD
 aslJlThCnRhqDxhAk91x7v7vnm0zE=;
From: Peter Marko <peter.marko@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [master][scarthgap][PATCH] fetch: remove True option to getVar calls in clearcase module
Date: Tue, 25 Jun 2024 21:36:19 +0200
Message-Id: <20240625193619.1799635-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Jun 2024 19:40:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16378

From: Peter Marko <peter.marko@siemens.com>

Layer cleanup similar to
https://git.openembedded.org/openembedded-core/commit/?id=26c74fd10614582e177437608908eb43688ab510

It was probably not found before beacause of the extra "d" parameter.
That seem to be a bug as getVar does not support that.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 lib/bb/fetch2/clearcase.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 1a9c86376..2b3bd7069 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -108,7 +108,7 @@ class ClearCase(FetchMethod):
                                                 ud.module.replace("/", "."),
                                                 ud.label.replace("/", "."))
 
-        ud.viewname         = "%s-view%s" % (ud.identifier, d.getVar("DATETIME", d, True))
+        ud.viewname         = "%s-view%s" % (ud.identifier, d.getVar("DATETIME"))
         ud.csname           = "%s-config-spec" % (ud.identifier)
         ud.ccasedir         = os.path.join(d.getVar("DL_DIR"), ud.type)
         ud.viewdir          = os.path.join(ud.ccasedir, ud.viewname)
@@ -196,7 +196,7 @@ class ClearCase(FetchMethod):
 
     def need_update(self, ud, d):
         if ("LATEST" in ud.label) or (ud.customspec and "LATEST" in ud.customspec):
-            ud.identifier += "-%s" % d.getVar("DATETIME",d, True)
+            ud.identifier += "-%s" % d.getVar("DATETIME")
             return True
         if os.path.exists(ud.localpath):
             return False
-- 
2.30.2


