Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2B5587D6A2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Apr 2019 10:02:09 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3PA1ocf005296
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Apr 2019 03:02:00 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Thu, 25 Apr 2019 03:01:39 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 25 Apr 2019 18:01:00 +0800
Message-ID: <d37712258af9b6fedb9e1586ace28908bec88391.1556186399.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1556186399.git.liezhi.yang@windriver.com>
References: <cover.1556186399.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] bitbake: build.py: check dependendent task for addtask
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
X-List-Received-Date: Thu, 25 Apr 2019 10:02:10 -0000
Content-Type: text/plain

The following command is incorrect, but was ignored silently, that may suprise
users:

addtask task after task_not_existed

This patch can check and warn for it. It would be better to also check "before"
tasks, but there is no easier way to do it.

[YOCTO #13282]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/build.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 7571421..861e9a9 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -815,6 +815,9 @@ def add_tasks(tasklist, d):
         task_deps['parents'][task] = []
         if 'deps' in flags:
             for dep in flags['deps']:
+                # Check and warn for "addtask task after foo" while foo does not exist
+                if not dep in tasklist:
+                    bb.warn('%s: dependent task %s does not exist!' % (d.getVar('PN'), dep))
                 dep = d.expand(dep)
                 task_deps['parents'][task].append(dep)
 
-- 
2.7.4


