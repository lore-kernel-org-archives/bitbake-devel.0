Return-Path: <pascal.bach@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26916C433F5
	for <webhook@archiver.kernel.org>; Thu, 29 Sep 2022 09:20:55 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web09.8355.1664443246370011999
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Sep 2022 02:20:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=pascal.bach@siemens.com header.s=fm1 header.b=nTF/DsRO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-402798-2022092909204361aaf924c3ec9875c0-_21shh@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 2022092909204361aaf924c3ec9875c0
        for <bitbake-devel@lists.openembedded.org>;
        Thu, 29 Sep 2022 11:20:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=pascal.bach@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ZOCJOLU0hNfXpHn4HV358trJqkJw2kKMpejSzeZOHnU=;
 b=nTF/DsROAIOyEF6TUUjxm9KQQZm0438LQK47in/n5GMs9o9yve73phoRsMMTEfy7oAdgqz
 vkk8JdVlAaqM97wD9hMAZvcqKFxXRMgsEg0xxKR2u8JTapIr5U+vHdjZdBnjF+Eqgl7jG3NS
 nZUhvoGE2qte+JW06RqKG1aQrckXg=;
From: pascal.bach@siemens.com
To: bitbake-devel@lists.openembedded.org
Cc: Pascal Bach <pascal.bach@siemens.com>
Subject: [PATCH] fetch2/ssh.py: fix checkstatus
Date: Thu, 29 Sep 2022 11:20:39 +0200
Message-Id: <20220929092039.1873677-1-pascal.bach@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-402798:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Sep 2022 09:20:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13996

From: Pascal Bach <pascal.bach@siemens.com>

The output of runfetchcmd is always empty in this case, as
the test doesn't produce any output.
SSH either returns 0 or 1, which is handled via exceptions.

This means the current check is not only unnecessary but prevents the
function from working.

We can just assume that if we reach the end of the function that the
file exists and return True.

Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 lib/bb/fetch2/ssh.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 8d082b38..0cbb2a6f 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -150,8 +150,6 @@ class SSH(FetchMethod):
         )
 
         check_network_access(d, cmd, urldata.url)
+        runfetchcmd(cmd, d)
 
-        if runfetchcmd(cmd, d):
-            return True
-
-        return False
+        return True
-- 
2.37.3


