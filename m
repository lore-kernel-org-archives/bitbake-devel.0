Return-Path: <juro.bystricky@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id D077F731D6
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jan 2016 19:01:45 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga104.fm.intel.com with ESMTP; 04 Jan 2016 11:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,521,1444719600"; d="scan'208";a="853361943"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.145])
	by orsmga001.jf.intel.com with ESMTP; 04 Jan 2016 11:01:46 -0800
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Jan 2016 10:51:43 -0800
Message-Id: <1451933503-25881-2-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1451933503-25881-1-git-send-email-juro.bystricky@intel.com>
References: <1451933503-25881-1-git-send-email-juro.bystricky@intel.com>
Cc: richard.purdie@intel.com
Subject: [PATCH 1/1] bitbake:fetch2/__init__.py: Add support for 7-Zip
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
X-List-Received-Date: Mon, 04 Jan 2016 19:01:45 -0000

7-Zip is a file archiver claiming the highest compression ratio.
This patch allows using 7-Zip commpressed files in bitbake recipes.
Two common formats are supported:

SRC_URI = "file://abc.tar.7z"
SRC_URI = "file://abc.7z"

Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 68ebf8b..0f9c643 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1407,6 +1407,10 @@ class FetchMethod(object):
                     cmd = 'rpm2cpio.sh %s | cpio -id' % (file)
             elif file.endswith('.deb') or file.endswith('.ipk'):
                 cmd = 'ar -p %s data.tar.gz | zcat | tar --no-same-owner -xpf -' % file
+            elif file.endswith('.tar.7z'):
+                cmd = '7z x -so %s | tar xf - ' % file
+            elif file.endswith('.7z'):
+                cmd = '7za x -y %s 1>/dev/null' % file
 
         if not unpack or not cmd:
             # If file == dest, then avoid any copies, as we already put the file into dest!
-- 
1.9.1


