Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 2648172E53
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 14:38:02 +0000 (UTC)
Received: by wixw10 with SMTP id w10so22520303wix.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 07:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Ez5gBpz2EehsJDea/dix3kvjFjk/rz0EuOU425PKNsM=;
	b=e+R+L1nI2LXccotAL9xYMoyFdazZr5Pnx66HZwq0v0JqUKWC7rbvQna8wWfmGqkPAT
	6J2xI7kfDe317+XGXzQEMMDjL45lr1ULNwa2JCsEoxDRz3OlRywB3/g7/iun9RNEHNqI
	cAQKTz0E5bCI+w037QAUYoIYM1m0Koug23fssxqWFjcBOYmZ9SdYSek1aDmiyrqXZZX/
	rhY01uBSeOU6wttHzp2I/vU7OYrc7mfOHBt8lVa1wGWhV5GCCZYfshGRXylF/rr8moeX
	/y8dfDE/DxFQLvIY2aWCWU3S6fobjy5KQ6YkKpJyh5I3dfRGijU05BMDk3OH0PBnsivM
	uw8g==
X-Gm-Message-State: ALoCoQmvFSGQh0GOO9O8x/58KyNQTbNq825XvtVlzc2qGywIR4GzD/zyjvQ0/wcb3jccmMezsuZC
X-Received: by 10.181.27.199 with SMTP id ji7mr5752414wid.76.1426862283672;
	Fri, 20 Mar 2015 07:38:03 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ch6sm6646176wjc.3.2015.03.20.07.38.01
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 07:38:02 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id AF752564127; Fri, 20 Mar 2015 10:25:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Mar 2015 10:25:21 +0000
Message-Id: <3ea483b8a55f97e412e864ff8f0ad392691bd8bc.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
References: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Subject: [PATCH 04/14] toastergui: fix machines page search
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
X-List-Received-Date: Fri, 20 Mar 2015 14:38:03 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the machine page search.

[YOCTO #7407]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 439c068..fa34e56 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2867,15 +2867,17 @@ if toastermain.settings.MANAGED:
         # for that object type. copypasta for all needed table searches
         (filter_string, search_term, ordering_string) = _search_tuple(request, Machine)
 
-        queryset_all = Machine.objects.all()
-        queryset_all = queryset_all.prefetch_related('layer_version')
-
         prj = Project.objects.get(pk = request.session['project_id'])
         compatible_layers = prj.compatible_layerversions()
 
+        queryset_all = Machine.objects.filter(layer_version__in=compatible_layers)
+        queryset_all = _get_queryset(Machine, queryset_all, None, search_term, ordering_string, 'name')
+
+        queryset_all = queryset_all.prefetch_related('layer_version')
+
+
         # Make sure we only show machines / layers which are compatible
         # with the current project
-        queryset_all = queryset_all.filter(layer_version__in=compatible_layers)
 
         project_layers = ProjectLayer.objects.filter(project_id=request.session['project_id']).values_list('layercommit',flat=True)
 
-- 
1.9.1


