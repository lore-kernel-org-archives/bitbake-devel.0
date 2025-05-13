Return-Path: <niqingliang2003@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE236C3ABC3
	for <webhook@archiver.kernel.org>; Tue, 13 May 2025 01:02:38 +0000 (UTC)
Subject: Re: [PATCH 0/1] fetch2/git: Use basename for gitsrcname when ud.proto is file
To: bitbake-devel@lists.openembedded.org
From: "Yi Qingliang" <niqingliang2003@gmail.com>
X-Originating-Location: CN (180.111.240.140)
X-Originating-Platform: Linux Chrome 135
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 12 May 2025 18:02:30 -0700
References: <13242.1747097291536868429@lists.openembedded.org>
In-Reply-To: <13242.1747097291536868429@lists.openembedded.org>
Message-ID: <13242.1747098150057047482@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="qFMmjJ0d5U92pE00cKvm"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 May 2025 01:02:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17604

--qFMmjJ0d5U92pE00cKvm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

indeed, what's I want is to compile program, which is expected running on O=
S with lower version glibc.
now, I'm using my older glibc to compile library, and use official latest o=
ne to compile my application,
the library can linked by user directly, at the same time the application i=
s provided to user with a full root file system (running with chroot).

I checked the static link glibc solution, which is not recommended.
and my library link to external 3rd binary library, so I can't use musl lib=
c solution.

for library:
now I have ported the 2.17 glibc to the latest bitbake/oe-core, static link=
ing gcc/c++ related library, dynamic linking glibc, to generate my library.

for application:
The Appimage looks like is too complicated, and need to check every so on a=
ll OS, to simplify it,
I selected chroot+root filesystem (with mounting some directory, dev, var, =
proc, ...) as solution for my application.

maybe there is a better solution?

--qFMmjJ0d5U92pE00cKvm
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>indeed, what's I want is to compile program, which is expected running=
 on OS with lower version glibc.<br />now, I'm using my older glibc to comp=
ile library, and use official latest one to compile my application,<br />th=
e library can linked by user directly, at the same time the application is =
provided to user with a full root file system (running with chroot).<br /><=
br />I checked the static link glibc solution, which is not recommended.<br=
 />and my library link to external 3rd binary library, so I can't use musl =
libc solution.<br /><br />for library:<br />now I have ported the 2.17 glib=
c to the latest bitbake/oe-core, static linking gcc/c++ related library, dy=
namic linking glibc, to generate my library.<br /><br />for application:<br=
 />The Appimage looks like is too complicated, and need to check every so o=
n all OS, to simplify it,<br />I selected chroot+root filesystem (with moun=
ting some directory, dev, var, proc, ...) as solution for my application.<b=
r /><br />maybe there is a better solution?</div>

--qFMmjJ0d5U92pE00cKvm--

