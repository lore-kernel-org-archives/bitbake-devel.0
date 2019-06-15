Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id CA3957EA99
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 07:17:45 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id n4so4723904wrs.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 00:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=GNk7XauTzB5KNHjImpqwLpwEJ5o8NOGQWyWk/Lg8Vzk=;
	b=BCj/hDpxvFv4Fl4ssrPCCtWahcDWeyNO8u44Qr0GHFoEowhQZXlierLLqqttxO4W8k
	niSikyGA0yxRmhg3LD37rCnmcRhyV4GnB0TOqE4GokCeWElnbtwq8hCq+3ijs1V/wKWZ
	cmGQtgh4Jfw3cFoyEooaD1jbtDiRe1jIHDdwqE9JrbI8zLnBqIUjKpMgwBEyeJ6GRwKI
	HVksMmU1oRMqO7SJcZs7Cbw5WN9mFdgvTs2VG+dhIPcrnH9YZNlHozolMFgn6i86QOZT
	z5lurCCxVujXphGhgZ+LTlrlDruHiEPh3xLiSMoH2MtJ5BJksv59PNOxXkX6p2EDobh7
	AudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=GNk7XauTzB5KNHjImpqwLpwEJ5o8NOGQWyWk/Lg8Vzk=;
	b=nDOIzkUPJecNf3TgnSZOIToMkkxpZLSSIaGpoZ9HHGZ555HcApbPNvye/GyWctjJ4l
	2DAID8TdPVdK7JFJCJrid69kGYWnRoUaUc24oyg1s4NB0SD3VPVfD0XR6pvm7QMa6IgN
	lo3IwLYK029MUjompxkGMb1wPguXN4aIYEx90obRE7lxH1nDOnVJNnCPmgppRe0aL64t
	qx3iuROPOMWevFNl9+8dvWARHycK6nhAm3DISIpPBiuHSLY0fSfN+O0ABhETqpdakk6K
	BbffUqwwkU7FUqqbVISQyD2P+OtfJqu1xqR+F8cYcxMeiwXwDORzUHHXNjkoa3Vrm/S9
	Hk2g==
X-Gm-Message-State: APjAAAUgEoTfG6kRAklfFL6k5+lXCXQAxcmG/4fpOyZuWsQI4JRo87P6
	d4mE4sxb7Po1uFhCW2T4qyPR8h9Z
X-Google-Smtp-Source: APXvYqzriu5mslF2AH0ADIASrsZCahzw9wS53F8JknFqn6j2d0Auiu3aUO12zWB0pQ72CMnk7zeXuQ==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr32101352wrv.61.1560583066284; 
	Sat, 15 Jun 2019 00:17:46 -0700 (PDT)
Received: from localhost (ip-217-030-068-212.aim-net.cz. [217.30.68.212])
	by smtp.gmail.com with ESMTPSA id
	v18sm3272860wrs.80.2019.06.15.00.17.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 15 Jun 2019 00:17:45 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 07:17:43 +0000
Message-Id: <20190615071743.9494-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [1.40][PATCH] bitbake: fix version comparison when one of the versions ends in .
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
X-List-Received-Date: Sat, 15 Jun 2019 07:17:46 -0000

From: Alexander Kanavin <alex.kanavin@gmail.com>

Previously, this would happen:

======================================================================
ERROR: test_vercmpstring (bb.tests.utils.VerCmpString)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/alexander/development/poky/bitbake/lib/bb/tests/utils.py", line 45, in test_vercmpstring
    result = bb.utils.vercmp_string('1.', '1.1')
  File "/home/alexander/development/poky/bitbake/lib/bb/utils.py", line 143, in vercmp_string
    return vercmp(ta, tb)
  File "/home/alexander/development/poky/bitbake/lib/bb/utils.py", line 135, in vercmp
    r = vercmp_part(va, vb)
  File "/home/alexander/development/poky/bitbake/lib/bb/utils.py", line 124, in vercmp_part
    elif ca < cb:
TypeError: '<' not supported between instances of 'NoneType' and 'int'

----------------------------------------------------------------------

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/utils.py | 4 ++++
 lib/bb/utils.py       | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 2f4ccf3c..f1cd83a4 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -42,6 +42,10 @@ class VerCmpString(unittest.TestCase):
         self.assertTrue(result < 0)
         result = bb.utils.vercmp_string('1.1', '1.0+1.1-beta1')
         self.assertTrue(result > 0)
+        result = bb.utils.vercmp_string('1.', '1.1')
+        self.assertTrue(result < 0)
+        result = bb.utils.vercmp_string('1.1', '1.')
+        self.assertTrue(result > 0)
 
     def test_explode_dep_versions(self):
         correctresult = {"foo" : ["= 1.10"]}
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 73b6cb42..215c18cf 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -120,6 +120,10 @@ def vercmp_part(a, b):
             return -1
         elif oa > ob:
             return 1
+        elif ca is None:
+            return -1
+        elif cb is None:
+            return 1
         elif ca < cb:
             return -1
         elif ca > cb:
-- 
2.17.1


