Return-Path: <jatedev@gmail.com>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
	[209.85.192.179])
	by mail.openembedded.org (Postfix) with ESMTP id 6669773FF0;
	Wed, 13 May 2015 22:47:09 +0000 (UTC)
Received: by pdbqd1 with SMTP id qd1so64986261pdb.2;
	Wed, 13 May 2015 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=GdDRLLgSYlwISYp1nVmZjnyWY1uLAcK9RHwQnvaHfCs=;
	b=e4MbqZ4W+rR6Kuz1BVOS9oUHLCC/yawjS58LnGn9/IIYa92AppI5eApDE2zPVpmECx
	xOmxhag72DAcr0i2ooZOTBv58ss5Iwy7B1CGvx1g1JM74yItvXKR/LwG57S8tDWOY5Uq
	wpHtPKlq2Q453OhO7/UwdNyjXpYXwUnnrMtVlz67+yBKPFSt/6nzu49g2jCbiP2ya4qb
	2B8dbrnWU3ke1n0YiJhO0dZjQ8mPQl8Su+QSUL4yY8sw5LZd2507lOMYlvA6uiLsllDP
	ATsTI+70PGqWq0d4O7TCq3qjVGTfjKLYbLpsTQwcyHdSWjzM1qyl5xK9mySKmO3L2zNr
	EaZQ==
MIME-Version: 1.0
X-Received: by 10.68.65.12 with SMTP id t12mr2169240pbs.118.1431557231591;
	Wed, 13 May 2015 15:47:11 -0700 (PDT)
Received: by 10.66.142.201 with HTTP; Wed, 13 May 2015 15:47:11 -0700 (PDT)
Date: Wed, 13 May 2015 18:47:11 -0400
Message-ID: <CAPphmgY46h8ajbqL66rynRf2-u28a0duxPFV3MqPjb_iB_RvaA@mail.gmail.com>
From: Jate Sujjavanich <jatedev@gmail.com>
To: openembedded-core@lists.openembedded.org, 
	bitbake-devel@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH v2][2/2] image.bbclass/rootfs.py: use PREFERRED_RPROVIDER to select package
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
X-List-Received-Date: Wed, 13 May 2015 22:47:10 -0000
Content-Type: multipart/alternative; boundary=001a113802ba43c8420515fe64f5

--001a113802ba43c8420515fe64f5
Content-Type: text/plain; charset=UTF-8

The following changes since commit 55bd8d189f647443b28f988ccfc9eebffaec84d1:

  providers.py: Add PREFERRED_RPROVIDER (2015-05-13 11:29:52 -0400)

are available in the git repository at:

  git://github.com/jatedev/poky.git preferred-provider-runtime-2

for you to fetch changes up to 832a47ff79a06a797ddd39db86c792a43cdf0865:

  image.bbclass/rootfs.py: use PREFERRED_RPROVIDER to select package
(2015-05-13 12:24:02 -0400)

----------------------------------------------------------------
Jate Sujjavanich (1):
      image.bbclass/rootfs.py: use PREFERRED_RPROVIDER to select package

 meta/classes/image.bbclass |   14 ++++++++++++++
 meta/lib/oe/rootfs.py      |    2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/meta/classes/image.bbclass b/meta/classes/image.bbclass
index 01f8b3f..80484d6 100644
--- a/meta/classes/image.bbclass
+++ b/meta/classes/image.bbclass
@@ -283,6 +283,20 @@ python rootfs_process_ignore() {
 }
 do_rootfs[prefuncs] += "rootfs_process_ignore"

