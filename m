Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id 6EBBE72BCE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:21:58 +0000 (UTC)
Received: by mail-wg0-f48.google.com with SMTP id x12so12910097wgg.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=cnkxSAE7L9SCuD8VZ8xXH/Lfg7dFgZNYYgkEWq+1yCM=;
	b=B7mmcgnpb0THaeZ9qVnWGhgo9oxCTIQ5FghQFERk8HF/E9MTweUrYLDvm8DZSUdBp7
	UbExwEwv5pxqgJJApJgu+LX2rx8lQzM+1xOLJDvEZQN7FGVurI/7jfadhtA4tP8XF0MU
	gLw3txrbdMRbS8QEr7HAM2lqvdCin8ANpQn0M0Wkr1VYK5wVc/fCbJ8C8Q+gltrSlsiT
	IZrF/cUMxNwtFPpQ1ufuYe1oLEyQ452Q43rNfnsekpAa/OQ0pZd5sARUYc9/OoVJju5u
	iNh2x4xNn3lHdgSYtWb/RLS/s1osIA8Yo4gp4VPwgo37pDavh1nPHNV4ED8OE+a33tWE
	9fMA==
X-Gm-Message-State: ALoCoQnijpMQ86susNxPQDIAR4j3xZ/rjVv6x2lJ3bVqmgJhtc8yW6BtD699VmGrzeGO6tgHt/DA
X-Received: by 10.194.237.41 with SMTP id uz9mr15903430wjc.80.1421864519142;
	Wed, 21 Jan 2015 10:21:59 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ei5sm8308033wid.2.2015.01.21.10.21.56
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:21:57 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id EDDDF56410E; Wed, 21 Jan 2015 17:01:42 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 17:01:39 +0000
Message-Id: <c8683b74579b999d9cfa4017b9cae5232517c63b.1421859619.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
References: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421859619.git.alexandru.damian@intel.com>
References: <cover.1421859619.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 09/12] toastergui: minor fixes
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:05 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a minor fixes patch.

- legacy sorting by "timespent" does not crash the builds pages
- missing xhr_configvaredit view in observer mode is added

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 616b57c..f84b120 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1743,7 +1743,8 @@ if toastermain.settings.MANAGED:
     # helper function, to be used on "all builds" and "project builds" pages
     def _build_list_helper(request, buildrequests):
         # ATTN: we use here the ordering parameters for interactive mode; the translation for BuildRequest fields will happen below
-        (pagesize, orderby) = _get_parameters_values(request, 10, 'completed_on:-')
+        default_orderby = 'completed_on:-'
+        (pagesize, orderby) = _get_parameters_values(request, 10, default_orderby)
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
@@ -1764,6 +1765,9 @@ if toastermain.settings.MANAGED:
             ordering_params[0] = "build__machine"
         if ordering_params[0] == "target__target":
             ordering_params[0] = "brtarget__target"
+        if ordering_params[0] == "timespent":
+            ordering_params[0] = "id"
+            orderby = default_orderby
 
         request.GET = request.GET.copy()        # get a mutable copy of the GET QueryDict
         request.GET['orderby'] = ":".join(ordering_params)
@@ -3204,6 +3208,9 @@ else:
     def xhr_datatypeahead(request):
         raise Exception("page not available in interactive mode")
 
+    def xhr_configvaredit(request):
+        raise Exception("page not available in interactive mode")
+
     def importlayer(request):
         raise Exception("page not available in interactive mode")
 
-- 
1.9.1


