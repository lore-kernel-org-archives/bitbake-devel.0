Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2788FC4332F
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 23:19:11 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.26387.1640215149933056353
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Dec 2021 15:19:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MTBfyYfJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id
 n10-20020a7bc5ca000000b00345c520d38eso1903389wmk.1
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Dec 2021 15:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SE9/0NSVvl0/SRnq8Nq6+zktHX9QCscFqIuL4w51fL8=;
        b=MTBfyYfJyUDGP3v3hoQUFzILtHnIWRMw0mZCH97faiPt/91Q9FLTj4F1XV5yEsHXPo
         WD4wERXa4wXzIHUm788Uskdi/fYaUI1ncer/TLaqXFUmkNiRaTbq6WYJi5MqB8j62yTV
         GNwQ7xsgMHx7MKhRF0Zb7UczGJl9hgNPWrtfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SE9/0NSVvl0/SRnq8Nq6+zktHX9QCscFqIuL4w51fL8=;
        b=aaHSpcxOlg7u+A6C5I9BWdcwkOzkMP3Mzjy0d01F7AforGxRh0pc27WukYDIWOmSCy
         G9E+1L6WJ6dnb6v/hNncn/LbMiXxzYDyfkCoSyOVwVDE217brlNyHLsCtacmOZ0kC5a/
         iavElfJV9r+3bKeFIVTIAotB4mXdKTceuIETj724J0nfH/eCQ6k0MU/Y446KrmAjqqxs
         1ku6tg5g7P8SDfELMu+3dqL8u/c+rn7bl4fGG1UA+lI0FWJFYSfLbhVJuGKY2RtC9dSG
         3f18MiVzmkFKQK1/SeQ06iC4lkObaJ4FNeUGz+3xXW5SjFootmks7xx8+3GO08lHKsdT
         fgOw==
X-Gm-Message-State: AOAM530fGcAv2Bi4fJLOCCEyc3LInL6jPUKc8Qrb6dLj4ruDjjz4Kjqj
	rgj1s1lh0SZaAp4pe+kkDV1XzeQU+qRtpQ==
X-Google-Smtp-Source: 
 ABdhPJxDMWsKfyndCTb6JLr7W6OWgAAoYxm8+AWzP8pNmfaoVCaJgkU+HzFkpCkDJ9nUbaviwAvq6A==
X-Received: by 2002:a1c:4644:: with SMTP id t65mr26467wma.116.1640215148093;
        Wed, 22 Dec 2021 15:19:08 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:1853:9343:6af4:2b3f])
        by smtp.gmail.com with ESMTPSA id
 n1sm3504768wrc.54.2021.12.22.15.19.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 15:19:07 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] utils: Add disable_network function
Date: Wed, 22 Dec 2021 23:19:06 +0000
Message-Id: <20211222231907.1036709-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Dec 2021 23:19:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13199

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
index d890ea832e..8006f7bd2d 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -26,6 +26,7 @@ import errno
 import signal
 import collections
 import copy
+import ctypes
 from subprocess import getstatusoutput
 from contextlib import contextmanager
 from ctypes import cdll
@@ -1594,6 +1595,36 @@ def set_process_name(name):
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


