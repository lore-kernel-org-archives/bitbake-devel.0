Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544A3C636D4
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 21:37:13 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.5892.1676497032465831585
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 13:37:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Bsg9f7F/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id he5so123798wmb.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 13:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sEoWMSb1NTRNnY/4CNoAqktJrifjtXv+KZZDBzZDGKA=;
        b=Bsg9f7F/YiLovWrh2oN6IehBYFXVj+inGMlkzQoI1FEFxtJo+w0bniprgrP0sL+sp5
         y7ZvAQdU16GMttm6h25Nq+m0/adcyoqjmSzUOEoRtL0/4CWkTytb0sKP3Kxp40BScOv3
         irrzhjSYJwq5udeURrA5POQ/miMKq5R+VBafk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEoWMSb1NTRNnY/4CNoAqktJrifjtXv+KZZDBzZDGKA=;
        b=7WcUCopMGl1QqCfg/9EvegxmPEbNwvLEjBPNtTyiFQmQ9MHUkzy79L4QcwLRsaUp0O
         VjA9qnUjGnaFAkT7YbPIV/VQPppFuz7QCrAi3J3Q4UBO2mZMo14zOBvTpcm8h+2Y/gLh
         Pw6bvn/MYJ06o0keywyZpmfvJ3jKk/cIFqGjkeIY0Px2OirxsKXo/jncgWL3Jj20Ul7Q
         jPIdyYA0b58PuGXaYbagX9yNAnoKhbYot+Qh64LqazIUKkz+nZDquQo+XGA9lI2b2WqL
         YgNVQh21DoP9t5nCLbpw8/bX275qmVMwCGGAKBBrcgcJ6E9+1zWyumqo3wjrM+IySiYZ
         7e/Q==
X-Gm-Message-State: AO0yUKXVvhlnKyZX42bReAs9tAQPIBTvD5t7t9lwOSQ/ZeqVAefTwDMB
	l1S6iPnjQ32vGRyF0uZXw/n50PinM5VCIBV7
X-Google-Smtp-Source: AK7set+8TJiXLv+Fyu00WRnThyrV6zXrfsxuFBVRuuYSzO+mSkuzF6qrmuZMxEO/5/NwQaJ1qBFvOg==
X-Received: by 2002:a05:600c:91d:b0:3e2:636:24ac with SMTP id m29-20020a05600c091d00b003e2063624acmr1981888wmp.14.1676497030398;
        Wed, 15 Feb 2023 13:37:10 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d39a:5560:699e:2da6])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bca49000000b003c6bbe910fdsm3325795wml.9.2023.02.15.13.37.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:37:10 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data: Evaluate the value of export/unexport/network flags
Date: Wed, 15 Feb 2023 21:37:09 +0000
Message-Id: <20230215213709.247135-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 21:37:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14439

Currently the export/unexport/network flags are acted on only by presence
or lack of in the data store. This is deliberate due to performance reasons
since a given recipe shell task might export ~80-90 variables and this means
expanding flags for every one of them.

This does catch users unaware since values which expand to nothing don't work
e.g. ${@""} and setting values to "0" wouldn't work either.

The downside to this patch is slow down in parsing speed of around 4%.

The network flag is easier to change and doesn't affect performance, it was
made to operate the same as export/unexport for consitency reasons.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker |  2 +-
 lib/bb/data.py     | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index a3ea5d9618..d743ff5105 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -269,7 +269,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
 
                 bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
 
-                if not the_data.getVarFlag(taskname, 'network', False):
+                if not bb.utils.to_boolean(the_data.getVarFlag(taskname, 'network')):
                     if bb.utils.is_local_uid(uid):
                         logger.debug("Attempting to disable network for %s" % taskname)
                         bb.utils.disable_network(uid, gid)
diff --git a/lib/bb/data.py b/lib/bb/data.py
index f3ae062022..42445245a4 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -114,8 +114,8 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
     if d.getVarFlag(var, 'python', False) and func:
         return False
 
-    export = d.getVarFlag(var, "export", False)
-    unexport = d.getVarFlag(var, "unexport", False)
+    export = bb.utils.to_boolean(d.getVarFlag(var, "export"))
+    unexport = bb.utils.to_boolean(d.getVarFlag(var, "unexport"))
     if not all and not export and not unexport and not func:
         return False
 
@@ -188,8 +188,8 @@ def emit_env(o=sys.__stdout__, d = init(), all=False):
 
 def exported_keys(d):
     return (key for key in d.keys() if not key.startswith('__') and
-                                      d.getVarFlag(key, 'export', False) and
-                                      not d.getVarFlag(key, 'unexport', False))
+                                      bb.utils.to_boolean(d.getVarFlag(key, 'export', False)) and
+                                      not bb.utils.to_boolean(d.getVarFlag(key, 'unexport', False)))
 
 def exported_vars(d):
     k = list(exported_keys(d))
@@ -375,7 +375,7 @@ def generate_dependencies(d, ignored_vars):
 
     mod_funcs = set(bb.codeparser.modulecode_deps.keys())
     keys = set(key for key in d if not key.startswith("__")) | mod_funcs
-    shelldeps = set(key for key in d.getVar("__exportlist", False) if d.getVarFlag(key, "export", False) and not d.getVarFlag(key, "unexport", False))
+    shelldeps = set(key for key in d.getVar("__exportlist", False) if bb.utils.to_boolean(d.getVarFlag(key, "export")) and not bb.utils.to_boolean(d.getVarFlag(key, "unexport")))
     varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS')
 
     codeparserd = d.createCopy()
-- 
2.37.2


