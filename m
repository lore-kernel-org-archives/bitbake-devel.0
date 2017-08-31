Return-Path: <andrey.z@gmail.com>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
	[209.85.128.195])
	by mail.openembedded.org (Postfix) with ESMTP id EAD84781E1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Aug 2017 16:23:32 +0000 (UTC)
Received: by mail-wr0-f195.google.com with SMTP id k94so64401wrc.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Aug 2017 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=hjcma+G5kIaEd+sFrmxYIZ/fP+v6uhIGzxjXN7zW+58=;
	b=QoTlDvPstYqZBINrH2PsWIbxBRbEoSpujMdOC79cfi6fDHoR9XnRtiROuRrXW7c/zp
	zYuf6aM7LWNvP9f0bynFUPsbqU/JkIXJ6Zyc5fZXC1uadHIpOOb9ZD5EGEwPcg0flk9z
	z/SyqORkxAENmxezUXDAl1I/Pk1FcNnfAnM57y0nsilkgDyBo+wtK3l0LCU5GxgawQwx
	G9D3mU9QjJ4JANxfo45pxzvThkfRHF1FO+Xx9uo8GQjhjONhq/0XFe2Zm7gOivNfPaat
	HVq/xFyD27zb1eHkbRHkpxT1au9g/0fmVoJVITNWRqQN14txcnhupX8wz8vHf9SX5YSE
	7QNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=hjcma+G5kIaEd+sFrmxYIZ/fP+v6uhIGzxjXN7zW+58=;
	b=kSkpcSQ87N7pB19jln9lmMyGm2w82MyUQeybAtuRsbTpQBaIJWhEfr5hLu4uvygScI
	O/fSDoIEmc0iQ5SNIBw0/A1kKnW6jMD9pstlIyqIbL4rb3R2gejitHHJby6+VJwVXK02
	rJJCb1w/R51c4Jvd+W6GNAUx9WI7fmA2B9JWtgqpUofdOicYt/jhiLH/idyQ3biOfi4E
	PpBcvi5rJASTGbLlD9vQStSbG83XUXQw1qHwdO1uwL0r/DgqIUS8Nwby03xYldJP/mXc
	YpIP7LvtHuzfgCkx7FsgSLSxlS3KcWHgokFJY8CmyAoDzMZ6CCmLCb89gAxjAOG7hT3S
	3goQ==
X-Gm-Message-State: AHYfb5jNgoewj9R7L8JtDAIDKrLLobz5dm2vKJCR74I1h7UpOmkPgXzd
	P7Zq+L2XgWGMjqMOesy/abgmL8IKIr/Jb5M=
X-Google-Smtp-Source: ADKCNb6K7BlD+JqEsGI1d9fumy7j1oqJLW8bccIn0iJsmYlKSmHFmUzUVBTAq4Nbgznhfh+YhPlm5nljFfiD7KTJRGI=
X-Received: by 10.223.143.3 with SMTP id p3mr3177123wrb.255.1504196613210;
	Thu, 31 Aug 2017 09:23:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.142.70 with HTTP; Thu, 31 Aug 2017 09:23:32 -0700 (PDT)
From: Andrey Zhizhikin <andrey.z@gmail.com>
Date: Thu, 31 Aug 2017 18:23:32 +0200
Message-ID: <CAHtQpK7BQhBrUKxttLRr8TaBud-SVLTVtKZsWrb4Dps1a1Hipw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Fri, 01 Sep 2017 15:25:32 +0000
Subject: [PATCH] bitbake: runqueue: Catch IndexError Python exception when resolving task dependencies
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
X-List-Received-Date: Thu, 31 Aug 2017 16:23:33 -0000
Content-Type: text/plain; charset="UTF-8"

This exception usually occurs when a task has a dependency,
which is listed in ASSUME_PROVIDED and should be resolved
quite early.

Case where this can be reproduced is when pseudo-native is listed
in ASSUME_PROVIDED, which then fails to be resolved by various
recipes.

This patch gives a valuable information to the user on which task
Bitbake excepts, so the user can investigate it's config files.

Signed-off-by: Andrey Zhizhikin <andrey.z@gmail.com>
---
 lib/bb/runqueue.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index e1a15af..fc3b27a 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2129,7 +2129,11 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     if depname not in self.rqdata.taskData[mc].build_targets:
                         continue

-                    depfn = self.rqdata.taskData[mc].build_targets[depname][0]
+                    try:
+                        depfn =
self.rqdata.taskData[mc].build_targets[depname][0]
+                    except IndexError:
+                        bb.msg.fatal("RunQueue", "Task %s failed with
index %s" % (realtid, depname))
+
                     if depfn is None:
                          continue
                     deptid = depfn + ":" + idependtask.replace("_setscene", "")
-- 
2.7.4

