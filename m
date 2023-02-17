Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9E8C05027
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 17:00:55 +0000 (UTC)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by mx.groups.io with SMTP id smtpd.web11.11728.1676653252957390427
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 09:00:53 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@myneves.com header.s=protonmail header.b=dzUzV5Oh;
 spf=pass (domain: myneves.com, ip: 185.70.43.23, mailfrom: paulo@myneves.com)
Date: Fri, 17 Feb 2023 17:00:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail; t=1676653250; x=1676912450;
	bh=nn5fllmPlowIcbnTx7D9zdeU9B8OPSZbjcmL16jZSmQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dzUzV5OhkCotgaELMHJxPR/cvmn6xrkVRI+LtquhO67hOpc3+i0bL213J86lwBP0G
	 c/FCgpaU90c1+MKSMt29CV3hBiQB0USJX4NXvH3fmzgJ7SLho00eITBqJ5/n+iKy0x
	 uKP1yeTAbHVPYYWq6qTmW0q487IapeJ96rLcpX48ipNnNJYc/onFOA3VumNYaAkZoR
	 u/aCdWSlZtCdT3M4K3fdZKlNhOe1pFsMzJwarIns23upc+ycyRJ8l5E8RtkDPPXKNF
	 3MOX+sPtrUcxsZdjB+OPvdOhdoteUcGw+m5jOTrY0+uCpbcLFrrNdrjQ/MPLXjIpy7
	 PWObz++cfLMDQ==
To: bitbake-devel@lists.openembedded.org
From: Paulo Neves <paulo@myneves.com>
Cc: Paulo Neves <paulo@myneves.com>
Subject: [PATCH 3/5] git: Remove is None check on  _find_git_lfs
Message-ID: <20230217170009.58707-3-paulo@myneves.com>
In-Reply-To: <20230217170009.58707-1-paulo@myneves.com>
References: <20230217170009.58707-1-paulo@myneves.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 17:00:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14462

shutil.which returns None when the argument is not found.
As per documentation[1] None is evaluated to False and everything
else is True, so it is safe to have _find_git_lfs just return
the value of shutil.which

[1] https://docs.python.org/3/library/stdtypes.html#truth-value-testing

Signed-off-by: Paulo Neves <paulo@myneves.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 2e3d32515..a3f29d2b9 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -687,7 +687,7 @@ class Git(FetchMethod):
         Return True if git-lfs can be found, False otherwise.
         """
         import shutil
-        return shutil.which("git-lfs", path=3Dd.getVar('PATH')) is not Non=
e
+        return shutil.which("git-lfs", path=3Dd.getVar('PATH'))

     def _get_repo_url(self, ud):
         """
--
2.34.1



