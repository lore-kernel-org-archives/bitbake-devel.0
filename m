Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA1EC433F5
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 02:25:00 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web10.1441.1637547896753547701
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Nov 2021 18:25:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.43, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="320933694"
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="320933694"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:25:00 -0800
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="588848669"
Received: from kkleong1-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.239.135])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:24:58 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 3/8] bitbake: adjust parser error check for python 3.10
 compatibility
Date: Mon, 22 Nov 2021 10:24:44 +0800
Message-Id: 
 <62e396e0899eb0d295229a8e49e35716b24f6038.1637547674.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637547674.git.anuj.mittal@intel.com>
References: <cover.1637547674.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Nov 2021 02:25:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13087

From: Alexander Kanavin <alex.kanavin@gmail.com>

The change was introduced in
https://github.com/python/cpython/commit/a698d52c3975c80b45b139b2f08402ec514dce75

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 8d3c6cbbe6ee734495713ae3b99c609527842506)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index aa9ac2c8..65857a9c 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -403,7 +403,7 @@ class DataSmart(MutableMapping):
                     s = __expand_python_regexp__.sub(varparse.python_sub, s)
                 except SyntaxError as e:
                     # Likely unmatched brackets, just don't expand the expression
-                    if e.msg != "EOL while scanning string literal":
+                    if e.msg != "EOL while scanning string literal" and not e.msg.startswith("unterminated string literal"):
                         raise
                 if s == olds:
                     break
-- 
2.33.1


