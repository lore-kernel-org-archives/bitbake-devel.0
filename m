Return-Path: <sgw@bigsur.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F613C4829B
	for <webhook@archiver.kernel.org>; Sat, 10 Feb 2024 00:56:58 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.4646.1707526612099014582
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 16:56:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bigsur.com header.s=bigsur.com header.b=FOfXnEOK;
 spf=pass (domain: bigsur.com, ip: 209.85.216.43, mailfrom: sgw@bigsur.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-296e8c8d218so1133365a91.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 16:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bigsur.com; s=bigsur.com; t=1707526611; x=1708131411; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5y4g3hsBbx27ghbPbLIdzF1B2XWNt3JL1PnzOLCspQk=;
        b=FOfXnEOKrsuVWjh8xl4JvA+E0oY1WEdipq8OpxCwdqLaC0iV4muTKDli8yVvEidlR0
         SZAlrtC1fqOgsygkYMgTSgJ1POIluR0mtq8OAiHGzG58yJFesBQC3mZG1OsPyktQZvay
         rfJ/CYnpYnNh7T7C6GJn4FjQhSYlaDqEbcv/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707526611; x=1708131411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5y4g3hsBbx27ghbPbLIdzF1B2XWNt3JL1PnzOLCspQk=;
        b=cR73k6BjWziA/ZPR8G/F07zq+aQ7R+gOH5mB3GPcYygo5oas/jLmyGgzR6ByR2lprR
         7a/zBUzFINPeqzlDyhdsU+sGRTIWKb+3SubDjt4ScB9SXy+zYxIb6juwWiOJM5bv1uZZ
         r5arLyc/m06rgU4GF2FrG3tPmL3qLjQcM4I70pYP3+63vBV9aqVcKFFcayuMUys/QlH4
         ehndy3e9ia6RQCEK0Om9qB9dkoA/UT+QE8s1Pt7+/Idn2eaymyhIX6+LTDVb90NA+/Io
         m2842fFEoBHnpPGoGpOV6HatZvdtMb3hmGG5g2E8RuLwXkyF8cQQ9tExOrgyJTSwkWyR
         DTdw==
X-Gm-Message-State: AOJu0YwlMHtuTXTS9qFMuE7tVOueTSAiENWUPazrNmOwBYSQZ9CT8tM6
	5QxeLBZVfMIzISdX+9j/gTEc0WhuZ/0a+h3epBg0GCoaGdKw0hBRGKD/GATFIA==
X-Google-Smtp-Source: AGHT+IEIO7IJmbwiMs9N7bXzyaaDvvL05K93H3txpeJ3VDyx8DZF3Ue/YMmVbzF2CAvY5//Hr8Z4zQ==
X-Received: by 2002:a17:90a:ba84:b0:297:7d8:e64d with SMTP id t4-20020a17090aba8400b0029707d8e64dmr631433pjr.1.1707526611254;
        Fri, 09 Feb 2024 16:56:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOe3LlDZoIjYhDzLswEt5DjhDKqmxHywEw/TVyY0c3AXRwmmtK9wphk0auWm0ZLDQxbxBxA4+E2yEgBtXL4BlqcxDDCL9xmN1uhRdVqo0gSgsLHD8lZC6OaIkMNpfdX0xZHUM0
Received: from [10.23.90.20] ([69.9.134.55])
        by smtp.gmail.com with ESMTPSA id se14-20020a17090b518e00b00296d3598f9asm2435921pjb.35.2024.02.09.16.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 16:56:50 -0800 (PST)
Message-ID: <77b4e744-91e8-486c-94fe-5fdd75c6c839@bigsur.com>
Date: Fri, 9 Feb 2024 16:56:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Underscore vs Dash in bbclass filenames
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: randy.macleod@windriver.com
References: <f8f81126-3fec-4dbd-8088-64d615879167@bigsur.com>
 <93a90192cda3bb300f0e53348648d1b0c1ecc5f9.camel@linuxfoundation.org>
From: Saul Wold <sgw@bigsur.com>
In-Reply-To: <93a90192cda3bb300f0e53348648d1b0c1ecc5f9.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 10 Feb 2024 00:56:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15871



On 2/9/24 10:05, Richard Purdie wrote:
> Hi Saul,
> 
> Thanks for looking at this.
> 
No Problem, I grabbed it at Randy's suggestion!

> On Wed, 2024-02-07 at 14:21 -0800, Saul Wold wrote:
>> I was looking into Bug 14235 [0] and had initial patch based on Randy's
>> original recommendation of using dash (-) which was a basic
>> python/tinfoil script to check existing bbclasses in the BBPATH.
>>
>> It was pointed out that the bbclass name is prepended to exported
>> function and that would cause problems for SHELL functions as dash is
>> not allowed in the shell function name.
>>
>> On further investigation this of course becomes a more nuanced problem,
>> so I considered an alternative approach for setting up a warning in
>> bitbake itself.  There is currently an error check in bitbake's ast.py
>> ExportFuncsNode() code. The code below would warnonce() for other
>> bbclasses that have a dash and are not in a NO_WARN_BBCLASSES list.
>>
>> At some point in the future this warning can be changed to an error.
>> I also noticed that the Regular Expressions defined in ast.py could be
>> tightened up slightly, there are a couple that use \s (general string)
>> vs \w which limits some special symbols, in order to limit dashes from
>> appearing in function names in bbclasses.
> 
> Was this for python or shell functions or both? We should probably
> tighten the shell case at the very least.
>
I would consider it both.

Oops, BBHandler.py has the re.compiles(), and I totally confused '\s' is 
whitespace, not string! Not sure what I was thinking, I had a python 
regex page open even!

__export_func_regexp__   = re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
probably should use \w+ to grab the EXPORT_FUNCTIONS function names.

__addtask_regexp__       = 
re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=after))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")
Here the \w+ is used to capture the "addtask" function list.

