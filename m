Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 95EE96FF69
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 15:17:05 +0000 (UTC)
Received: by mail-pa0-f45.google.com with SMTP id cd13so3303913pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=5VAYjaM4cVFWO15Zs4d/CIpmPD9s37FjMAX1gKGufsY=;
	b=SO8ThIakfZsBCz6PhI7ZQB0kGQmL9pvhXMjvgNRpHH7eEPnwlYEdE2ioouTumDgnQB
	2/Ibdd9nfCx51cjd22c+4G5p0dwAd4QIrx2Os9TlU/9JJGVpFwVfRTRPoDtktskj3uue
	mUd27kHaqeUbKvKCe+jdmfmGOl5LY+VERTFY0q5bcZxNlBeu2RNPU2eepZ5uRJ8oo3H6
	HwPcv0uD5fpPvmCxSHYf5nWjoNcTSbgwyEugpbEf9f89IJ5kZb6aLNchDCYOvog3PAV1
	1pyWrVMbeebgxhnZ+GeGlWH1UO9iCkLl4dJa5xwrGFB7D+L6kb9ua5t9XN/BlZi7XrbB
	ghHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=5VAYjaM4cVFWO15Zs4d/CIpmPD9s37FjMAX1gKGufsY=;
	b=b/HdggjczkB3IJ4ieTMlvXlpFk7WLeloYWVZPDbYjGAsk0+TsTJqsJKjcCB9qKyUef
	A9vSeN0Vx7uQgCIbbtgGp0F4kpgDSAyKRxvm/eiJMrPd5RHkyaIcY0AHD7wklkeAK5wn
	RxccyqzsdSVGgqPCfLncIIt2HaRP5BESXOi8GY7vgcKSAeVECaWodTz6ZH/7w0NyqvLB
	6wPYUUG5a3DEc4+yiCx7WXyiLad1E+lgQs310VpGiiIh9TcTirY8ScYXGvzkx0c8IZpw
	+iM/a5sKiKnZFa3gmG/8YgO68+Nh5VJmiHdmdNgEPZMFdZ80Aw3EU0ygXBs3jqDeu5Tj
	NXNQ==
X-Gm-Message-State: AA6/9RlxMODxKwqJV6iuVSgYQl3uPEl8zI53d/hSfMdY51jua37z0o2RLRejDPLMJsRVI6sZ
X-Received: by 10.66.235.37 with SMTP id uj5mr3067242pac.176.1474989426823;
	Tue, 27 Sep 2016 08:17:06 -0700 (PDT)
Received: from orion.ld.intel.com (fmdmzpr01-ext.fm.intel.com. [192.55.54.36])
	by smtp.gmail.com with ESMTPSA id
	p1sm5784876pae.12.2016.09.27.08.17.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 27 Sep 2016 08:17:06 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Sep 2016 16:16:53 +0100
Message-Id: <1474989416-10454-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474989416-10454-1-git-send-email-michael.g.wood@intel.com>
References: <1474989416-10454-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 2/5] toaster: check if file exist
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
X-List-Received-Date: Tue, 27 Sep 2016 15:17:05 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Buildinfohelper assumes that all files mentioned in
manifest exist in deploy/ directory, which is not always
the case. Toaster crashes with OSError trying to
call os.stat on non-existing file.

Checking if file exists before processing it should
fix this.

[YOCTO #10185]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index b2c74dd..970a941 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1758,6 +1758,9 @@ class BuildInfoHelper(object):
 
                 for basename in basenames:
                     artifact_path = os.path.join(deploy_dir_image, basename)
+                    if not os.path.exists(artifact_path):
+                        logger.warning("artifact %s doesn't exist, skipping" % artifact_path)
+                        continue
                     artifact_size = os.stat(artifact_path).st_size
 
                     # note that the artifact will only be saved against this
-- 
2.7.4


