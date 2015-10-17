Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 0BE4277133
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 17:43:45 +0000 (UTC)
Received: by pacfv9 with SMTP id fv9so52243544pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 10:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=stmSoFI40PqTJp5Au6G5td4q8Y8UPr22w1EVosuRfzQ=;
	b=WNGt9AbkObzqflS6F/eAX6TLO5ah/wZhU5z6N9SLk9XoeYLx2rgNvDfVRYaZasD708
	r/EN8ldsafRR5MYbbVNAh6jv3SDi/WMjRZuZsKlkaiHOGndSJsA1uHig3WoWP2BoJEC2
	Yco8LKfP8ueFDwgaCUv+DB928e7r2JqO4hjkyYRTwuqrbGGKXQXM9tB6etNGslq97ayV
	qq3kbhUM+ZbhpO+FTsMvGhsnT4gyxVOsYYe99ATQRbJRJDnWpinyYAlmg/5ExUBUi6qj
	kiB9nkPwxJPTTYu8RI/Iyjgo3C2T3eVMXedvBdHrRKY0I6M6qN2ARN1Kl9VW8CnRiEde
	t68A==
X-Received: by 10.66.144.135 with SMTP id sm7mr24568654pab.106.1445103826213; 
	Sat, 17 Oct 2015 10:43:46 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	bn1sm27888794pad.17.2015.10.17.10.43.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 17 Oct 2015 10:43:45 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 17 Oct 2015 10:45:51 -0700
Message-Id: <cfa320617f75b3dae5699b59906840e61c306576.1445103849.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <27aab0077a5ef4f49d5b1f3a94f7872836054ad4.1445103849.git.avery.brian@gmail.com>
References: <27aab0077a5ef4f49d5b1f3a94f7872836054ad4.1445103849.git.avery.brian@gmail.com>
In-Reply-To: <cover.1445103849.git.avery.brian@gmail.com>
References: <cover.1445103849.git.avery.brian@gmail.com>
Subject: [PATCH 4/6] toaster: Hide builds for non-cli projects in analysis mode
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
X-List-Received-Date: Sat, 17 Oct 2015 17:43:46 -0000

From: Elliot Smith <elliot.smith@intel.com>

The "latest builds" sections of the "all builds" page
show builds for all projects. This is not appropriate
for analysis mode, where we can only affect the command-line
builds project.

Modify the "latest builds" section to only show builds for
the command line builds project if in analysis mode.

Also rationalise where we get the queryset of latest builds from:
we have a _get_latest_builds() function which was being used
to get the latest builds in most places, but not all.

Also modify _get_latest_builds() to sort by started_on, rather
than primary key, as assuming that a higher primary key value equates
with later start time is incorrect.

[YOCTO #8514]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/views.py | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 10bbef5..d675f4f 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -92,9 +92,12 @@ def _get_latest_builds(prj=None):
     if prj is not None:
         queryset = queryset.filter(project = prj)
 
+    if not toastermain.settings.BUILD_MODE:
+        queryset = queryset.exclude(project__is_default=False)
+
     return list(itertools.chain(
-        queryset.filter(outcome=Build.IN_PROGRESS).order_by("-pk"),
-        queryset.filter(outcome__lt=Build.IN_PROGRESS).order_by("-pk")[:3] ))
+        queryset.filter(outcome=Build.IN_PROGRESS).order_by("-started_on"),
+        queryset.filter(outcome__lt=Build.IN_PROGRESS).order_by("-started_on")[:3] ))
 
 
 # a JSON-able dict of recent builds; for use in the Project page, xhr_ updates,  and other places, as needed
@@ -1926,6 +1929,11 @@ if True:
 
         queryset = Build.objects.all()
 
+        # if in analysis mode, exclude builds for all projects except
+        # command line builds
+        if not toastermain.settings.BUILD_MODE:
+            queryset = queryset.exclude(project__is_default=False)
+
         redirect_page = resolve(request.path_info).url_name
 
         context, pagesize, orderby = _build_list_helper(request,
@@ -2000,7 +2008,7 @@ if True:
         build_info = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
 
         # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
-        build_mru = Build.objects.order_by("-started_on")[:3]
+        build_mru = _get_latest_builds()[:3]
 
         # calculate the exact begining of local today and yesterday, append context
         context_date,today_begin,yesterday_begin = _add_daterange_context(queryset_all, request, {'started_on','completed_on'})
@@ -3030,6 +3038,10 @@ if True:
         queryset_all = queryset_all.filter(Q(is_default=False) |
                                            q_default_with_builds)
 
+        # if in BUILD_MODE, exclude everything but the command line builds project
+        if not toastermain.settings.BUILD_MODE:
+            queryset_all = queryset_all.exclude(is_default=False)
+
         # boilerplate code that takes a request for an object type and returns a queryset
         # for that object type. copypasta for all needed table searches
         (filter_string, search_term, ordering_string) = _search_tuple(request, Project)
-- 
1.9.1