deltask_regexg uses .+ instead of the tighter \w+ also.

If we do rename all dash bbclasses, then the inherit_regexp can change 
from .+ to \w+ also I think, but that's would be future!

>>
>> This is not for the current Scarthgap release.
>>
>> diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py
>> b/bitbake/lib/bb/parse/parse_py/BBHandler.py
>> index cd1c998f8f8..faf6e9ede63 100644
>> --- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
>> +++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
>> @@ -116,6 +116,9 @@ def handle(fn, d, include, baseconfig=False):
>>        init(d)
>>
>>        if ext == ".bbclass":
>> +        nowarn_bbclass_list = d.getVar('NOWARN_DASH_BBCLASSES')
>> +        if '-' in root and root not in nowarn_bbclass_list:
>> +            bb.warnonce("%s contains dash ('-') in name which is not
>> safe" % base_name)
>>            __classname__ = root
>>            __inherit_cache = d.getVar('__inherit_cache', False) or []
>>            if not fn in __inherit_cache:
>>
>>
>> Thoughts from the bitbake team on this approach?
>>
>>
>> [0] https://bugzilla.yoctoproject.org/show_bug.cgi?id=14235
> 
> If we are going to warn about something, it would have to be the dash.
> This kind of patch would seem to be roughly the right way to handle it.
> 
> My main question is whether we do want to force users through this
> transition or just stop new classes? Does the inconsistency really
> matter? Do we need to do anything, is there a problem we need to solve
> here?
> 
If we try to stop new classes, we need to keep a list of "grandfathered" 
classes which is the NOWARN_DASH_BBCLASSES variable in my proposal above.

I can post this with an associated patch to oe-core and 
meta-openembbeded layers, other layers would need to add their own 
NOWARN_DASH_BBCLASSES +=  the extend the list.

I am not sure if this would require a version bump which is why I think 
it needs to wait until after Scarthgap.

> If we do, do we support a set of "remapped" classes, where for example
> "inherit create-spdx" would translate into "inherit create_spdx" ? That
> does still have potential function name issues but they probably don't
> work today with dashes in and any class using those did already
> probably switch to an underscore.
> 
Honestly, I would rather not try to deal with remapping classes or 
function names.  As you point out any bbclass that has a shell function 
is already using either an underscore or single name (probably due to 
the error check you added).

This would just help make future naming more consistent with underscore 
or single name as Randy points.

If there is an opening on Tuesday and I make it, I will bring it.

Sau!

> Cheers,
> 
> Richard
> 
> 

