Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail.openembedded.org (Postfix) with ESMTP id EBAE078F49
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 18:02:33 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so9773772wmc.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=KYofho2ZQUbFeJJuHI7t/vCnFmL2ROvPindU0czAs9I=;
	b=T4UJ5iGIEjODllDb/6uu6U2Wvr22j5sqg51qKx33oyOierUBjLfpNYmBrlFE/Md5cG
	hWyeRgGaHIDJ21W7Xe5u7B264KMELT7L8rzVWDJZifhiAUA5KMEN3Sq1Vsq2yX40iuJb
	q6pVa3MWh5vQDBmohZQr6yQ/hvjwzc7TsnTMfBovfi7fq4JlQlHD2JjuKbmVD46swe2p
	QSiHockMggipoctch1R0n0+aNKpUHwCnpYvd92yt3azDgrnG2N6NiX2ZPpFIP1rFWFAi
	y5rYrXZbPNtAEHNPoKSQCHzaw3LOrLTYcJ0KhhC3ciRITxz3KIUh8aXRGZyZIF38WSka
	T6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=KYofho2ZQUbFeJJuHI7t/vCnFmL2ROvPindU0czAs9I=;
	b=OJcWQWqVmEJma3kFFbk/dnlhsHqIdy+0uAdpZwta32R3li3VNZ70N4++tLdMO/6oqD
	HBQ918esjKFezMwJBgjSszrh15Ky6yeh4WlIQDxG080+9jBdo2KDpuuUTvlP86EwWG+q
	LNRs4ySKVz0/pSbr+dKKXzEXUvv4O39Lp2nWS4R9PyNGbu5MNTQ5VMqfat7B9dDNsGJj
	HGvNojAbqU1QUNt5ol9goumsQQOVH/DXIwkM9G/lFHtsYbUd0bVSg5wE7IrTE063Asx/
	4XeOrVkVAhZEawAF9BdWgHhOzTdXiWeyCUbfvrbspShpoFkOMYZAYrPcusH+Xm4+z1eF
	8aGw==
X-Gm-Message-State: AOUpUlEit9ICSauoSCm/VRyT53nl+SxWcBVi7Jsf+YsxnpQ2wqzPX/O5
	iPUrJw5zaOICzxPhiLlovUvhg7SMCTc=
X-Google-Smtp-Source: AA+uWPzW/KvaZYq6LxwHVqvBT7K0Md/KrSDv1bKRXLiL1EvF0/CH4SAnPdULDp1lZiPbceQI6o9DiA==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr8333564wmc.30.1534183354219;
	Mon, 13 Aug 2018 11:02:34 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	x23-v6sm6373245wmh.26.2018.08.13.11.02.32
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 Aug 2018 11:02:33 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Aug 2018 19:02:25 +0100
Message-Id: <20180813180226.18299-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH 1/2] utils/md5_file: don't iterate line-by-line
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
X-List-Received-Date: Mon, 13 Aug 2018 18:02:34 -0000

Opening a file in binary mode and iterating it seems like the simple solution
but will still break on newlines, which for binary files isn't really useful as
the size of the chunks could be huge or tiny.

Instead, let's be a bit more clever: we'll be MD5ing lots of files, but we don't
want to fill up memory: use mmap() to open the file and read the file in 8k
blocks.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/utils.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 9903183213b..b20cdabcf01 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -524,12 +524,17 @@ def md5_file(filename):
     """
     Return the hex string representation of the MD5 checksum of filename.
     """
-    import hashlib
-    m = hashlib.md5()
+    import hashlib, mmap
 
     with open(filename, "rb") as f:
-        for line in f:
-            m.update(line)
+        m = hashlib.md5()
+        try:
+            with mmap.mmap(f.fileno(), 0, access=mmap.ACCESS_READ) as mm:
+                for chunk in iter(lambda: mm.read(8192), b''):
+                    m.update(chunk)
+        except ValueError:
+            # You can't mmap() an empty file so silence this exception
+            pass
     return m.hexdigest()
 
 def sha256_file(filename):
-- 
2.11.0


