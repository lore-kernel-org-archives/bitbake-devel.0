Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id B6D0C768C8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 17:27:27 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so144911939wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 10:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=wTcOtHc699y1L/1+6woQDWEFwcQBVGtOwa86SA4MKBg=;
	b=Q8kZRonoPgV8dhnJCkixZeANsn+Nos5UMQQe3VAzGTIRmHpmlk0zDW6Uc51UNvdmSn
	VffJ62CGTlE9ZYLteTAN6sKayqQeqseud9DUriZKHShWO3iwWbSVSAdZUuUj628oh8jb
	fK2I8EOylLmZwXDftnDUPIHXPEsTbPoP4rev9phJ21hHGhAi9A4Oa0dihdJKJkhJ6MxZ
	6mWEQ2+bJ3JFwNlsTWzdP9PqrSGkwFAHX6fo1ouBu8ENKBfjuyfuz99qa9ODN2ZVPLAV
	eLL2Xll6IFgY+tPklYaPuKhfXh/SLbj5WQ2GdT47BPJeu4Yr2RU3j+22pJzy092y5PaT
	1X2g==
X-Gm-Message-State: ALoCoQleQxBy162gjpKS+NBUQfql/u4S1yPVRUhPWYWhzOODUJbl6uJMsvGXN1XPk2kle4CQBOww
X-Received: by 10.194.78.143 with SMTP id b15mr50886210wjx.88.1439227647641;
	Mon, 10 Aug 2015 10:27:27 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	cw8sm30396731wjb.49.2015.08.10.10.27.26
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 10:27:27 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 18:27:13 +0100
Message-Id: <735d499213a78c6c29b9b0b82a9bbb19b3a990bc.1439226591.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
	<dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
Subject: [PATCH 06/11] toaster: remove unused import
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
X-List-Received-Date: Mon, 10 Aug 2015 17:27:28 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Fixed pylint warning:
    Unused Build imported from orm.models (unused-import)

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 9755a88..624ab7c 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -1,6 +1,6 @@
 from django.test import TestCase
 from django.core.urlresolvers import reverse
-from orm.models import Project, Release, BitbakeVersion, Build
+from orm.models import Project, Release, BitbakeVersion
 from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer
 from orm.models import Layer_Version, Recipe, Machine, ProjectLayer
 import json
-- 
2.1.4


