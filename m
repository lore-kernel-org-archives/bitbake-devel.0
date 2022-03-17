Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEF9C433F5
	for <webhook@archiver.kernel.org>; Thu, 17 Mar 2022 12:22:32 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web12.9476.1647519751438876200
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Mar 2022 05:22:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SIYXIufP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id
 123-20020a1c1981000000b0038b3616a71aso3055761wmz.4
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Mar 2022 05:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=picEUnG1bYdHgUCQjm7QARnpWFUK3GAW/w+OHbfVFoU=;
        b=SIYXIufPcKuBZ/cy4J/b64I4fCMa5e9irFgN94gRvB0lubmBFAuO85VINsnYoS58fD
         tOHzGcUn0d8+EDO78ozls910XVvg7omD59eTI5+niz9uMR5M37RoavTiboAHqQLUwpVs
         tiYBGJzmygOsLP+2u1uPobpMlg2PnVB7jNPA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=picEUnG1bYdHgUCQjm7QARnpWFUK3GAW/w+OHbfVFoU=;
        b=qgQugFcSd3HmNQQN+PsnDuxFbYh7+IiqRBWB+O5kGxoLCAm4gWnHf+u3pUo7ccdyXi
         XkyjDODbwGju9fge1R0P7P0IxeE7wTIBpQ+Z86QDZsMZS3temChdpmclH8IckmlEMM4V
         eb5WbviAqPGk8U2BdJN3SjPogCy1UjXMjIeCsCvaIlxnXit/D0apjhNMvBKYDn39BFSh
         lB41XsQeVH/WlzADNW5roBhlz4UGnWp0pvud8b9p3G2P9CtPWkg48hwwH36OuDQjRVgw
         t7HuMO1al1T9GSsfxcRI8zr4C3Pl5uhGKn/2EwpSRU5ycI2lVBEz/zy23i2f/F9aTGtU
         gPSw==
X-Gm-Message-State: AOAM530UfA4wwmkIupwqMv4pZGnAa8I3gYpLew4D/+8oLfOqEKNqUN+g
	ohAAFzhm3+08gA8UzVzlDishoNdQmVv3L5Vp
X-Google-Smtp-Source: 
 ABdhPJxHvlUqOBrLefJ6739ZkIqW9mFcjOBaZyYFinlWAcCtXvbRuWqRjY03zh2Q+80iCaHTtEIS6A==
X-Received: by 2002:a1c:c912:0:b0:37b:e074:dfcb with SMTP id
 f18-20020a1cc912000000b0037be074dfcbmr10884780wmb.161.1647519749517;
        Thu, 17 Mar 2022 05:22:29 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:64d8:6f1c:d663:861])
        by smtp.gmail.com with ESMTPSA id
 i15-20020a5d584f000000b00203ded4f92esm6338248wrf.18.2022.03.17.05.22.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:22:28 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] codeparser: Avoid log bufer overhead in cache case
Date: Thu, 17 Mar 2022 12:22:25 +0000
Message-Id: <20220317122225.996597-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317122225.996597-1-richard.purdie@linuxfoundation.org>
References: <20220317122225.996597-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Mar 2022 12:22:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13485

Creating the new log instances triggers a lot of python logging overhead
in a commonly called function (about 600,000 for parsing OE-Core).

We only need the log functionality if we're parsing, not if we just hit
from the cache. Therefore defer the log setup overhead until we know it
is a cache miss.

Whilst this complicates the code slightly, the performance gain is worth
it as for parsing OE-Core we drop 60 million funciton calls (from 225
overall).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/codeparser.py | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 0cec452c00..3b3c3b41ff 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -195,6 +195,10 @@ class BufferedLogger(Logger):
                 self.target.handle(record)
         self.buffer = []
 
+class DummyLogger():
+    def flush(self):
+        return
+
 class PythonParser():
     getvars = (".getVar", ".appendVar", ".prependVar", "oe.utils.conditional")
     getvarflags = (".getVarFlag", ".appendVarFlag", ".prependVarFlag")
@@ -276,7 +280,9 @@ class PythonParser():
         self.contains = {}
         self.execs = set()
         self.references = set()
-        self.log = BufferedLogger('BitBake.Data.PythonParser', logging.DEBUG, log)
+        self._log = log
+        # Defer init as expensive
+        self.log = DummyLogger()
 
         self.unhandled_message = "in call of %s, argument '%s' is not a string literal"
         self.unhandled_message = "while parsing %s, %s" % (name, self.unhandled_message)
@@ -303,6 +309,9 @@ class PythonParser():
                 self.contains[i] = set(codeparsercache.pythoncacheextras[h].contains[i])
             return
 
+        # Need to parse so take the hit on the real log buffer
+        self.log = BufferedLogger('BitBake.Data.PythonParser', logging.DEBUG, self._log)
+
         # We can't add to the linenumbers for compile, we can pad to the correct number of blank lines though
         node = "\n" * int(lineno) + node
         code = compile(check_indent(str(node)), filename, "exec",
@@ -321,7 +330,11 @@ class ShellParser():
         self.funcdefs = set()
         self.allexecs = set()
         self.execs = set()
-        self.log = BufferedLogger('BitBake.Data.%s' % name, logging.DEBUG, log)
+        self._name = name
+        self._log = log
+        # Defer init as expensive
+        self.log = DummyLogger()
+
         self.unhandled_template = "unable to handle non-literal command '%s'"
         self.unhandled_template = "while parsing %s, %s" % (name, self.unhandled_template)
 
@@ -340,6 +353,9 @@ class ShellParser():
             self.execs = set(codeparsercache.shellcacheextras[h].execs)
             return self.execs
 
+        # Need to parse so take the hit on the real log buffer
+        self.log = BufferedLogger('BitBake.Data.%s' % self._name, logging.DEBUG, self._log)
+
         self._parse_shell(value)
         self.execs = set(cmd for cmd in self.allexecs if cmd not in self.funcdefs)
 
-- 
2.32.0


