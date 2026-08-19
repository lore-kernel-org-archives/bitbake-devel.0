Return-Path: <giancarlo.cicellyn@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E1BC5DF87
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 13:05:38 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6438.1787144733506604969
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 06:05:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=EcwU8uYy;
 spf=pass (domain: gmail.com, ip: 209.85.210.41, mailfrom: giancarlo.cicellyn@gmail.com)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb63dbd229so636193a34.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 06:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787144733; cv=none;
        d=google.com; s=arc-20260327;
        b=m3rqV8Wcv8t8EEXkgWxSRVi7oEupCAeKszemDsUGDj6qC4559NQdiIhZhQ7A15eFXZ
         n9Hr+X3xaylPe69kpBbcUvzT4vZLHd2f6pWIOjFoKeQAHIWndwEj6EK4c9DC6e6JKcgm
         b79MI82Y3fg/hJV9w+rfpktEDPi2kWc6Kczyvo5YkqiKSPH+l2TX4+BEMrrrfC66oCgE
         TFcoV96u3dLxqcXhLDSz2rWyIFR4SZUsqs6XMqKqox/Wnk5w+To6j9u6z3fW7ngu1TUD
         NR/a9Ci5J1ZvnwMejjMeYn4L60hzEyNWzpxwr5yuQXuS1gs4IcsnIiThoE3N/SOagbli
         tIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=SHUj+h9s9HAefhEw7BJMK+IJJ6VNja7RgttQHQxCS00=;
        fh=Da0VcnEWTsEJFcxSqb8W58S9DB5DKFhcwZoV1ZLH5nU=;
        b=F/adW/8a8393YBknnRRuZ1EuIZegTTcy1aTrj/3NAeYgs8knI/Zio8goi8KEDFxYm5
         y+pX6gL3Wc9GaQtj57+9qFlI0eB5nA2RRt00d0km1lQcHG5ZvF2W6xMxd+MMrrynQfIb
         Pjz2OxhD/1/XcpnxTScYEn6BUtC11E+koJh/yfO8jsJCU3jFswl3ybM644FDA6eBQe1u
         eBQ4zlhHpSUAoFs6uZJ4cfrHzkFJ8tN2/4V6/l0vIIDQFvj9LbIn7m/CEQ26HxioyDvD
         JZbsCfnljK/5dfRX44q/qqgYiXq2s69dOyz/UQJkI/XBlLxlXWZI1XuVrhw/WyTIn9ZZ
         3UnQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787144733; x=1787749533; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SHUj+h9s9HAefhEw7BJMK+IJJ6VNja7RgttQHQxCS00=;
        b=EcwU8uYyiBYGHwJzZYllD9EwSSQ/bJ4ORX9h8bBZvPtDY9db1vqfCk8MlqEjSrbmIB
         pFJZE9seuJVH4QP+FvTrrIEGCyNlWqb8GKQC5uXUJGiJJ41uOrJdJ9wfAbCCnvxk2FGk
         J0OapxP324WPtX2cDGsDZZjkIpx0uCfCHH31JxuWqRJPG0jPTBfp4csbL49qd1xCvUXM
         sMWeDVuMHtJ34BejrfL9+cdfESMV+/2NxhZDk3HXKNOjRqtEwkqmZMZDeC6c95RqKaDI
         lNkQE48nYBHdX65G7eWtYbVlvQrYvvTmg35Msaxlyqs9R5zGA1tOuk+xXNEOgQJ89eGC
         Nh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144733; x=1787749533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SHUj+h9s9HAefhEw7BJMK+IJJ6VNja7RgttQHQxCS00=;
        b=Ccc63AXBYJL6w084XGO3hztl3qgr9qI8n4UoCum3GPGTIswKIADKin5Wzkzj48sYUh
         VtgFHuRjAc6KVMewXWxevf0DhqdjciWKPdU0pNDq2SVN+GkI5pmloMCYOdC9pEyKD1BM
         z6Pj0DjTW3Z5Cv28kRj0qrPFL6SjiFQSbHLMiiGBf6gc8l/8z3pl69jLJMp01/aBkJc1
         15BJdoO5xI3oFE/sBxdit0BIAh4Nr/pN+mTILeath7HSCY/CCk6XmIv5Pp7Ws9XLmw1q
         K9rOfpbZcTfZLAjn7TjLwXww8QGPICH7zpmtWQwyAzH4hQGMDHXo5iHBzAq2w5AGiACm
         hYOA==
