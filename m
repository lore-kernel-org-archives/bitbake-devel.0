Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B52C5DF6D
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 12:49:58 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6159.1787143791732161433
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 05:49:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=rvvyKd8/;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e57a753f9so81153285a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 05:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787143791; cv=none;
        d=google.com; s=arc-20260327;
        b=ht+Ini9xF7XiU6uLognkYBlx4/jogBQH79QTMi2zgpcYU2emeNkFpqbxRJziPtjojK
         izKpVS0TxJ3U4rfZK+ZCes5vqhUpHQbuQl/VtD/NENgxF++cuBlpm2ePA6D3b9X77RuB
         NLTdAIBnfjjMA/3OUdk2qQPHeZ5Olr3w2VA+vjK+8EsgxW6Dq3gniu8xYyDo8OSTtq8n
         SGIbzED6Qyv1ERD7hcIP2nbGB4F2y8afpVAyJnZYQPOa1FOn/aPLaZkJXFTbMVrWlRlE
         j6yxKxjJmDGCSwYk55crYcSaDuQdtPLX6Q9ZJNKkb3yOPKLLHFa4lS6cvhu3KR6CXOeD
         SVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MK/dibKPDEbw13Rl6klA6Jsdv0iikrDtgweikGFnWyM=;
        fh=sZ+LizO92di32clJ5O4FZQSlrzEWq9dYqe6rVfGtX9Q=;
        b=cB25eOfgXJZuchif7QPTA5stzUF0/sjjWXfQwbhjQ13ZfGfq7posm8HWfGRrgn0T3U
         dW23oVHu7UzbbF8X/k/ltMzKXnfv8hjVFjEJRvwKc5FchalEbS+vHFrq1jTQ0IbUI7e/
         UAVqqGsAcXjf7tTsAEcUHaRqqZJqyrPNnJHHykXqClpM7mEsrhK+/CBixjLAdRoFzE9G
         Ej9U1xpJGrAGxiX5QeQT5O2j7FqM3HtTQNEUbOu2dDXmAQbftKjSMfDp/t6EdgMxFArG
         sv4Z4WVEFbvu5HpMEBMyvHufQ3jGx1qnanAkEoYDRpbgXcmbmcvcBXvncldGIIUmaBBw
         XvFQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787143791; x=1787748591; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MK/dibKPDEbw13Rl6klA6Jsdv0iikrDtgweikGFnWyM=;
        b=rvvyKd8/Jr/0lhiaZFZuOn1Saov58dr1BBiTDd3VRMZlDbMvac52VXYhAzUTcw6A8t
         5Qj51KnXwKjGOUEBY7r/m7uMOit5/U8Y2YVlPNug38z2a7luGv3xC8S+kYKHnzaYBsHd
         DU2S5ABeyxuY6rspJxJXP3v9LxsoAN7jmiTuCFBr0RsjOWOZUznFPTh0FLbjkJU4zykO
         QLhnn80o53Xor/LfmgG5C6SouoinFGxgp7gyEhe50uipiZ+NSDcjJTm1a2odZMRmOkTV
         e98n5K7f0Mf9bLOT1nGTDQDUWVoyYmMNJ/laig1xlJ9nCi0GM9wvxo7Pl/vE9cOVWxMS
         +e6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143791; x=1787748591;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MK/dibKPDEbw13Rl6klA6Jsdv0iikrDtgweikGFnWyM=;
        b=KRY47LpcJniJgsOjLTCb3PPWTKTIKe/ga8B/ci6QccXYLRYf7DpVrgK3hA0Bjbp8ve
         yn6iMgBTLkhbqeeTeepeDbfWCJDuin7AhuLLty7Crt9u9eDHhVc1s9zOrQvd1sVZaBPK
         gF3leYJxjdE04bmtwrERtxeqY+F+YhiMPBOE4xLgwn3aFef4SGk/cG3m8ZGKM0IjkHbC
         WKKmzzhnincJy2fvpq/tZ/1JRfROoQgfKAPA3Xpx7xsMW1wDGJ3mDS9EataF/aJ55c1C
         NHUEGbdbRiX1y0TQX1b0+y42bmaJNuh1AKDVhnp6FL99z5mXWwleK+9jtUg3fR1nMTk5
         9zTg==
X-Gm-Message-State: AOJu0YxyYKPpEn4CSCmFuEdoSp3wD3ZdRMEJjCVwSh8DIuByCGHhMnpE
	OiKh/S7wid8fSNvpo70GtUX5Z7JURF5MLbPFAO305p/P0fddWKYpO8LSFYQawuPJAxVLAB1funR
	5iWqnHV54Clt3U0RefuJOQ3KWVNW+qZg=
X-Gm-Gg: AR+sD10VU2xmEq/nnRQuc/klDi8ZzF267xc6d8A6bFNLQ/Q6vVpZrX5RaVKE5ei6nLg
	j609q+ZJxLAF8rSluh+DNyU5rGt93BPxGzJF/q9amnrA7IAB9Ss7aiLD5fAipbiLY2lhifth0OX
	EumFqw0vd4YRVA0ckGGZoskZseICkUPH+uc8bIckM6zIiLIQZkavqDtXELHxHd2F19cOCSLjFbl
	aJ0YHno2GkCPzG+ZVmSGElSmVfTDVPx2phsITwYgaCSGm4z1OX+hmiR2HHi7cI+F4puoyuJQbUH
	sd72mQGYu0m/ssAo6mV3sm+HAFC7x2yUmOki9N31uN/Nl956V0jD9nJTCrEMk4H0H4CQVepPOJH
	AK/fKAvgZd8vQfg==
