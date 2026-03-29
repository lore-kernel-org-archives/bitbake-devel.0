Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B160FC97E2
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:30 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34480.1774809263056843324
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2026 11:34:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=bTVKkeWn;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1329275-20260329183420db6e8cd13600020707-wqrymk@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260329183420db6e8cd13600020707
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 29 Mar 2026 20:34:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HAq7eXLFjZheEakXRqCPGzR8luram90pCOe2hsMqG9I=;
 b=bTVKkeWn7jwgY3rtP6ktpiepEj9InmiR8vDotEZXEfDZ5I0uk+pZhp41Au2ONH7UxtE95L
 PoCRcC3TY3hu74654wE8C1Zq7zg+YPfkDzzv5ens9IBJ/ukt7aDJvqlENGbeL3RBuaPhrW64
 JmZBgSpJPYXNPdLmh4n+FrVi7gJdjIpWTkke03d8be105x8pOK9/nZkENxiOXPNUzhqCF9fZ
 Llw6qxRES1XpZJp7QOHusR6mjo5yF8UqoBW9ee8LpquItlbbqdHI+M+vN1YtGpWRgIGw2lYD
 12LEtpqp3Yma1UFn++00hH9qOoFfvwm+VVAJRlZ1pZ8k5ygxm9xpAeIQ==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 06/14] bitbake-setup: always restore sys.stdout
Date: Sun, 29 Mar 2026 20:32:53 +0200
Message-ID: <20260329183332.1996183-7-adrian.freihofer@siemens.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19272

From: Adrian Freihofer <adrian.freihofer@siemens.com>

While working on the bitbake-setup update with a non destructive fetcher,
I noticed that if the fetcher raises an exception, sys.stdout is not
restored, which can lead to issues in the rest of the code. This change
ensures that sys.stdout is always restored, even if an exception occurs
during the fetch and unpack process.

Showing the full Traceback of the error would be a bit confusing because
it happened in code which is not yet ready for review, but the final
error was:
  ValueError: I/O operation on closed file.

and this little change seems to be a reasonable improvement to avoid
such issues.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index f0240cae5..335927dae 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -794,9 +794,11 @@ def do_fetch(fetcher, dir):
     with open(fetchlog, 'a') as f:
         oldstdout = sys.stdout
         sys.stdout = f
-        fetcher.download()
-        fetcher.unpack_update(dir)
-        sys.stdout = oldstdout
+        try:
+            fetcher.download()
+            fetcher.unpack_update(dir)
+        finally:
+            sys.stdout = oldstdout
 
 def update_registry(registry, cachedir, d):
     registrydir = 'configurations'
-- 
2.53.0


