Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7E0DC7741E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1QHlV5K008791 for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:48:59 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id O8NBb8jvchCH for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:48:59 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1QHmtd1008908
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:48:56 GMT
Message-ID: <1456508935.11498.97.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 26 Feb 2016 17:48:55 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] wget: Set localfile for directories
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
X-List-Received-Date: Fri, 26 Feb 2016 17:49:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If we wget something which looks directory like we end up with lock files
and done stamps without names, they also all use the same lockfile.

This change ensures that we use separate lock files based on the url
and avoid creating the mysterious ${DL_DIR}/.done files.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index fd25c42..202ed0b 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -63,6 +63,8 @@ class Wget(FetchMethod):
             ud.basename = os.path.basename(ud.path)
 
         ud.localfile = data.expand(urllib.unquote(ud.basename), d)
+        if not ud.localfile:
+            ud.localfile = data.expand(urllib.unquote(ud.host + ud.path).replace("/", "."), d)
 
         self.basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
 



