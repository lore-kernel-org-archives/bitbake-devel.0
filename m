Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
	[209.85.192.182])
	by mail.openembedded.org (Postfix) with ESMTP id E9EEA73919
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 10:25:34 +0000 (UTC)
Received: by pdbni2 with SMTP id ni2so105049062pdb.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 03:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ZoFAR9TuombThzp/kR6W9y/ML6PABF7lRexhrumuy0w=;
	b=EelXcJhySn7S3Cav/0eKRaYQ6BZnxhRMOhrpNGNCsNS1NmiNtIyGxb6ysqgJ23e9cu
	s1epU6VcC3HK+b2EOHa5sK9lIytmeXDMfDELWX8cKyS4BhQ/hTMWueq91feQ0NGHZ2lU
	qSGnLcJpW9sPAh2nY0FEQU4co9JCQE41zcszjxBKpxywKThwqpmEOKckdNmytYO9kukU
	GarfuFBQDHxQfqwNem5t1aUKdgK1btpfK/6rA0XG3R5DGYQD/MI7dLHr3j7setdWhNp7
	6XQuYndDnpJtw12RavCTOABsjd4a5xWLn2Sh1Ayelg9dO8wZVjq51WMbBLFxOlxL+ZHX
	xkSw==
X-Gm-Message-State: ALoCoQltDIFxTRkKayMq5shJqMQweTBUGvO6S5AsQO3tQbJquAiJb2Z29cRDkLeygxCM5VFUhjx3
X-Received: by 10.66.102.34 with SMTP id fl2mr184682447pab.40.1426847135471;
	Fri, 20 Mar 2015 03:25:35 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id y9sm7328599pdj.90.2015.03.20.03.25.34
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 03:25:34 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id AC0665640FC; Fri, 20 Mar 2015 10:25:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Mar 2015 10:25:19 +0000
Message-Id: <ca8062627886484f8897ec09fb489bd78abde29e.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
References: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Subject: [PATCH 02/14] toaster: targets page performance improvement
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
X-List-Received-Date: Fri, 20 Mar 2015 10:25:35 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Yet another performance improvement, this time by forcing
two-step evaluation instead of using subqueries to select data.

This avoid using full-table lookups on un-indexed temporary
tables.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index fe016cc..439c068 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2767,7 +2767,10 @@ if toastermain.settings.MANAGED:
         queryset_with_search = _get_queryset(Recipe, queryset_all, None, search_term, ordering_string, '-name')
 
         # get unique values for 'name', and select the maximum ID for each entry (the max id is the newest one)
-        queryset_with_search_maxids = queryset_with_search.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')
+
+        # force evaluation of the query here; to process the MAX/GROUP BY, a temporary table is used, on which indexing is very slow
+        # by forcing the evaluation here we also prime the caches
+        queryset_with_search_maxids = map(lambda i: i[0], list(queryset_with_search.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')))
 
         queryset_with_search = queryset_with_search.filter(id__in=queryset_with_search_maxids).select_related('layer_version', 'layer_version__layer', 'layer_version__up_branch', 'layer_source')
 
-- 
1.9.1


