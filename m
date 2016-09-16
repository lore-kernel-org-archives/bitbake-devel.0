Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id 61AC5731D7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:22:57 +0000 (UTC)
Received: by mail-pa0-f44.google.com with SMTP id wk8so27411159pab.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=xFXI57p6Ddtbx8bv8ooZckuxY9H7a7KgdAKHNfTj++c=;
	b=moxlM84IjYTvAYg8E89G1VFeJuWYUSrSOohd3UclSmAie+7sqW+RY97TDwVnF7fzW9
	C+NjRlf1YIOlW5+arL7ZyPhXz9i0rfFgxgHomhfo6+fPmg0EUjFB8zwa4xVyncmGmId7
	ZOrJ3rBW4xw+l+ToxGOeIjBtp+V6lQuwhivPGM7+I4H/a1XHIBZgPEs+myNpzGVVMACg
	O/x8d+zwVOmQW8LuqqB1//XAQFMjRJhxe/G5mC55SaG1+RvY0lS6w1NnPYq8S9lKxoKw
	3dU76Yg8Z4MVwJnqMNSfBASAmXz9w/5SUlvbCTB0UWeGact/+0hoVI2xwjLUC2kvMvFH
	w7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=xFXI57p6Ddtbx8bv8ooZckuxY9H7a7KgdAKHNfTj++c=;
	b=IsWKnkRfVwuqIlO4MGVwkr+cyew90cittlIiEz0TjuojbwrK4SysYwLmRoNWIrGu5e
	LchODv3uTTmxd+vmI+NTqadtZmXrxuzUvRfL5PsJgBQlXRqWown0DaMpbhw02sBGyKtz
	Uu0sn1QtXo5qjFhTLTUfq/m+Ix1OcHl2fqVhsLWXrmyHI9jN8yhVejJh8Xw8Cdbq+em/
	83cIhitqEK/CVnhNm2R6iHpdjPC/2uU0OXAdH0Alt4x+1JK1dc9fSvGZQkwOCbSJtOyz
	i1IDmZ8ZjSDOVOum2ZXonOPpxy1jWdA0/l7Kl3xKrhyMmGWBuABhwzl3p76Im9zPZDJQ
	buMA==
X-Gm-Message-State: AE9vXwN1x9R+B0Y9pLcMbrx6E2fEvr0FtFlapWAyf2AdhCPqc75mGE58ArlcbcAGUbMddsvZ
X-Received: by 10.66.5.5 with SMTP id o5mr24329639pao.38.1474042978371;
	Fri, 16 Sep 2016 09:22:58 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	bm8sm13336146pac.16.2016.09.16.09.22.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 09:22:57 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2016 17:22:34 +0100
Message-Id: <1474042955-12618-8-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
References: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 7/8] runbuilds: code cleanup - remove unused imports
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
X-List-Received-Date: Fri, 16 Sep 2016 16:22:57 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Fixed pylint warning:  W0611(unused-import): Unused import

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 3421726..7f7a5a9 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -1,17 +1,14 @@
-from django.core.management.base import NoArgsCommand, CommandError
+from django.core.management.base import NoArgsCommand
 from django.db import transaction
 from django.db.models import Q
 
 from bldcontrol.bbcontroller import getBuildEnvironmentController
-from bldcontrol.bbcontroller import ShellCmdException, BuildSetupException
 from bldcontrol.models import BuildRequest, BuildEnvironment
 from bldcontrol.models import BRError, BRVariable
 
-from orm.models import Build, ToasterSetting, LogMessage, Target
+from orm.models import Build, LogMessage, Target
 
-import os
 import logging
-import sys
 import traceback
 import signal
 
-- 
2.7.4


