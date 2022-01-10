Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD55CC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 04:25:40 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web11.27826.1641788738858701688
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 09 Jan 2022 20:25:39 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=QR1zwiGg;
 spf=pass (domain: intel.com, ip: 192.55.52.136,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641788738; x=1673324738;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3n4XL3hGFZ8TPxOYI4X9wu2VG5Fyz968eQvZQn/TPb0=;
  b=QR1zwiGgGq3vh7EhyPkNfy+hwuTRd2k6rF0A5bCzMEtVxDx1giNM/7ih
   0gbJC6JWSDbzGL4SVc0cNaQfHdjB0d7BZ3YUhDMPG2FyT7EqeRCsCJ1rH
   jQL2QZj9AZBpcKJEQlUx6Yy2orpqlx1v9QpzvXnj5gh16+u40FcKGM43y
   7QLR5kgV6e738+xtKkdYcQ6oLxrmfhezflBMhLsKj3OzRrteqdHAF5JQ7
   bm3nNAmcP5V2wWHrxWfO3NTWLcGKJ1IoFkPMmPwT6ZyV/b5JVU5KY59Us
   1P3XrLlE/7sjQz5M10AALuaVC5LuPFFWg4LfOhQHlBj5xr/f5HvGFyFt6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="223132156"
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600";
   d="scan'208";a="223132156"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2022 20:25:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600";
   d="scan'208";a="473998406"
Received: from bboox-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.213.135.82])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2022 20:25:36 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH] utils: Update to use exec_module() instead of
 load_module()
Date: Mon, 10 Jan 2022 12:25:29 +0800
Message-Id: <20220110042529.14543-1-anuj.mittal@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Jan 2022 04:25:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13227

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This is deprecated in python 3.12 and Fedora 35 is throwing warnings so
move to the new functions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 68a18fbcb5959e334cf307d7fa8dc63832edb942)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/utils.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index d890ea83..1a515897 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -16,7 +16,8 @@ import bb.msg
 import multiprocessing
 import fcntl
 import importlib
-from importlib import machinery
+import importlib.machinery
+import importlib.util
 import itertools
 import subprocess
 import glob
@@ -1620,7 +1621,9 @@ def load_plugins(logger, plugins, pluginpath):
         logger.debug('Loading plugin %s' % name)
         spec = importlib.machinery.PathFinder.find_spec(name, path=[pluginpath] )
         if spec:
-            return spec.loader.load_module()
+            mod = importlib.util.module_from_spec(spec)
+            spec.loader.exec_module(mod)
+            return mod
 
     logger.debug('Loading plugins from %s...' % pluginpath)
 
-- 
2.34.1


