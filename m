Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194])
	by mail.openembedded.org (Postfix) with ESMTP id E5CAD76639
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:52:57 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id p185so17804050pfb.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=edbti+iV4R4ieGIhxG1yoTES+Of+QOYxxJPCmhf2vUM=;
	b=qmty1PLxiVV4Y3gMt5dCaOsKEjjLAlYcqkZDFE1Wri2BDc8WGSroYIcL/6+5+J8fw3
	o/Med93JFp+hhT28nt6/9V5ZXmSfjEF13G/qAzWCx3YTP/P2/R3scga/fD7LPYm+SXj6
	PcAxTorY+e8JoH+czZC+v1zHYAKWtX3oarWV9Gjm7vC/rx9zMH2D6EvAlgrpf0ZX8WAR
	i6iLE+BKLOQUG9jrPKBV2lOXUMO3SDMUyo74I9JrlBM3Wqpga5GIwgrhZk0z3jc3VRiJ
	0ZTcEwaoD1TpKDs0JtssJFNVNfNbIOv3NrPu+zM50cmuxVx7rxEDHj8GeU1/y7yEaNju
	QsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=edbti+iV4R4ieGIhxG1yoTES+Of+QOYxxJPCmhf2vUM=;
	b=cfSOcYNBJP11fGcO9BF8CxzLJQVUBYqRPzwu4gt5g9DyAcMPrrzFPx+tbEGbNztscu
	lSD6DcecBl1l3dBhMc4cf7c5RkNXXABfwhJ0qQgL1MxSQFn300d3LuKsH507m64p6zW+
	qjJ/pHkE3ZdKjPAHL0rU39MtJ38FmnNp0m/wyteQ5CNX0/xU2Ht5mRpSKB6DslPHY+zq
	ls0C1jeLOsLWmK2i8M7CMjLRJwAYeMWYOl2QhHBpmbWxQ4uXkYRC0TONt3obq6Irvabd
	51eEcV4ZleNFpcEdIOYNH543+PSmXrDyMmGUBLyrOMbCAEOXOT4HEq9+LbMtdrPnHbJM
	Q1FA==
X-Gm-Message-State: AOPr4FUAbS5B3A1f6uwhUdi219iBCySIxD7q9ZivqCYc5JYWL6iqDTuMAWd/dCvTwjaatQ==
X-Received: by 10.98.70.144 with SMTP id o16mr39192844pfi.26.1462045978972;
	Sat, 30 Apr 2016 12:52:58 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	z2sm33247522pfa.90.2016.04.30.12.52.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:52:57 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:52:48 -0700
Message-Id: <1462045969-14538-4-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1462045969-14538-1-git-send-email-kergoth@gmail.com>
References: <1462045969-14538-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCH] Implement support for per-task exports
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 30 Apr 2016 19:52:58 -0000

From: Christopher Larson <chris_larson@mentor.com>

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 bin/bitbake-worker | 10 ++++++++++
 lib/bb/data.py     |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 767a1c0..d02ab77 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -207,14 +207,24 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdat
                 # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
                 # successfully. We also need to unset anything from the environment which shouldn't be there 
                 exports = bb.data.exported_vars(the_data)
+
                 bb.utils.empty_environment()
                 for e, v in exports:
                     os.environ[e] = v
+
                 for e in fakeenv:
                     os.environ[e] = fakeenv[e]
                     the_data.setVar(e, fakeenv[e])
                     the_data.setVarFlag(e, 'export', "1")
 
+                task_exports = the_data.getVarFlag(taskname, 'exports', True)
+                if task_exports:
+                    for e in task_exports.split():
+                        the_data.setVarFlag(e, 'export', '1')
+                        v = the_data.getVar(e, True)
+                        if v is not None:
+                            os.environ[e] = v
+
                 if quieterrors:
                     the_data.setVarFlag(taskname, "quieterrors", "1")
 
diff --git a/lib/bb/data.py b/lib/bb/data.py
index dbc6dea..4b3a9f9 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -339,7 +339,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             deps |= parser.references
             deps = deps | (keys & parser.execs)
             return deps, value
-        varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "vardepvalueexclude", "postfuncs", "prefuncs", "lineno", "filename"]) or {}
+        varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "vardepvalueexclude", "exports", "postfuncs", "prefuncs", "lineno", "filename"]) or {}
         vardeps = varflags.get("vardeps")
         value = d.getVar(key, False)
 
@@ -383,6 +383,8 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 deps = deps | set(varflags["prefuncs"].split())
             if "postfuncs" in varflags:
                 deps = deps | set(varflags["postfuncs"].split())
+            if "exports" in varflags:
+                deps = deps | set(varflags["exports"].split())
         else:
             parser = d.expandWithRefs(value, key)
             deps |= parser.references
-- 
2.8.0


