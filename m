Return-Path: <maksym.iliev@litmus.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F2EC433F5
	for <webhook@archiver.kernel.org>; Fri,  1 Apr 2022 14:35:43 +0000 (UTC)
Subject: Re: Bitbake fails to find a file in SSTATE_MIRROR even though it
 exists
To: bitbake-devel@lists.openembedded.org
From: "Maksym Iliev" <maksym.iliev@litmus.io>
X-Originating-Location: Scarborough, Ontario, CA (66.22.163.164)
X-Originating-Platform: Windows Chrome 99
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 01 Apr 2022 07:35:42 -0700
References: 
 <CAMKF1so0n--D2TAWXwEe7ZD0hOXD3L9hffhgkVSueAc78cWDoQ@mail.gmail.com>
In-Reply-To: 
 <CAMKF1so0n--D2TAWXwEe7ZD0hOXD3L9hffhgkVSueAc78cWDoQ@mail.gmail.com>
Message-ID: <20180.1648823742775060138@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="dtznsP4jmj2P0pkPFmb7"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Apr 2022 14:35:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13565

--dtznsP4jmj2P0pkPFmb7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

My mistake. Please find the sstate mirror config below:

SSTATE_MIRRORS ?=3D "\
file://.* ://sstate-cache.s3.amazonaws.com/PATH"

--dtznsP4jmj2P0pkPFmb7
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>My mistake. Please find the sstate mirror config below:</p>
<div style=3D"color: #d4d4d4; background-color: #1e1e1e; font-family: Conso=
las, 'Courier New', monospace; line-height: 19px; white-space: pre;">
<div><span style=3D"color: #9cdcfe;">SSTATE_MIRRORS</span> ?=3D <span style=
=3D"color: #ce9178;">"\</span></div>
<div><span style=3D"color: #ce9178;">file://.* ://sstate-cache.s3.amazonaws=
.com/PATH"</span></div>
</div>

--dtznsP4jmj2P0pkPFmb7--

