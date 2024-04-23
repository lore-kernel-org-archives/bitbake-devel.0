Return-Path: <technophil98@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB72FC4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 13:51:32 +0000 (UTC)
Subject: Re: [PATCH] bitbake: fetch2/git: Escape parentheses in git src name
To: bitbake-devel@lists.openembedded.org
From: "Philippe Rivest" <technophil98@gmail.com>
X-Originating-Location: Montreal, Quebec, CA (68.67.62.2)
X-Originating-Platform: Windows Firefox 124
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 23 Apr 2024 06:51:30 -0700
References: <638cc02f-c0b8-42e5-9ee6-81114812427e@myneves.com>
In-Reply-To: <638cc02f-c0b8-42e5-9ee6-81114812427e@myneves.com>
Message-ID: <14877.1713880290929319572@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="HC90XwPOB1EKrZros5gm"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Apr 2024 13:51:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16133

--HC90XwPOB1EKrZros5gm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I considered quoting the clone directory. However, since the base implement=
ation used replace calls, I followed suit.
Whenever there was a parenthesis in the repo name, the clone would fail wit=
h the original implementation.
There should not be any side effects: no released version of Bitbake/git fe=
tcher has support for parentheses in
in the repo name.

I agree that a replacement list/map is a more scalable solution, but might =
come with a higher risk of side effects.
The same can be said for quoting the clone directory. Adding replace calls =
was a simple fix to a simple and narrow problem.

--HC90XwPOB1EKrZros5gm
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I considered quoting the clone directory. However, since the base implement=
ation used replace calls, I followed suit.<br />Whenever there was a parent=
hesis in the repo name, the clone would fail with the original implementati=
on. <br />There should not be any side effects: no released version of Bitb=
ake/git fetcher has support for parentheses in<br />in the repo name.<br />=
<br />I agree that a replacement list/map is a more scalable solution, but =
might come with a higher risk of side effects.<br />The same can be said fo=
r quoting the clone directory. Adding replace calls was a simple fix to a s=
imple and narrow problem.

--HC90XwPOB1EKrZros5gm--

