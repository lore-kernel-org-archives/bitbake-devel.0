Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
 by mx.groups.io with SMTP id smtpd.web12.13573.1591370572953779439
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 08:22:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZlJsi/Ri;
 spf=pass (domain: gmail.com, ip: 209.85.216.67, mailfrom: jpewhacker@gmail.com)
Received: by mail-pj1-f67.google.com with SMTP id k2so2710709pjs.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2020 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language;
        bh=iwPZIUlGWXJi6X+sMUhapGSEivhTk+gBUnyODN1KEfw=;
        b=ZlJsi/RiXEX8tl46qKfQnMM4vBhoQT361Ux8s9D3TTeDfC8U35B4hVykBhKE/0vtJO
         HpFiInJRprBFzied48pSOpmwTkFerrPHnQLWwS5CgAu0gbEhFSxJ52R46/KOE9tpgdQZ
         FdqFtdxhFo4Tf6VZDyrhwQIGsmVmoDuBE4inyIcjsz7i7LCbxK9Eml+nArih+Q7omuwJ
         ycZesFjnXbh1m4jSifKEHuaI0jOgcg3uj5CywZ8TmmavdaRggiVKIgUtlWzJ8TbDyCOP
         ZdrvJrlM7NnXXKdGshmoHSXjsSwOZvNS0/OP5X4b7ayDdsgRm48V4J3Oxu8yuoa0xdQk
         bXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=iwPZIUlGWXJi6X+sMUhapGSEivhTk+gBUnyODN1KEfw=;
        b=b6hQLVkxjYKgrKxQJsjb9UfClEsZYXPCYpCevvONTqOzEOU+BkXjH0NLTj94J+rEi6
         T9d04r/inNjqYHyK9ZhDjHES61jyb84q0llmvZWyPjImHLg8x57iCyxH+CAV2a9+pbFF
         U8fv9euoFJWcDqQeUoWUKrac2IevPBXCMEheIhg9riJC8vuEjbXZMqtliMcLNNRvWfp3
         T5hQSOq0XGyr/O7cS1v87UxGrZwIR2JVIdT1wwoDvGzPud40+NMfYN8mJtu+yWAsKkKW
         zJeX3Nyz77SlTbo5m/IzGWxZXSI9XFZr9HNm0nSDuEFDwOoxE/1zY1A1I/W5BUftd/Wj
         pJjA==
X-Gm-Message-State: AOAM532bm09RYlpmJWH7xGutCLV00gxX59uT5uI2cbf7hDsmF3zF2xXJ
	CTGtIXCJpz4+3Qy3COw/pF7OssXVkes=
X-Google-Smtp-Source: ABdhPJwbQls53CZhqqkqJMhZH99tnYVqzR3e1LJyjRudXsAxSSdaRTxfwrNaH8KcyJyy8L6altv3Lg==
X-Received: by 2002:a17:90a:f485:: with SMTP id bx5mr3739990pjb.77.1591370571976;
        Fri, 05 Jun 2020 08:22:51 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from ?IPv6:2605:a601:ac3d:c100:28:333f:5748:fb55? ([2605:a601:ac3d:c100:28:333f:5748:fb55])
        by smtp.gmail.com with ESMTPSA id h35sm9117306pje.29.2020.06.05.08.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 08:22:50 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [bitbake-devel][PATCH v4 0/8] Add support for per-multiconfig BBMASK
To: Alejandro Hernandez Samaniego <alhe@linux.microsoft.com>,
 bitbake-devel@lists.openembedded.org
References: <20200603025405.26885-1-JPEWhacker@gmail.com>
 <20200605015325.35395-1-JPEWhacker@gmail.com>
 <09fa0315-1536-1896-a4a4-f3771637ba17@linux.microsoft.com>
Message-ID: <9265b155-8cfe-2253-0151-e300cacb65d6@gmail.com>
Date: Fri, 5 Jun 2020 10:22:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <09fa0315-1536-1896-a4a4-f3771637ba17@linux.microsoft.com>
Content-Type: multipart/alternative;
 boundary="------------DE5603C7F89E429EB415FCD5"
Content-Language: en-US

--------------DE5603C7F89E429EB415FCD5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/5/20 2:29 AM, Alejandro Hernandez Samaniego wrote:
>
> Hey Joshua,
>
> Interesting approach, it looks good, it does look like the next step 
> that has to be taken, initially this would have been too invasive but 
> I think this should be fine.
>
> Do you have data on the performance increase/decrease by using 
> multiple caches?, are there any implications?
>
I don't have numbers, but my feeling is that it should be roughly the 
same. It's the same amount of data being cached and same number of 
recipes being parsed, the only difference is that the same cache data is 
split between multiple files instead of included in a single one.

There might be a bit of performance degredation since the recipe file 
access pattern has changed (e.g. it now parses all files for a given 
multiconfig in series before moving to the next multiconfig instead of 
parsing each file for each multiconfig), but I don't expect that to be 
too significant of an issue.

