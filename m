Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
	[209.85.128.41])
	by mail.openembedded.org (Postfix) with ESMTP id 5824B7C89C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2019 23:11:55 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id n188so7539407wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2019 15:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=BIjisJrScdhWssdge1kN9lpDwJNm0AKAj0giMGeYSsg=;
	b=UusqDywkO/FHw/jEpBDIL/rLph9IUrOpkpFFejC2TlMv4iPIIQ+Dz3jjoFfY8kw9/R
	iUN4pSh7/AznQHAyggGADtQvPkKdfkjIdD3blpsmINMH0BgX8TWe6d9XPotYRJc4fahL
	01rXeZK8zbEq6aZsLcGcQpxKXV9pPqO6okra8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=BIjisJrScdhWssdge1kN9lpDwJNm0AKAj0giMGeYSsg=;
	b=ObqcySz2c9DR5Zoqvoz9SFad6hJTqVZEnw0GJghIV3VhiykKkG4096hlODtBEyJq+g
	iGfns+56LdFcvcdeXS/ojVSpj/26W/vVY0Y3wb9GSb5Fqj6KQoVMNmm0hqzoeouuf57I
	dExMYRTZLU7YSce3c1L1/Bn3OpQKQLVxJH/isQIpuT5a6pT+FQWrMD0W0+TUFTH2hLIM
	7BqXQbuo4FUds6c1XKjX57TjhIVfvgCTUtEK73RCxV9uH8TjvMYr2IVPU1/IjB7QBs33
	6p8e4Wo9WtoX0JxzxBEMP89O5c81wfOvJNE9JjYZKd4rLjI59ST83oKF6BAqlSk0t7tm
	aQWQ==
X-Gm-Message-State: APjAAAWOxfv6FykUVpQKP+9yWT121qWC1cBb/n/VcL5zKGoIeYaiCEoY
	U50qEJMJwnvYSxcRf8G384CR1jaXbjw=
X-Google-Smtp-Source: APXvYqzWO3QuSRujfTrhrhIGualyx8UgEvcQZ3kX2kceH9Z2FJhSAwGJItCD5uAu1pz8OFVqZt9vGg==
X-Received: by 2002:a1c:9601:: with SMTP id y1mr18080531wmd.157.1574464315740; 
	Fri, 22 Nov 2019 15:11:55 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	s11sm9238300wrr.43.2019.11.22.15.11.54
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 22 Nov 2019 15:11:55 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Nov 2019 23:11:54 +0000
Message-Id: <20191122231154.32605-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] runqueue: Fix hash equivalence duplicate tasks running
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 22 Nov 2019 23:11:55 -0000
Content-Transfer-Encoding: 8bit

The key problem is that currently running setscene tasks are not
accounted for when processing task migrations. This means can allow
two of the same task to execute at the same time with unpredictable
effects.

This change allows us to stop doing that and refactor the code slightly
to make it clearer that these conditions don't arrive even with
deferred tasks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 8622738fd9..26492e7087 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2303,16 +2303,22 @@ class RunQueueExecute:
         for tid in changed:
             if tid not in self.rqdata.runq_setscene_tids:
                 continue
+            if tid not in self.pending_migrations:
+                self.pending_migrations.add(tid)
+
+        for tid in self.pending_migrations.copy():
             if tid in self.runq_running:
+                # Too late, task already running, not much we can do now
+                self.pending_migrations.remove(tid)
                 continue
-            if tid in self.scenequeue_covered:
+
+            if tid in self.scenequeue_covered or tid in self.sq_live:
+                # Already ran this setscene task or it running
                 # Potentially risky, should we report this hash as a match?
                 logger.info("Already covered setscene for %s so ignoring rehash" % (tid))
+                self.pending_migrations.remove(tid)
                 continue
-            if tid not in self.pending_migrations:
-                self.pending_migrations.add(tid)
 
-        for tid in self.pending_migrations.copy():
             valid = True
             # Check no tasks this covers are running
             for dep in self.sqdata.sq_covered_tasks[tid]:
-- 
2.20.1


