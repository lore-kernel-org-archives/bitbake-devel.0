Return-Path: <sven.schwermer@disruptive-technologies.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C6C27C50
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 12:26:10 +0000 (UTC)
Subject: Re: Pseudo errors in lib/bb/__pycache__ #bitbake
To: bitbake-devel@lists.openembedded.org
From: "Sven" <sven.schwermer@disruptive-technologies.com>
X-Originating-Location: Asker, Viken, NO (84.213.213.125)
X-Originating-Platform: Linux Chrome 125
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 04 Jun 2024 05:26:02 -0700
References: <42a3baed1928bf8e4d5fd06507928a2b666fc430.camel@linuxfoundation.org>
In-Reply-To: <42a3baed1928bf8e4d5fd06507928a2b666fc430.camel@linuxfoundation.org>
Message-ID: <21188.1717503962964097679@lists.openembedded.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Jun 2024 12:26:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16314

Richard, your explanation helped me find the issue: I had deleted files in =
__pycache__ between builds. Apparently, those files had been created while =
in the pseudo environment.

Thank you very much!

Sven

