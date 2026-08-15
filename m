Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97272C5DF6E
	for <webhook@archiver.kernel.org>; Sat, 15 Aug 2026 13:47:40 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9199.1786801649528025338
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 15 Aug 2026 06:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=XMuY+nbG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1329275-20260815134726403ac30869000207dc-txpyuo@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260815134726403ac30869000207dc
        for <bitbake-devel@lists.openembedded.org>;
        Sat, 15 Aug 2026 15:47:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Z80GARX2coisDMT58FFgCiS2Mdk+Hz2R7++QHzW0Fzs=;
 b=XMuY+nbG9kJHuv7H8ANfch5MsT1X2jTjGNCPO9sy6POXZZxV0RhUWtGRvj8c4lWIL+L4d3
 MdjqDim0/QnKpiWFTYay6uc7z5TPz9dHOJUAiK/RS+AysYXn+eV1Lai9YO/q/nuutM3yfeYS
 LX7Zs9F/t4heYMKQV6w+MxEH5am95HQEGV+H7Rmwv/+cxgzrIueq+0FQ/5LRRoGU7QaApUEh
 d/J3kDrIgc6slT94gsS+vt+crgIUAQJYzwhMD9z15OHt8TFcBqURSBZaXO6LstwAlaFkH49z
 WZPnD2AGlbXM9S1tuNZAt7RVqJjNjNRW6hClDhXmHzV2vn2kG6L8XgNg==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 3/7] command: fix setConfig coercing bool config values to truthy strings
Date: Sat, 15 Aug 2026 15:46:54 +0200
Message-ID: <20260815134722.497586-4-adrian.freihofer@siemens.com>
In-Reply-To: <20260815134722.497586-1-adrian.freihofer@siemens.com>
References: <20260815134722.497586-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 15 Aug 2026 13:47:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19954

From: Adrian Freihofer <adrian.freihofer@siemens.com>

CommandsSync.setConfig() unconditionally stringified the value with
str(params[1]) before assigning it to the cooker configuration
attribute. This breaks boolean values, since str(True) and str(False)
are both non-empty and therefore both truthy.

That makes it impossible to turn a boolean option back off over the
command interface: setting 'force' to False leaves configuration.force
holding the truthy string "False", so it stays effectively enabled for
the rest of the bitbake server session and spuriously invalidates tasks
in later, unrelated builds sharing that session.

Preserve the caller's original type instead of coercing to str. The
only other caller (cookerdata.py) already passes a plain string, so
this does not change behavior for it.

AI-Generated: Uses GitHub Copilot

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/command.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 59a979ee9..b57c5d4a3 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -228,7 +228,7 @@ class CommandsSync:
         Set the value of variable in configuration
         """
         varname = params[0]
-        value = str(params[1])
+        value = params[1]
         setattr(command.cooker.configuration, varname, value)
 
     def enableDataTracking(self, command, params):
-- 
2.55.0


