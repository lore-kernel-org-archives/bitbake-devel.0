Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 199B871C54
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Sep 2018 05:30:09 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w865UApq015919
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 5 Sep 2018 22:30:10 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Wed, 5 Sep 2018 22:30:10 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 5 Sep 2018 22:26:43 -0700
Message-ID: <2fcb85b5909ce883f418ce824261ea6bd5074fbf.1536210899.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1536210899.git.David.Reyna@windriver.com>
References: <cover.1536210899.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 4/9] toaster/widgets.py: avoid divide by zero issues
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
X-List-Received-Date: Thu, 06 Sep 2018 05:30:09 -0000
Content-Type: text/plain

From: Awais Belal <awais_belal@mentor.com>

There can be cases where the variables being used
to divide in build percentage expressions can be
zero. For example, a setup consisting of only local
repos will have repos_to_clone=0 and will generate
a divide by zero scenario.
Fix this by checking the divisor in such cases.

[YOCTO #12891]

Signed-off-by: Awais Belal <awais_belal@mentor.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/widgets.py | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index a1792d9..feef7c5 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -511,13 +511,18 @@ class MostRecentBuildsView(View):
                 buildrequest_id = build_obj.buildrequest.pk
             build['buildrequest_id'] = buildrequest_id
 
-            build['recipes_parsed_percentage'] = \
-                int((build_obj.recipes_parsed /
-                     build_obj.recipes_to_parse) * 100)
-
-            build['repos_cloned_percentage'] = \
-                int((build_obj.repos_cloned /
-                     build_obj.repos_to_clone) * 100)
+            if build_obj.recipes_to_parse > 0:
+                build['recipes_parsed_percentage'] = \
+                    int((build_obj.recipes_parsed /
+                         build_obj.recipes_to_parse) * 100)
+            else:
+                build['recipes_parsed_percentage'] = 0
+            if build_obj.repos_to_clone > 0:
+                build['repos_cloned_percentage'] = \
+                    int((build_obj.repos_cloned /
+                         build_obj.repos_to_clone) * 100)
+            else:
+                build['repos_cloned_percentage'] = 0
 
             tasks_complete_percentage = 0
             if build_obj.outcome in (Build.SUCCEEDED, Build.FAILED):
-- 
1.9.1


