Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f181.google.com (mail-it1-f181.google.com
	[209.85.166.181])
	by mail.openembedded.org (Postfix) with ESMTP id 73F8D7C612
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2019 21:36:55 +0000 (UTC)
Received: by mail-it1-f181.google.com with SMTP id x131so17773241itc.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2019 13:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=kJgIqVSRHdyXnbgqL38kizffN3zASoXG+Ig2v8GlwcA=;
	b=sQ9fCseFyFuZZAYujZgbISVSkEs3CbtxsKPq2H/NPGi64sOK9u1++Fd4o8ziLNXJRE
	AzClI3/bVCuRo3km4FtlwSJx8O+xTf7amwsPwtylKRDSy5Nm1tjJ0ZTWBF5CIdg9TL0I
	EcZ2RZPzsSra48f+cxds9bBLTewXoUXsu6MtZxIiAOkmKnSPLWoRF4gZYCYWGq6QuDwl
	LLK9eWRVOxRoDvdck7V25FNSp4nprTkgmkZEM2ogtXmNu5BAEqtHiM91y8xPZ9IIW0gK
	2eNgt4aCGLqV1KyROymzCzhZvV1/rCJ4L1/lA2GbP4YVSa2Aw8vDGZSpqSJRQm9U56GM
	BzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=kJgIqVSRHdyXnbgqL38kizffN3zASoXG+Ig2v8GlwcA=;
	b=EWmYTfgBGHRu3Why5BVih3auHUxPT9x9rc2tpR40rwD8rq2+w3yxAYaEMotGepVmmm
	AhCVBD65TPHzD5svZPTVpX6XFIOSN1ZJjGjm6cPoRTQ75X8wZMubdZ7Yyd592Ol5OT43
	x7ChXf0+dqDNSccsFsk9DPHKDHGUx4XwrLkra1cx8FS6SB4GwMIcQRAT+Py0eG7zzdy0
	G2BMq1KIEWoOFWi73gJzMNa9p9C303t/wMItIrqO+UILFW1MJWTp6lAZlpBdUjkbzD/m
	pwNvHs1YEheiCyQs8MAn1njg9bD/TMPZVhkXEYfMYQUpB36PpfyyE80/K8zAI0goJ7jy
	TnJw==
X-Gm-Message-State: AHQUAuZFZyurBA0fxR/s/sUUWHP5xilN4rZJYmRzth/JPe+upTpGpM89
	Elr0CZM7GGdUncpulifwfvh3hn84
X-Google-Smtp-Source: AHgI3IbO/aDz137uYJVO2trbudOmVvGmUl/jNoHXvXhVJbA6Qey1IpUiI2u0/KbwB/vTMpg0RWUdAQ==
X-Received: by 2002:a24:7b48:: with SMTP id q69mr3491669itc.31.1550180216222; 
	Thu, 14 Feb 2019 13:36:56 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	m186sm1678393ita.2.2019.02.14.13.36.54
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 14 Feb 2019 13:36:55 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Feb 2019 15:36:45 -0600
Message-Id: <20190214213645.4892-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207165603.20306-1-JPEWhacker@gmail.com>
References: <20190207165603.20306-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [PATCH v2] bitbake: Allow arguments in FAKEROOTCMD
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
X-List-Received-Date: Thu, 14 Feb 2019 21:36:55 -0000
Content-Transfer-Encoding: 8bit

Changes FAKEROOTCMD so that it can accept additional arguments to pass
to the fakeroot implementation instead of being treated as a simple
command

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 6002ccf06a8..9b2e69e543b 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -37,6 +37,7 @@ from bb import monitordisk
 import subprocess
 import pickle
 from multiprocessing import Process
+import shlex
 
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
@@ -1221,12 +1222,12 @@ class RunQueue:
         if fakeroot:
             magic = magic + "beef"
             mcdata = self.cooker.databuilder.mcdata[mc]
-            fakerootcmd = mcdata.getVar("FAKEROOTCMD")
+            fakerootcmd = shlex.split(mcdata.getVar("FAKEROOTCMD"))
             fakerootenv = (mcdata.getVar("FAKEROOTBASEENV") or "").split()
             env = os.environ.copy()
             for key, value in (var.split('=') for var in fakerootenv):
                 env[key] = value
-            worker = subprocess.Popen([fakerootcmd, "bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
+            worker = subprocess.Popen(fakerootcmd + ["bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
         else:
             worker = subprocess.Popen(["bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
         bb.utils.nonblockingfd(worker.stdout)
-- 
2.20.1


