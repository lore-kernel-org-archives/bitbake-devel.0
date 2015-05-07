Return-Path: <jatedev@gmail.com>
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com
	[209.85.216.176])
	by mail.openembedded.org (Postfix) with ESMTP id C1E1873F49;
	Thu,  7 May 2015 23:50:46 +0000 (UTC)
Received: by qcvo8 with SMTP id o8so5884754qcv.0;
	Thu, 07 May 2015 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:cc:content-type;
	bh=6JGyc7tkYsUy/9GQ2CWHjxByx9oIv+wcePOSSOfltb4=;
	b=mvtdSWi0DOlxbqvLj+V1U9Op7zdfqVbm+er0BxR4XmbsRQBN1GsS0kj3SUgHkJFKmb
	z6j0RxhWwBGwPQ7YmkT+DShxwCD1puZnzwaA4H37quVoLWSmBGCBQ221r/uxAD+PRaBw
	qiZHlYD9HznJr3TYjvU/pc0lqpz499k6WhnoumnIiS6uaYRxysSl8rozSGckl9Q/QFYv
	qJuZ4lhIvaRqitEI8syP1qnEsLb9FtZpc1QdWR3/vb6Bpi8hS13vECHhYk8QSNMEZ+WV
	BR9m84Od+b25hbcQK7nb7V0u102b0JvELDxYlk7xWSPOQLlXWj31EVKgcXv8WJZL4dgH
	pplQ==
MIME-Version: 1.0
X-Received: by 10.140.108.74 with SMTP id i68mr1510236qgf.73.1431042647777;
	Thu, 07 May 2015 16:50:47 -0700 (PDT)
Received: by 10.140.102.74 with HTTP; Thu, 7 May 2015 16:50:47 -0700 (PDT)
Date: Thu, 7 May 2015 19:50:47 -0400
Message-ID: <CAPphmgZohdErGJagQO_b6EZFmeZ1tbUsOomHm+7xEKXgQpFSxA@mail.gmail.com>
From: Jate Sujjavanich <jatedev@gmail.com>
To: openembedded-core@lists.openembedded.org
Cc: bitbake-devel@lists.openembedded.org
Subject: [2/2] image.bbclass/rootfs.py: PREFERRED_PROVIDER for rdepends
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
X-List-Received-Date: Thu, 07 May 2015 23:50:47 -0000
Content-Type: multipart/alternative; boundary=001a11395d20ade6300515869455

--001a11395d20ade6300515869455
Content-Type: text/plain; charset=UTF-8

Add item (package name) to list that is searched for possible
PREFERRED_PROVIDER's.

The WARNING from bitbake suggested specifying a PREFERRED_PROVIDER for the
package name, but setting it did nothing because the filterRunTimeProviders
searched only for the recipe names.

For the example case in bug #6149, bitbake looks for
PREFERRED_PROVIDER_openssh
and PREFERRED_provider_dropbear. This change allows
PREFERRED_PROVIDER_sshd="dropbear".

Signed-off-by: Jate Sujjavanich <jatedev@gmail.com>
----
The following changes since commit efe5b0940a6abc7348d8c60c456d93f5de8dda89:

  providers.py: Add package name to PREFERRED_PROVIDER search (2015-05-07
19:07:18 -0400)

are available in the git repository at:

  git://github.com/jatedev/poky.git oe-core-image-rdepend-alt

for you to fetch changes up to 60e7c872713ec2bef97a8bd5090d72e5e713ef31:

  image.bbclass/rootfs.py: PREFERRED_PROVIDER for rdepends (2015-05-07
19:07:45 -0400)

----------------------------------------------------------------
Jate Sujjavanich (1):
      image.bbclass/rootfs.py: PREFERRED_PROVIDER for rdepends

 meta/classes/image.bbclass |   14 ++++++++++++++
 meta/lib/oe/rootfs.py      |    2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/meta/classes/image.bbclass b/meta/classes/image.bbclass
index 01f8b3f..9bcc369 100644
--- a/meta/classes/image.bbclass
+++ b/meta/classes/image.bbclass
@@ -283,6 +283,20 @@ python rootfs_process_ignore() {
 }
 do_rootfs[prefuncs] += "rootfs_process_ignore"

+python rootfs_process_preferred_providers() {
+    inst_pkgs = d.getVar("PACKAGE_INSTALL", True).split()
+    pref_pkgs = list()
+    for pkg in inst_pkgs:
+        prefervar = d.getVar("PREFERRED_PROVIDER_%s" % pkg, True)
+        if prefervar:
+            inst_pkgs.remove(pkg)
+            pref_pkgs.append(prefervar)
+            bb.note("Selecting %s to provide %s due to PREFERRED_PROVIDER"
% (prefervar, pkg))
+    inst_pkgs.extend(pref_pkgs)
+    d.setVar("PACKAGE_INSTALL", ' '.join(inst_pkgs))
+}
+do_rootfs[prefuncs] += "rootfs_process_preferred_providers"
+
 # We have to delay the runtime_mapping_rename until just before rootfs runs
 # otherwise, the multilib renaming could step in and squash any fixups that
 # may have occurred.
diff --git a/meta/lib/oe/rootfs.py b/meta/lib/oe/rootfs.py
index 6fb749f..64fa153 100644
--- a/meta/lib/oe/rootfs.py
+++ b/meta/lib/oe/rootfs.py
@@ -393,7 +393,7 @@ class RpmRootfs(Rootfs):
         pass

     def _log_check_error(self):
