Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26DFC433EF
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 03:32:50 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mx.groups.io with SMTP id smtpd.web12.5172.1637033566840862534
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Nov 2021 19:32:49 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.88, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="257369175"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="257369175"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:49 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="506232242"
Received: from jli90-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.214.145.204])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:48 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 4/8] fetch: Handle mirror user/password replacements
 correctly
Date: Tue, 16 Nov 2021 11:32:33 +0800
Message-Id: 
 <5a13bca0e9088be4191f6120336c79dadfb86f76.1637033341.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637033341.git.anuj.mittal@intel.com>
References: <cover.1637033341.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 03:32:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13052

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Username or password replacements in URIs were being appended rather than
replaced in mirror url remapping. Fix this and add a test case.

[YOCTO #13823]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 66ad58bb87e5158aced572be4f1d5726bc97fcce)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/__init__.py | 4 ++++
 lib/bb/tests/fetch.py     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index dbf8b50e..1005ec10 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -430,6 +430,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
     uri_replace_decoded = list(decodeurl(uri_replace))
     logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
     result_decoded = ['', '', '', '', '', {}]
+    # 0 - type, 1 - host, 2 - path, 3 - user,  4- pswd, 5 - params
     for loc, i in enumerate(uri_find_decoded):
         result_decoded[loc] = uri_decoded[loc]
         regexp = i
@@ -449,6 +450,9 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                 for l in replacements:
                     uri_replace_decoded[loc][k] = uri_replace_decoded[loc][k].replace(l, replacements[l])
                 result_decoded[loc][k] = uri_replace_decoded[loc][k]
+        elif (loc == 3 or loc == 4) and uri_replace_decoded[loc]:
+            # User/password in the replacement is just a straight replacement
+            result_decoded[loc] = uri_replace_decoded[loc]
         elif (re.match(regexp, uri_decoded[loc])):
             if not uri_replace_decoded[loc]:
                 result_decoded[loc] = ""
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c3e714ae..0fb279e8 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -431,6 +431,10 @@ class MirrorUriTest(FetcherTest):
         ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master", "git://someserver.org/bitbake;branch=master", "git://git.openembedded.org/bitbake;protocol=http")
             : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
 
+        ("git://user1@someserver.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master", "git://someserver.org/bitbake;branch=master", "git://user2@git.openembedded.org/bitbake;protocol=http")
+            : "git://user2@git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
+
+
         #Renaming files doesn't work
         #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"
         #("file://sstate-xyz.tgz", "file://.*/.*", "file:///somewhere/1234/sstate-cache") : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
-- 
2.33.1


