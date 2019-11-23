Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 87E387FCD7
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 11:51:13 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id 4so8457334wro.7
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 03:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ungEimtazaeW5JWhOMqkLgUYxZShtC0ijLzHgsVc5YI=;
	b=POG0rXofsUwHo/oDdc8GU6BOP16pAfODhSfRLJX71hbBinCoPxuAVqFIF9wVcniIws
	G2lGngjwjn0O+7eFBpwoirG/QkADLwo0xiMeAjPbX+RjnZqW57ngkOSPijk8htvInldf
	5/cZvyvE4HXahOb5R+2y3DKzYMj3YqGRHRpqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ungEimtazaeW5JWhOMqkLgUYxZShtC0ijLzHgsVc5YI=;
	b=lKddWFxKdkyKUSairVo9wAzahdmXtQXiOUX7PfYUhi5KaeojjxdWE7mJZnNOqrDO2J
	AeUb+Ngv/YGvjut/GW46dX2Heex5zRO5Vx++eWed6TmpT2jM2mNcppVVLHZT5dpmR8fM
	E+8UxnkNPFj/Hl+SpwfdnStYMgR1dfdyEkU9lbPhR+v48nw8NGzu3KEgd6o8e0Kfjw3W
	cJeKvUwkVVKXADunmuC8GQ1ilMLg1d3CiXJCKFVwYrkoGyK3WClHpLphD1ctuRsJYHyF
	TL86oeJIPwJkp7KMdioFkEMqXtyawdTfcklVIcjW3fKw2Nxbtvm70nedgjX1X0i01m4D
	3eIA==
X-Gm-Message-State: APjAAAUWDw3vG/BNUHwqQHsKR0Vli6JmA2pnojD655AEEmMVbbCSgQb8
	3jb+q6kZ2A/4CL7pHKwdTeq6EuI8zWY=
X-Google-Smtp-Source: APXvYqxAfOwuZ1hJ8uJfj2ddeAs12zXC2D6CC1bnty6qLZFEFpZF3JnNJUpbhy5XzzdiE17oM955Ng==
X-Received: by 2002:adf:8543:: with SMTP id 61mr23247985wrh.171.1574509873697; 
	Sat, 23 Nov 2019 03:51:13 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	76sm1671310wma.0.2019.11.23.03.51.12
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 23 Nov 2019 03:51:13 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Nov 2019 11:51:12 +0000
Message-Id: <20191123115112.13110-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] prserv/serv: Only restart the server if settings change
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
X-List-Received-Date: Sat, 23 Nov 2019 11:51:13 -0000
Content-Transfer-Encoding: 8bit

The server is now restarting when running commands which doesn't make
sense. Only restart if its configuration has changed. This should
potentially fix various memory resident bitbake usages too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/prserv/serv.py | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index b854ba14b7..3124b07992 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -449,29 +449,35 @@ class PRServiceConfigError(Exception):
 def auto_start(d):
     global singleton
 
-    # Shutdown any existing PR Server
-    auto_shutdown()
-
     host_params = list(filter(None, (d.getVar('PRSERV_HOST') or '').split(':')))
     if not host_params:
+        # Shutdown any existing PR Server
+        auto_shutdown()
         return None
 
     if len(host_params) != 2:
+        # Shutdown any existing PR Server
+        auto_shutdown()
         logger.critical('\n'.join(['PRSERV_HOST: incorrect format',
                 'Usage: PRSERV_HOST = "<hostname>:<port>"']))
         raise PRServiceConfigError
 
-    if is_local_special(host_params[0], int(host_params[1])) and not singleton:
+    if is_local_special(host_params[0], int(host_params[1])):
         import bb.utils
         cachedir = (d.getVar("PERSISTENT_DIR") or d.getVar("CACHE"))
         if not cachedir:
             logger.critical("Please set the 'PERSISTENT_DIR' or 'CACHE' variable")
             raise PRServiceConfigError
-        bb.utils.mkdirhier(cachedir)
         dbfile = os.path.join(cachedir, "prserv.sqlite3")
         logfile = os.path.join(cachedir, "prserv.log")
-        singleton = PRServSingleton(os.path.abspath(dbfile), os.path.abspath(logfile), ("localhost",0))
-        singleton.start()
+        if singleton:
+            if singleton.dbfile != dbfile:
+               # Shutdown any existing PR Server as doesn't match config
+               auto_shutdown()
+        if not singleton:
+            bb.utils.mkdirhier(cachedir)
+            singleton = PRServSingleton(os.path.abspath(dbfile), os.path.abspath(logfile), ("localhost",0))
+            singleton.start()
     if singleton:
         host, port = singleton.getinfo()
     else:
-- 
2.20.1


