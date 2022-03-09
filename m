Return-Path: <tom.hochstein@nxp.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F488C433EF
	for <webhook@archiver.kernel.org>; Wed,  9 Mar 2022 00:22:50 +0000 (UTC)
Subject: bitbake -e and "no history recorded"
To: bitbake-devel@lists.openembedded.org
From: "Tom Hochstein" <tom.hochstein@nxp.com>
X-Originating-Location: Texas, US (165.225.33.77)
X-Originating-Platform: Windows Chrome 98
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 08 Mar 2022 16:22:49 -0800
Message-ID: <rMEQ.1646785369249055290.S70q@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0uQTYOD3SC9J7Apo6vNu"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Mar 2022 00:22:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13450

--0uQTYOD3SC9J7Apo6vNu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The output of bitbake -e on kirkstone is missing information on numerous va=
riables and shows "no history recorded". For example:

#
# $ALLOW_EMPTY
#=C2=A0 =C2=A0set /opt/kirkstone/sources/poky/meta/conf/documentation.conf:=
62
#=C2=A0 =C2=A0 =C2=A0[doc] "Specifies if an output package should still be =
produced if it is empty."
#
# $ALLOW_EMPTY:glm
#=C2=A0 =C2=A0[no history recorded]
#
#=C2=A0 =C2=A0"1"
ALLOW_EMPTY:glm=3D"1"

Is this a known issue?

Tom

--0uQTYOD3SC9J7Apo6vNu
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The output of bitbake -e on kirkstone is missing information on numerous va=
riables and shows "no history recorded". For example:<br /><br />
<div><span style=3D"font-family: courier_newregular, courier;">#</span></di=
v>
<div><span style=3D"font-family: courier_newregular, courier;"># $ALLOW_EMP=
TY</span></div>
<div><span style=3D"font-family: courier_newregular, courier;">#&nbsp; &nbs=
p;set /opt/kirkstone/sources/poky/meta/conf/documentation.conf:62</span></d=
iv>
<div><span style=3D"font-family: courier_newregular, courier;">#&nbsp; &nbs=
p; &nbsp;[doc] "Specifies if an output package should still be produced if =
it is empty."</span></div>
<div><span style=3D"font-family: courier_newregular, courier;">#</span></di=
v>
<div><span style=3D"font-family: courier_newregular, courier;"># $ALLOW_EMP=
TY:glm</span></div>
<div><span style=3D"font-family: courier_newregular, courier;">#&nbsp; &nbs=
p;[no history recorded]</span></div>
<div><span style=3D"font-family: courier_newregular, courier;">#</span></di=
v>
<div><span style=3D"font-family: courier_newregular, courier;">#&nbsp; &nbs=
p;"1"</span></div>
<div><span style=3D"font-family: courier_newregular, courier;">ALLOW_EMPTY:=
glm=3D"1"</span></div>
<div>&nbsp;</div>
Is this a known issue?<br /><br />Tom

--0uQTYOD3SC9J7Apo6vNu--

