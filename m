Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web12.1029.1598288024109989159
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 09:53:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JFuQ/Jhu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id o21so8860017wmc.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DfqrYoTZNOa8BWEBU3fo0N8QQnxDC49KMBGlIlQu+Lc=;
        b=JFuQ/Jhu8k4Dn7vjKaYarqAJMI6jyPvyCqWMvxMAGYgIqDQHcNKPaDReNMkMiNMVNY
         9d+0HYvXBkAro6q4R1l4cRC0Dh137witYkpQ+gAwnR617gN+ci0PmqbRWfG1Zult8djc
         I299qWmuPVZ7Y7AD/3isNM/Vq1sHlQ3ohu/cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfqrYoTZNOa8BWEBU3fo0N8QQnxDC49KMBGlIlQu+Lc=;
        b=QXjPsXY6xomzAQvlnRlzzTJfTCUSKZdhDX0sS9M3JUoQgjU5HrMV7dDh+/HTso84pN
         VYPKRDINmNPKRr6rw9tqwOvcTofnkytnwI86aeQ7p5eN0WgMXA8N3Y34M98DYAKB1MpH
         4bD/cmSy7BDTv3sG/UWlVoLr5TMslZCsWni+7T8/S4aoPM5ZOPid1L1X4R0LgNXHL5j5
         SPyP2HX0FCK3Ltsv1rINdD9r3ichAIx8xfrI0c0I7Yf1UvC/rXpEqGd/lsPzlj4erGez
         UdBpTvTUfGiGC3qu2DZ+b7PemfpspdYfsejuAlgcpXESc6P5ZtyvY2uanuPUh0qzaG90
         kHhA==
X-Gm-Message-State: AOAM532swDZUyvKBrJPMWBPSAIL9KYFvfKKgs8jFUWo09C/YR/Y2hRNq
	BfheQISz/qHrvPdHBkO8r2J1GCTHQ44CVUxW
X-Google-Smtp-Source: ABdhPJzmArdsukHnwcQhqV9fjthG0EwHybFO7BYks2NIdfOLN19H6C4krO2AQwYQGRk5RPQPIruoWA==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr151165wmb.173.1598288018395;
        Mon, 24 Aug 2020 09:53:38 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id f19sm182127wmh.44.2020.08.24.09.53.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:53:37 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 08/10] cooker: Ensure BB_ORIGENV is updated by changes to configuration.env
Date: Mon, 24 Aug 2020 17:53:29 +0100
Message-Id: <20200824165331.1373725-8-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
References: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes to configuration.env were not updating BB_ORIGENV, fix this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 99605e5844..754303813b 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -458,6 +458,12 @@ class BBCooker:
         bb.msg.loggerDefaultLogLevel = self.configuration.default_loglevel
         bb.msg.loggerDefaultDomains = self.configuration.debug_domains
 
+        if hasattr(self, "data"):
+            origenv = bb.data.init()
+            for k in environment:
+                origenv.setVar(k, environment[k])
+            self.data.setVar("BB_ORIGENV", origenv)
+
         for k in bb.utils.approved_variables():
             if k in environment and k not in self.configuration.env:
                 logger.debug(1, "Updating new environment variable %s to %s" % (k, environment[k]))
-- 
2.25.1

