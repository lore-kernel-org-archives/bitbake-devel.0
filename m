Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9949FC433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 17:14:33 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.13336.1639674871975121914
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Dec 2021 09:14:32 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.183.199,
 mailfrom: foss+yocto@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 7CA1DFF807;
	Thu, 16 Dec 2021 17:14:29 +0000 (UTC)
Date: Thu, 16 Dec 2021 18:14:27 +0100
From: Quentin Schulz <foss+yocto@0leil.net>
To: bitbake-devel@lists.openembedded.org,
 Daniel Wagenknecht <dwagenknecht@emlix.com>
CC: docs@lists.yoctoproject.org
Subject: =?US-ASCII?Q?Re=3A_=5Bbitbake-devel=5D_=5BPATC?=
 =?US-ASCII?Q?H=5D_doc=3A_document_override?=
 =?US-ASCII?Q?_style_operators_not_working_for_task_dependencies?=
In-Reply-To: <20211216152555.815291-1-dwagenknecht@emlix.com>
References: <20211216152555.815291-1-dwagenknecht@emlix.com>
Message-ID: <484FA2CC-02D8-4368-B332-DCBA4FBDE61F@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Dec 2021 17:14:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13186

Hi Daniel,

On December 16, 2021 4:25:56 PM GMT+01:00, Daniel Wagenknecht <dwagenknech=
t@emlix=2Ecom> wrote:
>Override style operators do not work for specifying task dependencies=2E
>This is not obvious and should be highlighted in the documentation=2E
>
>Signed-off-by: Daniel Wagenknecht <dwagenknecht@emlix=2Ecom>
>---
>
>I have experienced this problem with external layers "in the wild" leadin=
g to
>dependencies being undeclared and builds sometimes failing=2E Additional
>documentation will not necessarily fix the problem, but might make it eas=
ier to
>find the problem=2E I'm not sure if there's also some mechanism in bitbak=
e that
>could detect such mistakes and provide a warning?
>
>CC: qschulz, we talked about this on IRC:
>  https://www=2Eyoctoproject=2Eorg/irc/%23yocto=2E2021-11-30=2Elog=2Ehtml=
#t2021-11-30T14:18:08
>
>Sincerely
>Daniel Wagenknecht
>
> =2E=2E=2E/bitbake-user-manual-metadata=2Erst          | 19 +++++++++++++=
++++++
> 1 file changed, 19 insertions(+)
>
>diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst b=
/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst
>index d802a8d3=2E=2E181c0997 100644
>--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst
>+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst
>@@ -1689,6 +1689,14 @@ This section describes several ways to declare dep=
endencies=2E Remember,
> even though dependencies are declared in different ways, they are all
> simply dependencies between tasks=2E
>=20
>+=2E=2E note::
>+
>+   Override style operators do not work for declaring task dependencies=
=2E
>+   See
>+   :ref:`bitbake-user-manual/bitbake-user-manual-metadata:Inter-Task Dep=
endencies`
>+   for details=2E
>+
>+
> =2E=2E _dependencies-internal-to-the-bb-file:
>=20
> Dependencies Internal to the ``=2Ebb`` File
>@@ -1813,6 +1821,17 @@ must have completed before the ``do_patch`` task c=
an execute=2E
> The ``[rdepends]`` flag works in a similar way but takes targets in the
> runtime namespace instead of the build-time dependency namespace=2E
>=20
>+Note that dependencies are specified via
>+:ref:`bitbake-user-manual/bitbake-user-manual-metadata:Variable Flag Syn=
tax`
>+and thus override style operators do not work for declaring task
>+dependencies=2E You can add a task dependency for a specific override
>+(e=2Eg=2E a specific machine) by declaring an intermediary variable and =
using
>+overrides for setting that variable::
>+
>+   # Does not work: do_compile:machine[depends] +=3D "another_target:do_=
task"
>+   EXTRA_DO_COMPILE_DEPENDS:machine =3D "another_target:do_task"
>+   do_compile[depends] +=3D "${EXTRA_DO_COMPILE_DEPENDS}"
>+
> Functions You Can Call From Within Python
>

Nice addition, thanks for the patch!

I think we could make it even more explicit by adding a section in https:/=
/docs=2Eyoctoproject=2Eorg/bitbake/bitbake-user-manual/bitbake-user-manual-=
metadata=2Ehtml to explicit incompatibility between any OVERRIDES and varfl=
ags (or add a note in both sections that it's not compatible with the other=
) because I think this applies to :append and :prepend too=2E

Having a specific example for task dependencies is fine IMO but we'd benef=
it from an even more explicit rule=2E

Cheers
Quentin


 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20

