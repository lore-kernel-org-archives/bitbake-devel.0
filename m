Return-Path: <mads.andreasen@gmail.com>
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
	[209.85.208.193])
	by mail.openembedded.org (Postfix) with ESMTP id 257BB6BCE7
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  7 Jul 2019 11:35:58 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id v18so13138968ljh.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 07 Jul 2019 04:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id;
	bh=LakdqicPkSWz8JyNT++RFNnRJGZJm/safAUzG7QPTc8=;
	b=jThdyJls48bRiGkRgfSh0V4nbbvXSFYQGQs9Y7Qp8lBPg0u7PAYxnv6kJVw+yT8hKM
	S75pDKnDNg6GBMujCoClNyYoJnLcDSMQ/BJPnGs0LTRMWff0SEF3h57gw9nhgZB6O7sn
	zjMBOwHTmJB9U8gNGOx6ewTGf0VFumLtGCU8/VF9/ECT9l8aG8y7DIKwA+lFZmV8iaPR
	zwpAnDUJiIp/Zytr4pdhXlWxlZ5fwfmvzQEdFIDw0nYkkZ3r7VBBxPFk78qPdnTWtiqz
	zZ110S4MRfyHl7l42aTpwciWrqFtf+uCd85fmvwMCAAYXcLwk1WpMCwNgqIXhR7kuMXM
	PZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
	bh=LakdqicPkSWz8JyNT++RFNnRJGZJm/safAUzG7QPTc8=;
	b=ZfW6/oBHpivjItNi9AE7apGsRQuLaWNwHuj7qKjJFspgangT2Ggs74DfsatvS2yX1T
	nE/BpA/DzqPHeLGn/JdmtGYohBPCgs3qdNhMjEufi5Z2dFl/OT5njDf2OlKQpX3vRrEA
	KfybmYJx5us0E8ll9gwmes+XcO/lq5RjDWtgmXBckCewRV0ZiDq7/x9yESOc01y2PSlr
	Nws7UWM4bYUt67Ck6b7zIK9g5CZ5ZAjyog16Y6Bs9qyBtLrhMI3DpHwv9v0l1reMX92c
	5ZYzMBOxKZfSX0+EJodqbrPwC8g5ZUng4OtkzmevOhTy6XoE3ZUreMZfze7Nl/S1gd38
	HSSA==
X-Gm-Message-State: APjAAAUpoD2ZcWyFIEh65okBMx+gprxlXhK4YQwQnjhrcohN6xD9zr/s
	VR2hCdoMv+2SfQNZQKlYGPdNM2YDGlQ=
X-Google-Smtp-Source: APXvYqwQf8IS0XmChSRzmY0gywbDu9+/e1bcEyQnXgiDVTlBAVXk0ShojGdv2v5i3p/LZIJiG6pFDw==
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr3911579lji.84.1562499359034;
	Sun, 07 Jul 2019 04:35:59 -0700 (PDT)
Received: from localhost.localdomain (2-108-165-194-cable.dk.customer.tdc.net.
	[2.108.165.194])
	by smtp.gmail.com with ESMTPSA id k27sm635997lfm.90.2019.07.07.04.35.57
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 07 Jul 2019 04:35:58 -0700 (PDT)
Sender: Mads Andreasen <mads.andreasen@gmail.com>
From: Mads Andreasen <mads@andreasen.cc>
X-Google-Original-From: Mads Andreasen <github@andreasen.cc>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  7 Jul 2019 13:35:30 +0200
Message-Id: <20190707113530.13187-1-github@andreasen.cc>
X-Mailer: git-send-email 2.17.1
Cc: Mads Andreasen <github@andreasen.cc>
Subject: [PATCH] fetch2/npm: Use npm pack to download node modules instead of wget
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
X-List-Received-Date: Sun, 07 Jul 2019 11:35:59 -0000

Using npm pack to download the main node module and its dependencies
allow for the use of private npm modules and access to them via .npmrc

Signed-off-by: Mads Andreasen <mads@andreasen.cc>
---
 lib/bb/fetch2/npm.py | 45 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 4427b1bb..6c4d397f 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -101,11 +101,19 @@ class Npm(FetchMethod):
             return False
         return True
 
