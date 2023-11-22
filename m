Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1059C61D9C
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 22:11:12 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.51843.1700691065200960133
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Nov 2023 14:11:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NjshBeZn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40b2c8e91afso1476555e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Nov 2023 14:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1700691063; x=1701295863; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4MpL/PjFNil1Vai62s5p/C3+Q1HGi5D9WnZUuIU78P8=;
        b=NjshBeZnW2zBvEhb3vNAxbIyMnRLZw6xDVu/ygqUyHPV7t1TcqSQXlLTsuWboC2L+I
         nqcf6hhFo5SfzbE3qyPBwf43NKbegfbmDdcNJSeC0pst0GislLA6l1Q33PljuM8XfsW1
         spj0ABajxbrZbxNy6toAlJPTYqhNOhY05aYkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691063; x=1701295863;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4MpL/PjFNil1Vai62s5p/C3+Q1HGi5D9WnZUuIU78P8=;
        b=Wff/fM3MtRgPzJKeYKre9cOPMV6ffyDqnQ7zakjwJcIbVRbx64Lvk2WZX//ITUZajx
         O8cYwIRSj7ASB2VsqKkSH9LA6gSwSTN/eAhNIexz4p5cS80HKMA6xe7yFSNr07aQM/R2
         WTrxwKj/zWDoCgtmn4IWORYgOTtEVTMGdAJd2BPrpEYr6/fBPMuINSzKEmLNUunvu5dh
         +JPHc6JUfpiHYe3VsRX+8SKmRWZfLS/72u2Q4uQZhMYVv2vLRFkK7bHI035SJ3ioTHHk
         dcVk4yOK4KLTWfiAijQO/XNq23NMMWvo0iWK/lYAS0SW0cFwkJ0I6cRJYXBplkcB1v4+
         cQjA==
X-Gm-Message-State: AOJu0YzL6m8WRDCLpIrEGkJXpmrplWTIeF9JjeVEoyIY6TBoHw02vhnU
	bT2q2rAUKgfpX2xw/zuDfGbKLg==
X-Google-Smtp-Source: AGHT+IFOyyBoD4FCqy36ZAzGT04hOBqtG3lxHkOA5u4dD2tffcV0JC/oXwQI7o5P3SYFbD7oL6HVKw==
X-Received: by 2002:a05:600c:310f:b0:409:5c2b:43d1 with SMTP id g15-20020a05600c310f00b004095c2b43d1mr2570762wmo.20.1700691063611;
        Wed, 22 Nov 2023 14:11:03 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:c511:4d31:367c:ab3c? ([2001:8b0:aba:5f3c:c511:4d31:367c:ab3c])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c138c00b004063c9f68f2sm12608wmf.26.2023.11.22.14.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:11:03 -0800 (PST)
Message-ID: <e850b68b1b7c3a6eac139f5b72b19b2868531ee7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Keeping STAMPS_DIR between CI builds?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christian Eggers <ceggers@arri.de>, Alexander Kanavin
	 <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Nov 2023 22:11:02 +0000
In-Reply-To: <1994066.usQuhbGJ8B@n95hx1g2>
References: <3556314.iIbC2pHGDl@n95hx1g2>
	 <CANNYZj83WzD9L6=rw3JRG4TQSjkPjCC+_5gatOzUDr+ZL_4bNw@mail.gmail.com>
	 <1994066.usQuhbGJ8B@n95hx1g2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Nov 2023 22:11:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15564

On Wed, 2023-11-22 at 12:36 +0100, Christian Eggers wrote:
> On Wednesday, 22 November 2023, 12:22:52 CET, Alexander Kanavin
> wrote:
> > Your description shows that everything works as intended. If
> > something
> > needs artefacts in ${B} then do_compile has to run at least once to
> > populate ${B}. Preserving ${STAMPS_DIR} would clash with that and
> > isn't
> > going to work. And do_compile isn't sstate-enabled, so there's no
> > shortcut
> > that way.
>=20
> that sounds like not every task's output goes to the shared state
> cache (is there documentation about this?). As do_compile doesn't go
> to cache, all previous tasks (also not cached?) have to be rerun.

SSTATETASKS gives a hint about which ones write to sstate. It doesn't
make sense for everything to go there as the computation to recreate
some things is similar to that of storing it, or storage is large and
not often used, therefore not cost effective.

> Would it make sense to put the result of do_compile into the cache
> for my particular recipe?

You could create an sstate task which stored the binary, which would
work out very similar to the way do_deploy works. do_deploy would be
the simplest example we have.

I would caution that sstate tasks aren't "easy" and the system does
have to have knowledge of when to run dependent tasks and when not to
so there are complications in making them work accurately. It isn't
documented for that reason.

Regardless, keeping STAMPS_DIR around is a really bad idea unless you
really know what you're doing.

> > I'd suggest that instead of embedding any build id data into the
> > binary
> > from its recipe, you can do the same step when building the image.
> > There
> > are hooks for this, e.g. ROOTFS_POSTPROCESS_COMMAND.
>=20
> Of course this is much more straight forward (and what I already do).
> Be for
> some use cases (automatic testing), we handle with individual IPK
> files / executables
> rather than with complete rootfs images. For this use case it would
> be helpful
> if the application could "identify" itself.

You could embed the ID into a file in the package instead of the binary
itself but that doesn't solve the individual binary challenge. You
could record the checksum of the binary and have a mapping maintained
the other way?

Cheers,

Richard

