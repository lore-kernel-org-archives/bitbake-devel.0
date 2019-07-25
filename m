Return-Path: <mads.andreasen@gmail.com>
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
	[209.85.208.196])
	by mail.openembedded.org (Postfix) with ESMTP id CFDFE7EFD1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jul 2019 19:05:44 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id r9so49037536ljg.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jul 2019 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id;
	bh=hTOXQWWXrxp9ImOpzs8rU3GDizaJYirSnn5Qp9hqkcs=;
	b=J+S37ePbmFAd0qnHNdS+OVUPQz/T8Qr8q5G0Qpv/TCFNgysFKh1zh+S4+bWJVMavBS
	4o+jZBi0reauhW9xYXw4rMeaXqGCyXuBtFsopZUrPNrwVrDfhj8HfzSaDItwkz4MN2jK
	U8AQkgbIH24D8Bt2C01BQhQ9RkrIAlheNjHGhRa6u1sGG0BP7vbd7oHunRPMTTi3rf5u
	+JXR1W9vwpDh/4lyGSMLjNa6YhN0HFQc4nbFkwEYHcQcSfTLlt9HqTG9Nxilom3BXueY
	c1vMi2grnh0oxGrz7Y965v08yol/WwcPGLwINUgUHjBKRlDRv5g//DrBml7BUNXHVDC8
	SZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
	bh=hTOXQWWXrxp9ImOpzs8rU3GDizaJYirSnn5Qp9hqkcs=;
	b=XgZpsa3lw7kVaojZbWeKtEOZKTYsstEJge7KY+YR7JKeBn3iz+WBdF6vQSZFaUdK9N
	EoGEWNUfyA5oDFuDHbbEU5T9ZjUVRAPr0ZbM1NS5baUVi2aJrT4u3iExiKpi9UzFAuZ1
	JvAXyuBnKHpz3+0+4cs1xXWhTG1522PAIOwBZ9xxbRQok9J5KKl1Lfg64z0sA6gMaSAQ
	DcATWejT440yruO/Ee+TqOA4LeYb/h3r3tAerChUzfjVR82EwZ7q4v/OidRNNc/fTZ5u
	thCOOJcUyBxd1fRD8IPTB5J28yyDKjvccsh4UjSi2ETp292MGP8KSjnDR+/QOmilDsmt
	mOUw==
X-Gm-Message-State: APjAAAU7W5/Y7RiZd/Tw+tkHWJiPmiE40Il5022hRVfoWwn6YdEapISs
	qdGRrehmZi7d+hnzLi70PXAiFoEIr2I=
X-Google-Smtp-Source: APXvYqwz5a0FJZOhrF12zYmWw3Bbc7FyLe79qZIFlGZNVqdj4jytFdoSdH2PEmOfSNGW02FT54/WBg==
X-Received: by 2002:a2e:4794:: with SMTP id
	u142mr47523630lja.222.1564081544919; 
	Thu, 25 Jul 2019 12:05:44 -0700 (PDT)
Received: from localhost.localdomain (2-108-165-194-cable.dk.customer.tdc.net.
	[2.108.165.194]) by smtp.gmail.com with ESMTPSA id
	m25sm7756226lfp.97.2019.07.25.12.05.43
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 25 Jul 2019 12:05:44 -0700 (PDT)
Sender: Mads Andreasen <mads.andreasen@gmail.com>
From: Mads Andreasen <mads@andreasen.cc>
X-Google-Original-From: Mads Andreasen <github@andreasen.cc>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jul 2019 21:05:33 +0200
Message-Id: <20190725190533.17677-1-github@andreasen.cc>
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
X-List-Received-Date: Thu, 25 Jul 2019 19:05:45 -0000

Using npm pack to download the main node module and its dependencies
allow for the use of private npm modules and access to them via .npmrc

Signed-off-by: Mads Andreasen <mads@andreasen.cc>
---
 lib/bb/fetch2/npm.py | 45 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 4427b1bb..9700e610 100644
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
+        command = "npm pack {} --registry {}".format(pkgfullname, ud.registry)
+        logger.debug(2, "Fetching {} using command '{}' in {}".format(pkgfullname, command, dldir))
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
+        pkgnameWithVersion = "{}@{}".format(pkg, version)
+        logger.debug(2, "Get dependencies for {}".format(pkgnameWithVersion))
+        filename = self._runpack(ud, d, pkgnameWithVersion)
         manifest[pkg] = {}
-        manifest[pkg]['tgz'] = os.path.basename(outputurl).rstrip()
+        manifest[pkg]['tgz'] = filename
         manifest[pkg]['deps'] = {}
 
         if pkg in lockdown:
-- 
2.17.1


