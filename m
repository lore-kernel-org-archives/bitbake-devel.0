Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E293C7EE23
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 18:14:03 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.1671.1677521641775213578
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Feb 2023 10:14:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=4qtBqNBo;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id bw19so7151067wrb.13
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 10:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/5Pw2bFF/f1hV6JyS3s2VoeifEM2btOezBtl7DbdN4I=;
        b=4qtBqNBoYpzUyCqBfWgnv79OZ3rr84ksp1b8MN+VWmFXrvWk0SNz2be8UlcvdA6wyo
         kxd+PB4dLp5DNTw8BlKg5Vxlk2S1avNvx/BVQE/71Ry+b2ofVrQuuIbnRaIQBBnv8jVs
         QX9x975tsCywZAnBkn6mmqkSbGvqtIfzI8CQpVz5XyUccxbQIhebtmgfQ09oh4nS7BHR
         ubq+Z5+vHR4lDKT86T7muno4PnTGe81X0n+EblqqkOE2Cv/S0Pq9K6UTm8oMDYz0HIBn
         OoTPHagUDAcgCjAQp8nYZMzIALem8TLiHe5r/LqG9Dcj7RSRPvErcwSbU3uoTQVsmXQN
         nMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5Pw2bFF/f1hV6JyS3s2VoeifEM2btOezBtl7DbdN4I=;
        b=bCsqrWkM4/TmvOwjAVE7o/7S0NpprT/OwBHKplKLi70wxZeUuD++TsS0WruaTc9j3h
         2+gMjmH7gj6ap1Q+w92KB5GsAECN67S6v6ugcMvIfROMxoyxf466VO8+lnAm3ymj6iA5
         BoJZl/2amPcY/8GdFLw9nSS4knET9lplJ4rDUHmjK1Hf9MQo7D+GI04GWhtScsmgyVFR
         q9vyWCp493VFS6sJTWnXgj8WIwMksmjGNgKiv5X4DSxsD6UG2exVdm9YFpauhYsef17B
         kDi3V3joAGsWwSFs6exT0kCyg8MZoZHG1Io0W5YjBQhy6jNVIpndDeG2yCCtyipSOSh5
         gcTw==
X-Gm-Message-State: AO0yUKUuqjbRhoMdkna23qAfbLKfXElQor88Fi6D7cP2yMECqSl9+eIq
	JUD1SCOR3tn08fhkwIO9r2yolA==
X-Google-Smtp-Source: AK7set+T/5ap0JxFCJpLkHqmNGzirS/Z0ZJCCeCL8Ide0P6ALZFebp4BCljFaEdFPpe9IzVJI1rliA==
X-Received: by 2002:a05:6000:88:b0:2c9:7ed3:6801 with SMTP id m8-20020a056000008800b002c97ed36801mr75175wrx.26.1677521640024;
        Mon, 27 Feb 2023 10:14:00 -0800 (PST)
Received: from [192.168.0.28] (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id y14-20020adfee0e000000b002c71b4d476asm7873043wrn.106.2023.02.27.10.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 10:13:59 -0800 (PST)
Message-ID: <4984ee49-eb42-4891-f9fc-7ce7dc79f2ab@smile.fr>
Date: Mon, 27 Feb 2023 19:13:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bitbake-devel] [PATCH v2 2/2] bitbake-user-manual: update Hello
 World example
Content-Language: en-US
To: Michael Opdenacker <michael.opdenacker@bootlin.com>,
 Fawzi KHABER <fawzi.khaber@smile.fr>, bitbake-devel@lists.openembedded.org
Cc: Ever ATILANO <ever.atilano@smile.fr>,
 YP docs mailing list <docs@lists.yoctoproject.org>
References: <20230227135115.29202-1-fawzi.khaber@smile.fr>
 <20230227135115.29202-2-fawzi.khaber@smile.fr>
 <3ffcb4a2-f71e-cf47-29fd-bb2073316821@bootlin.com>
From: Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <3ffcb4a2-f71e-cf47-29fd-bb2073316821@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 18:14:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14503

Hi Michael,

On 2/27/23 18:42, Michael Opdenacker wrote:
>>         When you run BitBake, it begins looking for metadata files. The
>>       :term:`BBPATH` variable is what tells BitBake where
>> @@ -254,17 +242,6 @@ Following is the complete "Hello World" example.
> 
> 
> Wait, before this, it seems you forgot to update the output of the "bitbake" command right after setting the BBPATH variable. Or maybe you didn't work with the "master" branch. Here's what I get when I use bitbake from the current Poky master branch:
> 
> $bitbake
> Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.
> 
> Unless there's something in my environment that makes BitBake behave differently, but that's worth double checking anyway.

FYI, we already did some back and forth internally on this ^^

Be sure to have the BBPATH envvar unset before starting. Its really easy mixing shells and reusing one that did have a OE env sourced at some point and so an active BBPATH envvar.

