Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 3EE6C60107
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jun 2016 14:54:46 +0000 (UTC)
Received: by mail-pa0-f41.google.com with SMTP id b13so7111822pat.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jun 2016 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=JFtOY0RocQZc+i1R6RJRhv+6s0aAQ3GFTPg0FNT7Rz4=;
	b=icqz6PhkZbD+UG/USZjVrDomfuV3cRCVHWRHUcfQj2zwIy32cpgXwzOgrUCG59EEyV
	og1hMyt25FzGcuL2aQm0gtUytiZhWy3biiq2ItOjqiCFLYkM29U8Svh8fOoS823hpMGz
	4+SiUiIk4eDLcoIuX7Xi4LdxNd6jptHVmcUujhsNoLfibXjC4K8yq3vxVB3O4OIBlPEG
	IktQANBQQ9Qaq9r9AVlLulOIgqB8uYz7I7yUMGZNEIc8Ko1OXadnl8q4Ih16NtsST2Um
	bpWYxRZmFylrS9LOWca5OA6NtcnN4CWKseBQLevSYEjOe3GkIuDVMfoxUVW04zuqmLuL
	oiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=JFtOY0RocQZc+i1R6RJRhv+6s0aAQ3GFTPg0FNT7Rz4=;
	b=aQIU5GezAA81yxE1NgK1C57V/4rmX7SN/lmjJqXuQ7C8s4jWvzTglOiEv3Mj0xnDzP
	JFkCmZBx7pJV+5GRcBfZ75FQ+7RTyQEp4wvA51v1wK/K+fcMxzsSRoZ5ilw6mfWh1YwO
	l7dlWFe6xLNhjmHkD384mqpTkNt51vJR0ns+DGJzapRMQ5zfr/Uc4jyJShpfYh//FIeg
	w6tbvgwS/+XTjQdjhWHof9b7ub98JSKBfGScqymwCYC+sT1DOcj0J86+29pi8qxu53lE
	XEbZiHEZQ2LezRtFyf6OSyHdJBF1N74jlwNO5XchsthIRPPogAq/0yZIq2OhFDbv4gKb
	FQ7g==
X-Gm-Message-State: ALyK8tI57ROhwbF8mOmFlHRIzaCOsTUOqPHYvrd0SBvYT9e2Af524J6FB6mS6EA/rY2vmua4
X-Received: by 10.66.101.136 with SMTP id fg8mr28917259pab.144.1466520887002; 
	Tue, 21 Jun 2016 07:54:47 -0700 (PDT)
Received: from orion.ger.corp.intel.com ([192.55.54.45])
	by smtp.gmail.com with ESMTPSA id
	g26sm72727197pfj.82.2016.06.21.07.54.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 21 Jun 2016 07:54:46 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Jun 2016 15:54:32 +0100
Message-Id: <1466520872-18417-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] toaster: fix typo in arguments for libtoaster.js function
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
X-List-Received-Date: Tue, 21 Jun 2016 14:54:47 -0000

From: Elliot Smith <elliot.smith@intel.com>

The function for flattening the targets of a previous build
to a space-separated list references prev and next arguments
which aren't in the function signature. This prevents the "Rebuild"
buttons (in the most-recent build section) from working.

Fix the typo so that the buttons work again.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index eafe70d..a1379e1 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -94,7 +94,7 @@ var libtoaster = (function () {
 
     /* Flatten the array of targets into a space spearated list */
     if (targets instanceof Array){
-      targets = targets.reduce(function(prevV, nextV){
+      targets = targets.reduce(function(prev, next){
         return prev + ' ' + next;
       });
     }
-- 
2.7.4


