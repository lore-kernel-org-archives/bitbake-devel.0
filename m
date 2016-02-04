Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C07B5606D1
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Feb 2016 23:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u14NRTL2003081
	for <bitbake-devel@lists.openembedded.org>; Thu, 4 Feb 2016 23:28:57 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id afPWgFD0sf8M for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Feb 2016 23:28:57 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u14NSrTX003126
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 4 Feb 2016 23:28:55 GMT
Message-ID: <1454628533.27087.248.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 04 Feb 2016 23:28:53 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] fetch2/osc: Remove hardcoded url
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
X-List-Received-Date: Thu, 04 Feb 2016 23:28:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This shouldn't be in here, use a variable instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/osc.py b/bitbake/lib/bb/fetch2/osc.py
index 3d87796..3dfa2a7 100644
--- a/bitbake/lib/bb/fetch2/osc.py
+++ b/bitbake/lib/bb/fetch2/osc.py
@@ -124,7 +124,7 @@ class Osc(FetchMethod):
         f.write("scheme = http\n")
         f.write("su-wrapper = su -c\n")
         f.write("build-root = %s\n" % data.expand('${WORKDIR}', d))
-        f.write("urllist = http://moblin-obs.jf.intel.com:8888/build/%(project)s/%(repository)s/%(buildarch)s/:full/%(name)s.rpm\n")
+        f.write("urllist = %s\n" % d.getVar("OSCURLLIST", True))
         f.write("extra-pkgs = gzip\n")
         f.write("\n")
         f.write("[%s]\n" % ud.host)



