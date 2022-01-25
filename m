Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AA4C433EF
	for <webhook@archiver.kernel.org>; Tue, 25 Jan 2022 12:55:43 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web09.6516.1643115341841708472
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Jan 2022 04:55:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=kW1rLW5e;
 spf=pass (domain: gmail.com, ip: 209.85.167.50, mailfrom: ptsneves@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id x11so56639829lfa.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Jan 2022 04:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=1oDyOuotbkQC0gPODkb4uxu/M2kPg+agM4RW5TbsLuY=;
        b=kW1rLW5eWeCZFPR4QIRkIWMjTyTNZPykbAzZH2c6PNQdCuguNJKif6LVsed25FJcoH
         HhcTFf6lML6fXNUbD3OU4FU+OZikYR1XDeo4cgaPY3ci2d1nkZYsW7Bj4QeW1G1D9PiY
         OZZK0E32V35B3B+MlB0EmimwxtTb989OMnOklf6PVoa/SbvcvJGL1h84+LYMeWwohzIr
         RyhO0oIj7PIyqx9W1YOrkQ7ADRUh3QDGDvWikMBRRGe/M84oQkxcM5xySKg+3dXwsnBg
         YPono4z3vLO8xVSY+PpB8AW+p0pOIDTB5mmCMf0+O6bbddnX45W2qKS4Hj3ARCMO/kFZ
         yJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1oDyOuotbkQC0gPODkb4uxu/M2kPg+agM4RW5TbsLuY=;
        b=GMJkTTsj3ppHzzA6K/LiuqovUItm8g7H2LgsckgTtXi72R9AsD7BESvTV/7P9LwNu9
         3+ItjSkyYSUBUyUrH6MEKCt9SZLLehosY6sMoquivNayUeu06GVVGEoNO4cFqtHiPv1o
         WGPUeplXHwzzU+ouPSTPBl9mbepOL/SdmPzHwPuW0yYZQyXyrNRDVoTrE8A3E/mPqd2N
         U2e9q7nLJ+e09C6qTJ+Ct3MXbmAEXA261yDDOkKtIJyAhGVpmxB8UomUmD9G4LSYoedw
         gdEmdWRq0gdt40ybH49kYvsYuZixNA5LD5+or0RS6n0WlayDunv+KLOlto33OV5e1i5y
         qgVQ==
X-Gm-Message-State: AOAM531eFpWiTBWTTW6N0gDU1l2JoElEZDRxUumxHZXg89h8OO57+2mB
	ku/bPn9ntaa8crqjlSERcujE8p38tw==
X-Google-Smtp-Source: 
 ABdhPJwMA3a0fhQy0uYjeN553ZEBzhVnkFgYyePpTYmn71ATArWCqbqIAUp/HTWTlX9leH/IW861oQ==
X-Received: by 2002:a05:6512:3b11:: with SMTP id
 f17mr17641032lfv.431.1643115339691;
        Tue, 25 Jan 2022 04:55:39 -0800 (PST)
Received: from [10.67.202.36] (85-128-83-172.static.ip.netia.com.pl.
 [85.128.83.172])
        by smtp.gmail.com with ESMTPSA id
 k11sm1487381lfg.33.2022.01.25.04.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 04:55:39 -0800 (PST)
Subject: Re: [bitbake-devel] [PATCH]] checksum: Support uri formatted file
 list
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20220121153905.1701521-1-ptsneves@gmail.com>
 <db3861e842d22d49b7c834d9fbc9a5ca613bab01.camel@linuxfoundation.org>
From: Paulo Neves <ptsneves@gmail.com>
Message-ID: <eb092645-2fbd-675e-078d-9dd464ca64ef@gmail.com>
Date: Tue, 25 Jan 2022 13:55:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: 
 <db3861e842d22d49b7c834d9fbc9a5ca613bab01.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Jan 2022 12:55:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13280

I am not aware of it directly being done anywhere but files declared in 
the recipe are in URI form as far as i know. Where in the self test 
should i add such tests?

Paulo Neves

On 1/25/22 1:20 PM, Richard Purdie wrote:
> On Fri, 2022-01-21 at 16:39 +0100, Paulo Neves wrote:
>> Before this commit, if the file list for checksumming had
>> files names with spaces there would be a crash. This happened
>> due to filelist.split breaking on the file names instead of
>> on k:v boundaries. Now we validate this case and emit a fatal
>> error if such case is found. This needs to be fatal as the split
>> will generate broken k:v from then on.
>>
>> Instead of putting literal spaces in the file list the user
>> should urlencode the file names and if they contain coded spaces
>> they will be decoded. This is consistent with the current
>> practice where file names are urlencoded. A reproducer of the
>> issue this commit fixes, was to pass a do_compile[file-checksums]
>> list with files containing spaces in their names, urlencoded or
>> literal.
>>
>> Change-Id: I6ac4f1cffbb86e913883491d46e8cc69a028e992
>> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
>> ---
>>   bitbake/lib/bb/checksum.py | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/checksum.py b/bitbake/lib/bb/checksum.py
>> index fb8a77f6ab..97cf10825e 100644
>> --- a/bitbake/lib/bb/checksum.py
>> +++ b/bitbake/lib/bb/checksum.py
>> @@ -8,6 +8,7 @@
>>   import glob
>>   import operator
>>   import os
>> +import urllib.parse
>>   import stat
>>   import bb.utils
>>   import logging
>> @@ -110,10 +111,14 @@ class FileChecksumCache(MultiProcessCache):
>>   
>>           checksums = []
>>           for pth in filelist.split():
>> -            exist = pth.split(":")[1]
>> +            spl = pth.split(':')
>> +            if len(spl) != 2:
>> +                bb.fatal("found unformatted path in filelist " + pth)
>> +
>> +            exist = spl[1]
>>               if exist == "False":
>>                   continue
>> -            pth = pth.split(":")[0]
>> +            pth = urllib.parse.unquote(spl[0])
>>               if '*' in pth:
>>                   # Handle globs
>>                   for f in glob.glob(pth):
> Does any code currently urlencode the filepaths into this flag?
>
> I think we may also need to add some tests around this to bitbake-selftest...
>
> Cheers,
>
> Richard
>


