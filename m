Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 530FA731F7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:22:46 +0000 (UTC)
Received: by mail-pa0-f41.google.com with SMTP id oz2so22896302pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=hE84opXUlz6QOr9j5g8piBc4er1AoCZlLqVZ+N5AjfM=;
	b=RQ7rl7xU2OjXc9fG0MPjUp5XqgmyKJLbLlGHUvOLEe8qeXaxi3Z8GRrLZ6k207Mp1Q
	Q9vt9AtPqp7Tcuh6cpnaU7EA6J6UKU5Fv1AEA1quoy8X9UikVCaJBdkuojF/zKgVtAkr
	AHS3QxKjIErpmnHJ3IyG03T33jKofCkoyrM4AkfmvBf2fw4Ku4TbJZdPgV8tNxzCmMrD
	nXzdbnJqX+Lp/OAr5mzefTMep8S8hZDSb9QyDgfhTQQzt9F+/3PQ7ZIT90+nv8ioWyE+
	D0gUbxGEEPFMqACK9Wc3nQJ9ZcC+OWTZPs9dpbrTeja+vShPDQZhPjGOfxj8S3r+P9hE
	X8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=hE84opXUlz6QOr9j5g8piBc4er1AoCZlLqVZ+N5AjfM=;
	b=Ae36nVa7bEfkk2TlDpfENQCDcUwVWu8cGydRZ94/Xl6ZCiXqGfEyEFc9nZun6QS1B1
	R9Ypbjmlyy2bkaApiTkjyWieaGyNYdmBl54w983KUbhDi39UUAIEWuT9C0Lvi5pRGV7I
	LuEsjEYl1bYZuUllLceXFM72Gw/zNnivk5G6k7M2kefsUo1lYLtk7jxGEdvp+u8JEeq8
	jEiOObVPOSDDNEKJDAkbN9Hg+d27w9DmcYc/j0mnNVOKJxy6e17mHJVKmM9xM+bGtixD
	att4MCXvOoyzGBLuqSQuDzgX0m7t4Uvq68rMd359LFZECWGH/35rZiHw7uhbAy0JPEni
	c9jA==
X-Gm-Message-State: AE9vXwPijEC1wQUzS+R4/luXrwPAuN+JTV4TPPMvzwm2YSjQfiJ+zbN5gOQC5ohUXu7fq54C
X-Received: by 10.66.7.8 with SMTP id f8mr24307813paa.91.1474042967342;
	Fri, 16 Sep 2016 09:22:47 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	bm8sm13336146pac.16.2016.09.16.09.22.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 09:22:46 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2016 17:22:29 +0100
Message-Id: <1474042955-12618-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
References: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 2/8] toaster: implement signal_runbuilds function
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
X-List-Received-Date: Fri, 16 Sep 2016 16:22:47 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This function reads pid of runbuilds process from
BUILDDIR/.runbuilds.pid and sends SIGUSR1 to it. signal_runbuilds
function will be used in Toaster code to notify runbuilds when
build is scheduled, finished or cancelled.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 8ee0c87..38d014a 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -33,9 +33,10 @@ from django.conf import settings
 import django.db.models.signals
 
 import sys
-import os.path
+import os
 import re
 import itertools
+from signal import SIGUSR1
 
 import logging
 logger = logging.getLogger("toaster")
@@ -1736,6 +1737,11 @@ def invalidate_cache(**kwargs):
     except Exception as e:
       logger.warning("Problem with cache backend: Failed to clear cache: %s" % e)
 
+def signal_runbuilds():
+    """Send SIGUSR1 to runbuilds process"""
+    with open(os.path.join(os.getenv('BUILDDIR'), '.runbuilds.pid')) as pidf:
+        os.kill(int(pidf.read()), SIGUSR1)
+
 django.db.models.signals.post_save.connect(invalidate_cache)
 django.db.models.signals.post_delete.connect(invalidate_cache)
 django.db.models.signals.m2m_changed.connect(invalidate_cache)
-- 
2.7.4


