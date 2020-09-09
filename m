Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web10.9603.1599693958621848120
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2020 16:25:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=OmgXzAU8;
 spf=pass (domain: gmail.com, ip: 209.85.215.176, mailfrom: raj.khem@gmail.com)
Received: by mail-pg1-f176.google.com with SMTP id 5so3206591pgl.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2020 16:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=y4SyGH5ogLV8dG2gkqJPJcyBQIDDqhb9PodWQoVyRcA=;
        b=OmgXzAU8BKVXg5g0IXFhZ7VNjrXo89WE9uaDkt48JT/vJAHk6kxBwILXIz6KzmwVw/
         qLcnfo2DARNkBrzPwjv6GBW1UjjC40pMYtBfhWFs95H7ZiiIQ5IEsh/FTqNAXEecN47a
         /cUpZvcwRGhp3ijk/IgVKCll10EbLrKIyzBrRkfJ/5DncI0ELw3sWROQzCiqHrasp9wN
         o/2h9GLYdYSyr9kzVcn7JtWJeDPlT/es6GelqxgilfXMKF4oiqwWeG6yE9oFbjJVKy8Z
         bwq7Eh4D2KSJrMkZdo4MTJ52g9rNyQmoRlRMy4WbmHIPeGomfdsYi0h7SWLaBuxLQTVR
         HiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to;
        bh=y4SyGH5ogLV8dG2gkqJPJcyBQIDDqhb9PodWQoVyRcA=;
        b=VVBN5Lu+JADw18es75K0rlVrEXZvMmckZOj2kDoHJnG2ankAlqvoa60pX049ivY4tL
         NGaDOYvRbdWgbu8DjmJmNzscYVHDppZg6yjuzLlzlEFpjE1vcp8YCaSVVNjjuvMNN1Ek
         SJ2Aj03KAqlgHvp/ClmiY24upXeU37A/Kw8Z78b9RH0oz3g6xR6qJQ6ImgL92/46H8ZE
         bwJzLa4AwVurnUQcrYUfDBch8Et6SoYC1MGygVo3m/a5K0u3MzcQp+ZgiXxP8iHgm9zy
         nfd82wIJmfrMesJbhSMOh8Uaa3W0QwZ9QSF32DnHDkX9DPiAbPzVgl6lnHJiFiYvVvs6
         LKTA==
X-Gm-Message-State: AOAM530B5DsmTAfHto8p/H7+CEalAf0uSm+oJ+TZ+O1Cw5//qeXh+Wly
	qZ6rriP/eYOkV/xXva3IJm0+d2YBVQcuvQ==
X-Google-Smtp-Source: ABdhPJws5OrB+9xFaMTo/f3R8I2T0Yos8VXCfacQXqkHZ1yJfClKmQHre6JDElhnKTU0fYgStWbXmw==
X-Received: by 2002:a62:7d91:0:b029:13e:d13d:a061 with SMTP id y139-20020a627d910000b029013ed13da061mr2783810pfc.39.1599693957639;
        Wed, 09 Sep 2020 16:25:57 -0700 (PDT)
Return-Path: <raj.khem@gmail.com>
Received: from ?IPv6:2601:646:9200:4e0::ff6e? ([2601:646:9200:4e0::ff6e])
        by smtp.gmail.com with ESMTPSA id s16sm2829133pgl.78.2020.09.09.16.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 16:25:56 -0700 (PDT)
Subject: Re: [bitbake-devel] an idea about parallel doing do_patch
To: Mikko Rapeli <mikko.rapeli@bmw.de>, zhangyifan46@huawei.com
Cc: bitbake-devel@lists.openembedded.org
References: <iYPR.1599467249227446374.EQbU@lists.openembedded.org>
 <20200907083711.GL2026@korppu>
From: "Khem Raj" <raj.khem@gmail.com>
Autocrypt: addr=raj.khem@gmail.com; keydata=
 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
Organization: HIMVIS LLC
Message-ID: <b39c3efd-a6a3-90fd-556e-e78fcbf8fc22@gmail.com>
Date: Wed, 9 Sep 2020 16:25:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907083711.GL2026@korppu>
X-Groupsio-MsgNum: 11687
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="569LrADwerRXKFNiBv2qDpRUjOE3JuxKA"

--569LrADwerRXKFNiBv2qDpRUjOE3JuxKA
Content-Type: multipart/mixed; boundary="8gJUBB4RFwu1IPgsnYoCYkNGomRx4o7nc";
 protected-headers="v1"
From: Khem Raj <raj.khem@gmail.com>
To: Mikko Rapeli <mikko.rapeli@bmw.de>, zhangyifan46@huawei.com
Cc: bitbake-devel@lists.openembedded.org
Message-ID: <b39c3efd-a6a3-90fd-556e-e78fcbf8fc22@gmail.com>
Subject: Re: [bitbake-devel] an idea about parallel doing do_patch
References: <iYPR.1599467249227446374.EQbU@lists.openembedded.org>
 <20200907083711.GL2026@korppu>
In-Reply-To: <20200907083711.GL2026@korppu>

--8gJUBB4RFwu1IPgsnYoCYkNGomRx4o7nc
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 9/7/20 1:37 AM, Mikko Rapeli wrote:
> Hi,
>=20
> On Mon, Sep 07, 2020 at 01:27:29AM -0700, zhangyifan46 via lists.openemb=
edded.org wrote:
>> In our peoject,we have suffered a lot from long duration of do_patch of=
 linux kernel(3000+ patches). I found that one do_patch task uses only one =
process. So I modify a llittle do do_patch task. Here is my idea:
>> 1.analyse the patches,only getting the modified files of each patch.
>> 2.cluster all patches according to the files modified( patch no.1 modif=
ies file A,B ,patch no.2 modifies file A, patch no.3 modifies file C,then w=
e cluster patch no.1 and no.2 as=A0 a group, patch no.3 as another group) ,=
 here I use union-find to do the cluster
>> 3.assign one group on one process
>> But I met the problem of probabilistic missing patches.
>> Anyone has any comments about my idea?
>=20
> I think having large patch sets in meta layers and applied with bitbake =
are not the
> right solution. I would create a custom git repo and branch for large fo=
rks/branches
> like this.
>=20

right, I think thousands of patches via patch management tools like
quilt is going to be cumbersome, I think best approach here would be to
fork kernel tree and maintain your patches on a branch. It will ease out
maintenance as well as build times. Ofcourse it means you have to adopt
a good process to manage your kernel branch so it does not spin into a
maintenance problems either.

> Possibly it could also be possible to apply patches with git through mbo=
x files, but
> I don't think this will much faster than bitbake.


>=20
> Hope this helps,
>=20
> -Mikko
>=20
>>
>>
>>=20


--8gJUBB4RFwu1IPgsnYoCYkNGomRx4o7nc--

--569LrADwerRXKFNiBv2qDpRUjOE3JuxKA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSPpVvapDR0rgZCCc27BTNVkZ0zFAUCX1lkfQAKCRC7BTNVkZ0z
FPKBAKCE8y2t2naleM7UVZ/FQxliYAco3ACggPJGpIlgm0VE//XgzfQyFmdu57o=
=CJDS
-----END PGP SIGNATURE-----

--569LrADwerRXKFNiBv2qDpRUjOE3JuxKA--
