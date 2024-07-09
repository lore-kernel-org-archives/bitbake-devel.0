Return-Path: <wavexx@thregr.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19689C2BD09
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 18:21:09 +0000 (UTC)
Received: from erc.thregr.org (erc.thregr.org [46.43.2.63])
 by mx.groups.io with SMTP id smtpd.web10.2977.1720549266543979432
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jul 2024 11:21:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thregr.org header.s=v1 header.b=EYiIELJN;
 spf=pass (domain: thregr.org, ip: 46.43.2.63, mailfrom: wavexx@thregr.org)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thregr.org;
	s=v1; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:
	From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=xxSYAtYAvILh4E4RsoVsn1u30iIwji++CQO5zsMS894=; b=E
	YiIELJNoYb9ZkMrN/lTIKw8fNG9c6QQ2eyoOGgfLXAeBR0SXE05X4OzwuYeqm037Xzq+apidtSj7B
	eFMeO1CYjT8q/5ZlkM0BoVyWHpwTekICvs4aBWtCncHr4uRDJ+ciO/GBcM9vUrtLE+7YVqJkA7LTO
	MKJ6GSrCinTQRIb0UenrLYyogDdFaJ14FyjO+5NGtiLyjKJAiQfgNpRhWctfveDZ4K+2sBEZ+jn2s
	O+S/qTMKxMeULjBWSwt8pLmkmkDuuoxWasFQVh91j2lGgloPql9lj7tSWtTx3CIeGpF4WmQo9pD8j
	r+75qWoui+26eFWomLs/lphA5/xJ0mziQ==;
Received: from [37.162.171.55] (helo=localhost)
	by erc.thregr.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1sRFSL-00000007irQ-1roR (envelope-from <wavexx@thregr.org>);
	Tue, 09 Jul 2024 20:20:49 +0200
From: Yuri D'Elia <wavexx@thregr.org>
To: bitbake-devel@lists.openembedded.org
Cc: Yuri D'Elia <wavexx@thregr.org>
Subject: [PATCH] fetch2/git: Sanitize git configuration
Date: Tue,  9 Jul 2024 20:20:58 +0200
Message-ID: <20240709182057.141231-2-wavexx@thregr.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jul 2024 18:21:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16409

Prevent loading the local and system configuration by default.

This prevents clone from failing if, for example, the user has set a
different clone.defaultRemoteName (which git still honours from the HOME
directory) whereas the fetcher expects the default remote to be
"origin".

Instead of overriding unsafe values (which might break unexpectedly),
always start with a stock config.
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index c7ff769fd..1ea000b3a 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -262,7 +262,7 @@ class Git(FetchMethod):
             for name in ud.names:
                 ud.unresolvedrev[name] = 'HEAD'
 
-        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c gc.autoDetach=false -c core.pager=cat -c safe.bareRepository=all"
+        ud.basecmd = d.getVar("FETCHCMD_git") or "GIT_CONFIG_GLOBAL=/dev/null git -c gc.autoDetach=false -c core.pager=cat -c safe.bareRepository=all"
 
         write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
         ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
-- 
2.45.2


