Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C265C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 13:43:31 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web10.8201.1742391810056060520
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Mar 2025 06:43:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=t65dTAyW;
 spf=softfail (domain: sakoman.com, ip: 209.85.128.177, mailfrom: steve@sakoman.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6fecfae554bso61822967b3.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1742391809; x=1742996609; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LYVK4medbwMUX1jwTpoKdAix/t/ZyBu2KhPJ2B7uoU=;
        b=t65dTAyWFUKL40axjkbicdv7rNTh+4umvAm6+3Y+mqbZEZ2djqsq03129ZRVYJLKmC
         lPbY86C26Zb7gE2ykfhpqJ/tNvTbWgx07uJKWO0u9lhftR1tvmuyvJAwoX2NN29mTHYE
         1gvZQ8xq1fY60yld4FI523ddcThJFoOjUWK6T5fSvQMgDaqVQo+6GH+NcEWoKtZ5e1eS
         E7lZE1t4kf9OWrr4fweAtq4yk65PYc4J1CU+XlnQkoRo87ROkIflLjYrebfo7kuQxMHw
         jYOb+Tct0UmiP6fi+RPEnpKmWW71dK9f0yg1Wc8Foz71vXjeKaC2JiAfEiVZ+T0jw1AR
         ib9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742391809; x=1742996609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LYVK4medbwMUX1jwTpoKdAix/t/ZyBu2KhPJ2B7uoU=;
        b=RAxw2h9mzfoPmtiukjqZR0MYTLI75LJ41HzuPz5/ByScbxhNous2cdkV+j7DP78FM5
         W0amHzRehfF4idWt6PC2/c2EiVg2sDc4mXy65Swulp6XxRnmDxlD8Fppw1mTJjMHRjVI
         Vgpm6kGN2V4Ac8nwrTEgcoUCSAhAR3JqlZqoi7BuyhigdLprCwPim+ztw+yIQC4u666m
         8v6fOFv3DskRGBg9KVSEXFbXWxDQmyQGH9QZRDb3/7TxLEgOlVqORLvA2+hCxw7/6vsZ
         wqCEQovx1yma6JSXuOWtH83rWvNCo2Mj+UUOk57tKOLENOStgSz3aI5pLxz+nkNKFwBz
         lbRA==
X-Gm-Message-State: AOJu0Yxi9FhuVqeEsJ9LyhfuckV7YFXlNw47tn857S83LnwvAmOElbJF
	bLwsJrhsMFTM4/yDettZlWcyF5lnDTYJ0owS+j9AXOm6YptQEzLaeJkFG1iOvETBcKVUgCFqnmI
	gyoTtCkSZrYoN6KfYQi6urMRk6UbxMtOmX5Dz6g==
X-Gm-Gg: ASbGncvh4PUY7LKrdY/cxZdAVr6kfjWNuCRLHBHK3JG2BM3mKODmz2+d+FTN40/jiLz
	n4P/UI+odLIzZ6JzobdL44ftidBYGJWaZlTF3RI0GEVX5XFVL9K9hvTeknfLKVzpEmEC1uG8ktc
	NhQjdy/XJ5QXrovxAFJsroCqh5Mm/bC/Kmq8d1qLCFAosAk4/FR9T6v78yBg==
X-Google-Smtp-Source: AGHT+IGT3lFCubeAb58zDG/EJ581im8k/shg9dLHOqaSUcAZ6VT9YdRpBbIwjJP/d4gScYDFVQ4J+FEQe7hRrx4vR0Y=
X-Received: by 2002:a05:690c:6108:b0:6ef:48ac:9d0c with SMTP id
 00721157ae682-7009c127c6fmr36640757b3.25.1742391809166; Wed, 19 Mar 2025
 06:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1741808747.git.steve@sakoman.com> <da5f41996687e18b78d9c9845e621d832115aa1e.1741808747.git.steve@sakoman.com>
 <CAD=4a=Umi_YD9i=FB+412DQJLLi4b_AdDn0MeTWiBMMmZ+WE3w@mail.gmail.com>
In-Reply-To: <CAD=4a=Umi_YD9i=FB+412DQJLLi4b_AdDn0MeTWiBMMmZ+WE3w@mail.gmail.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Wed, 19 Mar 2025 06:43:18 -0700
X-Gm-Features: AQ5f1JqXFDQzLDLxKfQWHcqyDxYl8DMrzHtyBil1B-nPzdqzJdxAjWxybaKipI0
Message-ID: <CAOSpxdaupXeT4cg9jMOfzB2fE+Lmt6e679-igdqKc42qw-PfQQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][kirkstone][2.0][PATCH 1/1] siggen.py:
 Improve taskhash reproducibility
