Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web08.8153.1628167056344868857
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Aug 2021 05:37:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=R6awRNhm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id h13so6353982wrp.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Aug 2021 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iubxp0Hnj83MrCWHd8yifZOzNFHFG7x3MNQZF1Np5o=;
        b=R6awRNhmLHDVjQ/plhsR7MvzWQQahbG3xHhEwtLuJFUtuOBh6YPr/p+cMR72+UPnJX
         EQm9NTskfSAEBnJEUZ7Rg6+bjkya6qQZyP1YJyhsLa2ddfOkFNO6FyZ3suj2cPNonMyG
         5qdA/CFHwfzTX4lzLF44dZYuhwRHH3vVXbMtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iubxp0Hnj83MrCWHd8yifZOzNFHFG7x3MNQZF1Np5o=;
        b=pham+Pk9ZFqYx3EUgqOcZJc6qRejmZP9HgQAEOqHffCWeqdX7YD/kbka3PszOE3bNQ
         31ruL9QPkmtnqgrri7bDwrRi4N+IMIcIF/djx4bpwVHgArjhPkDSg2sU91VxaXMwByj8
         evbVVL2aqgXc/rcTss5YSttf6k9ETgvf7ii19izKx3fzYiw4Cqnc5VQJPsDwvz4HGy8Y
         22VWbf3iYdZnI4SHrKRUt0Hxt40vn2KHwWq2f/2ptlC/Csc2VXlKluLHYfUCGBNuNBLo
         bmkvC7kMdx8ngUYlsEnMBjSXRm5Taor9KGX9xS7+dQc0TbneHqTcYD3zNV52ZzR9DTFd
         vLKA==
X-Gm-Message-State: AOAM530d6aILIuAWE6rmfhMxLPgy6xRJdCsC7m3UpPpA8DBAeCJf2Zob
	XnTwtzKDsMiwouDCb0wTB1VI+j33z8DyCw==
X-Google-Smtp-Source: ABdhPJzm8MM2zGWuNe27/UHNJCziiODvI6nUkNdx7zZkcXfMhgUjLLRxdkTN5BEnpr/ALDBAAD7UfA==
X-Received: by 2002:a5d:4951:: with SMTP id r17mr4903906wrs.208.1628167054769;
        Thu, 05 Aug 2021 05:37:34 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:ea47:91d3:ba71:9eb4])
        by smtp.gmail.com with ESMTPSA id a24sm2106291wmj.42.2021.08.05.05.37.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 05:37:34 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/4] process: Improve traceback error reporting from main loop
Date: Thu,  5 Aug 2021 13:37:30 +0100
Message-Id: <20210805123733.3572421-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the code can just show nothing as the exception if there was a double
fault, which in this code path is quite likely. This leads to an error log
which effectively says "it failed" with no information about how.

Improve things so we get a nice verbose traceback left in the logs/output
which is preferable to no logs.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index a0955722e3..6127fd40e6 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -26,6 +26,7 @@ import errno
 import re
 import datetime
 import pickle
+import traceback
 import bb.server.xmlrpcserver
 from bb import daemonize
 from multiprocessing import queues
@@ -217,8 +218,9 @@ class ProcessServer():
                     self.command_channel_reply.send(self.cooker.command.runCommand(command))
                     serverlog("Command Completed")
                 except Exception as e:
-                   serverlog('Exception in server main event loop running command %s (%s)' % (command, str(e)))
-                   logger.exception('Exception in server main event loop running command %s (%s)' % (command, str(e)))
+                   stack = traceback.format_exc()
+                   serverlog('Exception in server main event loop running command %s (%s)' % (command, stack))
+                   logger.exception('Exception in server main event loop running command %s (%s)' % (command, stack))
 
             if self.xmlrpc in ready:
                 self.xmlrpc.handle_requests()
-- 
2.30.2

