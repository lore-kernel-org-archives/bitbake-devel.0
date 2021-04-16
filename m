Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.12243.1618593088838425545
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Apr 2021 10:11:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ATcTQeX9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id j5so26422057wrn.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Apr 2021 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hyz9xuF/3e92Ejf1rtruCZSE4pUjxkJBWAN28doV4oc=;
        b=ATcTQeX9K9v+SPwnSZ2LDEk8GosJ8t+7PHk4dWitRKpwldDsE0J7UMX2YaD4pxSkjw
         hClkDMhyC3rIuYAK19Xp/ZvMMKturXv1GXxTAAbGJ+1kwImwWMz9HJZ6VQnbalwR7ekH
         +qzFKCgBsTxIj35N2Pn/D29v0TsU/lZUvr71A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hyz9xuF/3e92Ejf1rtruCZSE4pUjxkJBWAN28doV4oc=;
        b=gyhoX0+VQC8OIxFTLRRB+XiGBFo0ShXqmS5zKM+VO0Bc4iTzTtRjmnDgql4L7AuUxN
         +A4vbP93nQsUmIMVQUsiplSWFFay1BN65cooQaQFxgQQ6xQx0hFGUADqgXlbRbVtHDki
         Rn6HFnp7/7pIbm3/FMKFAtZ3OcKSxGxNiSVCL5XwFzTSzsXmxfttJit5cV2Oy8ZEXTi5
         Ga1XIVy0ieYkbPyTFY0NJkD5+SGzGsSTkzSWf+fqzcNv3forT9pWdpbJA0/y4GwArOs8
         Xb7hKjrguR4EAe060KndeuIEknFmR6GyPS8I3CDKDejelHaQIIAqSY8RV4N3k3zbbEQG
         a5sw==
X-Gm-Message-State: AOAM530lEfp4R+Fy08v+L1IYPkHjOps2T1vgH3dSnc9N7TYGTsjpwzoi
	HIbYnPCxDfGrDDfR98tNuiycxYov/YyfXw==
X-Google-Smtp-Source: ABdhPJy8DLZeWWdQE7nqLY6BgdVmHZXzhozffn5vfc/7uPAb0vXwPxp5KdyHGX4pHcnNw88BnN+6aQ==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr178157wru.421.1618593087200;
        Fri, 16 Apr 2021 10:11:27 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:6910:66c9:6ed2:e889])
        by smtp.gmail.com with ESMTPSA id v185sm10368774wmb.25.2021.04.16.10.11.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 10:11:26 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] tinfoil/data_smart: Allow variable history emit() to function remotely
Date: Fri, 16 Apr 2021 18:11:25 +0100
Message-Id: <20210416171126.1373752-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can't access the emit() function of varhistory currently as the datastore parameter
isn't handled correctly, nor is the output stream. Add a custom wrapper for this
function which handles the two details correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py | 12 ++++++++++++
 lib/bb/tinfoil.py |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index dd77cdd6e2..f530cf844b 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -20,6 +20,7 @@ Commands are queued in a CommandQueue
 
 from collections import OrderedDict, defaultdict
 
+import io
 import bb.event
 import bb.cooker
 import bb.remotedata
@@ -500,6 +501,17 @@ class CommandsSync:
         d = command.remotedatastores[dsindex].varhistory
         return getattr(d, method)(*args, **kwargs)
 
+    def dataStoreConnectorVarHistCmdEmit(self, command, params):
+        dsindex = params[0]
+        var = params[1]
+        oval = params[2]
+        val = params[3]
+        d = command.remotedatastores[params[4]]
+
+        o = io.StringIO()
+        command.remotedatastores[dsindex].varhistory.emit(var, oval, val, o, d)
+        return o.getvalue()
+
     def dataStoreConnectorIncHistCmd(self, command, params):
         dsindex = params[0]
         method = params[1]
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 796a98f053..27a341541a 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -52,6 +52,10 @@ class TinfoilDataStoreConnectorVarHistory:
     def remoteCommand(self, cmd, *args, **kwargs):
         return self.tinfoil.run_command('dataStoreConnectorVarHistCmd', self.dsindex, cmd, args, kwargs)
 
+    def emit(self, var, oval, val, o, d):
+        ret = self.tinfoil.run_command('dataStoreConnectorVarHistCmdEmit', self.dsindex, var, oval, val, d.dsindex)
+        o.write(ret)
+
     def __getattr__(self, name):
         if not hasattr(bb.data_smart.VariableHistory, name):
             raise AttributeError("VariableHistory has no such method %s" % name)
-- 
2.30.2