-    def _runwget(self, ud, d, command, quiet):
-        logger.debug(2, "Fetching %s using command '%s'" % (ud.url, command))
-        bb.fetch2.check_network_access(d, command, ud.url)
+    def _runpack(self, ud, d, pkgfullname: str, quiet=False) -> str:
+        """
+        Runs npm pack on a full package name. 
+        Returns the filename of the downloaded package
+        """
+        bb.fetch2.check_network_access(d, pkgfullname, ud.registry)
         dldir = d.getVar("DL_DIR")
-        runfetchcmd(command, d, quiet, workdir=dldir)
+        dldir = os.path.join(dldir, ud.prefixdir)
+
+        command = f"npm pack {pkgfullname} --registry {ud.registry}"
+        logger.debug(2, "Fetching {pkgfullname} using command '{command}' in {dldir}")
+        filename = runfetchcmd(command, d, quiet, workdir=dldir)
+        return filename.rstrip()
 
     def _unpackdep(self, ud, pkg, data, destdir, dldir, d):
         file = data[pkg]['tgz']
@@ -163,6 +171,9 @@ class Npm(FetchMethod):
         pkgfullname = pkg
         if version != '*' and not '/' in version:
             pkgfullname += "@'%s'" % version
+        if pkgfullname in fetchedlist:
+            return
+
         logger.debug(2, "Calling getdeps on %s" % pkg)
         fetchcmd = "npm view %s --json --registry %s" % (pkgfullname, ud.registry)
         output = runfetchcmd(fetchcmd, d, True)
@@ -182,15 +193,10 @@ class Npm(FetchMethod):
                 if (not blacklist and 'linux' not in pkg_os) or '!linux' in pkg_os:
                     logger.debug(2, "Skipping %s since it's incompatible with Linux" % pkg)
                     return
-        #logger.debug(2, "Output URL is %s - %s - %s" % (ud.basepath, ud.basename, ud.localfile))
-        outputurl = pdata['dist']['tarball']
+        filename = self._runpack(ud, d, pkgfullname)
         data[pkg] = {}
-        data[pkg]['tgz'] = os.path.basename(outputurl)
-        if outputurl in fetchedlist:
-            return
-
-        self._runwget(ud, d, "%s --directory-prefix=%s %s" % (self.basecmd, ud.prefixdir, outputurl), False)
-        fetchedlist.append(outputurl)
+        data[pkg]['tgz'] = filename
+        fetchedlist.append(pkgfullname)
 
         dependencies = pdata.get('dependencies', {})
         optionalDependencies = pdata.get('optionalDependencies', {})
@@ -217,17 +223,12 @@ class Npm(FetchMethod):
                     if obj == pkg:
                         self._getshrinkeddependencies(obj, data['dependencies'][obj], data['dependencies'][obj]['version'], d, ud, lockdown, manifest, False)
                         return
-        outputurl = "invalid"
-        if ('resolved' not in data) or (not data['resolved'].startswith('http://') and not data['resolved'].startswith('https://')):
-            # will be the case for ${PN}
-            fetchcmd = "npm view %s@%s dist.tarball --registry %s" % (pkg, version, ud.registry)
-            logger.debug(2, "Found this matching URL: %s" % str(fetchcmd))
-            outputurl = runfetchcmd(fetchcmd, d, True)
-        else:
-            outputurl = data['resolved']
-        self._runwget(ud, d, "%s --directory-prefix=%s %s" % (self.basecmd, ud.prefixdir, outputurl), False)
+
+        pkgnameWithVersion = f"{pkg}@{version}"
+        logger.debug(2, f"Get dependencies for {pkgnameWithVersion}")
+        filename = self._runpack(ud, d, pkgnameWithVersion)
         manifest[pkg] = {}
-        manifest[pkg]['tgz'] = os.path.basename(outputurl).rstrip()
+        manifest[pkg]['tgz'] = filename
         manifest[pkg]['deps'] = {}
 
         if pkg in lockdown:
-- 
2.17.1


