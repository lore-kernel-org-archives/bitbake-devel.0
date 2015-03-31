Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
	[209.85.192.172])
	by mail.openembedded.org (Postfix) with ESMTP id 10CD873CC3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 14:07:33 +0000 (UTC)
Received: by pddn5 with SMTP id n5so21901883pdd.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 07:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=OVzw4tH+EcSgNRlaH7kxNm7P4Jv9ljVANCbqWRpD9xg=;
	b=cX7eqCjL4LXGz7V6IizZEF0hlnoZS143fLcN4fH30IWAMqnVxKeRH4TpxNYkUKELj8
	2MjVa+EX0EEi1yz70QscZf34Of9o9ms3nOTSXP6KYuHH3SebFHfD92pLBm9IO0ZgaZZ4
	mco/v6OD5uzOwlYr3+P7yyfB3QNFF3qTbqjXg7I3gMLm+C6yN1exwMmimaxwGjyEzAIl
	RcPtCv17HUz7cUOBE4+5QyXw1AIz4BhIpCA1MqrBDrgcrgGxbVioqRpizgKLZvH9yr4e
	YOWe6x8oUCqds0PL+y/wtic3+svC/pz6wg5cg2e5S6MbZyxhwNto9tSWj5jwGaBkju0p
	hl8g==
X-Gm-Message-State: ALoCoQlPG2pOxLmModxDY4H+nHMQgVrC6zHhSrRN8NzTWWSQa4z/AyDMJqa5wUiDRrOpMb/UuRYx
X-Received: by 10.66.140.39 with SMTP id rd7mr67644187pab.25.1427810855211;
	Tue, 31 Mar 2015 07:07:35 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	xh3sm13479968pab.25.2015.03.31.07.07.33
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 31 Mar 2015 07:07:33 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 3142F561E66; Tue, 31 Mar 2015 15:07:31 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 Mar 2015 15:07:27 +0100
Message-Id: <4b553dbeff7c7bc536669e7fee7d52f962259ebe.1427810520.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1427810520.git.alexandru.damian@intel.com>
References: <cover.1427810520.git.alexandru.damian@intel.com>
Subject: [PATCH 1/4] toastergui: prevent error on empty build list
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
X-List-Received-Date: Tue, 31 Mar 2015 14:07:39 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch prevents errors being thrown on date limit
computations if the build list is empty.

[YOCTO #7513]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index fdd8022..2f8fb1a 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -334,8 +334,14 @@ def _add_daterange_context(queryset_all, request, daterange_list):
     context_date['daterange_filter']=''
     for key in daterange_list:
         queryset_key = queryset_all.order_by(key)
-        context_date['dateMin_'+key]=timezone.localtime(getattr(queryset_key.first(),key)).strftime("%d/%m/%Y")
-        context_date['dateMax_'+key]=timezone.localtime(getattr(queryset_key.last(),key)).strftime("%d/%m/%Y")
+        try:
+            context_date['dateMin_'+key]=timezone.localtime(getattr(queryset_key.first(),key)).strftime("%d/%m/%Y")
+        except AttributeError:
+            context_date['dateMin_'+key]=timezone.localtime(timezone.now())
+        try:
+            context_date['dateMax_'+key]=timezone.localtime(getattr(queryset_key.last(),key)).strftime("%d/%m/%Y")
+        except AttributeError:
+            context_date['dateMax_'+key]=timezone.localtime(timezone.now())
     return context_date,today_begin,yesterday_begin
 
 
-- 
1.9.1


