Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 289E47C0CA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Jan 2019 08:31:47 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0B8VmQG003399
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Jan 2019 00:31:49 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Fri, 11 Jan 2019 00:31:48 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 Jan 2019 16:49:53 +0800
Message-ID: <6ac00ba5663bf149507d17af8a695b2d7182a11e.1547196548.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547196548.git.liezhi.yang@windriver.com>
References: <cover.1547196548.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: runqueue: __find_md5__ -> __find_sha256
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
X-List-Received-Date: Fri, 11 Jan 2019 08:31:48 -0000
Content-Type: text/plain

Fixed:
Create a new build
$ bitbake quilt-native -ccleansstate -Snone
$ bitbake quilt-native -ccleansstate -Sprintdiff

[snip]
     latestmatch = sorted(matches.keys(), key=lambda f: matches[f])[-1]
>    prevh = __find_md5__.search(latestmatch).group(0)
     output = bb.siggen.compare_sigfiles(latestmatch, match, recursecb)
AttributeError: 'NoneType' object has no attribute 'group'

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/runqueue.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f44eff4..809ec48 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -41,7 +41,7 @@ from multiprocessing import Process
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
 
-__find_md5__ = re.compile( r'(?i)(?<![a-z0-9])[a-f0-9]{32}(?![a-z0-9])' )
+__find_sha256__ = re.compile( r'(?i)(?<![a-z0-9])[a-f0-9]{64}(?![a-z0-9])' )
 
 def fn_from_tid(tid):
      return tid.rsplit(":", 1)[0]
@@ -1676,7 +1676,7 @@ class RunQueue:
             matches = {k : v for k, v in iter(matches.items()) if h not in k}
             if matches:
                 latestmatch = sorted(matches.keys(), key=lambda f: matches[f])[-1]
-                prevh = __find_md5__.search(latestmatch).group(0)
+                prevh = __find_sha256__.search(latestmatch).group(0)
                 output = bb.siggen.compare_sigfiles(latestmatch, match, recursecb)
                 bb.plain("\nTask %s:%s couldn't be used from the cache because:\n  We need hash %s, closest matching task was %s\n  " % (pn, taskname, h, prevh) + '\n  '.join(output))
 
-- 
2.7.4


