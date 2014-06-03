Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 925F96B8B8
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Jun 2014 15:26:19 +0000 (UTC)
Received: by mail-wi0-f176.google.com with SMTP id n15so6682970wiw.15
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Jun 2014 08:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=GM86riqI5zRrZxooS5TySdJLYr2IgPfkFuUbhdJyuAI=;
	b=k4CzRVraNNpuww5fknnnJL1s/bl+Aum1VBPTrdWJIugiXUORA1OORqPLhxRWP1QyL+
	BLMXOXs/PjJKEyeVfy0qxSzfmTnKIcSH0ZrnZ4SfF4c1FEX9MnvuMxYycKKbgyeAGr2f
	PE2OauEqqR+8ciJoORyaGBOZQRh1plZSSdaq244M65fs7yN2PZMPlKICzRjMDvMu9mjC
	ED8M0JuD0RzoOO5ij5uv95IWAsoiq+HhGc2yzuJR/B9cpykLGPzAq4VVcfdvjT9q9RVC
	Lto+WuOTQNVC0RXDyeK4auuQuo2sdPF2XDI0thB5m73vMjUg1kLUx6IdVobven+wkmQz
	QFIg==
X-Gm-Message-State: ALoCoQkujagdL+6wpYSbahYuRuCd3budKtdYh8nJuDRMvvmPXfv+reDMDT2EXukDZa8eBaFngSsn
X-Received: by 10.194.238.65 with SMTP id vi1mr16644103wjc.84.1401809180066;
	Tue, 03 Jun 2014 08:26:20 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id bj2sm3768251wib.3.2014.06.03.08.26.18
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 03 Jun 2014 08:26:18 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id D826B562053; Tue,  3 Jun 2014 16:26:18 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Jun 2014 16:26:18 +0100
Message-Id: <c103c988f5fbfb47f1757af2dc22d2c23e3ef861.1401808899.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
References: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1401808899.git.alexandru.damian@intel.com>
References: <cover.1401808899.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 9/9] toasterui: fix django settings environment value
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
X-List-Received-Date: Tue, 03 Jun 2014 15:26:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Previously, the buildinfohelper only set a django settings module
environment variable if none were set.

This may lead to problems when the starting the toasterui
from an already existing Django environment.

As such, we always override the variable to provide the
correct name for the local Django settings module.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 6965570..58df687 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -22,7 +22,7 @@ import bb
 import re
 import ast
 
-os.environ.setdefault("DJANGO_SETTINGS_MODULE", "toaster.toastermain.settings")
+os.environ["DJANGO_SETTINGS_MODULE"] = "toaster.toastermain.settings"
 
 import toaster.toastermain.settings as toaster_django_settings
 from toaster.orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage, HelpText
-- 
1.9.1


