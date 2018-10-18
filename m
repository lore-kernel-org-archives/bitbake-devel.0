Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 6C5B879BEA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 09:22:55 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so32414704wrt.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=UZC2z8nDQfjITfAWOIsOvCPNreTf4x4ro831T+vMI1k=;
	b=YXRJtZ8gyBUb+vRyVDug9zgUP4FM2rzu41Bv4EkXlYeHprYLm0NKDQ6OY5OLQ27Pu8
	lDUAlKchc/SgtyWVYm3Rmj6P/wwfLwY9eSdQLqlLHKn7WW8/lnSECToXS/uFCDg4qVop
	1EF3uuxmhCf+G8gqo5Zj0zBA5gglu8FdFxhDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=UZC2z8nDQfjITfAWOIsOvCPNreTf4x4ro831T+vMI1k=;
	b=CQwwep3DHk+xtz7IhoAfsKfsVElO9WY7+b7hlIymf6jkKOglqRYVmuhoMPPn/ckAw+
	BFrhcTn1Ra/QNZ6YfNlyM1wsBHhJDP1bHudOaxXURkYVETaDg4J3lctPsUDEsVI3FqJb
	mFUk76Md+xgXi+FJ1/pgkXMLUvsoereBmXMrU91/d31fILqKRilydrIoLfS3pFKwN3ll
	20E4rn9oKmDnqvUELjcdxh3OPfbnU31O1l4xwpz8MyIYlwekred8EdCjA2xiFBZfK1pM
	8ZD1PAf8TlQ26MXFhHrvFf3Hr2t8nABg4JL6HoutedBYSzdr7t0LPgb4CEUqzKL0V5R5
	4z9w==
X-Gm-Message-State: ABuFfoiBTkyAHSzu6+jskN0eEXeeSoA91h60b+rArxV9QuNI2QuCCVy/
	XcfL7zUYtgGg05UmJp3mnIYuoI0GWA4=
X-Google-Smtp-Source: ACcGV60UDOSQqXYTuUajbPXgrqxUx0Z7TudZTB+2HFDrBEqJnuXojegCyo6tsnGS9kR3iyzgHr9W0w==
X-Received: by 2002:adf:c989:: with SMTP id
	f9-v6mr27503024wrh.148.1539854575759; 
	Thu, 18 Oct 2018 02:22:55 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x17-v6sm17666494wrs.84.2018.10.18.02.22.54
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 02:22:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Oct 2018 10:22:46 +0100
Message-Id: <20181018092246.1445-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
References: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
Subject: [PATCH 7/7] test/data: Add new tests for task checksum changing/not changing
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
X-List-Received-Date: Thu, 18 Oct 2018 09:22:55 -0000

This adds some basic tests for task checksums to ensure that the
checksums:

* change when variables change
* change when active _remove operators are present
* don't change when the _remove operators are not active
* change when an active contains() expression is present
* dont' change a contains() expression isn't active

There is a lot of other functionality which should be added to this
test but its a start.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/data.py | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 8279115e03..9ac78e3683 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -455,6 +455,54 @@ class Contains(unittest.TestCase):
         self.assertFalse(bb.utils.contains_any("SOMEFLAG", "x y z", True, False, self.d))
 
 
+class TaskHash(unittest.TestCase):
+    def test_taskhashes(self):
+        def gettask_bashhash(taskname, d):
+            tasklist, gendeps, lookupcache = bb.data.generate_dependencies(d)
+            taskdeps, basehash = bb.data.generate_dependency_hash(tasklist, gendeps, lookupcache, set(), "somefile")
+            bb.warn(str(lookupcache))
+            return basehash["somefile." + taskname]
+
+        d = bb.data.init()
+        d.setVar("__BBTASKS", ["mytask"])
+        d.setVar("__exportlist", [])
+        d.setVar("mytask", "${MYCOMMAND}")
+        d.setVar("MYCOMMAND", "${VAR}; foo; bar; exit 0")
+        d.setVar("VAR", "val")
+        orighash = gettask_bashhash("mytask", d)
+
+        # Changing a variable should change the hash
+        d.setVar("VAR", "val2")
+        nexthash = gettask_bashhash("mytask", d)
+        self.assertNotEqual(orighash, nexthash)
+
+        d.setVar("VAR", "val")
+        # Adding an inactive removal shouldn't change the hash
+        d.setVar("BAR", "notbar")
+        d.setVar("MYCOMMAND_remove", "${BAR}")
+        nexthash = gettask_bashhash("mytask", d)
+        self.assertEqual(orighash, nexthash)
+
+        # Adding an active removal should change the hash
+        d.setVar("BAR", "bar;")
+        nexthash = gettask_bashhash("mytask", d)
+        self.assertNotEqual(orighash, nexthash)
+
+        # Setup an inactive contains()
+        d.setVar("VAR", "${@bb.utils.contains('VAR2', 'A', 'val', '', d)}")
+        orighash = gettask_bashhash("mytask", d)
+
+        # Activate the contains() and the hash should change
+        d.setVar("VAR2", "A")
+        nexthash = gettask_bashhash("mytask", d)
+        self.assertNotEqual(orighash, nexthash)
+
+        # The contains should be inactive but even though VAR2 has a
+        # different value the hash should match the original
+        d.setVar("VAR2", "B")
+        nexthash = gettask_bashhash("mytask", d)
+        self.assertEqual(orighash, nexthash)
+
 class Serialize(unittest.TestCase):
 
     def test_serialize(self):
-- 
2.17.1


