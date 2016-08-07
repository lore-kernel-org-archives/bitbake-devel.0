Return-Path: <matt@madison.systems>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id 50688760B0
	for <bitbake-devel@openembedded.org>;
	Sun,  7 Aug 2016 13:37:59 +0000 (UTC)
Received: by mail-pa0-f53.google.com with SMTP id ti13so27490856pac.0
	for <bitbake-devel@openembedded.org>;
	Sun, 07 Aug 2016 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=madison-systems.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=tMafzwjypL0iS2ox4FtD0Sd9s5FBIYKmkAbN3Ob3pdY=;
	b=lYIUJAvtKaT7Mn+Q93nx9ZJIGEVbLYGii1vhSjGiy9YGHEaDTWl0T+SR8okaeEosmt
	0riuXfwJX7R+C3B7i6Cj0saSDTfG3gdjjejvdloilu6ZFcZ/uGtgkb4oVnSIRkIHOMOD
	DumE1YkYJSmvlcqks7ENsJN+s9cRjqjET54bVLMMn/C3XhuG8h998OJsHO7MJJcqhZJj
	mWzj5BRwoOK4eow5FnWBqvEXY1K3K7WyUtto3dYFnUzScMvjiPvjjapYSGPpx4qmapq1
	Z1ScMqpGnmQlNJP20ZeJFDEw/Z5HzqsHuctVnawzS6LdLy4X0q/MMhWluMa/c8+djT0N
	ee1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=tMafzwjypL0iS2ox4FtD0Sd9s5FBIYKmkAbN3Ob3pdY=;
	b=Q88HbWFQ+fH8JmK3aF07do1n0Mmdp5br5Dup38IyZK6UmxwapLfVwj1eylIV0js5RR
	xZxS6cVS2PRKbZkfBKNDvxmvQU8xoFaahyzV/FwxJVyLdiWyqXa5/CoO6WhjNHQ7/Brm
	kEyATmM9+uOdCf56DS6m0+LrC3GPLBCNQ97sGTVi+Q/LRZthp8ghjkTPirJDr8Wkqlx2
	jkVt1n8xocatHr9E8ddwqGepQIfESLOQKWg/TJAVA3k8IlisHhuDjtqnqKAuiIfMWZPa
	QnZxFPXP8j3Qb9+ui2VuPymtYjK4Jt05c1cNOPmRFKo3Sha1PXuE8aloZnLqBDMVm6Jk
	LrAQ==
X-Gm-Message-State: AEkooutaEVFnQcn6r55xnCGJCQ7S+mdhDX7kccMU+fS1WN3FyK/OHIxwN1kWfUns8QvH/A==
X-Received: by 10.66.230.195 with SMTP id ta3mr154171003pac.89.1470577080010; 
	Sun, 07 Aug 2016 06:38:00 -0700 (PDT)
Received: from workhorse.madison.systems
	(70.90.175.93-BusName-ca.sfba.hfc.comcastbusiness.net.
	[70.90.175.93]) by smtp.gmail.com with ESMTPSA id
	xx7sm41059982pac.3.2016.08.07.06.37.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 07 Aug 2016 06:37:59 -0700 (PDT)
From: Matt Madison <matt@madison.systems>
To: bitbake-devel@openembedded.org
Date: Sun,  7 Aug 2016 06:37:31 -0700
Message-Id: <1470577051-17709-1-git-send-email-matt@madison.systems>
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
X-List-Received-Date: Sun, 07 Aug 2016 13:38:00 -0000

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


