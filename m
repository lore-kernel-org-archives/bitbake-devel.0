Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id DDFFB6D798
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 13:22:08 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAJDM3Z8010590 for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 13:22:04 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MX9p4DoBtD5c for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 13:22:03 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAJDM0UV010581
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 13:22:02 GMT
Message-ID: <1384867317.16887.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 19 Nov 2013 13:21:57 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Fix handling of SCM mirrors in MIRRORS
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
X-List-Received-Date: Tue, 19 Nov 2013 13:22:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If an SCM mirror is in PREMIRRORS, the tarball is downloaded and then found
by the "upstream" check and handled correctly.

If an SCM mirror is in MIRRORS, the tarball is downloaded but not used
since there is no "upstream" run after MIRRORS completes. It therefore
sits there useless and unused. This code change forces the upstream to
run after a mirror tarball is found and fixes the usage of SCM mirrors
in MIRRORS.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 451d104..b9f673c 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -805,6 +805,10 @@ def try_mirror_url(newuri, origud, ud, ld, check = False):
             dest = os.path.join(dldir, os.path.basename(ud.localpath))
             if not os.path.exists(dest):
                 os.symlink(ud.localpath, dest)
+            if not os.path.exists(origud.donestamp) or origud.method.need_update(origud.url, origud, ld):
+                origud.method.download(origud.url, origud, ld)
+                if hasattr(ud.method,"build_mirror_data"):
+                    origud.method.build_mirror_data(origud.url, origud, ld)
             return None
         # Otherwise the result is a local file:// and we symlink to it
         if not os.path.exists(origud.localpath):



