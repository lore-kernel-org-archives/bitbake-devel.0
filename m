Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id 01E6276A81
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:17 +0000 (UTC)
Received: by wijp15 with SMTP id p15so105171696wij.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=v42aIU5qbzUzzDM/iGVzW5pmCnD3Os6M2aM+/SU7+eo=;
	b=VaTBn2jGNI5Sznmo6cMyrxMWmHE6qYZb02Su9MsvdtsmPKG3b+Q5uKdAXYaZ/pIGYg
	CgFJbcLWT4V/kIff+Z7JdjzugegLnWCAGBFHjs+Ob3pVd9P/fd9Ehzqff1Nu71j1+AnP
	W/vzblRzHkXN4oNl57Q9H0vYOb8knVlLSLDiPlfCXLKO27NK9NvwCH0c6okY/pHailpu
	rdTkX8X3NIjPC9X9E9ycQZTMcZCaGxksTevBM5ETK/XsNp06gZOQPG6HzYjqnhuQuxge
	ohu0GU52otxDWUUuJr7j37PEUYS270OQBDn53NvRW3voc5fi3odZbLGi2cT/1Can1VBV
	2oXw==
X-Gm-Message-State: ALoCoQnMCaoLK4I5CEekZxkUnMHdG70sPjl9J16IncdrF+9IONx6aADQcgRqJvkb8aRQL+zWjI/X
X-Received: by 10.180.83.137 with SMTP id q9mr47124908wiy.68.1439915357741;
	Tue, 18 Aug 2015 09:29:17 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:17 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:59 +0100
Message-Id: <174d3255d2f790d7f6f76618d15c257f282c4097.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 13/14] toastergui: do not show in-progress builds in the table
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
X-List-Received-Date: Tue, 18 Aug 2015 16:29:19 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the all-builds table as not to show
in-progress builds.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 20f7cb3..086d387 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1892,7 +1892,7 @@ if True:
         # be able to display something.  'count' and 'page' are mandatory for all views
         # that use paginators.
 
-        queryset = Build.objects.filter(outcome__lte = Build.IN_PROGRESS)
+        queryset = Build.objects.exclude(outcome = Build.IN_PROGRESS)
 
         context, pagesize, orderby = _build_list_helper(request, queryset)
 
-- 
2.1.4


