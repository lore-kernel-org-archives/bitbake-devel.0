Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3545C54EAA
	for <webhook@archiver.kernel.org>; Sat, 21 Jan 2023 21:23:18 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.6418.1674336191358589214
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Jan 2023 13:23:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L7kq2U6h;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id q8so6427837wmo.5
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 13:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c14Fo4Ir/YSfvMlCoKPz2sOF2fuIrWApZrh1hpKV7Vg=;
        b=L7kq2U6h01OcXG/BSS7wrvwo284TXEyzK8s6lbGuTd1A6kPSUFcbF1Oq3l3gPXWppZ
         IDKBAKmZqDCxOww2PFOfLUmSgwIwM0oZ3fkId8V8NrkBGCgseatTZynXmgbRaJhFhpNq
         mHg6Z5WEsCIi7iv6D5766CdltWjuImDGPWwks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c14Fo4Ir/YSfvMlCoKPz2sOF2fuIrWApZrh1hpKV7Vg=;
        b=gKfxXPwFiolrLjpHp/YaOnfn0/zAuqI3agdbpH0AxdEs5ijZYuqoyQFYz1Dt0Qy7K+
         HfpQzSKuvAyxKOLf5xJB3hUvElT9pauuZZ4vGDfx/tNEO44fj6FrNYmrk5bemRvXZ9Bs
         PavvBJmoIfq2cyYlBpFBgFeBi7Cvz4yZ9/eiZ1cWB7oDy18Kt2nb4Yx0Bf72Lc4FsQU7
         TkSRxIww3X1KN4lWvSFeaq1aB2v5A5kPDHEcFvPhdtjerdGvWU1N3WfA6TiLfpsfWfWS
         3N0iuMC9SxgPt+FP2K85xZRPhjgwehCJMEaBqBDT+1SRu3b7olb4cmllf12CnDyXVNF3
         EQNA==
X-Gm-Message-State: AFqh2kp1z7ne3zV0uVGW1LROn06qHUNTl+OM9WYGfhWnXmEpB2A+aCEk
	d7G88AvTITK17vMjemF9DgpfySCG3zPMtjti
X-Google-Smtp-Source: AMrXdXtaklg88+7RX7aWPi/3ICBoDQ7ynBliYPZMY9UMkQwq5Ph9mutVfHpfe2PIuySB63KxUhqVkg==
X-Received: by 2002:a05:600c:1c8b:b0:3db:fe:f84e with SMTP id k11-20020a05600c1c8b00b003db00fef84emr17856453wms.1.1674336189623;
        Sat, 21 Jan 2023 13:23:09 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f1f:fd3b:ca38:d2c5])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003da105437besm6713089wmq.29.2023.01.21.13.23.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:23:09 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 6/6] data_smart: Small optimisation to _findVar()
Date: Sat, 21 Jan 2023 21:23:05 +0000
Message-Id: <20230121212305.2171310-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230121212305.2171310-1-richard.purdie@linuxfoundation.org>
References: <20230121212305.2171310-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 21:23:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14334

Some users of _findVar don't need the override data and even
getVarFlag doesn't need it in some common cases (parsing=True).

Rearrange the code as the current overridedata approach doesn't need
to be in the _findVar code anyway. This removes some search overhead
from a critical path.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index e2c93597e5..c597dbade8 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -515,18 +515,18 @@ class DataSmart(MutableMapping):
         dest = self.dict
         while dest:
             if var in dest:
-                return dest[var], self.overridedata.get(var, None)
+                return dest[var]
 
             if "_data" not in dest:
                 break
             dest = dest["_data"]
-        return None, self.overridedata.get(var, None)
+        return None
 
     def _makeShadowCopy(self, var):
         if var in self.dict:
             return
 
-        local_var, _ = self._findVar(var)
+        local_var = self._findVar(var)
 
         if local_var:
             self.dict[var] = copy.copy(local_var)
@@ -782,10 +782,12 @@ class DataSmart(MutableMapping):
         if expand and cachename in self.expand_cache:
             return self.expand_cache[cachename].value
 
-        local_var, overridedata = self._findVar(var)
+        local_var = self._findVar(var)
         value = None
         removes = set()
-        if flag == "_content" and overridedata is not None and not parsing:
+        if flag == "_content" and not parsing:
+            overridedata = self.overridedata.get(var, None)
+        if flag == "_content" and not parsing and overridedata is not None:
             match = False
             active = {}
             self.need_overrides()
@@ -900,7 +902,7 @@ class DataSmart(MutableMapping):
     def delVarFlag(self, var, flag, **loginfo):
         self.expand_cache = {}
 
-        local_var, _ = self._findVar(var)
+        local_var = self._findVar(var)
         if not local_var:
             return
         if not var in self.dict:
@@ -943,7 +945,7 @@ class DataSmart(MutableMapping):
             self.dict[var][i] = flags[i]
 
     def getVarFlags(self, var, expand = False, internalflags=False):
-        local_var, _ = self._findVar(var)
+        local_var = self._findVar(var)
         flags = {}
 
         if local_var:
-- 
2.37.2


