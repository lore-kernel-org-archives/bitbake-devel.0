Return-Path: <christian.schaefer@at.abb.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C5ECD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 15:33:15 +0000 (UTC)
Subject: Re: bitbake-setup: sync layers to branch HEAD
To: bitbake-devel@lists.openembedded.org
From: "Christian Schaefer" <christian.schaefer@at.abb.com>
X-Originating-Location: Munich, Bavaria, DE (147.161.168.111)
X-Originating-Platform: Windows Firefox 151
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 17 Jun 2026 08:33:07 -0700
References: <AM7PR06MB640717D4774F7C9F5CC36DACBDE42@AM7PR06MB6407.eurprd06.prod.outlook.com> <CANNYZj_nQiHUjVvips9+kn7XV1JZquZDJs-5RCZ6RpDAHgCYRw@mail.gmail.com>
In-Reply-To: <CANNYZj_nQiHUjVvips9+kn7XV1JZquZDJs-5RCZ6RpDAHgCYRw@mail.gmail.com>
Message-ID: <203383.1781710387657029391@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="ffP89LKmw8W7Qa9x3YK6"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 15:33:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19728

--ffP89LKmw8W7Qa9x3YK6
Content-Type: text/plain; charset="utf-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

Thanks for the hint. I found the error.

To test the ``update`` functionality originally, I additionally used ``--so=
urce-overrides`` to pin a certain lock file, which referenced (on purpose) =
an older commit in the oe-core wrynose branch.
Then, I assumed, by calling ``bitbake-setup update`` this would then sync t=
he layer to the latest upstream HEAD (fast-forward from the older commit to=
 the latest).
However, it seems that the ``bitbake-setup update`` does not work in that c=
ombination (if the revs are initially pinned). Which is fine for me.

Thanks for the fast help!

--ffP89LKmw8W7Qa9x3YK6
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Thanks for the hint. I found the error.</p>

<p>To test the <code>update</code> functionality originally, I additionally=
 used <code>--source-overrides</code> to pin a certain lock file, which ref=
erenced (on purpose) an older commit in the oe-core wrynose branch.
Then, I assumed, by calling <code>bitbake-setup update</code> this would th=
en sync the layer to the latest upstream HEAD (fast-forward from the older =
commit to the latest).
However, it seems that the <code>bitbake-setup update</code> does not work =
in that combination (if the revs are initially pinned). Which is fine for m=
e.</p>

<p>Thanks for the fast help!</p>

--ffP89LKmw8W7Qa9x3YK6--

