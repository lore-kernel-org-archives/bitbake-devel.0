Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 332467FE13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jan 2020 17:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 700079C02E8;
	Fri, 24 Jan 2020 12:08:29 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id p6Ia5PuR4F4T; Fri, 24 Jan 2020 12:08:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DC9289C02D7;
	Fri, 24 Jan 2020 12:08:28 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id 0UtjxHcpH0uM; Fri, 24 Jan 2020 12:08:28 -0500 (EST)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id DE4609C02E8;
	Fri, 24 Jan 2020 12:08:27 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Jan 2020 18:08:10 +0100
Message-Id: <20200124170814.20510-9-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124170814.20510-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200124170814.20510-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: paul.eggleton@linux.intel.com, rennes-dev@savoirfairelinux.com
Subject: [PATCH v6 08/12] fetch2/wget: fix downloadfilename parameter
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
X-List-Received-Date: Fri, 24 Jan 2020 17:08:28 -0000
Content-Transfer-Encoding: quoted-printable

When using a download filename with characters which can be interpreted
by the shell ('(', ')', '&', ';', ...) the command fails. Quoting the
filename fixes the issue.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/wget.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 72bc6c8f..5235ae4d 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -12,6 +12,7 @@ BitBake build tools.
 #
 # Based on functions from the base bb module, Copyright 2003 Holger Schu=
rig
=20
+import shlex
 import re
 import tempfile
 import os
@@ -91,9 +92,9 @@ class Wget(FetchMethod):
         fetchcmd =3D self.basecmd
=20
         if 'downloadfilename' in ud.parm:
-            dldir =3D d.getVar("DL_DIR")
-            bb.utils.mkdirhier(os.path.dirname(dldir + os.sep + ud.local=
file))
-            fetchcmd +=3D " -O " + dldir + os.sep + ud.localfile
+            localpath =3D os.path.join(d.getVar("DL_DIR"), ud.localfile)
+            bb.utils.mkdirhier(os.path.dirname(localpath))
+            fetchcmd +=3D " -O %s" % shlex.quote(localpath)
=20
         if ud.user and ud.pswd:
             fetchcmd +=3D " --user=3D%s --password=3D%s --auth-no-challe=
nge" % (ud.user, ud.pswd)
--=20
2.20.1


