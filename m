Return-Path: <dl9pf@gmx.de>
X-Greylist: delayed 302 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 14 Feb 2020 15:06:31 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by mail.openembedded.org (Postfix) with ESMTP id 704E8610B4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Feb 2020 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1581692792;
	bh=ORhzCrj+MhIZpkCpGr3uWfXvGFmzDIY/frfTNfmJcU8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=dqsrWAatImPxDxlLUwy5LWUT45TgBErQHrCwHVxo0u8gAuEG9OMUB7/iVyw6Sc5to
	OQ83pPXS2jBx3CEUWH6NDIuEscvpmYitzjN8oMx2CfNfmYKEumVCihHaruaBY2oU9y
	OWpW+7noKLIfoh2JqgDoEHuAOZV3GQD46h9YrJCg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([95.216.96.43]) by mail.gmx.com
	(mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
	1MuDXz-1jLWvk1T9p-00ud2j; Fri, 14 Feb 2020 16:01:29 +0100
From: dl9pf@gmx.de
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Feb 2020 16:01:09 +0100
Message-Id: <20200214150109.29296-1-dl9pf@gmx.de>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:AWugaQ39wODa7Wm2K+qQyBpaX7MIwtpZoPJTIYrlRFKlnK9uEa0
	XltC/Ze9AIMdAFEJZ0L65Rina/gQ0AUHqyqbspYLMA6pQi0VoqXTk0EgcQFSQC4xY+LYDe6
	U7Y4hlVvUlMTSc2cToxlknhxWeDUtgCkvfMkE8jiOHj4oc0XP2DqjoNO/KQYM7+aWjYowRw
	YvPeI5PGpZA8ngdinMxTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lkQQ2FdoR3w=:MRM/RTRMiXZhmSZ/GG8hg/
	8ujDg4LxifFo1Vl/dCEjD+0OYk8L2zwLMLZG4/HztuwRUCc6VoGMbmqgvs8ktJvWJycO2Zwsf
	fKFV2tN0JT5HDyxz+YlKxgVbtpx85X0axUwbtWuE5tMOPVdp8CTj/JKrPRhGZmgTiraQq0mtf
	A8zN8/oD41SqtA7rMst/aoHkiwHOuzrDett7UV6RDMKGtvs2z7vE1SRgaasoQWl6qBOEMqbMU
	ClDx5Xlyfb8JxZpe5QzvOuVbo12opR4pO7cvnhdBr23JFZtxsFZfpGqUt/IVKnPqFllB8PBL2
	zpssPxHpSE/6D6fSn36kAFydAAGIvzedsI55v9fpCZii8dJTZbILNExXT/YgfOSMiQYtJwFuU
	R+Dyaa+8twT7Tji76G1PHqJtR44HKJ+MTaegE9dax5smt3Ib7R2R23KxFzsEg3tH+fNo4arhN
	eBtPWm5j9Fy+AdUMKaUO0wDH+GiwVBrbozYnVeeyx9hPaWGPgcVG3s5rPiP7B4u7M29D7/VkB
	NRbsrq80p/bD8iwLMH2SYmle287jg6z7Phq6LDwXt7lMhLeU+wMsp+9t5hSrPB+ArMITp3QJz
	Hw+/K7tUmlnGn+M7mwptFGkfCP84FA5ebkkSNAgS2pfl4pFKSiTenVI+ZE+M5seWORNjmNdWy
	5id7ypjxnh6eh8Qnao09xSyMSx8+K3Ibgcn2GRiYnAJ56Ril2e3Z//DAGzycPlNGZpfcBMBfT
	UEORJJPrREkdwEkVw+DPQptaoJ6q/2xgwaz338e9fIUq4cxsXiG7fNM53fOM9x0bUEMK3Em/S
	3X28U4HDu6I5U9U+/pexsWBZlUld+Xzb8UOIDj91vwEfYBCOz1xXDr4xThNKf82NYfo2euxGn
	A43K5ichdTWo1ohTmWWaOe7uv/NO9YyppT1FtYASLs3AT3y9qMhMPi8BtrBri7YWqDrZOT7ym
	kXrR4JE48di9Is/fErKaGESE1q93d8YxqYK+so3hOL7Wun9PNbNqrgqPEK40lbz9zzp9+it0k
	mU5h40inAeubdU8awPIqOWhFQjEqghjrJj6k2uOfcorVapQG8czgsqqyUVtpLr1VkZj+vWnZr
	O8+FbkE51KcVOT8+dWvxJd6kwLablMMDsC3SQHPt3nTNMU9PehpFdCgTOKcn7mlL2NtVRQboY
	T5kcArIpjMcQsJeoLPykWoCAEbXMkubBc/GxZg01eEMOfDCY63fN7HoUquAZ6qMy8dhDSPILp
	wZyeSmw/tV67WLHr7
Subject: [PATCH] Fix bitbake-layerindex to checkout the requested branch
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
X-List-Received-Date: Fri, 14 Feb 2020 15:06:31 -0000
Content-Transfer-Encoding: quoted-printable

From: Jan-Simon Moeller <jsmoeller@linuxfoundation.org>

Bitbake-layerindex would not respect the branch given with -b .
This fixes the clone command.

V2: Corrected 'branch' back to 'branches' and added
    a FIXME on multiple LAYERSERIES_CORENAMES.
V3: After discussion on IRC use branches[-1] as well
    educated guess for now but leave the FIXME in place.

Signed-off-by: Jan-Simon Moeller <jsmoeller@linuxfoundation.org>
=2D--
 lib/bblayers/layerindex.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 57cd9027..096ea4f8 100644
=2D-- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -24,7 +24,7 @@ class LayerIndexPlugin(ActionPlugin):
     This class inherits ActionPlugin to get do_add_layer.
     """

-    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer):
+    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer, branch)=
:
         layername =3D self.get_layer_name(url)
         if os.path.splitext(layername)[1] =3D=3D '.git':
             layername =3D os.path.splitext(layername)[0]
@@ -32,7 +32,7 @@ class LayerIndexPlugin(ActionPlugin):
         layerdir =3D os.path.join(repodir, subdir)
         if not os.path.exists(repodir):
             if fetch_layer:
-                result =3D subprocess.call(['git', 'clone', url, repodir]=
)
+                result =3D subprocess.call(['git', 'clone', '-b', branch,=
 url, repodir])
                 if result:
                     logger.error("Failed to download %s" % url)
                     return None, None, None
@@ -73,6 +73,10 @@ class LayerIndexPlugin(ActionPlugin):
             branches =3D [args.branch]
         else:
             branches =3D (self.tinfoil.config_data.getVar('LAYERSERIES_CO=
RENAMES') or 'master').split()
+
+        # FIXME: multple branches is not deterministic when cloning the r=
epository
+        # for now we pull the last entry
+        checkoutbranch =3D branches[-1]
         logger.debug(1, 'Trying branches: %s' % branches)

         ignore_layers =3D []
@@ -171,7 +175,7 @@ class LayerIndexPlugin(ActionPlugin):
                 subdir, name, layerdir =3D self.get_fetch_layer(fetchdir,
                                                       layerBranch.layer.v=
cs_url,
                                                       layerBranch.vcs_sub=
dir,
-                                                      not args.show_only)
+                                                      not args.show_only,=
 checkoutbranch)
                 if not name:
                     # Error already shown
                     return 1
=2D-
2.11.0


