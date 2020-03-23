Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.302.1584983838900975292
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Mar 2020 10:17:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QV/03wLk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id c81so221833wmd.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2020 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=barl3+l8fEt9EgJMt0xrH/i3OpjRHn0k1QXq+TwzKW8=;
        b=QV/03wLkpGY/RxZRuyy2gmDBEdCu3x1Hu/16DRhFxpksvrup9ZcR46UlUcLuKq84fa
         H7zoYpcvCAJp08ajdJGjIwiga8ekRfZ25v44WKqAWxx7HfhBnaMqwbKaFhxX6T3yExGQ
         EOlMO49aLZsR7qR3n1OS3hUEAB47XkGXrOgW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=barl3+l8fEt9EgJMt0xrH/i3OpjRHn0k1QXq+TwzKW8=;
        b=K52Em8BupXVLSSI3b6KpIVNwVD0qbXR7duQ1wkaO9THIiLsOmi+82Ipd/Vyk1J/WE1
         d8172muhAR6Ui9eEJdRvwdBdoJMY208zwNMeSuzHa0gtmlAZlDC9R2oXmKFk1xpV2DQy
         fDqu3WMVtpgAEwBh3wWVDwk3AJEKF2YkP9IT8MBdHEYPL7snGqp1Uaaa20+ggZR7nKq3
         yHM3daJ0fvCH0LJ2VLwBqcc6gsxcXM4hjF3ECISjmPVtEAHHo5WiPUTtyTqTDM4Al3px
         BgpMHN0LwwnWNOAanlLAPCoEzbEGUjltWNnoq2D1OQw7LwiIdnwgZLSTE2vBGFHZv5uC
         L1Cw==
X-Gm-Message-State: ANhLgQ04o7x0Ug3hz6SAeLJ1A59ajIgMK8Avd7m+/67dfx1my5mbla3F
	A7TIatdg6r064TQ0bqt9DRwTSTskAkw=
X-Google-Smtp-Source: ADFU+vveKVU5cLUqYl8iIOabty92MMClgrpnpp2AuYwdBZpSm42Sc2L48cvcc2F2piQBx006G5Pbqw==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr332662wmh.72.1584983835242;
        Mon, 23 Mar 2020 10:17:15 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id q185sm342144wme.10.2020.03.23.10.17.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 10:17:14 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] data_smart: Don't pass unneeded datastore
Date: Mon, 23 Mar 2020 17:17:11 +0000
Message-Id: <20200323171712.434949-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323171712.434949-1-richard.purdie@linuxfoundation.org>
References: <20200323171712.434949-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The datastore is already available to this function internally so don't
also try and pass the datastore as a parameter. This is clearly broken
API when you look at the existing calls to it.

This then doesn't break the planned tinfoil data connector changes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py        | 3 ++-
 lib/bblayers/common.py      | 2 +-
 lib/layerindexlib/cooker.py | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 63a32bc6a7..b2dc9d9fd5 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -338,11 +338,12 @@ class VariableHistory(object):
                 lines.append(line)
         return lines
 
-    def get_variable_items_files(self, var, d):
+    def get_variable_items_files(self, var):
         """
         Use variable history to map items added to a list variable and
         the files in which they were added.
         """
+        d = self.dataroot
         history = self.variable(var)
         finalitems = (d.getVar(var) or '').split()
         filemap = {}
diff --git a/lib/bblayers/common.py b/lib/bblayers/common.py
index c5657d3819..6c76ef3505 100644
--- a/lib/bblayers/common.py
+++ b/lib/bblayers/common.py
@@ -17,7 +17,7 @@ class LayerPlugin():
     def tinfoil_init(self, tinfoil):
         self.tinfoil = tinfoil
         self.bblayers = (self.tinfoil.config_data.getVar('BBLAYERS') or "").split()
-        layerconfs = self.tinfoil.config_data.varhistory.get_variable_items_files('BBFILE_COLLECTIONS', self.tinfoil.config_data)
+        layerconfs = self.tinfoil.config_data.varhistory.get_variable_items_files('BBFILE_COLLECTIONS')
         self.bbfile_collections = {layer: os.path.dirname(os.path.dirname(path)) for layer, path in layerconfs.items()}
 
     @staticmethod
diff --git a/lib/layerindexlib/cooker.py b/lib/layerindexlib/cooker.py
index 4ce397d884..65b23d087f 100644
--- a/lib/layerindexlib/cooker.py
+++ b/lib/layerindexlib/cooker.py
@@ -93,7 +93,7 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
             return index
 
         collections = d.getVar('BBFILE_COLLECTIONS')
-        layerconfs = d.varhistory.get_variable_items_files('BBFILE_COLLECTIONS', d)
+        layerconfs = d.varhistory.get_variable_items_files('BBFILE_COLLECTIONS')
         bbfile_collections = {layer: os.path.dirname(os.path.dirname(path)) for layer, path in layerconfs.items()}
 
         (_, bb_branch, _, _) = self._get_bitbake_info()
-- 
2.25.1

