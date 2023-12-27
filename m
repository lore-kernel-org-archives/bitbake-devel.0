Return-Path: <insu0.park@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA30C47073
	for <webhook@archiver.kernel.org>; Wed, 27 Dec 2023 14:56:31 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.web10.103027.1703688986607354033
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Dec 2023 06:56:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lRpVRcnR;
 spf=pass (domain: gmail.com, ip: 209.85.167.179, mailfrom: insu0.park@gmail.com)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ba14203a34so5376618b6e.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 27 Dec 2023 06:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703688985; x=1704293785; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIhaaqjc9j2DLoKOq6izl2aDUeDZRp7je80/uhzW97g=;
        b=lRpVRcnRIysaSRLoh3ufWuDg4yUuNU80nXgDFuOLGOWHRHJUyJdS7wh7NVos5iNx1+
         WdMqxdQshNCqhLmcxd+EG2dNWeBLEUHt921sVcQHYRiDCtmoROC01R8Zz70zreCukS91
         a2dislL9L+FJM39MywY7dZ/xDvU3t8it8noRbautyGFZ3TkbM3cAFmiuAnbMXGZmmdv4
         zNrJVIVK20AvDaukqickXIG5wyBhGgEo2VuW3LXgnfFsRNUAX9ax+9iNp5m/Ion6+1YC
         klqzEBs2zpUa2ul5H5Nuam51b4f+cP+yxG43BpkyUzifa/1XI00XC30gLKS5U/OmikvG
         BO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688985; x=1704293785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIhaaqjc9j2DLoKOq6izl2aDUeDZRp7je80/uhzW97g=;
        b=Rwh15S8uwg6yr0lmk9WB2nsvt4lc+PbrGCWR9qUEIRvIiXjXxMiTHiXNFdZk960b3H
         K+0Ec7nB89RM7TEDMgPahT765ZSp+22Y7exAx9IBrTpBHvA0E51T/MUdb5+7I9r5Kgn6
         j2fxnlbvE/VFOsdw37T5UAUAIvL8txLxTgIDdWJV+54dpP+MSimRbANWPINz3mpxYonZ
         BtWSM0QOwna8TAzhU4OP5jZLMrKsp7PyY+WhkFFBwzaEwqLwPyWg1R/uovGuSqPYw0bh
         W6cVYejbYrTJnygghq/CEkqTuodkCFS7Jfz3QqZNZJBDxinVVbBGO4WMa2AWpuchvlIx
         m0VA==
X-Gm-Message-State: AOJu0Yw7bUrLQveEztVSXpthss0tub5cMg612JzNs9L4T6cquhD7nfYW
	X/XFR8FpkJUsad445MDlsbc7FnlNk8o=
X-Google-Smtp-Source: AGHT+IGu3qxrnJOCqNKE1KrVw6D1OyWk0xnVCAv/FENA6uaKXaadlorOtjlAUWvFxfkUBADd4hnA2A==
X-Received: by 2002:a05:6358:5289:b0:170:c56d:353b with SMTP id g9-20020a056358528900b00170c56d353bmr12361954rwa.15.1703688985467;
        Wed, 27 Dec 2023 06:56:25 -0800 (PST)
Received: from insu1park-bee-ccnc1.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id fb27-20020a056a002d9b00b006d9bdc0f765sm4944491pfb.53.2023.12.27.06.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 06:56:25 -0800 (PST)
From: Insu Park <insu0.park@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	steve@sakoman.com
Cc: Insu Park <insu0.park@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [dunfell][1.46][PATCH 1/1] data: Add missing dependency handling of remove operator
Date: Wed, 27 Dec 2023 23:56:17 +0900
Message-Id: <20231227145617.8940-2-insu0.park@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227145617.8940-1-insu0.park@gmail.com>
References: <20231227145617.8940-1-insu0.park@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Dec 2023 14:56:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15708

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
  handle_contains() and handle_remove() out of the try block
  and added the 3rd argument, "exclusions", to handle_contains().
- The test code in codeparser.py are modified as the master branch
  added three more arguments to the build_dependencies().

Signed-off-by: Insu Park <insu0.park@gmail.com>
---
 lib/bb/data.py             |  1 +
 lib/bb/tests/codeparser.py | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index b0683c51..1d21e00a 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -301,6 +301,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 value += "\n_remove of %s" % r
                 deps |= r2.references
                 deps = deps | (keys & r2.execs)
+                value = handle_contains(value, r2.contains, d)
             return value
 
         if "vardepvalue" in varflags:
diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index f4852047..f1c4f618 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -412,6 +412,32 @@ esac
         # Check final value
         self.assertEqual(self.d.getVar('ANOTHERVAR').split(), ['anothervalue', 'yetanothervalue', 'lastone'])
 
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
+        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), self.d)
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


