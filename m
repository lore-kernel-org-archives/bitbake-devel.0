Return-Path: <giancarlo.cicellyn@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D01FC5DF86
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 13:05:28 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6495.1787144724825139381
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 06:05:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=pE/yri6X;
 spf=pass (domain: gmail.com, ip: 209.85.210.42, mailfrom: giancarlo.cicellyn@gmail.com)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso911796a34.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 06:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787144724; cv=none;
        d=google.com; s=arc-20260327;
        b=X1NEn4Bu4ElqwUl5QyV7Ts22MXse02qWxzmkO9/BjYykRtEPbOKnv+dK/p0dTwxs1g
         xbEDY8njeJA0a/H4IoxLqpY6JPhlIl0OIk+ODArJTkNxHdgRN4eV9ZqkQeOpUkoujmy5
         l6XN4JAX55i12csuiFzvuzMr4hL27DSL2mCPZei5ym6y5q4aYszska/6fq6TYvaWGNBZ
         9yLDLF4SwGH3hUOHFcYuQBHxlgyZw9oCqfAUt/oD5Fl1kKP+P+ujOmmlm028I5fLRGRq
         4Xu/pNX9fRljKAy7iOzujGdOz6Ldy/yFz9YDB0AR1HhOK0/cnGECrasQsyPn2qIG1Q9d
         6RXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=SHUj+h9s9HAefhEw7BJMK+IJJ6VNja7RgttQHQxCS00=;
        fh=Da0VcnEWTsEJFcxSqb8W58S9DB5DKFhcwZoV1ZLH5nU=;
        b=Bv7xbNQGbZp0AsLA4cLBm98MuP72q120+1XPIumZc1T2ndM3whqet5V0ZSzNZHpVOY
         +HvZgw3UgKVQhLTykezM5fuzz5n5oGZqXWcy0cblsy4ZETjljtw1ucG1pAQlJKCwPZ6U
         dSHJKCf/fKxkFLrnoaNOyOfxq/upRPgVanq7MaMZyrA0JUYAncyAinMtdmRnkGAMkrEx
         mA1Ynnn8R7vfRA7YU4kayBU90DLrCyQjRSzTL62F6l0tNb6WJ0lV/kDrGHwZkm5LL+b3
         2yBN5g4rUR8n4wTqjlvbtuIo1lAF1EH6357K6W7YBT0Wl0LH+dKfwnVE5O72S15qLPWM
         aPqg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787144724; x=1787749524; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SHUj+h9s9HAefhEw7BJMK+IJJ6VNja7RgttQHQxCS00=;
        b=pE/yri6X+0tDmdf0QU+B+OCDRt/q+V2tGAer6+97lnVKfEKkc0SBGszjWZv/WczUFc
         XbtMMz4SY1n/KsSeIUKFVJLB/1ga1+fAVOiJ0lhMeKox3nQIm9W5gRupUgogBd1gGNKg
         pvLaEs3IgkJ6MU3ayjROaNOr3hYTMkB2LOufdlLa0sHjgZ7hdWR4NSbJX/gVeuKQ2lMF
         +cxw/MOvmF3ge74ol98g+D2sNFfkMkSGzE9IGyRr3H0tpVGMkI4pTxyFBp9vJWK8W1zS
         G4lzD3YnF4okku99a2b5WA02Ob2Doz8AXj2/MMeREdLa8mGuzw6A8Xo3SfDhzBSX9KMI
         2ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144724; x=1787749524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SHUj+h9s9HAefhEw7BJMK+IJJ6VNja7RgttQHQxCS00=;
        b=AlIT97NMKEMOEQdWmuWhxCe0C4X09LhK31NHo2v/NfN+XetnvY9eriWrrGXi+d34c4
         Hcp3qCf2hvwDDGnjYvDxHyM0MamnVgHm74J22rQQbdAsjdfBIRKQ8VtSHBDyNYoPbKFQ
         wosdguLsANfcq9ZP/cUe8kIecHSJhVqkqZhLudR7m8Eor00UxeEOYkJVze8ekD7UPm5R
         Ygwj72TW4SOz2e9T04niRsWlrIpqb3aKbgMLoqFH1Cdu1XrYmC08T0U1ZuSShsxgj/zP
         7uwJy/lHxUjoQpzECBYsVI/R2d56HlIwJlJKLXkYfoZpzUCNmMRvj0WeEBEz9jdzMbCR
         yMLw==
