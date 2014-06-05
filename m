Return-Path: <ashcharles@gmail.com>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
	[209.85.160.50])
	by mail.openembedded.org (Postfix) with ESMTP id 2BC886FA7C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Jun 2014 19:56:20 +0000 (UTC)
Received: by mail-pb0-f50.google.com with SMTP id ma3so1557290pbc.23
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 Jun 2014 12:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=k8LVIQ+liOJ5kai6WNGe557KfN0RvK5Cd74YPv4dWZM=;
	b=XMv5Aj37S7deEvjymGUZyTOxef2UpRYtE0dZhSqzOBveaPnepzp7nBS/1fCxLbLydI
	NyH70zexGfipxt/Q6n8xib2MfUwRE6djyZsp8N5mMRUAaUGYMzIuWxYs394ljuyU6k2C
	XhsHbOeyxQD+8Ecwo2V60mgRV187gIFkHeV7rKTqQi7RKZDjzHEJHrLumpauomVlK75+
	/gZuSn3HtOjKf3iXi6JjBX3m8gexkLMSkSx6r7iR+zBQuGVgf2ssWDgcc4cOUk1btq6L
	AHT1ZvoYayIGKP9Tj9UyDE3R/cMNuegXktauu6ZFeI/WaJ1ovPnE43fCUP71OS9AoNdH
	in/A==
X-Received: by 10.68.97.129 with SMTP id ea1mr79739613pbb.73.1401998180890;
	Thu, 05 Jun 2014 12:56:20 -0700 (PDT)
Received: from gumstux.bchsia.telus.net (s206-116-3-18.bc.hsia.telus.net.
	[206.116.3.18])
	by mx.google.com with ESMTPSA id pw4sm7260037pbc.61.2014.06.05.12.56.19
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 05 Jun 2014 12:56:20 -0700 (PDT)
From: Ash Charles <ashcharles@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  5 Jun 2014 12:56:05 -0700
Message-Id: <1401998165-20959-1-git-send-email-ashcharles@gmail.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <CAK8F28=zftQQKQymrxk_Zu_3ttURMFEW+0szvXeC+XhQjHT=_w@mail.gmail.com>
References: <CAK8F28=zftQQKQymrxk_Zu_3ttURMFEW+0szvXeC+XhQjHT=_w@mail.gmail.com>
Subject: [PATCH] bitbake: show wildcard appends for bitbake-layers
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
X-List-Received-Date: Thu, 05 Jun 2014 19:56:21 -0000

The 'bitbake-layers show-appends' command can use the built-in
get_file_appends() method which correctly identifies bbappends that
include a '%' wildcard in their filename.

Signed-off-by: Ash Charles <ashcharles@gmail.com>
---
 bitbake/bin/bitbake-layers | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 302f020..9964040 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -556,7 +556,7 @@ Recipes are listed with the bbappends that apply to them as subitems.
                 continue
 
             basename = os.path.basename(filename)
-            appends = self.bbhandler.cooker.collection.appendlist.get(basename)
+            appends = self.bbhandler.cooker.collection.get_file_appends(basename)
             if appends:
                 appended.append((basename, list(appends)))
             else:
-- 
1.8.3.2


