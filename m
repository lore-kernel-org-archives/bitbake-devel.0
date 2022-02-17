Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D86DC433EF
	for <webhook@archiver.kernel.org>; Thu, 17 Feb 2022 22:09:53 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web08.3371.1645135792051729795
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 14:09:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IyW0TXqh;
 spf=pass (domain: konsulko.com, ip: 209.85.219.52,
 mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f52.google.com with SMTP id d7so11103459qvk.2
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 14:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8HRXohnY1cVMFojdtKHpUzbAZ+dM++RAuGEmcFGkdlE=;
        b=IyW0TXqhEEn+QeBduf6AaMDJFOaztKT3C7Ze8E3J4gXo4lNyHp072hhG7mrtQgX9gU
         4BxvHIe6XQvtccPnICQYjhAeCK8jSEauY08K2P2ElEjvOI54i2XzIs0MztNJ8KNNw++a
         79c/hFnwNxGPw50p7RG5ekd2lvvkMiLA5qAfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8HRXohnY1cVMFojdtKHpUzbAZ+dM++RAuGEmcFGkdlE=;
        b=LDuctaCjlV279GnHWvCfvA0chcrbLdHc5qxgWdesrcpxxPpgBbGolFCm9xuUgr1Z0H
         RoE14JIUgSs6j637U3MEuA1gz5eWRfoF8ERiYZSYsDPU/fGG5+ucdo6p7Ow5WzIfwWEY
         Hg0dpgcPp7uUv1L99gV6h7nNtDqKckkKG1J/NZA18IppEzSJwRYHC73Pf2CH4ZKPEdJ1
         V8CFS337gFpFJCq66zThP1PxHyr6x9JOkqLSfBZpmBQmWNEty8zSZwAX6hLu6aI3xuYk
         RXqsEjUKY50YflckVRb2kJfegoSAhhgLiMh0i+wxKiVooZrP39IcYcsCiv1WxGqaljIe
         nCtQ==
X-Gm-Message-State: AOAM5303lsewDypraWjvS8iaOAxN8eCIFMLRkS2yRDZ5cVq1sfcRgkFV
	9JnRh4vLsLDx/AHqsvKlaNkvIM2/aiCo6w==
X-Google-Smtp-Source: 
 ABdhPJy/6MrOSjPr+dUakYF555qAozuWf6jTotnLxFOr3Ci6T03gwebZRPOTS8s7VbOVwTBnhXCUUg==
X-Received: by 2002:a05:6214:250a:b0:42c:fa1:3c97 with SMTP id
 gf10-20020a056214250a00b0042c0fa13c97mr3832381qvb.60.1645135790628;
        Thu, 17 Feb 2022 14:09:50 -0800 (PST)
Received: from ghidorah.spiteful.org (192-0-174-222.cpe.teksavvy.com.
 [192.0.174.222])
        by smtp.gmail.com with ESMTPSA id
 q15sm5127572qtn.41.2022.02.17.14.09.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 14:09:50 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/4] Replace remaining "abort" usage
Date: Thu, 17 Feb 2022 17:09:35 -0500
Message-Id: 
 <039ef76f550ad873d1f625a8db27b653ab2b2d3e.1645135230.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645135230.git.scott.murray@konsulko.com>
References: <cover.1645135230.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Feb 2022 22:09:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13364

In line with the inclusive language migration defined at:

https://wiki.yoctoproject.org/wiki/Inclusive_language

replace the remaining usage of "abort" in documentation, error
messages, and comments with halt/fail/exit as appropriate.
A couple of external Javascript API calls in Toaster remain, as
they cannot currently be changed.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 bin/toaster                                                   | 4 ++--
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 2 +-
 lib/bb/siggen.py                                              | 2 +-
 lib/bblayers/action.py                                        | 2 +-
 lib/toaster/bldcontrol/localhostbecontroller.py               | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 8711014c..558a8195 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -33,7 +33,7 @@ databaseCheck()
     $MANAGE migrate --noinput || retval=1
 
     if [ $retval -eq 1 ]; then
-        echo "Failed migrations, aborting system start" 1>&2
+        echo "Failed migrations, halting system start" 1>&2
         return $retval
     fi
     # Make sure that checksettings can pick up any value for TEMPLATECONF
@@ -41,7 +41,7 @@ databaseCheck()
     $MANAGE checksettings --traceback || retval=1
 
     if [ $retval -eq 1 ]; then
-        printf "\nError while checking settings; aborting\n"
+        printf "\nError while checking settings; exiting\n"
         return $retval
     fi
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 315086a6..59a9de2f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -735,7 +735,7 @@ overview of their function and contents.
          "
 
       This next example shows an error message that occurs because invalid
-      entries are found, which cause parsing to abort::
+      entries are found, which cause parsing to fail::
 
          ERROR: BBFILES_DYNAMIC entries must be of the form {!}<collection name>:<filename pattern>, not:
          /work/my-layer/bbappends/meta-security-isafw/*/*/*.bbappend
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index d0988e0e..ebba4525 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -584,7 +584,7 @@ class SignatureGeneratorUniHashMixIn(object):
         if self.setscenetasks and tid not in self.setscenetasks:
             return
 
-        # This can happen if locked sigs are in action. Detect and just abort
+        # This can happen if locked sigs are in action. Detect and just exit
         if taskhash != self.taskhash[tid]:
             return
 
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index f05f5d33..6723e2c6 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -53,7 +53,7 @@ class ActionPlugin(LayerPlugin):
                 except (bb.tinfoil.TinfoilUIException, bb.BBHandledException):
                     # Restore the back up copy of bblayers.conf
                     shutil.copy2(backup, bblayers_conf)
-                    bb.fatal("Parse failure with the specified layer added, aborting.")
+                    bb.fatal("Parse failure with the specified layer added, exiting.")
                 else:
                     for item in notadded:
                         sys.stderr.write("Specified layer %s is already in BBLAYERS\n" % item)
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 75674ccb..577e765f 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -200,7 +200,7 @@ class LocalhostBEController(BuildEnvironmentController):
                 localdirpath = os.path.join(localdirname, dirpath)
                 logger.debug("localhostbecontroller: localdirpath expects '%s'" % localdirpath)
                 if not os.path.exists(localdirpath):
-                    raise BuildSetupException("Cannot find layer git path '%s' in checked out repository '%s:%s'. Aborting." % (localdirpath, giturl, commit))
+                    raise BuildSetupException("Cannot find layer git path '%s' in checked out repository '%s:%s'. Exiting." % (localdirpath, giturl, commit))
 
                 if name != "bitbake":
                     layerlist.append("%03d:%s" % (index,localdirpath.rstrip("/")))
@@ -467,7 +467,7 @@ class LocalhostBEController(BuildEnvironmentController):
             logger.debug("localhostbecontroller: waiting for bblock content to appear")
             time.sleep(1)
         else:
-            raise BuildSetupException("Cannot find bitbake server lock file '%s'. Aborting." % bblock)
+            raise BuildSetupException("Cannot find bitbake server lock file '%s'. Exiting." % bblock)
 
         with open(bblock) as fplock:
             for line in fplock:
-- 
2.35.1


