Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 5CF966FAF7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 18:02:37 +0000 (UTC)
Received: by mail-wg0-f42.google.com with SMTP id y10so564660wgg.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 11:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=8T95SvTo/PxF0JN2Y/Wt2Xea0OkVr/ufenpGXkDDBc8=;
	b=g+EwfOqjgQuNDWLOYy5kDgbjSIcqJ1R7D+Cbfh0J86JIdH/rXwySiotqU9xV5Wwnpw
	dFP84q/tQvPjuY0mFd5/f9XmMY0YmxxLBDLUW8RFMK893u8YZqroXH4rJfgBAIXuAY40
	yN4OiOIyhnb5vhzsJ/11LaCRJb3Jc/ed3WVUTVsJuq0ePEpsYJCqNMha7O7TXcLrcgIz
	1KLAEYQQs0quWvUxejd/lBDHGFTduVAwp4Z9GzB/15Jys5BrekUAJlxjNMHILkX81tJJ
	wx+BAtbxgl0DkLP1SmHl/ZxLHM3dJ0rijBnkc85zL5kZDfPdLZHJsp1+eGkTkdnrpe0V
	3Tag==
X-Gm-Message-State: ALoCoQlmSozcNRdugwJpApQbHbZdjK0Kx8NrIdMaZqLP/X1luZ+DrAdemm2oYoPrtEt/QqeHbXVa
X-Received: by 10.180.210.171 with SMTP id mv11mr23595977wic.44.1395770557433; 
	Tue, 25 Mar 2014 11:02:37 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id i9sm179169wiy.17.2014.03.25.11.02.34
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 25 Mar 2014 11:02:35 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 9213E560995; Tue, 25 Mar 2014 17:51:14 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Mar 2014 17:51:10 +0000
Message-Id: <54d3f8cdea1dc3fc0be3cf5c245efeeef04f1683.1395769683.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7cdff1413429eb64bae7522e587b42f850aa0fe0.1395769683.git.alexandru.damian@intel.com>
References: <7cdff1413429eb64bae7522e587b42f850aa0fe0.1395769683.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395769683.git.alexandru.damian@intel.com>
References: <cover.1395769683.git.alexandru.damian@intel.com>
Subject: [PATCH 2/5] toaster: Remove commented-out code from views.py
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
X-List-Received-Date: Tue, 25 Mar 2014 18:02:40 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

This code in the All tasks view class needed to be removed.

[YOCTO #6010]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/views.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a9023a3..3e59138 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -732,11 +732,6 @@ def tasks_common(request, build_id, variant):
 
     tasks = _build_page_range(Paginator(queryset, request.GET.get('count', 100)),request.GET.get('page', 1))
 
-# Per Belen - do not show the covering task
-#    for t in tasks:
-#        if t.outcome == Task.OUTCOME_COVERED:
-#            t.provider = _find_task_provider(t)
-
     # define (and modify by variants) the 'tablecols' members
     tc_order={
         'name':'Order',
-- 
1.8.3.2


