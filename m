Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A8EC433F5
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 08:37:11 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web09.3943.1637570229954568121
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Nov 2021 00:37:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.136, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="214775788"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800";
   d="scan'208";a="214775788"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2021 00:37:02 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800";
   d="scan'208";a="552191281"
Received: from amohdwah-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.239.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2021 00:37:01 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 2/2] fetch2: Fix url remap issue and add testcase
Date: Mon, 22 Nov 2021 16:36:48 +0800
Message-Id: 
 <3bc465ab77b8d4a2d4b9a3108b86f1cddab27311.1637570097.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637570097.git.anuj.mittal@intel.com>
References: <cover.1637570097.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Nov 2021 08:37:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13095

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Using "" as a target for .replace() is a really bad idea as it duplicates the replacement
for every character in the string. Add a testcase which triggered this and correct the
code to return the correct result.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3af1ecf049d2eed56f6d319dc7df6eb4a3d4eebc)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/tests/fetch.py     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index b73b3695..25179bc2 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -473,7 +473,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                     basename = os.path.basename(ud.localpath)
                 if basename:
                     uri_basename = os.path.basename(uri_decoded[loc])
-                    if basename != uri_basename and result_decoded[loc].endswith(uri_basename):
+                    if uri_basename and basename != uri_basename and result_decoded[loc].endswith(uri_basename):
                         result_decoded[loc] = result_decoded[loc].replace(uri_basename, basename)
                     elif not result_decoded[loc].endswith(basename):
                         result_decoded[loc] = os.path.join(result_decoded[loc], basename)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 7edbf50b..a85ebdf4 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -434,6 +434,7 @@ class MirrorUriTest(FetcherTest):
         ("git://user1@someserver.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master", "git://someserver.org/bitbake;branch=master", "git://user2@git.openembedded.org/bitbake;protocol=http")
             : "git://user2@git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
 
+        ("gitsm://git.qemu.org/git/seabios.git/;protocol=https;name=roms/seabios;subpath=roms/seabios;bareclone=1;nobranch=1;rev=1234567890123456789012345678901234567890", "gitsm://.*/.*", "http://petalinux.xilinx.com/sswreleases/rel-v${XILINX_VER_MAIN}/downloads") : "http://petalinux.xilinx.com/sswreleases/rel-v%24%7BXILINX_VER_MAIN%7D/downloads/git2_git.qemu.org.git.seabios.git..tar.gz",
 
         #Renaming files doesn't work
         #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"
-- 
2.33.1


