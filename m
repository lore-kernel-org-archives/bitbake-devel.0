Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 6257F6B678
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 16:45:46 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0KGjeba012975 for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 16:45:41 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8Yhd9B8rn4oZ for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 16:45:41 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0KGjOCL012967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 16:45:26 GMT
Message-ID: <1390236318.874.40.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Jan 2014 16:45:18 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH v2] bitbake: fetch2/git: Anchor names when using ls-remote
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
X-List-Received-Date: Mon, 20 Jan 2014 16:45:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When specifying tags, they're searched for unanchored so foo/bar could
match:

refs/heads/abc/foo/bar
refs/heads/xyz/foo/bar
refs/heads/foo/bar

This change anchors the expressions so they are based against heads
or tags.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index ed55f43..3620143 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -326,7 +326,7 @@ class Git(FetchMethod):
         else:
             username = ""
 
-        cmd = "%s ls-remote %s://%s%s%s %s^{}" % \
+        cmd = "%s ls-remote %s://%s%s%s refs/heads/%s^{} refs/tags/%s^{}" % \
               (ud.basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name])
         if ud.proto.lower() != 'file':
             bb.fetch2.check_network_access(d, cmd)



