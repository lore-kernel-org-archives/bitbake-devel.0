Return-Path: <mlynch@hi-techniques.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E01CC25B7A
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 15:33:42 +0000 (UTC)
Subject: Re: Dependencies ?
To: bitbake-devel@lists.openembedded.org
From: "Michael Lynch" <mlynch@hi-techniques.com>
X-Originating-Location: Madison, Wisconsin, US (24.159.236.186)
X-Originating-Platform: Windows Chrome 94
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 24 May 2024 08:33:38 -0700
References: <CANNYZj_XF0cXbK-nVeK=xpd8_XC07j-FC8rovvips085M1OMHQ@mail.gmail.com>
In-Reply-To: <CANNYZj_XF0cXbK-nVeK=xpd8_XC07j-FC8rovvips085M1OMHQ@mail.gmail.com>
Message-ID: <18579.1716564818242640497@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="RshROnhA8zn7TFr7kJxr"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 15:33:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16263

--RshROnhA8zn7TFr7kJxr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

For informational purposes the two recipes in question here are intel-compu=
te-runtime and intel-graphics-compiler.=C2=A0 Both are items needed to use =
OpenCL with INTEL GPUs.

Alex, it sounds like the "wrong" thing to do is to "rollback" the meta-clan=
g layer back to the "mickledore" branch as was suggested?=C2=A0 Here's the =
weird thing, the layer compatibility for meta-clang in the "mickledore" bra=
nch actually lists "scarthgap" in addition to "mickeldore" and one other.=
=C2=A0 Where as layer compatibility of meta-clang in the "scarthgap" branch=
 is set to "scarthgap" only.=C2=A0 Did someone maybe do the wrong thing wit=
h layer compatibility in meta-clang on the mickledore branch?=C2=A0 Just cu=
rious because it seemed that mixing layer branches to make things build see=
med a bit off of the whole philosophy of how yocto/bitbake was intended to =
work but I thought maybe that was just me not understanding everything comp=
letely.

-- Mike

--RshROnhA8zn7TFr7kJxr
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

For informational purposes the two recipes in question here are <em>intel-c=
ompute-runtime</em> and<em> intel-graphics-compiler</em>.&nbsp; Both are it=
ems needed to use OpenCL with INTEL GPUs.<br /><br />Alex, it sounds like t=
he "wrong" thing to do is to "rollback" the meta-clang layer back to the "m=
ickledore" branch as was suggested?&nbsp; Here's the weird thing, the layer=
 compatibility for meta-clang in the "mickledore" branch actually lists "sc=
arthgap" in addition to "mickeldore" and one other.&nbsp; Where as layer co=
mpatibility of meta-clang in the "scarthgap" branch is set to "scarthgap" o=
nly.&nbsp; Did someone maybe do the wrong thing with layer compatibility in=
 meta-clang on the mickledore branch?&nbsp; Just curious because it seemed =
that mixing layer branches to make things build seemed a bit off of the who=
le philosophy of how yocto/bitbake was intended to work but I thought maybe=
 that was just me not understanding everything completely.<br /><br />-- Mi=
ke

--RshROnhA8zn7TFr7kJxr--

