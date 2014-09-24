Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DDF07715DE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Sep 2014 16:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8OGrl1W029231 for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Sep 2014 17:53:47 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id aIazoPu702ea for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Sep 2014 17:53:47 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8OGrjZA029228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Sep 2014 17:53:46 +0100
Message-ID: <1411577628.4189.58.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 24 Sep 2014 17:53:48 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] hob: Fix sstate mirrors mangling
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
X-List-Received-Date: Wed, 24 Sep 2014 16:53:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

hob was adding the redundant characters "\1" in SSTATE_MIRRORS variable. If
needed it is expected the user will add this instead so remove the code
that was doing this.

[YOCTO #6600]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
index ab5b614..b5eb3d8 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
@@ -230,10 +230,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.configuration.sstatemirror = ""
         for mirror in self.sstatemirrors_list:
             if mirror[1] != "" and mirror[2].startswith("file://"):
-                if mirror[1].endswith("\\1"):
-                    smirror = mirror[2] + " " + mirror[1] + " \\n "
-                else:
-                    smirror = mirror[2] + " " + mirror[1] + "\\1 \\n "
+                smirror = mirror[2] + " " + mirror[1] + " \\n "
                 self.configuration.sstatemirror += smirror
         self.configuration.bbthread = self.bb_spinner.get_value_as_int()
         self.configuration.pmake = self.pmake_spinner.get_value_as_int()