X-Gm-Message-State: AOJu0YzWLXbXNtmGpZ+fHuGMPJ+r9/S63UEeQIBBaHczSFDu+p8kUzR3
	J6hWbeP3adH6KH5R8gs3iWN3ZY1+5Cb7YLZsKGG8YVeuiF3tMTijRmg9EBaInwvcBxyHA3Hpxm4
	X6qLudNUKsLje8SaOFh+d8IL39IguE1HVwQ==
X-Gm-Gg: AR+sD13b93JBalwDd2//d6rcwbOxWDdTL7Yc9LEkaRtRwT+KRZdj5obNang7L4Otrns
	bAwSYoankdxhLxzaAZz4F1JGsWzAoXIABemQmYU/rHx2mscj+kcvQCOm8XMP+/LyivLLQzGFiwD
	lIGGP1rQ7UzUaKkH1NDBpxocrMpbq0VucMllcD6aiGhuUNBcU8iCYXNPMDXcvtdigsSbKKv5hIP
	p1Fh21Fk0aUBjTLSLutGClcRIK+ZP5ZikklZibaVqjnEA02X5TRSBil9qN5Ee4cUmyOTHXabQKP
	apSYjIHzQ5QDcuPW1I227NygLZlmpVCxZZCsU8JBjM56KOeqDRxah39tKVip4lBC5yfbd8+gLIk
	J9IcwyETUMIgEZB6UzwHCzECAdvThRjQ6t02iqNaWhaLN8EAal4EVGJRqciOhV3aN6K/Hx040BE
	5STd7leEUO2U/X6rMx1vlxsTyopEXnbQDzNQRbvA==
X-Received: by 2002:a05:6830:6add:b0:7f3:daf9:eda3 with SMTP id
 46e09a7af769-7f43e2cc101mr4213152a34.4.1787144723838; Wed, 19 Aug 2026
 06:05:23 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 19 Aug 2026 13:05:21 +0000
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 19 Aug 2026 13:05:21 +0000
In-Reply-To: <CANNYZj-rNiwKhLyF-UUd+Sif-aEj3YEn5nycSG_2hZwp=HZeYQ@mail.gmail.com>
References: <20260819042417.22411-1-giancarlo.cicellyn@gmail.com>
 <CANNYZj-FZ5trTVaP_nvZu+sAoEZ--0RZk_cDMUkK6jgrGobTdA@mail.gmail.com>
 <CAK46CgSuNHHqd8Nm_9KTEiiad1+4LoQB9sJ-5v89uhzjCcP8Bg@mail.gmail.com>
 <CANNYZj_v-WM7ZQOt+ytKGG2KxbE4w_Q9r_w1U1nJTLkfZLy_Ow@mail.gmail.com>
 <CAK46CgRZjY2XP9BtxSiWUhtYtdPF-1GiO3X7wN5R7rm3urUk3Q@mail.gmail.com> <CANNYZj-rNiwKhLyF-UUd+Sif-aEj3YEn5nycSG_2hZwp=HZeYQ@mail.gmail.com>
MIME-Version: 1.0
From: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
Date: Wed, 19 Aug 2026 13:05:21 +0000
X-Gm-Features: AcwNN1VPhkZ77zkhiJimSgvDqJ3WHl5iWNQ4tigpsHPHUyq7JMihT1sOzqaQfdo
Message-ID: <CAK46CgQW2qHx++L+mVxwPgcyjoapS4QAaY-Uc3cq_Sb_+VXNBw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: preserve build config when
 init script is missing
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 13:05:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20000

It has become fairly clear that we have incompatible views on what
constitutes acceptable use of AI. For that reason, thank you for the
discussion, but I=E2=80=99d prefer to move on.

