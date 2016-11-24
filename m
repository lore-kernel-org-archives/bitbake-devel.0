Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id 41D4171B3F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:29 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id a197so110282053wmd.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=NMUtN9XlWRtVy991TgMp2/XxHuLgFfFmoVqEqgcG2hQ=;
	b=uZ+eOOlwNKOVAIs3mtxcjWOJfjF8Vm01k6wDNytM6MAp85FefFIq2DHwRKCbF06K7l
	fTrckGrBM/qSepd3KY9f4qWFYplB7sb+XxOSMsyKxBM3jH14ePQ+c9gQNb5I4wFgqJEO
	iavMoBqrZSPpADeYnGtuViEFxzDshgqSes4118W02fGxKyucDAKrmPgC2ryOjM+pi1JR
	NmOIpXZw/ZzGYXEjK/L+jfo921Y4aF6LUHD0s2uJWXXdwmUoNvXIQeHT6quMZ/+tF00/
	vtg8YgeLesHLrNuODzGY7r9FnthtbfqkxPbqmsohBullmU3CgyBxSSSsd2Aexhqvq3/t
	gZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=NMUtN9XlWRtVy991TgMp2/XxHuLgFfFmoVqEqgcG2hQ=;
	b=YfdoNHCiBarj1jmvFl0LJxfm0PDtbBk385vOLFFtBonBrkO3ft4uOGVwSwcMCRYZhL
	vYPEOGBtG/2xBw3adGl2ccE+dOTUCYdRqt/qDxfW903qTAnRW9XR9mfHPbQnBf3jjmbH
	EbGnY39t1rBGOmY3S6q8Txmir2AkHzt8ehmK9UQgpY5IRECBeAXOKBblfGtXzViW/dMa
	YLo4A6Mfw3vBPx7+llCCGku0IGx2xK0jkg+ssOUQhWJZq3e9xdjqMBCl4DsE61ow0pf8
	z5vgyxMrvQkiIq5fhYTmJebAXuDenXIrVS0P/Eemgunh02m1/Eie6+HHDANtCNLImi/T
	EKvQ==
X-Gm-Message-State: AKaTC00ohx0orCROHL6WR9LaJzVSsn8MTlB8l3vKbqbzvZ9w8chPZoQkXIg1w63aVfkohPLs
X-Received: by 10.28.196.207 with SMTP id u198mr1855241wmf.102.1479986431075; 
	Thu, 24 Nov 2016 03:20:31 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:30 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:20:01 +0000
Message-Id: <1479986406-4657-11-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 10/15] toaster: orm models Project class Fix pyflake errors
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:30 -0000

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index fd15fbe..394c886 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -38,6 +38,7 @@ import re
 import itertools
 from signal import SIGUSR1
 
+
 import logging
 logger = logging.getLogger("toaster")
 
@@ -178,24 +179,27 @@ class ProjectManager(models.Manager):
         else:
             return projects[0]
 
+
 class Project(models.Model):
-    search_allowed_fields = ['name', 'short_description', 'release__name', 'release__branch_name']
+    search_allowed_fields = ['name', 'short_description', 'release__name',
+                             'release__branch_name']
     name = models.CharField(max_length=100)
     short_description = models.CharField(max_length=50, blank=True)
     bitbake_version = models.ForeignKey('BitbakeVersion', null=True)
-    release     = models.ForeignKey("Release", null=True)
-    created     = models.DateTimeField(auto_now_add = True)
-    updated     = models.DateTimeField(auto_now = True)
+    release = models.ForeignKey("Release", null=True)
+    created = models.DateTimeField(auto_now_add=True)
+    updated = models.DateTimeField(auto_now=True)
     # This is a horrible hack; since Toaster has no "User" model available when
     # running in interactive mode, we can't reference the field here directly
-    # Instead, we keep a possible null reference to the User id, as not to force
+    # Instead, we keep a possible null reference to the User id,
+    # as not to force
     # hard links to possibly missing models
-    user_id     = models.IntegerField(null = True)
-    objects     = ProjectManager()
+    user_id = models.IntegerField(null=True)
+    objects = ProjectManager()
 
     # set to True for the project which is the default container
     # for builds initiated by the command line etc.
-    is_default  = models.BooleanField(default = False)
+    is_default= models.BooleanField(default=False)
 
     def __unicode__(self):
         return "%s (Release %s, BBV %s)" % (self.name, self.release, self.bitbake_version)
-- 
2.7.4


