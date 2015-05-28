Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 0E60773236
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:18:12 +0000 (UTC)
Received: by wgbgq6 with SMTP id gq6so37860721wgb.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=AECDWBaY3Fhvvc3wJIStiFG7hApo7b3z2LDtaY78kKs=;
	b=baATGinX7BFUQnDcw55CNJUclGUksJO1r5d/wEYRN67y6bdQfiqUp9VmkBzr1fwxQ4
	lY5jF1EfO+eDf2EwBmABZ6OXxHEY3y0sxmwejb1uc2sIsfvusIMsGKJAfavwiKTEA8rR
	psHNeElXzagAFOsJH3OUMopRSVB2zUvKTK1Ih54P5KSvDYY3eXc8+cwX1uK2FD8y8lNy
	UzPf+sMpuvVpcCCPiRg6GYeOa5EW1hNytqOqVKbLIntR5Kfn1IFdTNTBUPyO/HI97XVC
	SFYQ/Nwcvqq6IhmLGNvR7cO4w9myfcYVu7LpTOzIDIJUZQ70svV/UTdC4vP1VTK75EVK
	5wAA==
X-Gm-Message-State: ALoCoQlYyQJwVXMOXOqutfQDDASmogLBE1KgLVTlg8m5DxHilx756jnYHLD7lYh8JplKCCGRjK7/
X-Received: by 10.180.218.108 with SMTP id pf12mr18945491wic.93.1432822693292; 
	Thu, 28 May 2015 07:18:13 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id bm9sm3572738wjc.21.2015.05.28.07.18.12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:18:12 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D668A56175C; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:14 +0100
Message-Id: <105c22e3fb49bfb517e2c55783feec4a0d5ab8b6.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 20/22] bitbake/: toaster tts: fix tests
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
X-List-Received-Date: Thu, 28 May 2015 14:18:15 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/contrib/tts/backlog.txt | 2 --
 lib/toaster/contrib/tts/launcher.py | 2 +-
 lib/toaster/contrib/tts/runner.py   | 2 +-
 lib/toaster/contrib/tts/tests.py    | 2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)
 delete mode 100644 lib/toaster/contrib/tts/backlog.txt

diff --git a/lib/toaster/contrib/tts/backlog.txt b/lib/toaster/contrib/tts/backlog.txt
deleted file mode 100644
index 6f92f7a..0000000
--- a/lib/toaster/contrib/tts/backlog.txt
+++ /dev/null
@@ -1,2 +0,0 @@
-michaelw/toaster-frontend-cleanups|PENDING
-adamian/test_0|PENDING
diff --git a/lib/toaster/contrib/tts/launcher.py b/lib/toaster/contrib/tts/launcher.py
index 5b63bc1..90c6d95 100755
--- a/lib/toaster/contrib/tts/launcher.py
+++ b/lib/toaster/contrib/tts/launcher.py
@@ -87,7 +87,7 @@ if __name__ == "__main__":
         errtext = None
         out = None
         try:
-            out = shellutils.run_shell_cmd("./runner.py %s" % next_task)
+            out = shellutils.run_shell_cmd("%s %s" % (os.path.join(os.path.dirname(__file__), "runner.py"), next_task))
             pass
         except ShellCmdException as e:
             print("Failed while running the test runner: %s", e)
diff --git a/lib/toaster/contrib/tts/runner.py b/lib/toaster/contrib/tts/runner.py
index d2a6099..f55c493 100755
--- a/lib/toaster/contrib/tts/runner.py
+++ b/lib/toaster/contrib/tts/runner.py
@@ -168,7 +168,7 @@ def read_settings():
 # cleanup !
 def clean_up(testdir):
     # TODO: delete the test dir
-    #run_shell_cmd("rm -rf -- '%s'" % testdir)
+    run_shell_cmd("rm -rf -- '%s'" % testdir)
     pass
 
 if __name__ == "__main__":
diff --git a/lib/toaster/contrib/tts/tests.py b/lib/toaster/contrib/tts/tests.py
index 3d4cfea..2e630db 100644
--- a/lib/toaster/contrib/tts/tests.py
+++ b/lib/toaster/contrib/tts/tests.py
@@ -44,7 +44,7 @@ class TestPySystemStart(unittest.TestCase):
 
     def test_start_interactive_mode(self):
         try:
-            run_shell_cmd("bash -c 'source %s/oe-init-build-env && source toaster start && source toaster stop'" % config.testdir, config.testdir)
+            run_shell_cmd("bash -c 'source %s/oe-init-build-env && source toaster start webport=56789 && source toaster stop'" % config.testdir, config.testdir)
         except ShellCmdException as e:
             self.fail("Failed starting interactive mode: %s" % (e))
 
-- 
1.9.1


