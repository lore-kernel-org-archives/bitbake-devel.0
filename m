Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FDDCED27F
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 08:57:20 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web11.4369.1728377835176049063
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Oct 2024 01:57:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VSZYkb1I;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fac47f0b1aso62704851fa.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 01:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728377833; x=1728982633; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/H7JJ8gLY2iM7ZrZxuR8F/swEilFu/GrjmewxKHSX9s=;
        b=VSZYkb1I4yfzZ/UPIkpT2WW8tyOZDMiCjnQveSSt/L0AZHs6SLoupJryfuLTyB/0ri
         c4uD9X91wBYC1hW2kIaDmgx2S/DjBUkB+tDGFNhWNZV8Ju0Ij+LuPsh5TAlVvRvRfiQg
         M7hwgAtTsXuNRryJC1E3i0a4pBccKRWVHO6LGQnIeki2TN2EvSwF4SyLib+K78w1WACT
         uuZR9rZPuDLpplAq9PWwWa+bogB6RhbtvDKAuKYMtbQPMz+N0UTJZW8nLadTLz/9f5IO
         onIvFyn4Nk251xHGAKWPwbRlvddSuDa2NVzADrlf/Bo1CYPFYQm+5zYBHFQeJNnm8uQr
         uAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728377833; x=1728982633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/H7JJ8gLY2iM7ZrZxuR8F/swEilFu/GrjmewxKHSX9s=;
        b=chOU5k0jie/DJ+MV6Vwnd13bxNAoOZmNUTaWIUqaJg03oEqccO7ZpwnIJjWlBHUQ5X
         DuLzrotR5scxd6Xu6YcHnOuw0MgZumQFMIZmbG5y01S3ZKxi1+oIKy9texlnn59F4zo/
         FuFBzMUyKUiS5c1xtfl0ZAc/g94lPZYAsm7xAeQHCYwisoak3HzzQ2Ik3fgYe9Uio7FA
         F1Yz8yS1Z3bKr6HiHKdT3LIi+MAzbjPZEJKhmYB69E2Hur9P0eEBADrtaNOtAumSSTrY
         j2STOE9KM7/1mrOCMmXQvEaOssnuEKhSLGron7lc6I0oS2gLNc4vh0OM5+Wodl64ltp5
         19Ow==
X-Gm-Message-State: AOJu0YzOfRT90aO5EDz6/u92YQVIE7wlrZ3DySplF9SsM9Jg/hvnFR0O
	T2VckWGy0ESZtp19K5wYmRUidMwDjqPcyXAtNSoQP7qyxvDRPR1g6ZxKfik4lq5nfpjfFkgr9U/
	uOCL8dT6Vhu1re25Lc60MrP4piar4Ag==
X-Google-Smtp-Source: AGHT+IGE7f8lXwyTzZOjteFUSLN5MswZzRx8TiKFCaszKujBE50tYi4yuODSLIDnMqifwcAy2J1WjjBV1VL4gwM7+0c=
X-Received: by 2002:a05:6512:1155:b0:539:9510:115e with SMTP id
 2adb3069b0e04-539ab9c6f32mr7079137e87.57.1728377832719; Tue, 08 Oct 2024
 01:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241004030640.10440-1-mfumita@electromag.com.au>
 <46a43e5aa802fcb59dc2dd1fc832e4fd787939b9.camel@linuxfoundation.org>
 <9aa944db-e60d-4b19-9865-afea669e8f5d@electromag.com.au> <CANNYZj9YZ3ryc7fOFqs250Yt9UM4fxOG2yCcLx=JoYC98v=s1Q@mail.gmail.com>
 <11e9bf7a-1738-473e-ad21-a16ea1b5dd62@electromag.com.au>
In-Reply-To: <11e9bf7a-1738-473e-ad21-a16ea1b5dd62@electromag.com.au>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 8 Oct 2024 10:57:00 +0200
Message-ID: <CANNYZj82-9JDK7=zK+Jozmx_fXg83qqaHfCgURGt4kWDyNYGkw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] fetch2/svn: Support to feed an external
 SSL certificate file and its password
To: mfumita@electromag.com.au
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 08:57:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16652

On Tue, 8 Oct 2024 at 05:02, Mori Fumita via lists.openembedded.org
<mfumita=electromag.com.au@lists.openembedded.org> wrote:

> As you suggested, these could be saved in a temporary configuration file
> instead of using environment variables.
> In that case, the fetcher would need an interface to forward its path to
> the SVN "--config-dir" command line option anyway.

But would it? Can you just add the needed options under ~/.subversion/ ?

The problem with extending the fetcher with specific tool options is
that it doesn't scale. You want these two options, someone else wants
other options. Git has hundreds of possible options. We direct
everyone to just put them in their local config.

And having passwords in recipes or environment variables still isn't
secure. Convenient, maybe, but that's a lesser priority.

Alex

