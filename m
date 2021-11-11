Return-Path: <gabriel.valcazar@digi.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8BCC433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 12:18:01 +0000 (UTC)
Subject: Re: [PATCH 1/2] fetch/git: Handle github dropping git:// support
To: bitbake-devel@lists.openembedded.org
From: gabriel.valcazar@digi.com
X-Originating-Location: =?utf-8?b?TGXDs24sIENhc3RpbGxlIGFuZCBMZcOzbiwgRVMg?=
 =?utf-8?b?KDgxLjQ3LjE2NS40MCk=?=
X-Originating-Platform: Linux Firefox 94
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 11 Nov 2021 04:18:01 -0800
References: 
 <5b3eb5a7a03a999e37b2ac0aacf2997819c00fd2.camel@linuxfoundation.org>
In-Reply-To: 
 <5b3eb5a7a03a999e37b2ac0aacf2997819c00fd2.camel@linuxfoundation.org>
Message-ID: <30784.1636633081071526988@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="ZxIcDLEtqS5U0iCFWF6s"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 12:18:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13015

--ZxIcDLEtqS5U0iCFWF6s
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Thanks for the explanation. I fully understand the reasoning behind your de=
cision, but I really think this issue requires specific treatment due to it=
s nature.

Ideally, customers using our legacy products (and thus, really old versions=
 of our Yocto distribution) would migrate to newer products running newer s=
oftware, and these situations would be avoided altogether. However, we're t=
alking about products that are already in production, with several devices =
in the field that require periodic updates. Maintaining outdated software, =
while not recommendable from several standpoints, is oftentimes a more effi=
cient approach than migrating to something newer, especially in these cases=
.

Older Yocto builds are still possible for us and our customers via docker c=
ontainers or virtual machines, which provide "old" environments where the b=
uilds still work, despite all of the missing fixes in bitbake/poky. Basical=
ly, rather than patching the Yocto stack to fit our environment, we adapt o=
ur environment to fit the Yocto stack - again, because several legacy custo=
mers have made the decision to depend on old Yocto versions.

Having said this, I believe GitHub's deprecation of the git protocol is a s=
pecial case because, regardless of the environment you're using or how many=
 patches you've backported so far, builds will simply stop working altogeth=
er after the plug is pulled. No matter which environment we use, this is an=
 external factor that's going to force changes in the Yocto stack, in areas=
 that we have little to no control over. We're going to have to fix it eith=
er way, but it would be a much smoother transition if the fix were included=
 by the community, and it's a unique enough case to warrant it being patche=
d in older bitbake versions (in my opinion).

Forgive me for the insistence, but I truly believe this situation requires =
exceptional treatment.

Best regards,
Gabriel

--ZxIcDLEtqS5U0iCFWF6s
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,<br /><br />Thanks for the explanation. I fully understand the r=
easoning behind your decision, but I really think this issue requires speci=
fic treatment due to its nature.<br /><br />Ideally, customers using our le=
gacy products (and thus, really old versions of our Yocto distribution) wou=
ld migrate to newer products running newer software, and these situations w=
ould be avoided altogether. However, we're talking about products that are =
already in production, with several devices in the field that require perio=
dic updates. Maintaining outdated software, while not recommendable from se=
veral standpoints, is oftentimes a more efficient approach than migrating t=
o something newer, especially in these cases.<br /><br />Older Yocto builds=
 are still possible for us and our customers via docker containers or virtu=
al machines, which provide "old" environments where the builds still work, =
despite all of the missing fixes in bitbake/poky. Basically, rather than pa=
tching the Yocto stack to fit our environment, we adapt our environment to =
fit the Yocto stack - again, because several legacy customers have made the=
 decision to depend on old Yocto versions.<br /><br />Having said this, I b=
elieve GitHub's deprecation of the <em>git </em>protocol is a special case =
because, regardless of the environment you're using or how many patches you=
've backported so far, builds will simply stop working altogether after the=
 plug is pulled. No matter which environment we use, this is an external fa=
ctor that's going to force changes in the Yocto stack, in areas that we hav=
e little to no control over. We're going to have to fix it either way, but =
it would be a much smoother transition if the fix were included by the comm=
unity, and it's a unique enough case to warrant it being patched in older b=
itbake versions (in my opinion).<br /><br />Forgive me for the insistence, =
but I truly believe this situation requires exceptional treatment.<br /><br=
 />Best regards,<br />Gabriel

--ZxIcDLEtqS5U0iCFWF6s--

