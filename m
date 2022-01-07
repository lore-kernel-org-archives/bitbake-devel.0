Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB32C433EF
	for <webhook@archiver.kernel.org>; Fri,  7 Jan 2022 23:15:31 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web09.966.1641597330403080295
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Jan 2022 15:15:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MeirRVFo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id e5so4923177wmq.1
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Jan 2022 15:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZycn3QfxEmXn5jFA7Iy50xGJ8D8XUnyOx6vaccgAo8=;
        b=MeirRVFoiYTg43NotEtsG+ooD3doWFx/6E9vICikBRwHGswjG9KEQgbmx24qqCBKQ9
         Ol1Jr6H7SHwRw6PpFT9k/6RxuHjHnBecbrBwvFZVnyPds9OoQhS3/bwhkrnwm8t32Ijq
         7kKqf1Ng64fHduXP0QbmCr93nGIFxVKORsoHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZycn3QfxEmXn5jFA7Iy50xGJ8D8XUnyOx6vaccgAo8=;
        b=K7ayHInznM+y5UrriKi4hH3dAt5XeJF7jJ18/iD9SId16Ao73Xm87ar9dXiXUwJoKu
         kDp+MAnNpf7g/0CnwCU9+vWAP0jV0D+m+lWLIwsuwloaEDGMiePHscXAyugdMh+F9ZMi
         GlNyLe0PZfJ9HYeqoIfQUVZcANPvKf7Ggn2JWKCaSGr4OQYGAzuqp4pHNhNMrGtMVk6v
         DV71T5D+r7+9ZW5Ydd2btg29UBy2m9xpgU7Zjb6xsUcvj2UF49Shz6WEhI5EuT0/g2BJ
         e3eu/UsHygB28gqoPbkI3BqULYTMlg87Kmj0Ek2kmYN3tyuI2ibVg7+2+KwdWbnSx41s
         1uDA==
X-Gm-Message-State: AOAM5308N/96Z4y8HAJF9L79O+AWAJl9cndXc6phZevtMsNa1R9IigkZ
	3Ff26kW7/0Q4hIzlzLGlYIf50QoqBFa6KQ==
X-Google-Smtp-Source: 
 ABdhPJwKJIOGbU1+5njqiBGMtsf6FzQsW+x8L12FrzpuVLBLtGkmmv7odiGQgNecUK4y2Xex37sTTQ==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr7069521wmi.114.1641597328578;
        Fri, 07 Jan 2022 15:15:28 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9055:f73b:1aa9:bf82])
        by smtp.gmail.com with ESMTPSA id t6sm45147wry.84.2022.01.07.15.15.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:15:28 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] utils: Add disable_network function
Date: Fri,  7 Jan 2022 23:15:25 +0000
Message-Id: <20220107231526.1517563-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Jan 2022 23:15:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13226

Add a function which uses the unshare glibc call to disable networking
in the current process. This doesn't work on older distros/kernels
but will on more recent ones so for now we simply ignore the cases we
can't execute on. uid/gid can be passed in externally so this can
work with pseudo/fakeroot contexts.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 1a51589704..0312231933 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -27,6 +27,7 @@ import errno
 import signal
 import collections
 import copy
+import ctypes
 from subprocess import getstatusoutput
 from contextlib import contextmanager
 from ctypes import cdll
@@ -1595,6 +1596,36 @@ def set_process_name(name):
     except:
         pass
 
+def disable_network(uid=None, gid=None):
+    """
+    Disable networking in the current process if the kernel supports it, else
+    just return after logging to debug. To do this we need to create a new user
+    namespace, then map back to the original uid/gid.
+    """
+    libc = ctypes.CDLL('libc.so.6')
+
+    # From sched.h
+    # New user namespace
+    CLONE_NEWUSER = 0x10000000
+    # New network namespace
+    CLONE_NEWNET = 0x40000000
+
+    if uid is None:
+        uid = os.getuid()
+    if gid is None:
+        gid = os.getgid()
+
+    ret = libc.unshare(CLONE_NEWNET | CLONE_NEWUSER)
+    if ret != 0:
+        logger.debug("System doesn't suport disabling network without admin privs")
+        return
+    with open("/proc/self/uid_map", "w") as f:
+        f.write("%s %s 1" % (uid, uid))
+    with open("/proc/self/setgroups", "w") as f:
+        f.write("deny")
+    with open("/proc/self/gid_map", "w") as f:
+        f.write("%s %s 1" % (gid, gid))
+
 def export_proxies(d):
     """ export common proxies variables from datastore to environment """
     import os
-- 
2.32.0


