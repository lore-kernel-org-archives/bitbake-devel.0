Return-Path: <V.Vogelhuber@DigitalEndoscopy.de>
Received: from SRV-MSX01.digitendos.local
	(host-80-81-19-29.customer.m-online.net [80.81.19.29])
	by mail.openembedded.org (Postfix) with ESMTP id 10A236D406
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Oct 2013 16:31:16 +0000 (UTC)
Received: from [192.168.10.111] (192.168.10.111) by SRV-MSX01.digitendos.local
	(192.168.10.14) with Microsoft SMTP Server (TLS) id 14.2.347.0;
	Tue, 29 Oct 2013 17:31:16 +0100
Message-ID: <526FE2D3.7020808@digitalendoscopy.de>
Date: Tue, 29 Oct 2013 17:31:15 +0100
From: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
X-Originating-IP: [192.168.10.111]
X-TM-AS-Product-Ver: SMEX-10.1.0.2244-7.000.1014-20254.006
X-TM-AS-Result: No--15.588300-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
Subject: HG Fetch with username and password in url
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
X-List-Received-Date: Tue, 29 Oct 2013 16:31:16 -0000
X-Groupsio-MsgNum: 4049
Content-Type: multipart/mixed; boundary="------------050905000900070202090200"

--------------050905000900070202090200
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

We currently use an company internal mercurial server with username and 
password authentication
that will be accessed during the build of a firmware image from within a 
custom recipe.
The only way to access it from within the yocto toolchain seems to have 
the username and password
stored within the URL of the SRC_URI variable.

But the current hg.py fetcher does not completely support this. Attached 
is a patch that fixes the missing parts.

// This time in plain text, sorry for doing HTML mail

--------------050905000900070202090200
Content-Type: text/x-patch; name="hg_with_user_name_and_passwd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hg_with_user_name_and_passwd.patch"

diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index b1c8675..cf21481 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -92,7 +92,10 @@ class Hg(FetchMethod):
         if not ud.user:
             hgroot = host + ud.path
         else:
-            hgroot = ud.user + "@" + host + ud.path
+            if ud.pswd:
+                hgroot = ud.user + ":" + ud.pswd + "@" + host + ud.path
+            else:
+                hgroot = ud.user + "@" + host + ud.path
 
         if command == "info":
             return "%s identify -i %s://%s/%s" % (basecmd, proto, hgroot, ud.module)
@@ -112,7 +115,10 @@ class Hg(FetchMethod):
             # do not pass options list; limiting pull to rev causes the local
             # repo not to contain it and immediately following "update" command
             # will crash
-            cmd = "%s pull" % (basecmd)
+            if ud.user and ud.pswd:
+                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull" % (basecmd, ud.user, ud.pswd, proto)
+            else:
+                cmd = "%s pull" % (basecmd)
         elif command == "update":
             cmd = "%s update -C %s" % (basecmd, " ".join(options))
         else:


--------------050905000900070202090200--
