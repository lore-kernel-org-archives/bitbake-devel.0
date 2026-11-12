Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14349.1794493681665015980
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Nov 2026 06:28:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d+LWHs1T;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so45982735e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Nov 2026 06:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794493680; x=1795098480; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z5dmY5i+SI6llfk4KsgAqBZXwNSnRaA+vY1dL68qNK0=;
        b=d+LWHs1TmpGpw+LmvKEHMn6/uqecYdEUDoOWpqLZXTaixRUAzt+KZTgL+Km7yewBbP
         y6ZgdwHVlTxFz6yPSe7oVlbsxuN74vp3wflZjWs/0hjsgLT/XxJOMK9EzOqheJg46V9Q
         Q18sY2lYFaUvadoUhP/b6QnLYRxGzQmhfLmng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493680; x=1795098480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Z5dmY5i+SI6llfk4KsgAqBZXwNSnRaA+vY1dL68qNK0=;
        b=U009v4oXmSh0iNbFUaAAHncl72IkEfUzhlRGfXQ6kKXeoCL59xNEb2cBGYgfXm6/Ho
         2xRXPOUzi2bzALRvjauA5rhi0ly3Eqp0i1FeU/eK6LM2GDsHTjoLSNZRkff//Chc6w4d
         XYrGo10Ju2rOqG7QvVDHdWqttqnwXkOd15eLW1QbObkEilZrVV5zcgKYZX21WV7umnXh
         0r8m04dgURqJmKjWRXydMHGMzQofiI/0dSiJhDHGddJOKHU0686AnwiF2riMJWHPxzPy
         0rIh5N/YLAwITUpCydwM3RHC7oWVS2qh46jhx42OyGyFbmxMhEvS90PCcVNETHee9Q2F
         d5fA==
X-Gm-Message-State: APuU4Z+RHKDmFBpODIIYFQSJs3UoHlXbTbswtIjTBM2+m68uMqlCiddU
	RnbbUgJX8CPGvvQtUZAU3C1bjqt8lIN1VBHYPtqcSznHst9yjR8+MAddjkpDaGQxpjqppHNMdoo
	0pWXnjGs=
X-Gm-Gg: AYBFou1C/l7GmtwN9WuwWdPpXBd0AqoIjX1Px1PcOlRlRJRBf150x4AvlIarXKdpvmo
	MeY+xTQMqEvUM96RkU0RuQ4qOMgV03bhpvPNHTILczmNr7lz4f9/xxnmVxodDWuM4QGpcsYhBHc
	DDlpWZVHOJ+eoC0Wq+OrM+jEcHUuAtY564wBHCFuejujCsX+J8+LeZioYIGrP1Vw38jiaijyJYm
	oxkDv3txLyelmVIG27O/CUjTO9JPaVsQqpn9JfgV0S9mz8ixmUNF4NmrAKd0ii9qkSWIbEV+ycP
	ouWdSXZtjsk77JESLFE4H5A2677rcKEwHHy3VdAKHr14t/CrY+HgpQ2SFe/HqN4VwE12fWHtWbz
	y6NEEMVn0k8PWtkR6/NobogbJrdqm06ANxPoxV8OSBOlT5mKUpYlF2VNfyMMxrrFyO+g4+RHVWc
	2tiqerfolvAL1TqicOBNDNzQSNmBxBYDAe/piRYqG19pp75/DSQTc7SYa4kvOXH1PaG5zQAqppL
	/uc4ZwgIt25dfCRz2x4HcHqgk19DEyeVojjWGClGGp4oEleieesOR1+DTY5AujwL/IIqPAPv/F7
	MyGkJjjVRPAHksSpt+vEOg8HkFWD6w1pkBH15dyE8PZFJOQSQfSv2wkSiA==
X-Received: by 2002:a05:600c:3b86:b0:4a1:df52:3e36 with SMTP id 5b1f17b1804b1-4ba0939aef5mr125711225e9.27.1794493679733;
        Thu, 12 Nov 2026 06:27:59 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1562:9f61:e354:1b51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2593e4sm83090325e9.5.2026.11.12.06.27.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:27:58 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] cooker/runqueue: Add and switch to use get_layername API
Date: Thu, 12 Nov 2026 14:27:55 +0000
Message-ID: <20261112142755.3343305-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112142755.3343305-1-richard.purdie@linuxfoundation.org>
References: <20261112142755.3343305-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 12 Nov 2026 14:28:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20426
Content-Type: text/plain; charset="utf-8"

