Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 70B6E77195
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 17:43:46 +0000 (UTC)
Received: by pacfv9 with SMTP id fv9so52243693pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 10:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=qCzXA01cA752S9t/hBO/i5ttX4KKogmNO7ghjgcExII=;
	b=P5zLZoRYUtLPT35ldULqrxXk7NpsOwqJN2bWoFCajq5hb7P2OMvy5o6rD7Jt1tY01e
	pQYJrBeHNhdjbQtwebWzVQKio+B/JdchfnQMqGdA0UE57nXII6EhJRd03BSDiu3z3gVl
	VaOWOGETlqvmI43isTYUvR+mvwoRO9YxrehtNTNj3d3Bxg0XklQhggeHwM4pjv2+myLA
	Wa99+f9gLCXkexKCiYjX7YskWqacrs54elldXPzLa3crvG/EdTSnGm239ow+2ACQ9ype
	API+9f/WWGZJ3BSCIk5X+2HK8t4At50TRG8P8FP/Rxk5yYGjAKOiNFzid23lVLlYdSu0
	31EA==
X-Received: by 10.68.137.202 with SMTP id qk10mr24212953pbb.30.1445103827032; 
	Sat, 17 Oct 2015 10:43:47 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	bn1sm27888794pad.17.2015.10.17.10.43.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 17 Oct 2015 10:43:46 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 17 Oct 2015 10:45:52 -0700
Message-Id: <071584e9032d50ba4f0090623150220c85a5b7b1.1445103849.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <27aab0077a5ef4f49d5b1f3a94f7872836054ad4.1445103849.git.avery.brian@gmail.com>
References: <27aab0077a5ef4f49d5b1f3a94f7872836054ad4.1445103849.git.avery.brian@gmail.com>
In-Reply-To: <cover.1445103849.git.avery.brian@gmail.com>
References: <cover.1445103849.git.avery.brian@gmail.com>
Subject: [PATCH 5/6] toaster: Run tests in build mode
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
X-List-Received-Date: Sat, 17 Oct 2015 17:43:46 -0000

From: Elliot Smith <elliot.smith@intel.com>

Now that the UI content is conditional on whether BUILD_MODE
is active, modify the existing tests so that they run in
this mode by default.

[YOCTO #8514]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/tests.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 29dd7fd..9e6c46a 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -32,6 +32,8 @@ from orm.models import Layer_Version, Recipe, Machine, ProjectLayer, Target
 from orm.models import CustomImageRecipe, ProjectVariable
 from orm.models import Branch
 
+import toastermain
+
 from toastergui.tables import SoftwareRecipesTable
 import json
 from bs4 import BeautifulSoup
@@ -40,6 +42,10 @@ import re
 PROJECT_NAME = "test project"
 CLI_BUILDS_PROJECT_NAME = 'Command line builds'
 
+# by default, tests are run in build mode; to run in analysis mode,
+# set this to False in individual test cases
+toastermain.settings.BUILD_MODE = True
+
 class ViewTests(TestCase):
     """Tests to verify view APIs."""
 
-- 
1.9.1


