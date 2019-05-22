Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f182.google.com (mail-it1-f182.google.com
	[209.85.166.182])
	by mail.openembedded.org (Postfix) with ESMTP id A8D157E1A2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 May 2019 19:56:55 +0000 (UTC)
Received: by mail-it1-f182.google.com with SMTP id e184so5026189ite.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 May 2019 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=dJl2DHh4p2wWOUhhqlMprn+VNLOv5JMVM7MTehkHDKk=;
	b=F2tI1+RHlHhro9EpeeXkzewGHp96QoM+gofdq7+71TFaWjGV8OzEAJsnsWtyB3C96d
	SrVLrbXtveximRL2DtamU7Tf28QWJxoiMkydvea4TRMuaEv2xNlNE9A84YqkvghSaeOp
	noHjedC1T6XhRIAjKXIb/BnTWB74kh73YX/wTqTvS9cyQ2ke9D6kI7OxiEB9gOYhzKNj
	Wx9Yw2DH08kBrI1lAxiqGzns+MfntqvIEPTLOPnVkL6rseZ8u04iFYe0hMaRx4yP6gZD
	SykY0zI1C+TQduOqr5hRIsj1lC2SUAwjWrbYHdL7B60XaI54htpJr7cR+7tae9us+Rrd
	/6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=dJl2DHh4p2wWOUhhqlMprn+VNLOv5JMVM7MTehkHDKk=;
	b=GjVp9AWtHNFqq50/hQ3dtbLoy0gGuzteAq0KASrnKboK12BLVVGDKD8wIveiSwHL05
	bMPmLiCQYVNjEMELPygIQQ947pX4+NUR24DOqO7lW7dT0ZljnOwLRC6RJGmnLLzleILO
	tFPcOe1eLRcpCXDLpD5++FgaBAt7UiT8p6tyf6KjcgT1JaouhD64c/M8CEf9i4ZR4NSQ
	WDErelHR9YEQWDSyFke6VhsCDhbDiAc6otMgNgrm+alTpktmityETxImbj6mYno+X6Yi
	Iy1XGfifoyHIk5yUqBx/7MFGFlUAye9noY29/Sn55k3NBUzoN7RvJUVYg5peiFNnIbNv
	7EXA==
X-Gm-Message-State: APjAAAW2ObhIHtMMoko6NHnaqgClZXajjkS74nepVoDbRkM9Ba6guXeT
	oQuOlD32q/dp+S9FdQ2tRLVtJ6ho
X-Google-Smtp-Source: APXvYqyoouvFf/FZYhAPZM0sEaUsnyUGLqwT7gzMQM/ojsCDe3736ObF2EAGvw2yvKr27/F94ZptAw==
X-Received: by 2002:a02:b817:: with SMTP id o23mr57928083jam.134.1558555016357;
	Wed, 22 May 2019 12:56:56 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id r12sm3218747itb.2.2019.05.22.12.56.55
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 May 2019 12:56:55 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 May 2019 14:56:50 -0500
Message-Id: <20190522195650.15359-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [PATCH] bitbake: Show base multiconfig environment
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
X-List-Received-Date: Wed, 22 May 2019 19:56:55 -0000
Content-Transfer-Encoding: 8bit

Adds support to the 'bitbake -e' command so that it can display the base
environment for a multiconfig. It was previously possible to get the
base environment for the main environment by running "bitbake -e", but
there was no support for getting the base environment for a multiconfig
without specifying a recipe. A user can now print the base environment
for the multiconfig "foo" by running:

 $ bitbake -e multiconfig:foo

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cooker.py | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 33697a71d5e..d183abab6dc 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -495,6 +495,7 @@ class BBCooker:
         """
         fn = None
         envdata = None
+        mc = ''
         if not pkgs_to_build:
             pkgs_to_build = []
 
@@ -503,6 +504,12 @@ class BBCooker:
             self.enableDataTracking()
             self.reset()
 
+        def mc_base(p):
+            if p.startswith('multiconfig:'):
+                s = p.split(':')
+                if len(s) == 2:
+                    return s[1]
+            return None
 
         if buildfile:
             # Parse the configuration here. We need to do it explicitly here since
@@ -513,18 +520,16 @@ class BBCooker:
             fn = self.matchFile(fn)
             fn = bb.cache.realfn2virtual(fn, cls, mc)
         elif len(pkgs_to_build) == 1:
-            ignore = self.data.getVar("ASSUME_PROVIDED") or ""
-            if pkgs_to_build[0] in set(ignore.split()):
-                bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
+            mc = mc_base(pkgs_to_build[0])
+            if not mc:
+                ignore = self.data.getVar("ASSUME_PROVIDED") or ""
+                if pkgs_to_build[0] in set(ignore.split()):
+                    bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
 
-            taskdata, runlist = self.buildTaskData(pkgs_to_build, None, self.configuration.abort, allowincomplete=True)
+                taskdata, runlist = self.buildTaskData(pkgs_to_build, None, self.configuration.abort, allowincomplete=True)
 
-            mc = runlist[0][0]
-            fn = runlist[0][3]
-        else:
-            envdata = self.data
-            data.expandKeys(envdata)
-            parse.ast.runAnonFuncs(envdata)
+                mc = runlist[0][0]
+                fn = runlist[0][3]
 
         if fn:
             try:
@@ -533,6 +538,12 @@ class BBCooker:
             except Exception as e:
                 parselog.exception("Unable to read %s", fn)
                 raise
+        else:
+            if not mc in self.databuilder.mcdata:
+                bb.fatal('Not multiconfig named "%s" found' % mc)
+            envdata = self.databuilder.mcdata[mc]
+            data.expandKeys(envdata)
+            parse.ast.runAnonFuncs(envdata)
 
         # Display history
         with closing(StringIO()) as env:
-- 
2.21.0


