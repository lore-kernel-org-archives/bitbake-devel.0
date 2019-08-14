Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
	[209.85.128.50])
	by mail.openembedded.org (Postfix) with ESMTP id AAB9F7EAC3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 15:02:51 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id v15so4888600wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 08:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=aMMBAyvcpoX7TJjxhu911WAPw8BaESM0GPGE9Tel/v8=;
	b=bVPz1eR/y+BfLiWjYhbZgaoOG8sljQQ4joJsEqbvHFJgzMNCVcM6U80nQ99mQxa20J
	QKGagh0nMklCFsfrO4TrnyjRdodlwNwDRHnLWWw2z5vd2Wow0QO2K15hSgeKnw6uJtUG
	wKjIJieaqriNGezR5oGzWWrZYfLahYqdx8gPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=aMMBAyvcpoX7TJjxhu911WAPw8BaESM0GPGE9Tel/v8=;
	b=ssIlGopKD+I3qw71I4mraEaTSIlAnELXI2hvGyF1gdy6s4MLjvlUhrYv7dv0ALRwQT
	NkSKElIKJDTIqvJSUO2B9B0tEiqTSnYq/VTiC3+xGd5cffQFuCoeqVxj8iEV/z1tn2RB
	nRl2DjfcA6cJRMxIqqBHAjmCGgEZ/Z6yNs/ojQ+xGwFzghzdfOrtf49PYauvQPXgAZmI
	iyYQqOuzVm7Nk3CG0d/N58sDuPNUt9rltqcHApklu8NN7rTrEhQX+hSODmGoxko06izE
	lOfYCrLiWC6Ht658xa3JFqUdSBWkprnUl+KnvLYDoEYzCnwzD8hceGfY13pDIUwcnXWJ
	HGaQ==
X-Gm-Message-State: APjAAAV0pKnQGHa5NBzHz5fi14FbSKhxd52XqE5Pj9Oc29K1bG/72Ivr
	/XMyL8U8xI1bsB9Xd1avWTJugusQwO4fMQ==
X-Google-Smtp-Source: APXvYqy8NMWhImpqgW1mwW9/+eLX0su3BFj+lE/ieYdIL3KwpSwqG2jR3EynBdMcQTscXudyAxyYJg==
X-Received: by 2002:a1c:a6c8:: with SMTP id p191mr8563846wme.99.1565794972240; 
	Wed, 14 Aug 2019 08:02:52 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	v65sm6165285wme.31.2019.08.14.08.02.51
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 14 Aug 2019 08:02:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Aug 2019 16:02:48 +0100
Message-Id: <20190814150250.332-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/3] runqueue: Add further debug information
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
X-List-Received-Date: Wed, 14 Aug 2019 15:02:53 -0000
Content-Transfer-Encoding: 8bit

Further testing shows we should test some extra datastructures to help pinpoint logic
errors more precisely. This adds some further data structure sanity checks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b571dde4bf..ff19564a8c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1918,6 +1918,17 @@ class RunQueueExecute:
             logger.error("Scenequeue had holdoff tasks: %s" % pprint.pformat(self.holdoff_tasks))
             err = True
 
+        for tid in self.rqdata.runq_setscene_tids:
+            if tid not in self.scenequeue_covered and tid not in self.scenequeue_notcovered:
+                err = True
+                logger.error("Setscene Task %s was never marked as covered or not covered" % tid)
+            if tid not in self.sq_buildable:
+                err = True
+                logger.error("Setscene Task %s was never marked as buildable" % tid)
+            if tid not in self.sq_running:
+                err = True
+                logger.error("Setscene Task %s was never marked as running" % tid)
+
         for x in self.rqdata.runtaskentries:
             if x not in self.tasks_covered and x not in self.tasks_notcovered:
                 logger.error("Task %s was never moved from the setscene queue" % x)
-- 
2.20.1


