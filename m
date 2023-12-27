Return-Path: <insu0.park@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A03C46CD4
	for <webhook@archiver.kernel.org>; Wed, 27 Dec 2023 14:55:01 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.102507.1703688892273278189
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Dec 2023 06:54:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZmaJ3Q9h;
 spf=pass (domain: gmail.com, ip: 209.85.215.172, mailfrom: insu0.park@gmail.com)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cd54e5fbb2so1342999a12.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 27 Dec 2023 06:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703688891; x=1704293691; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRo1YF/kbRbX9QA2sy6+NB8n7/zJTzwJ0xC/L64UmX4=;
        b=ZmaJ3Q9h2hC4E4A6+1pexQz6GUehguv7G8f8j59Io0p379Sl0wuhScAwi1VAlgh4VW
         YIt+024QdNq0g5b5pf6pHPpLx1Kxx7UkhnwVYTUcXBJ05SJndEU+RGp/5Y5ZKeT0Kwxy
         hXVDvcgGvguIkiEG0hURctmxYMG7lZq8BH2VMFCvN/he5lcQRTdZ1hm3Zbl7g3MrGh/S
         iq7ik4aquA4qf/OrSRrC1ztoVRER2aJF9FmmXL7QGIxum4D2boc4OovBM9am9YOvVRqe
         yCZCGR1c8digQXQhCkWhA1Nfu+zkvEPOyyr2AnGRG2MX5Bgkx3g8cKHWJ5ykdOkIZZEE
         D3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688891; x=1704293691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRo1YF/kbRbX9QA2sy6+NB8n7/zJTzwJ0xC/L64UmX4=;
        b=XXu/b2b0eT5SKBUEBI+ME7xNGRKtt3QL7dIrOOgqBZD6z+vakidxhy4Gyhp2fvjNh5
         4vX8LNgcVvEHrQ5WD8SLEMpZ1QzQmtqDeIfgDBjGAcrIRuZHRdqQcQRNmUJe83dqN8CN
         J5yygHBwOoFcsQWmeG4A6vNZNb/XrV7UTrbRBqRQMWyJmLR2rVnkc5FS6Lri5as3zY75
         iLp72xIjZd7NJEsC6RBE1Vwz0CmpT0d3PgtGFpAfZwHMgZRAJ8aGjCUbgK87RYXvbjWQ
         WrNCuCckPf644HvobE9KfLpPhj6SvZH+PvdP2x+KKSFKih/WsVp0FmZQg2oN61afMOqv
         j8YQ==
X-Gm-Message-State: AOJu0YxN5ta5F3WCHHZQG8Pya5GMfQssI21USTMBuMshv2WqGX4PeUgD
	8f3hIe9S/LE3+wLJ9C096cYh8TRJIe4=
X-Google-Smtp-Source: AGHT+IHEOgKDMLTkunb4iAB4WqcIYXcugAXz85fu1pir/20cfSQ4EPtvWUDOOtSvR7JidCHtELsNOw==
X-Received: by 2002:a05:6a20:7289:b0:196:38df:a8b3 with SMTP id o9-20020a056a20728900b0019638dfa8b3mr167884pzk.56.1703688891572;
        Wed, 27 Dec 2023 06:54:51 -0800 (PST)
Received: from insu1park-bee-ccnc1.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 19-20020aa79253000000b006c3069547bfsm11734582pfp.79.2023.12.27.06.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 06:54:51 -0800 (PST)
From: Insu Park <insu0.park@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	steve@sakoman.com
Cc: Insu Park <insu0.park@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [kirkstone][2.0][PATCH 1/1] data: Add missing dependency handling of remove operator
Date: Wed, 27 Dec 2023 23:54:18 +0900
Message-Id: <20231227145418.8776-2-insu0.park@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227145418.8776-1-insu0.park@gmail.com>
References: <20231227145418.8776-1-insu0.park@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Dec 2023 14:55:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15706

A recipe variable handles its dependencies even on the "contains"
variables within the "inline Python expressions" like bb.utils.filter().
And it also handles those in the append operator correctly, but the
problem is that it does not so in the remove operator.

Fix it by adding the missing dependencies every time the remove
operator has been handled.
Also add a test case to check if the override operators handle
dependencies correctly.

Signed-off-by: Insu Park <insu0.park@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Cherry-picked from master: b90520eedb1dbc7f6a3928d089fe74fafb864eb5
- Conflicts in data.py are resolved as the master branch moved
  handle_contains() and handle_remove() out of the try block.
- The test code in codeparser.py are modified as the master branch
  added three more arguments to the build_dependencies().

Signed-off-by: Insu Park <insu0.park@gmail.com>
---
 lib/bb/data.py             |  1 +
 lib/bb/tests/codeparser.py | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index c09d9b04..45411055 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -310,6 +310,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
                 value += "\n_remove of %s" % r
                 deps |= r2.references
                 deps = deps | (keys & r2.execs)
+                value = handle_contains(value, r2.contains, exclusions, d)
             return value
 
         if "vardepvalue" in varflags:
diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index 71ed382a..36ed4e19 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -430,6 +430,32 @@ esac
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
+        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), self.d)
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


