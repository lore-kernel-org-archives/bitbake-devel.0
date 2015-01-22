Return-Path: <Chong.Lu@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 7331371144
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 02:58:39 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id t0M2wdBq022822
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
	Wed, 21 Jan 2015 18:58:39 -0800 (PST)
Received: from pek-hostel-deb02.wrs.com (128.224.153.152) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.174.1; Wed, 21 Jan 2015 18:58:38 -0800
From: Chong Lu <Chong.Lu@windriver.com>
To: <bitbake-devel@lists.openembedded.org>, <paul.eggleton@linux.intel.com>
Date: Thu, 22 Jan 2015 10:53:54 +0800
Message-ID: <f73b94aaf542e5b7039cb573b6beba2f990b9c2e.1421895046.git.Chong.Lu@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1421895046.git.Chong.Lu@windriver.com>
References: <cover.1421895046.git.Chong.Lu@windriver.com>
MIME-Version: 1.0
Subject: [PATCH V2 1/2] bitbake.conf: Add two variables for layer index
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
X-List-Received-Date: Thu, 22 Jan 2015 02:58:42 -0000
Content-Type: text/plain

Add BITBAKE_LAYERINDEX_URL variable that bitbake-layers can use to find layer index.
Add LAYER_FETCH_DIR variable that bitbake-layers can use to specify fetch directory.

[YOCTO #5348]

Signed-off-by: Chong Lu <Chong.Lu@windriver.com>
---
 meta/conf/bitbake.conf | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
index d22e9e8..a8f4dc9 100644
--- a/meta/conf/bitbake.conf
+++ b/meta/conf/bitbake.conf
@@ -549,6 +549,12 @@ SELECTED_OPTIMIZATION[vardeps] += "FULL_OPTIMIZATION DEBUG_OPTIMIZATION"
 BUILD_OPTIMIZATION = "-O2 -pipe"
 
 ##################################################################
+# The OE layer index.
+##################################################################
+BITBAKE_LAYERINDEX_URL ??= "http://layers.openembedded.org/layerindex/api/"
+LAYER_FETCH_DIR ??= "${COREBASE}"
+
+##################################################################
 # Download locations and utilities.
 ##################################################################
 
-- 
1.9.1


