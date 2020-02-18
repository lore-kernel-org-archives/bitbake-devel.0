Return-Path: <dl9pf@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by mail.openembedded.org (Postfix) with ESMTP id D2BA16157F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1582034171;
	bh=LoHXktrnm2Heickzpshe3fC/cRevYKCI6VEIlov0EwU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=VDXPlqnhsc69gBZEOlNY2h1uzTinVIHqPAFSKo3qHLF82tnDoZ5mzwc3UReZWmlhG
	nQcgepXItrrVZZgi8Kjy7tHiJQkK71oIa7EAv6m2gYveXKfeoznbojXwZvPrbRuPOo
	lCyf4OzsaRG5UcUpDFFIJVNdREDlnWqXeE9gwHKI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([95.216.96.43]) by mail.gmx.com
	(mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
	1MryT9-1jr7HC03m9-00nv48; Tue, 18 Feb 2020 14:56:11 +0100
From: Jan-Simon Moeller <dl9pf@gmx.de>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Feb 2020 14:55:54 +0100
Message-Id: <20200218135554.19362-1-dl9pf@gmx.de>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:czKzJhUA/IgZjEYWuSj5Vfeave/M5aPCuXqxnAa/16+Z9N8gQ+1
	RCJ19m6dHue5qbnt9374Bo57fMbYVNnVBRCCLvIYJZBLXI4RNZYGrS+inVEyWJ8lXYbbkXJ
	XvWZMo1n1GsClgsYi5uOxOnArkWi4gGiPxJwT+8FJPqr0gfe45pn+xxO/QOgDcx2a582Ddi
	YitLDkC9dl3klmO4qQU6Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:14+rkaZCgGU=:WabeMefpF4EWY8BQRp9bhu
	kyI4ey9YsBkQZSIuYK3RZRHzO0UNhtmPFz3uE62/KKay9e7ohpRrydqhEL7GcBCnyOoHI0DOX
	L+ZFCQgo384E0BYp7TL79VDC8Ko+uKJLlCDMH9ftM3axpB6Tx2O6pD1L16Lm4OaAjpbJh8BcH
	WBNX2WsSdfTMD9VYr3IvYT2bgkGaTkQvuJuu9DdZEvOXULBgS4pwOuWK93Y8v2KNKObaoMInL
	KBatXUrAl96jN1N5/BhyPb30uV5MDR+EvsEBAgGB38StcZoHl2Am2QT21tII/OsfGtCQu0vCj
	1uupke45R1oB1zPtibcbqgYqMB0AO2t7Wov2kZkP4CsLfW6Al6tVwSTDWsRvs+9AlgPxbmD+R
	so+tIkqxMkMUbQ838cR/4hxRZSbAmfUbDzJfY3Nu2QTrMxL/16Aplq8Lt4aCZp9NHsXSo8rpg
	7ywvA3dlekgvdOH5h+GlX6rccAg0EF7bVEE0HXGrutiNQMPJJPgAoa/npOswYRU7Xo+t+T+ex
	M9TB32yZ1ZSpnya5Ym4NFCVTmf6RWyyjdfZlYUJrAr8l/rpif6iC6YT3AUaf5zzOKlmzO50+6
	NN2e91NhVAHPtDIpyQD72FXjhysM7MgRw2Xx7XyLfbFx/CfHFzZetRJHG9tsbkiIg8gYFwdVe
	/on7JiPMIoegSDlrV2Jhct0AbYl5codN8+ITVUo+KHvXIirg54pxgLKbO12ZWmkAwunPbQ0hB
	uCx54S87H2VlIxQL0FouoK2xjLScojXZC7oUq6sOkEEtVndU+VCcYTepCPaVeni9CBc+ghDEC
	qir/uWBQfkJT4zDXXPOeKyN8MGndESTLELTib5+PvqKwlYQvs5cB/i83gCciP3E2pIoQfrhM5
	G/XHhkE3CX06P89pot/vkFx8RauHclt1DW5K3PHTV2k32kVGY8sAAZ7rfBx6Q52psxh9B0jZX
	84xfC/mE17cqikQx6pPSyVJCPaS1juRk8yhZi90+AuUEUC4r6EPB9TTqO49P1uriuAGEbbpFp
	62ueec//jQCs0mj5+Cq4aNXERykMHkLaEwWjJ/WcYU7M8Sj48o32OR7Df826+mo58ZzzIkDTS
	NA4ntvIKwxN58nfGZ9r6QkSbPaQv/CSE+Nc7ULDNa9NamZ5+YY8Np3dBrIYrQ1pJyd8GjeQlP
	Ft+6GieVfgiy64GmLKeHQM2DK05/gayqN0FvqGfDmemBCranm2QED0aUA22hffryta8U4=
Subject: [PATCH] bitbake: layerindex: allow clones to be shallow
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
X-List-Received-Date: Tue, 18 Feb 2020 13:56:11 -0000
Content-Transfer-Encoding: quoted-printable

When bitbake-layers fetch-layerindex clones the repositories, these are
full clones. Allow the user to specify '-s' and do shallow clones
instead for faster downloads.

Signed-off-by: Jan-Simon Moeller <dl9pf@gmx.de>
=2D--
 lib/bblayers/layerindex.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index aa3b682d..95b67a66 100644
=2D-- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -24,7 +24,7 @@ class LayerIndexPlugin(ActionPlugin):
     This class inherits ActionPlugin to get do_add_layer.
     """

-    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer, branch)=
:
+    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer, branch,=
 shallow=3DFalse):
         layername =3D self.get_layer_name(url)
         if os.path.splitext(layername)[1] =3D=3D '.git':
             layername =3D os.path.splitext(layername)[0]
@@ -32,10 +32,12 @@ class LayerIndexPlugin(ActionPlugin):
         layerdir =3D os.path.join(repodir, subdir)
         if not os.path.exists(repodir):
             if fetch_layer:
-                cmd =3D ['git', 'clone', '-b' , branch, url, repodir]
-                if not branch:
-                    # Branch really shouldn't be empty, but use the repo =
default if it is
-                    cmd =3D ['git', 'clone', url, repodir]
+                cmd =3D ['git', 'clone']
+                if shallow:
+                    cmd.extend(['--depth', '1'])
+                if branch:
+                    cmd.extend(['-b' , branch])
+                cmd.extend([url, repodir])
                 result =3D subprocess.call(cmd)
                 if result:
                     logger.error("Failed to download %s (%s)" % (url, bra=
nch))
@@ -176,7 +178,8 @@ class LayerIndexPlugin(ActionPlugin):
                                                       layerBranch.layer.v=
cs_url,
                                                       layerBranch.vcs_sub=
dir,
                                                       not args.show_only,
-                                                      layerBranch.actual_=
branch)
+                                                      layerBranch.actual_=
branch,
+                                                      args.shallow)
                 if not name:
                     # Error already shown
                     return 1
@@ -209,6 +212,7 @@ class LayerIndexPlugin(ActionPlugin):
         parser_layerindex_fetch =3D self.add_command(sp, 'layerindex-fetc=
h', self.do_layerindex_fetch, parserecipes=3DFalse)
         parser_layerindex_fetch.add_argument('-n', '--show-only', help=3D=
'show dependencies and do nothing else', action=3D'store_true')
         parser_layerindex_fetch.add_argument('-b', '--branch', help=3D'br=
anch name to fetch')
+        parser_layerindex_fetch.add_argument('-s', '--shallow', help=3D'd=
o only shallow clones (--depth=3D1)', action=3D'store_true')
         parser_layerindex_fetch.add_argument('-i', '--ignore', help=3D'as=
sume the specified layers do not need to be fetched/added (separate multip=
le layers with commas, no spaces)', metavar=3D'LAYER')
         parser_layerindex_fetch.add_argument('layername', nargs=3D'+', he=
lp=3D'layer to fetch')

=2D-
2.11.0


