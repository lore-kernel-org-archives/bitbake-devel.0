Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web08.38298.1615219083158931655
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Mar 2021 07:58:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dstesXlv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id u14so12013271wri.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Mar 2021 07:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=THyT2cTcSXXJeiKzBzXpXMC0cJ2I608P2ShL45+9NM4=;
        b=dstesXlvWkh+i7x82M+lRNwEQB47jqHu39SSrNju1GxbFcyCm2wGGcGLSOROJYy24/
         ggxhuSZaDQ28Q/5R/NabPEkrgwmwSNuqYZVpRmiSDJNLDxAhhdJtp4/tdjefe8qyUbil
         uAxRTenwFLKKDx5ezG0W6anssMYkvE6KhpvwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THyT2cTcSXXJeiKzBzXpXMC0cJ2I608P2ShL45+9NM4=;
        b=fZthw7R2vzm1yhLArOp3ECV4EJZz6xmc0spjvxw74LIMYx1IbM/u/UI7pD7vkvtT9d
         /zlw6MnLb+123C40aTTGoulJxcU9DCDUmhIjp4jxTx16JP8bBBcwzbMZ1RPYw0ChaQCP
         03xQZegDwFiXKAN9vjW12DixFyvdg2opjRkDbR4Q3/xnEQyfEv83eQj+dtg33r8j/5eo
         2n35wWDfpJO7iseYlgnn2DHyhayTbgddjpxh/1R1+/QUSMgM2bDHtMiC+MO2djhsmEKq
         uuEbkNEIk7qiFXhfdjzIQTXG+mHmSgzujae+n6aKnJvwyHQepYajl8DHeFW4NlpHpwKu
         EyIw==
X-Gm-Message-State: AOAM5337RtsHslsIl5+4yGClGcOlq9lFG8pto1TFZW+M6nF5j31TisFB
	S1x4/nHlSoO/LItpyLL/a1JLyaZ2QAgXZQ==
X-Google-Smtp-Source: ABdhPJxeQd+DmSi/13QZ1K3W9qwh2EEzAVgOujWYVHUZ2Dtxu1y2lcQ7gE0qkcDA6NLVNE1QUaWY4A==
X-Received: by 2002:adf:e805:: with SMTP id o5mr12262108wrm.196.1615219081666;
        Mon, 08 Mar 2021 07:58:01 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:3242:e265:217d:9509])
        by smtp.gmail.com with ESMTPSA id f7sm21711709wrm.36.2021.03.08.07.58.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:58:01 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] runqueue: Add setscene task overlap sanity check
Date: Mon,  8 Mar 2021 15:58:00 +0000
Message-Id: <20210308155800.2410990-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210308155800.2410990-1-richard.purdie@linuxfoundation.org>
References: <20210308155800.2410990-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've seen hard to debug issues where a task ends up in both the
covered and notcovered list. Add a sanity check to ensure if this
happens in future, we see it in the logs.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9934708664..714f6949e7 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1961,6 +1961,10 @@ class RunQueueExecute:
             logger.error("Scenequeue had holdoff tasks: %s" % pprint.pformat(self.holdoff_tasks))
             err = True
 
+        for tid in self.scenequeue_covered.intersection(self.scenequeue_notcovered):
+            # No task should end up in both covered and uncovered, that is a bug.
+            logger.error("Setscene task %s in both covered and notcovered." % tid)
+
         for tid in self.rqdata.runq_setscene_tids:
             if tid not in self.scenequeue_covered and tid not in self.scenequeue_notcovered:
                 err = True
-- 
2.27.0

