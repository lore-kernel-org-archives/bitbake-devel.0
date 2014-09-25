Return-Path: <ross.burton@intel.com>
Received: from mail-we0-f177.google.com (mail-we0-f177.google.com
	[74.125.82.177])
	by mail.openembedded.org (Postfix) with ESMTP id F0CAA60144
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 14:31:55 +0000 (UTC)
Received: by mail-we0-f177.google.com with SMTP id t60so7928396wes.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 07:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=XPzGZwX48ea7fyo1i20sa/nGy+/g7Dsx637hjObwuZU=;
	b=V3Y8gqEfq5oxyKN2mj3r6qGkjoRk/p/uKSimk7L9NaTLBy9P4rFB5jPdASY4g3hfrI
	bxPn1isEUt7kpaJIUHeu1jVtlxyA2juH1Vo+NJHrvYXRDyQ8CFB9J4Uj1lkF59eayL9H
	HCEmAtf1CRs/2ptu0KvdNtR20IjFAPEneO1py6iCypQRLJllJ/beyZy403DMcvAbMYYf
	NMMGQXxhooSj3COoCvtlwFEKRhUtbUNl/6TFzcy7c1xWGKCiMU9ZmrV7MNiu8y0beKku
	9GdmXVZGtHRK7GTdYVvSuvhZBAMxHZKa+P6+GC61RNh5/iiZAUjroyi9qO6L9Iav6O0F
	hkdw==
X-Gm-Message-State: ALoCoQkdZlzZbgnI908rklwUKSBi2QY73J02vfrAoJxx7lCiCFcLhrGwczsFm0Y321KylXJ/ojvT
X-Received: by 10.194.121.232 with SMTP id ln8mr16503089wjb.65.1411655516297; 
	Thu, 25 Sep 2014 07:31:56 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPSA id
	ks10sm2888435wjb.38.2014.09.25.07.31.54
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Sep 2014 07:31:55 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Sep 2014 15:31:51 +0100
Message-Id: <1411655511-11479-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] monitordisk: don't log when not monitoring a filesystem for inodes
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
X-List-Received-Date: Thu, 25 Sep 2014 14:31:57 -0000

Writing a log that the filesystem isn't being monitored for inode usage just
confuses users who are not aware about the nature of inodes in their filesystem,
so don't say anything, just silently disable the monitor.  In general this only
happens on filesystems which don't have a limit on inodes.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/monitordisk.py |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
index 6b03682..466523c 100644
--- a/bitbake/lib/bb/monitordisk.py
+++ b/bitbake/lib/bb/monitordisk.py
@@ -239,11 +239,9 @@ class diskMonitor:
                 freeInode = st.f_favail
 
                 if minInode and freeInode < minInode:
-                    # Some fs formats' (e.g., btrfs) statvfs.f_files (inodes) is
-                    # zero, this is a feature of the fs, we disable the inode
-                    # checking for such a fs.
+                    # Some filesystems use dynamic inodes so can't run out
+                    # (e.g. btrfs). This is reported by the inode count being 0.
                     if st.f_files == 0:
-                        logger.info("Inode check for %s is unavaliable, will remove it from disk monitor" % path)
                         self.devDict[k][2] = None
                         continue
                     # Always show warning, the self.checked would always be False if the action is WARN
-- 
1.7.10.4


