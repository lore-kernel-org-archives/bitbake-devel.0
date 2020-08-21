Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.web10.136074.1598021667894340351
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2020 07:54:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Zc921dQ2;
 spf=pass (domain: gmail.com, ip: 209.85.222.180, mailfrom: jeff.dagenais@gmail.com)
Received: by mail-qk1-f180.google.com with SMTP id b14so1593492qkn.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2020 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sCJ6XVw9u+zg58LJfbbl7s9xqu804TPu1DZJvcIf82c=;
        b=Zc921dQ2X/yOoQPaH7shiedZv7FSOxwpyq0C25jwrgPXatUr1QeS+/ieyOePit4n/Z
         LqUMTtC+xERc5KFx9WQU66R5g2WWuUcoPaN+5Wi3NiDv/KWE4j+ft3Pg2hM/8+zgFTQQ
         mpELr5vD8zvc+ApCQEYFTkZ9HcUWpQE0JNfr7Aj+08pedIpEml7Tuzh/NwDyQUVkAFjT
         s0iLv7koxJGCqrha357arGCfiaJWnHKhp4GULtwsztRpzzOeRe0SzRrBKIRnwekKBEIm
         Hd116m4ou9xQ3ZMoJ5ZKZ3/wWh+wNxp2moe5RgFkKAkunentn3Z4LETBPJpq21w5Ok+l
         7Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sCJ6XVw9u+zg58LJfbbl7s9xqu804TPu1DZJvcIf82c=;
        b=mEHz4AOwMqzpwts3hg+Vj+9XY9cadUWfLeASCSkXFrixYoI6ah4MOtj5JKm8PW6WuH
         KXRm27OOF550JDt1y5hHsenQJGqRwGbLwvnRayRSSbbWy7XJCSNla+rFhVjwG16j/jaU
         BwNhoVAcac8MhRbhXrLeJ6zEzQ5TtiZNMAgtSTkJ4SBgPYOdjkD/ooAfkqHBEVIZ5Sxg
         s3JNAQP3TN8TLkYnCUW3HAKT4uFo/T20HrZSwcC1h3/3JgJ/SwYy4EzLrgDP0JK93HYZ
         c4AFwZpbLm1dLQo/oWr/yLGxFk2X8bUI674dJ3XARvxWvaDpdNPAJOMFLDPrEGrSFRHA
         XWsA==
X-Gm-Message-State: AOAM530WaOfWOsMPB6SkUJ+THa+TWD3kxCJD1/K9ZhRORH5n3LSAKVn/
	xhY+akJivuXqM2IkMLVfGc4=
X-Google-Smtp-Source: ABdhPJy4Mmdk8j2AGNz/p7FOjOCsZUG/kpjtcrUPhNz0VuJuIe/GiSVpEk8PGS7cKM1zrVSDBqJ/dA==
X-Received: by 2002:a05:620a:346:: with SMTP id t6mr3144147qkm.29.1598021667004;
        Fri, 21 Aug 2020 07:54:27 -0700 (PDT)
Return-Path: <jeff.dagenais@gmail.com>
Received: from [10.0.0.29] ([135.0.225.35])
        by smtp.gmail.com with ESMTPSA id m66sm1883912qkf.86.2020.08.21.07.54.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:54:26 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [bitbake-devel] [RFC] siggen: clean_basepath leaks full recipe file path
From: "Jean-Francois Dagenais" <jeff.dagenais@gmail.com>
In-Reply-To: <1819f13202abc9339dbdd0215d714fda8a9b070b.camel@linuxfoundation.org>
Date: Fri, 21 Aug 2020 10:54:25 -0400
Cc: bitbake-devel@lists.openembedded.org,
 =?utf-8?Q?Maxime_Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>,
 guillaume.champagne@sonatest.com
Message-Id: <29032972-1F01-4FE9-A3BD-13E1FFD43790@gmail.com>
References: <20200820215000.30818-1-jeff.dagenais@gmail.com>
 <1819f13202abc9339dbdd0215d714fda8a9b070b.camel@linuxfoundation.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi Richard, all,

> On Aug 21, 2020, at 10:18, Richard Purdie =
<richard.purdie@linuxfoundation.org> wrote:
>=20
>> The following email is a patch which could be applied if deemed
>> correct. But please
>> consider this re-written version:
>>=20
>> def clean_basepath(basepath):
>>    # basepath is a string like '/full/path/to/recipes-
>> whatever/helloworld/helloworld_0.1.2.bb:do_compile'
>>    # or 'virtual:native:/full/path/to/recipes-
>> whatever/helloworld/helloworld_0.1.2.bb:do_compile'
>>    # or 'mc:somemachine:/full/path/to/recipes-
>> whatever/helloworld/helloworld_0.1.2.bb:do_compile'
>>=20
>>    _, parent_dir, recipe_task =3D basepath.rsplit("/", 2)
>>    # drop what is left of the second slash, searching from right to
>> left
>>    cleaned =3D parent_dir + '/' + recipe_task
>>=20
>>    # if there was a 'abc:xyz' prefix, add it to the end
>>    if not basepath.startswith('/'):
>>        cleaned +=3D ':' + basepath.split('/', 1)[0].rstrip(':')
>>=20
>>    return cleaned
>>=20
>> Both simple fix and this rewrite were tested with `oe-selftest -r
>> sstatetests`.
>>=20
>> We feel this version has these advantages:
>> * improved readablility
>> * improved efficiency (the split is not repeated twice and function
>> it has fewer `if`s)
>> * honours the open/close principle better by not hardcoding
>> "virtual:" nor "mc:"
>>=20
>> Thanks for your feedback! I will submit this version as a patch if it
>> is positive.
>=20
> Well done finding this, the bug has clearly been there a while! I've
> had a feeling there was something going on somewhere but never found
> it.

Cache misses/extra tasks running has always bugged me but it never =
became a high
priority target until this week. We started using the hash equivalence =
server a
few months back and just recently, CI pipelines of what should have =
otherwise
been all cached work started talking hours and hours. This current issue =
might
not be completely responsible for what we were rebuilding since all CI =
runners
experience the same recipe space checkout path. Which means even though =
the full
recipe paths are in the sstate cache objects, they are the same for all =
runners.

Your confirmation that we did find something so core and were able to =
fix it
gives us more confidence to take a crack at the other issues we're =
seing. ;)

>=20
> I've taken the opportunity to make the code slightly clearer so have
> written and sent a modified version of your patch. I hope that is ok!
> Please take a look and let me know if I've missed anything too.
>=20

It looks good, just using a slightly different method than the patch I =
sent:
=
https://lists.openembedded.org/g/bitbake-devel/topic/patch_siggen/76318034=


Can you share why you remade it?


Also, my colleague Maxime mentioned test cases... It would be nice to =
write
actual unit tests targetted directly on this function so I would then be =
able to
submit with more confidence the refactored version of the function I =
included in
the RFC just above here. (I still would like the community's review on =
it and
comments on the advantages I submitted BTW.)

Perhaps if someone more familiar with these parts could send a list of =
possible
formats the function encounters in all the different scenarios and give =
dummy
before -> after strings. I could bundle this into unit tests along with =
my
refactored function in an upcoming series.

Example: *
=
'virtual:something:/full/path/to/poky/meta/recipes-whatever/helloworld/hel=
loworld_1.2.3.bb:do_sometask'
--> 'helloworld/helloworld_1.2.3.bb:do_sometask:virtual:something' * =
'mc:...' ->
'...' * etc.


Thanks for your thoughts and the rapid feedback!