X-Gm-Message-State: AOJu0Yyea+PvxbgINZGjBsfVGWeQDUpglYUN+FET74+qIJIUPOUNvDs5
	2oSz7HJ5XVj5H21j7mF9qQFkOocodcb0RIN/WZbuSwvsE2cARoxX8pvrL0GfaI1tZA62R2EPhck
	nmxDNT+YQU0g/HfGVe6/TRVGBHzNv0QEdYQ==
X-Gm-Gg: AR+sD10WXUbgoXXpeV3D1pnQ3zQjedFS1PKV7y0C1WosdGCRpfu4Cr91cilXTu2SLyr
	fvdEk01rLEr7W/LctQQmYWR0EHmLy1UjRa9iiwSg9JDkAhtPqtox7NUZDR1TJKCIJbCZdHOKq+D
	hin0qsJwJr2oQ2FWkFIolCVMgvFDG3ZZDOu1VTnw6p+ev6BJ9l8ww1HF9lJwY7csuVM6AxQyOty
	m9MEAclbg6dhLiIDVhmjDmABQKclEy9pQaCnRhY9XyuZ7aj6qicCIalRbdb13WcR/mscrtOzXNU
	P1nlMuK7w3X+m5bTna2I+GX5kCRvU9WqT0OdmnUM4ZxT19I4P9p6TXGe9zVKPxCCNlnPPF8m1De
	0p8zivfeyvsZuMHl/NuzgDLD0yxpw1epa8LMKigXaSoK2j7BQsSZ1jTykT78rdGK0RiKozP19BB
	1hBiuoJrzkJAPsUsE9rzYPLg+hWWTj5sklenuCwGh+YWQMV1xd
X-Received: by 2002:a05:6830:8d4:b0:7e9:f6b7:7752 with SMTP id
 46e09a7af769-7f43e432c08mr2912870a34.12.1787144732483; Wed, 19 Aug 2026
 06:05:32 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 19 Aug 2026 13:05:31 +0000
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 19 Aug 2026 13:05:31 +0000
In-Reply-To: <CANNYZj-rNiwKhLyF-UUd+Sif-aEj3YEn5nycSG_2hZwp=HZeYQ@mail.gmail.com>
References: <20260819042417.22411-1-giancarlo.cicellyn@gmail.com>
 <CANNYZj-FZ5trTVaP_nvZu+sAoEZ--0RZk_cDMUkK6jgrGobTdA@mail.gmail.com>
 <CAK46CgSuNHHqd8Nm_9KTEiiad1+4LoQB9sJ-5v89uhzjCcP8Bg@mail.gmail.com>
 <CANNYZj_v-WM7ZQOt+ytKGG2KxbE4w_Q9r_w1U1nJTLkfZLy_Ow@mail.gmail.com>
 <CAK46CgRZjY2XP9BtxSiWUhtYtdPF-1GiO3X7wN5R7rm3urUk3Q@mail.gmail.com> <CANNYZj-rNiwKhLyF-UUd+Sif-aEj3YEn5nycSG_2hZwp=HZeYQ@mail.gmail.com>
MIME-Version: 1.0
From: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
Date: Wed, 19 Aug 2026 13:05:31 +0000
X-Gm-Features: AcwNN1XuDu_5GT7JCHFWcIASysKueA79hrFYSCin2IBHboNOFSd8ygHAhAcU7Lo
Message-ID: <CAK46CgSrjz5wV15Jc+5in8gBqO-mZG=UkAV_A7s3iH1c0T2GKQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: preserve build config when
 init script is missing
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 13:05:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20001

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

