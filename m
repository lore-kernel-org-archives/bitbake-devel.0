Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 3DBDB6DEDA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2013 15:09:49 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id rBAF9mQH006908
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2013 07:09:48 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Tue, 10 Dec 2013 07:09:47 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 10 Dec 2013 10:09:38 -0500
Message-ID: <938f6010fa84c1a18d2fed6ec29cc0bfdf551fe8.1386680149.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1386680149.git.liezhi.yang@windriver.com>
References: <cover.1386680149.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 4/5] [dora] bitbake: build.py: add single-quotes around already-expanded directory name
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
X-List-Received-Date: Tue, 10 Dec 2013 15:09:49 -0000
Content-Type: text/plain

From: Peter Seebach <peter.seebach@windriver.com>

If the computed name of a directory contains an undefined variable
reference, bitbake dutifully creates a directory with a name that has
${...} in it. However, the actual task script created then tries to cd
to that directory, and the cd command fails, because no such directory
exists -- because the shell has helpfully removed the ${...} which did
not match any actual variables.

Since we want the name to be used exactly-as-is, add single quotes around
the name so this doesn't cause strange failures running tasks, which
allows us to progress past such failures and get to a point where they
can be diagnosed.

(Bitbake master rev: 2809c2e6f2f35f9b08058950be896947ab5a0284)

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/build.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 2e49a09..edab556 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -285,7 +285,7 @@ set -e
         if bb.msg.loggerVerboseLogs:
             script.write("set -x\n")
         if cwd:
-            script.write("cd %s\n" % cwd)
+            script.write("cd '%s'\n" % cwd)
         script.write("%s\n" % func)
         script.write('''
 # cleanup
-- 
1.7.10.4