-        r = re.compile('(unpacking of archive failed|Cannot find
package|exit 1|ERR|Fail)')
+        r = re.compile('(unpacking of archive failed|Cannot find
package|exit 1|ERR(?!ED_PROVIDER)|Fail)')
         log_path = self.d.expand("${T}/log.do_rootfs")
         with open(log_path, 'r') as log:
             found_error = 0

--001a11395d20ade6300515869455
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Add item (package name) to list that is searched for possi=
ble<br>PREFERRED_PROVIDER&#39;s.<br><br>The WARNING from bitbake suggested =
specifying a PREFERRED_PROVIDER for the<br>package name, but setting it did=
 nothing because the filterRunTimeProviders<br>searched only for the recipe=
 names.<br><br>For the example case in bug #6149, bitbake looks for PREFERR=
ED_PROVIDER_openssh<br>and PREFERRED_provider_dropbear. This change allows<=
br>PREFERRED_PROVIDER_sshd=3D&quot;dropbear&quot;.<br><br>Signed-off-by: Ja=
te Sujjavanich &lt;<a href=3D"mailto:jatedev@gmail.com">jatedev@gmail.com</=
a>&gt;<br>----<br>The following changes since commit efe5b0940a6abc7348d8c6=
0c456d93f5de8dda89:<br><br>=C2=A0 providers.py: Add package name to PREFERR=
ED_PROVIDER search (2015-05-07 19:07:18 -0400)<br><br>are available in the =
git repository at:<br><br>=C2=A0 git://<a href=3D"http://github.com/jatedev=
/poky.git">github.com/jatedev/poky.git</a> oe-core-image-rdepend-alt<br><br=
>for you to fetch changes up to 60e7c872713ec2bef97a8bd5090d72e5e713ef31:<b=
r><br>=C2=A0 image.bbclass/rootfs.py: PREFERRED_PROVIDER for rdepends (2015=
-05-07 19:07:45 -0400)<br><br>---------------------------------------------=
-------------------<br>Jate Sujjavanich (1):<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 image.bbclass/rootfs.py: PREFERRED_PROVIDER for rdepends<br><br>=C2=A0m=
eta/classes/image.bbclass |=C2=A0=C2=A0 14 ++++++++++++++<br>=C2=A0meta/lib=
/oe/rootfs.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 2 +-<br>=C2=
=A02 files changed, 15 insertions(+), 1 deletion(-)<br><br>diff --git a/met=
a/classes/image.bbclass b/meta/classes/image.bbclass<br>index 01f8b3f..9bcc=
369 100644<br>--- a/meta/classes/image.bbclass<br>+++ b/meta/classes/image.=
bbclass<br>@@ -283,6 +283,20 @@ python rootfs_process_ignore() {<br>=C2=A0}=
<br>=C2=A0do_rootfs[prefuncs] +=3D &quot;rootfs_process_ignore&quot;<br><br=
>+python rootfs_process_preferred_providers() {<br>+=C2=A0=C2=A0=C2=A0 inst=
_pkgs =3D d.getVar(&quot;PACKAGE_INSTALL&quot;, True).split()<br>+=C2=A0=C2=
=A0=C2=A0 pref_pkgs =3D list()<br>+=C2=A0=C2=A0=C2=A0 for pkg in inst_pkgs:=
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prefervar =3D d.getVar(&quo=
t;PREFERRED_PROVIDER_%s&quot; % pkg, True)<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if prefervar:<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 inst_pkgs.remove(pkg)<br>+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pref_pkgs.append(prefervar)<b=
r>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.no=
te(&quot;Selecting %s to provide %s due to PREFERRED_PROVIDER&quot; % (pref=
ervar, pkg))<br>+=C2=A0=C2=A0=C2=A0 inst_pkgs.extend(pref_pkgs)<br>+=C2=A0=
=C2=A0=C2=A0 d.setVar(&quot;PACKAGE_INSTALL&quot;, &#39; &#39;.join(inst_pk=
gs))<br>+}<br>+do_rootfs[prefuncs] +=3D &quot;rootfs_process_preferred_prov=
iders&quot;<br>+<br>=C2=A0# We have to delay the runtime_mapping_rename unt=
il just before rootfs runs<br>=C2=A0# otherwise, the multilib renaming coul=
d step in and squash any fixups that<br>=C2=A0# may have occurred.<br>diff =
--git a/meta/lib/oe/rootfs.py b/meta/lib/oe/rootfs.py<br>index 6fb749f..64f=
a153 100644<br>--- a/meta/lib/oe/rootfs.py<br>+++ b/meta/lib/oe/rootfs.py<b=
r>@@ -393,7 +393,7 @@ class RpmRootfs(Rootfs):<br>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pass<br><br>=C2=A0=C2=A0=C2=A0=C2=A0 def _log_chec=
k_error(self):<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D re.comp=
ile(&#39;(unpacking of archive failed|Cannot find package|exit 1|ERR|Fail)&=
#39;)<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D re.compile(&#39;=
(unpacking of archive failed|Cannot find package|exit 1|ERR(?!ED_PROVIDER)|=
Fail)&#39;)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_path =
=3D self.d.expand(&quot;${T}/log.do_rootfs&quot;)<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 with open(log_path, &#39;r&#39;) as log:<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found=
_error =3D 0<br><br></div>

--001a11395d20ade6300515869455--
