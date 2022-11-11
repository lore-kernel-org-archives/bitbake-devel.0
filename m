Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C87C433FE
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 14:26:24 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web12.5927.1668176782494535236
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Nov 2022 06:26:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KLysOSVu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id h9so6746219wrt.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Nov 2022 06:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=564myiDK/ri693dzBXCMtasvcOgwi4Y+AmSCP1BODc0=;
        b=KLysOSVuUOFlgiwbkNvtzOS/t+sElnTQEZut9Pxw17DIRs6Zgvl6l3pcneSD9PddIM
         juKwvawgH3aYyxZZGKi3v95DXaZoMvF1ljymvBwjZOX5g8cagWzpfmIx29mYcYwznqDz
         1N8L2Yi2RaXQOpVukyyUgFZKMEbMDhit5KbzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=564myiDK/ri693dzBXCMtasvcOgwi4Y+AmSCP1BODc0=;
        b=c90UgJq2o7XMj3H1Nv4Jd5mlYhhEOHX2uBBpp3O1bn9dTPrGjhpkC+AhLV7/F6pBc3
         cfc6qrD15GvNjDVIPhO1NeDYuOr3o5s0nD4cjGKAO/UlVPVSt9DHbLlfY2jO6CNXguQt
         XEvvxcqQpiLLFpiFrxVdrqsE7HG7DvfJmE86MAMKncFGkQGllpcj/zPM6U71Sz2QEoVO
         mdefGxcqToP2Vrc8myP/GbrIhH1bJkFFIAoFBJVAdDCR/u1ZvEan+16ihp1LrpSh87uG
         gvQ5JQKnALWFkWmcf6e2+w0PtJ1S/2MrAWIFTc69H48e4bkYdvDDy7kLebkuS6sGO70v
         hqdQ==
X-Gm-Message-State: ANoB5pn/6Qlf8ucuUdaoMrIjlhbi6/GyqR7il4BxhP2twhV66bfEybI6
	0H9YT8ynzKeb9Eyb3jt2vgqYrHUWn219ZA==
X-Google-Smtp-Source: AA0mqf4Pw6lCTRTM1353giZsf2QAF/OD1B8lX0g8Mg6Hy0Aq866y6b1CW4FXAIZLDyXtncO7W5NfyQ==
X-Received: by 2002:adf:e58b:0:b0:22e:2f06:80f3 with SMTP id l11-20020adfe58b000000b0022e2f0680f3mr1432490wrm.79.1668176779986;
        Fri, 11 Nov 2022 06:26:19 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2115:4271:c44b:61ee])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003c6f8d30e40sm9599084wmq.31.2022.11.11.06.26.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:26:19 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data/data_smart/build: Clean up datastore finalize/update_data references
Date: Fri, 11 Nov 2022 14:26:18 +0000
Message-Id: <20221111142618.2309492-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Nov 2022 14:26:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14070

We dropped the update_data calls a while ago. Clean up the code
to match the reality and drop the remaining no-op pieces. Update
the comments to reflect the slowest operations and let the cookie
monster's spirit live on!

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py      |  1 -
 lib/bb/data.py       | 12 +++++-------
 lib/bb/data_smart.py |  9 +--------
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index b8c1099ef5..db706d0a3a 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -572,7 +572,6 @@ def _task_data(fn, task, d):
     localdata.setVar('BB_FILENAME', fn)
     localdata.setVar('OVERRIDES', 'task-%s:%s' %
                      (task[3:].replace('_', '-'), d.getVar('OVERRIDES', False)))
-    localdata.finalize()
     bb.data.expandKeys(localdata)
     return localdata
 
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 4be26367d2..3a6af325f4 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -4,14 +4,16 @@ BitBake 'Data' implementations
 Functions for interacting with the data structure used by the
 BitBake build tools.
 
-The expandKeys and update_data are the most expensive
-operations. At night the cookie monster came by and
+expandKeys and datastore iteration are the most expensive
+operations. Updating overrides is now "on the fly" but still based
+on the idea of the cookie monster introduced by zecke:
+"At night the cookie monster came by and
 suggested 'give me cookies on setting the variables and
 things will work out'. Taking this suggestion into account
 applying the skills from the not yet passed 'Entwurf und
 Analyse von Algorithmen' lecture and the cookie
 monster seems to be right. We will track setVar more carefully
-to have faster update_data and expandKeys operations.
+to have faster datastore operations."
 
 This is a trade-off between speed and memory again but
 the speed is more critical here.
@@ -264,10 +266,6 @@ def emit_func_python(func, o=sys.__stdout__, d = init()):
                newdeps |= set((d.getVarFlag(dep, "vardeps") or "").split())
         newdeps -= seen
 
-def update_data(d):
-    """Performs final steps upon the datastore, including application of overrides"""
-    d.finalize(parent = True)
-
 def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
     deps = set()
     try:
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 62d0c01c41..5415f2fccf 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -481,13 +481,6 @@ class DataSmart(MutableMapping):
     def expand(self, s, varname = None):
         return self.expandWithRefs(s, varname).value
 
-    def finalize(self, parent = False):
-        return
-
-    def internal_finalize(self, parent = False):
-        """Performs final steps upon the datastore, including application of overrides"""
-        self.overrides = None
-
     def need_overrides(self):
         if self.overrides is not None:
             return
@@ -638,7 +631,7 @@ class DataSmart(MutableMapping):
                 nextnew.update(vardata.references)
                 nextnew.update(vardata.contains.keys())
             new = nextnew
-        self.internal_finalize(True)
+        self.overrides = None
 
     def _setvar_update_overrides(self, var, **loginfo):
         # aka pay the cookie monster
-- 
2.34.1


