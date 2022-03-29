Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F04FC433F5
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 14:28:06 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.7261.1648564084815790718
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:28:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O5KdfOqe;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id
 125-20020a1c0283000000b0038d043aac51so1365945wmc.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P67altbjq8eoAsQk9mhKF+xIRrDWZMZHmcEdGF6jcTU=;
        b=O5KdfOqeVJrK02fKsFE14/Ukg32L/KuqRT9yzpUH9Dk8e91p2BpY92Tg6h1Pgd+dPt
         PGK7X8c8D49YYNXQuRikll9Cf39OfHI/sFJ57QRhuT+s8Hc0ZJS3n9FOzcsxwoxMYGdH
         udUXZVeUMAv73dShvCk6KMXaDVQq4JWiAYOVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P67altbjq8eoAsQk9mhKF+xIRrDWZMZHmcEdGF6jcTU=;
        b=zml+kmX/AmtQWKnmjDuDJL1wnT8r9QwuIcKwGcgIEKivUd+Cv3ZR14IDhwStIBsGzI
         Qjt3pyxW9MZj/7DkwG/onB/FlaEaYA2rYZzRL7EcsXWM9z3F1hfDgpGovWTBwqRduKOz
         VRlWPMwKvv+khXlSzWJD1ndQuTEms65R4GfDRRn0cPueKiMxMZK2Gjw6E5QoWg1TzQbX
         h2+9VLGTMVT5S3JSZt/2qQ0sxbj0WWgS7H5fQB6y6XA02+tgO0HRZ1uvAM5zEU3Klt69
         v7MbHEwczD/g/Ih1L4DjhrErVmwjGjuiMcUsobZ+RAlkAXEMtYwEo0wOWm7f71K0RNj7
         pQuQ==
X-Gm-Message-State: AOAM530kzFs+8UNXqfaf858msP/rNl249Tqj5L1cIsAGbBzwXcKsRGEe
	jAhaCeZY9r4YTIoTZg1uw4EmJBCRc1IMYu/m
X-Google-Smtp-Source: 
 ABdhPJzWjdmQ8zlwUKzz65eCtVOukcKcbcAa4Pcqp+mM4HnheXefA85sfGPku8CQ5J4O9k++dZuVEA==
X-Received: by 2002:a1c:7c03:0:b0:38c:804d:d477 with SMTP id
 x3-20020a1c7c03000000b0038c804dd477mr7323185wmc.32.1648564082964;
        Tue, 29 Mar 2022 07:28:02 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a144:3266:4a07:b254])
        by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b00380deeaae72sm2529043wmb.1.2022.03.29.07.28.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:28:02 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 6/6] cooker: Rework force parser shutdown
Date: Tue, 29 Mar 2022 15:27:55 +0100
Message-Id: <20220329142755.1473185-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329142755.1473185-1-richard.purdie@linuxfoundation.org>
References: <20220329142755.1473185-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 14:28:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13545

The "force" option to parser shutdown was often the cause of lockups and
there is no good reason we should have two different behaviours.

Change and unify the codepaths to always:
  * Wait for longer for a controlled shutdown of a process (0.5s). Usually
    it will be much faster if it has finished so the delay doesn't really matter.
  * Send processes a SIGINT
  * Failing that, send a SIGTERM
  * Call .close() if available to release zombies

This means we no longer need the "force" parameter to the function so it is removed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 7c0c5d4efa..f435b18c87 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1613,7 +1613,7 @@ class BBCooker:
 
         if self.state in (state.shutdown, state.forceshutdown, state.error):
             if hasattr(self.parser, 'shutdown'):
-                self.parser.shutdown(clean=False, force = True)
+                self.parser.shutdown(clean=False)
                 self.parser.final_cleanup()
             raise bb.BBHandledException()
 
@@ -1741,7 +1741,7 @@ class BBCooker:
             self.state = state.shutdown
 
         if self.parser:
-            self.parser.shutdown(clean=not force, force=force)
+            self.parser.shutdown(clean=not force)
             self.parser.final_cleanup()
 
     def finishcommand(self):
@@ -2186,7 +2186,7 @@ class CookerParser(object):
 
             self.results = itertools.chain(self.results, self.parse_generator())
 
-    def shutdown(self, clean=True, force=False):
+    def shutdown(self, clean=True):
         if not self.toparse:
             return
         if self.haveshutdown:
@@ -2215,11 +2215,24 @@ class CookerParser(object):
                 break
 
         for process in self.processes:
-            if force:
-                process.join(.1)
+            process.join(0.5)
+
+        for process in self.processes:
+            if process.exitcode is None:
+                os.kill(process.pid, signal.SIGINT)
+
+        for process in self.processes:
+            process.join(0.5)
+
+        for process in self.processes:
+            if process.exitcode is None:
                 process.terminate()
-            else:
-                process.join()
+
+        for process in self.processes:
+            process.join()
+            # Added in 3.7, cleans up zombies
+            if hasattr(process, "close"):
+                process.close()
 
         self.parser_quit.close()
         # Allow data left in the cancel queue to be discarded
@@ -2296,18 +2309,18 @@ class CookerParser(object):
         except bb.BBHandledException as exc:
             self.error += 1
             logger.debug('Failed to parse recipe: %s' % exc.recipe)
-            self.shutdown(clean=False, force=True)
+            self.shutdown(clean=False)
             return False
         except ParsingFailure as exc:
             self.error += 1
             logger.error('Unable to parse %s: %s' %
                      (exc.recipe, bb.exceptions.to_string(exc.realexception)))
-            self.shutdown(clean=False, force=True)
+            self.shutdown(clean=False)
             return False
         except bb.parse.ParseError as exc:
             self.error += 1
             logger.error(str(exc))
-            self.shutdown(clean=False, force=True)
+            self.shutdown(clean=False)
             return False
         except bb.data_smart.ExpansionError as exc:
             self.error += 1
@@ -2316,7 +2329,7 @@ class CookerParser(object):
             tb = list(itertools.dropwhile(lambda e: e.filename.startswith(bbdir), exc.traceback))
             logger.error('ExpansionError during parsing %s', value.recipe,
                          exc_info=(etype, value, tb))
-            self.shutdown(clean=False, force=True)
+            self.shutdown(clean=False)
             return False
         except Exception as exc:
             self.error += 1
@@ -2328,7 +2341,7 @@ class CookerParser(object):
                 # Most likely, an exception occurred during raising an exception
                 import traceback
                 logger.error('Exception during parse: %s' % traceback.format_exc())
-            self.shutdown(clean=False, force=True)
+            self.shutdown(clean=False)
             return False
 
         self.current += 1
-- 
2.32.0