>
> Cheers,
>
> Alejandro
>
>
> On 6/4/20 6:53 PM, Joshua Watt wrote:
>> Splits apart the bitbake configuration data and caches so that each
>> defined multiconfig can specify as separate BBMASK independently of the
>> other multiconfigs. This can take multiple forms, such as a `BBMASK` in
>> a multiconfig .conf file, or BBMASK assignment based on an override (see
>> linked bugzilla for an example).
>>
>> The most noticeable change is that bitbake now keeps a parsing cache
>> file for each multiconfig instead of a single parsing cache file that
>> caches all multiconfigs.
>>
>> [YOCTO #13721]
>>
>> V2: Fixes some syntax errors in tinfoil
>>
>> V3: Optimizes caches so that each one only caches the files for it's own
>> multiconfig
>>
>> V4: Fixes compatability with Python < 3.6
>>      Renames split_pn -> split_mc
>>
>> Joshua Watt (8):
>>    bitbake: cooker: Split file collections per multiconfig
>>    bitbake: cache: Use multiconfig aware caches
>>    bitbake: lib: Add support for Logging Adapters
>>    bitbake: lib: Add PrefixLoggerAdapter helper
>>    bitbake: cache: Improve logging
>>    bitbake: cache: Cache size optimization
>>    bitbake: tests: Add tests for BBMASK in multiconfig
>>    bitbake: command: Move split_mc_pn to runqueue
>>
>>   bitbake/lib/bb/__init__.py                    |  50 +++-
>>   bitbake/lib/bb/cache.py                       | 228 ++++++++++++------
>>   bitbake/lib/bb/command.py                     |  39 +--
>>   bitbake/lib/bb/cooker.py                      | 159 +++++++-----
>>   bitbake/lib/bb/runqueue.py                    |  17 +-
>>   .../bb/tests/runqueue-tests/conf/bitbake.conf |   3 +-
>>   .../runqueue-tests/conf/multiconfig/mc1.conf  |   1 +
>>   .../runqueue-tests/conf/multiconfig/mc2.conf  |   1 +
>>   .../recipes/fails-mc/fails-mc1.bb             |   5 +
>>   .../recipes/fails-mc/fails-mc2.bb             |   4 +
>>   bitbake/lib/bb/tests/runqueue.py              |  15 ++
>>   bitbake/lib/bb/tinfoil.py                     |  26 +-
>>   bitbake/lib/bblayers/query.py                 |   4 +-
>>   13 files changed, 380 insertions(+), 172 deletions(-)
>>   create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
>>   create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb
>>
>>
>> 

--------------DE5603C7F89E429EB415FCD5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/5/20 2:29 AM, Alejandro Hernandez
      Samaniego wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:09fa0315-1536-1896-a4a4-f3771637ba17@linux.microsoft.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>Hey Joshua,</p>
      <p>Interesting approach, it looks good, it does look like the next
        step that has to be taken, initially this would have been too
        invasive but I think this should be fine.</p>
      <p>Do you have data on the performance increase/decrease by using
        multiple caches?, are there any implications?</p>
    </blockquote>
    <p>I don't have numbers, but my feeling is that it should be roughly
      the same. It's the same amount of data being cached and same
      number of recipes being parsed, the only difference is that the
      same cache data is split between multiple files instead of
      included in a single one.</p>
    <p>There might be a bit of performance degredation since the recipe
      file access pattern has changed (e.g. it now parses all files for
      a given multiconfig in series before moving to the next
      multiconfig instead of parsing each file for each multiconfig),
      but I don't expect that to be too significant of an issue.</p>
    <blockquote type="cite"
      cite="mid:09fa0315-1536-1896-a4a4-f3771637ba17@linux.microsoft.com">
      <p><br>
      </p>
      <p>Cheers,</p>
      <p>Alejandro<br>
      </p>
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 6/4/20 6:53 PM, Joshua Watt wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:20200605015325.35395-1-JPEWhacker@gmail.com">
        <pre class="moz-quote-pre" wrap="">Splits apart the bitbake configuration data and caches so that each
defined multiconfig can specify as separate BBMASK independently of the
other multiconfigs. This can take multiple forms, such as a `BBMASK` in
a multiconfig .conf file, or BBMASK assignment based on an override (see
linked bugzilla for an example).

The most noticeable change is that bitbake now keeps a parsing cache
file for each multiconfig instead of a single parsing cache file that
caches all multiconfigs.

[YOCTO #13721]

V2: Fixes some syntax errors in tinfoil

V3: Optimizes caches so that each one only caches the files for it's own
multiconfig

V4: Fixes compatability with Python &lt; 3.6
    Renames split_pn -&gt; split_mc

Joshua Watt (8):
  bitbake: cooker: Split file collections per multiconfig
  bitbake: cache: Use multiconfig aware caches
  bitbake: lib: Add support for Logging Adapters
  bitbake: lib: Add PrefixLoggerAdapter helper
  bitbake: cache: Improve logging
  bitbake: cache: Cache size optimization
  bitbake: tests: Add tests for BBMASK in multiconfig
  bitbake: command: Move split_mc_pn to runqueue

 bitbake/lib/bb/__init__.py                    |  50 +++-
 bitbake/lib/bb/cache.py                       | 228 ++++++++++++------
 bitbake/lib/bb/command.py                     |  39 +--
 bitbake/lib/bb/cooker.py                      | 159 +++++++-----
 bitbake/lib/bb/runqueue.py                    |  17 +-
 .../bb/tests/runqueue-tests/conf/bitbake.conf |   3 +-
 .../runqueue-tests/conf/multiconfig/mc1.conf  |   1 +
 .../runqueue-tests/conf/multiconfig/mc2.conf  |   1 +
 .../recipes/fails-mc/fails-mc1.bb             |   5 +
 .../recipes/fails-mc/fails-mc2.bb             |   4 +
 bitbake/lib/bb/tests/runqueue.py              |  15 ++
 bitbake/lib/bb/tinfoil.py                     |  26 +-
 bitbake/lib/bblayers/query.py                 |   4 +-
 13 files changed, 380 insertions(+), 172 deletions(-)
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb

</pre>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------DE5603C7F89E429EB415FCD5--
