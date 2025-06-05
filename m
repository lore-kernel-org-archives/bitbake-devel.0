Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4306AC5AE59
	for <webhook@archiver.kernel.org>; Thu,  5 Jun 2025 11:10:49 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.4895.1749121839699924346
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Jun 2025 04:10:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=PFFS40hI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1329275-202506051110342d66eae580125e3ad3-ropnyj@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202506051110342d66eae580125e3ad3
        for <bitbake-devel@lists.openembedded.org>;
        Thu, 05 Jun 2025 13:10:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=J4S+tqNwDLBO9fy+qkY4xjP77arkzOcC0UyOYXnNE24=;
 b=PFFS40hIe3pQkgxdlkc0F6THM350ERsvd4FBLNRbz12nr7/RKba55ZnOtGkUmCMFWBmydQ
 h8DrvMzmTLhrMNRX+FcfJx0VIHfWd23zG091P6fD1dlSl+ZYxE5VJS3fHIgFKhz9qOiUtEBb
 XhplO+BzCgjn/4owUXxEhKtBARvmw4DHPOF3s3u+Q0ylBiCU2pUAlljACLXgJF73SqI8Hq4s
 UhkdNugPlxqMDmQwH5SNkwinO4P1vvWA1HyVwoj+vcI8ILK0q7FXkWgwokXXNqMsq0zDJbI7
 tER5ku0e3BdDxGkekywiEtk9Bv3XOLxrD9ZdmqaXV2fCgywvdY3cdufw==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH] fetch2: Avoid deprecation warning
Date: Thu,  5 Jun 2025 13:10:18 +0200
Message-ID: <20250605111018.97903-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Jun 2025 11:10:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17685

From: Richard Purdie <richard.purdie@linuxfoundation.org>

>From re on python 3.13 onwards: "Passing count and flags as positional arguments is deprecated.
In future Python versions they will be keyword-only parameters."

Avoid the warning.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index e698fde19..1a6ff25d4 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -237,7 +237,7 @@ class URI(object):
         # to RFC compliant URL format. E.g.:
         #   file://foo.diff -> file:foo.diff
         if urlp.scheme in self._netloc_forbidden:
-            uri = re.sub("(?<=:)//(?!/)", "", uri, 1)
+            uri = re.sub(r"(?<=:)//(?!/)", "", uri, count=1)
             reparse = 1
 
         if reparse:
-- 
2.49.0


