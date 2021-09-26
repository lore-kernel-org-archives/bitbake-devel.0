Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCE9C433FE
	for <webhook@archiver.kernel.org>; Sun, 26 Sep 2021 13:33:42 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web08.18679.1632663221213203742
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Sep 2021 06:33:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RkYK8/WR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id w17so43340176wrv.10
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Sep 2021 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZSG3HGzDvSSnZkI9wi1sZJARII8Ka/ebWK+tc5ysBQ=;
        b=RkYK8/WRqv5dW8b+LAKeoXKVFUs5sGppQoTfzQHbAfbepFXbfDaypoQ/BOHNMHh8Ho
         oOT2hBUMCSw1mv1Efgehp4qQfpMy1Fpbi1QhPaMWvIhYbRNnJsRFDUqzGYBDHaoi14mK
         MoNoKjjRUL/Btc+mV4emWbDH/o5np0eWUQ404=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZSG3HGzDvSSnZkI9wi1sZJARII8Ka/ebWK+tc5ysBQ=;
        b=ZUg5dhQ4v0d0w9v//9m9NBj/s8y9yGQZeUKGBexvOqVZpRnsuApFmiXxZVgWZPmjIn
         y/xlXE/Sw3eKxfJ7z3CsgmOlR/QMVXzf14D9zPwbPMBmPfeXHmElot3AmzdD8NdmgojN
         y/ay+F7NNT6XOTMKYbZICI4DsoXseyz1bcKRQyWjGzZvOLQXp4Zf6gLh4HKZsJ6sU4FP
         FYqFirvLsk9f50hjysE80wZxfTrE5IUouA/WiF2P78PVvcQa31TtEBtSVjUYbXhCtwuW
         FZlX9inc/QVa2ovrCZ8duM1lKn7FJlpdWSsKJn88IVdqz/d5XdoQSHB37CinMoGZaJj+
         9yww==
X-Gm-Message-State: AOAM530fuOtiFeblwgO/EJmoB3MuOrkagu5Gibfy4V6j8cxrnmknhRwZ
	FgKd8rqhK88GEDOGxtFX+FQ2EOFXIUOXG4ZT
X-Google-Smtp-Source: 
 ABdhPJxq/9CrriatH3QoFPjzp3fVKX224Ufp5ry8AbLDzJzOX3gk1Ap4hE6vI3eZrqnk2gunBTlDCQ==
X-Received: by 2002:a5d:59ad:: with SMTP id
 p13mr22268875wrr.253.1632663219489;
        Sun, 26 Sep 2021 06:33:39 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:ea95:6e9a:b58c:3d3e])
        by smtp.gmail.com with ESMTPSA id
 o3sm14534162wra.52.2021.09.26.06.33.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 06:33:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] siggen: Fix sorting in diff output
Date: Sun, 26 Sep 2021 14:33:37 +0100
Message-Id: <20210926133338.2011130-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Sep 2021 13:33:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12707

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


