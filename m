Received: from mga07.intel.com ([143.182.124.22] helo=azsmga101.ch.intel.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ross.burton@intel.com>) id 1TDzRU-0000tj-S1
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 17:10:29 +0200
Received: from mail-wi0-f171.google.com ([209.85.212.171])
	by mga03.intel.com with ESMTP/TLS/RC4-SHA; 18 Sep 2012 07:56:20 -0700
Received: by wibhq4 with SMTP id hq4so3481338wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Sep 2012 07:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:x-gm-message-state;
	bh=72hxYX7fwrBVLKw3sI1D+CRipDl+mlM9kf4tdcWDYqc=;
	b=LtydoujnhXMBHCb8U/PWTTrndIZGqlWk6K1gwaAookxc4uP1ihygdO9qqElVbJSD91
	Wj+T9lr3ggO3XFwST/BmT5rsygpNWJJh7QbCewmjDVgXn2YInFgIxymcYYCDsHCD5VCy
	IsNNyczSjSffrZGzqRhJjMsQNz+D54y0AaFMT8+JdyYuWggtaWFS2svZ6lq5yLSlmBS/
	qFQR2RW1vY9p8SzKXIQieDF3+M1V1mu0NsMsRoMyznzl/qFhAyciDyGs1latrJWCdZ4i
	lLpXAu5UvfIzj4WfU6lYQyDN45u376n6sBHCVcX3+pLq9DiIBL6VYnhZJDsaoH+i8oMC
	g91A==
Received: by 10.180.81.193 with SMTP id c1mr286892wiy.12.1347980177366;
	Tue, 18 Sep 2012 07:56:17 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPS id v3sm23084537wiw.7.2012.09.18.07.56.14
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 18 Sep 2012 07:56:15 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Sep 2012 15:55:24 +0100
Message-Id: <1347980124-27674-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10
X-Gm-Message-State: ALoCoQls/xP2I022P9cJ/nAAdTSsb4p/IujRIlFClZQZI3CuMot+BvM6E+ROPUKJR6ZhmImSiyZ4
Subject: [PATCH] hob: Don't set busy cursor on the root window, just our window
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 18 Sep 2012 15:10:29 -0000

[ YOCTO #3127 ]

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 6df1ca4..335a5cb 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -809,9 +809,9 @@ class Builder(gtk.Window):
         self.image_details_page.set_sensitive(sensitive)
 
         if sensitive:
-            self.get_root_window().set_cursor(gtk.gdk.Cursor(gtk.gdk.LEFT_PTR))
+            self.window.set_cursor(None)
         else:
-            self.get_root_window().set_cursor(gtk.gdk.Cursor(gtk.gdk.WATCH))
+            self.window.set_cursor(gtk.gdk.Cursor(gtk.gdk.WATCH))
         self.sensitive = sensitive
 
 
-- 
1.7.10



