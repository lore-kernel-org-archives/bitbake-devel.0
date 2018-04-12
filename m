Return-Path: <jdebski@enigma.com.pl>
X-Greylist: delayed 473 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 12 Apr 2018 09:52:54 UTC
Received: from mail.enigma.com.pl (mail.enigma.com.pl [91.198.145.120])
	by mail.openembedded.org (Postfix) with ESMTP id 35D696612D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Apr 2018 09:52:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.enigma.com.pl (Postfix) with ESMTP id 6839B17163C9A5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Apr 2018 11:45:01 +0200 (CEST)
Received: from mail.enigma.com.pl ([127.0.0.1])
	by localhost (mail.enigma.com.pl [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id FPeJuCopzVsz; Thu, 12 Apr 2018 11:45:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.enigma.com.pl (Postfix) with ESMTP id 6530717163C9A3;
	Thu, 12 Apr 2018 11:45:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail.enigma.com.pl
Received: from mail.enigma.com.pl ([127.0.0.1])
	by localhost (mail.enigma.com.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1PLEXEw8widl; Thu, 12 Apr 2018 11:45:00 +0200 (CEST)
Received: from jdebski-black.enigma.com.pl (unknown [10.14.1.110])
	by mail.enigma.com.pl (Postfix) with ESMTPSA id 46FCE17163C9A2;
	Thu, 12 Apr 2018 11:45:00 +0200 (CEST)
From: =?UTF-8?q?Jakub=20D=C4=99bski?= <jdebski@enigma.com.pl>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Apr 2018 11:44:53 +0200
Message-Id: <1523526293-14340-1-git-send-email-jdebski@enigma.com.pl>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Cc: =?UTF-8?q?Jakub=20D=C4=99bski?= <jdebski@enigma.com.pl>
Subject: [PATCH] fetch2/git.py: Added handling of the user's password in url
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
X-List-Received-Date: Thu, 12 Apr 2018 09:52:54 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Fetching source code from private repository (using https or http) fails
because password passed in url (git://user:pass@domain) is ignored.

Signed-off-by: Jakub D=C4=99bski <jdebski@enigma.com.pl>
---
 lib/bb/fetch2/git.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 3de83be..6600e19 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -527,10 +527,13 @@ class Git(FetchMethod):
         Return the repository URL
         """
         if ud.user:
-            username =3D ud.user + '@'
+            if ud.pswd:
+                userinfo =3D ud.user + ':' + ud.pswd '@'
+            else:
+                userinfo =3D ud.user + '@'
         else:
-            username =3D ""
-        return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
+            userinfo =3D ""
+        return "%s://%s%s%s" % (ud.proto, userinfo, ud.host, ud.path)
=20
     def _revision_key(self, ud, d, name):
         """
--=20
2.7.4


