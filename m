Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com
	[209.85.223.170])
	by mail.openembedded.org (Postfix) with ESMTP id 1495D78B5F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jul 2018 15:42:13 +0000 (UTC)
Received: by mail-io0-f170.google.com with SMTP id l7-v6so11239900ioj.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Jul 2018 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=zDOR0zyyIMLQ0LGZ1ji3VWI5UKZDrDPUlK0Il9cl5j8=;
	b=b1/ZCWPemNWA40qrkUchLwJyWu16LqZ8dledkWFIWC2ZL9rfDuGADqbuYImvMTcXLc
	EeH6wiigWd0kBja8d4T+JFBOrUk2y/7OG+sNmTEt4VcxyrB7qojBPq2rzOcInOEhcrNB
	s0wSCytcDsRBT3x1PBtjnJarhFGvk8ZeijvRDogxkncYxDXXq025fOWjZfRBY9qIfa8T
	/h26xLmsXQuNuITkWz+3gsFvGE+Xrum0iDaPWEnOyqCT2rm2TujxLR7ys5w9VfFGS0dE
	wuNnzzJ7y09O0on40bE7Ak2EFscfSWkYhaoCdwgsMx6vLZu4YR+ZEyrSdWAQ4P5kIV1F
	VK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=zDOR0zyyIMLQ0LGZ1ji3VWI5UKZDrDPUlK0Il9cl5j8=;
	b=cOMV0iqd+ou0Xk9E9KCkp1fpCOljJ0ZtndUYjE4GghnLgWqc+8NS0oPkhvrW8O6iLE
	5F1gLaIN5LmbqcceA8WnrjPKf3BIjx0ZJi7tnfgnbiOvcqTg0WLKLlsYMcyNoMn7wU37
	//v5LP6FR/luKRUV181Xayjn3281e/n83IMFI1llzh9XoNUdcvrzrZ20Eh+0JVJ4NSO1
	9LkeGW0C3U/m2fn7d/jftzP0G3ykhKkLjOERJmT0YwzWEoBRItsIkc+uEHHBG8OsNSwd
	gnyBAjxDWRGMxfHZp1nzKObsJm8Y39GM/tR8jOACs7qEdfTok3HeMOECYINCn7z1pNWd
	AcOg==
X-Gm-Message-State: APt69E2kXFGQUNxHFpXY58N08AVwpEh6EuxT0my7vysGMJqFwlC1zuFr
	rR8MlKxXvB9dry7csYhPG3fezCnd
X-Google-Smtp-Source: AAOMgpcbPKTOAApgbtKZ1xARqXXt7kpSp1VKrbsTU5icLO4c7YvXvJtwr88yvYYnRL+H3Sq69BsZ+Q==
X-Received: by 2002:a6b:bd43:: with SMTP id
	n64-v6mr9339557iof.254.1530891734999; 
	Fri, 06 Jul 2018 08:42:14 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	r80-v6sm1734053ita.20.2018.07.06.08.42.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 06 Jul 2018 08:42:14 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jul 2018 10:42:00 -0500
Message-Id: <20180706154200.28769-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706154200.28769-1-JPEWhacker@gmail.com>
References: <20180706154200.28769-1-JPEWhacker@gmail.com>
Subject: [PATCH 4/4] runqueue: Stop on first unsatisfied dependency
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
X-List-Received-Date: Fri, 06 Jul 2018 15:42:14 -0000

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 8ce9ad51898..ba9bebebcfe 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1886,11 +1886,12 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 continue
             if revdep in self.runq_buildable:
                 continue
-            alldeps = 1
+            alldeps = True
             for dep in self.rqdata.runtaskentries[revdep].depends:
                 if dep not in self.runq_complete:
-                    alldeps = 0
-            if alldeps == 1:
+                    alldeps = False
+                    break
+            if alldeps:
                 self.setbuildable(revdep)
                 logger.debug(1, "Marking task %s as buildable", revdep)
 
-- 
2.17.1


