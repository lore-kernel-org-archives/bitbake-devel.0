Received: from [209.85.210.175] (helo=mail-iy0-f175.google.com)
	by linuxtogo.org with esmtp (Exim 4.72) id 1T4hra-0002fO-2p
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Aug 2012 02:35:02 +0200
Received: by iaky10 with SMTP id y10so2253697iak.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Aug 2012 17:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=ZyDLNuE/1fOUj44ab9iIsaPQQZ96r9wd2i+hfQ7RZ78=;
	b=Z286e2Fyrdwo6Ub/ZVlY/kjeF/F7mza7wLI6Vps6VOL6VQqG9SS02+rHQgkCZS7lyf
	WKD6J3a06Cly7bbGdWujZxFskgmolOD/+ZNZ2hGc5RCnqtDcf5m3pEHK72zsHC86cmFz
	5x0R5GENPxHJdHieVDG4OV0R38fDwB0q2UJkfTyZMvNK9dLDrVTjcm0wBG1sInU/1l/1
	4j0NL7u+YsWlHDlj00NeR97xvyhDmsvqEeIwfDZokdHMKZSDTnQj+lh02PfrXV0aKRUk
	9kSI2rgDBXrMziY7/CrL5woDi51MHxV7jcS6U+zLJq6GJHG402ut6xifTQTfqjTe3KC2
	F1mw==
Received: by 10.50.76.202 with SMTP id m10mr220860igw.52.1345767774692;
	Thu, 23 Aug 2012 17:22:54 -0700 (PDT)
Received: from localhost.localdomain (dsl-67-55-9-50.acanac.net. [67.55.9.50])
	by mx.google.com with ESMTPS id wm7sm2046923igb.6.2012.08.23.17.22.52
	(version=SSLv3 cipher=OTHER); Thu, 23 Aug 2012 17:22:53 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Aug 2012 20:22:40 -0400
Message-Id: <1345767760-5516-1-git-send-email-twoerner@gmail.com>
X-Mailer: git-send-email 1.7.10-rc3
Subject: [PATCH] clarify wording
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 24 Aug 2012 00:35:02 -0000

From: Trevor Woerner <twoerner@gmail.com>

The '-s' option shows (input) recipes, not (built/output) packages. Clarify
the help wording for this option so it is consistent.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 bin/bitbake |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake b/bin/bitbake
index 0b4f556..ed2ff06 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -142,7 +142,7 @@ Default BBFILES are the .bb files in the current directory.""")
     parser.add_option("-p", "--parse-only", help = "quit after parsing the BB files (developers only)",
                action = "store_true", dest = "parse_only", default = False)
 
-    parser.add_option("-s", "--show-versions", help = "show current and preferred versions of all packages",
+    parser.add_option("-s", "--show-versions", help = "show current and preferred versions of all recipes",
                action = "store_true", dest = "show_versions", default = False)
 
     parser.add_option("-e", "--environment", help = "show the global or per-package environment (this is what used to be bbread)",
-- 
1.7.10.GIT



