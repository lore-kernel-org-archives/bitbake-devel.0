Return-Path: <yosuke.nky@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D888C4167B
	for <webhook@archiver.kernel.org>; Mon, 19 Dec 2022 13:48:36 +0000 (UTC)
Subject: Re: [PATCH] Enable to use some bitbake server commands
To: bitbake-devel@lists.openembedded.org
From: yosuke.nky@gmail.com
X-Originating-Location: Tokyo, JP (160.237.142.147)
X-Originating-Platform: Linux Chrome 107
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 19 Dec 2022 05:48:33 -0800
References: <64b26408f1b87a4b8e58268cb9529e0952c30582.camel@linuxfoundation.org>
In-Reply-To: <64b26408f1b87a4b8e58268cb9529e0952c30582.camel@linuxfoundation.org>
Message-ID: <27383.1671457713988336797@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="25K33fAipqlyTcMTqDa2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Dec 2022 13:48:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14201

--25K33fAipqlyTcMTqDa2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> It looks like we may just be able to add a dict() wrapper around the retu=
rn values if these are all defaultdict objects?
Sorry, I forgot that some commands return " collections.abc.KeysView ". The=
refore, enable_marshel function in my patch is trying to cast list and dict=
.
For instance,=C2=A0dataStoreConnectorCmd returns " collections.abc.KeysView=
 " when subcommand is "keys".
However, dataStoreConnectorCmd has so many subcommands that we have not bee=
n able to verify the return types of all of them.
Perhaps we should consider removing dataStoreConnectorCmd from the scope of=
 this patch, as we will look into how to fix it properly later.

To make matters easier to understand, I created gits file for reproducing t=
he error with tinfoil, not with my private work.
https://gist.github.com/AngryMane/9e0f57dac862b209ae406a729c4fa4e5
You can reproduce the error by following below steps.
1.=C2=A0bitbake-error in my gist and copy it to bitbake/bin
1. source oe-init-build env
1. bitbake --server-only --bind localhost:8081
1.bitbake-error

Please note that this error occurs with only XMLRPCserver and ProcessServer=
 doen't occur this error.
In other words, the problem does not occur except in use cases where the bi=
tbake --server-only option is used.

--25K33fAipqlyTcMTqDa2
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<span style=3D"white-space: pre-wrap;">&gt; It looks like we may just be ab=
le to add a dict() wrapper around the </span><span style=3D"white-space: pr=
e-wrap;">return values if these are all defaultdict objects?<br /></span>So=
rry, I forgot that some commands return "<span style=3D"color: #6e7781; fon=
t-family: ui-monospace, SFMono-Regular, 'SF Mono', Menlo, Consolas, 'Libera=
tion Mono', monospace; font-size: 12px; white-space: pre;">collections.abc.=
KeysView</span>". Therefore,&nbsp;<span style=3D"white-space: pre-wrap;">en=
able_marshel function in </span>my patch is trying to cast list and dict.&n=
bsp; &nbsp;<br />For instance,&nbsp;dataStoreConnectorCmd returns "<span st=
yle=3D"color: #6e7781; font-family: ui-monospace, SFMono-Regular, 'SF Mono'=
, Menlo, Consolas, 'Liberation Mono', monospace; font-size: 12px; white-spa=
ce: pre;">collections.abc.KeysView</span>" when subcommand is "keys".&nbsp;=
 &nbsp;<br />However, dataStoreConnectorCmd has so many subcommands that we=
 have not been able to verify the return types of all of them.<br />Perhaps=
 we should consider removing dataStoreConnectorCmd from the scope of this p=
atch, as we will look into how to fix it properly later.<br /><br />To make=
 matters easier to understand, I created gits file for reproducing the erro=
r with tinfoil, not with my private work.<br /><a href=3D"https://gist.gith=
ub.com/AngryMane/9e0f57dac862b209ae406a729c4fa4e5" target=3D"_blank" rel=3D=
"noopener">https://gist.github.com/AngryMane/9e0f57dac862b209ae406a729c4fa4=
e5</a><br />You can reproduce the error by following below steps.<br />1.&n=
bsp;bitbake-error in my gist and copy it to bitbake/bin<br />1. source oe-i=
nit-build env<br />1.&nbsp;<span style=3D"color: #24292f; font-family: ui-m=
onospace, SFMono-Regular, 'SF Mono', Menlo, Consolas, 'Liberation Mono', mo=
nospace; font-size: 12px; white-space: pre;">bitbake --server-only --bind l=
ocalhost:8081<br />1.bitbake-error</span><br /><br />Please note that this =
error occurs with only XMLRPCserver and ProcessServer doen't occur this err=
or.<br />In other words, the problem does not occur except in use cases whe=
re the bitbake --server-only option is used.

--25K33fAipqlyTcMTqDa2--

