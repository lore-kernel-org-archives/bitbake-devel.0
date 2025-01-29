Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49FDC0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 16:52:27 +0000 (UTC)
Subject: Re: [scarthgap] bitbake extremely slow down during "Initialising tasks" #bitbake #scarthgap
To: bitbake-devel@lists.openembedded.org
From: "Livius" <egyszeregy@freemail.hu>
X-Originating-Location: =?UTF-8?B?U3R1dHRnYXJ0LCBCYWRlbi1Xw7xydHRlbWJlcmcsIERF?= (194.39.218.22)
X-Originating-Platform: Windows Chrome 132
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 29 Jan 2025 08:52:22 -0800
References: <29326.1736976169205415623@lists.openembedded.org>
In-Reply-To: <29326.1736976169205415623@lists.openembedded.org>
Message-ID: <17310.1738169542896951631@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="ofdyO4oZiAu2FhDWAflY"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 16:52:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17117

--ofdyO4oZiAu2FhDWAflY
Content-Type: text/plain; charset="utf-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

Issue was solved with the following patch: https://lists.openembedded.org/g=
/bitbake-devel/topic/patch_bitbake_cooker_fix/110805862

Or need to disable Event log by using `BB_DEFAULT_EVENTLOG =3D ""` in `loca=
l.conf` file.

--ofdyO4oZiAu2FhDWAflY
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Issue was solved with the following patch: <a href=3D"https://lists.open=
embedded.org/g/bitbake-devel/topic/patch_bitbake_cooker_fix/110805862" targ=
et=3D"_blank">https://lists.openembedded.org/g/bitbake-devel/topic/patch_bi=
tbake_cooker_fix/110805862</a></p>

<p>Or need to disable Event log by using <code>BB_DEFAULT_EVENTLOG =3D &quo=
t;&quot;</code> in <code>local.conf</code> file.</p>

--ofdyO4oZiAu2FhDWAflY--

