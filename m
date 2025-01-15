Return-Path: <ganesh.manoj.mahajan@signify.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D06C02180
	for <webhook@archiver.kernel.org>; Wed, 15 Jan 2025 06:24:16 +0000 (UTC)
Subject: HELP
To: bitbake-devel@lists.openembedded.org
From: "Ganesh Mahajan" <ganesh.manoj.mahajan@signify.com>
X-Originating-Location: IN (165.225.124.177)
X-Originating-Platform: Windows Chrome 131
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 14 Jan 2025 22:24:16 -0800
Message-ID: <cy2f.1736922256220994167.TiEe@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="6NMoc8c1TjidTklf6yCP"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Jan 2025 06:24:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17018

--6NMoc8c1TjidTklf6yCP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I am trying to upgrade from dunfell to scarthgap-5.0.5

meta-eaton is my custom layer.
source setup worked for dunfell but when trying with scarthgap facing TEMPL=
ATECONF error.

Error is as below
*/home/build/project/meta-eaton/conf/templates/template-name
build@ubuntu-bionic:~/project$ source meta-eaton/setup-build-env
Error: TEMPLATECONF value (which is /home/build/project/meta-eaton/conf/tem=
plates/template-name) must point to* meta-some-layer/conf/templates/templat=
e-name
changed the dir structure as mentioned in error, UNSET TEMPLATECONF and ver=
ified its path which is
*build@ubuntu-bionic:~/project$ echo $TEMPLATECONF*
*/home/build/project/meta-eaton/conf/templates/template-name

* what am i doing wrong can anyone help.

--6NMoc8c1TjidTklf6yCP
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div><span style=3D"box-sizing: border-box; overflow-wrap: break-word !impo=
rtant; color: #333333; font-size: 16px; font-style: normal; font-variant-li=
gatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform:=
 none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-=
space: normal; text-decoration-thickness: initial; text-decoration-style: i=
nitial; text-decoration-color: initial; font-family: system-ui, Roboto, Ari=
al, sans-serif; background-color: #ffffff; display: inline;">I am trying to=
 upgrade from dunfell to scarthgap-5.0.5<br style=3D"box-sizing: border-box=
; overflow-wrap: break-word !important;" /><br style=3D"box-sizing: border-=
box; overflow-wrap: break-word !important;" />meta-eaton is my custom layer=
.</span><br style=3D"box-sizing: border-box; overflow-wrap: break-word !imp=
ortant; color: #333333; font-family: system-ui, 'Segoe UI', Roboto, 'Helvet=
ica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Color =
Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; font-size:=
 16px; font-style: normal; font-variant-ligatures: normal; font-variant-cap=
s: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align=
: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: =
#ffffff; text-decoration-thickness: initial; text-decoration-style: initial=
; text-decoration-color: initial;" /><span style=3D"box-sizing: border-box;=
 overflow-wrap: break-word !important; color: #333333; font-size: 16px; fon=
t-style: normal; font-variant-ligatures: normal; font-variant-caps: normal;=
 font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; t=
ext-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webki=
t-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: i=
nitial; text-decoration-style: initial; text-decoration-color: initial; fon=
t-family: system-ui, Roboto, Arial, sans-serif; background-color: #ffffff; =
display: inline;">source setup worked for dunfell but when trying with scar=
thgap facing TEMPLATECONF error.<br style=3D"box-sizing: border-box; overfl=
ow-wrap: break-word !important;" /></span><br style=3D"box-sizing: border-b=
ox; overflow-wrap: break-word !important; color: #333333; font-family: syst=
em-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans'=
, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbo=
l', 'Noto Color Emoji'; font-size: 16px; font-style: normal; font-variant-l=
igatures: normal; font-variant-caps: normal; font-weight: 400; letter-spaci=
ng: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform=
: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white=
-space: normal; background-color: #ffffff; text-decoration-thickness: initi=
al; text-decoration-style: initial; text-decoration-color: initial;" /><spa=
n style=3D"color: #333333; font-family: system-ui, 'Segoe UI', Roboto, 'Hel=
vetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Col=
or Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; font-si=
ze: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-=
caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-al=
ign: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing=
: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-colo=
r: #ffffff; text-decoration-thickness: initial; text-decoration-style: init=
ial; text-decoration-color: initial; display: inline !important; float: non=
e;">Error is as below</span><br style=3D"box-sizing: border-box; overflow-w=
rap: break-word !important; color: #333333; font-family: system-ui, 'Segoe =
UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-=
serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Colo=
r Emoji'; font-size: 16px; font-style: normal; font-variant-ligatures: norm=
al; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; or=
phans: 2; text-align: start; text-indent: 0px; text-transform: none; widows=
: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal=
; background-color: #ffffff; text-decoration-thickness: initial; text-decor=
ation-style: initial; text-decoration-color: initial;" /><strong style=3D"b=
ox-sizing: border-box; font-weight: bold; overflow-wrap: break-word !import=
ant; color: #333333; font-family: system-ui, 'Segoe UI', Roboto, 'Helvetica=
 Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Color Emo=
