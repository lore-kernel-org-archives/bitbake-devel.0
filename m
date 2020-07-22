Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web12.28151.1595449579510556888
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jul 2020 13:26:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=I30WHSUs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id 88so3119170wrh.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Jul 2020 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=74IK3atPs0ty3Vp/kGEqrhcUPqn+ITZ25/hPWO0D+hs=;
        b=I30WHSUs5oZM2ohkNWFYdXJ6cLyi1hQVHObI+765e8at/OKdsby1GEeZiXRseJtx8Q
         O26PqGa+3wt4PHBSZf8XG7QRXV216hF1O0UJzNG4EAFEDDUhHGDszEPHT56nKEtPxwJi
         2Do8Gus0feXblBnx75o9aKRvEuJRPxf91q8J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=74IK3atPs0ty3Vp/kGEqrhcUPqn+ITZ25/hPWO0D+hs=;
        b=ByPa5R0nTKUrn4LOiMw4ehtvhRSoZCNr1h6uSyJytykVEdn0s7mbCx21yKZBA9D3aj
         oGFlIgvhRcHJMocJu5I4ZGpzgsy7EiD3XN33X/wtgqK0F2DfApHuQkMua/KfCQVq8Nq+
         A02UHIUznEUd6drxgmvnawFcYwYdoGXEx5ifEBzGRxVawTNOspAi6WHCTRCqBXxvN0LZ
         WOCQ2LPjqQoW8bQyZHz8aCsEwO5++XkKGxkAwqlBgojlw/1jpLMCm+ivK4mnYM5FzN2g
         6nc+4KBtGja1GhJI04O8ks7qO7ecYR/CYqSuO8IcM9QCHN/FC/1VW5kmECuLjKHDx4gJ
         SIlw==
X-Gm-Message-State: AOAM5332tUbkfMCVJKU/PjWrlFrXyXz6nVpLPTZ8dVeHYSKFNT6//Y9l
	8yXlN9gGsTQW9c1f1U2/TxAwXToWMaZwjw==
X-Google-Smtp-Source: ABdhPJwo5nUOXnQgtjsImHYymIP+ZO0gbH6qdFuN482It5CtOA21ddqU4pQzdyKPibBrWePZVPeYNA==
X-Received: by 2002:adf:a15c:: with SMTP id r28mr1044437wrr.151.1595449577352;
        Wed, 22 Jul 2020 13:26:17 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (f.a.5.c.a.d.d.d.3.0.d.d.c.1.8.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:981c:dd03:ddda:c5af])
        by smtp.gmail.com with ESMTPSA id w14sm1087744wrt.55.2020.07.22.13.26.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 13:26:16 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] cooker: Improve multiconfig configuration error reporting
Date: Wed, 22 Jul 2020 21:26:14 +0100
Message-Id: <20200722202615.164870-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This avoids a traceback if an invalid multiconfig is referenced in the bitbake
commandline and tweaks the message to make it more understanable.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 3a58a3a332..19ddc1d3ba 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -626,6 +626,7 @@ class BBCooker:
         current = 0
         runlist = []
         for k in fulltargetlist:
+            origk = k
             mc = ""
             if k.startswith("mc:"):
                 mc = k.split(":")[1]
@@ -635,6 +636,10 @@ class BBCooker:
                 k2 = k.split(":do_")
                 k = k2[0]
                 ktask = k2[1]
+
+            if mc not in self.multiconfigs:
+                 bb.fatal("Multiconfig dependency %s depends on nonexistent multiconfig configuration named %s" % (origk, mc))
+
             taskdata[mc].add_provider(localdata[mc], self.recipecaches[mc], k)
             current += 1
             if not ktask.startswith("do_"):
@@ -670,7 +675,7 @@ class BBCooker:
                         l = k.split(':')
                         depmc = l[2]
                         if depmc not in self.multiconfigs:
-                            bb.fatal("Multiconfig dependency %s depends on nonexistent mc configuration %s" % (k,depmc))
+                            bb.fatal("Multiconfig dependency %s depends on nonexistent multiconfig configuration named configuration %s" % (k,depmc))
                         else:
                             logger.debug(1, "Adding providers for multiconfig dependency %s" % l[3])
                             taskdata[depmc].add_provider(localdata[depmc], self.recipecaches[depmc], l[3])
-- 
2.25.1

