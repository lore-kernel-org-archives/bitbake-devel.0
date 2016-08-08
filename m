Return-Path: <matt@madison.systems>
Received: from mail-pf0-f175.google.com (mail-pf0-f175.google.com
	[209.85.192.175])
	by mail.openembedded.org (Postfix) with ESMTP id 646D0771A7
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 22:44:08 +0000 (UTC)
Received: by mail-pf0-f175.google.com with SMTP id h186so123009785pfg.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 08 Aug 2016 15:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=madison-systems.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=tMafzwjypL0iS2ox4FtD0Sd9s5FBIYKmkAbN3Ob3pdY=;
	b=lkC7fP39kqtBYgsZRpsHI+cOhb5ygXx265K3XCNwSU4i/27ow4Bbn1/bFP+Qeb+rZl
	DH/jX+JvYZutUp8zIGpX7rKUwz7m7oVlIKEknRZHvLt6gAjDN3zbeGReeiWCbW4kjy8Y
	N+Nx9gerW+n8Yh5RfBUfJqEC5vnF1zHswUe0oBkl9CXXi4VKp/uSFgbn93xVvfnrqm7L
	zV1ThtJHhzfbvK/VAbdn1NfDvV39eg/s+98aN6XG6yn3Z4PqPXp79s5uzFkZC94n7JHG
	zyVPjx/4RUz66m/J7qbuc/LTHZVb1cfKKQJtfCraXn5xp19S80ErNc8M3Q/ScXt6/1Qj
	vkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=tMafzwjypL0iS2ox4FtD0Sd9s5FBIYKmkAbN3Ob3pdY=;
	b=XrH4rXr1F4kAmCK65Z2BAAl91jOkpd4qRCpsFDkuZ27TtcdS7LdJiBcKIVMsIfMRzN
	bRaSLBvYskRH962OF6Xna8Ow2MyRyjvBT3oh0iTASrJF0/cpFwCC8vDO8D2eFxlTD54C
	V2M2vQKmzg17ehnO7huaYnTXWi6v7/s1+gyKNBctN0cFfOLPLI/tGd+49oLA7moPzZwI
	KEhkjhi2yiMNilLPiXh+J058EjARHB6iszt9w1hU+dJbEn558ohPCCNS32LM8TwNk4rt
	FfbMMfZGRF2qisrzZ+6Sf6fK7qUKXLupD/9nEGzfbscCNKtfG6k4fbcdtl88kpe6lMZQ
	gQqg==
X-Gm-Message-State: AEkooutzEZpViKzK4HnJGI+6XIjfrkxHSjRHhHzYaHGEywl1GAxRZB8CG+DpTUEUDwoY+g==
X-Received: by 10.98.24.194 with SMTP id 185mr165914526pfy.52.1470696248787;
	Mon, 08 Aug 2016 15:44:08 -0700 (PDT)
Received: from workhorse.madison.systems
	(70.90.175.93-BusName-ca.sfba.hfc.comcastbusiness.net.
	[70.90.175.93]) by smtp.gmail.com with ESMTPSA id
	d72sm50548450pfj.15.2016.08.08.15.44.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Aug 2016 15:44:07 -0700 (PDT)
From: Matt Madison <matt@madison.systems>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Aug 2016 15:43:43 -0700
Message-Id: <1470696223-9260-1-git-send-email-matt@madison.systems>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] fetch2: save/restore cwd for mirror URL downloads
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
X-List-Received-Date: Mon, 08 Aug 2016 22:44:10 -0000

Fixes "changed cwd" warnings from setscene tasks when the
packages are downloaded from a shared-state mirror.

Signed-off-by: Matt Madison <matt@madison.systems>
---
 lib/bb/fetch2/__init__.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 9054b2e..c0017a8 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -928,6 +928,8 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
     if ud.lockfile and ud.lockfile != origud.lockfile:
         lf = bb.utils.lockfile(ud.lockfile)
 
+    save_cwd = os.getcwd()
+
     try:
         if check:
             found = ud.method.checkstatus(fetch, ud, ld)
@@ -995,6 +997,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
             pass
         return False
     finally:
+        os.chdir(save_cwd)
         if ud.lockfile and ud.lockfile != origud.lockfile:
             bb.utils.unlockfile(lf)
 
@@ -1558,6 +1561,7 @@ class Fetch(object):
 
         network = self.d.getVar("BB_NO_NETWORK", True)
         premirroronly = (self.d.getVar("BB_FETCH_PREMIRRORONLY", True) == "1")
+        save_cwd = os.getcwd()
 
         for u in urls:
             ud = self.ud[u]
@@ -1635,6 +1639,7 @@ class Fetch(object):
             finally:
                 if ud.lockfile:
                     bb.utils.unlockfile(lf)
+        os.chdir(save_cwd)
 
     def checkstatus(self, urls=None):
         """
-- 
2.7.4


