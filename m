Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
	[209.85.223.179])
	by mail.openembedded.org (Postfix) with ESMTP id 8E775719F7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 16:48:16 +0000 (UTC)
Received: by mail-io0-f179.google.com with SMTP id c21so285157698ioj.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 08:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=ctjRvTe0y5OoYwceM+uCnUwulATJyrnH/DotXUzJB+4=;
	b=0Zej0bSTC6VB+7aIk1J6QEWmbfVEDM7An8IKEzHbT8bbPfsP2YUB1wasah316RgjMj
	0xu0wYurZQstntXHdt3M7t8idZzRjIXqlZhiwwBIjbFKbf4YLfL9ce4tVKtOuqfkoNqL
	h/+02+llyCeq07UB4AtagONw36jItPnnQj/oI3VpWu8SXOro6Fd2oPqEqVgSBVqQNZm1
	IWuDW9Jy84xIJkmZTpAtj92UYCkFbl1+5jApdvmG31WnV2A3LWi+XLyfxN+kPitcGbTw
	QZFA7Bh1ArA2kcG6F5o4Cfe1Du7pHszvVjbc1tveRjGKb2OixP0TJVhAAOogFDBDvrjh
	l73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=ctjRvTe0y5OoYwceM+uCnUwulATJyrnH/DotXUzJB+4=;
	b=khj/vhJ3lBH6J4ZtEj8PGU9JPbYuw4NloUERX22uWD42D3AF6cN1QHRm+tZxptjEaT
	kg7pwEmXqht9ScDXepgFkxgI/MyAZG6OSWbLf8p1Yk2c1xatfsQZ5bC38ljHTEatK3QI
	h3ejcPAFYhKyVZ/DYDqt4nyIFB51pm7SjcHYG8THxZmVvi6BI8rTNJOrgwVpKhJuiPSF
	fpR22hLZVyDi4lXtsmXdyHf6iT0OtOorP62Tk+0jfEiBm6ZkwvvFAnX7FKA8evurvKCS
	PsdYlx6ZxGerNyxGjz/DeQd1zZawCqLZ3CNijS035i8yYo8aaeolTK+Thrju+srydc3Z
	Womg==
X-Gm-Message-State: AKaTC01stcb90ZtaRtavYHKYjp+MA3eruo9lsakvnJ1cCh295D0fiIqyF46u4uF8lKx6kJDI
X-Received: by 10.107.34.139 with SMTP id i133mr24957782ioi.229.1480438095411; 
	Tue, 29 Nov 2016 08:48:15 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8EEDB.dip0.t-ipconnect.de.
	[93.232.238.219])
	by smtp.gmail.com with ESMTPSA id l79sm1119425itb.1.2016.11.29.08.48.14
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 29 Nov 2016 08:48:14 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 29 Nov 2016 17:47:44 +0100
Message-Id: <135391ec22099f7e364ac8e03792fac9998ca263.1480437099.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1480437099.git.patrick.ohly@intel.com>
References: <cover.1480437099.git.patrick.ohly@intel.com>
Subject: [PATCH V2 3/4] monitordisk.py: minor code and comment cleanup
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
X-List-Received-Date: Tue, 29 Nov 2016 16:48:16 -0000

There's no need to encode and decode the hash key as a single string,
a tuple works just fine. Iterating over entries can be written more
concisely.

Entries in the stat results are integers, not floating point values.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/monitordisk.py | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index 203c405..0f9010a 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -129,7 +129,7 @@ def getDiskData(BBDirs, configuration):
             bb.utils.mkdirhier(path)
         dev = getMountedDev(path)
         # Use path/action as the key
-        devDict[os.path.join(path, action)] = [dev, minSpace, minInode]
+        devDict[(path, action)] = [dev, minSpace, minInode]
 
     return devDict
 
@@ -205,16 +205,13 @@ class diskMonitor:
         """ Take action for the monitor """
 
         if self.enableMonitor:
-            for k in self.devDict:
-                path = os.path.dirname(k)
-                action = os.path.basename(k)
-                dev = self.devDict[k][0]
-                minSpace = self.devDict[k][1]
-                minInode = self.devDict[k][2]
+            for k, attributes in self.devDict.items():
+                path, action = k
+                dev, minSpace, minInode = attributes
 
                 st = os.statvfs(path)
 
-                # The free space, float point number
+                # The available free space, integer number
                 freeSpace = st.f_bavail * st.f_frsize
 
                 if minSpace and freeSpace < minSpace:
@@ -235,7 +232,7 @@ class diskMonitor:
                         rq.finish_runqueue(True)
                         bb.event.fire(bb.event.DiskFull(dev, 'disk', freeSpace, path), self.configuration)
 
-                # The free inodes, float point number
+                # The free inodes, integer number
                 freeInode = st.f_favail
 
                 if minInode and freeInode < minInode:
-- 
2.1.4


