Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 81FBA77114
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 20:27:22 +0000 (UTC)
Received: by padcn9 with SMTP id cn9so32586895pad.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=WnJ4ysdaaFPyd/smzw4tMz/fuDLb7zA0gAW5xe69PrM=;
	b=C+u7SZ4apnDzj0Z0pmZlxty8+aUtFTH6uXtyemU6/DRjOg5H1EMyD9ComF+l9Nyizi
	0VzlChmRhItQXvXSm/idPPTMHBPRH22J6un+F0/VUCdehMJFq291BI8V5LzTKA5xNO5K
	Vhv8qqripE8EsDyXYTQJjGPGJxoBIqEeAVS7PeyAj7C0bWf2mzO0qGPScLqY+OjXe1/B
	6CruNi0P7yDtB3c1DJWF4Qon0VU2/uYo5plrpiWfgWvwA+73U+J0Xgqh0bpZkZwq2NsA
	wCh12ycZiOW4wCoXcH5/Sc5QVO5SAlA5SqOGnhhx/HaHDP6VGcKR63B5BwoTqnSs6dwX
	wT4A==
X-Received: by 10.66.147.74 with SMTP id ti10mr5664830pab.88.1444854442592;
	Wed, 14 Oct 2015 13:27:22 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ce3sm11236656pbb.35.2015.10.14.13.27.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 14 Oct 2015 13:27:21 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 13:29:17 -0700
Message-Id: <f08b7a75c711bbb9cd59d4343c871fd499ec9a17.1444854417.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20dd08f325d8ef8c81e951a92979cf98b0a2b905.1444854417.git.avery.brian@gmail.com>
References: <20dd08f325d8ef8c81e951a92979cf98b0a2b905.1444854417.git.avery.brian@gmail.com>
In-Reply-To: <cover.1444854417.git.avery.brian@gmail.com>
References: <cover.1444854417.git.avery.brian@gmail.com>
Subject: [PATCH 09/10] toaster: Exclude "command line builds" project from projects typeahead
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
X-List-Received-Date: Wed, 14 Oct 2015 20:27:22 -0000

From: Elliot Smith <elliot.smith@intel.com>

The "New build" drop-down provides autocomplete for Toaster projects.

However, it should not include the default project (for command
line builds), as it should not be possible for the user to
select this project as the container for a Toaster build.

[YOCTO #8231]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/typeaheads.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/typeaheads.py b/lib/toaster/toastergui/typeaheads.py
index 9db3182..dd4b7f5 100644
--- a/lib/toaster/toastergui/typeaheads.py
+++ b/lib/toaster/toastergui/typeaheads.py
@@ -121,12 +121,12 @@ class RecipesTypeAhead(ToasterTypeAhead):
         return results
 
 class ProjectsTypeAhead(ToasterTypeAhead):
-    """ Typeahead for all the projects """
+    """ Typeahead for all the projects, except for command line builds """
     def __init__(self):
         super(ProjectsTypeAhead, self).__init__()
 
     def apply_search(self, search_term, prj, request):
-        projects = Project.objects.all().order_by("name")
+        projects = Project.objects.exclude(is_default=True).order_by("name")
 
         primary_results = projects.filter(name__istartswith=search_term)
         secondary_results = projects.filter(name__icontains=search_term).exclude(pk__in=primary_results)
-- 
1.9.1


