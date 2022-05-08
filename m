Return-Path: <viraniac@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47F7C433F5
	for <webhook@archiver.kernel.org>; Sun,  8 May 2022 17:39:17 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web11.22892.1652031552580874410
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 May 2022 10:39:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=lu/9KRnB;
 spf=pass (domain: gmail.com, ip: 209.85.215.175,
 mailfrom: viraniac@gmail.com)
Received: by mail-pg1-f175.google.com with SMTP id s16so114808pgs.3
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 May 2022 10:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EvtQ5yhnrEPzOsqoW2AtZXKbC0cqM8kX/P82iTGXhyM=;
        b=lu/9KRnBSqS5c/sByPtWdUA0uO7HLKWRyEOpfqevXJzcgYqur2cLdDbk6ViUiQlHuo
         xu315zxzQLc/ozZsRnv2oZbl97ayLe/GxWLJ3svkBRnGn5ILQWmnaEQMYu2R6llV4BHm
         eIcWbeqvH/XmYir38QAeo/mY59H6Nr9h/cfOBxOr4OYuqxRWWoJqJd9y60gdtYLvMyiK
         hL+qHHUg/vzgPD5NgBEnJ+AkofPbP7u3tPIHGElYZjX3+H8rCiyjxTDFmJVjDCqR+K72
         PI8lhIpRX8ffclvbMrgS9Owk8MEoqqHNE/0t7D5DJjVCSJJkBM2xsTjKljeGZQvRNZJR
         +5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EvtQ5yhnrEPzOsqoW2AtZXKbC0cqM8kX/P82iTGXhyM=;
        b=AqdCfAfses9dt4/7ph9Wjl7SKXxh15avQO+xBzx+J/MNwLKvx3CMaiPsJOakIaCu7M
         103L4HNZsCGRErxteusXF/bndqA7iTj50d4b+EI7DvHfIEASOlMlm4Z/mPl9pG2gZwJ0
         ySo5LG8CkdN9Uh8wmbtUDAjZWwFRENR9nLQOKG7PAgpTCIFgUd/eTwxVOAC8HSpqTuHE
         C6qCO0caFlK6EQVJMNKRN/R83Iw9zjbgMccgbOLBJvkfnCDgZFbBFTNeumDkuOqtXnlD
         Zkw8dfgeWKNVARxofPgK6MWjWPr6F35Mow0knbY7j/s0elsHXrTYFtyo04pqlXbP9VKa
         5KXQ==
X-Gm-Message-State: AOAM530JRlm47VulgFJ0tMrDQYBo16Oi4ZddXEYny4sdedg8qEHdWjw6
	YRG7k+4rMrbIiWN6zjrzcwStaWGzCgA=
X-Google-Smtp-Source: 
 ABdhPJz6umeKmG+7n5YmliZrpKD4sK6nOxA2B8fJLw2BkgEeFpsNxtvveSe4L6a8ZbY4RpQqtkk1gQ==
X-Received: by 2002:aa7:9846:0:b0:50d:d690:4af4 with SMTP id
 n6-20020aa79846000000b0050dd6904af4mr12705579pfq.58.1652031551792;
        Sun, 08 May 2022 10:39:11 -0700 (PDT)
Received: from lima-default.. ([49.36.44.20])
        by smtp.gmail.com with ESMTPSA id
 24-20020a630e58000000b003c18e0768e3sm6769826pgo.78.2022.05.08.10.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 10:39:11 -0700 (PDT)
From: Gunjan Gupta <viraniac@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Gunjan Gupta <viraniac@gmail.com>
Subject: [bitbake][PATCH] fetch2/osc: Small fixes for osc fetcher
Date: Sun,  8 May 2022 17:38:04 +0000
Message-Id: <20220508173804.448602-1-viraniac@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 08 May 2022 17:39:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13678

The current fetcher seemed to have some issues that made it difficult when
trying to use the same. This patch fixes the following

* Make consistent use of the path that needs to be used as oscdir
* The path mentioned in os.access in download function was not same as
  ud.moddir which would result into invoking of fetch command instead of
  update command even if directory already existed
* Before creating oscrc, make sure oscdir exists and create it if it does
  not exist
* Updated the configuration to use apiurl and added a new parameter to
  control whether http or https needs to be used to connect to apiurl

Signed-off-by: Gunjan Gupta <viraniac@gmail.com>
---
 lib/bb/fetch2/osc.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index 99a529e5..eb0f82c8 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -36,6 +36,7 @@ class Osc(FetchMethod):
         # Create paths to osc checkouts
         oscdir = d.getVar("OSCDIR") or (d.getVar("DL_DIR") + "/osc")
         relpath = self._strip_leading_slashes(ud.path)
+        ud.oscdir = oscdir
         ud.pkgdir = os.path.join(oscdir, ud.host)
         ud.moddir = os.path.join(ud.pkgdir, relpath, ud.module)
 
@@ -49,7 +50,7 @@ class Osc(FetchMethod):
             else:
                 ud.revision = ""
 
-        ud.localfile = d.expand('%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.path.replace('/', '.'), ud.revision))
+        ud.localfile = d.expand('%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), relpath.replace('/', '.'), ud.revision))
 
     def _buildosccommand(self, ud, d, command):
         """
@@ -86,7 +87,7 @@ class Osc(FetchMethod):
 
         logger.debug2("Fetch: checking for module directory '" + ud.moddir + "'")
 
-        if os.access(os.path.join(d.getVar('OSCDIR'), ud.path, ud.module), os.R_OK):
+        if os.access(ud.moddir, os.R_OK):
             oscupdatecmd = self._buildosccommand(ud, d, "update")
             logger.info("Update "+ ud.url)
             # update sources there
@@ -114,20 +115,23 @@ class Osc(FetchMethod):
         Generate a .oscrc to be used for this run.
         """
 
-        config_path = os.path.join(d.getVar('OSCDIR'), "oscrc")
+        config_path = os.path.join(ud.oscdir, "oscrc")
+        if not os.path.exists(ud.oscdir):
+            bb.utils.mkdirhier(ud.oscdir)
+
         if (os.path.exists(config_path)):
             os.remove(config_path)
 
         f = open(config_path, 'w')
+        proto = ud.parm.get('proto', 'https')
         f.write("[general]\n")
-        f.write("apisrv = %s\n" % ud.host)
-        f.write("scheme = http\n")
+        f.write("apiurl = %s://%s\n" % (proto, ud.host))
         f.write("su-wrapper = su -c\n")
         f.write("build-root = %s\n" % d.getVar('WORKDIR'))
         f.write("urllist = %s\n" % d.getVar("OSCURLLIST"))
         f.write("extra-pkgs = gzip\n")
         f.write("\n")
-        f.write("[%s]\n" % ud.host)
+        f.write("[%s://%s]\n" % (proto, ud.host))
         f.write("user = %s\n" % ud.parm["user"])
         f.write("pass = %s\n" % ud.parm["pswd"])
         f.close()
-- 
2.32.0


