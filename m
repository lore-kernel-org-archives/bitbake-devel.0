Received: from [209.85.210.175] (helo=mail-iy0-f175.google.com)
	by linuxtogo.org with esmtp (Exim 4.72) id 1T5PwU-00044y-P3
	for bitbake-devel@lists.openembedded.org;
	Sun, 26 Aug 2012 01:39:02 +0200
Received: by iaky10 with SMTP id y10so5854196iak.6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 25 Aug 2012 16:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=h++g269RvdUHO5wqWMze60w2h5QMjVktOgWte7+NIpE=;
	b=tpTFpTaxjZaZYQUHB3miVQDHAIHaDALMVRbDXGUNvUZ3FXUU/Z0lNuyuUsJxWNERTw
	oTaXR0w33VaTcmvHsFXil1D0EglJ9fQ7XHTCqH2ljoH/HEoCxxj9ObApdQZlxpdJWDTJ
	sjmD9JyVMoSyb+ZYG/4IJ/12YdILiTtlBlUp4nCUVAPczxsalmF3nEAXF1M95FKaMLCy
	e3F5sBpi5mohd0xqO1ObfIxZ8a7BginGuVV6L31OOw5l2t7Eqx9EjQVepIghipp0HAjd
	KjgH+Iw7mPW32AcCIil6IemKZb9y2eLYoKhFNN20De2a4f2+JjEs/8wUa6Xdh+GLolYP
	2mkw==
Received: by 10.50.94.133 with SMTP id dc5mr6102700igb.16.1345937212956;
	Sat, 25 Aug 2012 16:26:52 -0700 (PDT)
Received: from localhost.localdomain (dsl-67-55-9-50.acanac.net. [67.55.9.50])
	by mx.google.com with ESMTPS id
	ua5sm2443006igb.10.2012.08.25.16.26.50 (version=SSLv3 cipher=OTHER);
	Sat, 25 Aug 2012 16:26:51 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 25 Aug 2012 19:26:45 -0400
Message-Id: <1345937205-6119-1-git-send-email-twoerner@gmail.com>
X-Mailer: git-send-email 1.7.10-rc3
Subject: [PATCH] clarify wording in help output for -s
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
X-List-Received-Date: Sat, 25 Aug 2012 23:39:03 -0000

From: Trevor Woerner <twoerner@gmail.com>

The '-s' option shows (input) recipes, not (built/output) packages. Clarify
the help wording for this option so it is consistent with how bitbake defines
recipes and packages.
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
1.7.10-rc3



