Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 928E0765E3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:45 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga102.fm.intel.com with ESMTP; 31 Jul 2015 05:09:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="533657601"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2015 05:09:45 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 26BAA6A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:08:59 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:13 +0300
Message-Id: <353b78f518bc30a9dd1231d7f484a148657aac89.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 12/22] bitbake: toastergui: css Remove redundant css rules
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

The machine change notification animation is no longer required in
favour of the global overlay notification.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 62ba78c..638c6dd 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -249,11 +249,6 @@ div.add-deps { margin-top: 15px; }
   opacity:1;
 }
 
-@keyframes machines-fade { 0% { background-color: #D9EDF7; } 25% { background-color: #D9EDF7; } 100% { background-color: white; } }
-@-webkit-keyframes machines-fade { 0% { background-color: #D9EDF7; } 25% { background-color: #D9EDF7; } 100% { background-color: white; } }
-
-.machines-highlight { -webkit-animation: machines-fade 7s 1; -moz-animation: machines-fade 7s 1; animation: machines-fade 7s 1; }
-
 .tab-pane table { margin-top: 10px; }
 
 thead .description, .get_description_or_summary { width: 364px; }
-- 
2.1.4


