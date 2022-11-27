Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BFCC4332F
	for <webhook@archiver.kernel.org>; Sun, 27 Nov 2022 21:49:45 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.102311.1669585777234094632
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Nov 2022 13:49:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IjZ+NBmZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id bx10so1984618wrb.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Nov 2022 13:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FED5smfTRFglFjN1lDKQkMIpidDx7oUYW38v5BIr1cw=;
        b=IjZ+NBmZBJpHYuzZU0zjggaL8ZUbo98vP6XSxgTGALmC1Ub+uTuHk9t1YVAMR9pGag
         ct/uqknijystTJcCLBwgaaBl6n8JIR3cu7cNYFc54BeCicR8YqcKo/sxb+AWzk68JpKZ
         bxcx2+lAE6ferjThgZevZAGkgyUpJzElmpfDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FED5smfTRFglFjN1lDKQkMIpidDx7oUYW38v5BIr1cw=;
        b=aVKguz4vHnk1gzL/tr06nyFoICSMERZsvyPb6vRPb4fCpOPY4hL4uz4Ftn51ldBA+p
         Ezc176bq8rRb7WJ6M5BlbrfV74p1NRkWXFU4UfJKOsDdyS45gHeCF7sgRJXElV6JvlyQ
         VpZIRbhgHskoXjXfS+YbbtjunJfpAZgOB9G+jCehV+sL2lOoRlFo4FowrHrr/yBywjiS
         tLcJWLMQlEYkPQLI9S9SpfoUFzQ+0PjH2bhjS/P3XIGamQVKiJ2kUNgZYwcL38mhOjQl
         JMwiOhW5Z8DW1n4CEu2f7xX3s3hySUlDoIJniYbJ/QdHZT51bGyK/JR0xzh3fJr5kYBo
         WllA==
X-Gm-Message-State: ANoB5plyWKHP5q/5kJ3C+b5l6AHXG/sB7dgXQoesR57VKi6X4aiSkQ6H
	dRauJX/y3GkplJ2189N9GDMX5xMYzvhrXQ==
X-Google-Smtp-Source: AA0mqf52HPBehs7Mlb0NXIJdYIAF2lYbaqCUxzAp16KaoBsBSkguoixr0/7HeapVKL2gAgoI/o24bA==
X-Received: by 2002:adf:fc48:0:b0:236:e0d:9ad with SMTP id e8-20020adffc48000000b002360e0d09admr19136423wrs.692.1669585775354;
        Sun, 27 Nov 2022 13:49:35 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:aafe:fe4:d699:e1e9])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003b435c41103sm20577983wmo.0.2022.11.27.13.49.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 13:49:35 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH RFC] data: Evaluate the value of export/unexport/network flags
Date: Sun, 27 Nov 2022 21:49:34 +0000
Message-Id: <20221127214934.541723-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Nov 2022 21:49:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14117

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

I'm torn on this patch due to the parsing speed slow down. I'm putting the 
patch out there for discussion.

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 3799b170cb..5a89e7c9b8 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -270,7 +270,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
 
                 bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
 
-                if not the_data.getVarFlag(taskname, 'network', False):
+                if not bb.utils.to_boolean(the_data.getVarFlag(taskname, 'network')):
                     if bb.utils.is_local_uid(uid):
                         logger.debug("Attempting to disable network for %s" % taskname)
                         bb.utils.disable_network(uid, gid)
diff --git a/lib/bb/data.py b/lib/bb/data.py
index ab1a5959ba..5299315050 100644
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
@@ -374,7 +374,7 @@ def generate_dependencies(d, ignored_vars):
 
     mod_funcs = set(bb.codeparser.modulecode_deps.keys())
     keys = set(key for key in d if not key.startswith("__")) | mod_funcs
-    shelldeps = set(key for key in d.getVar("__exportlist", False) if d.getVarFlag(key, "export", False) and not d.getVarFlag(key, "unexport", False))
+    shelldeps = set(key for key in d.getVar("__exportlist", False) if bb.utils.to_boolean(d.getVarFlag(key, "export")) and not bb.utils.to_boolean(d.getVarFlag(key, "unexport")))
     varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS')
 
     deps = {}
-- 
2.34.1


