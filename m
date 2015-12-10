Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f175.google.com (mail-pf0-f175.google.com
	[209.85.192.175])
	by mail.openembedded.org (Postfix) with ESMTP id 63A4B6FFD7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:52:57 +0000 (UTC)
Received: by pfu207 with SMTP id 207so40745767pfu.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=7VESyyBVV7uXVjR+o192grYuM8dmznBnjKVI8xuZGSg=;
	b=mg0ulGgdUHquxJKm+BR5Y6ensiWroDk6em2hSDRTjO59QYtslpUCxqNHsj6OiDHtJT
	G35uXrg4xNkZhRIgxBqcBpYgzto7iR7oKSUaqKApryGCRYvx36PvvniFAwYOs5WxQes/
	5OzTXLoKcudXG+XNXRNZhlSPiD5aSTXzPNCrUJEpuoFz16N/E+ShZWojK35SXNCOli2K
	Fw9DcFzIcI4y67N2uFkaOiJWvvn2gsxyyJo5x5uWUzijbduD7lb7xVFgt3dfyp6BMPo6
	wtky5I5CxbTQ+BBeYqcT65ISmsN8MxbyMFG0aiqLrCWQVv1EJ6c+lgo6zsrxr6nMRBau
	VMOQ==
X-Received: by 10.98.12.8 with SMTP id u8mr3609338pfi.76.1449719578792;
	Wed, 09 Dec 2015 19:52:58 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.52.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:52:58 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:26 -0800
Message-Id: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 01/18] toaster: Upgrade to Django 1.8.6 and remove South
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
X-List-Received-Date: Thu, 10 Dec 2015 03:52:58 -0000

From: Elliot Smith <elliot.smith@intel.com>

Upgrade Django to long-term support version.

Django now provides its own migration framework, so remove
requirement for South.

[YOCTO #8364]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster                         | 8 ++------
 lib/toaster/toastermain/settings.py | 1 -
 toaster-requirements.txt            | 3 +--
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 6d1ec05..528e17e 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -176,15 +176,11 @@ notify_chldexit() {
 verify_prereq() {
     # Verify prerequisites
 
-    if ! echo "import django; print (1,) == django.VERSION[0:1] and django.VERSION[1:2][0] in (6,)" | python 2>/dev/null | grep True >/dev/null; then
-        printf "This program needs Django 1.6. Please install with\n\npip install django==1.6\n"
+    if ! echo "import django; print (1,) == django.VERSION[0:1] and django.VERSION[1:2][0] in (8,)" | python 2>/dev/null | grep True >/dev/null; then
+        printf "This program needs Django 1.8. Please install with\n\npip install django<=1.8.7\n"
         return 2
     fi
 
-    if ! echo "import south; print reduce(lambda x, y: 2 if x==2 else 0 if x == 0 else y, map(lambda x: 1+cmp(x[1]-x[0],0), zip([0,8,4], map(int,south.__version__.split(\".\"))))) > 0" | python 2>/dev/null | grep True >/dev/null; then
-        printf "This program needs South 0.8.4. Please install with\n\npip install south==0.8.4\n"
-        return 2
-    fi
     return 0
 }
 
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index de686b2..7c559bc 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -276,7 +276,6 @@ INSTALLED_APPS = (
     'django.contrib.humanize',
     'bldcollector',
     'toastermain',
-    'south',
 )
 
 
diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index 1d7d21b..5d34494 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -1,5 +1,4 @@
-Django==1.6
-South==0.8.4
+Django==1.8.6
 argparse==1.2.1
 wsgiref==0.1.2
 beautifulsoup4>=4.4.0
-- 
1.9.1


