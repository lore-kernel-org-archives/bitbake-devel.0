Return-Path: <fawzi.khaber@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08273C64ED6
	for <webhook@archiver.kernel.org>; Wed,  1 Mar 2023 10:42:47 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] bitbake-user-manual: update Hello World example
To: bitbake-devel@lists.openembedded.org
From: "Fawzi KHABER" <fawzi.khaber@smile.fr>
X-Originating-Location: FR (176.157.204.145)
X-Originating-Platform: Linux Chrome 109
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 01 Mar 2023 02:42:45 -0800
References: <29555.1677578950016132509@lists.openembedded.org>
In-Reply-To: <29555.1677578950016132509@lists.openembedded.org>
Message-ID: <11178.1677667365539099890@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="XaFJpZYFKFedsEggJkdW"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Mar 2023 10:42:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14509

--XaFJpZYFKFedsEggJkdW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Michael,

As i was preparing my patch v3, i found an issue with the LAYERSERIES_COMPA=
T Variable. bitbake and OE seems to be maintained separately but they are l=
inked.
so for this hello world example should not include an OE release in bblayer=
s.conf but :
if LAYERSERIES_COMPAT is not set it produces a warning, and if a default va=
lue is set but OE is not included, the build fails with
No core layer found to work with layer '%s'. Missing entry in bblayers.conf
this change was introduced in=C2=A05815a7258ebb8a989e0c6f5798853559d9413f02=
 to fix https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14340
I would suggest, keeping the warning for now.

Best regards,
Fawzi.

--XaFJpZYFKFedsEggJkdW
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Michael,<br /><br />As i was preparing my patch v3, i found an issue =
with the LAYERSERIES_COMPAT Variable. bitbake and OE seems to be maintained=
 separately but they are linked.<br />so for this hello world example shoul=
d not include an OE release in bblayers.conf but :<br />if LAYERSERIES_COMP=
AT is not set it produces a warning, and if a default value is set but OE i=
s not included, the build fails with&nbsp;<br />No core layer found to work=
 with layer '%s'. Missing entry in bblayers.conf<br />this change was intro=
duced in&nbsp;5815a7258ebb8a989e0c6f5798853559d9413f02 to fix&nbsp;<a href=
=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14340" target=3D"_b=
lank" rel=3D"noopener">https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D=
14340</a><br />I would suggest, keeping the warning for now.<br /><br />Bes=
t regards,<br />Fawzi.

--XaFJpZYFKFedsEggJkdW--

