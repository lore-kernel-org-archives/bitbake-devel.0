Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 4B3026EEFA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:08 +0000 (UTC)
Received: by mail-wg0-f44.google.com with SMTP id m15so2480672wgh.27
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=7/yUCS24CG4arqiosJDY928LRtlSxOQpEAMFKItj3ig=;
	b=cqrjA7AEdAnZZBWAmuP4HBDxhjH6xbCWzpdqANjK6wkUGSgGwYxVb+ZjEVnGbhbXhf
	fxOnzOunsckTSbjQO1qv/IJqjyHcHU15tevTpwGEt8/ZNRTsm7RlBwzF4mPh6ENGRsGp
	oT6wzaF1FmDL80V+DkxiljuwxXHxsjC5HM4hxSxPnhDnpOKaOccp8h7tP1QpynbFcIDP
	Q07iTiM52puDEgThxlgPrUdO5ukpcPFuOKHsClmz4myZUnQRJiQJJeOoGVEVI/trOKon
	7nKDGzYDXrTPjeuFa7D0v42VW6kvXjTSCszLLT+4iMB5j4FFV2Z3sT+gfvAazJIZ1BzJ
	8IYw==
X-Gm-Message-State: ALoCoQmWTmy/TGZtve52q/LnKD6uOIgBM9zcgSqH04dKVwPzMHho9EkwBE3wyXnuCIJis/T2Vk1b
X-Received: by 10.180.73.173 with SMTP id m13mr7291824wiv.52.1394819949474;
	Fri, 14 Mar 2014 10:59:09 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id t6sm36755633wix.4.2014.03.14.10.59.05
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:08 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 21937561245; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:56 +0000
Message-Id: <b60a473aeca1e18c49ef6db074d3bdafa4104c3d.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 15/19] toaster: Fix Recipe sorting in tasks table
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:09 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In the tasks table and the other tables derived from it
(Time, CPU usage and Disk I/O) sorting by Recipe was not
working correctly. This change fixes the problem by
specifying use of the recipe name to sort.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/views.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index bf7f2c8..ddeb992 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -518,8 +518,8 @@ def tasks_common(request, build_id, variant):
     tc_recipe={
         'name':'Recipe',
         'qhelp':'The name of the recipe to which each task applies',
-        'orderfield': _get_toggle_order(request, "recipe"),
-        'ordericon':_get_toggle_order_icon(request, "recipe"),
+        'orderfield': _get_toggle_order(request, "recipe__name"),
+        'ordericon':_get_toggle_order_icon(request, "recipe__name"),
     }
     tc_recipe_version={
         'name':'Recipe version',
-- 
1.8.3.2


