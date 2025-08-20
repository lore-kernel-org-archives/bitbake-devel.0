Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10B1CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 20:25:15 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web11.7406.1755721513633162874
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Aug 2025 13:25:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WitWXTHp;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70a88db0416so3417936d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755721513; x=1756326313; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sqYojmpAbmTdADmqqqj0wn2Dv6dlBTTFMKqOCkNEht4=;
        b=WitWXTHp7UYF2PosYzf6VWzKyheEd5y43ClhVx4EVf5X9aLfeH5KJZFfvTWypcvb4C
         5UsrtFuNhZ10Mo5tNuWRMF0wuNkwZne3/pETLi3tuyXD07JlGcnRDPudq4tCe20IGyx2
         HyvBfV4BJPy9FtbGCB9OGFEUsUZ1eIgBU2ma2nCxQ9OIUXXi46rJJuj8qnMt7kvInq8j
         SKpyQPmA810z3qZWUX0TuUaznyvkaWooCNi9oCGh9xqeVophD8oCkDHHl0gsYMAnAIq8
         G0wrJAQYLv6g+MpAxPWmob7wnu6feTXV82BTAiq6soZT7YvDUppeboQkAmV1lQrTWq4t
         8K+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755721513; x=1756326313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqYojmpAbmTdADmqqqj0wn2Dv6dlBTTFMKqOCkNEht4=;
        b=m8uV+bezVFEtoVKiGzyee7ixiycydfcjIq1E3lXuWh3hilVk45SsoO/Q7SCHgyOXOV
         tcCNQtmP6CkyS7xaRDUtcFo3mtCtnlIrTvVLeuxNfTbGfAN7BCBl5Ck5U6kMDq3TF7Zx
         f4cegXYNLYSDEc62SRXGnXrHFn8Zif4FMEUXLudyP9ojzbIg+leKm5bi6sXDm+oMltiR
         djMWnS5Ihd17k+RCt0YkiYsixAVsLDWeucsimikuXJfFysZqGanzcMfSpyg8tYeb9ML4
         gzX9AidF+DjThH3O93oPsvaHZRKx7JgfELJvccChT6Y7ssAtFc+4gyx2kjjqVfWJRc7e
         Za5A==
X-Forwarded-Encrypted: i=1; AJvYcCUrt2kSfOAf4Y0UAHsQ/KhiPs0KUEZFireByhNWcHIC6i57GW3QO9hknQ9gaeTurscyfocGM772l45bPtCq@lists.openembedded.org
X-Gm-Message-State: AOJu0YyiOC+6Q0d8ftT8gVQf0e6QBA0W84WANeF7KjLABSPuWC/8HbF0
	e6+g/ACYotJ/iuerGH7mutH/rLvt2IUmEydPFwbitPmR0a5wnlB7+2o/YkQdRvX2iQ5R03ffFPl
	bIhH7LgGPY57XKBs+TsyQBcKMWcQi2jw=
X-Gm-Gg: ASbGnctoGf2lOYgw9hkhxOMFNGxMH3DcX2u/2NY+62fvPyg6DgcNsiuck2NrOQotQQk
	yOBo0OcX5Z0saZ6nDVqPZBX5MOS7n1kv78o0ziFrpgMkYHs86p1PRZsjMZI7BnqOLu+ouHqkumu
	fa+PQWEKxeJL90sSBBbYzI9zY0BLlTPKYyEVoRED9HR18OUaPge8mSd1W7GoJpTIOChTmTKg0ki
	uaX8lb1EM8RyBdwMk+n0J9f80MijCmXiMHb5yZFdA==
X-Google-Smtp-Source: AGHT+IHaXfuOwsAdVV/OQjpPASw8KoRk0rFUZBLnDLzNu5XZhJr36sflYlurOoDYt2NmtZXFR5b3Krw+e2RDQjKafKg=
X-Received: by 2002:a05:6214:20e2:b0:709:e095:128f with SMTP id
 6a1803df08f44-70d76fd4bbfmr49451796d6.25.1755721512680; Wed, 20 Aug 2025
 13:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250813151523.1855287-1-alex.kanavin@gmail.com>
 <9b00442e9c0eed12c491b98704bc34fd9f78c48b.camel@linuxfoundation.org>
 <CANNYZj_1k7_pzh3wkn53aVGM1+ioDsqmAGTYgr7AwswYv2pQMw@mail.gmail.com>
 <0a06fda681c8b5d94cbccc000e661451c1c49251.camel@linuxfoundation.org>
 <6e562ea3-ea7e-7e27-54ef-5fabc05888b5@konsulko.com> <CANNYZj8y-VCKnzUD2OLihbt4KtYPqdBK4zE3-5mQE84844fYjw@mail.gmail.com>
 <647b238c-cf12-eb7b-d243-038854180192@konsulko.com>
In-Reply-To: <647b238c-cf12-eb7b-d243-038854180192@konsulko.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 20 Aug 2025 22:25:00 +0200
X-Gm-Features: Ac12FXyOdNEjUlKrW87eKlgmCYN69htNNLikwGY-cCB67o6HcAVfgKYaTjf6dhQ
Message-ID: <CANNYZj_RWrJxXx6+WZ_px_EWOd9+Wr1TgUEHgGg3rspY5wEECw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial implementation
To: Scott Murray <scott.murray@konsulko.com>
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	Tim Orling <tim.orling@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 20:25:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17898

On Wed, 20 Aug 2025 at 22:15, Scott Murray <scott.murray@konsulko.com> wrote:
> Sure, but my point is that's what I'll be doing every time I set up
> any project (and maybe reconfiguring it?), so effectively for me the
> default behavior is not useful.  I doubt I am alone in doing all my
> development work on a different disk than where /home is on my dev
> and build machines.

Then there's the option of setting BITBAKE_SETUP_TOP_DIR in environment.

Alex

