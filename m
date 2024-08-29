Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D0FC83027
	for <webhook@archiver.kernel.org>; Thu, 29 Aug 2024 09:53:03 +0000 (UTC)
Subject: [bitbake][kirkstone][2.0] Appends discarded by expandVarref
To: bitbake-devel@lists.openembedded.org
From: "Adam Blank" <adam.blank.g@gmail.com>
X-Originating-Location: (131.228.32.167)
X-Originating-Platform: Windows Chrome 127
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 29 Aug 2024 02:53:00 -0700
Message-ID: <zAtt.1724925180061037156.a5Q8@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="kjWyn97N6vnKGic5wjnp"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Aug 2024 09:53:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16528

--kjWyn97N6vnKGic5wjnp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

expandVarref is called during the parsing stage, to expand special purpose =
variables, in my case LAYERDIR.
Internally it calls setVar without letting it know that parsing is True, wh=
ich removes any possible appends for the variable being processed by it.
This has interesting side effects - I doubt they were intended, but fixing =
it shows how rife they are.

1. Real life example for BBMASK
- BBMASK:append:qemuarm64 =3D " meta-foo/recipes-bar"
- BBMASK +=3D "${LAYERDIR}/recipes-kernel/linux/linux-yocto_5.15.bbappend"

When this is parsed in layer.conf, OVERRIDES have not been appended with 'q=
emuarm64' yet.
Before the change (self.setVar(key, referrervalue.replace(ref, value))):
The call to expandVarref ends up setting BBMASK to some appended value with=
 LAYERDIR expanded, but removing the conditional append for qemuarm64.
The qemuarm64 append although perfectly good syntax-wise, is never applied.
After the change (self.setVar(key, referrervalue.replace(ref, value), parsi=
ng=3DTrue)):
The call to expandVarref ends up setting BBMASK to some appended value with=
 LAYERDIR expanded, the conditional append for qemuarm64 remains in place.
As soon as the OVERRIDES start containing 'qemuarm64', the conditional appe=
nd also starts being considered - as intended.
2. Real life example for BBFILES
- BBFILES:append =3D " ${LAYERDIR}/recipes-core/wpa-supplicant/wpa-supplica=
nt_%.bbappend"

Before the change (self.setVar(key, referrervalue.replace(ref, value))):
The call to expandVarref ends up setting BBFILES to some appended value wit=
h LAYERDIR expanded, but removing the append.
This time the effect is exactly as the author intended, but only accidental=
ly - contrary to what the syntax would suggest.
After the change (self.setVar(key, referrervalue.replace(ref, value), parsi=
ng=3DTrue)):
The call to expandVarref ends up setting BBFILES to some appended value wit=
h LAYERDIR expanded, the append remains in place.
For every subsequently parsed layer, the BBFILES end up being appended with=
 gibberish (based on its own LAYERDIR).
Definitely not intended by the author.

So now I'm wondering what the situation is really. Are the above just examp=
les of bad style? Perhaps it would be worth it to extend the documentation =
for LAYERDIR type variables, to warn about their special handling?
My hunch is that this is a defect (at least the fact, that expandVarref is =
used truly during parsing, and setVar which it calls is not notified about =
it).
It can be easily circumvented by a simple indirection, i.e. placing the exp=
ressions with LAYERDIR in them in a separate variable, and then referencing=
 this variable. But this feels like a hack.

Please let me know your opinions.
Thanks,
Adam

--kjWyn97N6vnKGic5wjnp
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>&nbsp;</div>
<div>
<div>expandVarref is called during the parsing stage, to expand special pur=
pose variables, in my case LAYERDIR.<br />Internally it calls setVar withou=
t letting it know that parsing is True, which removes any possible appends =
for the variable being processed by it.<br />This has interesting side effe=
cts - I doubt they were intended, but fixing it shows how rife they are.</d=
iv>
<div>&nbsp;</div>
<div>1. Real life example for BBMASK<br />&nbsp; &nbsp; - BBMASK:append:qem=
uarm64 =3D " meta-foo/recipes-bar"<br />&nbsp; &nbsp; - BBMASK +=3D "${LAYE=
RDIR}/recipes-kernel/linux/linux-yocto_5.15.bbappend"</div>
<div>&nbsp; &nbsp;</div>
<div>&nbsp; &nbsp; When this is parsed in layer.conf, OVERRIDES have not be=
en appended with 'qemuarm64' yet.</div>
<div>&nbsp; &nbsp; Before the change (self.setVar(key, referrervalue.replac=
e(ref, value))):<br />&nbsp; &nbsp; &nbsp; The call to expandVarref ends up=
 setting BBMASK to some appended value with LAYERDIR expanded, but removing=
 the conditional append for qemuarm64.<br />&nbsp; &nbsp; &nbsp; The qemuar=
m64 append although perfectly good syntax-wise, is never applied.<br />&nbs=
p; &nbsp; After the change (self.setVar(key, referrervalue.replace(ref, val=
ue), parsing=3DTrue)):<br />&nbsp; &nbsp; &nbsp; The call to expandVarref e=
nds up setting BBMASK to some appended value with LAYERDIR expanded, the co=
nditional append for qemuarm64 remains in place.<br />&nbsp; &nbsp; &nbsp; =
As soon as the OVERRIDES start containing 'qemuarm64', the conditional appe=
nd also starts being considered - as intended.</div>
<div>2. Real life example for BBFILES<br />&nbsp; &nbsp; - BBFILES:append =
=3D " ${LAYERDIR}/recipes-core/wpa-supplicant/wpa-supplicant_%.bbappend"</d=
iv>
<div>&nbsp; &nbsp;</div>
<div>&nbsp; &nbsp; Before the change (self.setVar(key, referrervalue.replac=
e(ref, value))):<br />&nbsp; &nbsp; &nbsp; The call to expandVarref ends up=
 setting BBFILES to some appended value with LAYERDIR expanded, but removin=
g the append.<br />&nbsp; &nbsp; &nbsp; This time the effect is exactly as =
the author intended, but only accidentally - contrary to what the syntax wo=
uld suggest.<br />&nbsp; &nbsp; After the change (self.setVar(key, referrer=
value.replace(ref, value), parsing=3DTrue)):<br />&nbsp; &nbsp; &nbsp; The =
call to expandVarref ends up setting BBFILES to some appended value with LA=
YERDIR expanded, the append remains in place.<br />&nbsp; &nbsp; &nbsp; For=
 every subsequently parsed layer, the BBFILES end up being appended with gi=
bberish (based on its own LAYERDIR).<br />&nbsp; &nbsp; &nbsp; Definitely n=
ot intended by the author.</div>
<div>&nbsp; &nbsp;</div>
<div>So now I'm wondering what the situation is really. Are the above just =
examples of bad style? Perhaps it would be worth it to extend the documenta=
tion for LAYERDIR type variables, to warn about their special handling?<br =
/>My hunch is that this is a defect (at least the fact, that expandVarref i=
s used truly during parsing, and setVar which it calls is not notified abou=
t it).<br />It can be easily circumvented by a simple indirection, i.e. pla=
cing the expressions with LAYERDIR in them in a separate variable, and then=
 referencing this variable. But this feels like a hack.</div>
<div>&nbsp;</div>
<div>Please let me know your opinions.</div>
<div>Thanks,</div>
<div>Adam</div>
</div>

--kjWyn97N6vnKGic5wjnp--

