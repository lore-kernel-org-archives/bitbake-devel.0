Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
	[74.125.82.173])
	by mail.openembedded.org (Postfix) with ESMTP id 739126F8DC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 16:50:03 +0000 (UTC)
Received: by mail-we0-f173.google.com with SMTP id w61so2002936wes.32
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 09:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=IXU5Sv6nzx/FHeE4GakjKzI4/A+b7f+d8Dsy8FxZ3cQ=;
	b=UrgQl2Bx2nqIielq6hWWDJ4BkIHSPQh0x4R/aerNeGanMcHVvjnEn92XCNQ10dVlHI
	makWyWv6iv5cfn7pLmr8wxjzW8z2FyZ8kGf994mqqJXO/DEC6WopIPurrfepQ19G83Fb
	6aLKemERUl+l3j1J//o/D/75H69ohhKDkWDuP4U9+YWZzmqPqIEhkmlTro8r5n+b/Rtf
	IUDIwLVYymDpe34QwHTFpsWxa2k2OXWLkmtcEI+gBbmbOzjeSAFNWGJiu0P0NzHdhgtr
	TbM+JX9EKTFnSXCun7GI+M24kBSX2sVcocjCVmyclmLyBkk4KLm3+7qt3i+ZhYQnTFgI
	G3rA==
X-Gm-Message-State: ALoCoQle0ohaoPH59fq//Eje3NWyYJEDluvqQk2u40Mxg5DyrsU4cPzV04/ZKhcw6XPnX07/Oe+y
X-Received: by 10.180.96.66 with SMTP id dq2mr6361209wib.54.1395939004783;
	Thu, 27 Mar 2014 09:50:04 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	t10sm13892080wiw.19.2014.03.27.09.50.02 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 27 Mar 2014 09:50:04 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 7FE26560A32; Thu, 27 Mar 2014 16:50:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Mar 2014 16:49:56 +0000
Message-Id: <0b06de4c3300a3b204d5ee634d16afd88613ec66.1395938903.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
References: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395938903.git.alexandru.damian@intel.com>
References: <cover.1395938903.git.alexandru.damian@intel.com>
Subject: [PATCH 4/9] toaster: Fix typo in heading code
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

From: Belen Barros Pena <belen.barros.pena@intel.com>

Fix typo in the code that handles the changes
in the h1 text in order to display the number of results
returned by a search.

[YOCTO #6001]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/configvars.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/configvars.html b/lib/toaster/toastergui/templates/configvars.html
index de4940e..1bd29aa 100644
--- a/lib/toaster/toastergui/templates/configvars.html
+++ b/lib/toaster/toastergui/templates/configvars.html
@@ -16,7 +16,7 @@
  <h1>
   {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
       {{objects.paginator.count}} variable{{objects.paginator.count|pluralize}} found
-  {%elif request.GET.filter and objects.paginator.count == 0 or request.GETs.search and objects.paginator.count == 0 %}
+  {%elif request.GET.filter and objects.paginator.count == 0 or request.GET.search and objects.paginator.count == 0 %}
       No variables found
   {%else%}
       Configuration
-- 
1.8.3.2