ji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; font-size: 16=
px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: =
normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent:=
 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stro=
ke-width: 0px; white-space: normal; background-color: #ffffff; text-decorat=
ion-thickness: initial; text-decoration-style: initial; text-decoration-col=
or: initial;">/home/build/project/meta-eaton/conf/templates/template-name<b=
r style=3D"box-sizing: border-box; overflow-wrap: break-word !important;" /=
>build@ubuntu-bionic:~/project$ source meta-eaton/setup-build-env<br style=
=3D"box-sizing: border-box; overflow-wrap: break-word !important;" />Error:=
 TEMPLATECONF value (which is /home/build/project/meta-eaton/conf/templates=
/template-name) must point to</strong><span style=3D"color: #333333; font-f=
amily: system-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liber=
ation Sans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Seg=
oe UI Symbol', 'Noto Color Emoji'; font-size: 16px; font-style: normal; fon=
t-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; l=
etter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; tex=
t-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; white-space: normal; background-color: #ffffff; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al; display: inline !important; float: none;"><span>&nbsp;</span>meta-some-=
layer/conf/templates/template-name</span><br style=3D"box-sizing: border-bo=
x; overflow-wrap: break-word !important; color: #333333; font-family: syste=
m-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans',=
 Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol=
', 'Noto Color Emoji'; font-size: 16px; font-style: normal; font-variant-li=
gatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform:=
 none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-=
space: normal; background-color: #ffffff; text-decoration-thickness: initia=
l; text-decoration-style: initial; text-decoration-color: initial;" /><span=
 style=3D"color: #333333; font-family: system-ui, 'Segoe UI', Roboto, 'Helv=
etica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Colo=
r Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; font-siz=
e: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-c=
aps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-ali=
gn: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing:=
 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color=
: #ffffff; text-decoration-thickness: initial; text-decoration-style: initi=
al; text-decoration-color: initial; display: inline !important; float: none=
;">&nbsp;changed the dir structure as mentioned in error, UNSET TEMPLATECON=
F and verified its path which is</span><br style=3D"box-sizing: border-box;=
 overflow-wrap: break-word !important; color: #333333; font-family: system-=
ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', A=
rial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol',=
 'Noto Color Emoji'; font-size: 16px; font-style: normal; font-variant-liga=
tures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing:=
 normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: n=
one; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-sp=
ace: normal; background-color: #ffffff; text-decoration-thickness: initial;=
 text-decoration-style: initial; text-decoration-color: initial;" /><strong=
 style=3D"box-sizing: border-box; font-weight: bold; overflow-wrap: break-w=
ord !important; color: #333333; font-family: system-ui, 'Segoe UI', Roboto,=
 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Appl=
e Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; fo=
nt-size: 16px; font-style: normal; font-variant-ligatures: normal; font-var=
iant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; t=
ext-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webki=
t-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; t=
ext-decoration-thickness: initial; text-decoration-style: initial; text-dec=
oration-color: initial;">build@ubuntu-bionic:~/project$ echo $TEMPLATECONF<=
/strong><br style=3D"box-sizing: border-box; overflow-wrap: break-word !imp=
ortant; color: #333333; font-family: system-ui, 'Segoe UI', Roboto, 'Helvet=
ica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Color =
Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; font-size:=
 16px; font-style: normal; font-variant-ligatures: normal; font-variant-cap=
s: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align=
: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: =
#ffffff; text-decoration-thickness: initial; text-decoration-style: initial=
; text-decoration-color: initial;" /><strong style=3D"box-sizing: border-bo=
x; font-weight: bold; overflow-wrap: break-word !important; color: #333333;=
 font-family: system-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans',=
 'Liberation Sans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji=
', 'Segoe UI Symbol', 'Noto Color Emoji'; font-size: 16px; font-style: norm=
al; font-variant-ligatures: normal; font-variant-caps: normal; letter-spaci=
ng: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform=
: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white=
-space: normal; background-color: #ffffff; text-decoration-thickness: initi=
al; text-decoration-style: initial; text-decoration-color: initial;">/home/=
build/project/meta-eaton/conf/templates/template-name<br style=3D"box-sizin=
g: border-box; overflow-wrap: break-word !important;" /><br style=3D"box-si=
zing: border-box; overflow-wrap: break-word !important;" /></strong><span s=
tyle=3D"color: #333333; font-family: system-ui, 'Segoe UI', Roboto, 'Helvet=
ica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Color =
Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; font-size:=
 16px; font-style: normal; font-variant-ligatures: normal; font-variant-cap=
s: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align=
: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: =
#ffffff; text-decoration-thickness: initial; text-decoration-style: initial=
; text-decoration-color: initial; display: inline !important; float: none;"=
>what am i doing wrong can anyone help.</span></div>

--6NMoc8c1TjidTklf6yCP--

