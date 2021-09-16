Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web08.3390.1631823774717014542
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 13:22:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Gvr98SI+;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id x6so11383436wrv.13
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Sep 2021 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8RwAxjylra7AY7NpLOf/0QMQ0QqhXSmAR2TCiNrt2s=;
        b=Gvr98SI+IfhjSb9K8hrnWh/7QQYbJCih8W3f+cT7hsQ98fkgis+1olE5+JaM4OY7wt
         rrSiGRz+eaD2C5DTDUfIUUEX8pevqXIQp8HSgd+GSEOgBxpz2oDFq6uCi+JnxeuoYjvy
         as7IutHor5VEQuQRZVshmpdkaWnmpKk1Zh5tHQBGZh7Y8gTdtaj77rYmCvWYtgAxD8bz
         NOf3S2pe+pjfy1qANYYv8kAn7IYSS5VekiFCSrjstBuNDzIjcYaeD/uDLu1zos3CQjx8
         xS0Yfx64HMsOEzkKwDCqo1VOGHNGhht8tceejUva2vHOw7m6NbThptdr7MYBpKiLmreV
         FyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8RwAxjylra7AY7NpLOf/0QMQ0QqhXSmAR2TCiNrt2s=;
        b=bO0htxR2r5NTqmUtPpW3Hk5bhsZLIQc5TXwRi4bGBG728W8niwP6zXds0fV+o+tzQO
         uBJ0P/KdIswQBE8XlzBjF1Njv19MsZq13AMtX+Mu2+djwlyWg6wJzm4Sg+E9kG/aiZcn
         0Tw06rzs77oeiBBDvjhxaAR5CzyEs4P8A50yat6Q4Z1WOtyDZQFmhc7DbQZgi0iC5oM/
         qnNZA6futhCFVggRvaef5IqL/mDJ/6iqVWjvreuc9N4QgeZCfLfdsB2PaL6SqEEGt9o1
         7CeR5piLP8ZGQMkrC0eXVuToPhlCxadEEZkY4w0NjukJMSiFdnt6FBsNoa9V5cvuu4h+
         vvvQ==
X-Gm-Message-State: AOAM5304Kqq2gQVVQ8f17BB3nePTaHbw/WvdjFqpqBHjX10+zl91vV3X
	BdabIPxBrPOuKCz6Ac6lI4EZHWC6kio=
X-Google-Smtp-Source: ABdhPJyeA5R0D/F4E3wrmieV3RyQvbOoU8VbC8b/sPOOuD9UanL18aGYtsL2Z05P6TQW4vRKpCJEeA==
X-Received: by 2002:adf:fb8f:: with SMTP id a15mr8249634wrr.92.1631823773408;
        Thu, 16 Sep 2021 13:22:53 -0700 (PDT)
Return-Path: <alex.kanavin@gmail.com>
Received: from nereus.lab.linutronix.de. (b2b-109-90-143-203.unitymedia.biz. [109.90.143.203])
        by smtp.gmail.com with ESMTPSA id q11sm8644586wmc.41.2021.09.16.13.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:22:53 -0700 (PDT)
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 7/7] bitbake: correct deprecation warning in process.py
Date: Thu, 16 Sep 2021 22:22:37 +0200
Message-Id: <20210916202237.1929584-7-alex@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916202237.1929584-1-alex@linutronix.de>
References: <20210916202237.1929584-1-alex@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index b593830cc74..8fdcc66dc77 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -661,7 +661,7 @@ class BBUIEventQueue:
         self.reader = ConnectionReader(readfd)
 
         self.t = threading.Thread()
-        self.t.setDaemon(True)
+        self.t.daemon = True
         self.t.run = self.startCallbackHandler
         self.t.start()
 
-- 
2.20.1

