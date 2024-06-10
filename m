Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B60C27C5E
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 09:04:00 +0000 (UTC)
Subject: Re: [PATCH v2] fetch2/wget: Add user_agent parameter so it can be used optionally
To: bitbake-devel@lists.openembedded.org
From: "Livius" <egyszeregy@freemail.hu>
X-Originating-Location: =?UTF-8?B?U3R1dHRnYXJ0LCBCYWRlbi1Xw7xydHRlbWJlcmcsIERF?= (194.39.218.22)
X-Originating-Platform: Windows Chrome 125
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 10 Jun 2024 02:03:59 -0700
References: <CANNYZj-viDOqH+GUsehwYukr0SKJsu8qwKbGyvEgmXW-ob4drQ@mail.gmail.com>
In-Reply-To: <CANNYZj-viDOqH+GUsehwYukr0SKJsu8qwKbGyvEgmXW-ob4drQ@mail.gmail.com>
Message-ID: <24273.1718010239225296120@lists.openembedded.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Jun 2024 09:04:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16338

Yes FETCHCMD_wget can solve it, but it is a workaround and not a nice solut=
ion. Moreover need many experiences for it to understand where and how need=
 to be used, it is not optimal for Yocto end-users, also there will be no a=
ny official documentation about that it is a recommended ugly solution solv=
e this issues in recipes. I can not believe this kind of "hacking" is the b=
est to use for long-term solution, this issue need to be solved even more i=
n many recipes in the future in my opinion (more and more HTTP servers are =
going be crazy in the future).

In your last commits regarding user-agent every info about this situation c=
an be found in your commit message.
https://github.com/openembedded/bitbake/commit/d6fa261a9603677f0b3abbd309c1=
ca6073b63f4c
Your patch was not ready to solve this in a good way, therefore it was reve=
rted because Jfrog Artifactory does not like it if wget use a browser user-=
agent, so it must be not a hardcoded wget downloading mode.
https://github.com/openembedded/bitbake/commit/feef5cd12e877f42ffcace168d44=
b0e6eb80a907

I also run in to this same issue, because dear AMD changed there HTTP serve=
rs to be stupid with wget (it is now affected in all old Yocto releases as =
well, thanks AMD).
https://support.xilinx.com/s/question/0D54U00008RolRMSAZ/yocto-metaxilinxco=
re-cannot-find-pmuromnative-url?language=3Den_US

Nobody from us can solve the server issues, not I am and not You are the se=
rver maintainers of this big tech companies, they will never take care abou=
t this Yocto issue, i think. So it means a nice and easy solution need to b=
e provided by the Yocto project/bitbake about this issues.

It is clear for me there are some random HTTP server hoster which does not =
like wget downloading and must be used some fake browser user-agent for the=
m and unfortunately there are other server hoster which do the opposite iss=
ue, when a browser user-agent can require an interactive browser for downlo=
ad (wget can not do it).

So my opinion, user-agent must be an enable/disable parameter for wget fetc=
her. It will helps for recipe maintainers to use it if need. Default "Mozil=
la/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0" =
user-agent in BB_USER_AGENT will be fine for 99% if need to use it, but als=
o it is easily changeable in a recipe file if maintainer found out there ne=
ed to be use any other user-agent for a specific HTTP host server/URL.

