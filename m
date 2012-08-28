Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T6NeG-0000vV-Aw for bitbake-devel@lists.openembedded.org;
	Tue, 28 Aug 2012 17:24:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7SERUOT008276
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Aug 2012 15:27:30 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 08249-01 for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Aug 2012 15:27:26 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7SERGf4008270
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Aug 2012 15:27:20 +0100
Message-ID: <1346166694.23096.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 28 Aug 2012 08:11:34 -0700
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: taskdata: Don't add dependencies on tasks that don't exist
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 28 Aug 2012 15:24:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

"bitbake meta-toolchain" with qemu image testing enabled causes problems
since it adds a task after do_rootfs which doesn't exist in this case.

We should simply ignore these extra dependencies rather than adding
them in which is what this patch does (adding a debug message when this
happens).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index aed3a16..c08186a 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -176,6 +176,9 @@ class TaskData:
             # Work out task dependencies
             parentids = []
             for dep in task_deps['parents'][task]:
+                if dep not in task_deps['tasks']:
+                    bb.debug(2, "Not adding dependeny of %s on %s since %s does not exist" % (task, dep, dep))
+                    continue
                 parentid = self.gettask_id(fn, dep)
                 parentids.append(parentid)
             taskid = self.gettask_id(fn, task)




