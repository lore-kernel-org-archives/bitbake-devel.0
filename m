Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by mail.openembedded.org (Postfix) with ESMTP id 7B93C61C12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Mar 2020 23:28:56 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id h8so3790549iob.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Mar 2020 16:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jDGyVuxkoAnm9OB0gdYStUIy4dbXtoNRptBL2rBM1+8=;
	b=AHD4LqkwLpxlHPxG0YM/y4kgOWtMVo4d7SQHojgGVAMnMU/9PxSWpY+sKPGo8zXJtq
	fHuR2qgk1Giqaozk2wxNY9d82iPHo8bnxmpggBL94qSO2LGmnycrgrl9aq2RP1ECFn+3
	rBpBy/Uv36SkQDcpqWJCfLDBthGkdpcG+QB2OvdSF/ZOKeP2NNinXVBLDPBQBiRVyXhB
	odcZFJpxeLebYLxAMvvochhcKMzKI986Yx0jPOQwyLCm3lN5hm4vJfK2HmRy7UdVwXl7
	x991IZzygDMSnhsUfEMqrQQbToNeTXuLBn0RfHnSMRjo7i959IezAT6bGXluPc5yREPY
	7XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jDGyVuxkoAnm9OB0gdYStUIy4dbXtoNRptBL2rBM1+8=;
	b=r+F00QFA2hdW5CzA7a7eFR5gB45kUBQPaj303QcKmMcTnWG2HYPdEycIUG2Xo0v4j/
	R/XDiazEaj2gYgYpjmBjOS+ieivsYb0OJ6eVyUwYHRoKrwUrsBqGNRUN3luqcygU0dnx
	ByFOfmcHkDVtdhiKfViYKEB+uYOUZd4Y+1Bg3ueVjwOy/JaIhP+6CBIxu7+Gb1QLUuYm
	fW71eUCow0cJZpJEO8bd1Cn1n7Z4nHWj74uTu5OiQPHt4UlvRDp9RKFP8/r5lf+sNX4J
	3zkNTdiRfgP/TKA19NcIercehwZ1LcuX1+zeGT6/q1GOEKQOLrMVfsAI/zqeF+3ggQCE
	Bg/Q==
X-Gm-Message-State: ANhLgQ1JYgtwTeud0GU3RHKtTWo5v9lOYaSa43RSBx0iHv9YlbsVpw1s
	IToDmKwRPU7oXz72txm8s1/udy3kN74=
X-Google-Smtp-Source: ADFU+vuorYVpLfILx1VAjhKyeKsxDKMZqXXhtTfdpLhuYbYDzi9cQghm1x6Rh7MiAkVyHxyVf+SFeA==
X-Received: by 2002:a6b:c045:: with SMTP id q66mr5167932iof.10.1583969336064; 
	Wed, 11 Mar 2020 16:28:56 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id w3sm3297603ior.55.2020.03.11.16.28.55
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 11 Mar 2020 16:28:55 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Mar 2020 18:28:47 -0500
Message-Id: <20200311232847.2874-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311232847.2874-1-JPEWhacker@gmail.com>
References: <20200311232847.2874-1-JPEWhacker@gmail.com>
Subject: [PATCH 4/4] bitbake: runqueue: Lower setscene complete logging level
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
X-List-Received-Date: Wed, 11 Mar 2020 23:28:56 -0000

Lowers the level of the log message when setscene tasks have completed.
This message can occur multiple times when hash equivalence is enabled,
since the runqueue switches between executing setscene tasks and normal
tasks. Since this is primarily of use when debugging hash equivalence,
use the hash equivalence logger at VERBOSE level.

[YOCTO #13813]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index cef9b0fbbf..16f076f3b1 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -2059,7 +2059,7 @@ class RunQueueExecute:
         self.update_holdofftasks()
 
         if not self.sq_live and not self.sqdone and not self.sq_deferred and not self.updated_taskhash_queue and not self.holdoff_tasks:
-            logger.info("Setscene tasks completed")
+            hashequiv_logger.verbose("Setscene tasks completed")
 
             err = self.summarise_scenequeue_errors()
             if err:
-- 
2.17.1


