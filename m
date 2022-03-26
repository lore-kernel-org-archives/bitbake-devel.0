Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20883C433EF
	for <webhook@archiver.kernel.org>; Sat, 26 Mar 2022 18:40:00 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web08.6478.1648319998759865038
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Mar 2022 11:39:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=lV2wbNdh;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1648319999;
  x=1679855999;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C6D0V217Z66Hzd5azuakkUUtbuYRZla0VNJ8LY8zcvA=;
  b=lV2wbNdhJ16e/sBJAGMAO38G4CE+X124CbwwnoT9Xd7o96QgF3WYjpwt
   0LXQZJRNyLxbV6vNorxW7sI4aJoWDoE7z+7tUF3VZMbEOQ7xqCeEd2nf3
   7enUe46gRlJfb+oAnNv9k5xzfC/a8Y+RXI5OAteKS/KwGD8B4BTxH3qb4
   1PGP6KosiJjzvhNUEyrMusF63hWMwgl/b/53Ww9/gG/+lkbJY/fO/5XTa
   +OMAXul0CKmLrNN0j6fMUBNNT2kFfDj3yb67tGUKTzpGN9pGeMKij9fOw
   qpd/noezaYPhsXjZqDPoUPNJm3BMfYJjobR+p2IT8l4pje8Lac6IHqrCQ
   A==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] server/process: Correct a typo in a comment
Date: Sat, 26 Mar 2022 19:39:53 +0100
Message-ID: <20220326183953.21730-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 26 Mar 2022 18:40:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13512

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index efc3f04b4c..7c587a9110 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -556,7 +556,7 @@ def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpc
 
         server.run()
     finally:
-        # Flush any ,essages/errors to the logfile before exit
+        # Flush any messages/errors to the logfile before exit
         sys.stdout.flush()
         sys.stderr.flush()
 

