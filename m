Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f181.google.com (mail-we0-f181.google.com
	[74.125.82.181])
	by mail.openembedded.org (Postfix) with ESMTP id CAAA465E14
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Apr 2014 13:17:43 +0000 (UTC)
Received: by mail-we0-f181.google.com with SMTP id q58so2401125wes.40
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Apr 2014 06:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=4hTczNGIzAAVQOtKe5SqVyIrLvB42FPdbwgJN5co6uI=;
	b=mM8E4+VVK067S4TPM1URzz0JgkIZQU0pu9isktdqY5E2SmVx5VTEUNBtrw2valpxTD
	GCxovGYj5F/09poXdpuGG5c4fBKk4Ds88oNpxo3Y+TrPECaf/+jpYyeeiXyVTYVkw9fC
	/4kHMEIVkCVlGJq5+ptjREf9dK1rmT/roq64gM5v6+gAHJcDt0aCmW08TuaKBOJ67RBe
	BW/cqF9s6KLyKZ2H30cnl3J8t4zRoGKVyRBvE9JemaxigdFHX7xTn2tp6WG0LyhrMWtX
	Go8zUx3X0k3I+AVmgVsS5lUrVv6kK1IgtncWDJUmHxVFjtFGYfbyVrb4tR4YthC3grGR
	JgLw==
X-Gm-Message-State: ALoCoQldIB5iLpYwBJJYPXT22V324q2bnO9cDHVjUoC0Dyyumejme2X7PgDBx2t5sR7mPo4k6R6f
X-Received: by 10.180.105.132 with SMTP id gm4mr12327182wib.39.1397049464286; 
	Wed, 09 Apr 2014 06:17:44 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id i9sm10053839wiy.17.2014.04.09.06.17.41
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Apr 2014 06:17:42 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 793C15602D5; Wed,  9 Apr 2014 14:17:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Apr 2014 14:17:36 +0100
Message-Id: <befe17a5084ebd878df11f67d0de0154a020a977.1397049329.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
References: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1397049329.git.alexandru.damian@intel.com>
References: <cover.1397049329.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 5/9] toaster: fix filtering query for multiple filters
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
X-List-Received-Date: Wed, 09 Apr 2014 13:17:46 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a fix for using multiple expressions in filters.
Three different issues are touched:
* added an explicit error message for incorrect filter usage
* changed the value separator to something that will pass
through from the browser to the actual code
* changed the "and" operator for combining Q from a dubios
lambda function to the standard operator.and_

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 96ce4d7..4ed9940 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -80,7 +80,7 @@ def _redirect_parameters(view, g, mandatory_parameters, *args, **kwargs):
     return redirect(url + "?%s" % urllib.urlencode(params), *args, **kwargs)
 
 FIELD_SEPARATOR = ":"
-VALUE_SEPARATOR = ";"
+VALUE_SEPARATOR = "!"
 DESCENDING = "-"
 
 def __get_q_for_val(name, value):
@@ -102,7 +102,7 @@ def _get_filtering_query(filter_string):
     values = search_terms[1].split(VALUE_SEPARATOR)
 
     querydict = dict(zip(keys, values))
-    return reduce(lambda x, y: x & y, map(lambda x: __get_q_for_val(k, querydict[k]),[k for k in querydict]))
+    return reduce(operator.and_, map(lambda x: __get_q_for_val(x, querydict[x]), [k for k in querydict]))
 
 def _get_toggle_order(request, orderkey, reverse = False):
     if reverse:
@@ -128,7 +128,7 @@ def _validate_input(input, model):
 
         # Check we have only one colon
         if len(input_list) != 2:
-            invalid = "We have an invalid number of separators"
+            invalid = "We have an invalid number of separators: " + input + " -> " + str(input_list)
             return None, invalid
 
         # Check we have an equal number of terms both sides of the colon
-- 
1.9.1


