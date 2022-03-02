Return-Path: <stefnexter@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6BEC433F5
	for <webhook@archiver.kernel.org>; Wed,  2 Mar 2022 15:47:13 +0000 (UTC)
Subject: access to bitbake arguments 
To: bitbake-devel@lists.openembedded.org
From: stefnexter@gmail.com
X-Originating-Location: Spanga, Stockholm County, SE (81.170.142.70)
X-Originating-Platform: Windows Chrome 98
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 02 Mar 2022 07:47:12 -0800
Message-ID: <vWgJ.1646236032314957322.874H@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="MmKEx2NvPgudlizrGR8U"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Mar 2022 15:47:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13405

--MmKEx2NvPgudlizrGR8U
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I hope that this question is suitable for mailing list, if not please sugge=
st a more proper one.
We are using bitbake 1.44

is there a way to get the arguments bitbake were started with during parsin=
g of conf/bitbake.conf=C2=A0 ?

In 1.17 using python sys.argv=C2=A0 worked but with 1.44 I see that the con=
fig file is parsed several times, the last time there is no argument other =
than "decafbad"

//Stef

--MmKEx2NvPgudlizrGR8U
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,<br /><br />I hope that this question is suitable for mailing list, if n=
ot please suggest a more proper one.<br />We are using bitbake 1.44<br /><b=
r />is there a way to get the arguments bitbake were started with during pa=
rsing of conf/bitbake.conf&nbsp; ?<br /><br />In 1.17 using python sys.argv=
&nbsp; worked but with 1.44 I see that the config file is parsed several ti=
mes, the last time there is no argument other than "decafbad"<br /><br />//=
Stef

--MmKEx2NvPgudlizrGR8U--

