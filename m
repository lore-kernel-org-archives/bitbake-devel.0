Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD05C53210
	for <webhook@archiver.kernel.org>; Sat, 31 Dec 2022 16:59:02 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.45727.1672505937825932764
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 31 Dec 2022 08:58:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PlKLGLgA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id ay40so17541915wmb.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 08:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wuK2FZRia/8yhVlRsgd6JACcbt/mEBKwKZyw+Ww6Ibs=;
        b=PlKLGLgAkgtm0/xdnkG0D/zk8HhdnfZrn5t2x2OMl6Tki55GHlmZN+ff2E+UxjQ5vS
         zvV/eqYBom+t89bagJW16PkhnGZn31fVEsInl35/kdHT1u808zsBuygmh0UtN3AP/MQh
         LjiDiYLbHdXgWBNAY3rRD31s8VasMd5DUmvZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuK2FZRia/8yhVlRsgd6JACcbt/mEBKwKZyw+Ww6Ibs=;
        b=u2352PR37ZZjF4gkKI1c0fYRDhKGq1tG6eXEVC4ZKbpFkpbg4n6rCK4H3mxra45bad
         lIx9ZxxrFg+YNX9XATQPLkLJFCUMq9yky7uiGJU2qr5i9Ks9UFBADbPLUp/sCFnWLfyL
         DgFyNmIdyzS3rUBsRp2MEaDAorn0cutboSI4SivLhiMQ15o5dFIQl6dRX5/IqaN202ND
         itLSzbriZYmWKNggaNiIuiyr5+3nbQVbzZAhkbGlwN50IKbkbfrcI9wPHr5PxZRErToO
         c/JmAh52BWSyhWwoaLPCSYiipjABCHQfQ2dD2ftvdd/9gDgbnPg/OWG9T6SDVCvgGSWJ
         MiVw==
X-Gm-Message-State: AFqh2kpK/Zgc68VWM925jzF/KKwcnggFtAmRC/Mr2cRSMHnJc8OeTzd4
	tb+siHP3Dk1kEpGuTYO6lzhTLij1Fhkv6p+9
X-Google-Smtp-Source: AMrXdXv9s8hzEB/lvQhDojGCwj1kGs6KdvcNDZOrzPVEe8PgfHDW1UrqRKNLwtmPFy3fTm2aP+Qtvw==
X-Received: by 2002:a1c:6a14:0:b0:3d1:f302:1975 with SMTP id f20-20020a1c6a14000000b003d1f3021975mr25127110wmc.33.1672505936192;
        Sat, 31 Dec 2022 08:58:56 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1a1f:74ee:21ca:3bb])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003b47b80cec3sm36582812wmq.42.2022.12.31.08.58.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:58:55 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 09/11] server/process: Add locking around idle functions accesses
Date: Sat, 31 Dec 2022 16:58:47 +0000
Message-Id: <20221231165849.964169-10-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
References: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 16:59:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14270

In preparation for adding splitting bitbakes work into two threads,
add locking around the idle functions list accesses.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 5acc105e08..2aee9ef051 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -93,6 +93,7 @@ class ProcessServer():
         self.xmlrpc = False
 
         self._idlefuns = {}
+        self._idlefuncsLock = threading.Lock()
 
         self.bitbake_lock = lock
         self.bitbake_lock_name = lockname
@@ -109,7 +110,8 @@ class ProcessServer():
     def register_idle_function(self, function, data):
         """Register a function to be called while the server is idle"""
         assert hasattr(function, '__call__')
-        self._idlefuns[function] = data
+        with self._idlefuncsLock:
+            self._idlefuns[function] = data
         serverlog("Registering idle function %s" % str(function))
 
     def run(self):
@@ -358,21 +360,28 @@ class ProcessServer():
                 serverlog("".join(msg))
 
     def idle_commands(self, delay, fds=None):
+        def remove_idle_func(function):
+            with self._idlefuncsLock:
+                del self._idlefuns[function]
+
         nextsleep = delay
         if not fds:
             fds = []
 
-        for function, data in list(self._idlefuns.items()):
+        with self._idlefuncsLock:
+            items = list(self._idlefuns.items())
+
+        for function, data in items:
             try:
                 retval = function(self, data, False)
                 if isinstance(retval, idleFinish):
                     serverlog("Removing idle function %s at idleFinish" % str(function))
-                    del self._idlefuns[function]
+                    remove_idle_func(function)
                     self.cooker.command.finishAsyncCommand(retval.msg)
                     nextsleep = None
                 elif retval is False:
                     serverlog("Removing idle function %s" % str(function))
-                    del self._idlefuns[function]
+                    remove_idle_func(function)
                     nextsleep = None
                 elif retval is True:
                     nextsleep = None
@@ -388,7 +397,7 @@ class ProcessServer():
             except Exception as exc:
                 if not isinstance(exc, bb.BBHandledException):
                     logger.exception('Running idle function')
-                del self._idlefuns[function]
+                remove_idle_func(function)
                 serverlog("Exception %s broke the idle_thread, exiting" % traceback.format_exc())
                 self.quit = True
 
-- 
2.37.2


