Return-Path: <alex.kiernan@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11A3C43334
	for <webhook@archiver.kernel.org>; Tue, 28 Jun 2022 11:14:14 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.53915.1656414852956365150
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Jun 2022 04:14:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=kpkiQRUb;
 spf=pass (domain: gmail.com, ip: 209.85.208.51,
 mailfrom: alex.kiernan@gmail.com)
Received: by mail-ed1-f51.google.com with SMTP id z19so17013339edb.11
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Jun 2022 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JA7Ph2PR4QpTSBryaYIih5K36eOM0mwThO05CPeokGA=;
        b=kpkiQRUb9FrAFuh/fM8qQprFI8FSP8kv/zasZO93OvMR5kEAmPHERtArcJFa0WN9sq
         sj97NGpeT4KqALQ3eQj3JR3GWSvAU0YHFXOsLvpyBsx9c60vwHR7jtYX5X2m5PCEG/1a
         SioOnj0HKsvTBQ+EbcvS5TDp2kQKgRG6WNVUx40KlrrgZZeuW9fMFU66hsGh6IafRNUR
         dcXf7uG/TUnfRxOIJywQ3GB5SvRI0QB2yKGYemZzq25smXD7u8zy9xiArF+R+P3U+DX/
         Ipo+cFvkz445F2Jiv25tMRZK7FO8dHuDr5vhzWznroqiHCFG9JZWsEInkWcmzbSwik1a
         znzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JA7Ph2PR4QpTSBryaYIih5K36eOM0mwThO05CPeokGA=;
        b=g0TAMFU0SfAp2ms2pV/qE0K8QXdP+AhvY2t8gOcIdYojQzS5nszq3J6n5tCIHDSsSh
         MgXAlHWWAFzBEIcRjO9nqqwIqv+AqKLT/Ec4Js7485jF0UyQDXwMwDl1nTmmouady35f
         lF1NcF3LYyGSmIMdYGwqyR8he/uXISBTTXz7LtkhW3w/jOx7/lyIirOSv8vyapnZB5Sf
         6IkQXrC+eHDxWCTTMTBCDOsfWsxyHJox+OrlyygBzLa8H2XxYOGoaq/LjNmnbbr+k+eX
         aeJv4H77olDIhFbQPGm84pdNi/gSxm4zjTOooihnEsxYJcRTOaJN4Qfs0bMTHZePKZZS
         bWZQ==
X-Gm-Message-State: AJIora9i58lA7jK3dpAEelKJDYxBHUbUdtn9DvCVvtJAtULhwwKyDuum
	eF+FiJ2iU0cNXtgUeUfDDhEVC3Vp5eV5AmBzmTM=
X-Google-Smtp-Source: 
 AGRyM1sqpkA0WIGo4exRTRSgA7Ov8Y9jwObMovBNTrDoeJrUG87lwOnVV+hzxT3NCILOLOTBp3likBY8wx//bRHFQjs=
X-Received: by 2002:a05:6402:158e:b0:435:7d0f:ac85 with SMTP id
 c14-20020a056402158e00b004357d0fac85mr22408170edv.93.1656414851434; Tue, 28
 Jun 2022 04:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220609070631.23346-1-alex.kiernan@gmail.com>
 <5e781972643ed99e2948ac5a908222a190678475.camel@linuxfoundation.org>
 <16F6ED45D7C68CA7.32696@lists.openembedded.org>
 <CAO5Uq5SxhRhpRGyD4PoXm3b2Edtzy=tgGWkRFpjKRikFgsW+mg@mail.gmail.com>
 <d6260e8bcd7b49395c7e81e4649f5989df8d6e91.camel@linuxfoundation.org>
In-Reply-To: 
 <d6260e8bcd7b49395c7e81e4649f5989df8d6e91.camel@linuxfoundation.org>
From: Alex Kiernan <alex.kiernan@gmail.com>
Date: Tue, 28 Jun 2022 12:13:59 +0100
Message-ID: 
 <CAO5Uq5T6wOcv3XWvyAyKM0mMcrMEQZ1buGt+Sy_R0PuvYRtowg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] data_smart: Pass flags through variable
 rename
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org,
	Otavio Salvador <otavio.salvador@ossystems.com.br>,
 Alex Kiernan <alexk@zuma.ai>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Jun 2022 11:14:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13792

On Mon, Jun 27, 2022 at 12:10 PM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Thu, 2022-06-16 at 13:27 +0100, Alex Kiernan wrote:
> > I've been thinking around this, I guess the bit I really want to work
> > is for flags to survive through variable renames, rather than
> > overrides, but the two use cases do tend to collide as we often have
> > overrides with variable expansion, which is then renaming...
> >
> > Just realised I c&p my example from our vendor branch which is still
> > on _ based overrides rather than : based ones, but both seem to work
> > for me.
>
> I've been pondering this a bit more but I'm not sure we want to wade
> into the complexities of how flags+overrides+key expansion can all
> collide together.
>

I guess I understand this, even if I'd like it to work :)

> I did notice this in the metadata though:
>
> RRECOMMENDS:coreutils-dev[nodeprrecs] = "1"
>
> which happens to work as it doesn't use key expansion and doesn't rely
> on override expansion for access (the variable named
> "RRECOMMENDS:coreutils-dev" exists).
>
> It does mean we have some subset of this problem live in metadata
> though :/.
>
> Changing it to RRECOMMENDS:${PN}-dev breaks things.
>

Feels like it merits at least a warning? Though I guess the challenge
is chasing an ever moving set of internal flags which can be attached
to a variable.

-- 
Alex Kiernan

