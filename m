Return-Path: <niqingliang2003@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC539C3ABC3
	for <webhook@archiver.kernel.org>; Tue, 13 May 2025 00:48:18 +0000 (UTC)
Subject: Re: [PATCH 0/1] fetch2/git: Use basename for gitsrcname when ud.proto is file
To: bitbake-devel@lists.openembedded.org
From: "Yi Qingliang" <niqingliang2003@gmail.com>
X-Originating-Location: CN (180.111.240.140)
X-Originating-Platform: Linux Chrome 135
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 12 May 2025 17:48:11 -0700
References: <13242.1747096905485013812@lists.openembedded.org>
In-Reply-To: <13242.1747096905485013812@lists.openembedded.org>
Message-ID: <13242.1747097291536868429@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="nslR8mIiq4YicfPtzocc"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 May 2025 00:48:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17603

--nslR8mIiq4YicfPtzocc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Tthe patch Robert provided not work, shallow file's name changed to gitshal=
low_glibc.git_0557361-1_release.2.17.master.tar.gz , which still result unp=
acking error.

no bare repo, and shallow file's name is not expected (no sourceware.org).

--nslR8mIiq4YicfPtzocc
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Tthe patch Robert provided not work, shallow file's name changed to <s=
pan style=3D"color: #dbdde1; font-family: system-ui, 'Segoe UI', Roboto, 'H=
elvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple C=
olor Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; font-=
size: 16px; font-style: normal; font-variant-ligatures: normal; font-varian=
t-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-=
align: start; text-indent: 0px; text-transform: none; widows: 2; word-spaci=
ng: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-co=
lor: #252728; text-decoration-thickness: initial; text-decoration-style: in=
itial; text-decoration-color: initial; display: inline !important; float: n=
one;">gitshallow_glibc.git_0557361-1_release.2.17.master.tar.gz</span>, whi=
ch still result unpacking error.<br /><br />no bare repo, and shallow file'=
s name is not expected (no sourceware.org).</div>

--nslR8mIiq4YicfPtzocc--

