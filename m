Return-Path: <straka.derek@gmail.com>
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com
	[209.85.220.174])
	by mail.openembedded.org (Postfix) with ESMTP id 187136018C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Mar 2016 12:08:44 +0000 (UTC)
Received: by mail-qk0-f174.google.com with SMTP id p130so18505581qke.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Mar 2016 05:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=jOiMOg0DTugayI8B7PP7FhwoSWqcnV1sy8bo+8aN80Q=;
	b=Pw86ULf/ojuFSpP/yyncHmWfGD5HarM5ransosPZt2ls3rvwTFPIR+kWnCUpw66A6K
	Xa4nOdhjHkD8k0qq0g/OvY0t+f5+Vk+yBUQTiFHcLHAXn2jhHNATAs4jvd94HVmX1KOC
	ifRk3L00ka7uBEwTZNt3lj+8va9adeAoOim0oiU89FnfmBzBTTCJCxpF6KiLEFEihgWT
	DFLx5+mKP0Is57OrlIu8K+MrGGMXMaD+fB/j81PP8XkhjVMpFD+a19TgWZJb9/z91nqG
	H7HgcDs8JUhHmRN3tP488ogBZzslsdADskEb+Yh2DqIKbsAw4xiyXPPQcjL8E7zTj2LA
	J2oQ==
X-Gm-Message-State: AD7BkJIRqiz/Lij8aifvGgpATDGOvVNU6vHYN0sYj/iPcs3TvgpwBl18NjMy71xgN/ouUw==
X-Received: by 10.55.20.223 with SMTP id 92mr9817450qku.61.1458821324760;
	Thu, 24 Mar 2016 05:08:44 -0700 (PDT)
Received: from localhost.localdomain ([96.91.222.230])
	by smtp.gmail.com with ESMTPSA id 43sm3165933qgh.28.2016.03.24.05.08.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Mar 2016 05:08:44 -0700 (PDT)
From: Derek Straka <derek@asterius.io>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Mar 2016 08:08:35 -0400
Message-Id: <1458821315-25577-1-git-send-email-derek@asterius.io>
X-Mailer: git-send-email 1.9.1
Cc: Derek Straka <derek@asterius.io>
Subject: [PATCH] bitbake: fetch2/gitsm: Fix fetch when the repository contains nested submodules
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
X-List-Received-Date: Thu, 24 Mar 2016 12:08:47 -0000

This fixes a problem when the repository contains multiple levels of submodules via a resursive submodule init.

Signed-off-by: Derek Straka <derek@asterius.io>
---
 bitbake/lib/bb/fetch2/gitsm.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index 2ecea7c..752f1d3 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -110,8 +110,7 @@ class GitSM(Git):
         os.chdir(tmpclonedir)
         runfetchcmd(ud.basecmd + " reset --hard", d)
         runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d)
-        runfetchcmd(ud.basecmd + " submodule init", d)
-        runfetchcmd(ud.basecmd + " submodule update", d)
+        runfetchcmd(ud.basecmd + " submodule update --init --recursive", d)
         self._set_relative_paths(tmpclonedir)
         runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*false/bare = true/'", d)
         os.rename(gitdir, ud.clonedir,)
@@ -132,6 +131,4 @@ class GitSM(Git):
         submodules = self.uses_submodules(ud, d)
         if submodules:
             runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d)
-            runfetchcmd(ud.basecmd + " submodule init", d)
-            runfetchcmd(ud.basecmd + " submodule update", d)
-
+            runfetchcmd(ud.basecmd + " submodule update --init --recursive", d)
-- 
1.9.1


