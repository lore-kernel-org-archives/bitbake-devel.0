Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id EDEFD71B39
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 15:15:24 +0000 (UTC)
Received: by mail-io0-f181.google.com with SMTP id j65so235046717iof.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 07:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=ctjRvTe0y5OoYwceM+uCnUwulATJyrnH/DotXUzJB+4=;
	b=QURM8tNPgBlJbXoNPsS7fcIVE8jOh5LCxcf+9ujLarDdd57HJ+mYNMtxwaMzHIlgwz
	2/4rQvyzVigePEw20cl8BRoPCj4r8sbEzjjXjA3PCcFXeKMuI4qzommjgTeWHiTIHZLh
	QVqarPMGOpI1qMfSnCwQjK1J89QF/nr11o+/BlDtRD5+GXxj4OI6xdaPNctTgmxN49PN
	8GNsRPu8kmVakIc4C+xhgjQdPX3mSkt+GOGv1NE834fn4mXuriL05Gp4G73f++5spF83
	UBTDKZMUdmjYMjDZtm9n+Jbc6GUOHRrWoCDwoJVTZeD+r63ey1bRfH4VzCl7fjQUNr/k
	7lvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ctjRvTe0y5OoYwceM+uCnUwulATJyrnH/DotXUzJB+4=;
	b=cbDNt1KTEoXIpyZOPrVxiyJc2NW+ljo0P15k2iSRehrRs74Arc4yQ6MHvjjJVqqbjy
	/p9D+jlFSc2TJmYr/EIzzgqvoI8VmsSKnxM8cAq9UO6eQS6STKOWlwkU8KyMar70hP3c
	mbseIdVvWGrDjZ7tkAPhBX5h32LOhOSzwCqZ7G8QckevtmszxnXsilWl4byCxFxjZpEx
	Y7YrV5kwxkzKE2DFitPJmhM3T0/zImChVuZDgPPm6x5ndynwpvh9dwFdcsHdaNhRZEp4
	PJNgKrD3sk+FmeFuQ6+VZNwaEY8/QHQ9EOVLKkWTqVfFp5duHi9HkD5Y4vCo+ssx1gJh
	yv7w==
X-Gm-Message-State: AKaTC02aJdc/nnrInPSdhzO9dn2Su824Pf44vcFTQD0MIS3va3mWGKj8QpyNWofr1wQcPBWA
X-Received: by 10.107.137.101 with SMTP id l98mr17428186iod.215.1480346125744; 
	Mon, 28 Nov 2016 07:15:25 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8C83A.dip0.t-ipconnect.de.
	[93.232.200.58]) by smtp.gmail.com with ESMTPSA id
	i75sm9364092itf.10.2016.11.28.07.15.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Nov 2016 07:15:24 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Nov 2016 16:15:12 +0100
Message-Id: <1a47403ab5698b458d8b47d4600f208add7415b8.1480345719.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <90660fc75cc3fedceabef02ac2ade99d7c26fbb2.1480345719.git.patrick.ohly@intel.com>
References: <90660fc75cc3fedceabef02ac2ade99d7c26fbb2.1480345719.git.patrick.ohly@intel.com>
In-Reply-To: <cover.1480345719.git.patrick.ohly@intel.com>
References: <cover.1480345719.git.patrick.ohly@intel.com>
Subject: [PATCH 3/4] monitordisk.py: minor code and comment cleanup
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
X-List-Received-Date: Mon, 28 Nov 2016 15:15:25 -0000

There's no need to encode and decode the hash key as a single string,
a tuple works just fine. Iterating over entries can be written more
concisely.

Entries in the stat results are integers, not floating point values.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/monitordisk.py | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index 203c405..0f9010a 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -129,7 +129,7 @@ def getDiskData(BBDirs, configuration):
             bb.utils.mkdirhier(path)
         dev = getMountedDev(path)
         # Use path/action as the key
-        devDict[os.path.join(path, action)] = [dev, minSpace, minInode]
+        devDict[(path, action)] = [dev, minSpace, minInode]
 
     return devDict
 
@@ -205,16 +205,13 @@ class diskMonitor:
         """ Take action for the monitor """
 
         if self.enableMonitor:
-            for k in self.devDict:
-                path = os.path.dirname(k)
-                action = os.path.basename(k)
-                dev = self.devDict[k][0]
-                minSpace = self.devDict[k][1]
-                minInode = self.devDict[k][2]
+            for k, attributes in self.devDict.items():
+                path, action = k
+                dev, minSpace, minInode = attributes
 
                 st = os.statvfs(path)
 
-                # The free space, float point number
+                # The available free space, integer number
                 freeSpace = st.f_bavail * st.f_frsize
 
                 if minSpace and freeSpace < minSpace:
@@ -235,7 +232,7 @@ class diskMonitor:
                         rq.finish_runqueue(True)
                         bb.event.fire(bb.event.DiskFull(dev, 'disk', freeSpace, path), self.configuration)
 
-                # The free inodes, float point number
+                # The free inodes, integer number
                 freeInode = st.f_favail
 
                 if minInode and freeInode < minInode:
-- 
2.1.4