Rather that using one of the fields of calc_bbfile_priority, add
a new dedicated function since we want the layername more often than
not.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py  |  2 +-
 lib/bb/cooker.py   | 14 ++++++++++----
 lib/bb/runqueue.py |  4 ++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 068d95c1649..f49ebb19d8e 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -583,7 +583,7 @@ class CommandsSync:
                 appendfiles = command.cooker.collections[mc].get_file_appends(fn)
         else:
             appendfiles = []
-        layername = command.cooker.collections[mc].calc_bbfile_priority(fn)[2]
+        layername = command.cooker.collections[mc].get_layername(fn)
         # We are calling bb.cache locally here rather than on the server,
         # but that's OK because it doesn't actually need anything from
         # the server barring the global datastore (which we have a remote
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index af53135353e..bac0e7205b8 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -590,7 +590,7 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
 
         if fn:
             try:
-                layername = self.collections[mc].calc_bbfile_priority(fn)[2]
+                layername = self.collections[mc].get_layername(fn)
                 envdata = self.databuilder.parseRecipe(fn, self.collections[mc].get_file_appends(fn), layername)
             except Exception as e:
                 parselog.exception("Unable to read %s", fn)
@@ -1391,7 +1391,7 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
 
         bb_caches = bb.cache.MulticonfigCache(self.databuilder, self.databuilder.data_hash, self.caches_array)
 
-        layername = self.collections[mc].calc_bbfile_priority(fn)[2]
+        layername = self.collections[mc].get_layername(fn)
         infos = bb_caches[mc].parse(fn, self.collections[mc].get_file_appends(fn), layername)
         infos = dict(infos)
 
@@ -1825,6 +1825,12 @@ class CookerCollectFiles(object):
                 return pri, regex, layername
         return 0, None, None
 
+    def get_layername(self, filename):
+        for layername, _, _, _ in self.bbfile_config_priorities:
+            if regex.match(filename):
+                return layername
+        return None
+
     def get_bbfiles(self):
         """Get list of default .bb files by reading out the current directory"""
         path = os.getcwd()
@@ -2181,7 +2187,7 @@ class CookerParser(object):
         for mc in self.cooker.multiconfigs:
             for filename in self.mcfilelist[mc]:
                 appends = self.cooker.collections[mc].get_file_appends(filename)
-                layername = self.cooker.collections[mc].calc_bbfile_priority(filename)[2]
+                layername = self.cooker.collections[mc].get_layername(filename)
                 if not self.bb_caches[mc].cacheValid(filename, appends):
                     self.willparse.append((mc, self.bb_caches[mc], filename, appends, layername))
                 else:
@@ -2426,7 +2432,7 @@ class CookerParser(object):
         bb.cache.SiggenRecipeInfo.reset()
         to_reparse = set()
         for mc in self.cooker.multiconfigs:
-            layername = self.cooker.collections[mc].calc_bbfile_priority(filename)[2]
+            layername = self.cooker.collections[mc].get_layername(filename)
             to_reparse.add((mc, filename, self.cooker.collections[mc].get_file_appends(filename), layername))
 
         for mc, filename, appends, layername in to_reparse:
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ef95eb46bf9..a1e6487a6de 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2307,7 +2307,7 @@ class RunQueueExecute:
                 'unihash' : self.rqdata.get_task_unihash(task),
                 'quieterrors' : True,
                 'appends' : self.cooker.collections[mc].get_file_appends(taskfn),
-                'layername' : self.cooker.collections[mc].calc_bbfile_priority(realfn)[2],
+                'layername' : self.cooker.collections[mc].get_layername(realfn),
                 'taskdepdata' : self.sq_build_taskdepdata(task),
                 'dry_run' : False,
                 'taskdep': taskdep,
@@ -2401,7 +2401,7 @@ class RunQueueExecute:
                 'unihash' : self.rqdata.get_task_unihash(task),
                 'quieterrors' : False,
                 'appends' : self.cooker.collections[mc].get_file_appends(taskfn),
-                'layername' : self.cooker.collections[mc].calc_bbfile_priority(realfn)[2],
+                'layername' : self.cooker.collections[mc].get_layername(realfn),
                 'taskdepdata' : self.build_taskdepdata(task),
                 'dry_run' : self.rqdata.setscene_enforce,
                 'taskdep': taskdep,
