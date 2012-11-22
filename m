Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TbekF-0000wQ-Uv for bitbake-devel@lists.openembedded.org;
	Thu, 22 Nov 2012 22:55:40 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAMLfWFV029713
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Nov 2012 21:41:32 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 26715-10 for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Nov 2012 21:41:28 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAMLfLU5029707
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Nov 2012 21:41:23 GMT
Message-ID: <1353620481.10459.64.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 22 Nov 2012 21:41:21 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] fetch2: Avoid using FILESDIR in unpack
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
X-List-Received-Date: Thu, 22 Nov 2012 21:55:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently there is code which uses FILESDIR in unpack to ensure
parent directories are created, leading to differing behaviour depending on
which search path is used to locate the directory.

This change standardises the code and takes the data from the fetcher in
question meaning we can standardise the code and deprecate FILESDIR.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index ea52874..5708ecd 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -963,15 +963,14 @@ class FetchMethod(object):
             dest = os.path.join(rootdir, os.path.basename(file))
             if (file != dest) and not (os.path.exists(dest) and os.path.samefile(file, dest)):
                 if os.path.isdir(file):
-                    filesdir = os.path.realpath(data.getVar("FILESDIR", True))
+                    # If for example we're asked to copy file://foo/bar, we need to unpack the result into foo/bar
+                    basepath = getattr(urldata, "basepath", None)
                     destdir = "."
-                    if file[0:len(filesdir)] == filesdir:
-                        destdir = file[len(filesdir):file.rfind('/')]
+                    if basepath and basepath.find("/") != -1:
+                        destdir = basepath[:basepath.rfind('/')]
                         destdir = destdir.strip('/')
-                        if len(destdir) < 1:
-                            destdir = "."
-                        elif not os.access("%s/%s" % (rootdir, destdir), os.F_OK):
-                            os.makedirs("%s/%s" % (rootdir, destdir))
+                    if destdir != "." and not os.access("%s/%s" % (rootdir, destdir), os.F_OK):
+                        os.makedirs("%s/%s" % (rootdir, destdir))
                     cmd = 'cp -pPR %s %s/%s/' % (file, rootdir, destdir)
                     #cmd = 'tar -cf - -C "%d" -ps . | tar -xf - -C "%s/%s/"' % (file, rootdir, destdir)
                 else:
diff --git a/bitbake/lib/bb/fetch2/local.py b/bitbake/lib/bb/fetch2/local.py
index 7ea2f3b..45de15f 100644
--- a/bitbake/lib/bb/fetch2/local.py
+++ b/bitbake/lib/bb/fetch2/local.py
@@ -44,6 +44,7 @@ class Local(FetchMethod):
         # We don't set localfile as for this fetcher the file is already local!
         ud.decodedurl = urllib.unquote(ud.url.split("://")[1].split(";")[0])
         ud.basename = os.path.basename(ud.decodedurl)
+        ud.basepath = ud.decodedurl
         return
 
     def localpath(self, url, urldata, d):




