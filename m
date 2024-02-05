Return-Path: <nvhieudt11@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997BFC4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 11:31:15 +0000 (UTC)
Subject: [PATCH] Support add-layer to prepend
To: bitbake-devel@lists.openembedded.org
From: nvhieudt11@gmail.com
X-Originating-Location: (203.247.149.151)
X-Originating-Platform: Windows Chrome 121
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 05 Feb 2024 03:31:13 -0800
Message-ID: <HOgI.1707132673041693756.jdfH@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="5YgT0DAhNJNV9pbf87VL"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Feb 2024 11:31:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15823

--5YgT0DAhNJNV9pbf87VL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

As you know, layer order in BBLAYERS can affect in parsing recipes process,
in some cases, users want to add a layer on the top of BBLAYERS variable

So, add "--prepend" option for bitbake-layers to support add-layer to prepe=
nd

Signed-off-by: Hieu Van Nguyen <hieu2.nguyen@lge.com>
---
lib/bb/utils.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 7 +++++--
lib/bblayers/action.py | 3 ++-
2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 068b631c..086f1cc8 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1412,7 +1412,7 @@ def edit_metadata_file(meta_file, variables, varfunc)=
:
return updated

-def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=3DNone):
+def edit_bblayers_conf(bblayers_conf, add, remove, prepend=3DNone, edit_cb=
=3DNone):
"""Edit bblayers.conf, adding and/or removing layers
Parameters:
bblayers_conf: path to bblayers.conf file to edit
@@ -1482,7 +1482,10 @@ def edit_bblayers_conf(bblayers_conf, add, remove, e=
dit_cb=3DNone):
for addlayer in addlayers:
if addlayer not in bblayers:
updated =3D True
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bbla=
yers.append(addlayer)
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if p=
repend:
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bblayers.insert(0,addlayer)
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else=
:
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bblayers.append(addlayer)
del addlayers[:]

if edit_cb:
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index a8f26993..57d7195c 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -49,7 +49,7 @@ class ActionPlugin(LayerPlugin):
shutil.copy2(bblayers_conf, backup)

try:
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 notadded, _ =3D bb.utils.edit_bb=
layers_conf(bblayers_conf, layerdirs, None)
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 notadded, _ =3D bb.utils.edit_bb=
layers_conf(bblayers_conf, layerdirs, None, args.prepend)
self.tinfoil.modified_files()
if not (args.force or notadded):
try:
@@ -267,6 +267,7 @@ build results (as the layer priority order has effectiv=
ely changed).
def register_commands(self, sp):
parser_add_layer =3D self.add_command(sp, 'add-layer', self.do_add_layer, p=
arserecipes=3DFalse)
parser_add_layer.add_argument('layerdir', nargs=3D'+', help=3D'Layer direct=
ory/directories to add')
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser_add_layer.add_argument('--prepend', act=
ion=3D'store_true', help=3D'Prepend layer directory/directories')

parser_remove_layer =3D self.add_command(sp, 'remove-layer', self.do_remove=
_layer, parserecipes=3DFalse)
parser_remove_layer.add_argument('layerdir', nargs=3D'+', help=3D'Layer dir=
ectory/directories to remove (wildcards allowed, enclose in quotes to avoid=
 shell expansion)')
--
2.43.0

--5YgT0DAhNJNV9pbf87VL
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>As you know, layer order in BBLAYERS can affect in parsing recipes pro=
cess,</div>
<div>in some cases, users want to add a layer on the top of BBLAYERS variab=
le</div>
<div>&nbsp;</div>
<div>So, add "--prepend" option for bitbake-layers to support add-layer to =
prepend</div>
<div>&nbsp;</div>
<div>Signed-off-by: Hieu Van Nguyen &lt;hieu2.nguyen@lge.com&gt;</div>
<div>---</div>
<div>&nbsp;lib/bb/utils.py&nbsp; &nbsp; &nbsp; &nbsp; | 7 +++++--</div>
<div>&nbsp;lib/bblayers/action.py | 3 ++-</div>
<div>&nbsp;2 files changed, 7 insertions(+), 3 deletions(-)</div>
<div>&nbsp;</div>
<div>diff --git a/lib/bb/utils.py b/lib/bb/utils.py</div>
<div>index 068b631c..086f1cc8 100644</div>
<div>--- a/lib/bb/utils.py</div>
<div>+++ b/lib/bb/utils.py</div>
<div>@@ -1412,7 +1412,7 @@ def edit_metadata_file(meta_file, variables, var=
func):</div>
<div>&nbsp; &nbsp; &nbsp;return updated</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>-def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=3DNone):</=
div>
<div>+def edit_bblayers_conf(bblayers_conf, add, remove, prepend=3DNone, ed=
it_cb=3DNone):</div>
<div>&nbsp; &nbsp; &nbsp;"""Edit bblayers.conf, adding and/or removing laye=
rs</div>
<div>&nbsp; &nbsp; &nbsp;Parameters:</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bblayers_conf: path to bblayers.conf=
 file to edit</div>
<div>@@ -1482,7 +1482,10 @@ def edit_bblayers_conf(bblayers_conf, add, remo=
ve, edit_cb=3DNone):</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for addlayer in addlay=
ers:</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if addla=
yer not in bblayers:</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;updated =3D True</div>
<div>-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 bblayers.append(addlayer)</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 if prepend:</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; bblayers.insert(0,addlayer)</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 else:</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; bblayers.append(addlayer)</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;del addlayers[:]</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if edit_cb:</div>
<div>diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py</div>
<div>index a8f26993..57d7195c 100644</div>
<div>--- a/lib/bblayers/action.py</div>
<div>+++ b/lib/bblayers/action.py</div>
<div>@@ -49,7 +49,7 @@ class ActionPlugin(LayerPlugin):</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;shutil.copy2(bblayers_conf, backup)<=
/div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;try:</div>
<div>-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; notadded, _ =3D bb.utils.ed=
it_bblayers_conf(bblayers_conf, layerdirs, None)</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; notadded, _ =3D bb.utils.ed=
it_bblayers_conf(bblayers_conf, layerdirs, None, args.prepend)</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.tinfoil.modified_=
files()</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if not (args.force or =
notadded):</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;try:</di=
v>
<div>@@ -267,6 +267,7 @@ build results (as the layer priority order has eff=
ectively changed).</div>
<div>&nbsp; &nbsp; &nbsp;def register_commands(self, sp):</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;parser_add_layer =3D self.add_comman=
d(sp, 'add-layer', self.do_add_layer, parserecipes=3DFalse)</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;parser_add_layer.add_argument('layer=
dir', nargs=3D'+', help=3D'Layer directory/directories to add')</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; parser_add_layer.add_argument('--prepend'=
, action=3D'store_true', help=3D'Prepend layer directory/directories')</div=
>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;parser_remove_layer =3D self.add_com=
mand(sp, 'remove-layer', self.do_remove_layer, parserecipes=3DFalse)</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;parser_remove_layer.add_argument('la=
yerdir', nargs=3D'+', help=3D'Layer directory/directories to remove (wildca=
rds allowed, enclose in quotes to avoid shell expansion)')</div>
<div>--&nbsp;</div>
<div>2.43.0</div>

--5YgT0DAhNJNV9pbf87VL--

