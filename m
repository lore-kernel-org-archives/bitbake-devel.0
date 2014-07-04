Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
	[74.125.82.170])
	by mail.openembedded.org (Postfix) with ESMTP id 878256AC9C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jul 2014 12:44:27 +0000 (UTC)
Received: by mail-we0-f170.google.com with SMTP id w61so1629298wes.29
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Jul 2014 05:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=e0lEqoVqJqIqsYWJjXMlaGV7TItZ/q+d1kcqKtI9V8M=;
	b=W9NcJe7zE5pFVT04D8Jj9DqBqjOzRh9P4YHtDB1akbT+t3opfOfvAztQo1yqPfX5p0
	kQU2OYxD2v0sIamInv4qx5+q1Kc+nDFkmMVIylDbDknMeIZtjp1qTp4NT8KkwQhB9PvA
	8zUMyHsKBCgzOo07uKQ1QFr/KJo3QAPikimaS6uCjpRWcHucSGQ6lgCJGf8SK+6HnClK
	1UyX4PHGn4g2Jp27kjc/AOdUbSbLfR83JAl01CtvPabspeIxNkWfEkK87AUXVvHaBnUI
	a/WVbZ5cdtxJEtte+7T5maWzJHra/uveRnb59wsOiAf1vSDVjNxsNYufKLbDl93rwZdA
	SzZA==
X-Gm-Message-State: ALoCoQlWY39m+UsE2d/FDCjCHw6P3EthdMt8DI+kxH7aeHl4uZTFYg+rozslpj8aX7GpL7bQliUZ
X-Received: by 10.194.185.238 with SMTP id ff14mr12269856wjc.9.1404477868301; 
	Fri, 04 Jul 2014 05:44:28 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	nf11sm45053164wic.9.2014.07.04.05.44.26 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Jul 2014 05:44:27 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 1D13B560605; Fri,  4 Jul 2014 13:44:27 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Jul 2014 13:44:18 +0100
Message-Id: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404477729.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1404477729.git.alexandru.damian@intel.com>
References: <cover.1404477729.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/9] toaster: remove strftime calls in filters
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
X-List-Received-Date: Fri, 04 Jul 2014 12:44:30 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We remove the unneeded strftime calls in filters, as the
filters can deal directly with datetime types.

[YOCTO #6379]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 68e981a..1f3e11d 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -301,9 +301,9 @@ def builds(request):
                  'filter' : {'class' : 'started_on',
                              'label': 'Show:',
                              'options' : [
-                                         ("Today's builds" , 'started_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=timezone.now().strftime("%Y-%m-%d")).count()),
-                                         ("Yesterday's builds", 'started_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d")).count()),
-                                         ("This week's builds", 'started_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d")).count()),
+                                         ("Today's builds" , 'started_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=timezone.now()).count()),
+                                         ("Yesterday's builds", 'started_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(hours=24))).count()),
+                                         ("This week's builds", 'started_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(days=7))).count()),
                                          ]
                             }
                 },
@@ -315,9 +315,9 @@ def builds(request):
                  'filter' : {'class' : 'completed_on',
                              'label': 'Show:',
                              'options' : [
-                                         ("Today's builds", 'completed_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=timezone.now().strftime("%Y-%m-%d")).count()),
-                                         ("Yesterday's builds", 'completed_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d")).count()),
-                                         ("This week's builds", 'completed_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d")).count()),
+                                         ("Today's builds", 'completed_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=timezone.now()).count()),
+                                         ("Yesterday's builds", 'completed_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(hours=24))).count()),
+                                         ("This week's builds", 'completed_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(days=7))).count()),
                                          ]
                             }
                 },
-- 
1.9.1