+python rootfs_process_preferred_rproviders() {
+    inst_pkgs = d.getVar("PACKAGE_INSTALL", True).split()
+    pref_pkgs = list()
+    for pkg in inst_pkgs:
+        prefervar = d.getVar("PREFERRED_RPROVIDER_%s" % pkg, True)
+        if prefervar:
+            inst_pkgs.remove(pkg)
+            pref_pkgs.append(prefervar)
+            bb.note("Selecting %s to provide %s due to
PREFERRED_RPROVIDER" % (prefervar, pkg))
+    inst_pkgs.extend(pref_pkgs)
+    d.setVar("PACKAGE_INSTALL", ' '.join(inst_pkgs))
+}
+do_rootfs[prefuncs] += "rootfs_process_preferred_rproviders"
+
 # We have to delay the runtime_mapping_rename until just before rootfs runs
 # otherwise, the multilib renaming could step in and squash any fixups that
 # may have occurred.
diff --git a/meta/lib/oe/rootfs.py b/meta/lib/oe/rootfs.py
index 6fb749f..4bad7ef 100644
--- a/meta/lib/oe/rootfs.py
+++ b/meta/lib/oe/rootfs.py
@@ -393,7 +393,7 @@ class RpmRootfs(Rootfs):
         pass

     def _log_check_error(self):
-        r = re.compile('(unpacking of archive failed|Cannot find
package|exit 1|ERR|Fail)')
+        r = re.compile('(unpacking of archive failed|Cannot find
package|exit 1|ERR(?!ED_RPROVIDER)|Fail)')
         log_path = self.d.expand("${T}/log.do_rootfs")
         with open(log_path, 'r') as log:
             found_error = 0

--001a113802ba43c8420515fe64f5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The following changes since commit 55bd8d189f647443b28f988=
ccfc9eebffaec84d1:<br><br>=C2=A0 providers.py: Add PREFERRED_RPROVIDER (201=
5-05-13 11:29:52 -0400)<br><br>are available in the git repository at:<br><=
br>=C2=A0 git://<a href=3D"http://github.com/jatedev/poky.git">github.com/j=
atedev/poky.git</a> preferred-provider-runtime-2<br><br>for you to fetch ch=
anges up to 832a47ff79a06a797ddd39db86c792a43cdf0865:<br><br>=C2=A0 image.b=
bclass/rootfs.py: use PREFERRED_RPROVIDER to select package (2015-05-13 12:=
24:02 -0400)<br><br>-------------------------------------------------------=
---------<br>Jate Sujjavanich (1):<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image.=
bbclass/rootfs.py: use PREFERRED_RPROVIDER to select package<br><br>=C2=A0m=
eta/classes/image.bbclass |=C2=A0=C2=A0 14 ++++++++++++++<br>=C2=A0meta/lib=
/oe/rootfs.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 2 +-<br>=C2=
=A02 files changed, 15 insertions(+), 1 deletion(-)<br><br>diff --git a/met=
a/classes/image.bbclass b/meta/classes/image.bbclass<br>index 01f8b3f..8048=
4d6 100644<br>--- a/meta/classes/image.bbclass<br>+++ b/meta/classes/image.=
bbclass<br>@@ -283,6 +283,20 @@ python rootfs_process_ignore() {<br>=C2=A0}=
<br>=C2=A0do_rootfs[prefuncs] +=3D &quot;rootfs_process_ignore&quot;<br><br=
>+python rootfs_process_preferred_rproviders() {<br>+=C2=A0=C2=A0=C2=A0 ins=
t_pkgs =3D d.getVar(&quot;PACKAGE_INSTALL&quot;, True).split()<br>+=C2=A0=
=C2=A0=C2=A0 pref_pkgs =3D list()<br>+=C2=A0=C2=A0=C2=A0 for pkg in inst_pk=
gs:<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prefervar =3D d.getVar(&=
quot;PREFERRED_RPROVIDER_%s&quot; % pkg, True)<br>+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if prefervar:<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inst_pkgs.remove(pkg)<br>+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pref_pkgs.append(prefervar=
)<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb=
.note(&quot;Selecting %s to provide %s due to PREFERRED_RPROVIDER&quot; % (=
prefervar, pkg))<br>+=C2=A0=C2=A0=C2=A0 inst_pkgs.extend(pref_pkgs)<br>+=C2=
=A0=C2=A0=C2=A0 d.setVar(&quot;PACKAGE_INSTALL&quot;, &#39; &#39;.join(inst=
_pkgs))<br>+}<br>+do_rootfs[prefuncs] +=3D &quot;rootfs_process_preferred_r=
providers&quot;<br>+<br>=C2=A0# We have to delay the runtime_mapping_rename=
 until just before rootfs runs<br>=C2=A0# otherwise, the multilib renaming =
could step in and squash any fixups that<br>=C2=A0# may have occurred.<br>d=
iff --git a/meta/lib/oe/rootfs.py b/meta/lib/oe/rootfs.py<br>index 6fb749f.=
.4bad7ef 100644<br>--- a/meta/lib/oe/rootfs.py<br>+++ b/meta/lib/oe/rootfs.=
py<br>@@ -393,7 +393,7 @@ class RpmRootfs(Rootfs):<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass<br><br>=C2=A0=C2=A0=C2=A0=C2=A0 def _log_c=
heck_error(self):<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D re.c=
ompile(&#39;(unpacking of archive failed|Cannot find package|exit 1|ERR|Fai=
l)&#39;)<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D re.compile(&#=
39;(unpacking of archive failed|Cannot find package|exit 1|ERR(?!ED_RPROVID=
ER)|Fail)&#39;)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_pat=
h =3D self.d.expand(&quot;${T}/log.do_rootfs&quot;)<br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with open(log_path, &#39;r&#39;) as log:<br>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fo=
und_error =3D 0<br><br></div>

--001a113802ba43c8420515fe64f5--
