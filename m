Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id C77D079AB1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 07:17:48 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w9F7Hn0T016768
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 00:17:49 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Mon, 15 Oct 2018 00:17:49 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Oct 2018 00:14:19 -0700
Message-ID: <68f3b6bb80168c02ec8c2d2c88f3f1488714cccf.1539558338.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1539558338.git.David.Reyna@windriver.com>
References: <cover.1539558338.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 3/3] toaster: missing shutil import
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
X-List-Received-Date: Mon, 15 Oct 2018 07:17:48 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The "buildimport.py" script is missing the "import shutil" line,
which causes a project import page failure.

[YOCTO #12959]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastermain/management/commands/buildimport.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b/lib/toaster/toastermain/management/commands/buildimport.py
index 9e1cd6d..2d57ab5 100644
--- a/lib/toaster/toastermain/management/commands/buildimport.py
+++ b/lib/toaster/toastermain/management/commands/buildimport.py
@@ -55,6 +55,7 @@ import os
 import re
 import os.path
 import subprocess
+import shutil
 
 # Toaster variable section delimiters
 TOASTER_PROLOG = '#=== TOASTER_CONFIG_PROLOG ==='
-- 
1.9.1


