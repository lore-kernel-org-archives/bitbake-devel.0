Return-Path: <wavexx@thregr.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34BFC3DA42
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 19:39:29 +0000 (UTC)
Received: from erc.thregr.org (erc.thregr.org [46.43.2.63])
 by mx.groups.io with SMTP id smtpd.web10.4907.1720553955911081339
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jul 2024 12:39:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thregr.org header.s=v1 header.b=pMNRHMQ9;
 spf=pass (domain: thregr.org, ip: 46.43.2.63, mailfrom: wavexx@thregr.org)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thregr.org;
	s=v1; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:
	From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=MSSSrInIFtBay/2JeA44+hlayodVA8sPTL8PXsn835A=; b=p
	MNRHMQ9WsQhpDUUyDupZE13aSOG0vOPFaT3WvyR73VY0DyWek0D7QX7KnmIR0qUu2vW0zz+nIIac9
	RR4fpdoKKISai+P9Gcwpgt28yQRkS8Ljp8HEYOGXaT2tiTMsrhdYrzY/G9kprf8tMTv75oMVmbfOS
	HJmcAIAN/KI/Yx5uOhqCJpw9rt3S9fz2AVgLD3URRpCbKFyovLRto+acGWJlh5qPjbVMVF7dMaxvs
	aWOS6EqHjHzdkvmBUISNY4zcjNFxYZ8wWRCBDgp2f3uP4PnGNHkC/jSRnKEAAQOxtWZI5SUl1Nj89
	T431rqg1OwShxdg0Uc88MXz5NMMJ3+GqA==;
Received: from [37.162.171.55] (helo=localhost)
	by erc.thregr.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1sRGfw-00000007lB8-0Ryz (envelope-from <wavexx@thregr.org>);
	Tue, 09 Jul 2024 21:38:56 +0200
From: Yuri D'Elia <wavexx@thregr.org>
To: bitbake-devel@lists.openembedded.org
Cc: Yuri D'Elia <wavexx@thregr.org>
Subject: [PATCH] fetch2/git: Enforce default remote name to "origin"
Date: Tue,  9 Jul 2024 21:39:06 +0200
Message-ID: <20240709193906.165986-1-wavexx@thregr.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jul 2024 19:39:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16413

Enforce the default remote name to "origin", as assumed in numerous
places.

This prevents build failures in case the system/user configuration sets
this to a different value.
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index c7ff769fd..a65cd4bb2 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -262,7 +262,7 @@ class Git(FetchMethod):
             for name in ud.names:
                 ud.unresolvedrev[name] = 'HEAD'
 
-        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c gc.autoDetach=false -c core.pager=cat -c safe.bareRepository=all"
+        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c gc.autoDetach=false -c core.pager=cat -c safe.bareRepository=all -c clone.defaultRemoteName=origin"
 
         write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
         ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
-- 
2.45.2


