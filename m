Return-Path: <matt@madison.systems>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id F13D560762
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 21 Aug 2016 15:03:27 +0000 (UTC)
Received: by mail-pa0-f52.google.com with SMTP id hb8so11141066pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 21 Aug 2016 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=madison-systems.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=hZQ0baFlRJ9oArTkD7pIfL/JBpMN2qNHcciOKA9aKUY=;
	b=BOrtnYIG4E0odwb+U72OLn7/yFkLxLPEZBLytU3o1XacG6ZdOOz5EBmTS3/5RBEKY6
	fa97as2feYXDtsMM1cnTw6TVF3vJfLgxf5H2fdUB8I/Ge387qYWIgjiHpo1d68Fm5GwO
	zIG3c06/WXsa1l3lBUInGjEEzJjcWf2jumrj6RIHhOdMyv4tx1XAo1JfCrZtZwjPEvk8
	w+EhFAGvehkbfqiC+8Woj1/ShbXeBBFCbZ3ZpjguskI4sQdB0y6soWU6uFX2M843C2pT
	9PRI/3FucMN/P9oa0C7lxHP/l0lFyEj+r2RNuFV4qArDlYM/hmdv+M2+e1XDigVAem1X
	9ZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=hZQ0baFlRJ9oArTkD7pIfL/JBpMN2qNHcciOKA9aKUY=;
	b=Es4vZlY9gBaXc7U44zU2MuagUNnedjcmLczw9AXuP9d9byz3Pj2qrceCr10LzYw/pe
	EuB9qvIokVaTWRX73wvT+ZSQodagSGubMi9WDVsOVzcMGxFssvMm5+35FHBj3ElpNOmf
	Hb6RP+YLq7yITW3zeS4ZER1JojtOncRpa8hTTC1C7Xmvnf4VUtJMhBSXqFOPc/BccYfa
	rOCM1SleJaZLRu5NlCNaXKaHuTdk+a4rRq1hKrqwhY+auXgNuYelpB7186GzoGU/hZrg
	PiQtKh9zgp5WdPZp8WSFyJSxbUw1jxZzER+Gg0tP3Uvd3fxYkKr0i0poO75yuiyFy1Yq
	GBvQ==
X-Gm-Message-State: AEkoousJr2dXvB4+JGJmM6kacTLJwGtwI/IDbKqsQfQAOIsoUA/+uH99YEDtLxaR2ERZew==
X-Received: by 10.66.82.3 with SMTP id e3mr33106976pay.54.1471791807967;
	Sun, 21 Aug 2016 08:03:27 -0700 (PDT)
Received: from workhorse.madison.systems
	(70.90.175.93-BusName-ca.sfba.hfc.comcastbusiness.net.
	[70.90.175.93]) by smtp.gmail.com with ESMTPSA id
	p67sm20707316pfg.22.2016.08.21.08.03.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 21 Aug 2016 08:03:26 -0700 (PDT)
From: Matt Madison <matt@madison.systems>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 21 Aug 2016 08:02:46 -0700
Message-Id: <1471791766-27141-1-git-send-email-matt@madison.systems>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] fetch2: clean up remaining cwd saves/changes
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
X-List-Received-Date: Sun, 21 Aug 2016 15:03:28 -0000

Now that the fetchers all preserve the current working
directory, the cwd changes in the try_mirror_url,
download, and checkstatus methods are no longer needed.

Signed-off-by: Matt Madison <matt@madison.systems>
---
 lib/bb/fetch2/__init__.py | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7a3eb3c..65c426f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -935,8 +935,6 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
                 return found
             return False
 
-        os.chdir(ld.getVar("DL_DIR", True))
-
         if not verify_donestamp(ud, ld, origud) or ud.method.need_update(ud, ld):
             ud.method.download(ud, ld)
             if hasattr(ud.method,"build_mirror_data"):
@@ -1553,8 +1551,6 @@ class Fetch(object):
         network = self.d.getVar("BB_NO_NETWORK", True)
         premirroronly = (self.d.getVar("BB_FETCH_PREMIRRORONLY", True) == "1")
 
-        save_cwd = os.getcwd()
-
         for u in urls:
             ud = self.ud[u]
             ud.setup_localpath(self.d)
@@ -1577,8 +1573,6 @@ class Fetch(object):
                 if premirroronly:
                     self.d.setVar("BB_NO_NETWORK", "1")
 
-                os.chdir(self.d.getVar("DL_DIR", True))
-
                 firsterr = None
                 verified_stamp = verify_donestamp(ud, self.d)
                 if not localpath and (not verified_stamp or m.need_update(ud, self.d)):
@@ -1629,7 +1623,6 @@ class Fetch(object):
                 raise
 
             finally:
-                os.chdir(save_cwd)
                 if ud.lockfile:
                     bb.utils.unlockfile(lf)
 
@@ -1638,8 +1631,6 @@ class Fetch(object):
         Check all urls exist upstream
         """
 
-        save_cwd = os.getcwd()
-
         if not urls:
             urls = self.urls
 
@@ -1663,8 +1654,6 @@ class Fetch(object):
             if not ret:
                 raise FetchError("URL %s doesn't work" % u, u)
 
-        os.chdir(save_cwd)
-
     def unpack(self, root, urls=None):
         """
         Check all urls exist upstream
-- 
2.7.4


