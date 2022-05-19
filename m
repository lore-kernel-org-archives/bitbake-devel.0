Return-Path: <viraniac@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB757C433EF
	for <webhook@archiver.kernel.org>; Thu, 19 May 2022 18:36:50 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web08.11487.1652985401600446917
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 May 2022 11:36:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Z501M0fX;
 spf=pass (domain: gmail.com, ip: 209.85.216.53, mailfrom: viraniac@gmail.com)
Received: by mail-pj1-f53.google.com with SMTP id
 pq9-20020a17090b3d8900b001df622bf81dso5986227pjb.3
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 May 2022 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gwS+qsf2WiD68avo0WHNtCiY+6QH++5H6ymzIp4nuSw=;
        b=Z501M0fXhheoyw4+JJSRVi51Dqv0vWSjN4+KFBlM2twQUxSS+J9c+GpN0q3DU1cENP
         gPHpE7gqvLMdZ7Q2byqK+QM4fda6cGOhFIKeED7qtDp21EkMg4QGMjaqPXQkmqwJfAaT
         1ESe7ri1YNWRBgTbzHqXiYxNaSeOgfAK0PGGkXmx1hcYmW7qi2WD+i9nuOylhEdy4UVj
         JNJON4hF6MaBTNfYTuiGrwPhQrafNtybK7I2R5dwvwvxR13KkfJjvdTqvISm73iGEp1K
         l9eutOfoETXay1GX31q9/h8AlC+9MP4hRfas+2nurX0R74Kn6Nrl2PsktnkM4mmHQwQN
         CwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gwS+qsf2WiD68avo0WHNtCiY+6QH++5H6ymzIp4nuSw=;
        b=0VZt1G9frqx4l1alJ7Dv4q0/sp/s0F6uUYl7esswsiXSjRq1miuB1WuZE6mkgd9hGg
         ZO8+1uQ68YqmsDMcEjnNdfoEPxiHP7hOSNNSGyKDlscFiv0I9LXgjzUTeDTDnEumsA6K
         TwTzKDReZlbkVhEsXbxzcNeZLCWTPetyhG7D3l4G6JQF+JXR2Yx0D0Wdpv2+PPUtPhPm
         5MXveq4FjEODp7ihvC+c5Vtf3udoe7V+CnRcXi4DWATSJGcstlu83dPWoTNJ2osLAxkn
         qiTQ5/LDR71BHsMJf+YjmbqWS3hBKnU0An0HBDqgZ7YqV1MiIz3+9SC3Hl0dLnoKDeF8
         sMEg==
X-Gm-Message-State: AOAM533M0DO21pDdSbSnrp1eiMwbUemsa7nkEyZWU6bEpB0UFayTmoMR
	ZFlESAfUGJFnxIQwPdk7nzMmjuxM1obDAQ==
X-Google-Smtp-Source: 
 ABdhPJxeYjVNwf07fU0SdIPMYz0IXy8BKTUTyA+IMlNl7WGhBsWmC0IaYntbNDZS7DFGWJ4HcQWyLw==
X-Received: by 2002:a17:902:ef47:b0:156:646b:58e7 with SMTP id
 e7-20020a170902ef4700b00156646b58e7mr5852761plx.57.1652985400891;
        Thu, 19 May 2022 11:36:40 -0700 (PDT)
Received: from lima-default.. ([49.36.40.88])
        by smtp.gmail.com with ESMTPSA id
 n12-20020a63a50c000000b003c619f3d086sm3823140pgf.2.2022.05.19.11.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:36:40 -0700 (PDT)
From: Gunjan Gupta <viraniac@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Gunjan Gupta <viraniac@gmail.com>
Subject: [PATCH] fetch2/osc: Add support to query latest revision
Date: Thu, 19 May 2022 18:34:03 +0000
Message-Id: <20220519183403.468179-1-viraniac@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 May 2022 18:36:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13704

Add support to query latest revision. This makes it possble to use
osc fetcher without specifying the rev parameter.

Signed-off-by: Gunjan Gupta <viraniac@gmail.com>
---
 lib/bb/fetch2/osc.py | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index eb0f82c8..dd02f037 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -9,6 +9,7 @@ Based on the svn "Fetch" implementation.
 
 import logging
 import os
+import re
 import  bb
 from    bb.fetch2 import FetchMethod
 from    bb.fetch2 import FetchError
@@ -60,26 +61,49 @@ class Osc(FetchMethod):
 
         basecmd = d.getVar("FETCHCMD_osc") or "/usr/bin/env osc"
 
-        proto = ud.parm.get('protocol', 'ocs')
+        proto = ud.parm.get('protocol', 'https')
 
         options = []
 
         config = "-c %s" % self.generate_config(ud, d)
 
-        if ud.revision:
+        if getattr(ud, 'revision', ''):
             options.append("-r %s" % ud.revision)
 
         coroot = self._strip_leading_slashes(ud.path)
 
         if command == "fetch":
-            osccmd = "%s %s co %s/%s %s" % (basecmd, config, coroot, ud.module, " ".join(options))
+            osccmd = "%s %s -A %s://%s co %s/%s %s" % (basecmd, config, proto, ud.host, coroot, ud.module, " ".join(options))
         elif command == "update":
-            osccmd = "%s %s up %s" % (basecmd, config, " ".join(options))
+            osccmd = "%s %s -A %s://%s up %s" % (basecmd, config, proto, ud.host, " ".join(options))
+        elif command == "api_source":
+            osccmd = "%s %s -A %s://%s api source/%s/%s" % (basecmd, config, proto, ud.host, coroot, ud.module)
         else:
             raise FetchError("Invalid osc command %s" % command, ud.url)
 
         return osccmd
 
+    def _latest_revision(self, ud, d, name):
+        """
+        Fetch latest revision for the given package
+        """
+        api_source_cmd = self._buildosccommand(ud, d, "api_source")
+
+        output = runfetchcmd(api_source_cmd, d)
+        match = re.match('<directory ?.* rev="(\d+)".*>', output)
+        if match is None:
+            raise FetchError("Unable to parse osc response", ud.url)
+        return match.groups()[0]
+
+    def _revision_key(self, ud, d, name):
+        """
+        Return a unique key for the url
+        """
+        # Collapse adjacent slashes
+        slash_re = re.compile(r"/+")
+        rev = getattr(ud, 'revision', "latest")
+        return "osc:%s%s.%s.%s" % (ud.host, slash_re.sub(".", ud.path), name, rev)
+
     def download(self, ud, d):
         """
         Fetch url
@@ -123,7 +147,7 @@ class Osc(FetchMethod):
             os.remove(config_path)
 
         f = open(config_path, 'w')
-        proto = ud.parm.get('proto', 'https')
+        proto = ud.parm.get('protocol', 'https')
         f.write("[general]\n")
         f.write("apiurl = %s://%s\n" % (proto, ud.host))
         f.write("su-wrapper = su -c\n")
-- 
2.32.0