On Wed, 19 Aug 2026 14:49:38 +0200, Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
> On Wed, 19 Aug 2026 at 12:51, Giancarlo Cicellyn Comneno
> <giancarlo.cicellyn@gmail.com> wrote:
> > I understand that you personally expect review conversations to be
> > written without AI assistance. That expectation was not clear to me
> > before, but now it is. I accept that this is how you prefer to
> > interact with contributors, even though for me using AI assistance is
> > part of how I work and learn, and it saves time that I can spend on
> > the technical work itself and on the other projects I handle in
> > parallel.
>
> There's a growing community consensus about this: reviewers want to
> talk with humans, and giving them AI generated replies is likely to
> antagonize and frustrate them. It gets worse when people keep doing it
> despite being asked to stop, and then get defensive about it.
>
> E.g. Rust has already spelled it out clearly:
> https://blog.rust-lang.org/inside-rust/2026/08/05/rust-langrust-is-adopti=
ng-an-llm-policy/#mechanically-copy-pasting-llm-output-is-a-waste-of-time
>
> They say:
> =3D=3D=3D
> We will often get people who respond to review comments by
> copy-pasting them into their LLM, then copy-pasting its response back
> onto GitHub. Bluntly: this is a waste of everyone's time. If we wanted
> an LLM's opinion, we could have asked it ourselves. We want to hear
> your thoughts, not a machine's.
>
> Moreover, this is a breach of trust between the reviewer and the
> author. Our assumption when we review is that we're talking to a real
> person who wants to do their best work. Pasting LLM text creates
> suspicion: does the author actually care? Is there a person here at
> all?
> =3D=3D=3D
>
> I have also written about this here, which touches on the reasons I
> want interaction with humans:
> https://www.linkedin.com/feed/update/urn:li:activity:7490778888923541504/
>
> Do take your own reputation much more seriously than any possible time
> savings (which often end up negated through actual human review and
> having to manually establish and then rework AI mistakes or incorrect
> assumptions).
>
> Yocto is going to tweak the policy to more clearly say what is okay
> and what isn't, the exact wording is under consideration:
> https://lists.openembedded.org/g/openembedded-core/message/243686
>
> > What I can tell you accurately is that the goal was to learn on the
> > job by auditing `bitbake-setup`, looking for problematic or fragile
> > failure paths, and trying to validate anything found with tests before
> > proposing a fix. This patch came out of that process. It did not come
> > from a real OE-Core incident or from a user bug report, and I already
> > made that clear in my previous reply.
>
> The patches would've been better received if this was done first:
>
> - research whether the scenarios they fix are realistic *before*
> submission. You are free to use AI any way you want in that activity.
>
> - if that research was inconclusive, or you lack experience to make
> that judgement, then mark the patches as RFC, and add your own
> commentary to the commit messages: specifically that you have asked AI
> to find problems, but you are not sure if the discovered problems are
> real, and seek community feedback.
>
> At the very least, this last bit should've been written in a response
> to my question, by *you*.
>
> Keep this in mind: you can't assume reviewers are compensated for
> doing reviews, and all too often in open source they're not, or their
> time is stretched extremely thin. For example, I'm not getting paid to
> have this conversation. So any needed research needs to happen up
> front, so that you don't end up asking me, or anyone, to explain
> things for you, or prove to you that the patches aren't necessary.
>
> > Is your technical objection that the source transition exercised by
> > the test is outside the supported contract of `bitbake-setup`?
> >
> > Or is the concern instead that the transition is technically possible
> > but too theoretical / unrealistic to justify an upstream patch?
> >
> > I am asking because those are two different conclusions, and I would
> > genuinely like to learn which one applies here.
>
> The questions to ask, as part of that upfront research I mentioned
> above, is neither of these. It's "What are these files used for? How
> likely are they to be removed?"
>
> scripts/oe-setup-build is used to set up a bitbake build directory
> from a configuration template in a layer. Oe-init-build-env is used to
> set bitbake-specific variables in a unix environment so that bitbake
> can find metadata and the bitbake build directory set up by
> oe-setup-build, and then run actual yocto builds.
>
> Both files are a core part of yocto workflows, they're standard,
> documented, and especially oe-init-build-env is used by almost
> everyone. So they will stay in oe-core repository until the end of
> time; it's completely unrealistic to remove them from that repo.
>
> > In any case, thank you for the time you have spent reviewing this. I
> > am here primarily to learn by doing useful work, and I have no
> > interest in defending a patch whose premise does not hold.
>
> If you'd like to help, it's best to first establish what would be
> helpful. Let me assure you: AI assisted bug hunting is not where help
> would be most appreciated. Again, it's best to ask the community first
> what you could do, given your level of experience and particular
> interests and goals. Or read the weekly status emails such as one I
> linked above, where the most pressing issues are highlighted.
>
> Alex