To: Ernst Persson <ernstp@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 13:43:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17468

On Wed, Mar 19, 2025 at 1:05=E2=80=AFAM Ernst Persson <ernstp@gmail.com> wr=
ote:
>
> I tried building in an old kirkstone workspace with this patch applied an=
d I got a lot of taskhash mismatch errors.
> After deleting tmp and cache the build was fine, though it did rebuild ev=
erything from scratch.
> Does this need bumping of something like HASHEQUIV_HASH_VERSION or SSTATE=
_VERSION... ?

I didn't see any taskhash mismatch errors in any of my testing, so I'm
not sure what happened in your build!

I don't think bumps to HASHEQUIV_HASH_VERSION or SSTATE_VERSION are
required, but perhaps Richard can confirm.

Steve

> Den ons 12 mars 2025 kl 20:48 skrev Steve Sakoman via lists.openembedded.=
org <steve=3Dsakoman.com@lists.openembedded.org>:
>>
>> From: Paulo Neves <paulo@myneves.com>
>>
>> file checksums are part of the data checksummed
>> to generate the task hash. The list of file checksums
>> was not ordered.
>>
>> In this commit we make sure the task hash checksum takes
>> a list of checksum data that is ordered by unique file name
>> thus guaranteeing reproducibility.
>>
>> Signed-off-by: Paulo Neves <paulo@myneves.com>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
>> Signed-off-by: Steve Sakoman <steve@sakoman.com>
>> ---
>>  lib/bb/siggen.py | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
>> index 0a9ce0ede..828729d8b 100644
>> --- a/lib/bb/siggen.py
>> +++ b/lib/bb/siggen.py
>> @@ -331,7 +331,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
>>          for dep in self.runtaskdeps[tid]:
>>              data +=3D self.get_unihash(dep)
>>
>> -        for (f, cs) in self.file_checksum_values[tid]:
>> +        for (f, cs) in sorted(self.file_checksum_values[tid], key=3Dcle=
an_checksum_file_path):
>>              if cs:
>>                  if "/./" in f:
>>                      data +=3D "./" + f.split("/./")[1]
>> @@ -393,7 +393,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
>>          if runtime and tid in self.taskhash:
>>              data['runtaskdeps'] =3D self.runtaskdeps[tid]
>>              data['file_checksum_values'] =3D []
>> -            for f,cs in self.file_checksum_values[tid]:
>> +            for f,cs in sorted(self.file_checksum_values[tid], key=3Dcl=
ean_checksum_file_path):
>>                  if "/./" in f:
>>                      data['file_checksum_values'].append(("./" + f.split=
("/./")[1], cs))
>>                  else:
>> @@ -720,6 +720,12 @@ class SignatureGeneratorTestMulticonfigDepends(Sign=
atureGeneratorBasicHash):
>>      name =3D "TestMulticonfigDepends"
>>      supports_multiconfig_datacaches =3D True
>>
>> +def clean_checksum_file_path(file_checksum_tuple):
>> +    f, cs =3D file_checksum_tuple
>> +    if "/./" in f:
>> +        return "./" + f.split("/./")[1]
>> +    return f
>> +
>>  def dump_this_task(outfile, d):
>>      import bb.parse
>>      fn =3D d.getVar("BB_FILENAME")
>> --
>> 2.43.0
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#17438): https://lists.openembedded.org/g/bitbake-dev=
el/message/17438
>> Mute This Topic: https://lists.openembedded.org/mt/111666877/4947266
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [ernst=
p@gmail.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>

