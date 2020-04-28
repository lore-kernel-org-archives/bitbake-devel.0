Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.214.1588040247906797051
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Apr 2020 19:17:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=hVE1lUyL;
 spf=pass (domain: gmail.com, ip: 209.85.210.181, mailfrom: akuster808@gmail.com)
Received: by mail-pf1-f181.google.com with SMTP id x2so6234555pfx.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Apr 2020 19:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=8jHhs0ow/Eg2cZO+fDH/pe/IJkkg4VWnciNLqe9W2e0=;
        b=hVE1lUyLH4ws6xNfyyQy+OelV8RPC9nAGipk5Bfsu5bRg4+vNTdzWzskwxHoEwKEZV
         QpOAuo1ydrkoKQbDUX0UTprG04Yiuhukto3GgFrz5ygPrH+bh9ARJOurPoe03PGDJTYs
         y6j5PZRTw+cmc9ZlDZF0cAEPHIoRtpxu9sgWGgKHFn803Ltm95Tws8Sfv+ur2TV6t/8d
         RMPI0M6MVKI4i8DwWHNvty0jZAjXNcj8JCYzBQIWH+lX0N8wbLssBXr3NGFOTG3l0keK
         iAlQlDQo2Pinr8tyaLUZGOeJ3Q5NTNm8O4E36ax0D24Hb2ZrMlAeFHzn68zYWQRx8vlc
         2KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=8jHhs0ow/Eg2cZO+fDH/pe/IJkkg4VWnciNLqe9W2e0=;
        b=WrU47DzQcx2wYQ54EToyZHcQ/8Ejv4tleqpSy5YmlLXNAy9xnpgYQL7ePnbwkFeBz9
         j4HJJrAN/JhIwPEPxvPw5WGrrEhXVkabprjgp14Yo2ZNBJiHAS+0bKuegR+x3PHzGeTF
         JVgJV9dxr9kEKEEhdeJlEA7z+xEcDbWtGgPF2rINUCvdM5WnZXLDmUeO8PXH+yCxCF6Q
         Dvv748irSsHnOBtjcUSs6FDoaDAyQ9Ug5f9aTyWQr36JYR715V/DTwQYtO2JpNVKYV2j
         NGiwFPBd5xPxGBiyXAY1TaUtKmwZv4hm0o27AJQ9TWr8/6pyiX3t82uafirZQUyDprte
         sMFw==
X-Gm-Message-State: AGi0Pub0ojtXC6C1jBL6nvMfCvjLA1yVm6v4g9SI2ZpPHk9tWFbAeDo0
	GfJS7zFWF88y9QX/5XZ2NQg8Tnv3
X-Google-Smtp-Source: APiQypJczdIwzJyoxag0kiQpbL0sJscxaKy2stDtNocNblB3Rz+duFsaTYr0HczLwKCvr0Qyr8sFQQ==
X-Received: by 2002:a63:d60a:: with SMTP id q10mr26520964pgg.37.1588040247167;
        Mon, 27 Apr 2020 19:17:27 -0700 (PDT)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:f1bf:759e:e8cd:49cd])
        by smtp.gmail.com with ESMTPSA id c63sm9820866pfc.2.2020.04.27.19.17.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 19:17:26 -0700 (PDT)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.44 2/3] fetch2: Make fetcher_compare_revisions() work
Date: Mon, 27 Apr 2020 19:17:21 -0700
Message-Id: <226be487f58a2ab11418af9a6c909c5ba097cb1e.1587931627.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587931627.git.akuster808@gmail.com>
References: <cover.1587931627.git.akuster808@gmail.com>

From: Peter Kjellerstedt <pkj@axis.com>

This seems to have been broken for a very long time. Now it also works
regardless of BB_SRCREV_POLICY.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ffd663a8e07e2e39e8ca2d2493f4f98037c5f9e4)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/fetch2/__init__.py | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 4a781bde..14005492 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -484,17 +484,22 @@ def fetcher_init(d):
     Called to initialize the fetchers once the configuration data is known.
     Calls before this must not hit the cache.
     """
+
+    revs = bb.persist_data.persist('BB_URI_HEADREVS', d)
+    try:
+        # fetcher_init is called multiple times, so make sure we only save the
+        # revs the first time it is called.
+        if not bb.fetch2.saved_headrevs:
+            bb.fetch2.saved_headrevs = dict(revs)
+    except:
+        pass
+
     # When to drop SCM head revisions controlled by user policy
     srcrev_policy = d.getVar('BB_SRCREV_POLICY') or "clear"
     if srcrev_policy == "cache":
         logger.debug(1, "Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
     elif srcrev_policy == "clear":
         logger.debug(1, "Clearing SRCREV cache due to cache policy of: %s", srcrev_policy)
-        revs = bb.persist_data.persist('BB_URI_HEADREVS', d)
-        try:
-            bb.fetch2.saved_headrevs = revs.items()
-        except:
-            pass
         revs.clear()
     else:
         raise FetchError("Invalid SRCREV cache policy of: %s" % srcrev_policy)
@@ -513,22 +518,12 @@ def fetcher_parse_done():
 
 def fetcher_compare_revisions(d):
     """
-    Compare the revisions in the persistant cache with current values and
-    return true/false on whether they've changed.
+    Compare the revisions in the persistent cache with the saved values from
+    when bitbake was started and return true if they have changed.
     """
 
-    data = bb.persist_data.persist('BB_URI_HEADREVS', d).items()
-    data2 = bb.fetch2.saved_headrevs
-
-    changed = False
-    for key in data:
-        if key not in data2 or data2[key] != data[key]:
-            logger.debug(1, "%s changed", key)
-            changed = True
-            return True
-        else:
-            logger.debug(2, "%s did not change", key)
-    return False
+    headrevs = dict(bb.persist_data.persist('BB_URI_HEADREVS', d))
+    return headrevs != bb.fetch2.saved_headrevs
 
 def mirror_from_string(data):
     mirrors = (data or "").replace('\\n',' ').split()
-- 
2.17.1

