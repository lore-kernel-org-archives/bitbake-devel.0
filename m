Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id CF0466EDF9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:15 +0000 (UTC)
Received: by mail-wi0-f182.google.com with SMTP id d1so3680570wiv.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=GJU4jSJRjcmBs7gN1fgPH687HXDzGbwapYP+Dt4J0D8=;
	b=hRRbxJtAB3bwtdCwCcV4acY2rywTJR0fbGNtyfvBod7GxurBN5RyUJa4FvQhiiWdul
	gfTy31MxhLlkmtRyxLZM3ccOTl6XhDvIxbi+smnO47FkCmQATWbHu14uc8KXVgV8YPFM
	IzcmJTHKvBpEZVJp+i1V2V000JHILbZU1y2kHi65+ExRpnA77RtPtqQTmm1uft9uMpLo
	j6s98oKeBjO3r/FwAqSz0ms0iSrz6kAFg/vPjYKNgLiJjblHzLXtZ0EynyA+x3ut95JB
	TuIdcrA3wJlMy1RwpBPkmLNdO9fOOMJkwIQqVtvOJAEBT9ze0Wrdtm/EBYJU2B8jQZTy
	kS0A==
X-Gm-Message-State: ALoCoQlk73twSp5nhqzBzVMvGOJs2vuznA1DZNOUddyIU/Dasak4XzrNoUC8M5Lx+6+h+7t7AEri
X-Received: by 10.194.90.39 with SMTP id bt7mr4553868wjb.93.1396284435996;
	Mon, 31 Mar 2014 09:47:15 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id w6sm13283630wjq.29.2014.03.31.09.47.13
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:14 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 09D0B5601EB; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:02 +0100
Message-Id: <53e5cdf5b6cd715e8b1ed57c52abbce2184de75e.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
References: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 02/14] toaster: fix timezone detection
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:16 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch replaces faulty timezone detection with a version
that simply reads the TZ environment variable if it is set.

If the TZ is not set, we do a reverse match search among known
timezone definitions and take the first match.

    [YOCTO #5499]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastermain/settings.py | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 51fa3cc..e26ee3c 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -50,9 +50,23 @@ ALLOWED_HOSTS = []
 # although not all choices may be available on all operating systems.
 # In a Windows environment this must be set to your system time zone.
 
-# Always use local computer's time zone
-import time
-TIME_ZONE = time.tzname[0]
+# Always use local computer's time zone, find
+import os, hashlib
+if 'TZ' in os.environ:
+    TIME_ZONE = os.environ['TZ']
+else:
+    # need to read the /etc/localtime file which is the libc standard
+    # and do a reverse-mapping to /usr/share/zoneinfo/;
+    # since the timezone may match any number of identical timezone definitions,
+
+    zonefilelist = {}
+    ZONEINFOPATH = '/usr/share/zoneinfo/'
+    for dirpath, dirnames, filenames in os.walk(ZONEINFOPATH):
+        for fn in filenames:
+            filepath = os.path.join(dirpath, fn)
+            zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = filepath.lstrip(ZONEINFOPATH).strip()
+
+    TIME_ZONE = zonefilelist[hashlib.md5(open('/etc/localtime').read()).hexdigest()]
 
 # Language code for this installation. All choices can be found here:
 # http://www.i18nguy.com/unicode/language-identifiers.html
-- 
1.9.1


