Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9752AC19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 13:22:03 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web09.8412.1659532913758819548
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Aug 2022 06:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=qk5OgvNj;
 spf=pass (domain: gmail.com, ip: 209.85.210.45,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f45.google.com with SMTP id
 g19-20020a9d1293000000b0061c7bfda5dfso12206080otg.1
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Aug 2022 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:in-reply-to;
        bh=dwbPkp2Ci3/KkEz427qsWY7hWnMgK6BlJ6uYnyUcx+A=;
        b=qk5OgvNjYiigyH8kofoofME/j/sqpgNbJ9uf4553KWranzMDIEqAcdEV4T9vXyQN0v
         WHmRnHvqBgnISQF6Sa1Xh38R1A5ecB1Su3XNrwEapwFlvpfB8xKwWrF1+VthsW74LWbZ
         8Knuh2tWaNraJC+5IgQsuB2P6zcfwfT8HywEpasEES3uFcAqal3zDaZ760P3DG6rgxJL
         8EwbVkYqnoNVIXkG/wV/S1krmGLkXNT6kJZOVyzpkbfgG35LPTY5NqhBnN1CsWAVnFtL
         yeFWWM8TzV+J/vZGNnjYZAsVGp4qnvHKBJXkoaaF+Ca1kvpWO3jWKKSI+WWwQGHv22zd
         +ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:in-reply-to;
        bh=dwbPkp2Ci3/KkEz427qsWY7hWnMgK6BlJ6uYnyUcx+A=;
        b=THeEDOalYBLKeGHTG/nakWDj7m9oRECQ6G2azjGKSq4SRMOpyo1e50GNFMxiGHejso
         eywqQJKlFHbxQbubiivLcNPa6jwxq1GeYBAuxeB0RO1qM4QCv9EEb2FLZP0FZdP/z+jx
         KQcBmaZyN8lpp9jCWpR2ArETJVc/sgCDLyIxfF9dwPmJEYCI/ILEFfDwdYE6cBuDvzYW
         PYj3JrVl/TUYC5TEIGa+e7sl9mUs6FsjDSn96iffJyjBdltKxwAdf77bdSO3NiRVVGp7
         sHIMUb/rcb20gD++2U7fM/UXVdDujAYNIvugdda9eZazeeAlPldqqfu6b5A9SiGKfqGB
         nkJw==
X-Gm-Message-State: AJIora/axEAbetCthEl4kQYuDd8vreJ7LM+8AXlWy37M7MfAguN1ZVyC
	zwjD+f2SlGMAY33RdsesxvY=
X-Google-Smtp-Source: 
 AGRyM1uzODbTK95M+oNWBxLs+Z3en3CLnORTwzB1J7OKol1nCL5fhHdy1wco4pG06R2L/K+xp0f/OA==
X-Received: by 2002:a9d:4b0a:0:b0:61c:f85a:3d47 with SMTP id
 q10-20020a9d4b0a000000b0061cf85a3d47mr9593481otf.360.1659532912923;
        Wed, 03 Aug 2022 06:21:52 -0700 (PDT)
Received: from ?IPV6:2605:a601:ac3d:c100:e3e8:d9:3a56:e27d?
 ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id
 v20-20020a4ae6d4000000b00435b0a84995sm3959821oot.24.2022.08.03.06.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 06:21:51 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Content-Type: multipart/alternative;
 boundary="------------R08uDMf7kv0mkEZKaEoJZpZy"
Message-ID: <a1e4c7e7-e048-e57a-976f-86584b2970fb@gmail.com>
Date: Wed, 3 Aug 2022 08:21:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bitbake-devel][PATCH v2] siggen: Fix sigtask data not being
 renamed atomically
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 bitbake-devel@lists.openembedded.org
References: <20220801203418.57677-1-JPEWhacker@gmail.com>
 <20220802131405.318201-1-JPEWhacker@gmail.com>
 <29b6f80a-74e8-896c-d02a-cd584d50cfb3@prevas.dk>
In-Reply-To: <29b6f80a-74e8-896c-d02a-cd584d50cfb3@prevas.dk>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Aug 2022 13:22:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13866

This is a multi-part message in MIME format.
--------------R08uDMf7kv0mkEZKaEoJZpZy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/3/22 06:40, Rasmus Villemoes wrote:
> On 02/08/2022 15.14, Joshua Watt via lists.openembedded.org wrote:
>> Signature generation uses mkstemp() to get a file descriptor to a unique
>> file and then write the signature into it, however it closed the file
>> before doing the chmod() and rename() operations. Closing the file means
>> that other mkstemp() could potentially open the same file and race with
>> the chmod() and rename(), causing a error. While it may not sound like
>> this would be very likely, glibc (at least) generates the filename for
>> mkstemp() using the system clock, meaning that it is much more likely
>> for highly parallel builds sharing sstate over NFS to encounter the race
>> condition.
>>
>> To fix the problem, perform the chmod() and rename() while the file is
>> still open, since this prevents other mkstemp() calls from being able to
>> open the file (due to the O_EXCL flag).
> Eh, O_CREAT|O_EXCL should prevent opening an already existing file,
> whether somebody has it open or not, so I don't see how another
> mkstemp() could end up opening "our" file. Unless O_EXCL semantics are
> broken on NFS and only work by accident when the local client does have
> the file open - but what would then prevent other clients with,
> presumably, the exact same system time from clobbering our file, whether
> or not the chmod+rename is done with the fd still held?

