Subject: Re: gitsm fetcher fails when `PREMIRRORS_ONLY` is set
To: bitbake-devel@lists.openembedded.org
From: tiago.mlb.vasconcelos@gmail.com
X-Originating-Location: Lisbon, PT (213.205.68.220)
X-Originating-Platform: Windows Chrome 157
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 23 Nov 2026 02:35:35 -0800
References: <9Kec.1795097583791318314.gZXu@lists.openembedded.org> <c5c653afd21314dc7d58248102fd23633fec54b6.camel@linuxfoundation.org>
In-Reply-To: <c5c653afd21314dc7d58248102fd23633fec54b6.camel@linuxfoundation.org>
Message-ID: <1100827.1795430135720488922@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="tlvtmbFVm8PFhoUU4OeX"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Mon, 23 Nov 2026 10:35:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20470

--tlvtmbFVm8PFhoUU4OeX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Thank you for the feedback. Below are new bitbake-selftest cases in
lib/bb/tests/fetch.py that show the issue, together with a possible fix.

Without the gitsm.py change, `test_submodule_premirroronly` and
`test_shallow_submodule_premirroronly` will fail:

Signed-off-by: Tiago Vasconcelos <tiago.mlb.vasconcelos@gmail.com>
---

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 5869e1b99..727462ea3 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -194,6 +194,12 @@ class GitSM(Git):
# Is the following still needed?
#url +=3D ";nocheckout=3D1"

