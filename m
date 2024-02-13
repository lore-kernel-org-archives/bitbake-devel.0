Return-Path: <sgw@bigsur.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC98C4829A
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 18:35:06 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.21024.1707849305306166871
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Feb 2024 10:35:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bigsur.com header.s=bigsur.com header.b=N3kQTKkW;
 spf=pass (domain: bigsur.com, ip: 209.85.214.180, mailfrom: sgw@bigsur.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d746ce7d13so40019565ad.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Feb 2024 10:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bigsur.com; s=bigsur.com; t=1707849305; x=1708454105; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PLiGrsaCnrGxjX21ALShf1ySAd7/FQz1uTTDJIs/qrc=;
        b=N3kQTKkWe062qmukRXLnSCyGQkN+bB+mkUXarF+ZaGxksQwctGCA117+rUWCXhegnD
         99gMhkOjuLP833H+FbFsV/E5zl02STkHfy9c/W4EDV7lZNN2Y+LysHViBooEhoZOTKXx
         /5cykkixTTUXsibXsXHykTltExaWTnhxqRjog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707849305; x=1708454105;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLiGrsaCnrGxjX21ALShf1ySAd7/FQz1uTTDJIs/qrc=;
        b=utU65K31fytCox+Y9wKBCBrzDGLElHdZY1BLw4JDDLR10bO+yjOx1y5RsY78JD98F+
         b1VhIao5wWaQzMApf5zyLSEO6G2bAI4p1BEZtJo01lmk8e4tnKU6kxnfzP75G+LSxd6Y
         1yLnz7/kQEeaRcIoux2tfzGoXq5jrv4j54V0cCVjeoYGzTrHQajg3fEWT0seuYKBrpA/
         VjG2jIA7Pn34/dS+sD2r9H04FAGn8fHRVTBOj9eCPmu7MVGd3bDkHEvipHrh8rErvLaS
         uRE74KRI3vWqhXIrD1EvLS3ZHmSavqTcSKZQpM7VXEZ1NbYJiJZPpJtHq7+nJP0+QmER
         oj9g==
X-Forwarded-Encrypted: i=1; AJvYcCVFpQg1cdI/lSuI/nMOJywYexV5WYiBB7umKH2Q72y9Sn9eH/w1/5salMA3fPGsu8yBnXU1aYONSlvV5kCXf/uDTPfd55db4RvQ84sjG5QzGe61WMQ=
X-Gm-Message-State: AOJu0Yy6vCOOHv+1+RwEHdknpoZmDVpRCqLS4ZfGBTY/VG6ZiNRL8aJx
	WjxZugAvvn10mxUEdIfL53RUgC83flSRh35KqsArAQk8i28ioRBb+hVLphVOgw==
X-Google-Smtp-Source: AGHT+IGF+6zQqYdmvDP3pOe8Pzh0f3kNpUi7TSeb2IBNMA3YsBV4fe2bwcXf45cu250esWil19CtvA==
X-Received: by 2002:a17:90a:8d16:b0:298:b12e:79fd with SMTP id c22-20020a17090a8d1600b00298b12e79fdmr329085pjo.31.1707849304405;
        Tue, 13 Feb 2024 10:35:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU60S/vyQDrdF6Boj096/79dFg79BmQt9/AsuBNjhHx3lgvo4yELZ5Y66PdN9etWoNXJ/HePDoaC+AzIkNJqXUT3GFErDsUsB/y3ErHjeM9Ia8Owc1FijdVlxBWvxOTKWAVXKbm
Received: from [10.23.90.20] ([69.9.134.55])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ac08600b002932ec731d1sm2899872pjs.18.2024.02.13.10.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 10:35:04 -0800 (PST)
Message-ID: <58ab14ca-5a58-48dd-ac0f-bdc03c783f84@bigsur.com>
Date: Tue, 13 Feb 2024 10:35:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Underscore vs Dash in bbclass filenames
Content-Language: en-US
From: Saul Wold <sgw@bigsur.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: randy.macleod@windriver.com
References: <f8f81126-3fec-4dbd-8088-64d615879167@bigsur.com>
 <93a90192cda3bb300f0e53348648d1b0c1ecc5f9.camel@linuxfoundation.org>
 <77b4e744-91e8-486c-94fe-5fdd75c6c839@bigsur.com>
In-Reply-To: <77b4e744-91e8-486c-94fe-5fdd75c6c839@bigsur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Feb 2024 18:35:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15888

Following up on this after the Tech Meeting today.  The discussion 
centered around if any function names (python or shell) contain invalid 
characters such a dash (-) and issue a warning or error.

The current __func_start_regexp__ in BBHandler.py is defined as follows:

__func_start_regexp__    = 
re.compile(r"(((?P<py>python(?=(\s|\()))|(?P<fr>fakeroot(?=\s)))\s*)*(?P<func>[\w\.\-\+\{\}\$:]+)?\s*\(\s*\)\s*{$" 
)

Note the sub-pattern for the function name: (?P<func>[\w\.\-\+\{\}\$:]+)
It includes '.', '-', '+' and '$' which are all invalid for shell and 
python function names.  The \w expression which matches [a-zA-Z0-9_] is 
correct for both shell and python functions.

If an invalid character is introduced in a function name with the a 
modified regular expression that removes the invalid characters the 
following error will occur:

ERROR: Unable to parse 
/home/swold/src/yocto/poky/bitbake/lib/bb/parse/parse_py/ConfHandler.py
Traceback (most recent call last):
   File 
"/home/swold/src/yocto/poky/bitbake/lib/bb/parse/parse_py/ConfHandler.py", 
line 200, in feeder(lineno=7, s='python dash-test-python-function() {', 
fn='/home/swold/src/yocto/poky/meta/classes/underscore_bbclass.bbclass', 
statements=[<bb.parse.ast.MethodNode object at 0x7fe6a2dbc700>, 
<bb.parse.ast.AddTaskNode object at 0x7fe6a2dbc5b0>], baseconfig=False, 
conffile=False):

     >    raise ParseError("unparsed line: '%s'" % s, fn, lineno);

bb.parse.ParseError: ParseError at 
/home/swold/src/yocto/poky/meta/classes/underscore_bbclass.bbclass:7: 
unparsed line: 'python dash-test-python-function() {'

With that limited investigation, I realized that there are some 'class' 
specific functions like a do_write_config:append:class-target() or 
do_compile:class-native() which would fail the RE match() in BBHandler.py.

I think more investigation is needed on how those are parsed and handled 
in bitbake (I admit to not being an expert on bitbake internals).

Sau!


On 2/9/24 16:56, Saul Wold wrote:
> 
> 
> On 2/9/24 10:05, Richard Purdie wrote:
>> Hi Saul,
>>
>> Thanks for looking at this.
>>
> No Problem, I grabbed it at Randy's suggestion!
> 
>> On Wed, 2024-02-07 at 14:21 -0800, Saul Wold wrote:
>>> I was looking into Bug 14235 [0] and had initial patch based on Randy's
>>> original recommendation of using dash (-) which was a basic
>>> python/tinfoil script to check existing bbclasses in the BBPATH.
>>>
>>> It was pointed out that the bbclass name is prepended to exported
>>> function and that would cause problems for SHELL functions as dash is
>>> not allowed in the shell function name.
>>>
>>> On further investigation this of course becomes a more nuanced problem,
>>> so I considered an alternative approach for setting up a warning in
>>> bitbake itself.  There is currently an error check in bitbake's ast.py
>>> ExportFuncsNode() code. The code below would warnonce() for other
>>> bbclasses that have a dash and are not in a NO_WARN_BBCLASSES list.
>>>
>>> At some point in the future this warning can be changed to an error.
>>> I also noticed that the Regular Expressions defined in ast.py could be
>>> tightened up slightly, there are a couple that use \s (general string)
>>> vs \w which limits some special symbols, in order to limit dashes from
>>> appearing in function names in bbclasses.
>>
>> Was this for python or shell functions or both? We should probably
>> tighten the shell case at the very least.
>>
> I would consider it both.
> 
> Oops, BBHandler.py has the re.compiles(), and I totally confused '\s' is 
> whitespace, not string! Not sure what I was thinking, I had a python 
> regex page open even!
> 
> __export_func_regexp__   = re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
> probably should use \w+ to grab the EXPORT_FUNCTIONS function names.
> 
> __addtask_regexp__       = 
> re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=after))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")
> Here the \w+ is used to capture the "addtask" function list.
> 
> deltask_regexg uses .+ instead of the tighter \w+ also.
> 
> If we do rename all dash bbclasses, then the inherit_regexp can change 
> from .+ to \w+ also I think, but that's would be future!
> 
>>>
>>> This is not for the current Scarthgap release.
>>>
>>> diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py
>>> b/bitbake/lib/bb/parse/parse_py/BBHandler.py
>>> index cd1c998f8f8..faf6e9ede63 100644
>>> --- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
>>> +++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
>>> @@ -116,6 +116,9 @@ def handle(fn, d, include, baseconfig=False):
>>>        init(d)
>>>
>>>        if ext == ".bbclass":
>>> +        nowarn_bbclass_list = d.getVar('NOWARN_DASH_BBCLASSES')
>>> +        if '-' in root and root not in nowarn_bbclass_list:
>>> +            bb.warnonce("%s contains dash ('-') in name which is not
>>> safe" % base_name)
>>>            __classname__ = root
>>>            __inherit_cache = d.getVar('__inherit_cache', False) or []
>>>            if not fn in __inherit_cache:
>>>
>>>
>>> Thoughts from the bitbake team on this approach?
>>>
>>>
>>> [0] https://bugzilla.yoctoproject.org/show_bug.cgi?id=14235
>>
>> If we are going to warn about something, it would have to be the dash.
>> This kind of patch would seem to be roughly the right way to handle it.
>>
>> My main question is whether we do want to force users through this
>> transition or just stop new classes? Does the inconsistency really
>> matter? Do we need to do anything, is there a problem we need to solve
>> here?
>>
> If we try to stop new classes, we need to keep a list of "grandfathered" 
> classes which is the NOWARN_DASH_BBCLASSES variable in my proposal above.
> 
> I can post this with an associated patch to oe-core and 
> meta-openembbeded layers, other layers would need to add their own 
> NOWARN_DASH_BBCLASSES +=  the extend the list.
> 
> I am not sure if this would require a version bump which is why I think 
> it needs to wait until after Scarthgap.
> 
>> If we do, do we support a set of "remapped" classes, where for example
>> "inherit create-spdx" would translate into "inherit create_spdx" ? That
>> does still have potential function name issues but they probably don't
>> work today with dashes in and any class using those did already
>> probably switch to an underscore.
>>
> Honestly, I would rather not try to deal with remapping classes or 
> function names.  As you point out any bbclass that has a shell function 
> is already using either an underscore or single name (probably due to 
> the error check you added).
> 
> This would just help make future naming more consistent with underscore 
> or single name as Randy points.
> 
> If there is an opening on Tuesday and I make it, I will bring it.
> 
> Sau!
> 
>> Cheers,
>>
>> Richard
>>
>>

