Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f169.google.com (mail-pf0-f169.google.com
	[209.85.192.169])
	by mail.openembedded.org (Postfix) with ESMTP id 5495F6FFD3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:07 +0000 (UTC)
Received: by pfu207 with SMTP id 207so40747731pfu.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=5ZNwktamB+fWdvDaW2OHvjpma+fIO2dKTMSbdLVo5Rw=;
	b=svSbTERByy2A3zrq2loBVU22vBKfEwAX2u3LQudHZ/y2AEnnbr4NaphDpuNcWY3yet
	tMGgOu6qZIGsdsR98wN/Y2HUC40ksLc7ETB6jCXfc0ggbPtGMjjz/PUVjsC6zl2ZG7NU
	St7pVFD+XJ5fyfuNILyVLnKWEE7p4H4+tQkOAyUOvoDIdaax+MRIbWt3apajOJfkkDH1
	Byl+UNSPs5vfQLNl+XUBYZoE9tspR6QV2Vb0D+sDh1yo5lznY7cNZ5jmHwHo0hkg+138
	/ud4WiIfgwkFQ+O3A1FSuArJv18W1yIQhlivqW3UAI+4B/x8jAhoS6QHCcKWCmhoSBZn
	IHPw==
X-Received: by 10.98.14.67 with SMTP id w64mr3500565pfi.163.1449719588424;
	Wed, 09 Dec 2015 19:53:08 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:07 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:35 -0800
Message-Id: <8112dde8ffc2d96cc9b73a17643efec9663c5e75.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 10/18] toaster: Check Django version against toaster-requirements.txt
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:07 -0000

From: Elliot Smith <elliot.smith@intel.com>

Instead of hard-coding the required Django version in the start
script, look it up from the toaster-requirements.txt file.

[YOCTO #8364]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index e3c7867..0862a35 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -175,9 +175,15 @@ notify_chldexit() {
 
 verify_prereq() {
     # Verify prerequisites
+    regex="([0-9])\.([0-9])"
+    for line in `cat $BBBASEDIR/toaster-requirements.txt | grep Django` ; do
+        [[ `echo $line` =~ $regex ]]
+        required_major_version="${BASH_REMATCH[1]}"
+        required_minor_version="${BASH_REMATCH[2]}"
+    done
 
-    if ! echo "import django; print (1,) == django.VERSION[0:1] and django.VERSION[1:2][0] in (8,)" | python 2>/dev/null | grep True >/dev/null; then
-        printf "This program needs Django 1.8. Please install with\n\npip install django<=1.8.7\n"
+    if ! echo "import django; print ($required_major_version,) == django.VERSION[0:1] and django.VERSION[1:2][0] in ($required_minor_version,)" | python 2>/dev/null | grep True >/dev/null; then
+        printf "This program needs Django $required_major_version.$required_minor_version. Please install with\n\npip install -r $BBBASEDIR/toaster-requirements.txt\n"
         return 2
     fi
 
-- 
1.9.1


