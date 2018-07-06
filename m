Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com
	[209.85.223.178])
	by mail.openembedded.org (Postfix) with ESMTP id B2B396093B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jul 2018 15:42:09 +0000 (UTC)
Received: by mail-io0-f178.google.com with SMTP id q4-v6so11241301iob.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Jul 2018 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=0ctFivmrG2X7JouBWZVANDuu9dx92tetX5kckAD3RCA=;
	b=uujTfbl7theLzA5/V1/pz4VKqWLEXrmqg5I7b7DCLZK4aUrKk2Srv+oB5qMdhojso6
	NvLS/WFWVY7Qyl3plXaOE08a4o/gCnEtIkGCWnXjORcVakb2aeDldQZ3SdBaZOpXmDg4
	K8E9+4TFbRqRcP+1WbdxQUUYZJRbq7DYXiYnf2BAGRsNij3aJ6cma+/OKJ2oc+Xeashz
	8XEeoBvrWX3TnwuMFDdEURrL1SGCA+QrF60gTVFLg60f/UwzC25vVhysmCSuUszAOua9
	LAOmdztWRljemicXKhcd1Zc8aIsCaFStZi0ZNmfyF00A4xVunaMqHCFklQ7y29DD6UJ4
	E9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=0ctFivmrG2X7JouBWZVANDuu9dx92tetX5kckAD3RCA=;
	b=kDZTf18F1HClq8YGkTc4yluGADhehCsCsMKKthnI3HN57D09Y5PCTSbyN9NaLyH72T
	5qZMdb+N1tQHFUF09F8ThfPjnRzuC1jh3wVMdov+B59XKgr3rISRPXXeGUQ0OnnhIasN
	z5MbLRb4QiwfybXoyVQWC7fbUR8GLbhISuqTgJlpyuvEEJYBVhwdtA95VVzuruS8J4TN
	8u+FBTwiX4AEtBvCWi6FW+jL9BYyEMnTft1Yi+Sy7DgjUumaV3XKHONVCE9I7KcLx4WG
	+TQ8FrUn5DdCLzuBklTZowT0tbl8F3j+0YnvuM7TZ/lfoOvnjApyoZ0dsEAoqkfjeBQI
	aVcg==
X-Gm-Message-State: APt69E3paEUR/D8XZsxWfzVBIBKWu0HlJvP1raT5T27ac2iOF+jMsCTl
	xCbmf+dKFIt8W8io37OSHolKm4Az
X-Google-Smtp-Source: AAOMgpetoOGBZSE/qNNEmzc2OW+AlHF3r6iWdlqe5RmtSogXFHaD/MH9SgmkVJ+djne2TGHA2iO+eQ==
X-Received: by 2002:a6b:b284:: with SMTP id
	b126-v6mr8805594iof.201.1530891730499; 
	Fri, 06 Jul 2018 08:42:10 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	r80-v6sm1734053ita.20.2018.07.06.08.42.09
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 06 Jul 2018 08:42:10 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jul 2018 10:41:59 -0500
Message-Id: <20180706154200.28769-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706154200.28769-1-JPEWhacker@gmail.com>
References: <20180706154200.28769-1-JPEWhacker@gmail.com>
Subject: [PATCH 3/4] runqueue: Remove unused variable
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
X-List-Received-Date: Fri, 06 Jul 2018 15:42:09 -0000

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 792b91a11c1..8ce9ad51898 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1892,8 +1892,6 @@ class RunQueueExecuteTasks(RunQueueExecute):
                     alldeps = 0
             if alldeps == 1:
                 self.setbuildable(revdep)
-                fn = fn_from_tid(revdep)
-                taskname = taskname_from_tid(revdep)
                 logger.debug(1, "Marking task %s as buildable", revdep)
 
     def task_complete(self, task):
-- 
2.17.1


