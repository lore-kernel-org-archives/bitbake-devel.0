Return-Path: <shibi.cbe@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F26EECAAD8
	for <webhook@archiver.kernel.org>; Wed, 14 Sep 2022 10:04:33 +0000 (UTC)
Subject: Devtool fails if SRCREV is set to autorev #bitbake #poky #devtool
 #kirkstone 
To: bitbake-devel@lists.openembedded.org
From: shibi.cbe@gmail.com
X-Originating-Location: Mumbai, Maharashtra, IN (52.95.75.11)
X-Originating-Platform: Mac Chrome 104
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 14 Sep 2022 03:04:24 -0700
Message-ID: <Pw0r.1663149864858866100.4IUz@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="MwkkrvEMLctESzLTrar8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Sep 2022 10:04:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13976

--MwkkrvEMLctESzLTrar8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Everyone

We perform yocto build and do devtool modify for one of package it works
if we perform devtool modify for another package without resetting the prev=
iously modified package we are getting below error in modified package duri=
ng parsing bb step

recipefile:

SRC_URI=3D"git://git.com/pkg/linux;branch=3Dmulberry-5.10;protocol=3Dssh;na=
me=3Dlinux;destsuffix=3Dgit

SRCREV =3D "${AUTOREV}"

PV =3D "5.10+git${SRCPV}"

Yocto version: Kirkstone
BB_SRCREV_POLICY =3D "clear"

Error:

ERROR: /local/home/test/workspace/poky/../sources/meta-mulberry/recipes-ker=
nel/linux/linux_5.10.bb: Error executing a python function in <code>:=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| ETA:=C2=A0 --:--:--

The stack trace of python calls that resulted in this exception/failure was=
:
File: '<code>', lineno: 21, function: <module>

0017:__anon_56__local_home_test_workspace_poky_meta_classes_kernel_fitimage=
_bbclass(d)

0018:__anon_795__local_home_test_workspace_poky_meta_classes_kernel_fitimag=
e_bbclass(d)

0019:__anon_7__local_home_test_workspace_poky_meta_classes_kernel_devicetre=
e_bbclass(d)

0020:__anon_717__local_home_test_workspace_poky_meta_classes_kernel_yocto_b=
bclass(d)

*** 0021:__anon_145__local_home_test_workspace_poky_meta_classes_externalsr=
c_bbclass(d)

