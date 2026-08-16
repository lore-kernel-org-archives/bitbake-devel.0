Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562ADC5B572
	for <webhook@archiver.kernel.org>; Sun, 16 Aug 2026 22:15:19 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18658.1786918513597642071
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 16 Aug 2026 15:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=TLn6fV1T;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1329275-2026081622151152511fc91900020713-0bc_vz@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026081622151152511fc91900020713
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 17 Aug 2026 00:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Z80GARX2coisDMT58FFgCiS2Mdk+Hz2R7++QHzW0Fzs=;
 b=TLn6fV1TlgmC81f+98Z1yVJzaKvsYqK5ac2mGgvVQFwLY7PrnTK+k2bJdp8GjD3lTYMGXY
 ICHAM6nRS0mzweEeHfpoMwDX8Qk3Ht5M4jZsc2Ts8w0ukEIPljjIIDM2G1NwWzNY+XwT4Vgb
 +XihW37zkBB7YJky+h1RZSXRaTXjHNAid6iUDPf0bNc9h9y/GUQDbcIjcUexj1c7KYAevJ0W
 TQRN15MZPU5plSTI765FaAFF2+yBAQYNTg94AYO5sbf3Rjxa9txngUhdrzk3UBvdp7a+D6dg
 /vL9JuLHOXRUKHoFhFOJuMPVhEWfgl1+wON5iOPYZ1ozJaGJIUXNR43w==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 4/8] command: fix setConfig coercing bool config values to truthy strings
Date: Mon, 17 Aug 2026 00:14:43 +0200
Message-ID: <20260816221507.155861-5-adrian.freihofer@siemens.com>
In-Reply-To: <20260816221507.155861-1-adrian.freihofer@siemens.com>
References: <20260816221507.155861-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 16 Aug 2026 22:15:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19966

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


