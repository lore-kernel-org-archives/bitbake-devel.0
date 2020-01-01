Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
	[209.85.221.52])
	by mail.openembedded.org (Postfix) with ESMTP id 1DB106C102
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jan 2020 11:03:09 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id q6so36738196wro.9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 Jan 2020 03:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=jVV+li5LJx6SqrhSyEaU2w65Q/Q8GjO5Uem/nwO3rpg=;
	b=b5+v1Zt0zTDSpbOyXiVkzPzj9Zg74lFVpk/xvXGc0VEDJSMS57WPdj2Jjm06ppvVeJ
	F4a3OOEhJIVBB2Se4QOclepP9gCu70dkcUtJqkK4HspXNijSMWBtPzbSm/wD8S+6dsmL
	leZK1ZKWj4KFtNqb41l7dLyXObiVKsNlXbTOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=jVV+li5LJx6SqrhSyEaU2w65Q/Q8GjO5Uem/nwO3rpg=;
	b=tcsY9OtE2QHJTKimaCQEtJJcbP1PKY9HE1OVx1AzfIyQmTpVtX4T5qzWesxZMC9hVz
	UA9iH1oZEMwL7b/ONBGmoy3qfLNcERHwXON3LwjEhW/vW7OP6gmcfM9Undt8jmw7uCSw
	r4lyvrH5G2l4pE+kRCt2Xte6mPSSwTKPfSV8xYMIcqiOfFp6yLmdZRI1fng36iGiulhb
	6nzvSIKE0Abc5GWeJg94vj8tTpkWjdcF+UdchfvsfIALIR2fmVwJCrUz3mCkOT+ePOOL
	Q1zbDWsn77e50tPkG/AOc+CjV4+fzZBOU2h38AhmMI35PQRYXVREtRLzwhGhB/Hlm/VX
	tYsw==
X-Gm-Message-State: APjAAAVVgipKqxzinqaK1hKGJPSVj5KCblJA3d/M4NYFikNXtfDLyeXN
	7Oya/CA5km38MITyrA4SZK+R/WkkbEI=
X-Google-Smtp-Source: APXvYqwgKm3t9L4BIxP7gDYlvoZSGH8mIgNVpz7guPNsSkved+TlSKI28rn3ssfqA8wF8eYRjUf+wg==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr74707820wrt.70.1577876589750; 
	Wed, 01 Jan 2020 03:03:09 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a1sm5250672wmj.40.2020.01.01.03.03.08
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 01 Jan 2020 03:03:08 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jan 2020 11:03:02 +0000
Message-Id: <20200101110305.12317-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200101110305.12317-1-richard.purdie@linuxfoundation.org>
References: <20200101110305.12317-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/5] runqueue: Ensure task dependencies are run correctly
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
X-List-Received-Date: Wed, 01 Jan 2020 11:03:10 -0000
Content-Transfer-Encoding: 8bit

We've seen a number of mystery failures where task B would run despite
task A, its dependency not having run. An example would be do_compile
when do_unpack didn't run.

This has been tracked down to this code block. In theory it shouldn't
trigger however it can and has due to bugs elsewhere. When it does, it
causes significant weird failures and possible build corruption.

Change the code to abort the build. This avoids any chance of corruption
and should ensure the issues get reported, putting an end to the weird
build failures.

There may be some cases where this triggers and it shouldn't, we'll work
through those as they arise and are identified.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f82799800b..56ca2529ca 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2353,6 +2353,12 @@ class RunQueueExecute:
             if tid in self.tasks_scenequeue_done:
                 self.tasks_scenequeue_done.remove(tid)
             for dep in self.sqdata.sq_covered_tasks[tid]:
+                if dep in self.runq_complete:
+                    bb.error("Task %s marked as completed but now needing to rerun? Aborting build." % dep)
+                    self.failed_tids.append(tid)
+                    self.rq.state = runQueueCleanUp
+                    return
+
                 if dep not in self.runq_complete:
                     if dep in self.tasks_scenequeue_done and dep not in self.sqdata.unskippable:
                         self.tasks_scenequeue_done.remove(dep)
-- 
2.20.1


