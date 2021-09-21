Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web08.4943.1632213324527270188
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Sep 2021 01:35:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210390177"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="210390177"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="701611422"
Received: from marsalan-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.172])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:26 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [hardknott][PATCH 3/8] data_smart: Improve error display for handled exceptions
Date: Tue, 21 Sep 2021 16:35:11 +0800
Message-Id: <52b659127bb7997e86c171d87fdd8406f1c33cd8.1632212181.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632212181.git.anuj.mittal@intel.com>
References: <cover.1632212181.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We don't need tracebacks for BBHandledException. Reduces confusing output like:

ERROR: /meta/recipes-core/images/core-image-tiny-initramfs.bb: Circular task dependencies as do_image_complete depends itself via the chain do_image_complete -> do_packageswu -> do_image_qa -> do_image -> do_image_cpio
ERROR: ExpansionError during parsing /meta/recipes-core/images/core-image-tiny-initramfs.bb
Traceback (most recent call last):
  File "/bitbake/lib/bb/build.py", line 1050, in follow_chain(task='do_image_qa', endtask='do_build', chain=['do_image_complete', 'do_packageswu', 'do_image_qa', 'do_image', 'do_image_cpio']):
                     if task in deps:
    >                    follow_chain(othertask, endtask, chain)
             chain.pop()
  File "/bitbake/lib/bb/build.py", line 1050, in follow_chain(task='do_image', endtask='do_build', chain=['do_image_complete', 'do_packageswu', 'do_image_qa', 'do_image', 'do_image_cpio']):
                     if task in deps:
    >                    follow_chain(othertask, endtask, chain)
             chain.pop()
  File "/bitbake/lib/bb/build.py", line 1050, in follow_chain(task='do_image_cpio', endtask='do_build', chain=['do_image_complete', 'do_packageswu', 'do_image_qa', 'do_image', 'do_image_cpio']):
                     if task in deps:
    >                    follow_chain(othertask, endtask, chain)
             chain.pop()
  File "/bitbake/lib/bb/build.py", line 1038, in follow_chain(task='do_image_complete', endtask='do_build', chain=['do_image_complete', 'do_packageswu', 'do_image_qa', 'do_image', 'do_image_cpio']):
             if task in chain:
    >            bb.fatal("Circular task dependencies as %s depends itself via the chain %s?!" % (task, " -> ".join(chain)))
             chain.append(task)
  File "/bitbake/lib/bb/__init__.py", line 165, in fatal:
         mainlogger.critical(''.join(args), extra=kwargs)
    >    raise BBHandledException()

to the real error:

ERROR: /media/build1/poky/meta/recipes-core/images/core-image-tiny-initramfs.bb: Circular task dependencies as do_image_complete depends itself via the chain do_image_complete -> do_packageswu -> do_image_qa -> do_image -> do_image_cpio

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 551d4c0576a0a0c3406000029df9238b312f2263)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/data_smart.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index b4ed62a4e..8291ca65e 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -411,6 +411,8 @@ class DataSmart(MutableMapping):
                 raise
             except bb.parse.SkipRecipe:
                 raise
+            except bb.BBHandledException:
+                raise
             except Exception as exc:
                 tb = sys.exc_info()[2]
                 raise ExpansionError(varname, s, exc).with_traceback(tb) from exc
-- 
2.31.1

