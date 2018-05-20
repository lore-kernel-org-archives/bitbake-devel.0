Return-Path: <t9360341@ntut.org.tw>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
	by mail.openembedded.org (Postfix) with ESMTP id 5461460745
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 May 2018 14:53:45 +0000 (UTC)
Received: by mail-pg0-f65.google.com with SMTP id 63-v6so3099981pgg.3
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 May 2018 07:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ntut-org-tw.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=ydWN4TDo8SecO14rmryDwm4NZdAQAByBCeOs/zb/+04=;
	b=Umn+hDM38QeFuJ4DIMe55hKmfOh2/r3bWHEzsUpY1RSCdIZGFaZWaArHptm01ey4aF
	WOVuIac8rKNN5lcbQqSngQgxSiMSexyaIkS4+eFOvLm8/Ogcl3u0gFCUFnsdgejWrMlC
	HWMT0pizjWpHS+OL00pQO6LCvf2F0ayzbXfI4VgdtEfonkC2QUdcMhdJ5TS4cO65D7H2
	Glg4PKJPT8Dl/6VMVyAMYaMnwi368Dh8OWkmJmKOrqq16TVZ5i6ukqjlnlqDRlUZPsCw
	edVwnpVPgs8bTDLCs3ZN2SsqLkPQ69zkHXrBz9zlMPDgaZsosPJywFespYHAzL36FBah
	DU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ydWN4TDo8SecO14rmryDwm4NZdAQAByBCeOs/zb/+04=;
	b=CrWt5bfgtyn2RQbI1LKGUvmjNC+5A3I9eS1lNNpwOgb47ESUnHaQulfBhVYkIHy+Bv
	lyL7WPKVNuw7lHCIk35fzInKOwvGTYyhrMbnRIRHx7Lrh5w/Zrgv+tPOnJuxogH+7qFX
	d8SqvSoHPJDDa57s+gpjqQOEZevFeZgwpuy6Lip2cgk1RrjvOvrkRTO+qfzNQOHFJ+kv
	X4GXKzAvwMjWGsFN/Cxk1mWc98b6zu9C2hwdooVFqdi9BFI2syPxfkmJN76Pjl9pYnMM
	4X2R9ddzwMZ1C7Bfo/wHrzZ2QMnuQv+MTY/a3167YMLcAPYfC2WPWm/2xtRHq1kqVtAw
	4JCw==
X-Gm-Message-State: ALKqPwcnzxjin1Dcs7mFn5C58zmluzQ+RSQ/wYDdDgwWivyXQ5UKmWBd
	s6+4antfIw4GerNhH4jaC6KE+w+YMLE=
X-Google-Smtp-Source: AB8JxZr9W0An7e21ZQoUjEQIXUvIBWmJfLu0M+6/JjXAQs6dGfzV/mSw+Bf3EsXCYxjTp2M8HEAaQg==
X-Received: by 2002:a63:6445:: with SMTP id
	y66-v6mr4763360pgb.283.1526828026653; 
	Sun, 20 May 2018 07:53:46 -0700 (PDT)
Received: from thlin-VirtualBox.hitronhub.home
	(123-195-53-184.dynamic.kbronet.com.tw. [123.195.53.184])
	by smtp.gmail.com with ESMTPSA id
	r90-v6sm30710942pfg.122.2018.05.20.07.53.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 20 May 2018 07:53:45 -0700 (PDT)
From: Tzu Hsiang Lin <t9360341@ntut.org.tw>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 20 May 2018 22:51:52 +0800
Message-Id: <20180520145152.1619-1-t9360341@ntut.org.tw>
X-Mailer: git-send-email 2.17.0
Subject: [PATCH] Fix import spawn error on Python 3.6.5(Default Python version on Ubuntu 18.04 LTS). - Copy the find_executable() function from python3.5/distutils/spawn.py - npm.py do not need to import spawn
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
X-List-Received-Date: Sun, 20 May 2018 14:53:46 -0000

---
 lib/bb/fetch2/clearcase.py | 28 ++++++++++++++++++++++++++--
 lib/bb/fetch2/npm.py       |  1 -
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 36beab6a..28589dbc 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -69,7 +69,6 @@ from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
-from   distutils import spawn
 
 class ClearCase(FetchMethod):
     """Class to fetch urls via 'clearcase'"""
@@ -107,7 +106,7 @@ class ClearCase(FetchMethod):
         else:
             ud.module = ""
 
-        ud.basecmd = d.getVar("FETCHCMD_ccrc") or spawn.find_executable("cleartool") or spawn.find_executable("rcleartool")
+        ud.basecmd = d.getVar("FETCHCMD_ccrc") or _find_executable("cleartool") or _find_executable("rcleartool")
 
         if d.getVar("SRCREV") == "INVALID":
           raise FetchError("Set a valid SRCREV for the clearcase fetcher in your recipe, e.g. SRCREV = \"/main/LATEST\" or any other label of your choice.")
@@ -207,6 +206,31 @@ class ClearCase(FetchMethod):
             output = runfetchcmd(cmd, d, workdir=ud.ccasedir)
             logger.info("rmview output: %s", output)
 
+    def _find_executable(executable, path=None):
+        """Tries to find 'executable' in the directories listed in 'path'.
+
+        A string listing directories separated by 'os.pathsep'; defaults to
+        os.environ['PATH'].  Returns the complete filename or None if not found.
+        """
+        if path is None:
+            path = os.environ['PATH']
+
+        paths = path.split(os.pathsep)
+        base, ext = os.path.splitext(executable)
+
+        if (sys.platform == 'win32') and (ext != '.exe'):
+            executable = executable + '.exe'
+
+        if not os.path.isfile(executable):
+            for p in paths:
+                f = os.path.join(p, executable)
+                if os.path.isfile(f):
+                    # the file exists, we have a shot at spawn working
+                    return f
+            return None
+        else:
+            return executable
+
     def need_update(self, ud, d):
         if ("LATEST" in ud.label) or (ud.customspec and "LATEST" in ud.customspec):
             ud.identifier += "-%s" % d.getVar("DATETIME",d, True)
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 730c346a..408dfc3d 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -32,7 +32,6 @@ from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
 from   bb.fetch2 import UnpackError
 from   bb.fetch2 import ParameterError
-from   distutils import spawn
 
 def subprocess_setup():
     # Python installs a SIGPIPE handler by default. This is usually not what
-- 
2.17.0


