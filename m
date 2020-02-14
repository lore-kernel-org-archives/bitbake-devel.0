Return-Path: <dl9pf@gmx.de>
X-Greylist: delayed 303 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 14 Feb 2020 14:27:30 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by mail.openembedded.org (Postfix) with ESMTP id 662886104E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Feb 2020 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1581690450;
	bh=eIQ/ACGaI8r2hzrqBTGqFM8erlMozSKX93JtlFSaNIE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=fbqzB14oEjudVAtg/Fmj5HEzzljEz6lxbtuSb/Ve4X1P48L2HYf/GXOAv59NkIYLt
	zjuaqjnk1V+vrmEXMWFbgoxLSAVYrZ5kKnbN8hUofAoP/Kb5Sol47Fzczs3KF/NIEW
	moyfMu7h3hEnDgRtmZai7kwnTyJROSKBaCJAmFas=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([95.216.96.43]) by mail.gmx.com
	(mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
	1N79u8-1jYPSJ0mc8-017UhN; Fri, 14 Feb 2020 15:22:27 +0100
From: dl9pf@gmx.de
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Feb 2020 15:22:00 +0100
Message-Id: <20200214142200.28757-1-dl9pf@gmx.de>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:LnLa1cAIx6ARRDo/CQf7FGWYKGCJjM+KcG5WpMYlfaZV8/kZYE8
	+HZl6m+FbhVvswLnAUAq+BOiWKlmNICgahutmWKKO+7bO+rILmU1TgcXy5cnWdOMtuMivoz
	UIu+Oz2Q86XbTcAgqEIG2Gc2rANb9MWgHaHBLeoLZ6TR/5rgW/XIvs9l70YppH/a3MmSMm5
	ZKtzWyfddQIk/Ag4bHDmw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+0sglccYYO0=:GAfyrEIM1IdEqahkeanhhv
	C09XKTUZ2DvEmOb5ni2b8uirpwgCDueyQLYkB2UQW28y+GPFvwuZCaP7bVKjnuHcA6d+f6TIR
	9DB2EXSicWc2AaINA6egYj1X3U1z+hVS+4lKljuUhouIYcadFivnSJShsrw+wQvxCXF9IoKeV
	v5qjr/pQ6+gong+dHfpDPc65vvVYFl9M6G9Jx9G7q/hxHFoSZYFpEiSQIcI/9DNugIvCpe2qf
	e/d4/SuHn8AHLw6NB5oHrsek/aF9ImRzz/3TwiX6/m48oPEZFf99UaUN6CfVNVsrqKS0HfAx0
	ExH28ps3FFx3Gft+MaVcOf54kgc8zaYe9NOP7VincNY2Ib+MNqQCRyc0bJc3NWIRV/mPnxiSD
	80VcJlzMh81txlejVpNjEFxpgAvqZLZ4CzsjbRIzLTyCMnQ7RLL6YHTjaAUOkTuTNioRYGlFx
	z4jXwhNsOUehRlyxaRWZGk6MXyopvMw6JyFjId43gl7nWCSFjz9raofpKi0WSOg/UaBnCF2bO
	I9PUgf8nQVilAAvRZOt5HEHGNeWk6eTPSQVG3GDtrLkMwrY6oav6Med9lQcN7/L1uyDlv1sbL
	zohYMqafg6W6hpgFPL70gG08/qa6HYQN+qz9N1PVNWLZmEijKcQ8mh7qQmR9hPDExHEPYfyxZ
	JO7UCtIY7R3Jq5JF68BhUTVcw5hcU/FpL3S4ayWU8tDkBAv9pOD7w92dkiOM7kgkGVn9OxrAK
	xvYfIkVZHY/eciONZUyWtN0W01cNOw12O0AhH8LRPme2umK5F/Jj/CxWCTaQI33cZH2d3CNaE
	EEl8v3nYc3sgJ6M0OMxqV+bYu5zjtb92/e8UqKMuNru4B5PCVyDzlKdct4XxCUzThZ/kCRzrq
	cNMb+JiLDxoyJ5jgJQM3/43HGZrwTyfE8dOO6ngt+rYDi4yaQcz3w9lbg/bozvOzMWTrE8g27
	L7qcKayTE92DPPFPsdEDaq/cvBAldx+x6XFp0pp8Z0DhlpdnJUyD9n84Szr9uW46H/PsOE7SX
	j95JcqcOZsyABSvwUsvw3cl6gGv67mIhgE8wfm6l1CzO0+LvjV8tflcatmx9yks76jiruc1dm
	WwnAgcwXjAe67ycUQj2orxrYa2GDJA1bLITNBWIySHhoyhIn3YnC4nGdJl6ztxsOEFTnjDYUO
	w82pmwCkih8oNzY5YsCZlZGfL1GbZgnUmO0W5UfHlHu0M21PJwGJWIBIeOeYVUcs10+TSGXLR
	FV5ZRrBObBHkRv12v
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
X-List-Received-Date: Fri, 14 Feb 2020 14:27:30 -0000
Content-Transfer-Encoding: quoted-printable

From: Jan-Simon Moeller <jsmoeller@linuxfoundation.org>

Bitbake-layerindex would not respect the branch given with -b .
This fixes the clone command.

Signed-off-by: Jan-Simon Moeller <jsmoeller@linuxfoundation.org>
=2D--
 lib/bblayers/layerindex.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 57cd9027..093434ac 100644
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
@@ -70,9 +70,9 @@ class LayerIndexPlugin(ActionPlugin):

         # Set the default...
         if args.branch:
-            branches =3D [args.branch]
+            branch =3D [args.branch]
         else:
-            branches =3D (self.tinfoil.config_data.getVar('LAYERSERIES_CO=
RENAMES') or 'master').split()
+            branch =3D (self.tinfoil.config_data.getVar('LAYERSERIES_CORE=
NAMES') or 'master').split()
         logger.debug(1, 'Trying branches: %s' % branches)

         ignore_layers =3D []
@@ -171,7 +171,7 @@ class LayerIndexPlugin(ActionPlugin):
                 subdir, name, layerdir =3D self.get_fetch_layer(fetchdir,
                                                       layerBranch.layer.v=
cs_url,
                                                       layerBranch.vcs_sub=
dir,
-                                                      not args.show_only)
+                                                      not args.show_only,=
 branch)
                 if not name:
                     # Error already shown
                     return 1
=2D-
2.11.0


