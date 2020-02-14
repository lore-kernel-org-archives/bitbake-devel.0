Return-Path: <dl9pf@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by mail.openembedded.org (Postfix) with ESMTP id 1E3F7610AB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Feb 2020 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1581691683;
	bh=GeKW34OoF1Dp0MMIQk4FaQiTiFIKvfv3mca8YzSIjgw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=j6DQr+SXjh5uPZNHV8oNkcclhsuGoFyftrGmZAdJrZWA69QfYICcLMEOsQIbWGzju
	6y2z7Mfg9ortTfuBrKb33l265b0ruGpjomJa8Vrhypk4Xy6AOnSlq49zrQtGAbQzLA
	y14yY2jaVdTySuycpin/pho4zC+3CKQOLnqkHNhM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([95.216.96.43]) by mail.gmx.com
	(mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
	1N4z6q-1jRofv1Hds-010ro6; Fri, 14 Feb 2020 15:48:03 +0100
From: dl9pf@gmx.de
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Feb 2020 15:47:42 +0100
Message-Id: <20200214144742.28943-1-dl9pf@gmx.de>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:Gkqy80/ZiyCGPgP3h1vF4qydHwWpe512VdKW9+x5K+lLEq3OHB7
	NwLcqsC8HJylSREJzP4+8inu/PIhY5f9ZRJfeylmFEbyClpolh5SWEieJUWzwvUAxD2O4B7
	G319M4JP8GwBQEBQgUe5d+wSFQEcx03/aTSsEcAKJfPLK8b4jJmu3WBgIUXlLCPvsTUJVUq
	00b/XjhuzlxHot8NCDNgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+lXmFqAOiHU=:fj4gns/LZdXXX4NkS44Y/K
	IkPKc+CqwLjRXZenNDx5JFVSqlEygD+Qx8RfK0M5msDi2LmTns/hOADCMPCJaeUGh1NPWbR+O
	SvGz667LXi5YhR+kRTzVQ61eCDiESkUxbNtS3e5FYzx0STqlSxmSmCwuWGN75SoIFrnaes7zn
	QYmawOUMbNVTdvZdSNuPHIMeCfDF/CkmZW+mkvsFpJy0ebjbfUnIrkn0CmXtNtdwxQ+zi/OvT
	Duo+pDDCBeAPdqPTj0ZCtXOuUH36GAn8qJ5kGFdmWeSCXkRz8keijTiMhKxmAYDL0tEIXoC1a
	Kib78uZHtCVaw7x/dr3tfW1R+8T2MT8E5wsRDn+FemWscY+ss8A9RSjp/IAvyFI4kjRlkQn4b
	Dgz5eWYnbuW0HW2vduzP/KpjDC/f/l0sNR24/iCUQItp8lv5aVLemcf0UqjRYgccMpm25deIo
	ofNAKrOk+jJYc/CGLMttIIEOXlR7KNc55UNzVENwKg1dmhde0qPMJ+ijDRMxZzWNmNdyWM47l
	a0ueBg7EVu8un+bp4UMtGKgullfqinKIlEzmHcSLc0/506ipzcNf/rkAiNiARO6V1LndcuMtG
	x3inIFrgdfy39Sea4dFBeomSjKmn0twpZRvdIXyEeLTqT4WawgdWj8UOmYXZl8ZHDkXkiA0po
	/LPYRhVOq6TqPkGiDgMQt4klPsSbN4p255+1dQMcsrxPCSbHs/8Zp+KVK8N8mXPY4AeY14Pcg
	1wdCrv9lGnRvHim5c3lFd9tplHBdskWMA+RzpW2PCVsd7iMgPpXgS8bxHN6Em3yf4wShinNDC
	8y/phIhRjkQpjTtYG6uvJPqO8r3GWI0ytEzWvlOXUz68yGjTry9b2Yi9b3w1BLR4t1zrShSl3
	RCRN6OW+y8RIvc6e3AEcgy2squGzNbS6/u5HUEOI3WXSpRDhhOd0f/RnUDHPDOdM9hrHI6Fsg
	+bruyuDKVUemBvrSK6ZI2vcCcMjYgWLddmRHsToFsVfz3/PY8VAVIfgjk3znhEwviZcZhvVhp
	A/dn48D8SCS23Osf62oxj01D9N5GFxHtFVSQMWt8csIm10AMUHJohnKMiidEL8xw76MvjS5IO
	Dn4MTiHefz+LUV+Dtsw7m7ZlmORj51l9JlqdHXJ8IzRCy0EokuuGK+CY96ihojv3rcpAfod/V
	ki8wBQqpylsmftwTEsFQQpgU0jrI4jwI5TMckhnETXCHjot6wYOKucHoVFU9FqRd8aBZdwPfk
	VmuR1RMnzUsjPTuoT
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
X-List-Received-Date: Fri, 14 Feb 2020 14:48:03 -0000
Content-Transfer-Encoding: quoted-printable

From: Jan-Simon Moeller <jsmoeller@linuxfoundation.org>

Bitbake-layerindex would not respect the branch given with -b .
This fixes the clone command.

V2: Corrected 'branch' back to 'branches' and added
    a FIXME on multiple LAYERSERIES_CORENAMES.

Signed-off-by: Jan-Simon Moeller <jsmoeller@linuxfoundation.org>
=2D--
 lib/bblayers/layerindex.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 57cd9027..32454c8a 100644
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
@@ -71,8 +71,12 @@ class LayerIndexPlugin(ActionPlugin):
         # Set the default...
         if args.branch:
             branches =3D [args.branch]
+            checkoutbranch =3D args.branch
         else:
             branches =3D (self.tinfoil.config_data.getVar('LAYERSERIES_CO=
RENAMES') or 'master').split()
+            # FIXME: multple branches is not deterministic when cloning t=
he repository
+            # for now pull master ...
+            checkoutbranch =3D 'master'
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


