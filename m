Return-Path: <insu0.park@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179B4CD3448
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 06:59:49 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.1914.1695106785499379385
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Sep 2023 23:59:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eJDru/ii;
 spf=pass (domain: gmail.com, ip: 209.85.210.170, mailfrom: insu0.park@gmail.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-68fdd6011f2so3970812b3a.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 23:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695106785; x=1695711585; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J70tC8YBNSCKLbuNLqYyvfU3nGZ2gjBMLb1RzJGlQLU=;
        b=eJDru/iiLJVZ+OCe88lcWYPoMxIWFwIl9lfCae7GeVT5YDT9S47UJeJnFH0RadY6A/
         mu5tn5CZRNI8O7pOPjgcDBQWBz0GN1MJ9KqO5ddFVc36wOLVcvHqlu+2qPh6AVatMpxn
         VYAsTAxCa3URlRl9/SU/qfPJjMPK2/ZNDSKUPuvVX4S3D4fpyMF7nSj4tXgzVfei1kvN
         MwNLWIxI5/m9sIaB3IykPDHjEH4SF8J/PoiXeFa2Y+wxMO8zGVAtiNMkiPlzj3/WQDvk
         TMXx3tQzYQX8reNqHPDiHFe5GwJSvap6WXFempt2T3jCnvYd0A5RnqO0s06Pu65YdAg8
         kM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695106785; x=1695711585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J70tC8YBNSCKLbuNLqYyvfU3nGZ2gjBMLb1RzJGlQLU=;
        b=StDHJ1G6yq2rLh7qrZNlzkXHiV7AYeS7/oIZDYNzkLbiK8W2vgVuIJikZVAqFlOMiB
         9XIxrkqXr/ufC5XuJoJ6s/ZT9994W86oJ4gsCHmYRLjP+YmAf4TnrycK1sX2PpBnzo9w
         b4QS39buSIahmcGY/20q917tk4pxYt/NgGdFyyDhM6w1UmNIiXTV3EjbgrEVp/tqOFfM
         ZZ8DvOK47guBlTkCWlDrqGOWwTAPj3EEXqiRZ73tro3MTxrOVGcuHNm99F5fxRmUtqAi
         FTNJ22XPMQHa9D3BQdjqlXOOgWyXdZei3VZqh73XZN16WWshL5KD/8C5za04sQ9oGXIO
         VobA==
X-Gm-Message-State: AOJu0YwJ8bAvxzvz4oXiJOWEQSIhxPEl1C+Lv/ob6Ezh//SqCzJXvaoy
	mwxtfbQPCoroPQGaladamp6pLeh7qUNPmeIX
X-Google-Smtp-Source: AGHT+IF0w2KxUcrzzvIlGiPAVXq5pdmy+9uAnRVffNwIM+9POojuXZVDABsQ2MomEs6qjaJ5ME/gUg==
X-Received: by 2002:a05:6a00:a1f:b0:68f:e810:e87e with SMTP id p31-20020a056a000a1f00b0068fe810e87emr12337516pfh.31.1695106784647;
        Mon, 18 Sep 2023 23:59:44 -0700 (PDT)
Received: from insu1park-bee-ccnc1.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b0068aca503b9fsm8090298pfn.114.2023.09.18.23.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 23:59:44 -0700 (PDT)
From: Insu Park <insu0.park@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Insu Park <insu0.park@gmail.com>
Subject: [PATCH v2 1/1] bitbake: data: Add missing dependency handling of remove operator
Date: Tue, 19 Sep 2023 15:59:38 +0900
Message-Id: <20230919065938.1317052-2-insu0.park@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919065938.1317052-1-insu0.park@gmail.com>
References: <20230919065938.1317052-1-insu0.park@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Sep 2023 06:59:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15083

A recipe variable handles its dependencies even on the "contains"
variables within the "inline Python expressions" like bb.utils.filter().
And it also handles those in the append operator correctly, but the
problem is that it does not so in the remove operator.

Fix it by adding the missing dependencies every time the remove
operator has been handled.
Also add a test case to check if the override operators handle
dependencies correctly.

Signed-off-by: Insu Park <insu0.park@gmail.com>
---
 lib/bb/data.py             |  1 +
 lib/bb/tests/codeparser.py | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 3ee8f5e7..505f4295 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -285,6 +285,7 @@ def build_dependencies(key, keys, mod_funcs, shelldeps, varflagsexcl, ignored_va
             value += "\n_remove of %s" % r
             deps |= r2.references
             deps = deps | (keys & r2.execs)
+            value = handle_contains(value, r2.contains, exclusions, d)
         return value
 
     deps = set()
diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index a64c614b..b6f2b77e 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -436,6 +436,32 @@ esac
         self.assertEqual(deps, set(["TESTVAR2"]))
         self.assertEqual(self.d.getVar('ANOTHERVAR').split(), ['testval3', 'anothervalue'])
 
+    def test_contains_vardeps_override_operators(self):
+        # Check override operators handle dependencies correctly with the contains functionality
+        expr_plain = 'testval'
+        expr_prepend = '${@bb.utils.filter("TESTVAR1", "testval1", d)} '
+        expr_append = ' ${@bb.utils.filter("TESTVAR2", "testval2", d)}'
+        expr_remove = '${@bb.utils.contains("TESTVAR3", "no-testval", "testval", "", d)}'
+        # Check dependencies
+        self.d.setVar('ANOTHERVAR', expr_plain)
+        self.d.prependVar('ANOTHERVAR', expr_prepend)
+        self.d.appendVar('ANOTHERVAR', expr_append)
+        self.d.setVar('ANOTHERVAR:remove', expr_remove)
+        self.d.setVar('TESTVAR1', 'blah')
+        self.d.setVar('TESTVAR2', 'testval2')
+        self.d.setVar('TESTVAR3', 'no-testval')
+        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), set(), self.d, self.d)
+        self.assertEqual(sorted(values.splitlines()),
+                         sorted([
+                          expr_prepend + expr_plain + expr_append,
+                          '_remove of ' + expr_remove,
+                          'TESTVAR1{testval1} = Unset',
+                          'TESTVAR2{testval2} = Set',
+                          'TESTVAR3{no-testval} = Set',
+                          ]))
+        # Check final value
+        self.assertEqual(self.d.getVar('ANOTHERVAR').split(), ['testval2'])
+
     #Currently no wildcard support
     #def test_vardeps_wildcards(self):
     #    self.d.setVar("oe_libinstall", "echo test")
-- 
2.25.1


