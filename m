Return-Path: <jonathan.yong@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 055D96C5D8
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Dec 2018 05:37:54 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	03 Dec 2018 21:37:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,312,1539673200"; d="scan'208";a="115834324"
Received: from vanguard-01.png.intel.com ([10.221.118.162])
	by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2018 21:37:54 -0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Dec 2018 05:37:53 +0000
Message-Id: <20181204053753.44975-2-jonathan.yong@intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204053753.44975-1-jonathan.yong@intel.com>
References: <20181204053753.44975-1-jonathan.yong@intel.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake-user-manual: document git usehead argument
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
X-List-Received-Date: Tue, 04 Dec 2018 05:37:54 -0000
Content-Transfer-Encoding: 8bit

usehead functionality is already present, document it.

Signed-off-by: Yong, Jonathan <jonathan.yong@intel.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.xml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index 29ae486a7..341ce9998 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -588,6 +588,11 @@
                         The name of the path in which to place the checkout.
                         By default, the path is <filename>git/</filename>.
                         </para></listitem>
+                   <listitem><para><emphasis>"usehead":</emphasis>
+                        For local git:// urls to use the current branch HEAD
+                        as the revision for use with AUTOREV. Implies nobranch.
+                        Will only work when protocol is "file".
+                        </para></listitem>
                 </itemizedlist>
                 Here are some example URLs:
                 <literallayout class='monospaced'>
-- 
2.19.2


