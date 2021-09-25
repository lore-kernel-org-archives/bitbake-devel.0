Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4878C433EF
	for <webhook@archiver.kernel.org>; Sat, 25 Sep 2021 09:46:55 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web08.5367.1632563214921160039
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Sep 2021 02:46:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IsWV91jV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id w29so34777839wra.8
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Sep 2021 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZSG3HGzDvSSnZkI9wi1sZJARII8Ka/ebWK+tc5ysBQ=;
        b=IsWV91jVO/5B12S+AKY9iu1ig4tZsMmdd9K1Ny6r92eyYl2VCCJIYYoU5BolDrJuCE
         4orZjVNBjrM5FCaFDnJnzohhm0ZDL20svP2Umm73oTrXyok7IrE8iZvfJSgLe/CmTuvw
         kiUEkA4cJaD+vTT+5+Egrwaj3WQXoFAT4yKJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZSG3HGzDvSSnZkI9wi1sZJARII8Ka/ebWK+tc5ysBQ=;
        b=VOR/PNXEsxNyWS5gJeMT0X4iE7HBcl3eDJNGOiZ0zDC+X9Yci7Q992MPtF1j2VG5eB
         l1iMYP0r7qxBoJY8mt4slOqLNwH9+Qdy/1s0cvvZ3zPbJTqN/zQacayrKV/DpaJmfizJ
         Yo1VvBLuU54y7HEBfftpg6x/Awn6Klot4FPS0I50kKvF9oyA15yXI2u8FxrMnSojJNN1
         RZM5NMUGSyQW9wg0Z3fAPiso0fb9QdnyKV+A4AhxrbtgYVHy238CnkY+111u92F6wwkK
         4CljBYGJU7u0het6RxHCDLbJ/GmDFSghVPz1Gg6W4HQ0CKUDHPWM6OESMAcK+fchS+4M
         iOUw==
X-Gm-Message-State: AOAM531gRUgWLVKO7AngobRFwn8uH5Hf5cLdtuNfIKbWy6z5qKQaFufe
	2Ei56fvNC7FPLB+j1WsrKb1N4G99VN0/NK7y
X-Google-Smtp-Source: 
 ABdhPJyBbR56ONHFLuvUbAI1pntt9GBvFmnWHBkUQBcPOOhaZoti0yC+uhjGVpSukwMmu/PtsrXlMQ==
X-Received: by 2002:a05:600c:3543:: with SMTP id
 i3mr6242332wmq.64.1632563213016;
        Sat, 25 Sep 2021 02:46:53 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:2185:dd9d:1e31:557d])
        by smtp.gmail.com with ESMTPSA id
 a75sm11420864wmd.4.2021.09.25.02.46.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 02:46:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Fix sorting in diff output
Date: Sat, 25 Sep 2021 10:46:52 +0100
Message-Id: <20210925094652.1781540-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Sep 2021 09:46:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12705

The diff output isn't deterministic at the moment as the sets can have differing
ordering. Sort the output so it is consistent.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 3f9fe50642..625a9cf3bb 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -864,21 +864,21 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
 
     changed, added, removed = dict_diff(a_data['gendeps'], b_data['gendeps'], a_data['basewhitelist'] & b_data['basewhitelist'])
     if changed:
-        for dep in changed:
+        for dep in sorted(changed):
             output.append(color_format("{color_title}List of dependencies for variable %s changed from '{color_default}%s{color_title}' to '{color_default}%s{color_title}'") % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep]))
             if a_data['gendeps'][dep] and b_data['gendeps'][dep]:
                 output.append("changed items: %s" % a_data['gendeps'][dep].symmetric_difference(b_data['gendeps'][dep]))
     if added:
-        for dep in added:
+        for dep in sorted(added):
             output.append(color_format("{color_title}Dependency on variable %s was added") % (dep))
     if removed:
-        for dep in removed:
+        for dep in sorted(removed):
             output.append(color_format("{color_title}Dependency on Variable %s was removed") % (dep))
 
 
     changed, added, removed = dict_diff(a_data['varvals'], b_data['varvals'])
     if changed:
-        for dep in changed:
+        for dep in sorted(changed):
             oldval = a_data['varvals'][dep]
             newval = b_data['varvals'][dep]
             if newval and oldval and ('\n' in oldval or '\n' in newval):
@@ -948,7 +948,7 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
         b = b_data['runtaskhashes']
         changed, added, removed = dict_diff(a, b)
         if added:
-            for dep in added:
+            for dep in sorted(added):
                 bdep_found = False
                 if removed:
                     for bdep in removed:
@@ -958,7 +958,7 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
                 if not bdep_found:
                     output.append(color_format("{color_title}Dependency on task %s was added{color_default} with hash %s") % (clean_basepath(dep), b[dep]))
         if removed:
-            for dep in removed:
+            for dep in sorted(removed):
                 adep_found = False
                 if added:
                     for adep in added:
@@ -968,7 +968,7 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
                 if not adep_found:
                     output.append(color_format("{color_title}Dependency on task %s was removed{color_default} with hash %s") % (clean_basepath(dep), a[dep]))
         if changed:
-            for dep in changed:
+            for dep in sorted(changed):
                 if not collapsed:
                     output.append(color_format("{color_title}Hash for dependent task %s changed{color_default} from %s to %s") % (clean_basepath(dep), a[dep], b[dep]))
                 if callable(recursecb):
-- 
2.32.0


