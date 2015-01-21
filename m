Return-Path: <ross.burton@intel.com>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 897347231B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 14:15:13 +0000 (UTC)
Received: by mail-wg0-f42.google.com with SMTP id k14so40028252wgh.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 06:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=jOyo92VYzlTbjI93fE1NwKrLIGpJHqLYZrTWYG64Iuc=;
	b=FQ+u1LVir0RzhUBpxrw1xgq0CryQM/PGohCFkW/EZ+w+hd83LKHBPyZWoOvpgeO5ut
	kskQl/D1yzy79nVokTKpRyhbcbS41po+912czsmzrv/K2XEYOXpgyLIh4spFLwyn2ubs
	ocFKSgyvT1HfXF9Pk3MlD2teiWHLnVcbX3cSnWR/uLD8//07knP3HfAkae5ZzN0hAcYl
	bbssSNZQZZyjUHa6cTOTwvFy/7w7mJZrV6ja7D3Nv1jaj9mepHwizuj7zcWI7Gbwl9Vg
	6RA5m7HyXS88ShoSKUBMMhOx+if0/xMdj5cuAV5jKHISny1SP5W3G9ydo/Pqiubqkdg8
	Tolw==
X-Gm-Message-State: ALoCoQl4fvmuirRT6WMqU5b0eFOrnxepJNDMiI2XuTwemZkJWZoGbo1Dr6viu5naiG4zGIfij3+c
X-Received: by 10.194.108.162 with SMTP id hl2mr50276797wjb.134.1421849713658; 
	Wed, 21 Jan 2015 06:15:13 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35])
	by mx.google.com with ESMTPSA id 18sm25696672wjr.46.2015.01.21.06.15.12
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 06:15:12 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 14:13:38 +0000
Message-Id: <1421849618-28332-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] bitbake: only check that /dev/shm is writable on Linux
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
X-List-Received-Date: Wed, 21 Jan 2015 14:15:19 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/bin/bitbake |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index d46c3dd..49efdf1 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -44,8 +44,8 @@ from bb import cookerdata
 __version__ = "1.25.0"
 logger = logging.getLogger("BitBake")
 
-# Python multiprocessing requires /dev/shm
-if not os.access('/dev/shm', os.W_OK | os.X_OK):
+# Python multiprocessing requires /dev/shm on Linux
+if sys.platform.startswith('linux') and not os.access('/dev/shm', os.W_OK | os.X_OK):
     sys.exit("FATAL: /dev/shm does not exist or is not writable")
 
 # Unbuffer stdout to avoid log truncation in the event
-- 
1.7.10.4


