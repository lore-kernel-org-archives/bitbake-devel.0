Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA6AC0218C
	for <webhook@archiver.kernel.org>; Sat, 25 Jan 2025 11:35:05 +0000 (UTC)
Subject: Re: [PATCH v2 0/4] bitbake: knotty/progressbar: Optimize footer update and prints.
To: bitbake-devel@lists.openembedded.org
From: "Livius" <egyszeregy@freemail.hu>
X-Originating-Location: =?UTF-8?B?RmVneXZlcm5laywgSsOhc3otTmFneWt1bi1Tem9sbm9rLCBIVQ==?= (178.48.208.49)
X-Originating-Platform: Windows Chrome 132
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sat, 25 Jan 2025 03:35:01 -0800
References: <4c4373f1f496cf2cf3cba8f1716fef7b21871d4f.camel@linuxfoundation.org>
In-Reply-To: <4c4373f1f496cf2cf3cba8f1716fef7b21871d4f.camel@linuxfoundation.org>
Message-ID: <6995.1737804901994832161@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="EP0LMbGy0N3IOIwwq9xt"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Jan 2025 11:35:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17081

--EP0LMbGy0N3IOIwwq9xt
Content-Type: text/plain; charset="utf-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

Performance improvement is quite trivial that will happen. Not allowed to w=
rite to stdout or any unbuffered file while the code is running inside a lo=
op in any script language or programming language.

I started to look for the performance issues because my Yocto projects star=
ted to build slowly from scarthgap release in any physical machines (only i=
n a virtual machine it can run fast yet).
https://lists.openembedded.org/g/bitbake-devel/topic/109854844

Yesterday, I found the bug which releated to bitbake Event logger (workarou=
nd to disable it). Soon I will send a Patch v3 for footer update, but not t=
his was the root cause, i will also send a patch for fix even logger class =
logging which has the real critical problem.

--EP0LMbGy0N3IOIwwq9xt
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Performance improvement is quite trivial that will happen. Not allowed t=
o write to stdout or any unbuffered file while the code is running inside a=
 loop in any script language or programming language.</p>

<p>I started to look for the performance issues because my Yocto projects s=
tarted to build slowly from scarthgap release in any physical machines (onl=
y in a virtual machine it can run fast yet).
<a href=3D"https://lists.openembedded.org/g/bitbake-devel/topic/109854844" =
target=3D"_blank">https://lists.openembedded.org/g/bitbake-devel/topic/1098=
54844</a></p>

<p>Yesterday, I found the bug which releated to bitbake Event logger (worka=
round to disable it). Soon I will send a Patch v3 for footer update, but no=
t this was the root cause, i will also send a patch for fix even logger cla=
ss logging which has the real critical problem.</p>

--EP0LMbGy0N3IOIwwq9xt--

