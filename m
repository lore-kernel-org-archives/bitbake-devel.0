Return-Path: <matt@madison.systems>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642FBC4321E
	for <webhook@archiver.kernel.org>; Mon, 18 Apr 2022 14:25:53 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web09.11034.1650049922152088940
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Apr 2022 12:12:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@madison.systems header.s=google header.b=c2mI8lCP;
 spf=pass (domain: madison.systems, ip: 209.85.208.172,
 mailfrom: matt@madison.systems)
Received: by mail-lj1-f172.google.com with SMTP id h11so10396096ljb.2
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Apr 2022 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=madison.systems; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Y41wap7eHDf6zL2SE1WWlAG9sa9yY9+ma2Yrd/jkKM=;
        b=c2mI8lCPfO/VkVNY1OD+YbF1eiJp52ezy2T6gH5aNjMr9koS3oJ1yPOwBwJpKYHa0k
         SCtWnOL4zzrLpwJtC3gUuZC1FI11huu7mjH+nWqnORlZ8i0nRN7GOmuUUEH61FoEIU5U
         9sNtoW4fEKzB4VRcVHSmwWaZ5kXOLOMypDHG5rtsVICs8hydOTZQepZu9IsfHOQzp794
         59fBSQ6hLaUUt0r21kuMW0KI6J4boGPd/k1Sb3vzSY60dCwDZs+5egJAe67Qsy72dhU0
         PP0vvgSnIEIfIl9rFNZRvF7csi2nJ7ZwBLm9SpCyj3R/vpqs/Z/Q3c7Dsffp3HziqOrF
         LirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Y41wap7eHDf6zL2SE1WWlAG9sa9yY9+ma2Yrd/jkKM=;
        b=bjySFBmLJ1+SAPpOuTROHny+jHGaPTzhePjtlXn0pasdpvdTg2HU/0Fm5RMBw2P5CX
         BqlIAP7YR1jMi0+5mtLk3Tf0FUk5OTnlIQi+a3Y8USge7vsDWJFw2gzaZy/0aH6S8VxI
         zNXfQzM9VliZm2X3N/FFBic6RbJzazuxZeu02PPru+V1xdRcmvJ2iedpjGli0pxzxfZ8
         GRPYTOQS+F82QY+iWsKXeIZXGuBiaaP2hpvLPdzhe/06zFBUo7dKGfK+hNKTW4l/e/zH
         1v7jU3pkQYwqdZWNq49EyPSSolsmchiD13A8phM+GyjQOFg4VsI5J5yocHROK067V6E5
         8Blg==
X-Gm-Message-State: AOAM531l9bCZj0UcUJBpVjqWTxMrEHGuzHVUTJIrlce54NhaaN+wH2fT
	llQp1Xf2jlM9G1wGV1ogP5CM9zhjM9Ox5l0HjOZCJg==
X-Google-Smtp-Source: 
 ABdhPJzt8eurJq0gAI6yGRXPch4Te54+Y8Se7/CzftiNO5IPLAa6f6yyYHxdDLig9sbPWUPNHcwIVXcXu3U2TdLPmNw=
X-Received: by 2002:a2e:390c:0:b0:248:1b88:d6c4 with SMTP id
 g12-20020a2e390c000000b002481b88d6c4mr277895lja.49.1650049919979; Fri, 15 Apr
 2022 12:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133456.44233-1-matt@madison.systems>
 <CAMKF1srWYsAXw+HYMTBivYNSt_sME7JFoDP1+uVxSfM1SfW8rQ@mail.gmail.com>
In-Reply-To: 
 <CAMKF1srWYsAXw+HYMTBivYNSt_sME7JFoDP1+uVxSfM1SfW8rQ@mail.gmail.com>
From: Matt Madison <matt@madison.systems>
Date: Fri, 15 Apr 2022 12:11:49 -0700
Message-ID: 
 <CAGgRHJqbjOLBR8Fx9A61wdd-+0tViCQEq_YrozNKuvYgkbgr8A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] providers: use local variable for
 packages_dynamic pattern
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Apr 2022 14:25:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13636

On Fri, Apr 15, 2022 at 9:04 AM Khem Raj <raj.khem@gmail.com> wrote:
>
>
>
> On Fri, Apr 15, 2022 at 6:36 AM Matt Madison <matt@madison.systems> wrote:
>>
>> During parsing, Python raises
>>
>>    RuntimeError: dictionary changed size during iteration
>>
>> in getRuntimeProviders, if you happen to have a recipe
>> with an explicit RDEPENDS on a dynamic package containing a '+'
>> character, such as 'gtk+3-locale-en'.
>>
>> This is because we're using the modified pattern as the
>> key into the packages_dynamic dict to append to rproviders,
>> and since that key doesn't exist, the dict is getting modified
>> to add a new, empty, entry for it. So even without the runtime
>> error, we'd be generating an incorrect result.
>>
>> Fix this by using a local variable for modifying the pattern
>> and using the original key to retrieve the value on a match.
>
>
> Good fine I wonder if a test case would be good to have Added as well

I was wondering that, too.  Are there test cases for exercising the
PACKAGES_DYNAMIC feature already? If someone can provide a pointer, I
can see about adding one for this.

Thanks,
-Matt

>>
>>
>>
>> Signed-off-by: Matt Madison <matt@madison.systems>
>> ---
>>  lib/bb/providers.py | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/bb/providers.py b/lib/bb/providers.py
>> index 8c1c31a5..e11a4637 100644
>> --- a/lib/bb/providers.py
>> +++ b/lib/bb/providers.py
>> @@ -396,8 +396,8 @@ def getRuntimeProviders(dataCache, rdepend):
>>          return rproviders
>>
>>      # Only search dynamic packages if we can't find anything in other variables
>> -    for pattern in dataCache.packages_dynamic:
>> -        pattern = pattern.replace(r'+', r"\+")
>> +    for pat_key in dataCache.packages_dynamic:
>> +        pattern = pat_key.replace(r'+', r"\+")
>>          if pattern in regexp_cache:
>>              regexp = regexp_cache[pattern]
>>          else:
>> @@ -408,7 +408,7 @@ def getRuntimeProviders(dataCache, rdepend):
>>                  raise
>>              regexp_cache[pattern] = regexp
>>          if regexp.match(rdepend):
>> -            rproviders += dataCache.packages_dynamic[pattern]
>> +            rproviders += dataCache.packages_dynamic[pat_key]
>>              logger.debug("Assuming %s is a dynamic package, but it may not exist" % rdepend)
>>
>>      return rproviders
>> --
>> 2.32.0
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#13633): https://lists.openembedded.org/g/bitbake-devel/message/13633
>> Mute This Topic: https://lists.openembedded.org/mt/90486450/1997914
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [raj.khem@gmail.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>