+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# BB_NO_NETWORK may have been se=
t by the parent fetch for its mirror
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# tarball. The submodule Fetch a=
pplies BB_FETCH_PREMIRRORONLY itself,
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# blocking upstream but still al=
lowing PREMIRRORS.
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if bb.utils.to_boolean(d.getVar(=
"BB_FETCH_PREMIRRORONLY")):
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d.setVar("BB_NO_NE=
TWORK", "0")
+
try:
newfetch =3D Fetch([url], d, cache=3DFalse)
newfetch.download()
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index cc133c1f5..106643d82 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2092,6 +2092,102 @@ class GitShallowTest(FetcherTest):
# Verify the submodule is also shallow
self.assertRevCount(1, cwd=3Dos.path.join(self.gitdir, 'gitsubmodule'))

+ =C2=A0 =C2=A0def use_http_premirror(self, mirrordir):
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# Serve the prepared downloads locally and all=
ow this host in mirror-only mode.
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0server =3D HTTPService(mirrordir, host=3D'127.=
0.0.1')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0server.start()
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.addCleanup(server.stop)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d.setVar('PREMIRRORS', 'gitsm://.*/.* htt=
p://127.0.0.1:%s/' % server.port)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d.setVar('BB_FETCH_PREMIRRORONLY', '1')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d.setVar('BB_NO_NETWORK', '0')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d.setVar('BB_ALLOWED_NETWORKS', '127.0.0.=
1')
+
+ =C2=A0 =C2=A0def check_submodule_premirroronly(self, shallow):
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if not shallow:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d.setVar('BB_GIT_SHALLOW', =
'0')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d.setVar('BB_GENERATE_MIRRO=
R_TARBALLS', '1')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d.setVar('BB_GENERATE_SHALL=
OW_TARBALLS', '0')
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# Create a submodule with two commits so its f=
etched history can be checked.
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.add_empty_file('a')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.add_empty_file('b')
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0smdir =3D os.path.join(self.tempdir, 'gitsubmo=
dule')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.mkdirhier(smdir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git_init(cwd=3Dsmdir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# Make this look like it was cloned from a rem=
ote...
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git('config --add remote.origin.url "%s"'=
 % smdir, cwd=3Dsmdir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git('config --add remote.origin.fetch "+r=
efs/heads/*:refs/remotes/origin/*"', cwd=3Dsmdir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.add_empty_file('asub', cwd=3Dsmdir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.add_empty_file('bsub', cwd=3Dsmdir)
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git('submodule init', cwd=3Dself.srcdir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git('-c protocol.file.allow=3Dalways subm=
odule add file://%s' % smdir, cwd=3Dself.srcdir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git('submodule update', cwd=3Dself.srcdir=
)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git('commit -m submodule -a', cwd=3Dself.=
srcdir)
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0uri =3D 'gitsm://%s;protocol=3Dfile;subdir=3D$=
{S};branch=3Dmaster' % self.srcdir
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# Fetch once to generate the mirror tarballs
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fetch(uri)
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# Stop generating tarballs during the mirror-o=
nly fetch.
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '=
0')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', =
'0')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0mirrordir =3D os.path.join(self.tempdir, 'mirr=
or')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.rename(self.dldir, mirrordir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.mkdirhier(self.dldir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# Remove the original repositories so the fetc=
h must use the premirror.
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.remove(self.gitdir, recurse=3DTrue)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.remove(self.srcdir, recurse=3DTrue)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.remove(smdir, recurse=3DTrue)
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.use_http_premirror(mirrordir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fetch_and_unpack(uri)
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# Shallow fetches retain only the tip commit; =
full fetches retain all commits.
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0expected_revisions =3D 1 if shallow else 3
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertRevCount(expected_revisions)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(os.listdir(os.path.join(self.g=
itdir, 'gitsubmodule')))
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0expected_submodule_revisions =3D 1 if shallow =
else 2
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertRevCount(expected_submodule_revisio=
ns, cwd=3Dos.path.join(self.gitdir, 'gitsubmodule'))
+
+ =C2=A0 =C2=A0def test_submodule_premirroronly(self):
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0"""Submodules must be fetched from a network P=
REMIRRORS with BB_FETCH_PREMIRRORONLY"""
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.check_submodule_premirroronly(shallow=3DF=
alse)
+
+ =C2=A0 =C2=A0def test_shallow_submodule_premirroronly(self):
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0"""Shallow submodules must be fetched from a n=
etwork PREMIRRORS with BB_FETCH_PREMIRRORONLY"""
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.check_submodule_premirroronly(shallow=3DT=
rue)
+
+ =C2=A0 =C2=A0def test_submodule_premirroronly_no_upstream(self):
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0"""A submodule missing from PREMIRRORS must no=
t be fetched from upstream"""
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.add_empty_file('a')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0sha =3D self.git('rev-parse HEAD', cwd=3Dself.=
srcdir).strip()
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# Point the submodule at an unavailable upstre=
am and add its gitlink to the parent.
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0with open(os.path.join(self.srcdir, '.gitmodul=
es'), 'w') as f:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write('[submodule "sub"]\n\tpa=
th =3D sub\n\turl =3D https://git.invalid/sub.git\n')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git('add .gitmodules', cwd=3Dself.srcdir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git('update-index --add --cacheinfo 16000=
0,%s,sub' % sha, cwd=3Dself.srcdir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git('commit -m submodule', cwd=3Dself.src=
dir)
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d.setVar('BB_GIT_SHALLOW', '0')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '=
1')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', =
'0')
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0_, ud =3D self.fetch('git://%s;protocol=3Dfile=
;branch=3Dmaster' % self.srcdir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0mirrordir =3D os.path.join(self.tempdir, 'mirr=
or')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.rename(self.dldir, mirrordir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '=
0')
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.remove(self.srcdir, recurse=3DTrue)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.mkdirhier(self.dldir)
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.use_http_premirror(mirrordir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# The missing submodule premirror must fail in=
stead of falling back to upstream.
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0with self.assertRaises(bb.fetch2.NetworkAccess=
) as cm:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fetch('gitsm://%s;protocol=
=3Dfile;subdir=3D${S};branch=3Dmaster' % self.srcdir)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertIn('git.invalid', cm.exception.url)
+
if any(os.path.exists(os.path.join(p, 'git-annex')) for p in os.environ.get=
('PATH').split(':')):
def test_shallow_annex(self):
self.add_empty_file('a')

--tlvtmbFVm8PFhoUU4OeX
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi Richard,<br /><br />Thank you for the feedback. Below are new bitba=
ke-selftest cases in<br />lib/bb/tests/fetch.py that show the issue, togeth=
er with a possible fix.<br /><br />Without the gitsm.py change, `test_submo=
dule_premirroronly` and<br />`test_shallow_submodule_premirroronly` will fa=
il:<br /><br />Signed-off-by: Tiago Vasconcelos &lt;tiago.mlb.vasconcelos@g=
mail.com&gt;<br />---</div>
<div><br />diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py<br =
/>index 5869e1b99..727462ea3 100644<br />--- a/lib/bb/fetch2/gitsm.py<br />=
+++ b/lib/bb/fetch2/gitsm.py<br />@@ -194,6 +194,12 @@ class GitSM(Git):<br=
 />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# Is the following still=
 needed?<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#url +=3D ";n=
ocheckout=3D1"<br />&nbsp;<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
# BB_NO_NETWORK may have been set by the parent fetch for its mirror<br />+=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# tarball. The submodule Fetch ap=
plies BB_FETCH_PREMIRRORONLY itself,<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;# blocking upstream but still allowing PREMIRRORS.<br />+ &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if bb.utils.to_boolean(d.getVar("BB_FETCH=
_PREMIRRORONLY")):<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;d.setVar("BB_NO_NETWORK", "0")<br />+<br />&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;try:<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp;newfetch =3D Fetch([url], d, cache=3DFalse)<br />&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;newfetch.download()<=
br />diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py<br />index =
cc133c1f5..106643d82 100644<br />--- a/lib/bb/tests/fetch.py<br />+++ b/lib=
/bb/tests/fetch.py<br />@@ -2092,6 +2092,102 @@ class GitShallowTest(Fetche=
rTest):<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# Verify the submodule is al=
so shallow<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.assertRevCount(1, cw=
d=3Dos.path.join(self.gitdir, 'gitsubmodule'))<br />&nbsp;<br />+ &nbsp; &n=
bsp;def use_http_premirror(self, mirrordir):<br />+ &nbsp; &nbsp; &nbsp; &n=
bsp;# Serve the prepared downloads locally and allow this host in mirror-on=
ly mode.<br />+ &nbsp; &nbsp; &nbsp; &nbsp;server =3D HTTPService(mirrordir=
, host=3D'127.0.0.1')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;server.start()<br /=
>+ &nbsp; &nbsp; &nbsp; &nbsp;self.addCleanup(server.stop)<br />+ &nbsp; &n=
bsp; &nbsp; &nbsp;self.d.setVar('PREMIRRORS', 'gitsm://.*/.* http://127.0.0=
.1:%s/' % server.port)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.d.setVar('BB_=
FETCH_PREMIRRORONLY', '1')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.d.setVar(=
'BB_NO_NETWORK', '0')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.d.setVar('BB_A=
LLOWED_NETWORKS', '127.0.0.1')<br />+<br />+ &nbsp; &nbsp;def check_submodu=
le_premirroronly(self, shallow):<br />+ &nbsp; &nbsp; &nbsp; &nbsp;if not s=
hallow:<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.d.setVar('BB_G=
IT_SHALLOW', '0')<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.d.se=
tVar('BB_GENERATE_MIRROR_TARBALLS', '1')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp;self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '0')<br />+<br =
/>+ &nbsp; &nbsp; &nbsp; &nbsp;# Create a submodule with two commits so its=
 fetched history can be checked.<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.add=
_empty_file('a')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.add_empty_file('b')=
<br />+<br />+ &nbsp; &nbsp; &nbsp; &nbsp;smdir =3D os.path.join(self.tempd=
ir, 'gitsubmodule')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;bb.utils.mkdirhier(sm=
dir)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.git_init(cwd=3Dsmdir)<br />+ &n=
bsp; &nbsp; &nbsp; &nbsp;# Make this look like it was cloned from a remote.=
..<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.git('config --add remote.origin.u=
rl "%s"' % smdir, cwd=3Dsmdir)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.git('=
config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cw=
d=3Dsmdir)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.add_empty_file('asub', cw=
d=3Dsmdir)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.add_empty_file('bsub', cw=
d=3Dsmdir)<br />+<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.git('submodule ini=
t', cwd=3Dself.srcdir)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.git('-c proto=
col.file.allow=3Dalways submodule add file://%s' % smdir, cwd=3Dself.srcdir=
)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.git('submodule update', cwd=3Dself=
.srcdir)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.git('commit -m submodule -a=
', cwd=3Dself.srcdir)<br />+<br />+ &nbsp; &nbsp; &nbsp; &nbsp;uri =3D 'git=
sm://%s;protocol=3Dfile;subdir=3D${S};branch=3Dmaster' % self.srcdir<br />+=
<br />+ &nbsp; &nbsp; &nbsp; &nbsp;# Fetch once to generate the mirror tarb=
alls<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.fetch(uri)<br />+<br />+ &nbsp;=
 &nbsp; &nbsp; &nbsp;# Stop generating tarballs during the mirror-only fetc=
h.<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.d.setVar('BB_GENERATE_MIRROR_TARB=
ALLS', '0')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.d.setVar('BB_GENERATE_SH=
ALLOW_TARBALLS', '0')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;mirrordir =3D os.pa=
th.join(self.tempdir, 'mirror')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;bb.utils.=
rename(self.dldir, mirrordir)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;bb.utils.mk=
dirhier(self.dldir)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;# Remove the original=
 repositories so the fetch must use the premirror.<br />+ &nbsp; &nbsp; &nb=
sp; &nbsp;bb.utils.remove(self.gitdir, recurse=3DTrue)<br />+ &nbsp; &nbsp;=
 &nbsp; &nbsp;bb.utils.remove(self.srcdir, recurse=3DTrue)<br />+ &nbsp; &n=
bsp; &nbsp; &nbsp;bb.utils.remove(smdir, recurse=3DTrue)<br />+<br />+ &nbs=
p; &nbsp; &nbsp; &nbsp;self.use_http_premirror(mirrordir)<br />+ &nbsp; &nb=
sp; &nbsp; &nbsp;self.fetch_and_unpack(uri)<br />+<br />+ &nbsp; &nbsp; &nb=
sp; &nbsp;# Shallow fetches retain only the tip commit; full fetches retain=
 all commits.<br />+ &nbsp; &nbsp; &nbsp; &nbsp;expected_revisions =3D 1 if=
 shallow else 3<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.assertRevCount(expec=
ted_revisions)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.assertTrue(os.listdir=
(os.path.join(self.gitdir, 'gitsubmodule')))<br />+ &nbsp; &nbsp; &nbsp; &n=
bsp;expected_submodule_revisions =3D 1 if shallow else 2<br />+ &nbsp; &nbs=
p; &nbsp; &nbsp;self.assertRevCount(expected_submodule_revisions, cwd=3Dos.=
path.join(self.gitdir, 'gitsubmodule'))<br />+<br />+ &nbsp; &nbsp;def test=
_submodule_premirroronly(self):<br />+ &nbsp; &nbsp; &nbsp; &nbsp;"""Submod=
ules must be fetched from a network PREMIRRORS with BB_FETCH_PREMIRRORONLY"=
""<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.check_submodule_premirroronly(sha=
llow=3DFalse)<br />+<br />+ &nbsp; &nbsp;def test_shallow_submodule_premirr=
oronly(self):<br />+ &nbsp; &nbsp; &nbsp; &nbsp;"""Shallow submodules must =
be fetched from a network PREMIRRORS with BB_FETCH_PREMIRRORONLY"""<br />+ =
&nbsp; &nbsp; &nbsp; &nbsp;self.check_submodule_premirroronly(shallow=3DTru=
e)<br />+<br />+ &nbsp; &nbsp;def test_submodule_premirroronly_no_upstream(=
self):<br />+ &nbsp; &nbsp; &nbsp; &nbsp;"""A submodule missing from PREMIR=
RORS must not be fetched from upstream"""<br />+ &nbsp; &nbsp; &nbsp; &nbsp=
;self.add_empty_file('a')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;sha =3D self.gi=
t('rev-parse HEAD', cwd=3Dself.srcdir).strip()<br />+ &nbsp; &nbsp; &nbsp; =
&nbsp;# Point the submodule at an unavailable upstream and add its gitlink =
to the parent.<br />+ &nbsp; &nbsp; &nbsp; &nbsp;with open(os.path.join(sel=
f.srcdir, '.gitmodules'), 'w') as f:<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;f.write('[submodule "sub"]\n\tpath =3D sub\n\turl =3D https://git=
.invalid/sub.git\n')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.git('add .gitmo=
dules', cwd=3Dself.srcdir)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.git('upda=
te-index --add --cacheinfo 160000,%s,sub' % sha, cwd=3Dself.srcdir)<br />+ =
&nbsp; &nbsp; &nbsp; &nbsp;self.git('commit -m submodule', cwd=3Dself.srcdi=
r)<br />+<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.d.setVar('BB_GIT_SHALLOW',=
 '0')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.d.setVar('BB_GENERATE_MIRROR_T=
ARBALLS', '1')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.d.setVar('BB_GENERATE=
_SHALLOW_TARBALLS', '0')<br />+<br />+ &nbsp; &nbsp; &nbsp; &nbsp;_, ud =3D=
 self.fetch('git://%s;protocol=3Dfile;branch=3Dmaster' % self.srcdir)<br />=
+ &nbsp; &nbsp; &nbsp; &nbsp;mirrordir =3D os.path.join(self.tempdir, 'mirr=
or')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;bb.utils.rename(self.dldir, mirrordi=
r)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.d.setVar('BB_GENERATE_MIRROR_TARB=
ALLS', '0')<br />+ &nbsp; &nbsp; &nbsp; &nbsp;bb.utils.remove(self.srcdir, =
recurse=3DTrue)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;bb.utils.mkdirhier(self.d=
ldir)<br />+<br />+ &nbsp; &nbsp; &nbsp; &nbsp;self.use_http_premirror(mirr=
ordir)<br />+ &nbsp; &nbsp; &nbsp; &nbsp;# The missing submodule premirror =
must fail instead of falling back to upstream.<br />+ &nbsp; &nbsp; &nbsp; =
&nbsp;with self.assertRaises(bb.fetch2.NetworkAccess) as cm:<br />+ &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.fetch('gitsm://%s;protocol=3Dfile;su=
bdir=3D${S};branch=3Dmaster' % self.srcdir)<br />+ &nbsp; &nbsp; &nbsp; &nb=
sp;self.assertIn('git.invalid', cm.exception.url)<br />+<br />&nbsp; &nbsp;=
 &nbsp;if any(os.path.exists(os.path.join(p, 'git-annex')) for p in os.envi=
ron.get('PATH').split(':')):<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;def tes=
t_shallow_annex(self):<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;self.add_empty_file('a')</div>

--tlvtmbFVm8PFhoUU4OeX--
