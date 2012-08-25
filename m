Received: from [209.85.210.175] (helo=mail-iy0-f175.google.com)
	by linuxtogo.org with esmtp (Exim 4.72) id 1T564K-0002z1-Uw
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Aug 2012 04:25:49 +0200
Received: by iaky10 with SMTP id y10so4581498iak.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Aug 2012 19:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=znimFJHnUSiJiS6UGfxHj2a3VFmtJheNHUKtgn9VGtI=;
	b=zNUqOLXR5uo7uX59NsmsWQIIABUVXTwUZWVEu6HthFcEQSo3HlrRO89txnhzU/bOdk
	oQxSlleMDyjAT+TKuSnfuFP5MLZgPPcvkxBCIMaGLi7qXzCbWL8fs6hfrFzyNiOvCJ/F
	7UF8MHtq5KxvGRV4VoentvCYhVBSwLwJeDcO89fVYWPbtf/LL0Ln8yQaXyrsI/5Z5Drc
	z9ITwg0+QWVo7y1pBfvKBOTCjAwUDf5TlE2ycFFRUo7AymqTrtcQ9E6eq/LvzSjQR04L
	ilRcJP/SSfT/L1PqdqzgkSj7TFeYixOKEhvVLh1DywqUGbKpxSU8bqk3PkGGU9LoeDyJ
	GnZg==
Received: by 10.43.97.8 with SMTP id ci8mr6029023icc.28.1345860820138;
	Fri, 24 Aug 2012 19:13:40 -0700 (PDT)
Received: from localhost.localdomain (dsl-67-55-9-50.acanac.net. [67.55.9.50])
	by mx.google.com with ESMTPS id fu4sm212354igc.4.2012.08.24.19.13.37
	(version=SSLv3 cipher=OTHER); Fri, 24 Aug 2012 19:13:38 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Aug 2012 22:13:17 -0400
Message-Id: <1345860797-4302-1-git-send-email-twoerner@gmail.com>
X-Mailer: git-send-email 1.7.10-rc3
Subject: [PATCH] bitbake: clarify help wording
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
X-List-Received-Date: Sat, 25 Aug 2012 02:25:49 -0000

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
1.7.10-rc3



