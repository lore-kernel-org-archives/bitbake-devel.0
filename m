Return-Path: <changhyeok.bae@gmail.com>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by mail.openembedded.org (Postfix) with ESMTP id 7D8E478B17
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jul 2018 00:03:10 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so6329251pgv.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 17:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=N/Ja/sbR6EfvTTdwiA/T0t0h1fJX3gkKtDMY+BGTIOg=;
	b=UNiK8ImKbgf+ZAQ6Pf/yADRBDrXysOzzDw7knokNafCUPQnrE7vlAuNh3WOC230y2G
	bMUFO7pM+YGEeE696kdqI60n7Amnt+XxW9o/bm8tu1glklVyUE7XnwDrPrYA45bV2d1X
	yc2BKfsDjhntCdc4F8cHp9iTrFA5hjJJvjVQmANnMmfdmI5furKF+HW+rxNQ0aY4uiKC
	JJi8+Y7UpN0hqYQVsq3bTtw7GbSLWPEnVkO1xT7nfVcyMlmurTW2zFeCBhDa7xhJCy1B
	M0/iNcGk4wYmHPKK/wdoYNseZF+tC95jl3xR2x3MXAC12cqarJcnZB1Byx8zbuXG5sXM
	3efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=N/Ja/sbR6EfvTTdwiA/T0t0h1fJX3gkKtDMY+BGTIOg=;
	b=hejjoJMVgbCVqP91oGGreu1ngCN6dAYGOfLj94+42R+BInbpbKUaZtkFxbyjlIF2Xr
	JVVjH3ZqPG4/Uwxb6cNMSrS4cFAghJkH6UU950WvDzE/z1/dx3xGW3G0+BOAKb6X69XO
	RZrYauCtP7/rrLgui7+OSRzy+81waXpAwQIH77r7ZToHEgpk7IzOrts8RdJjjut4/b42
	UejFykAkhjcyvafFMI0AF+qawuYg6J1Bx4BPJ8Ml3q1YpSywNMvZu6vx/MXoxFdtiwMI
	xvuhMuAI53gBmJlCMDOFnHqtEkUK6hLCRwae1PhB732pDg+E1rbAF5TZp8OfDrENPWWf
	F/FQ==
X-Gm-Message-State: AOUpUlGmpiycFDUW83PKMB3DpvsUZanzhfzqDgdCo19NECV/AW+gCrgE
	pvG02UY5eYg3GyXVjLZmGLy0MkqS
X-Google-Smtp-Source: AAOMgpchDdaKTef0t0+eT4zcTLrHHwJpPveAnrjPjihcNATjlGxg04rAceRhp4uK0MfrPsy325fYqA==
X-Received: by 2002:a63:5204:: with SMTP id
	g4-v6mr22780289pgb.274.1532563391532; 
	Wed, 25 Jul 2018 17:03:11 -0700 (PDT)
Received: from ip-172-31-26-116.ap-northeast-2.compute.internal
	(ec2-52-79-39-246.ap-northeast-2.compute.amazonaws.com.
	[52.79.39.246]) by smtp.gmail.com with ESMTPSA id
	j72-v6sm24170775pge.19.2018.07.25.17.03.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 25 Jul 2018 17:03:11 -0700 (PDT)
From: Changhyeok Bae <changhyeok.bae@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Jul 2018 00:03:05 +0000
Message-Id: <1532563385-1913-1-git-send-email-changhyeok.bae@gmail.com>
X-Mailer: git-send-email 2.7.4
Cc: Changhyeok Bae <changhyeok.bae@gmail.com>
Subject: [PATCH][1.32] fetch2: fix import error for Python 3.6.5
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
X-List-Received-Date: Thu, 26 Jul 2018 00:03:10 -0000

From: Tzu Hsiang Lin <t9360341@ntut.org.tw>

When running bitbake command with Python 3.6.5 always result in
import error causing by the change of distutils module.
This patch replaces the method to search executable in PATH by
"/usr/bin/env <command>".

Signed-off-by: Tzu Hsiang Lin <t9360341@ntut.org.tw>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Changhyeok Bae <changhyeok.bae@gmail.com>
---
 lib/bb/fetch2/clearcase.py | 3 +--
 lib/bb/fetch2/npm.py       | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 70e280a..b0b5eff 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -70,7 +70,6 @@ from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
-from   distutils import spawn
 
 class ClearCase(FetchMethod):
     """Class to fetch urls via 'clearcase'"""
@@ -108,7 +107,7 @@ class ClearCase(FetchMethod):
         else:
             ud.module = ""
 
-        ud.basecmd = d.getVar("FETCHCMD_ccrc", True) or spawn.find_executable("cleartool") or spawn.find_executable("rcleartool")
+        ud.basecmd = d.getVar("FETCHCMD_ccrc") or "/usr/bin/env cleartool || rcleartool"
 
         if data.getVar("SRCREV", d, True) == "INVALID":
           raise FetchError("Set a valid SRCREV for the clearcase fetcher in your recipe, e.g. SRCREV = \"/main/LATEST\" or any other label of your choice.")
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 699ae72..7ccaba9 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -33,7 +33,6 @@ from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
 from   bb.fetch2 import UnpackError
 from   bb.fetch2 import ParameterError
-from   distutils import spawn
 
 def subprocess_setup():
     # Python installs a SIGPIPE handler by default. This is usually not what
-- 
2.7.4


