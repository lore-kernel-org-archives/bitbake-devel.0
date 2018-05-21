Return-Path: <t9360341@ntut.org.tw>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
	by mail.openembedded.org (Postfix) with ESMTP id 6F9A274E98
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2018 17:58:00 +0000 (UTC)
Received: by mail-pg0-f66.google.com with SMTP id n9-v6so6680638pgq.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2018 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ntut-org-tw.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=BmiZ1yP2+SQj45eC3D+leahSUAyQW/6bMlQW5fv2ut4=;
	b=u4wv+QBjSW17A1dNIkpvnJ1jBB9+2HYwcBGO91eIT3Z0ycsOuB30vqmXjMv3TAt5RT
	IyxFMA9LgR/FYnpsy7LJVwW6tJw/hlHs11HFxv9jwukCE6Atk9hredBLXpxw0mGQUjIf
	HCqEcxa48IyicbaccbIE0ogliToYmto4OfFwLZjWFU4RVhzx5MUbful3yUdz66dHFKTD
	Iu3wvY679UAHzsIT+QajNE+t+AjvA+7Az9kMLODKfeQ66okfgMkTTy4iKPDWL86THWSA
	ZoteKzxL32/0x1iEpDv6uZOtJWbMeKvLrovA8q7thYqU5aEmx+N1EuhVFzTxP0s1r3dI
	cWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=BmiZ1yP2+SQj45eC3D+leahSUAyQW/6bMlQW5fv2ut4=;
	b=pVoBLUd9cQs1/w8dX4uFN/JG4ZntvjwT7Ov0Zc7m+03IwM54lqNiwqFWmHXb/st27r
	g5ClO9dQuBiK3dwkEfjDcJnvMbwJANV0tZr3MPgsAEhuSqEUn4uDo4VKVSymqHpkfgB+
	ATy/PlIxUrKCecEYMEGDlJt9aSszn6sHfqvJjJSRb2rALOk7zWXCUaNLojjl50LXdS5o
	G6wE67rTarFTdO9iC0I61teLpblJM9g8jkjzVoamMTlMdxbv3Eiv1m7HvdepC571/q28
	x97hBlb1txEJRWitJ7I3WsRU5wxFDo7ZqAYMWT9ZgszxpdflSN6IpH2QkXx0dgXxeIOv
	hiug==
X-Gm-Message-State: ALKqPwd/m08wDdE8ihuFIbjrwlqCn7j24Y0c20nEUuozcRLWDJ/aqKbH
	3xYXhWoV8ueNbt6WIbObnAZWW/EPa5I=
X-Google-Smtp-Source: AB8JxZqoF8izs2R/hW7acbPvx/1ztMahz4yTTF1qKrJGQvrRvlTUmAm0eKFYLmIBKaLCfspsFisuMw==
X-Received: by 2002:a65:60d1:: with SMTP id
	r17-v6mr16824033pgv.410.1526925480959; 
	Mon, 21 May 2018 10:58:00 -0700 (PDT)
Received: from thlin-VirtualBox.hitronhub.home
	(123-195-53-184.dynamic.kbronet.com.tw. [123.195.53.184])
	by smtp.gmail.com with ESMTPSA id
	c7-v6sm40190247pfg.81.2018.05.21.10.57.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 May 2018 10:57:59 -0700 (PDT)
From: Tzu Hsiang Lin <t9360341@ntut.org.tw>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 May 2018 01:56:44 +0800
Message-Id: <20180521175644.3189-1-t9360341@ntut.org.tw>
X-Mailer: git-send-email 2.17.0
Subject: [PATCH] fetch2: fix import error for Python 3.6.5
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
X-List-Received-Date: Mon, 21 May 2018 17:58:00 -0000

When running bitbake command with Python 3.6.5 always result in
import error causing by the change of distutils module.
This patch replaces the method to search executable in PATH by
"/usr/bin/env <command>".

Signed-off-by: Tzu Hsiang Lin <t9360341@ntut.org.tw>
---
 lib/bb/fetch2/clearcase.py | 3 +--
 lib/bb/fetch2/npm.py       | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 36beab6a..3a6573d0 100644
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
+        ud.basecmd = d.getVar("FETCHCMD_ccrc") or "/usr/bin/env cleartool || rcleartool"
 
         if d.getVar("SRCREV") == "INVALID":
           raise FetchError("Set a valid SRCREV for the clearcase fetcher in your recipe, e.g. SRCREV = \"/main/LATEST\" or any other label of your choice.")
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


