Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326D2C433F5
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 18:24:28 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.13043.1645295057936754202
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 10:24:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bzi0F7Iq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id m27so8097672wrb.4
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 10:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3wWxx3gy6aJ29MvoNxBakX/HBhq0iTgz2E2B+9mZhMk=;
        b=bzi0F7IqG0RkaVnWTH5mqX44stItUxRc3IgH/eokQj3fVB705M6bmJq+u3NB2bi5NE
         6Sw/O3PJM7hXdJo2uxSnpy/uQ0mV9dyjuuxBazAX1VX1IxCyLmCQAPZ7NCs7LjBxhCHy
         /e7sRJUqfB5lM9BTLxQ90+B6KOrL4iukX6zGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3wWxx3gy6aJ29MvoNxBakX/HBhq0iTgz2E2B+9mZhMk=;
        b=ejCOffO4XGLnUtmwMmXHeSXXF5ljrPePK2hulf/RVaXT+gMXSVdIlwQObI/qm//ZZI
         AUoutcHIVOx8JGt32fPXUqCPWSvT5a4E0HnS2bCuE7T3zOpjMXK4yxX8WQiOs5bFth/J
         +3DkyPziYF+XYZIiW6wp0hcjS4HKqxNFZTXdoIfFi+SC44pNM1a84U/RkwH4HgmyKKAM
         2Qbdx/8bt9ewDhV4h7hNMH2IQZec1k0YK+e206XPabqIN34/GY/mzRyDjBSgLq8R6gQ5
         M58Sh7W9gPPE4fVsInWFAzWuWvuCBKNLVT1dwqjA460G4jH06ICDaxXGQrNHUHscHwDY
         tm/Q==
X-Gm-Message-State: AOAM533FXu+oSMeispuq/cX+M2R1DRgZwwLP+1dyIQ+8/FANByZyJNcm
	E+Rt8oVKt0HDYKgjrXQKEw1Of2IX3lXEpvlo
X-Google-Smtp-Source: 
 ABdhPJx9z6J/cdg3zaqe+utTQzY9IhTSrPgY3JIbV5yai+fwxB8i9n2w/1rq0a1+ndD1P8fq6zvrMA==
X-Received: by 2002:adf:f14e:0:b0:1e4:a64c:c1f8 with SMTP id
 y14-20020adff14e000000b001e4a64cc1f8mr10177828wro.512.1645295055999;
        Sat, 19 Feb 2022 10:24:15 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:bf04:d486:cfa0:deab])
        by smtp.gmail.com with ESMTPSA id
 z6-20020a1cf406000000b0037c4e2d3baesm2930799wma.19.2022.02.19.10.24.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 10:24:15 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: Abstract fetcher environment to a function
Date: Sat, 19 Feb 2022 18:24:14 +0000
Message-Id: <20220219182414.3083770-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 18:24:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13388

The changing of the environment inside the wget fetcher can race if
threading is used, such as with sstate in OE-Core. Abstract the function
so the environment can be correct before the function is called, removing
the race since the enviroment is then no longer changed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 11 +++++++++++
 lib/bb/fetch2/wget.py     |  9 +--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 14d3557f98..5dfe5ff360 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -851,6 +851,17 @@ FETCH_EXPORT_VARS = ['HOME', 'PATH',
                      'AWS_SECRET_ACCESS_KEY',
                      'AWS_DEFAULT_REGION']
 
+def get_fetcher_environment(d):
+    newenv = {}
+    origenv = d.getVar("BB_ORIGENV")
+    for name in bb.fetch2.FETCH_EXPORT_VARS:
+        value = d.getVar(name)
+        if not value and origenv:
+            value = origenv.getVar(name)
+        if value:
+            newenv[name] = value
+    return newenv
+
 def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
     """
     Run cmd returning the command output
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 92cc10785c..b3a3de571a 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -315,14 +315,7 @@ class Wget(FetchMethod):
         # Avoid tramping the environment too much by using bb.utils.environment
         # to scope the changes to the build_opener request, which is when the
         # environment lookups happen.
-        newenv = {}
-        origenv = d.getVar("BB_ORIGENV")
-        for name in bb.fetch2.FETCH_EXPORT_VARS:
-            value = d.getVar(name)
-            if not value and origenv:
-                value = origenv.getVar(name)
-            if value:
-                newenv[name] = value
+        newenv = bb.fetch2.get_fetcher_environment(d)
 
         with bb.utils.environment(**newenv):
             import ssl
-- 
2.32.0


