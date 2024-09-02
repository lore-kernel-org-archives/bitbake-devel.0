Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7127ECA0ED3
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 10:42:18 +0000 (UTC)
Subject: Re: [bitbake][kirkstone][2.0] Appends discarded by expandVarref
To: bitbake-devel@lists.openembedded.org
From: "Adam Blank" <adam.blank.g@gmail.com>
X-Originating-Location: (131.228.32.166)
X-Originating-Platform: Windows Chrome 127
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 02 Sep 2024 03:42:16 -0700
References: <083be01b5a70c46bedcdfca1c403c87b18299bf1.camel@linuxfoundation.org>
In-Reply-To: <083be01b5a70c46bedcdfca1c403c87b18299bf1.camel@linuxfoundation.org>
Message-ID: <17365.1725273736587575150@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="u1U5bX6t0JymBrb25Lah"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Sep 2024 10:42:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16534

--u1U5bX6t0JymBrb25Lah
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>=20
> To fix it we really need to avoid expanding any variables at all and
> just do a search/replace on the variable contents.
>=20

I'd like to propose something like that:

--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -1007,9 +1007,34 @@ class DataSmart(MutableMapping):
ref =3D '${%s}' % variable
value =3D self.getVar(variable, False)
for key in keys:
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0referrervalue =3D self.getVar(ke=
y, False)
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if referrervalue and isinstance(=
referrervalue, str) and ref in referrervalue:
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.setVar(key, r=
eferrervalue.replace(ref, value))
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cow =3D False
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not key in self.dict:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local_var, _ =3D s=
elf._findVar(key)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cow =3D True
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local_var =3D self=
.dict[key]
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for sKey in ["_content", "_defau=
ltval", ":append", ":prepend", ":remove"]:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D local_var[=
sKey] if sKey in local_var else None
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if isinstance(val,=
 str) and ref in val:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val2=
 =3D val.replace(ref, value)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if c=
ow:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0self._makeShadowCopy(key)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cow =3D False
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self=
.dict[key][sKey] =3D val2
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif isinstance(va=
l, list):
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val2=
 =3D None
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for =
i, (r, o) in enumerate(val):
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if ref in r:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if not val2:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val2 =3D list(val)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0val2[i] =3D [r.replace(ref, value), o]
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if v=
al2:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if cow:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0self._makeShadowCopy(key)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0cow =3D False
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0self.dict[key][sKey] =3D val2

Efficiency wise it does not do more that the original code, and it gets str=
aight to the point.

Thanks,
Adam

--u1U5bX6t0JymBrb25Lah
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<blockquote>
<div><span style=3D"color: #333333; font-family: system-ui, 'Segoe UI', Rob=
oto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, '=
Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'=
; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font=
-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2=
; text-align: start; text-indent: 0px; text-transform: none; widows: 2; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; back=
ground-color: #ffffff; text-decoration-thickness: initial; text-decoration-=
style: initial; text-decoration-color: initial; display: inline !important;=
 float: none;">To fix it we really need to avoid expanding any variables at=
 all and</span><br style=3D"box-sizing: border-box; overflow-wrap: break-wo=
rd !important; color: #333333; font-family: system-ui, 'Segoe UI', Roboto, =
'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple=
 Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; fon=
t-size: 16px; font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; backgroun=
d-color: #ffffff; text-decoration-thickness: initial; text-decoration-style=
: initial; text-decoration-color: initial;" /><span style=3D"color: #333333=
; font-family: system-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans'=
, 'Liberation Sans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoj=
i', 'Segoe UI Symbol', 'Noto Color Emoji'; font-size: 16px; font-style: nor=
mal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight=
: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: =
0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-strok=
e-width: 0px; white-space: pre-wrap; background-color: #ffffff; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; display: inline !important; float: none;">just do a search/re=
place on the variable contents.</span></div>
</blockquote>
<div><span style=3D"color: #333333; font-family: system-ui, 'Segoe UI', Rob=
oto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, '=
Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'=
; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font=
-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2=
; text-align: start; text-indent: 0px; text-transform: none; widows: 2; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; back=
ground-color: #ffffff; text-decoration-thickness: initial; text-decoration-=
style: initial; text-decoration-color: initial; display: inline !important;=
 float: none;">I'd like to propose something like that:</span></div>
