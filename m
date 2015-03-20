Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 4F655728C2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 10:25:41 +0000 (UTC)
Received: by pacwe9 with SMTP id we9so105075966pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 03:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=xgOvWHy24ajdBC383kvBIPRBhYlISF0HP1fYhu3qjww=;
	b=aWImF0QqDPklgMyjADGZtLjkGCNOrPbNvoXx19xqXWuRvXs3/206CK3eUdl4JMiD1T
	fsx7JrbrHHN2bnoku9EzqQnGrVDQnjodgIHnLMgVm8fLWDObDYYlCRDeR/h1G6EftvlN
	DKehzW0w8WWYLo9VyQnK7bYpjqXUkrK3O2HQ4ohdzkeZ8wv5a0f0KBCnnWhG7GUkmTaH
	PMPRimsbs+Xfqqa6NIidU60lOOi8zCn7gjPJ1r7pN2ooDjV8TDcIoKlvC/SviWfO6gpH
	uI/Z49HsPPsKplB1odOUGKNkszxrkaQjRq6fVqxMVhT4CdCnc/xoTKKDdGck380fN/sX
	6aSQ==
X-Gm-Message-State: ALoCoQljhzLHqEaoHGTfD0DU9nxlXRm0uZdCFYiBG11+FNVW8VQ02+3fcBj2j9cHxfsuEsc5RJFe
X-Received: by 10.70.64.193 with SMTP id q1mr123259706pds.94.1426847143326;
	Fri, 20 Mar 2015 03:25:43 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id f12sm7401985pat.43.2015.03.20.03.25.41
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 03:25:42 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BB3175645AE; Fri, 20 Mar 2015 10:25:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Mar 2015 10:25:29 +0000
Message-Id: <e97cc826f065482302cde9a5c18f2e41510a19c8.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
References: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Subject: [PATCH 12/14] toaster: tasks trigger the select related tables before ordering
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
X-List-Received-Date: Fri, 20 Mar 2015 10:25:42 -0000

From: Michael Wood <michael.g.wood@intel.com>

In two of the cases the data is changed from a QuerySet to a sorted list
so we aren't able to use the QuerySet api at this point, moving it
before the data type is changed fixes this.

[YOCTO #7404]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 26c8760..ea47d96 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -877,7 +877,10 @@ def tasks_common(request, build_id, variant, task_anchor):
         return _redirect_parameters( variant, request.GET, mandatory_parameters, build_id = build_id)
     (filter_string, search_term, ordering_string) = _search_tuple(request, Task)
     queryset_all = Task.objects.filter(build=build_id).exclude(order__isnull=True).exclude(outcome=Task.OUTCOME_NA)
+    queryset_all = queryset_all.select_related("recipe", "build")
+
     queryset_with_search = _get_queryset(Task, queryset_all, None , search_term, ordering_string, 'order')
+
     if ordering_string.startswith('outcome'):
         queryset = _get_queryset(Task, queryset_all, filter_string, search_term, 'order:+', 'order')
         queryset = sorted(queryset, key=lambda ur: (ur.outcome_text), reverse=ordering_string.endswith('-'))
@@ -887,7 +890,6 @@ def tasks_common(request, build_id, variant, task_anchor):
     else:
         queryset = _get_queryset(Task, queryset_all, filter_string, search_term, ordering_string, 'order')
 
-    queryset = queryset.select_related("recipe", "build")
 
     # compute the anchor's page
     if anchor:
-- 
1.9.1


