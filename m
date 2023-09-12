Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5C0EE3F38
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 21:40:07 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web11.2770.1694554805351390595
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Sep 2023 14:40:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=SoNw6ucv;
 spf=pass (domain: gmail.com, ip: 209.85.208.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2bf924f39f1so43286621fa.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 Sep 2023 14:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694554803; x=1695159603; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBkcbRI+uDfWalhKU0FN1bQVL9U/JoyJgP90HeeVpw8=;
        b=SoNw6ucvz72ie1WkjEjK+AVUKwXUwkeO58OfL5NXi1Bp7qvezt6hzF9W86Udc28aWU
         +GWG2tJKGPV8xolunOdgyNVPM86nFKho2VWEGrdEJ0IEhlCekaOZMkweWRPuvvCAxJsv
         8x6rlJRtYSxlGX8MqMzLDdbRRi3znw2hXTqrksEQQAs2idmUate3wxBE/7HfDyUn3+Qj
         yoyyqhjllxoEhRy+saPnG8Kp0wE1x8fcH3fX9kmoeRxkecBxVyn78H7HaQCZXlQtABjO
         aeBYbDcn0m0KaIjyUhltexR94hFyYDDdGoI1TCZVHXKHZlak6FvJSAkjTSW9PduR6UwJ
         nUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694554803; x=1695159603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBkcbRI+uDfWalhKU0FN1bQVL9U/JoyJgP90HeeVpw8=;
        b=mm32rr7VyNh8/7OEGGRto4k9D4nMETJ32DAy6Mi9i5pXsSC5jeGlGg3Q7QIxLV6kBC
         sZ8mBwp1ENEIjYqvETC9FMVG8DlqXvLHhzz/uHaxNpUqBf4lRKbZ+VumhVpjOj6wb1aQ
         +B65GBpLNN59cdDDpw/m9i7KY2/1nwn/Y7yQ4PB1IYB+y5DSRmdKKeMmWM/frhpP+XJb
         sTMKCOQ9e9U8j0FP3l2MgoeqdzHwf2/WJclruznA9XfBUIdxyP2Sfc3N8322A4p0an+R
         ET5kehV7xfc9jsUvK0aFbnvKOMOBSenVgecro69hTIQQxZfSPQLVFFbDmTZ0iI0q/K5z
         VVow==
X-Gm-Message-State: AOJu0YwwG7hkmmodt5X7o8VcQXMfcz/WFUzCPxTZg3NjZBZstBoLzkDL
	2G1qAk8EFObIdS6h9MSnbB+Ja+zrxbDZNEQJg1E=
X-Google-Smtp-Source: AGHT+IF3Dydff9Lhr9kWJkvI720vXOzS4B6ymVlsnCc9qsoGTDl87zRPzsqCRGy6U+7cdXfDU3Kq/PVOxsa+igafb4g=
X-Received: by 2002:a2e:9dd5:0:b0:2b9:eaa7:c23f with SMTP id
 x21-20020a2e9dd5000000b002b9eaa7c23fmr760617ljj.49.1694554802915; Tue, 12 Sep
 2023 14:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu> <CAJdd5Gb5wn7GG-1T_5CYjyESdBXU1RGghVYkAtAwF_GNBpnayg@mail.gmail.com>
 <9924500659de9ef4cf2b0c6e127fa27a@pianon.eu>
In-Reply-To: <9924500659de9ef4cf2b0c6e127fa27a@pianon.eu>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 12 Sep 2023 15:39:51 -0600
Message-ID: <CAJdd5Gb1cTQyEqFPQ-_jGb4kaHzHG93SJis800K-q__A_LcTbg@mail.gmail.com>
Subject: Re: [bitbake-devel] initial idea for hooks needed for source tracing
To: Alberto Pianon <alberto@pianon.eu>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Bitbake Devel <bitbake-devel@lists.openembedded.org>, Carlo Piana <carlo@piana.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Sep 2023 21:40:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15036

On Tue, Sep 12, 2023 at 3:26=E2=80=AFPM Alberto Pianon <alberto@pianon.eu> =
wrote:
>
> On 2023-09-12 23:05, Joshua Watt wrote:
> > On Tue, Sep 12, 2023 at 2:55=E2=80=AFPM Alberto Pianon <alberto@pianon.=
eu>
> > wrote:
> >>
> >> Hi Richard,
> >>
> >> as I said at today's meeting there is no hurry, but right after the
> >> meeting I had an idea and I wanted to fix it in my mind and test it
> >> before losing it :)
> >>
> >> It's just a temporary/WIP patch, but it should not be too far from a
> >> working implementation of the hooks we were talking about:
> >>
> >> http://cgit.openembedded.org/bitbake-contrib/commit/?h=3Dalpianon/srct=
race4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8
> >>
> >> There is no interference nor modification to the unpack process any
> >> more, just collection of needed metadata through the urldata object.
> >> Modifications to the core unpack function are minimal and (I hope!)
> >> straightforward, and there is no fetcher-specific logic in it ant
> >> more.
> >>
> >> When you find some time, could you please have a look and tell me if
> >> this may be the right direction?
> >
> > I think this is much better; there's still a few rough edges
> > (`function.__name__ =3D=3D "unpack_submodules"` is kinda gross :),
>
>
> I know :) but I couldn't figure out something better off the top of my
> head...
>
> The thing is that "function" is passed to process_submodules:
> http://cgit.openembedded.org/bitbake-contrib/tree/lib/bb/fetch2/gitsm.py?=
h=3Dalpianon/srctrace4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8#n43
>
> and it's executed for each submodule:
> http://cgit.openembedded.org/bitbake-contrib/tree/lib/bb/fetch2/gitsm.py?=
h=3Dalpianon/srctrace4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8#n152

Maybe process_submodules could take an optional argument that
indicates if the data should be added?

>
> I want to collect some metadata only when that "function" is
> "unpack_submodules" and not some other function.
>
> May you suggest a better way to do it? Maybe with inspect?
>
>
> > but this is much simpler and I think easier to understand.
>
> Thanks!
>
> > Also, I feel
> > like this is actually reasonably testable; presumably there would be
> > some mechanism to "plug" a different Trace class in instead of the
> > pre-canned one, and tests could be written that use a special test
> > implementation of that class to verify that it is being called
> > correctly. This also means your special source tracing classes can
> > live elsewhere instead of needing to be integrated into bitbake
> > immediately
>
> Yes, that was the idea. Maybe a variable where to store the module to
> load, like SRCTRACE_PYMODULE =3D "mybb.fetch2.trace"?
> And something like SRCTRACE_PYTEST =3D "mybb.tests.trace" for
> bitbake-selftest?
>

