Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web12.33923.1631013355138671396
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Sep 2021 04:15:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MqVr3oYr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id d6so13205153wrc.11
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Sep 2021 04:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Mbq0l31fEdqWNPKUo9kxSbYDYH+Gpo1k49Fm67teUqw=;
        b=MqVr3oYrkNjYh5ex2csjYW7yf+YqmnNtEJERcC2/d2JRvnXSkcotm2tE13d4c0B9U7
         KGpJwpDRdUyuJ1CdlFa3ZN7a+WBWlm87T9H3yGPEi6u1hr+MhkoWajoyxQ6qzsIfrHdF
         hHKboE90jEF6jK0hhgOYR2y+6pzO/gZfICjrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mbq0l31fEdqWNPKUo9kxSbYDYH+Gpo1k49Fm67teUqw=;
        b=C/jGXNscMzv+mN81IuE6RCqG6fSVqCH/1JyQlDQh3KVtS9bwm8yg0iiscuUwJlESxO
         V6CWq7dKSjxeX1YYapOJDka91EXuMA7zwu4hg09Qg8FuIkiodOry4RZulmg9aAmjDjUa
         VW0xKGCNhhofmgiDCFtVELcOaQBw4nq008cez12Uhw4u2JsEC4h5uEFDCDWdXRthRRTg
         v1zkqwNZLyDzzjcyGntdhxb5g/yvA0TTHxwTQqK/qErAYTt8f3s1vyZorTUERO2RnAl8
         Ot/EEzOWIVEDPulPAB7JHLvs6vdGmfqr6y6gq0ABWlR+vu0ak/W/8JUCf54nUSI0hbWk
         bTIw==
X-Gm-Message-State: AOAM530cmWcGMVwmbvFWf7qVzRuam52hBmuvz521DdLqcBrvqi3hJAQW
	ixw86nCyFwa9v6ldk9bBXxI9ysx+jwtAEA==
X-Google-Smtp-Source: ABdhPJzaVAzs9pq0NmhUVWsZNjax5/p6vjepK4JRt8Lc1nKiSzj3H7/v3+y9BihdyFNdhJdVE6o3vQ==
X-Received: by 2002:adf:82b0:: with SMTP id 45mr17776011wrc.161.1631013353592;
        Tue, 07 Sep 2021 04:15:53 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:7ba0:bddf:c938:8f16])
        by smtp.gmail.com with ESMTPSA id c14sm10626695wrr.58.2021.09.07.04.15.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 04:15:53 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] runqueue: Avoid deadlock avoidance task graph corruption
Date: Tue,  7 Sep 2021 12:15:52 +0100
Message-Id: <20210907111552.1111144-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907111552.1111144-1-richard.purdie@linuxfoundation.org>
References: <20210907111552.1111144-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the deferred task deadlock avoidance code triggers, it could mark an executed
task as failed which leads to "covered and not covered" error messages. Improve
the logic so if the deadlock code is triggered, it doesn't cause the errors.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c652f3eaf7..05ca5c4e88 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2180,7 +2180,8 @@ class RunQueueExecute:
         if self.sq_deferred:
             tid = self.sq_deferred.pop(list(self.sq_deferred.keys())[0])
             logger.warning("Runqeueue deadlocked on deferred tasks, forcing task %s" % tid)
-            self.sq_task_failoutright(tid)
+            if tid not in self.runq_complete:
+                self.sq_task_failoutright(tid)
             return True
 
         if len(self.failed_tids) != 0:
-- 
2.32.0

