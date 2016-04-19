Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id E797D62133
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 16:28:59 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id u206so39017742wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=j4p8ez5vveiPF5SCbwycf3+WMS+QeeiKQ55jo6W/2Ys=;
	b=an9ySFAOPZ1jbPJSD7ttTDBX6LCg12Rfiv37nsSC4ryhmDPhvjEUmsuYtDatKvm2d2
	QKE+NTofY78hbHgXQ7qYoZNbZjjmNmddbiiqbrxgNy+LAIu9zwHz5ybdOgnlUIFH5ANY
	bae4zTBm1okEu3AZFr0bLZxyubo7H0n/0YIGgamC2sH+Y5IGLk7eV33Xi1Gx127MOmUQ
	YspiaUL6lz8YkXQpUl5XUHddW+rSGx8Sz4hF7h7eu+GrDy4IeDoA3wpNBtAs0qsBplCo
	poq9/YsvssOtwnYf2rFAm5mKYX6fL+FsVAIkmMNZgCTj2qwQiYCLjNlIXsNIqRSInxrm
	xS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=j4p8ez5vveiPF5SCbwycf3+WMS+QeeiKQ55jo6W/2Ys=;
	b=Z8hhEfj/2t/Ma0nmDH393XUNlhdjmSASYvu82bHNS51kaE7SvEXY5a3bFIvrqTYAT1
	f5J7C8z+rHkOoU8/x3tYw/Fp5IGqrZ5oxOXMBdCERGzJr6cuHCqlXWYgBgF67lzHElz3
	+EO+QIhsQruOZVmiWC8anckxDTFo71c/P0x+NBGVqYRWKNm80DYgMjmAZfXS6HVLSeQl
	LuyejCOXT+1QeZ+swKERfglqOOjrtvJdi3EZKytuB6icjvfoQWaNGviP8pDFIoLmkCnP
	S85Lmq/IBAX7Aa2DrDAnxwT3LwDIdjm4pPd+C9mYauHrNSYFArWiCsB7eFpwKqeIxeGf
	U5Hw==
X-Gm-Message-State: AOPr4FUk3asaFyJDLVVH0T/BVOHtsfZYRL2CBFlND2ndUwSxin09O5D/U3wthPqWRVsL99NS
X-Received: by 10.194.63.8 with SMTP id c8mr4099814wjs.89.1461083340148;
	Tue, 19 Apr 2016 09:29:00 -0700 (PDT)
Received: from orion.home (host109-150-176-203.range109-150.btcentralplus.com.
	[109.150.176.203])
	by smtp.gmail.com with ESMTPSA id v64sm5168806wmv.1.2016.04.19.09.28.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 19 Apr 2016 09:28:59 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Apr 2016 17:28:42 +0100
Message-Id: <1461083327-11668-6-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
References: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 05/10] toaster: prevent exception when Project.release is null
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
X-List-Received-Date: Tue, 19 Apr 2016 16:29:00 -0000

From: Elliot Smith <elliot.smith@intel.com>

Project.release can be null. This causes an exception when calling
get_all_compatible_layer_versions(), as the query to fetch
the layer versions references release.branch_name.

Add a guard to the function so that an empty queryset is returned
if the release isn't set for a project.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 68c3072..f0a8786 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -264,11 +264,17 @@ class Project(models.Model):
     def get_all_compatible_layer_versions(self):
         """ Returns Queryset of all Layer_Versions which are compatible with
         this project"""
-        queryset = Layer_Version.objects.filter(
-            (Q(up_branch__name=self.release.branch_name) &
-             Q(build=None) &
-             Q(project=None)) |
-             Q(project=self))
+        queryset = None
+
+        # guard on release, as it can be null
+        if self.release:
+            queryset = Layer_Version.objects.filter(
+                (Q(up_branch__name=self.release.branch_name) &
+                 Q(build=None) &
+                 Q(project=None)) |
+                 Q(project=self))
+        else:
+            queryset = Layer_Version.objects.none()
 
         return queryset
 
-- 
2.5.0


