Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id AA3356F8DE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 16:50:03 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id cc10so6188701wib.14
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 09:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ciIz1TXQRccKTYk6zRezA/IieleLZUnta//g+n/qBuQ=;
	b=J3m661G6Dq2UQ9Kztmvaqh6LtVfKHK5ep3ypQiK3iKbNzEr1g2mHsxnSoyVlbxGOXt
	cbcBuayo6dWEqILkAUEo7iTmkWfXLUCqHJPGn8lFePMTA3DAFcNseG6hU4OT78n6FCUO
	tWPV8qu2REpCDHJ4UVyYoD1rlSm4YFSiCaVosIu0v7VCrdxcNiyGEp/IhCJtDOUa5JpP
	yuIOWuoiCwMxfTN+5IFoRAKgCIkVwiL59PlwE4uiuoyJes2pzCBGOZot23uizfngC3tZ
	O0gtEbHjanYMhNMFYLhPxWMkLga0rvAOp+vleGU811Qts7U5NpBuAV/efWYVH4H2mTio
	glOw==
X-Gm-Message-State: ALoCoQncIrIcshRYEQDOotODszLgV1AxIUovL2Fkl+TMC72G8jZwakO5ty+XCDtzyXbLansEk3o/
X-Received: by 10.180.19.35 with SMTP id b3mr41577992wie.20.1395939003993;
	Thu, 27 Mar 2014 09:50:03 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id h5sm13890836wiy.18.2014.03.27.09.50.02
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 27 Mar 2014 09:50:02 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 7E101560994; Thu, 27 Mar 2014 16:50:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Mar 2014 16:49:55 +0000
Message-Id: <4791f2886eebd5d9b4776cb66a4179710fbe2c7f.1395938903.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
References: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395938903.git.alexandru.damian@intel.com>
References: <cover.1395938903.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 3/9] toaster: insure _get_query returns distinct records
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
X-List-Received-Date: Thu, 27 Mar 2014 16:50:05 -0000

From: David Reyna <David.Reyna@windriver.com>

The '_get_query' can return duplicate records if a search term appears
multiple times in the same row, so the queryset must be made
distinct before returning.
This commit also removes the initial special case for configvars in
favor of this general solution.

[YOCTO #6012]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/views.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4f31ddb..8f6e201 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -192,7 +192,8 @@ def _get_queryset(model, queryset, filter_string, search_term, ordering_string):
         else:
             queryset = queryset.order_by(column)
 
-    return queryset
+    # insure only distinct records (e.g. from multiple search hits) are returned 
+    return queryset.distinct()
 
 # shows the "all builds" page
 def builds(request):
@@ -1060,10 +1061,8 @@ def configvars(request, build_id):
         return _redirect_parameters( 'configvars', request.GET, mandatory_parameters, build_id = build_id)
 
     queryset = Variable.objects.filter(build=build_id).exclude(variable_name__istartswith='B_').exclude(variable_name__istartswith='do_')
-    queryset_with_search =  _get_queryset(Variable, queryset, None, search_term, ordering_string).distinct().exclude(variable_value='',vhistory__file_name__isnull=True)
+    queryset_with_search =  _get_queryset(Variable, queryset, None, search_term, ordering_string).exclude(variable_value='',vhistory__file_name__isnull=True)
     queryset = _get_queryset(Variable, queryset, filter_string, search_term, ordering_string)
-    # remove duplicate records from multiple search hits in the VariableHistory table
-    queryset = queryset.distinct()
     # remove records where the value is empty AND there are no history files
     queryset = queryset.exclude(variable_value='',vhistory__file_name__isnull=True)
 
-- 
1.8.3.2


