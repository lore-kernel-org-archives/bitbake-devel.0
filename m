Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 9E8237FA25
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 16:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5621D9C0469;
	Fri, 17 Jan 2020 11:46:03 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id WB-Mw6tAjWsa; Fri, 17 Jan 2020 11:46:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C264D9C044D;
	Fri, 17 Jan 2020 11:46:02 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id jQDcCF39tRYn; Fri, 17 Jan 2020 11:46:02 -0500 (EST)
Received: from sulaco.example.com (40.73.12.109.rev.sfr.net [109.12.73.40])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CFA019C0462;
	Fri, 17 Jan 2020 11:46:01 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jan 2020 17:45:44 +0100
Message-Id: <20200117164548.28453-9-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes-dev@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v4 08/12] bitbake: fetch2/wget: fix downloadfilename parameter
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
X-List-Received-Date: Fri, 17 Jan 2020 16:52:10 -0000
Content-Transfer-Encoding: quoted-printable

When using a download filename with characters which can be interpreted
by the shell ('(', ')', '&', ';', ...) the command fails. Escaping the
filename fixes the issue.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/wget.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 725586d2..6506e1e2 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -94,9 +94,9 @@ class Wget(FetchMethod):
         fetchcmd =3D self.basecmd
=20
         if 'downloadfilename' in ud.parm:
-            dldir =3D d.getVar("DL_DIR")
-            bb.utils.mkdirhier(os.path.dirname(dldir + os.sep + ud.local=
file))
-            fetchcmd +=3D " -O " + dldir + os.sep + ud.localfile
+            localpath =3D os.path.join(d.getVar("DL_DIR"), ud.localfile)
+            bb.utils.mkdirhier(os.path.dirname(localpath))
+            fetchcmd +=3D " -O '%s'" % localpath
=20
         if ud.user and ud.pswd:
             fetchcmd +=3D " --user=3D%s --password=3D%s --auth-no-challe=
nge" % (ud.user, ud.pswd)
--=20
2.20.1


