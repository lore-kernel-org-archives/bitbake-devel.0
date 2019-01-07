Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
	[209.85.166.68])
	by mail.openembedded.org (Postfix) with ESMTP id 61FF07BEFE
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jan 2019 19:24:02 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id r200so1220412iod.11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 Jan 2019 11:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=xTW+b0Lcvsyxuj+MZgVrJmEkTrBM0PuGdVY/x2NpfiM=;
	b=pcjObPAtU6H92YQMhJQU3OOBCeOJ/KDvLOFxr/eNALa6nfclbYJSdwDoH3qFA57XN1
	m6NLhig9fYqHlLG2yvU6tWqRsRizSOVuM83Ok9lzhYDYlMOiQDrpADM7+fEQBmjzByzF
	NkVJQUM5DOdzphEamrEpKD9TpAFOK/1GUpj9dUlS4l5P/lIibknvvftqb4wSD2FS6Xlk
	YqJppceffacn8kuaWJysnfiiETHq/XSiV5oCnWhWF1O96DaKq5elN+MJJBvHu9/wkM26
	Nqwosx+BjKcHinabJTUt+BgGXCMgUbI4eNxfvChjwTsVJ9V+wuC9+dFXzba9HdxzZJv6
	IaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=xTW+b0Lcvsyxuj+MZgVrJmEkTrBM0PuGdVY/x2NpfiM=;
	b=aZFfKHuJFuzXYdxMX0KI30zLYJzQSvSW3HksexXsI0dK2+7LeQ6b0xdJVehYbnF0l+
	f9yAJgEPNSC7dR7GaRAS+Zh8Oypt+bnkDWHNqhJow+pFs/eP/Yn78hFKNhffgRgAge4d
	KchVORA+OKKlkGqRjl25DIiH8SYE3xksdgzmh73Qq253Pj9v/YLT+qM6CFEC/AL1p3F0
	yfgu/m2Im656Vh8miK0ELmps7s19m2uupBBzL2a+ynByCAAG6bi/4qB/0gtU8nYFLPut
	3dTpCQ9YU8HK9IKvw4iI9fHd/kl8eesjAesWojTFTI8uU+h8JWQfakgT0DO57WyLMYX+
	8aOw==
X-Gm-Message-State: AJcUukf6hlr4OuBN2Mj3TGk87nFU0OciRJS4D9obSkB7t/9EhsyDnrb+
	IzNEtXkO8pP4/3H67XvO5K3bOGCQ
X-Google-Smtp-Source: ALg8bN44PJgkLE/193r3DNONksAw+cJcHK1tlYkn4XdJ71z8NfkXEDYMh7/D0NmRNpc0bWAortyPig==
X-Received: by 2002:a6b:38d7:: with SMTP id
	f206mr42240731ioa.265.1546889043026; 
	Mon, 07 Jan 2019 11:24:03 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	j129sm4805142itb.41.2019.01.07.11.24.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 07 Jan 2019 11:24:02 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Jan 2019 13:23:52 -0600
Message-Id: <20190107192352.20747-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: alejandro.enedino.hernandez-samaniego@xilinx.com
Subject: [PATCH] bitbake: runqueue: Use multiconfig name to fetch unihash
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
X-List-Received-Date: Mon, 07 Jan 2019 19:24:02 -0000
Content-Transfer-Encoding: 8bit

The unihash should be fetched using the task filename that includes the
multiconfig prefixes.

[YOCTO #13124]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 00a14ebde06..0e6cc31f309 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1168,7 +1168,7 @@ class RunQueueData:
             procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
         (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
         self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
-        self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(fn + "." + taskname)
+        self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(taskfn + "." + taskname)
 
     def dump_data(self):
         """
@@ -1932,7 +1932,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
         (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
 
         old_unihash = self.rqdata.runtaskentries[task].unihash
-        new_unihash = bb.parse.siggen.get_unihash(fn + '.' + taskname)
+        new_unihash = bb.parse.siggen.get_unihash(taskfn + '.' + taskname)
 
         unihash_changed = old_unihash != new_unihash
         if unihash_changed:
-- 
2.20.1


