Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15768.1794915954457437084
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2026 03:45:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PymWsA/Q;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so19928305e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 03:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794915953; x=1795520753; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6zeE6UPkvPVr36ZGV+O724kIaiSmVJ6tPM7VBY0oEuo=;
        b=PymWsA/QWpAzpmtIjblVtLXQ7hS86kip1/yOMcKP7K7FKmHVTYrBCsX2YApQyo00P3
         2kO0QgVmPZGlRruyL7V31gkIR231z7BxaK6/ElzsOePln6ro8lB+F+Rxx3nfTHH9fcVa
         6X8cVS7wEIsET/54FqddRh6pYJK//paM1DAS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794915953; x=1795520753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6zeE6UPkvPVr36ZGV+O724kIaiSmVJ6tPM7VBY0oEuo=;
        b=zAcrTunpExY0IW7xvFM02padk0litGiJoKHUj6FlBAS8nToqPbt5g+jNLo2kh5bKXe
         QqM7xHw+WU2h4CIhodGVv0VHla5eQlwNgvdgcjlv3bGxI16a4PNWybL9SckETvZKEIyo
         BuRcOB4naxlY38aprIFMcV+SJyC2eeuS84UEYRA6+JuWFp6uzIIP5CsQPA/bWd719VYs
         /weq3J/4JBJqGIYbBGCC+diOh/C27rVld+jXmO3C1OCVn15AbVcF2/VtlvOme+91tpfX
         ueHwC/oS6SyR4+BfJUfI0kTl/EdNQ7GfHWq9BOYxjdKbg/GDJ/viflEzLfm8rzZ5mKKl
         /+6A==
X-Gm-Message-State: APuU4Z9oStM2Fzfr3ZiNPZBnwUi8Vm/gUgc9MwsIL6BDZqUAjc9dXUtq
	VdlVZyNbcxdXE3RrnzbvXI6+Oi3b49jWA21TbvD3SvT8g2YCbW6l3yKKjfnZlua2qB+4ZlGOC26
	270t06t4=
X-Gm-Gg: AYBFou1IdDnsi99RuXBUvDzQXnvraSbo0cO9yQFRK2JVFubOb0yCI4KCcYuejMN7yRE
	PoeODuTLgav5YOkCkFNdHoSEQMB9TdRrGJgqWCHeEftVWpSX1eUOHg2XZnVMNV6SLpq17gcC/om
	WxrUzafDvzXMiLbe426QS7jv1FBU+eIA1NzGGr3MyfmDhkz/l14mENQeXklwcB5UrY/n0pW+WwP
	hMTEXjOEb1jWrw8aGmIZ0wOcYN3DHamXUQwzk6YmFZmal0EEdhx7Q/oK1Kh0a4UpeYyM8UR3qkY
	Ytihj5wrX0GOQsuyrFfOdvj1tyqowwAK8+Pa5WV6NPzll1wGJBK1VuBf3KdsjEhwslGMTBpSYw/
	+jqckqiZzNXDok47IrZjpaCpDR2uj4CN2Q7y1v/l/11NjJoH2vtM9MvW2xq8iGaA3Ga2Mn0e82U
	8Cbu7VuX5Trp7r8RZmzliMvabS4rKIWrnl/0P+5XVg95a9JnmOtGGNP7qWDh2ky1h72ZuTcdX01
	/rntRsQJhfouyZeiHA61N0kmF5p9bofbEetSMAOSB3jPfyizG8Q1s/aJ1wfm5RoJ4a5obsz43FU
	2Yh2SeoESvoexu5I2cMIGtCug/eNzGy7C+YzDeFXeuy/Ly7wawCKWXXEPA==
X-Received: by 2002:a05:600c:154a:b0:4bb:6a5a:7824 with SMTP id 5b1f17b1804b1-4bb6a5a798emr159338105e9.30.1794915952693;
        Tue, 17 Nov 2026 03:45:52 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5769:a004:a5af:24bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7ad9426asm23650525e9.4.2026.11.17.03.45.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:45:52 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] runqueue: Fix deadlocked task issue for multiconfigs
Date: Tue, 17 Nov 2026 11:45:49 +0000
Message-ID: <20261117114550.2306278-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117114550.2306278-1-richard.purdie@linuxfoundation.org>
References: <20261117114550.2306278-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 11:45:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20446
Content-Type: text/plain; charset="utf-8"

Some builds were showing large numbers of deadlocked tasks. I tracked this
down to the case where there is a large amount of sstate available and tasks
are able to be skipped even though they were deferred.

If a task was deferred and skipped, it was left in the deferred list. Fix
this by adding a case in the handling code and removing such tasks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 4f80f1fde21..501fb92dc49 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2117,7 +2117,11 @@ class RunQueueExecute:
 
         found = None
         for t in sort_tids_by_mc(self.sq_deferred.copy(), self.sqdata.multiconfigs):
-            if self.sq_deferred[t] == task:
+            if t == task:
+                # The deferred task was probably skipped, we can just remove it from the queue
+                del self.sq_deferred[t]
+                update_scenequeue_data([t], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
+            elif self.sq_deferred[t] == task:
                 # Allow the next deferred task to run. Any other deferred tasks should be deferred after that task.
                 # We shouldn't allow all to run at once as it is prone to races.
                 if not found:
