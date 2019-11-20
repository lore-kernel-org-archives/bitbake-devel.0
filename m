Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id AA6827F815
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2019 09:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DC2A79C0418;
	Wed, 20 Nov 2019 04:34:39 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 85Ru6m2wAR-S; Wed, 20 Nov 2019 04:34:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 50FCB9C0407;
	Wed, 20 Nov 2019 04:34:39 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id UB1_bE1E2fve; Wed, 20 Nov 2019 04:34:39 -0500 (EST)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 877579C0426;
	Wed, 20 Nov 2019 04:34:38 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Nov 2019 10:34:11 +0100
Message-Id: <20191120093412.11519-7-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120093412.11519-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20191120093412.11519-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v3 6/7] fetch2/npm.py: restrict the build to be offline
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
X-List-Received-Date: Wed, 20 Nov 2019 09:34:39 -0000
Content-Transfer-Encoding: quoted-printable

After the do_fetch task, every other tasks must not access the network.
In order to ensure this point every npm command must use the '--offline'
argument. In addition, setting an invalid proxy is used as a safety.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/npm.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 9beb84bf..b365d5fc 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -329,6 +329,8 @@ def unpack_dependencies(d, shrinkwrap_file=3DNone):
=20
     def cache_dependency(tarball):
         cmd =3D "npm cache add '{}'".format(tarball)
+        cmd +=3D " --offline"
+        cmd +=3D " --proxy=3Dhttp://invalid.org"
         cmd +=3D d.expand(" --cache=3D${NPM_CACHE_DIR}")
         runfetchcmd(cmd, d)
=20
--=20
2.20.1


