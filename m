Return-Path: <mleonhardt@arri.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02556C433EF
	for <webhook@archiver.kernel.org>; Sun, 31 Oct 2021 20:11:52 +0000 (UTC)
Subject: Re: [PATCH] Raise when filename of lockfile is too long to avoid
 infinite loop
To: bitbake-devel@lists.openembedded.org
From: "Manuel Leonhardt" <mleonhardt@arri.de>
X-Originating-Location: Munich, Bavaria, DE (88.217.121.203)
X-Originating-Platform: Mac Firefox 93
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sun, 31 Oct 2021 13:11:52 -0700
References: <20211031195938.79586-1-mleonhardt@arri.de>
In-Reply-To: <20211031195938.79586-1-mleonhardt@arri.de>
Message-ID: <16473.1635711112015154424@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0THFScGMqPTfIedVXcT3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 Oct 2021 20:11:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12851

--0THFScGMqPTfIedVXcT3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This will only fix the error handling with long filenames. However, future =
changes might consider changing the control flow here, i.e., fail on all OS=
Errors except for those cases intended for the mode of operation.

See also https://lists.openembedded.org/g/openembedded-core/message/157691,=
 where generate_sstatefn in sstate.bbclass is adapted to consider the .lock=
 suffix when shorten filenames.

--0THFScGMqPTfIedVXcT3
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This will only fix the error handling with long filenames. However, future =
changes might consider changing the control flow here, i.e., fail on all OS=
Errors except for those cases intended for the mode of operation.<br /><br =
/>See also <a href=3D"https://lists.openembedded.org/g/openembedded-core/me=
ssage/157691," target=3D"_blank" rel=3D"noopener">https://lists.openembedde=
d.org/g/openembedded-core/message/157691,</a> where generate_sstatefn in ss=
tate.bbclass is adapted to consider the .lock suffix when shorten filenames=
.

--0THFScGMqPTfIedVXcT3--

