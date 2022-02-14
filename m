Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B305C433F5
	for <webhook@archiver.kernel.org>; Mon, 14 Feb 2022 20:26:19 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web08.690.1644870377421558336
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Feb 2022 12:26:17 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.183.197,
 mailfrom: foss+yocto@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by mail.gandi.net (Postfix) with ESMTPSA id B1E621C0007;
	Mon, 14 Feb 2022 20:26:14 +0000 (UTC)
Date: Mon, 14 Feb 2022 21:26:09 +0100
From: Quentin Schulz <foss+yocto@0leil.net>
To: Martin Leduc <martin.leduc@luminator.com>,
 Christopher Larson <kergoth@gmail.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] bitbake addtask bbclass dependancies
In-Reply-To: 
 <PA4P189MB118329A70AFDEC8C87329B6996319@PA4P189MB1183.EURP189.PROD.OUTLOOK.COM>
References: <Me0Z.1644602104245206529.KOgD@lists.openembedded.org>
 <5689f841-7090-4141-ae31-8d02596bdad1@Spark>
 <PA4P189MB118329A70AFDEC8C87329B6996319@PA4P189MB1183.EURP189.PROD.OUTLOOK.COM>
Message-ID: <9B73F57B-D218-4D75-95EC-6B2B9304C3B7@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Feb 2022 20:26:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13348

Hi Martin,

On February 12, 2022 3:04:47 PM GMT+01:00, Martin Leduc <martin=2Eleduc@lu=
minator=2Ecom> wrote:
>Hi Christopher,
>
>Thank you for this fast answer=2E  I=E2=80=99ve tested your suggestions, =
and it works=2E  Thank you but, this put me more in the dark by 2 topics be=
cause I try to understand=2E
>
>#1: when you say:
>
>Tasks you add are *not* automatically run, unless they=E2=80=99re explici=
tly requested with -c or they=E2=80=99re pulled in as a dependency by a tas=
k already being run
>
>Did I don=E2=80=99t explicitely don=E2=80=99t request to run it by defini=
ng task to be run after do_image_complete?
>

Imagine a tree of tasks, each node (task) having their dependencies repres=
ented as parent nodes=2E When you Bitbake a task, all parent nodes (hence d=
ependencies) are run first (from "root" task, usually fetch) and then the a=
ctual requested node is run=2E Anything that is not required for the task t=
o be run won't be run, that is an obvious performance choice=2E It is very =
rare to have tasks that aren't dependent on other tasks, meaning if we were=
 to build all tasks with a dependency, the build would take much longer and=
 we would run tasks that aren't interesting=2E

Take the example of menuconfig of the Linux kernel=2E To be able to run th=
is, you obviously need the sources of the kernel, but do you want this task=
 to be run every time the Linux kernel is fetched or built? Probably not=2E

>In build recipes and based on the diagram shown into the mega manual, if =
the do_rootfs is run, the do_image_complete will be call after the do_rootf=
s right?=2E

Not always no=2E You can run do_rootfs without running do_image_complete b=
y requesting Bitbake to run the do_rootfs task (and its dependencies) only=
=2E This is done by doing:
bitbake -c do_rootfs myimage-recipe

>So, again, in my mind, if I have one bbclass file having:
>
>do_thisattheend () { =E2=80=A6}
>
>do_thisattheend2 () {=E2=80=A6}
>
>addtask thisattheend after do_image_complete
>addtask thisattheend2 after thisattheend
>
>I explicitely ask them to be runned no?
>

No=2E You explicitly ask thisattheend2 to run thisattheend task when reque=
sted to be run and do_image_complete to be run when thisattheend task is re=
quested to be run=2E

>#2: do_build =E2=80=A6  why do_build?
>MEGA MANUAL: 27=2E1=2E1=2E do_build=C2=B6<https://www=2Eyoctoproject=2Eor=
g/docs/2=2E7=2E4/mega-manual/mega-manual=2Ehtml#ref-tasks-build>
>
>The default task for all recipes=2E This task depends on all other normal=
 tasks required to build a recipe=2E
