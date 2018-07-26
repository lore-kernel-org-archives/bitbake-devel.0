Return-Path: <changhyeok.bae@gmail.com>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail.openembedded.org (Postfix) with ESMTP id 0EF1A78AD9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jul 2018 00:26:57 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id s7-v6so6353618pgv.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 17:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=rg0wgy/lpFHENSkoMU1Vu2XVW1JDCqkV5tpzWspehoE=;
	b=BjbVnXiNWQmOw6HxClvPo26YqjxDK8vgOgpVBGkfgUp7xIpiMm8TdOyrw+GTccayYT
	UU/G/mKqjMwL2WZiUTUgofwKhIa4zkOfoBsgXESBbncXdC+N6l1Re+FO3jw4MTGfRA7P
	ad4Rmm1HpVWZkh56ylTeFyFc8EVnIYXCqLkYg9RHWO54SSjoPdq2YdHig908YxKiPNIp
	vFYPmD4BY4f1sRNnh1UAFDgiUjuftYUDJ/zIYh202AY8d4mKjkWC81VF1MqBbLN3izF7
	S+N858CeZreIYCaWuxbIoSGmuMTM4idZVDhPitcDRDjwZue/HCVaqC+ghodIyebT87yE
	DzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=rg0wgy/lpFHENSkoMU1Vu2XVW1JDCqkV5tpzWspehoE=;
	b=SnJkgk0dgr+H1QnvtQjgAi0lK5Ft4/Y2hM3HepMSmrMGNPVvugKMAiG41X8j5gG7Pa
	F9LbLp2y7lhhtAVDW0/Oghz8ZBZP6Lkokff5iG+fan1T9Nd3qYd2zxSe6ZDRKWqHiGXk
	xoWUaQAplaJ3uRaVSd2QbwquqXhCK1S2yKy4SG9qzER4OBlcVSb+Mb/joFwFCVmMI1wz
	tS6zBQLCQNFTTSWM3CXQB66IlFUr0jnJiBNy2XJBp2QKJgwR/ZnIu42as7n9qOW8Tn+w
	cPgPH/FLVozSMt7zL5WdEhIgsRl0oCko9cIWY9v0gjgckmNWO2KbIyHNPaySk9dxKbl7
	4A2g==
X-Gm-Message-State: AOUpUlHBlH7bq2L17bQUF2v7WHnxxC8hDVFPFc3EvufPi5AM0I7/ptXb
	BinQqBpN9ad+12333L0qDZTfS+JE
X-Google-Smtp-Source: AAOMgpcux83eFujZasi2apbV5QcVtvD00Wg+E9hPF2W/WcLNLW4q+/cUCJzbTlMvPyjQi+pnx84Xaw==
X-Received: by 2002:a62:21c3:: with SMTP id
	o64-v6mr24228188pfj.21.1532564818750; 
	Wed, 25 Jul 2018 17:26:58 -0700 (PDT)
Received: from ip-172-31-26-116.ap-northeast-2.compute.internal
	(ec2-52-79-39-246.ap-northeast-2.compute.amazonaws.com.
	[52.79.39.246]) by smtp.gmail.com with ESMTPSA id
	k64-v6sm19887047pgd.47.2018.07.25.17.26.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 25 Jul 2018 17:26:58 -0700 (PDT)
From: Changhyeok Bae <changhyeok.bae@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Jul 2018 00:26:50 +0000
Message-Id: <1532564810-2025-1-git-send-email-changhyeok.bae@gmail.com>
X-Mailer: git-send-email 2.7.4
Cc: Changhyeok Bae <changhyeok.bae@gmail.com>
Subject: [PATCH v2][1.32] fetch2: fix import error for Python 3.6.5
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
X-List-Received-Date: Thu, 26 Jul 2018 00:26:58 -0000

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
index 70e280a..41cd46f 100644
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
+        ud.basecmd = d.getVar("FETCHCMD_ccrc", True) or "/usr/bin/env cleartool || rcleartool"
 
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


