Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1TsGse-0003Sg-E3
	for bitbake-devel@lists.openembedded.org;
	Mon, 07 Jan 2013 18:53:00 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r07Hbnxs020833
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 7 Jan 2013 09:37:49 -0800 (PST)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.2.318.4;
	Mon, 7 Jan 2013 09:37:49 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 7 Jan 2013 11:57:23 -0600
Message-ID: <1357581443-27929-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH] lib/bb/build.py: 'deps' may not always exist in a few corner cases.
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
X-List-Received-Date: Mon, 07 Jan 2013 17:53:00 -0000
Content-Type: text/plain

With a small set of recipes (1), and all system dependencies assume_provided,
we may end up with no parent dependencies.  So we check if 'deps' was defined
instead of always assuming it exists.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/build.py |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 43790a6..2f6a61f 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -591,9 +591,10 @@ def add_tasks(tasklist, d):
         getTask('noexec')
         getTask('umask')
         task_deps['parents'][task] = []
-        for dep in flags['deps']:
-            dep = data.expand(dep, d)
-            task_deps['parents'][task].append(dep)
+        if 'deps' in flags:
+            for dep in flags['deps']:
+                dep = data.expand(dep, d)
+                task_deps['parents'][task].append(dep)
 
     # don't assume holding a reference
     data.setVar('_task_deps', task_deps, d)
-- 
1.7.3.4



