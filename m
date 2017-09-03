Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 45CB17836A
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  3 Sep 2017 05:32:27 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v835WTHR015748
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 2 Sep 2017 22:32:29 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sat, 2 Sep 2017 22:32:28 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 2 Sep 2017 22:24:05 -0700
Message-ID: <bde40e218a69f3fcf94559489d85581274269823.1504416112.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1504416112.git.David.Reyna@windriver.com>
References: <cover.1504416112.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 2/4] toaster: Order column in Tasks selectable
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
X-List-Received-Date: Sun, 03 Sep 2017 05:32:28 -0000
Content-Type: text/plain

From: Awais Belal <awais_belal@mentor.com>

The build page provides tables related to performance that
cover build time, CPU time and disk IO. The "Edit columns"
drop down does not allow selection of the Order column and
makes it hidden as well which is not accurate from user
interaction point of view.
This patch enables the hideable property for the Order column
so it is hidden by default but the user can enable it through
the drop down if need be.

[YOCTO #11040]

Signed-off-by: Awais Belal <awais_belal@mentor.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/buildtables.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/toaster/toastergui/buildtables.py b/lib/toaster/toastergui/buildtables.py
index dd0a690..755a7c2 100644
--- a/lib/toaster/toastergui/buildtables.py
+++ b/lib/toaster/toastergui/buildtables.py
@@ -571,6 +571,7 @@ class BuildTimeTable(BuildTasksTable):
         super(BuildTimeTable, self).setup_columns(**kwargs)
 
         self.columns[self.toggle_columns['order']]['hidden'] = True
+        self.columns[self.toggle_columns['order']]['hideable'] = True
         self.columns[self.toggle_columns['sstate_result']]['hidden'] = True
         self.columns[self.toggle_columns['elapsed_time']]['hidden'] = False
 
@@ -586,6 +587,7 @@ class BuildCPUTimeTable(BuildTasksTable):
         super(BuildCPUTimeTable, self).setup_columns(**kwargs)
 
         self.columns[self.toggle_columns['order']]['hidden'] = True
+        self.columns[self.toggle_columns['order']]['hideable'] = True
         self.columns[self.toggle_columns['sstate_result']]['hidden'] = True
         self.columns[self.toggle_columns['cpu_time_sys']]['hidden'] = False
         self.columns[self.toggle_columns['cpu_time_user']]['hidden'] = False
@@ -602,5 +604,6 @@ class BuildIOTable(BuildTasksTable):
         super(BuildIOTable, self).setup_columns(**kwargs)
 
         self.columns[self.toggle_columns['order']]['hidden'] = True
+        self.columns[self.toggle_columns['order']]['hideable'] = True
         self.columns[self.toggle_columns['sstate_result']]['hidden'] = True
         self.columns[self.toggle_columns['disk_io']]['hidden'] = False
-- 
1.9.1


