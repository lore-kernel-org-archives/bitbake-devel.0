Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id A11BF72CBE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:22:18 +0000 (UTC)
Received: by mail-wg0-f52.google.com with SMTP id y19so4283232wgg.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=jGgtVCKlv/C8iUOF6w7nJuUmj7ZZM1E0i8yhjYHeqZ8=;
	b=iTUhLpqAkbU6UPVHQ2W0ClUOyCBNcH7gA51V04GDEzCG0PsgS2Z4rBN748y51dsYjK
	+UD8fKys+jtS0W+oGKWSIwDSsLBnOtRWJJrtZx8SQbkW8XwUXPbknp1U+4ARJbLqb0Tn
	LD+JI4+GuA0OqqMvubWJKOcFkWKoiZwJdu55comH7Sk2KjQ5TK4456wrzyQsYyfdFafQ
	JOLQjGk58PEGdZp8fAraGNSNQA1+7ZxFwNWEw66uCAWJ+HMbYlbv9XC3FMIpP0NkO8an
	dE3CrZ7DaF7DG1sv0gA/87KDQ8ZKJUDta8w5D72IxQEOpNX1uyFAhQoVJ3Gmj9Y1FsR5
	JBvQ==
X-Gm-Message-State: ALoCoQmXRP3DVXJPB3DfvBmiIPrYNzoI4ckRkJAp6cbh/chAcGX859oQr7yjcMj/h1yyhXGhwT/Z
X-Received: by 10.194.236.200 with SMTP id uw8mr31840470wjc.10.1421864538370; 
	Wed, 21 Jan 2015 10:22:18 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id l9sm8270409wic.21.2015.01.21.10.22.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:22:16 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id EAC5B5640F0; Wed, 21 Jan 2015 17:01:42 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 17:01:37 +0000
Message-Id: <f62bde65c4eaa13839551eb6e68bf44ed1270251.1421859619.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
References: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421859619.git.alexandru.damian@intel.com>
References: <cover.1421859619.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 07/12] toastergui: fix all targets page search
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:19 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This fixes the display of layers in all-targets page search/filtering
usage pattern by displaying layer-equivalence class.

The significant impact is the correct display of the list size
for search/filtering actions

[YOCTO #7051]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 6b4b5d9..616b57c 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2494,9 +2494,12 @@ if toastermain.settings.MANAGED:
 
         queryset_all = _get_queryset(Layer_Version, queryset_all, filter_string, search_term, ordering_string, '-layer__name')
 
+        object_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all])
+        object_list = list(object_list)
+
 
         # retrieve the objects that will be displayed in the table; layers a paginator and gets a page range to display
-        layer_info = _build_page_range(Paginator(queryset_all, request.GET.get('count', 10)),request.GET.get('page', 1))
+        layer_info = _build_page_range(Paginator(object_list, request.GET.get('count', 10)),request.GET.get('page', 1))
 
 
         context = {
@@ -2504,7 +2507,7 @@ if toastermain.settings.MANAGED:
             'objects' : layer_info,
             'objectname' : "layers",
             'default_orderby' : 'layer__name:+',
-            'total_count': queryset_all.count(),
+            'total_count': len(object_list),
 
             'tablecols' : [
                 {   'name': 'Layer',
-- 
1.9.1