File: '/local/home/shibikri/mulberry_workspace/poky/meta/classes/externalsr=
c.bbclass', lineno: 66, function: __anon_145__local_home_test_workspace_pok=
y_meta_classes_externalsrc_bbclass
0062:=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:
0063:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d.setVar('B', '${WORKDIR}/${=
BPN}-${PV}/')
0064:
0065:=C2=A0 =C2=A0 =C2=A0 =C2=A0 local_srcuri =3D []
*** 0066:=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetch =3D bb.fetch2.Fetch((d.getVar('S=
RC_URI') or '').split(), d)
0067:=C2=A0 =C2=A0 =C2=A0 =C2=A0 for url in fetch.urls:
0068:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 url_data =3D fetch.ud[url]
0069:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parm =3D url_data.parm
0070:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (url_data.type =3D=3D 'fi=
le' or
File: '/local/home/test/workspace/poky/bitbake/lib/bb/fetch2/__init__.py', =
lineno: 1680, function: __init__
1676:
1677:=C2=A0 =C2=A0 =C2=A0 =C2=A0 for url in urls:
1678:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if url not in self.ud:
1679:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:
*** 1680:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 self.ud[url] =3D FetchData(url, d, localonly)
1681:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except NonLoca=
lMethod:
1682:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if localonly:
1683:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 self.ud[url] =3D None
1684:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 pass
File: '/local/home/test/workspace/poky/bitbake/lib/bb/fetch2/__init__.py', =
lineno: 1317, function: __init__
1313:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.warning('Consider upd=
ating %s recipe to use "protocol" not "proto" in SRC_URI.', d.getVar('PN'))
1314:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.parm["protocol"] =3D se=
lf.parm.get("proto", None)
1315:
1316:=C2=A0 =C2=A0 =C2=A0 =C2=A0 if hasattr(self.method, "urldata_init"):
*** 1317:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.method.urldata_init=
(self, d)
1318:
1319:=C2=A0 =C2=A0 =C2=A0 =C2=A0 if "localpath" in self.parm:
1320:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # if user sets localpath for=
 file, use it instead.\
1321:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.localpath =3D self.parm=
["localpath"]
File: '/local/home/shibikri/test/workspace/poky/bitbake/lib/bb/fetch2/git.p=
y', lineno: 249, function: urldata_init
0245:=C2=A0 =C2=A0 =C2=A0 =C2=A0 write_tarballs =3D d.getVar("BB_GENERATE_M=
IRROR_TARBALLS") or "0"
0246:=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.write_tarballs =3D write_tarballs !=3D =
"0" or ud.rebaseable
0247:=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.write_shallow_tarballs =3D (d.getVar("B=
B_GENERATE_SHALLOW_TARBALLS") or write_tarballs) !=3D "0"
0248:
*** 0249:=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.setup_revisions(d)
0250:
0251:=C2=A0 =C2=A0 =C2=A0 =C2=A0 for name in ud.names:
0252:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Ensure anything that doesn=
't look like a sha256 checksum/revision is translated into one
0253:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not ud.revisions[name] or=
 len(ud.revisions[name]) !=3D 40=C2=A0 or (False in [c in "abcdef0123456789=
" for c in ud.revisions[name]]):
File: '/local/home/test/workspace/poky/bitbake/lib/bb/fetch2/__init__.py', =
lineno: 1347, function: setup_revisions
1343:
1344:=C2=A0 =C2=A0 def setup_revisions(self, d):
1345:=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.revisions =3D {}
1346:=C2=A0 =C2=A0 =C2=A0 =C2=A0 for name in self.names:
*** 1347:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.revisions[name] =3D=
 srcrev_internal_helper(self, d, name)
1348:
1349:=C2=A0 =C2=A0 =C2=A0 =C2=A0 # add compatibility code for non name spec=
ified case
1350:=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(self.names) =3D=3D 1:
1351:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.revision =3D self.revis=
ions[self.names[0]]
File: '/local/home/test/workspace/poky/bitbake/lib/bb/fetch2/__init__.py', =
lineno: 1212, function: srcrev_internal_helper
1208:
1209:=C2=A0 =C2=A0 if srcrev =3D=3D "INVALID" or not srcrev:
1210:=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError("Please set a valid SRCRE=
V for url %s (possible key names are %s, or use a ;rev=3DX URL parameter)" =
% (str(attempts), ud.url), ud.url)
1211:=C2=A0 =C2=A0 if srcrev =3D=3D "AUTOINC":
*** 1212:=C2=A0 =C2=A0 =C2=A0 =C2=A0 srcrev =3D ud.method.latest_revision(u=
d, d, name)
1213:
1214:=C2=A0 =C2=A0 return srcrev
1215:
1216:def get_checksum_file_list(d):
File: '/local/home/test/workspace/poky/bitbake/lib/bb/fetch2/__init__.py', =
lineno: 1624, function: latest_revision
1620:=C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D self.generate_revision_key(ud, d, =
name)
1621:=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:
1622:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return revs[key]
1623:=C2=A0 =C2=A0 =C2=A0 =C2=A0 except KeyError:
*** 1624:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 revs[key] =3D rev =3D se=
lf._latest_revision(ud, d, name)
1625:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rev
1626:
1627:=C2=A0 =C2=A0 def sortable_revision(self, ud, d, name):
1628:=C2=A0 =C2=A0 =C2=A0 =C2=A0 latest_rev =3D self._build_revision(ud, d,=
 name)
File: '/local/home/test/workspace/poky/bitbake/lib/bb/fetch2/git.py', linen=
o: 734, function: _latest_revision
0730:=C2=A0 =C2=A0 =C2=A0 =C2=A0 """
0731:=C2=A0 =C2=A0 =C2=A0 =C2=A0 Compute the HEAD revision for the url
0732:=C2=A0 =C2=A0 =C2=A0 =C2=A0 """
0733:=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not d.getVar("__BBSEENSRCREV"):
*** 0734:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise bb.fetch2.FetchErr=
or("Recipe uses a floating tag/branch without a fixed SRCREV yet doesn't ca=
ll bb.fetch2.get_srcrev() (use SRCPV in PV for OE).")
0735:
0736:=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Ensure we mark as not cached
0737:=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.fetch2.get_autorev(d)
0738:
Exception: bb.fetch2.FetchError: Fetcher failure: Recipe uses a floating ta=
g/branch without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (us=
e SRCPV in PV for OE).
ERROR: Parsing halted due to errors, see error messages above

--MwkkrvEMLctESzLTrar8
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hello Everyone</div>
<div><br />We perform yocto build and do devtool modify for one of package =
it works</div>
<div>if we perform devtool modify for another package without resetting the=
 previously modified package we are getting below error in modified package=
 during parsing bb step&nbsp;</div>
<div>&nbsp;</div>
<div><span style=3D"font-weight: bold;">recipefile:</span></div>
<div>&nbsp;</div>
<div>SRC_URI=3D"git://git.com/pkg/linux;branch=3Dmulberry-5.10;protocol=3Ds=
sh;name=3Dlinux;destsuffix=3Dgit</div>
<div>&nbsp;</div>
<div>SRCREV =3D "${AUTOREV}"</div>
<div>&nbsp;</div>
<div>PV =3D "5.10+git${SRCPV}"</div>
<div>&nbsp;</div>
<div>Yocto version: Kirkstone</div>
<div>BB_SRCREV_POLICY =3D "clear"</div>
<div>&nbsp;</div>
<div><span style=3D"font-weight: bold;">Error:</span></div>
<div>&nbsp;</div>
<div>ERROR: /local/home/test/workspace/poky/../sources/meta-mulberry/recipe=
s-kernel/linux/linux_5.10.bb: Error executing a python function in &lt;code=
&gt;:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| ETA:&nbsp; --:--:--</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>The stack trace of python calls that resulted in this exception/failur=
e was:</div>
<div>File: '&lt;code&gt;', lineno: 21, function: &lt;module&gt;</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp;0017:__anon_56__local_home_test_workspace_poky_met=
a_classes_kernel_fitimage_bbclass(d)</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp;0018:__anon_795__local_home_test_workspace_poky_me=
ta_classes_kernel_fitimage_bbclass(d)</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp;0019:__anon_7__local_home_test_workspace_poky_meta=
_classes_kernel_devicetree_bbclass(d)</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp;0020:__anon_717__local_home_test_workspace_poky_me=
ta_classes_kernel_yocto_bbclass(d)</div>
<div>&nbsp;</div>
<div>&nbsp;*** 0021:__anon_145__local_home_test_workspace_poky_meta_classes=
_externalsrc_bbclass(d)</div>
<div>&nbsp;</div>
<div>File: '/local/home/shibikri/mulberry_workspace/poky/meta/classes/exter=
nalsrc.bbclass', lineno: 66, function: __anon_145__local_home_test_workspac=
e_poky_meta_classes_externalsrc_bbclass</div>
<div>&nbsp; &nbsp; &nbsp;0062:&nbsp; &nbsp; &nbsp; &nbsp; else:</div>
<div>&nbsp; &nbsp; &nbsp;0063:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; d.s=
etVar('B', '${WORKDIR}/${BPN}-${PV}/')</div>
<div>&nbsp; &nbsp; &nbsp;0064:</div>
<div>&nbsp; &nbsp; &nbsp;0065:&nbsp; &nbsp; &nbsp; &nbsp; local_srcuri =3D =
[]</div>
<div>&nbsp;*** 0066:&nbsp; &nbsp; &nbsp; &nbsp; fetch =3D bb.fetch2.Fetch((=
d.getVar('SRC_URI') or '').split(), d)</div>
<div>&nbsp; &nbsp; &nbsp;0067:&nbsp; &nbsp; &nbsp; &nbsp; for url in fetch.=
urls:</div>
<div>&nbsp; &nbsp; &nbsp;0068:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; url=
_data =3D fetch.ud[url]</div>
<div>&nbsp; &nbsp; &nbsp;0069:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; par=
m =3D url_data.parm</div>
<div>&nbsp; &nbsp; &nbsp;0070:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if =
(url_data.type =3D=3D 'file' or</div>
<div>File: '/local/home/test/workspace/poky/bitbake/lib/bb/fetch2/__init__.=
py', lineno: 1680, function: __init__</div>
<div>&nbsp; &nbsp; &nbsp;1676:</div>
<div>&nbsp; &nbsp; &nbsp;1677:&nbsp; &nbsp; &nbsp; &nbsp; for url in urls:<=
/div>
<div>&nbsp; &nbsp; &nbsp;1678:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if =
url not in self.ud:</div>
<div>&nbsp; &nbsp; &nbsp;1679:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; try:</div>
<div>&nbsp;*** 1680:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; self.ud[url] =3D FetchData(url, d, localonly)</div>
<div>&nbsp; &nbsp; &nbsp;1681:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; except NonLocalMethod:</div>
<div>&nbsp; &nbsp; &nbsp;1682:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; if localonly:</div>
<div>&nbsp; &nbsp; &nbsp;1683:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; self.ud[url] =3D None</div>
<div>&nbsp; &nbsp; &nbsp;1684:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pass</div>
<div>File: '/local/home/test/workspace/poky/bitbake/lib/bb/fetch2/__init__.=
py', lineno: 1317, function: __init__</div>
<div>&nbsp; &nbsp; &nbsp;1313:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; log=
ger.warning('Consider updating %s recipe to use "protocol" not "proto" in S=
RC_URI.', d.getVar('PN'))</div>
<div>&nbsp; &nbsp; &nbsp;1314:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sel=
f.parm["protocol"] =3D self.parm.get("proto", None)</div>
<div>&nbsp; &nbsp; &nbsp;1315:</div>
<div>&nbsp; &nbsp; &nbsp;1316:&nbsp; &nbsp; &nbsp; &nbsp; if hasattr(self.m=
ethod, "urldata_init"):</div>
<div>&nbsp;*** 1317:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; self.method.u=
rldata_init(self, d)</div>
<div>&nbsp; &nbsp; &nbsp;1318:</div>
<div>&nbsp; &nbsp; &nbsp;1319:&nbsp; &nbsp; &nbsp; &nbsp; if "localpath" in=
 self.parm:</div>
<div>&nbsp; &nbsp; &nbsp;1320:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # i=
f user sets localpath for file, use it instead.\</div>
<div>&nbsp; &nbsp; &nbsp;1321:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sel=
f.localpath =3D self.parm["localpath"]</div>
<div>File: '/local/home/shibikri/test/workspace/poky/bitbake/lib/bb/fetch2/=
git.py', lineno: 249, function: urldata_init</div>
<div>&nbsp; &nbsp; &nbsp;0245:&nbsp; &nbsp; &nbsp; &nbsp; write_tarballs =
=3D d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"</div>
<div>&nbsp; &nbsp; &nbsp;0246:&nbsp; &nbsp; &nbsp; &nbsp; ud.write_tarballs=
 =3D write_tarballs !=3D "0" or ud.rebaseable</div>
<div>&nbsp; &nbsp; &nbsp;0247:&nbsp; &nbsp; &nbsp; &nbsp; ud.write_shallow_=
tarballs =3D (d.getVar("BB_GENERATE_SHALLOW_TARBALLS") or write_tarballs) !=
=3D "0"</div>
<div>&nbsp; &nbsp; &nbsp;0248:</div>
<div>&nbsp;*** 0249:&nbsp; &nbsp; &nbsp; &nbsp; ud.setup_revisions(d)</div>
<div>&nbsp; &nbsp; &nbsp;0250:</div>
<div>&nbsp; &nbsp; &nbsp;0251:&nbsp; &nbsp; &nbsp; &nbsp; for name in ud.na=
mes:</div>
<div>&nbsp; &nbsp; &nbsp;0252:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # E=
nsure anything that doesn't look like a sha256 checksum/revision is transla=
ted into one</div>
<div>&nbsp; &nbsp; &nbsp;0253:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if =
not ud.revisions[name] or len(ud.revisions[name]) !=3D 40&nbsp; or (False i=
n [c in "abcdef0123456789" for c in ud.revisions[name]]):</div>
<div>File: '/local/home/test/workspace/poky/bitbake/lib/bb/fetch2/__init__.=
py', lineno: 1347, function: setup_revisions</div>
<div>&nbsp; &nbsp; &nbsp;1343:</div>
<div>&nbsp; &nbsp; &nbsp;1344:&nbsp; &nbsp; def setup_revisions(self, d):</=
div>
<div>&nbsp; &nbsp; &nbsp;1345:&nbsp; &nbsp; &nbsp; &nbsp; self.revisions =
=3D {}</div>
<div>&nbsp; &nbsp; &nbsp;1346:&nbsp; &nbsp; &nbsp; &nbsp; for name in self.=
names:</div>
<div>&nbsp;*** 1347:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; self.revision=
s[name] =3D srcrev_internal_helper(self, d, name)</div>
<div>&nbsp; &nbsp; &nbsp;1348:</div>
<div>&nbsp; &nbsp; &nbsp;1349:&nbsp; &nbsp; &nbsp; &nbsp; # add compatibili=
ty code for non name specified case</div>
<div>&nbsp; &nbsp; &nbsp;1350:&nbsp; &nbsp; &nbsp; &nbsp; if len(self.names=
) =3D=3D 1:</div>
<div>&nbsp; &nbsp; &nbsp;1351:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sel=
f.revision =3D self.revisions[self.names[0]]</div>
<div>File: '/local/home/test/workspace/poky/bitbake/lib/bb/fetch2/__init__.=
py', lineno: 1212, function: srcrev_internal_helper</div>
<div>&nbsp; &nbsp; &nbsp;1208:</div>
<div>&nbsp; &nbsp; &nbsp;1209:&nbsp; &nbsp; if srcrev =3D=3D "INVALID" or n=
ot srcrev:</div>
<div>&nbsp; &nbsp; &nbsp;1210:&nbsp; &nbsp; &nbsp; &nbsp; raise FetchError(=
"Please set a valid SRCREV for url %s (possible key names are %s, or use a =
;rev=3DX URL parameter)" % (str(attempts), ud.url), ud.url)</div>
<div>&nbsp; &nbsp; &nbsp;1211:&nbsp; &nbsp; if srcrev =3D=3D "AUTOINC":</di=
v>
<div>&nbsp;*** 1212:&nbsp; &nbsp; &nbsp; &nbsp; srcrev =3D ud.method.latest=
_revision(ud, d, name)</div>
<div>&nbsp; &nbsp; &nbsp;1213:</div>
<div>&nbsp; &nbsp; &nbsp;1214:&nbsp; &nbsp; return srcrev</div>
<div>&nbsp; &nbsp; &nbsp;1215:</div>
<div>&nbsp; &nbsp; &nbsp;1216:def get_checksum_file_list(d):</div>
<div>File: '/local/home/test/workspace/poky/bitbake/lib/bb/fetch2/__init__.=
py', lineno: 1624, function: latest_revision</div>
<div>&nbsp; &nbsp; &nbsp;1620:&nbsp; &nbsp; &nbsp; &nbsp; key =3D self.gene=
rate_revision_key(ud, d, name)</div>
<div>&nbsp; &nbsp; &nbsp;1621:&nbsp; &nbsp; &nbsp; &nbsp; try:</div>
<div>&nbsp; &nbsp; &nbsp;1622:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret=
urn revs[key]</div>
<div>&nbsp; &nbsp; &nbsp;1623:&nbsp; &nbsp; &nbsp; &nbsp; except KeyError:<=
/div>
<div>&nbsp;*** 1624:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; revs[key] =3D=
 rev =3D self._latest_revision(ud, d, name)</div>
<div>&nbsp; &nbsp; &nbsp;1625:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret=
urn rev</div>
<div>&nbsp; &nbsp; &nbsp;1626:</div>
<div>&nbsp; &nbsp; &nbsp;1627:&nbsp; &nbsp; def sortable_revision(self, ud,=
 d, name):</div>
<div>&nbsp; &nbsp; &nbsp;1628:&nbsp; &nbsp; &nbsp; &nbsp; latest_rev =3D se=
lf._build_revision(ud, d, name)</div>
<div>File: '/local/home/test/workspace/poky/bitbake/lib/bb/fetch2/git.py', =
lineno: 734, function: _latest_revision</div>
<div>&nbsp; &nbsp; &nbsp;0730:&nbsp; &nbsp; &nbsp; &nbsp; """</div>
<div>&nbsp; &nbsp; &nbsp;0731:&nbsp; &nbsp; &nbsp; &nbsp; Compute the HEAD =
revision for the url</div>
<div>&nbsp; &nbsp; &nbsp;0732:&nbsp; &nbsp; &nbsp; &nbsp; """</div>
<div>&nbsp; &nbsp; &nbsp;0733:&nbsp; &nbsp; &nbsp; &nbsp; if not d.getVar("=
__BBSEENSRCREV"):</div>
<div>&nbsp;*** 0734:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; raise bb.fetc=
h2.FetchError("Recipe uses a floating tag/branch without a fixed SRCREV yet=
 doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE).")</div>
<div>&nbsp; &nbsp; &nbsp;0735:</div>
<div>&nbsp; &nbsp; &nbsp;0736:&nbsp; &nbsp; &nbsp; &nbsp; # Ensure we mark =
as not cached</div>
<div>&nbsp; &nbsp; &nbsp;0737:&nbsp; &nbsp; &nbsp; &nbsp; bb.fetch2.get_aut=
orev(d)</div>
<div>&nbsp; &nbsp; &nbsp;0738:</div>
<div>Exception: bb.fetch2.FetchError: Fetcher failure: Recipe uses a floati=
ng tag/branch without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev(=
) (use SRCPV in PV for OE).</div>
<div>ERROR: Parsing halted due to errors, see error messages above</div>

--MwkkrvEMLctESzLTrar8--