X-Received: by 2002:a05:620a:458d:b0:92e:541e:632b with SMTP id
 af79cd13be357-9371e1f787fmr399148285a.2.1787143790467; Wed, 19 Aug 2026
 05:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260819042417.22411-1-giancarlo.cicellyn@gmail.com>
 <CANNYZj-FZ5trTVaP_nvZu+sAoEZ--0RZk_cDMUkK6jgrGobTdA@mail.gmail.com>
 <CAK46CgSuNHHqd8Nm_9KTEiiad1+4LoQB9sJ-5v89uhzjCcP8Bg@mail.gmail.com>
 <CANNYZj_v-WM7ZQOt+ytKGG2KxbE4w_Q9r_w1U1nJTLkfZLy_Ow@mail.gmail.com> <CAK46CgRZjY2XP9BtxSiWUhtYtdPF-1GiO3X7wN5R7rm3urUk3Q@mail.gmail.com>
In-Reply-To: <CAK46CgRZjY2XP9BtxSiWUhtYtdPF-1GiO3X7wN5R7rm3urUk3Q@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 19 Aug 2026 14:49:38 +0200
X-Gm-Features: AcwNN1Uu3SzHpDSj7So9VzrS7VGrVrNsm43ttFmysLCEDphNEX9_gkxOqofHDTc
Message-ID: <CANNYZj-rNiwKhLyF-UUd+Sif-aEj3YEn5nycSG_2hZwp=HZeYQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: preserve build config when
 init script is missing
To: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 12:49:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19999

On Wed, 19 Aug 2026 at 12:51, Giancarlo Cicellyn Comneno
<giancarlo.cicellyn@gmail.com> wrote:
> I understand that you personally expect review conversations to be
> written without AI assistance. That expectation was not clear to me
> before, but now it is. I accept that this is how you prefer to
> interact with contributors, even though for me using AI assistance is
> part of how I work and learn, and it saves time that I can spend on
> the technical work itself and on the other projects I handle in
> parallel.

There's a growing community consensus about this: reviewers want to
talk with humans, and giving them AI generated replies is likely to
antagonize and frustrate them. It gets worse when people keep doing it
despite being asked to stop, and then get defensive about it.

E.g. Rust has already spelled it out clearly:
https://blog.rust-lang.org/inside-rust/2026/08/05/rust-langrust-is-adopting-an-llm-policy/#mechanically-copy-pasting-llm-output-is-a-waste-of-time

They say:
===
We will often get people who respond to review comments by
copy-pasting them into their LLM, then copy-pasting its response back
onto GitHub. Bluntly: this is a waste of everyone's time. If we wanted
an LLM's opinion, we could have asked it ourselves. We want to hear
your thoughts, not a machine's.

Moreover, this is a breach of trust between the reviewer and the
author. Our assumption when we review is that we're talking to a real
person who wants to do their best work. Pasting LLM text creates
suspicion: does the author actually care? Is there a person here at
all?
===

I have also written about this here, which touches on the reasons I
want interaction with humans:
https://www.linkedin.com/feed/update/urn:li:activity:7490778888923541504/

Do take your own reputation much more seriously than any possible time
savings (which often end up negated through actual human review and
having to manually establish and then rework AI mistakes or incorrect
assumptions).

Yocto is going to tweak the policy to more clearly say what is okay
and what isn't, the exact wording is under consideration:
https://lists.openembedded.org/g/openembedded-core/message/243686

> What I can tell you accurately is that the goal was to learn on the
> job by auditing `bitbake-setup`, looking for problematic or fragile
> failure paths, and trying to validate anything found with tests before
> proposing a fix. This patch came out of that process. It did not come
> from a real OE-Core incident or from a user bug report, and I already
> made that clear in my previous reply.

The patches would've been better received if this was done first:

- research whether the scenarios they fix are realistic *before*
submission. You are free to use AI any way you want in that activity.

- if that research was inconclusive, or you lack experience to make
that judgement, then mark the patches as RFC, and add your own
commentary to the commit messages: specifically that you have asked AI
to find problems, but you are not sure if the discovered problems are
real, and seek community feedback.

At the very least, this last bit should've been written in a response
to my question, by *you*.

Keep this in mind: you can't assume reviewers are compensated for
doing reviews, and all too often in open source they're not, or their
time is stretched extremely thin. For example, I'm not getting paid to
have this conversation. So any needed research needs to happen up
front, so that you don't end up asking me, or anyone, to explain
things for you, or prove to you that the patches aren't necessary.

> Is your technical objection that the source transition exercised by
> the test is outside the supported contract of `bitbake-setup`?
>
> Or is the concern instead that the transition is technically possible
> but too theoretical / unrealistic to justify an upstream patch?
>
> I am asking because those are two different conclusions, and I would
> genuinely like to learn which one applies here.

The questions to ask, as part of that upfront research I mentioned
above, is neither of these. It's "What are these files used for? How
likely are they to be removed?"

scripts/oe-setup-build is used to set up a bitbake build directory
from a configuration template in a layer. Oe-init-build-env is used to
set bitbake-specific variables in a unix environment so that bitbake
can find metadata and the bitbake build directory set up by
oe-setup-build, and then run actual yocto builds.

Both files are a core part of yocto workflows, they're standard,
documented, and especially oe-init-build-env is used by almost
everyone. So they will stay in oe-core repository until the end of
time; it's completely unrealistic to remove them from that repo.

> In any case, thank you for the time you have spent reviewing this. I
> am here primarily to learn by doing useful work, and I have no
> interest in defending a patch whose premise does not hold.

If you'd like to help, it's best to first establish what would be
helpful. Let me assure you: AI assisted bug hunting is not where help
would be most appreciated. Again, it's best to ask the community first
what you could do, given your level of experience and particular
interests and goals. Or read the weekly status emails such as one I
linked above, where the most pressing issues are highlighted.

Alex