>I don=E2=80=99t intend to build a recipe, my intention is to run x functi=
ons AFTER the do_image_complete so why the do_build is invoked in that scen=
ario?
>

An image recipe is a recipe=2E When you run:
bitbake myimage-recipe
you're building a recipe=2E An image recipe=2E You're also actually runnin=
g the do_build task of myimage-recipe=2E Which in turns make Bitbake run al=
l dependencies of do_build of that image recipe=2E Since do_image_complete =
is a dependency of do_build, it'll get run=2E However, your custom task, is=
 not a dependency of do_build=2E Instead it has a dependency of do_image_co=
mplete=2E
If you want it to run you need to either run it directly, or add it to a t=
ask that is a dependency of the task you're running (usually do_build at th=
e very least) or you make it a direct dependency of this task=2E

The after and before words do not convey the same meaning in English than =
it does in Bitbake=2E

Replace "after" by "depends on" and "before" by "is depended on by", that =
might help to draw the picture in your mind of those dependencies and how t=
hey interact with each other=2E

Cheers,
Quentin

>Thank you so much for your answers
>
>Martin Leduc
>T : (418) 856-6896
>martin=2Eleduc@luminator=2Ecom<mailto:martin=2Eleduc@axiontech=2Eca>
>
>
>De : Christopher Larson <kergoth@gmail=2Ecom>
>Envoy=C3=A9 : 11 f=C3=A9vrier 2022 17:06
>=C3=80 : bitbake-devel@lists=2Eopenembedded=2Eorg; Martin Leduc <martin=
=2Eleduc@luminator=2Ecom>
>Objet : [EXTERNAL] Re: [bitbake-devel] bitbake addtask bbclass dependanci=
es
>
>CAUTION: This email originated from outside of Luminator Technology Group=
=2E Do not click links or open attachments unless you recognize the sender =
and know the content is safe=2E
>Tasks you add are *not* automatically run, unless they=E2=80=99re explici=
tly requested with -c or they=E2=80=99re pulled in as a dependency by a tas=
k already being run (i=2Ee=2E our default task, do_build, see BB_DEFAULT_TA=
SK)=2E i=2Ee=2E addtask thisattheend after do_image_complete before do_buil=
d=2E
>
>--
>Christopher =E2=80=9Ckergoth=E2=80=9D Larson
>chris_larson@mentor=2Ecom<mailto:chris_larson@mentor=2Ecom>, chris=2Elars=
on@siemens=2Ecom<mailto:chris=2Elarson@siemens=2Ecom>, kergoth@gmail=2Ecom<=
mailto:kergoth@gmail=2Ecom>
>On Feb 11, 2022, 10:55 AM -0700, Martin Leduc <martin=2Eleduc@luminator=
=2Ecom<mailto:martin=2Eleduc@luminator=2Ecom>>, wrote:
>
>Hi everyone,
>
>I try to figure if the approach is good=2E
>
>For my embeeded image, I need to run a function name do_thisattheend=2E  =
The approach I've is:
>
>Into a thisattheend=2Ebbclass file, I write:
>
>inherit logging
>
>do_thisattheend () {
>
>bbplain Well, it's done
>
>}
>
>
>
>do_thisattheend[nostamp] =3D
>"1"
>
>
>
>addtask after do_image_complete
>
>
>
>
>bitbake show the do_rootfs execution, a little quickly do_image_complete =
and done=2E
>
>If I replace addtask
>thisattheend after do_image_complete
>
>by addtask
>thisattheend
>before do_build after do_image_complete
>
>I see
>Well, it's done
>
>And I see it 2 times, when my comprehension is the do_image_complete is c=
alled one time=2E
>
>
>
>
>
>I've to say that I'm confused about the dependency structure and layout b=
ecause when I look at the picture:
>
>
>
><dummyfile=2E0=2Epart>
>
>The do_image_complete is the last state of the build process, exactly whe=
re I need to run my task=2E
>
>
>
>What I'm doing wrong?
>
>
>
>Any help is appreciated=2E
>
>
>
>Thank you
>

