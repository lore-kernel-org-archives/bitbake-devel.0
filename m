Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id 521C965E0F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 13:51:59 +0000 (UTC)
Received: by mail-wi0-f181.google.com with SMTP id n3so3028151wiv.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 06:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=UAWcmKd6Av0cQ7DOF/LsFjq1jiCDqEkjHbyDV3PVRuk=;
	b=QeO5G0mBlqo3mk2WvI1dWs0Dxy+56144qWtRKaAkjA5owRGwcnAXhiGb4XTzYoGvT/
	QpHUCJtmn4yT2eGU/zuN1lbPZoU31LIiGIAT/ua+YKDVN987I87Kz72Uy1UeJ52B49N6
	lpOM/u9EW2LN0dZvUgixoF5GpfPKgYiJQ/aq7lTSg+/7Mx0c0oAuioSRVKRX3e97ZSGh
	V0uKVFzQUQjEhM8hL06CzWrY75uU4Wk6dgIN1Ih6Z8miC0qcZni/mpQgzM/Bk1k79PcI
	WYwoSguRBU26/Cl75s0Fv/ziA7urYFz7cj0kuxSJh35gGlORODKtzVe9ThxFAJpd1gGS
	bTNQ==
X-Gm-Message-State: ALoCoQm8/IJhY8y/oYiqT05yH87p6ATDtiPQ9LgTRdDtdXB7MmK7S363B/Z6gXrISv01Cx6ptL80
X-Received: by 10.180.82.7 with SMTP id e7mr6916239wiy.6.1402581120462;
	Thu, 12 Jun 2014 06:52:00 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id vp5sm1630994wjc.31.2014.06.12.06.51.58
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Jun 2014 06:51:58 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id AC2B956115C; Thu, 12 Jun 2014 14:52:03 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Thu, 12 Jun 2014 14:52:01 +0100
Message-Id: <dc1daae51ef5201475b5c1a69d966ae57b66dcb6.1402580802.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <08556b79b7b2af08aaeedf8733b1b8996f387c4e.1402580802.git.alexandru.damian@intel.com>
References: <08556b79b7b2af08aaeedf8733b1b8996f387c4e.1402580802.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1402580802.git.alexandru.damian@intel.com>
References: <cover.1402580802.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 5/6] toastergui: fix built ETA calculation
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
X-List-Received-Date: Thu, 12 Jun 2014 13:52:00 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We fix the calculation showing the estimated time
to build completion.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 686cd5c..b38d260 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -230,11 +230,10 @@ def builds(request):
             b.completeper = tf.exclude(order__isnull=True).count()*100/tf.count()
         else:
             b.completeper = 0
-        b.eta = timezone.now()
+
+        b.eta = 0
         if b.completeper > 0:
-            b.eta += ((timezone.now() - b.started_on)*100/b.completeper)
-        else:
-            b.eta = 0
+            b.eta = timezone.now() + ((timezone.now() - b.started_on)*(100-b.completeper)/b.completeper)
 
     # set up list of fstypes for each build
     fstypes_map = {};
-- 
1.9.1


