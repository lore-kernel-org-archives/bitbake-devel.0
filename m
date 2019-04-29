Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 704697DA31
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Apr 2019 08:12:43 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x3T8CiCX004953
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Apr 2019 01:12:44 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Mon, 29 Apr 2019 01:12:43 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 29 Apr 2019 16:11:59 +0800
Message-ID: <cf3463d86e05376fd8a7f8079a815fce27a8d462.1556525357.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1556525357.git.liezhi.yang@windriver.com>
References: <cover.1556525357.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH V2 2/3] bitbake: build.py: check dependendent task for addtask
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
X-List-Received-Date: Mon, 29 Apr 2019 08:12:43 -0000
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
index 7571421..a83de8d 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -815,6 +815,9 @@ def add_tasks(tasklist, d):
         task_deps['parents'][task] = []
         if 'deps' in flags:
             for dep in flags['deps']:
+                # Check and warn for "addtask task after foo" while foo does not exist
+                if not dep in tasklist:
+                    bb.warn('%s: dependent task %s does not exist' % (d.getVar('PN'), dep))
                 dep = d.expand(dep)
                 task_deps['parents'][task].append(dep)
 
-- 
2.7.4


