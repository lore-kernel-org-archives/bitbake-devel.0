Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFB6FC97E4
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:30 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34484.1774809263057920385
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2026 11:34:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=ST2gykNZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1329275-20260329183419e6f874b93e00020791-2a0nrt@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260329183419e6f874b93e00020791
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 29 Mar 2026 20:34:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Nnmo35oV07aTzoAP8J5D6m73Apiz4salVBQcM/EJGEg=;
 b=ST2gykNZgV7Nu/Ztb2chLqWy/GmL0HT4oF4y0AhuQLxKGxLD9B1Cj8nAZCgmQyYZAdUKvR
 PBvMJIi1u/tZa4QiaQi0HX7si6AY3rCbUYEHYhAryg3HTKJF7pHGgDc8+WOGbghcIC9aUF0t
 2N4XfJ0PQGN6gv9LvcoRc8gu7AlSkO5GES4Igy+MjJcoJGMCszqEzHmhtuFYAJYFmzR1KREw
 F16ASHp8ukB8yXkL3UJxlqtRsjmQU0ikTE2khzzyxnlKdJ4JUJDln+krGwemxtGd8gCUiEK+
 iRFUEcL0coNDyQVgqaaQbFeTgkE0rirH2/mgUO5GxjQPL/pMpRHP/p2g==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 01/14] bitbake-setup: Fix type annotation for descriptions parameter in print_configs
Date: Sun, 29 Mar 2026 20:32:48 +0200
Message-ID: <20260329183332.1996183-2-adrian.freihofer@siemens.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19271

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Fixup for "bitbake-setup: Set function default to None":
when the default was changed from [] to None to avoid the mutable default
argument pitfall (B006), the type annotation was not updated accordingly.

The function body already explicitly handles None via:

    if not descriptions:
        descriptions = ["" for _ in choices]

Update the annotation to use the union type list[str] | None (Python 3.10+)
to accurately reflect that None is a valid value for this parameter.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index ce712e517..f0240cae5 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -46,7 +46,7 @@ def color_enabled() -> bool:
 def get_diff_color_param() -> str:
     return "--color=always" if color_enabled() else "--color=never"
 
-def print_configs(prompt: str, choices: list[str], descriptions: list[str] = None):
+def print_configs(prompt: str, choices: list[str], descriptions: list[str] | None = None):
     """
     Helper function to print a list of choices and align the output.
     Each option name is made bold to stand out, unless color is not enabled in
-- 
2.53.0