Here is a minimal script I used to reproduce the output in the patch.

  $ printenv |grep BBPATH # ensure $BBPATH is not set
  $ git clone git://git.openembedded.org/bitbake # clone latest master bitbake
  $ cd bitbake/
  $ ./bin/bitbake --version
  BitBake Build Tool Core version 2.3.1
  
  $ export PATH=$PWD/bin:$PATH
  $ which bitbake # must point to the above bitbake
  
  $ mkdir ../hello && cd ../hello/
  $ bitbake
  ERROR: The BBPATH variable is not set and bitbake did not find a conf/bblayers.conf file in the expected location.
  Maybe you accidentally invoked bitbake from the wrong directory?

I guess the following differences come from the same reason.

Can you try again with the above script?
>>       exists, you can run the ``bitbake`` command again::
>>            $ bitbake
>> -       ERROR: Traceback (most recent call last):
>> -         File "/home/scott-lenovo/bitbake/lib/bb/cookerdata.py", line 163, in wrapped
>> -           return func(fn, *args)
>> -         File "/home/scott-lenovo/bitbake/lib/bb/cookerdata.py", line 177, in _inherit
>> -           bb.parse.BBHandler.inherit(bbclass, "configuration INHERITs", 0, data)
>> -         File "/home/scott-lenovo/bitbake/lib/bb/parse/parse_py/BBHandler.py", line 92, in inherit
>> -           include(fn, file, lineno, d, "inherit")
>> -         File "/home/scott-lenovo/bitbake/lib/bb/parse/parse_py/ConfHandler.py", line 100, in include
>> -           raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), oldfn, lineno)
>> -       ParseError: ParseError in configuration INHERITs: Could not inherit file classes/base.bbclass
>> -
>>          ERROR: Unable to parse base: ParseError in configuration INHERITs: Could not inherit file classes/base.bbclass
>>         In the sample output,
> 
> 
> Same here. At this stage on Poky master, I get:
> $bitbake
> Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.
> 
>> @@ -284,7 +261,10 @@ Following is the complete "Hello World" example.
>>         $ mkdir classes
>>         Move to the ``classes`` directory and then create the
>> -    ``base.bbclass`` file by inserting this single line: addtask build
>> +    ``base.bbclass`` file by inserting this single line::
>> +
>> +      addtask build
>> +
>>       The minimal task that BitBake runs is the ``do_build`` task. This is
>>       all the example needs in order to build the project. Of course, the
>>       ``base.bbclass`` can have much more depending on which build
> 
> 
> Good catch. This is ugly in the current docs.
> 
>> @@ -328,10 +308,11 @@ Following is the complete "Hello World" example.
>>         BBFILES += "${LAYERDIR}/*.bb"
>>         BBFILE_COLLECTIONS += "mylayer"
>>         BBFILE_PATTERN_mylayer := "^${LAYERDIR_RE}/"
>> +      LAYERSERIES_COMPAT_mylayer = "dunfell"
> 
> You may mention that "dunfell" is just an example, and should be adapted to the OpenEmbedded-Core version(s) that your layer supports. By the way, "kirkstone" should be a better choice as it should last longer than "dunfell".
> 
> By the way, wishing we had a DISTRO_NAME_NO_CAP macro like in the YP manual, but that's will be a separate topic.
> 
>>         For information on these variables, click on :term:`BBFILES`,
>> -    :term:`LAYERDIR`, :term:`BBFILE_COLLECTIONS` or :term:`BBFILE_PATTERN_mylayer <BBFILE_PATTERN>`
>> -    to go to the definitions in the glossary.
>> +    :term:`LAYERDIR`, :term:`BBFILE_COLLECTIONS`, :term:`BBFILE_PATTERN_mylayer <BBFILE_PATTERN>`
>> +    or :term:`LAYERSERIES_COMPAT` to go to the definitions in the glossary.
>>         You need to create the recipe file next. Inside your layer at the
>>       top-level, use an editor and create a recipe file named
>> @@ -389,12 +370,14 @@ Following is the complete "Hello World" example.
> 
> 
> Before this too, I don't have the same output when I run "bitbake printhello" for the first time:
> 
> $ bitbake printhello
> ERROR: Nothing PROVIDES 'printhello'
> 
>>       target::
>>            $ bitbake printhello
>> +       Loading cache: 100% |
>> +       Loaded 0 entries from dependency cache.
>>          Parsing recipes: 100% |##################################################################################|
>> -       Time: 00:00:00
>>          Parsing of 1 .bb files complete (0 cached, 1 parsed). 1 targets, 0 skipped, 0 masked, 0 errors.
>>          NOTE: Resolving any missing task queue dependencies
>> -       NOTE: Preparing RunQueue
>> -       NOTE: Executing RunQueue Tasks
>> +       Initialising tasks: 100% |###############################################################################|
>> +       NOTE: No setscene tasks
>> +       NOTE: Executing Tasks
>>          ********************
>>          *                  *
>>          *  Hello, World!   *
> 
> 
> Weird, I believe I followed the instructions correctly, but I still have:
> ERROR: Nothing PROVIDES 'printhello'
> 
> This will probably help to know which version of Bitbake you're using. For documentation in "master", you should be using "master" too.
> 
> Sorry for all this changes, but it's great to fix an outdated version. If you lack time, I'll be happy to suggest a V2 that you could review then. Let me know...
> 
> Thanks again
> Michael.
> 

-- 
Yoann Congal
Smile ECS - Tech Expert

