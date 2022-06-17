Return-Path: <ola.x.nilsson@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3225AC43334
	for <webhook@archiver.kernel.org>; Fri, 17 Jun 2022 11:27:30 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web09.29447.1655465242303324148
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jun 2022 04:27:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=De8B8LtL;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: ola.x.nilsson@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1655465242;
  x=1687001242;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HvBOKbhNoA2NBtQXWfjHgz6T+r2IBEcnpNd4URQL6/M=;
  b=De8B8LtLG3n2+BwimUOEY+ZV75CIrabBF+p/LS41EizV0HWhunCTdxBP
   Q1Z4lXunzaKSIRvUkV9VfzxVjyR9ZGXW1RfHs+Wyed0pn691GJQu4tu8U
   96Df6LJUD1gpoFdHVt7oFFjyWvZNvvmnJJyciTikl+WlhBn0pUVqhQhFB
   RbO2HKCYzDc2u8zvsrlCdd6z2eHdP9whFY+1PSdanULyvkNr2ulmhOboz
   B72fkZeOQP6CELgUiwUu7Mou/bbensnsH4A0X4UfbmlawZQlX7RYKuXyS
   vKN2p/pt758e7+Z7ToxcFeXv7iAl+UTArIax5Dg5I8NSBxJah/EFYap3W
   g==;
From: Ola x Nilsson <olani@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] ConfHandler: Remove lingering close
Date: Fri, 17 Jun 2022 13:27:19 +0200
Message-ID: <20220617112719.15479-1-olani@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jun 2022 11:27:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13773

The f.close() statement should have been removed in
459ad524756a3f9b50feeedf31e33502dceae8d5.

Signed-off-by: Ola x Nilsson <ola.x.nilsson@axis.com>
---
 lib/bb/parse/parse_py/ConfHandler.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index b895d5b5..810b6011 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -147,8 +147,6 @@ def handle(fn, data, include):
     if oldfile:
         data.setVar('FILE', oldfile)
 
-    f.close()
-
     for f in confFilters:
         f(fn, data)
 
-- 
2.30.2


