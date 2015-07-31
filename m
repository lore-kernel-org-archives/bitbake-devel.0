Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 92AC2765E4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:42 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga102.fm.intel.com with ESMTP; 31 Jul 2015 05:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="533657583"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2015 05:09:43 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id CB4876A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:08:57 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:11 +0300
Message-Id: <07157cdc311efb6c557ee5ae956717c5be5d8999.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 10/22] bitbake: toastergui: css Add new rules for new project page
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:45 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add new css rules needed for new project page.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 86bee7b..62ba78c 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -270,6 +270,17 @@ thead .add-del-layers { width: 124px; }
   box-shadow: 0 0 10px #c09853;
 }
 
+#change-notification {
+  position: fixed;
+  z-index: 101;
+  top: 3%;
+  left: 20%;
+  right: 20%;
+  -webkit-box-shadow: 0 0 10px #3a87ad;
+  -moz-box-shadow: 0 0 10px #3a87ad;
+  box-shadow: 0 0 10px #3a87ad;
+}
+
 /* Copied in from newer version of Font-Awesome 4.3.0 */
 .fa-spin {
   -webkit-animation: fa-spin 2s infinite linear;
@@ -310,3 +321,10 @@ thead .add-del-layers { width: 124px; }
 .top-padded {
   padding-top: 60px;
 }
+
+input.input-lg {
+  font-size: 18px;
+  height: 22px;
+  line-height: 1.33333;
+  padding: 10px 16px;
+}
-- 
2.1.4


