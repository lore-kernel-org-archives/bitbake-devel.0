Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id EF6E57733E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb48I007485; Wed, 1 Jun 2016 13:37:04 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id NPhxbXg4rFWN; Wed,  1 Jun 2016 13:37:04 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxxQ007467
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000pK-Iq; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:44 +0100
Message-Id: <1464784607-2985-25-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 25/28] toaster: use // operator instead of /
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:07 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Division operator works differently in Python 3. It results in
float unlike in Python 2, where it results in int.

Explicitly used "floor division" operator instead of 'division'
operator. This should make the code to result in integer under
both pythons.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/orm/models.py                          | 2 +-
 lib/toaster/toastergui/templatetags/projecttags.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index dd64664..25bc1db 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -424,7 +424,7 @@ class Build(models.Model):
         tf = Task.objects.filter(build = self)
         tfc = tf.count()
         if tfc > 0:
-            completeper = tf.exclude(order__isnull=True).count()*100/tfc
+            completeper = tf.exclude(order__isnull=True).count()*100 // tfc
         else:
             completeper = 0
         return completeper
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 75f2261..1d68036 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -90,7 +90,7 @@ def whitespace_space_filter(value, arg):
 def divide(value, arg):
     if int(arg) == 0:
         return -1
-    return int(value) / int(arg)
+    return int(value) // int(arg)
 
 @register.filter
 def multiply(value, arg):
-- 
2.5.0