Yes, for some reason I had it my head that O_EXCL only affects open 
files; so I'm not sure. Maybe NFS is the culprit :/

>
> The patch is probably fine (as in, shouldn't make anything worse), but I
> think it would be nice to understand just what the problem actually is,
> and if this fixes it, how.

Ya, we are definetely getting errors like:


FileNotFoundError: [Errno 2] No such file or directory: 
'/mnt/releases/sstate/99/sigtask.wq6gkrm7' -> 
'/mnt/releases/sstate/99/sstate:hdparm::9.48:r0::3:990d8b39c15752a2dd68369cb3609283_unpack.tgz.siginfo'

With a backtrace to the os.rename() under heavy load. I don't understand 
how the chmod() can succeed and the rename fail unless there is a race. 
It's very hard to diagnose what went wrong post-mortem.

My other option was to manually add more entropy to the file names by 
prepending some random characters after "sigtask", since the 
"randomeness" of mkstemp() isn't great all tasks use the same sigtask 
file prefix (which increases the likely hood of a collision).
>
> Rasmus
--------------R08uDMf7kv0mkEZKaEoJZpZy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/3/22 06:40, Rasmus Villemoes
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:29b6f80a-74e8-896c-d02a-cd584d50cfb3@prevas.dk">
      <pre class="moz-quote-pre" wrap="">On 02/08/2022 15.14, Joshua Watt via lists.openembedded.org wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Signature generation uses mkstemp() to get a file descriptor to a unique
file and then write the signature into it, however it closed the file
before doing the chmod() and rename() operations. Closing the file means
that other mkstemp() could potentially open the same file and race with
the chmod() and rename(), causing a error. While it may not sound like
this would be very likely, glibc (at least) generates the filename for
mkstemp() using the system clock, meaning that it is much more likely
for highly parallel builds sharing sstate over NFS to encounter the race
condition.

To fix the problem, perform the chmod() and rename() while the file is
still open, since this prevents other mkstemp() calls from being able to
open the file (due to the O_EXCL flag).
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Eh, O_CREAT|O_EXCL should prevent opening an already existing file,
whether somebody has it open or not, so I don't see how another
mkstemp() could end up opening "our" file. Unless O_EXCL semantics are
broken on NFS and only work by accident when the local client does have
the file open - but what would then prevent other clients with,
presumably, the exact same system time from clobbering our file, whether
or not the chmod+rename is done with the fd still held?</pre>
    </blockquote>
    <p><font face="monospace">Yes, for some reason I had it my head that
        O_EXCL only affects open files; so I'm not sure. Maybe NFS is
        the culprit :/</font><br>
    </p>
    <blockquote type="cite"
      cite="mid:29b6f80a-74e8-896c-d02a-cd584d50cfb3@prevas.dk">
      <pre class="moz-quote-pre" wrap="">

The patch is probably fine (as in, shouldn't make anything worse), but I
think it would be nice to understand just what the problem actually is,
and if this fixes it, how.</pre>
    </blockquote>
    <p><font face="monospace">Ya, we are definetely getting errors like:</font></p>
    <p><font face="monospace"><br>
      </font></p>
    <font face="monospace"><span style="font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; white-space: pre-wrap; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgba(29, 28, 29, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">FileNotFoundError: [Errno 2] No such file or directory: '/mnt/releases/sstate/99/sigtask.wq6gkrm7' -&gt; '/mnt/releases/sstate/99/sstate:hdparm::9.48:r0::3:990d8b39c15752a2dd68369cb3609283_unpack.tgz.siginfo'</span></font><br>
    <p><span style="font-family: Monaco, Menlo, Consolas, &quot;Courier New&quot;, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; white-space: pre-wrap; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgba(29, 28, 29, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><font face="monospace">With a backtrace to the os.rename() under heavy load. I don't understand how the chmod() can succeed and the rename fail unless there is a race. It's very hard to diagnose what went wrong post-mortem.</font></span></p>
    <p><span style="font-family: Monaco, Menlo, Consolas, &quot;Courier New&quot;, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; white-space: pre-wrap; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgba(29, 28, 29, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><font face="monospace">
</font></span></p>
    <span style="font-family: Monaco, Menlo, Consolas, &quot;Courier New&quot;, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; white-space: pre-wrap; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgba(29, 28, 29, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><font face="monospace">My other option was to manually add more entropy to the file names by prepending some random characters after "sigtask", since the "randomeness" of mkstemp() isn't great all tasks use the same sigtask file prefix (which increases the likely hood of a collision). </font></span><br>
    <span style="font-family: Monaco, Menlo, Consolas, &quot;Courier New&quot;, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; white-space: pre-wrap; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgba(29, 28, 29, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"></span>
    <blockquote type="cite"
      cite="mid:29b6f80a-74e8-896c-d02a-cd584d50cfb3@prevas.dk">
      <pre class="moz-quote-pre" wrap="">

Rasmus
</pre>
    </blockquote>
  </body>
</html>

--------------R08uDMf7kv0mkEZKaEoJZpZy--

