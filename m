Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58CAC433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 06:39:31 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web09.3604.1658817566354203308
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 23:39:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FIw1xurI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id h9so18821505wrm.0
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 23:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=AwhEiABLhaGE6HfccIb71H7J28grIQd6vUDL932P8go=;
        b=FIw1xurI/M0AD4gPSWv1/aqyEdjFOHdlXAZ0kVgoGiV99n4NFEfd2jbe47ziDHDfOB
         3qbI5LaPUxLeiJC0g3NLEGRGd0+r3voNtu7iGkeHKCJemm2fT6q9Yq1t0lQLATevfxJg
         BHSodfTnQ/tN+GRdQlFjsewlfhAsJYjn62jgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=AwhEiABLhaGE6HfccIb71H7J28grIQd6vUDL932P8go=;
        b=pJdb1gjBeMA7vqM1XVu4xn5YSY7kb8bjjQI2ZVRdiM7NyNC70mki4vGrb6fbcFTSaN
         k08m6y1VE8BoEoQcjVkmgNOYGJbhHSKPCpSXqQCHFwInAazX8/vB9uFlbkt7zvsYoXhk
         VX7UtePdjW0pGip8yxT0WwhZ26VDm80W24PwaEpzuFNRPRiBnQFSE1NpFo/a5TtOcmI5
         9VHH/PDzhShT1IA3rg4bj6bqJ+wvTeXDph//xzJEi+aSIHgyW8hDSWWWgfvl2iP22EPX
         Ikilj6bW78nEi+vwJqxGcUYasxqXYyXijEpWB+f/zg/esfPak0pE9kNMjHwXcEblFy1k
         S9JQ==
X-Gm-Message-State: AJIora9k17c7NvYnYghedcVBz4+xzC3H2gy0+UxXSbx1zC/OGx00U6jn
	IuGZ5gFzo8D9DKVkeF63D3AOjw==
X-Google-Smtp-Source: 
 AGRyM1t+mlSu834k9HtmTL4thk+T8nztOkC8Z1Om/1K+D1BOQI5SyHa/BJDM/mPkKWhOaDg6dC3sLA==
X-Received: by 2002:a5d:51c7:0:b0:21e:8455:c286 with SMTP id
 n7-20020a5d51c7000000b0021e8455c286mr6291235wrv.61.1658817564504;
        Mon, 25 Jul 2022 23:39:24 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:289a:8162:dbfe:813c?
 ([2001:8b0:aba:5f3c:289a:8162:dbfe:813c])
        by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c510f00b003a30fbde91dsm22708430wms.20.2022.07.25.23.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 23:39:24 -0700 (PDT)
Message-ID: 
 <8cbc762227c6c5223004d7e457dff8f3da683a2d.camel@linuxfoundation.org>
Subject: Re: [PATCH 2/2] fetch: bb.fatal when trying to checksum
 non-existing files.
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Patrick Williams <patrick@stwcx.xyz>, Paulo Neves <ptsneves@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2022 07:39:19 +0100
In-Reply-To: <Yt9o3TefXIqpJk7q@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220708205407.1680137-1-ptsneves@gmail.com>
	 <20220708205407.1680137-2-ptsneves@gmail.com>
	 <Yt9o3TefXIqpJk7q@heinlein.stwcx.org.github.beta.tailscale.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Jul 2022 06:39:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13851

On Mon, 2022-07-25 at 23:09 -0500, Patrick Williams wrote:
> On Fri, Jul 08, 2022 at 10:54:07PM +0200, Paulo Neves wrote:
> > If the local fetcher was not able to find the file anywhere but it
> > was included in the SRC_URI for checksumming just make it a fatal
> > error.
> > ---
> >  lib/bb/fetch2/__init__.py | 2 +-
> >  lib/bb/tests/fetch.py     | 5 +++++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index 5f05278a..8184b55e 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -1237,7 +1237,7 @@ def get_checksum_file_list(d):
> >                              " This means there is no way to get the fi=
le except for an orphaned copy"
> >                              " in DL_DIR.") % (d.getVar('PN'), os.path.=
basename(f)))
> >                      else:
> > -                        bb.warn("Unable to get checksum for %s SRC_URI=
 entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f))=
)
> > +                        bb.fatal("Unable to get checksum for %s SRC_UR=
I entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)=
))
>=20
> Now that we've picked up this change, it seems to have caused a bunch of
> irritating hard failures where we use to just get irritating warnings.
> Our recipes probably aren't 100% ideal, but we had a number of recipes
> which are not pulled into all our machine configs, and could end up with
> broken SRC_URIs on machine configs they are not intended to be used on.
>=20
> There are some more complex examples, but one easy example is a recipe
> which had `file://${MACHINE}/eeprom.h` in its SRC_URI[1].  Any machine
> which didn't provide this file, even if it never intended to use the
> recipe, now fails when we picked up this change.
>=20
> I know we've been ignoring the warning(s) for a while on these kinds of
> failures, so it is our own fault, but it is kind of annoying the new
> behavior.  We now have to make sure every recipe not only parses validly
> on all machine configs but it also has to have fully populated SRC_URIs
> even when the recipe is never used on that machine config.
>=20
> 1. https://github.com/facebook/openbmc/blob/f0d9511ad2fbd563a6b793093cdac=
557c5ef2a89/meta-facebook/recipes-utils/mac-util/mac-util_0.1.bb#L12

I'm just going from memory but it might help to set COMPATIBLE_MACHINE
in the recipe so that it isn't fully parsed for the machines it isn't
intended for.

Cheers,

Richard