<div>&nbsp;</div>
<div><span style=3D"color: #333333; font-family: system-ui, 'Segoe UI', Rob=
oto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, '=
Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'=
; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font=
-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2=
; text-align: start; text-indent: 0px; text-transform: none; widows: 2; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; back=
ground-color: #ffffff; text-decoration-thickness: initial; text-decoration-=
style: initial; text-decoration-color: initial; display: inline !important;=
 float: none;">--- a/lib/bb/data_smart.py<br />+++ b/lib/bb/data_smart.py<b=
r />@@ -1007,9 +1007,34 @@ class DataSmart(MutableMapping):<br />&nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp;ref =3D '${%s}' % variable<br />&nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp;value =3D self.getVar(variable, False)<br />&nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;for key in keys:<br />- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;referrervalue =3D self.getVar(key, False)<br />- &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;if referrervalue and isinstance(referrervalue, str) =
and ref in referrervalue:<br />- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;self.setVar(key, referrervalue.replace(ref, value))<br />+ &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;cow =3D False<br />+ &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;if not key in self.dict:<br />+ &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;local_var, _ =3D self._findVar(key)<br=
 />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;cow =3D True<br=
 />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;else:<br />+ &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;local_var =3D self.dict[key]<br />+<=
br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for sKey in ["_content", "_=
defaultval", ":append", ":prepend", ":remove"]:<br />+ &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;val =3D local_var[sKey] if sKey in local=
_var else None<br />+<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;if isinstance(val, str) and ref in val:<br />+ &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;val2 =3D val.replace(ref,=
 value)<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;if cow:<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;self._makeShadowCopy(key)<br />+ &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;co=
w =3D False<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;self.dict[key][sKey] =3D val2<br />+ &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;elif isinstance(val, list):<br />+ &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;val2 =3D None<br=
 />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;f=
or i, (r, o) in enumerate(val):<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if ref in r:<br />+ &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp;if not val2:<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;val2 =
=3D list(val)<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;val2[i] =3D [r.replace(ref, valu=
e), o]<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;if val2:<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;if cow:<br />+ &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self._=
makeShadowCopy(key)<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;cow =3D False<br />+ &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;self.dict[key][sKey] =3D val2</span></div>
<div>&nbsp;</div>
<div><span style=3D"color: #333333; font-family: system-ui, 'Segoe UI', Rob=
oto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, '=
Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'=
; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font=
-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2=
; text-align: start; text-indent: 0px; text-transform: none; widows: 2; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; back=
ground-color: #ffffff; text-decoration-thickness: initial; text-decoration-=
style: initial; text-decoration-color: initial; display: inline !important;=
 float: none;">Efficiency wise it does not do more that the original code, =
and it gets straight to the point.<br /></span></div>
<div>&nbsp;</div>
<div><span style=3D"color: #333333; font-family: system-ui, 'Segoe UI', Rob=
oto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, '=
Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'=
; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font=
-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2=
; text-align: start; text-indent: 0px; text-transform: none; widows: 2; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; back=
ground-color: #ffffff; text-decoration-thickness: initial; text-decoration-=
style: initial; text-decoration-color: initial; display: inline !important;=
 float: none;">Thanks,</span></div>
<div><span style=3D"color: #333333; font-family: system-ui, 'Segoe UI', Rob=
oto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, '=
Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'=
; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font=
-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2=
; text-align: start; text-indent: 0px; text-transform: none; widows: 2; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; back=
ground-color: #ffffff; text-decoration-thickness: initial; text-decoration-=
style: initial; text-decoration-color: initial; display: inline !important;=
 float: none;">Adam</span></div>

--u1U5bX6t0JymBrb25Lah--

