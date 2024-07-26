Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8E6C3DA4A
	for <webhook@archiver.kernel.org>; Fri, 26 Jul 2024 18:09:17 +0000 (UTC)
Subject: Re: noexec varflag behavior vs documentation?
To: bitbake-devel@lists.openembedded.org
From: "Livius" <egyszeregy@freemail.hu>
X-Originating-Location: =?UTF-8?B?U3R1dHRnYXJ0LCBCYWRlbi1Xw7xydHRlbWJlcmcsIERF?= (194.39.218.22)
X-Originating-Platform: Windows Chrome 126
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 26 Jul 2024 11:09:13 -0700
References: <20211027095311.yy3gr5uc7fwhkui4@fedora>
In-Reply-To: <20211027095311.yy3gr5uc7fwhkui4@fedora>
Message-ID: <11151.1722017353364628651@lists.openembedded.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Jul 2024 18:09:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16438

What about with this bug or improvement? I like to use the following syntax=
 in my custom recipe but when noexec flag got "0", the task is still in ina=
ctive state and not starting to run.

do_copy_scripts[noexec] =3D "${@'0' if (d.getVar('INITRAMFS_IMAGE_BUNDLE') =
=3D=3D '1') else '1'}"

