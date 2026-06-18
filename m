Return-Path: <thune.a.tran@boeing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0672CD98F0
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 23:00:06 +0000 (UTC)
Received: from phx-mbsout-02.mbs.boeing.net (phx-mbsout-02.mbs.boeing.net [130.76.184.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31689.1781823599853945026
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 16:00:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@boeing.com header.s=boeing-s1912 header.b=TUtBH2MH;
 spf=pass (domain: boeing.com, ip: 130.76.184.179, mailfrom: thune.a.tran@boeing.com)
Received: from localhost (localhost [127.0.0.1])
	by phx-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/DOWNSTREAM_MBSOUT) with SMTP id 65IMxvjX017024;
	Thu, 18 Jun 2026 15:59:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boeing.com;
	s=boeing-s1912; t=1781823598;
	bh=1YYyPRL9j5Pr0CAy6+yLq1C0zYAogQtQepDzvzpu68k=;
	h=From:To:Cc:Subject:Date:From;
	b=TUtBH2MH+6EZ2N+lf7bEtCcl3HcC6FK0HgkSqVKfu5uhlMYAdNqe6TfNDfIHKJf6h
	 sG78uBIzV0HmQ7QkVwEpWAU6pg4QpF6Cj55LZlxGkzQmqVxnc1YBSPQkDvf3uL/8De
	 iPP1pjqQ6rG1Vrm4HVnw2/WjI4zUN5JBRW75jfAmJ7bQziDXawAJ75ENjXi00+WvPI
	 PvN8TCeqqfQ+qPHmUEFr9DfoqKwetIIaTasBu8xiQ+CNT1MvgcRILIIGtJf4AX8zi6
	 AaHn4SV+kls78xz//B2iAH2yP+/SPychCQmHEcapvU6nzM5Rc8RETtL3dY2z+z9LL8
	 TkNLtrSp96h/A==
Received: from ewa-av-01.mbs.boeing.net (ewa-av-01.mbs.boeing.net [137.137.51.75])
	by phx-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/8.15.2/UPSTREAM_MBSOUT) with ESMTPS id 65IMxqrs016980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 15:59:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by ewa-av-01.mbs.boeing.net (8.15.2/8.15.2/DOWNSTREAM_RELAY) with SMTP id 65IMxoei004196;
	Thu, 18 Jun 2026 15:59:52 -0700
Received: from A6637002.nos.boeing.com (a6637002.nos.boeing.com [10.35.210.187])
	by ewa-av-01.mbs.boeing.net (8.15.2/8.15.2/UPSTREAM_RELAY) with ESMTP id 65IMxkDg003979;
	Thu, 18 Jun 2026 15:59:47 -0700
From: Thune Tran <thune.a.tran@boeing.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thune Tran <thune.a.tran@boeing.com>,
        Chuck Wolber <chuck.wolber@boeing.com>
Subject: [PATCH] fetch2: export AWS_SHARED_CREDENTIALS_FILE for S3 fetches
Date: Thu, 18 Jun 2026 22:59:43 +0000
Message-Id: <20260618225943.48724-1-thune.a.tran@boeing.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 23:00:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19746

The S3 fetcher cannot use AWS credentials from a credential file
other than the default ~/.aws/credentials because fetch2 does not
export AWS_SHARED_CREDENTIALS_FILE.

Signed-off-by: Thune Tran <thune.a.tran@boeing.com>
Signed-off-by: Chuck Wolber <chuck.wolber@boeing.com>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f7d5dfe9a..4efa35a49 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -907,6 +907,7 @@ FETCH_EXPORT_VARS = ['HOME', 'PATH',
                      'SSL_CERT_FILE',
                      'NODE_EXTRA_CA_CERTS',
                      'AWS_PROFILE',
+                     'AWS_SHARED_CREDENTIALS_FILE',
                      'AWS_ACCESS_KEY_ID',
                      'AWS_SECRET_ACCESS_KEY',
                      'AWS_ROLE_ARN',
-- 
2.34.1


