Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4B9C76196
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 08:45:14 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.153772.1680770713142974106
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 01:45:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=K5flmkO1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id e18so38710663wra.9
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680770711;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UQho9mgzYKtY//EEzzQkC7dV7yEvB3qplX0WJBZsafk=;
        b=K5flmkO14tids3ET316uF2gjfUF3jtdq4dWJoxYCXRPZULIX7qVaW5gvYC0bxsHA6B
         PxQCNhizcdivBhV88wcfDJLn0dWhRYHLA+rw1neZuN2cCVZKanGSRRSMrPuc2BdHaWet
         FtgV/WVKqf3hiiHTmydB6lywjW6AmHnyCmnuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770711;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQho9mgzYKtY//EEzzQkC7dV7yEvB3qplX0WJBZsafk=;
        b=kBEVpCZzIeXJu4j4+SFN2l2n3XHtoTnteG9YtLSMNlzeiz8wJyYXIS0XR3ovAOxNSc
         5xzIrByQoaaA0Ah1pm/2GC/S52ESCx4UWt2sXWitiwbfR+P7t4znrrswW83odlA7I7yS
         it08fUOrhFKcVDe7gWoynTikDRJYVNk9oaU5Bks2KEXf1xUShjzdX0S+4ZeUpMPngQ0z
         /7+6+hvy1t1Ew7UYnhVW0fJD9vd3aYTGBhQ7szMQZLJQKbQnfaTcQG6xkM5qCTgv3sVB
         O7heopqSSoMC+QZuTZeQy4DLvxc0s0P6JjZxHP+rAtKq4WgVt6VAqhGGeS1U6avRs3hX
         bFIw==
X-Gm-Message-State: AAQBX9ej40+ygFIEtEznz62i5S5djwpqULvC8+KsHmEaRct1pBYitFm8
	ti9HO+9XhHpPeyaaHVDGFHzdFQ==
X-Google-Smtp-Source: AKy350bLrwq4S7WYoQCiTLPmGZNvvlcV5Eto6qXuQMz0EWRTlaaDMHt4rAnY+cNKjSUtflWWiGJLWQ==
X-Received: by 2002:a5d:6e85:0:b0:2d9:10e7:57e8 with SMTP id k5-20020a5d6e85000000b002d910e757e8mr3958284wrz.16.1680770711314;
        Thu, 06 Apr 2023 01:45:11 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6a84:552d:cd38:8d5? ([2001:8b0:aba:5f3c:6a84:552d:cd38:8d5])
        by smtp.gmail.com with ESMTPSA id f4-20020adff8c4000000b002cff06039d7sm1135921wrq.39.2023.04.06.01.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:45:10 -0700 (PDT)
Message-ID: <088f748bc07ec93c833dbdbf1a941225de62f553.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch:crate: create versioned 'name'
 entries
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Frederic Martinsons <frederic.martinsons@gmail.com>, Enrico Scholz
	 <enrico.scholz@sigma-chemnitz.de>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 06 Apr 2023 09:45:10 +0100
In-Reply-To: <CA+cAkeo9e9tUqizBJi=RM3S37j4N5VXm7Jdww_5PLxySU7GEqg@mail.gmail.com>
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
	 <CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
	 <lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de>
	 <CA+cAkerceUTAyZ6DveoQF1d-i4nHg6f64UJ2PUr-=L0igeCsFg@mail.gmail.com>
	 <lycz4icya8.fsf@ensc-pc.intern.sigma-chemnitz.de>
	 <17530ADB1695B5D1.3977@lists.openembedded.org>
	 <CA+cAkerZx=NLx_xiVU=gT9Pwuidv5iaW2PSCCtYaxqt-z-LqMw@mail.gmail.com>
	 <ly8rf6cm7u.fsf@ensc-pc.intern.sigma-chemnitz.de>
	 <CA+cAkeo9e9tUqizBJi=RM3S37j4N5VXm7Jdww_5PLxySU7GEqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.47.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 08:45:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14665

On Wed, 2023-04-05 at 19:05 +0200, Frederic Martinsons wrote:
>=20
>=20
> Le mer. 5 avr. 2023, 18:45, Enrico Scholz
> <enrico.scholz@sigma-chemnitz.de> a =C3=A9crit=C2=A0:
> > Fr=C3=A9d=C3=A9ric Martinsons <frederic.martinsons@gmail.com> writes:
> >=20
> > > No, I take that back, it should not be an issue since you set the
> > > name
> > > only if it is not already there. But, to be sure, did you try to
> > > build
> > > some existing cargo based recipe (zvariant but also python3-
> > > bcrypt for
> > > example).
> >=20
> > It will break cargo related recipes which were created between
> > 2023-03-16
> > and 2023-03-31.=C2=A0 Packages before this date do not contain sha256su=
m
> > and
> > after this date, they have an explicit 'name' (which matches the
> > one
> > generated by my patch).
> >=20
> >=20
> > Enrico
>=20
> Ok, I guess these dates match my patches series, if I do things
> rights, I handle all the recipes I know of (in meta-openembedded and
> openembedded-core at least)=C2=A0

This now gives me a problem as rc1 for 4.2 built yesterday. I'm
guessing we don't want a stable release series with one form for urls
for six months and a different one in master?

Does this mean I need to scrap rc1, merge this, wait for the recipe
updates and then rebuild the release?

Cheers,

Richard

