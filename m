Return-Path: <athragared@proton.me>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEC5C4332F
	for <webhook@archiver.kernel.org>; Sat, 11 Nov 2023 11:55:03 +0000 (UTC)
Subject: Problem when adding own tasks
To: bitbake-devel@lists.openembedded.org
From: athragared@proton.me
X-Originating-Location: Essen, North Rhine-Westphalia, DE (83.135.186.108)
X-Originating-Platform: Windows Firefox 119
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sat, 11 Nov 2023 03:54:53 -0800
Message-ID: <rd62.1699703693217578896.TOFk@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="uaJp07r17G0ISwnki9RT"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Nov 2023 11:55:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15514

--uaJp07r17G0ISwnki9RT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone, this is my first mail here, I hope this is the right "chann=
el" for my question.

I am currently using the 'Kirkstone' branch of yocto and I have encountered=
 a problem. I have written a .bbappend file for *systemd* in my own layer. =
Here I have written my own python function as follows:

python do_my_own_function(){
# do something
}
addtask my_own_function before do_install

This seems to work most of the time. However, I would like to execute my ow=
n function *AFTER* the do_install. However, this does not seem to work.
If I delete the build folder before building the image and then look in the=
 *log.task_order* file I see that my own function is NOT executed. Other pe=
ople on stackoverflow ( https://stackoverflow.com/questions/76234388/bitbak=
e-addtask-deploy-after-do-install-not-working-from-image-recipe ) seem to h=
ave observed this problem as well.

So I wanted to ask how to solve the problem or debug it further?

--uaJp07r17G0ISwnki9RT
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Hello everyone, this is my first mail here, I hope this is the right "ch=
annel" for my question.<br /><br />I am currently using the 'Kirkstone' bra=
nch of yocto and I have encountered a problem. I have written a .bbappend f=
ile for <strong>systemd</strong> in my own layer. Here I have written my ow=
n python function as follows:<br /><br />python do_my_own_function(){<br />=
&nbsp;&nbsp;&nbsp; # do something<br />}<br />addtask my_own_function befor=
e do_install<br /><br />This seems to work most of the time. However, I wou=
ld like to execute my own function <strong>AFTER</strong> the do_install. H=
owever, this does not seem to work.<br />If I delete the build folder befor=
e building the image and then look in the <strong>log.task_order</strong> f=
ile I see that my own function is NOT executed. Other people on <a href=3D"=
https://stackoverflow.com/questions/76234388/bitbake-addtask-deploy-after-d=
o-install-not-working-from-image-recipe" target=3D"_blank" rel=3D"noopener"=
>stackoverflow</a> seem to have observed this problem as well.</p>
<p><br />So I wanted to ask how to solve the problem or debug it further?<b=
r /><br /><br /><br /><br /><br /></p>

--uaJp07r17G0ISwnki9RT--

