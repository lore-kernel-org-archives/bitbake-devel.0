Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89181C433EF
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 09:02:57 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web10.6743.1635843773682662604
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 02:02:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="218125281"
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800";
   d="scan'208";a="218125281"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2021 02:02:55 -0700
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800";
   d="scan'208";a="496847337"
Received: from kehoh-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.215.233.28])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2021 02:02:54 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 3/3] fetch2: fix downloadfilename issue with premirror
Date: Tue,  2 Nov 2021 17:02:45 +0800
Message-Id: 
 <a790c04819507306b1a2248acdfd2b4520930116.1635843660.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635843660.git.anuj.mittal@intel.com>
References: <cover.1635843660.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 09:02:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12855

From: Chen Qi <Qi.Chen@windriver.com>

The following commit to fix [Yocto #13039] causes regression of
the behavior of PREMIRRORS.

  "bitbake: fetch2: fix premirror URI when downloadfilename defined"

Take meta-openembedded/meta-networking/recipes-protocols/freediameter/freediameter_1.4.0.bb
as an example.
SRC_URI = "\
    http://www.freediameter.net/hg/${fd_pkgname}/archive/${PV}.tar.gz;downloadfilename=${fd_pkgname}-${PV}.tar.gz \
    ...
"
With the above commit, it now tries to fetch 1.4.0.tar.gz instead of
freeDiameter-1.4.0.tar.gz. This makes https://downloads.yoctoproject.org/mirror/sources
not work for freediameter, as it holds freeDiameter-1.4.0.tar.gz.

The commit above tries to avoid fetching from invalid url such as:
https://<some_mirror>/1.4.0.tar.gz/freeDiameter-1.4.0.tar.gz.
And its solution is to make basename to be 1.4.0.tar.gz, thus causing the
regression.

This patch fixes the above regression. For Yocto #13039, it now tries
to fetch from url: https://<some_mirror>/freeDiameter-1.4.0.tar.gz.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 96c30007dc0b32eee2b15771daec7948bc9bfd97)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/__init__.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 259b2637a..8078991d7 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -466,9 +466,13 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                     # Kill parameters, they make no sense for mirror tarballs
                     uri_decoded[5] = {}
                 elif ud.localpath and ud.method.supports_checksum(ud):
-                    basename = os.path.basename(uri_decoded[loc])
-                if basename and not result_decoded[loc].endswith(basename):
-                    result_decoded[loc] = os.path.join(result_decoded[loc], basename)
+                    basename = os.path.basename(ud.localpath)
+                if basename:
+                    uri_basename = os.path.basename(uri_decoded[loc])
+                    if basename != uri_basename and result_decoded[loc].endswith(uri_basename):
+                        result_decoded[loc] = result_decoded[loc].replace(uri_basename, basename)
+                    elif not result_decoded[loc].endswith(basename):
+                        result_decoded[loc] = os.path.join(result_decoded[loc], basename)
         else:
             return None
     result = encodeurl(result_decoded)
-- 
2.31.1


