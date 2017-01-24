Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com
	[209.85.214.44])
	by mail.openembedded.org (Postfix) with ESMTP id D079371993
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Jan 2017 16:32:34 +0000 (UTC)
Received: by mail-it0-f44.google.com with SMTP id c7so89293519itd.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Jan 2017 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=VRMrccXJc4dSdUONuJBmJ3Bp24Hf/3OO88e4Ri9sKFo=;
	b=V0uEgsSV8Yjr4zjnNfMx/jj3gqetkXDK3GX71nXEde/3yoGTdaLv5pakLnN2qDpfpU
	Xqlzbt65Ge9c+zsgcjsjo3kktewPBdZ4SX2efdHZICOARXbzP9dbxcpNYYZN9rv4isqi
	ZglVZrisvFf2NJGz+kbADzkiG2GX3KzXIzC6E0xXakVxrLcuGvuImibEgXamo5nE5ygo
	sYP6dA4+/n+b/E1vvgnAcGDI08Njg5qqIR9jCZpSGOq98oc0B9ojgAMpEQDg/f/AT5/s
	fLLHjhL2vvO5CInoQosu0/zlca4ySc3qL2ol+vHoGoOGymLTfNozP47C6cYQnuhY47+Q
	TOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=VRMrccXJc4dSdUONuJBmJ3Bp24Hf/3OO88e4Ri9sKFo=;
	b=apqB+jcsJnCs+PbB/0Eh+7KO3Blli2kQG+2pZJGisJX0tTxvr8dw/oblvFD5FImaP7
	Q3Vxw2Zl/Vd0Kkb83sCYRg1+seQu6At9hxPGYRE0rg6Oyqbiloi2QaaGDjxgUjHfCzSW
	HauwabPbH/nU7bP4PB9cra0pN/264NCLNCHxtd9gJ/5zU9QUzNk2J6q/CnqHOyRrJVEq
	Mamc8bswfuk2LggIRFUXnj/mNriqzlep0lkrczeYrwBnaqbYl9yL7AvyJ1Dvuofr2blS
	svzkykEM/Nz4rBJZDchAhwT+VeNyxg06FutOby7jKgqyoTqBsqpRFsSJJZ9kllxGUIZ6
	4mMA==
X-Gm-Message-State: AIkVDXIQ+ztmQPF5MyrphH0rMRPdrXnT4KuitWwUrwrPC1LLBF6DtmPVy2Zfl+8MknecAIGP
X-Received: by 10.36.214.216 with SMTP id o207mr19921933itg.104.1485275554640; 
	Tue, 24 Jan 2017 08:32:34 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8FC8E.dip0.t-ipconnect.de.
	[93.232.252.142])
	by smtp.gmail.com with ESMTPSA id 35sm11702510iot.6.2017.01.24.08.32.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 24 Jan 2017 08:32:33 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Jan 2017 17:32:24 +0100
Message-Id: <20170124163224.27906-1-patrick.ohly@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] build.py: avoid exception when function is not defined
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
X-List-Received-Date: Tue, 24 Jan 2017 16:32:35 -0000

exc_func() fails with a hard to debug exception when the
function does not exist, for example due to a typo:

  ERROR: ...: Traceback (most recent call last):
    File "/work/bitbake/lib/bb/build.py", line 644, in exec_task
      return _exec_task(fn, task, d, quieterr)
    File "/work/bitbake/lib/bb/build.py", line 584, in _exec_task
      exec_func(func, localdata)
    File "/work/bitbake/lib/bb/build.py", line 198, in exec_func
      cleandirs = flags.get('cleandirs')
  AttributeError: 'NoneType' object has no attribute 'get'

There is code further down which will print a warning, but we don't
reach that unless we allow None as result of of d.getVarFlags() first.

The warning is further down intentionally and has to stay there, to
ensure that 'cleandirs' gets executed also for empty functions.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/build.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index c6104a47..c08ef890 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -195,13 +195,13 @@ def exec_func(func, d, dirs = None, pythonexception=False):
         oldcwd = None
 
     flags = d.getVarFlags(func)
-    cleandirs = flags.get('cleandirs')
+    cleandirs = flags.get('cleandirs') if flags else None
     if cleandirs:
         for cdir in d.expand(cleandirs).split():
             bb.utils.remove(cdir, True)
             bb.utils.mkdirhier(cdir)
 
-    if dirs is None:
+    if flags and dirs is None:
         dirs = flags.get('dirs')
         if dirs:
             dirs = d.expand(dirs).split()
-- 
2.11.0


