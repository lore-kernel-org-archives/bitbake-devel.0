Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web12.7343.1610819564908415066
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 16 Jan 2021 09:52:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=kpnVDXII;
 spf=pass (domain: gmail.com, ip: 209.85.210.181, mailfrom: akuster808@gmail.com)
Received: by mail-pf1-f181.google.com with SMTP id 11so7578382pfu.4;
        Sat, 16 Jan 2021 09:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6wj6TeQ3uATEF9f3iQ/YJ25EdLAg2FIr1kdfgiXxpr4=;
        b=kpnVDXIIPuII2yBR/ZoGhOuPjHVPjtM61vVOWJJ4jSK+GZTyESuSmCi0GUojSw1ZLl
         MtxNJjoCQ+N8odKNRLMCabDDDtGOdTjDPSrhmu8fQFfDZ+XVV7RO4mE+/14pdudKnS1n
         1CfvKZxuA69s9AF/pHePJj7VmLcsMUUSyF5mYcLie/t6i9mtBoGX1lbQ5HgyWitO/bdg
         rKIhmU8WUWtrs6jGvxpXmK0DDBPw9QjcbL9Gh1Yaod8e7G9l6UWMuQNu7gkIffjv3wI/
         JU7hix3isqYE/4KMhA+tjsITWorUMG6UmP9f/w6/Ze+EMCgoNAJeQy3wlGU/6odh9UM/
         n+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=6wj6TeQ3uATEF9f3iQ/YJ25EdLAg2FIr1kdfgiXxpr4=;
        b=Pbgwc+qTpqONUbfaAthLvzzn/hEQa8KeCvWN0YYqpkCaa0oGskvSKMnXMQgWu+u2OM
         NHuLoVJEE0tLW0qfvWpxpj9GHMcFOIAK6pa8nIDruoCCE8iWrU/fWnrlVHRA7W4MWRcT
         2BDqIyZasJciRmQ81bLRC6YVWZLfeVlT4cjqtPxZHWcI2CJArqRcfvzQMGpSB8X2lJOF
         Mhe2L/HAwhbaYyFKjN+7bI976kxStNOBkftLaFGHZx1bnZCOWrQS9wANRUan5sZOm6zg
         pTSH5vZyES5SB2jr11Q6hzcqpidjCwpvYwojt3hDMs9XRtF8yiBfi2RIa811iAVWU6Mc
         2ysQ==
X-Gm-Message-State: AOAM530HxnQ4n47XXuCP6VmJcA9shYUQRK/ShwfZYZ+CSaapPdjddWFQ
	t7OmV9iuCbOE4Wv8N4RKr1UWzw+196eqDQ==
X-Google-Smtp-Source: ABdhPJxW5kdUvzuk1cx1QMxgcGjQo7X+lE9w3b4LEBvbh5/pAsQCgiRSXpoxaKtyf9IWxSUkLBbdpA==
X-Received: by 2002:a62:7857:0:b029:19d:fe6a:3069 with SMTP id t84-20020a6278570000b029019dfe6a3069mr18737184pfc.3.1610819564136;
        Sat, 16 Jan 2021 09:52:44 -0800 (PST)
Return-Path: <akuster808@gmail.com>
Received: from ?IPv6:2601:202:4180:a5c0:9c08:d62e:30e8:e4f? ([2601:202:4180:a5c0:9c08:d62e:30e8:e4f])
        by smtp.gmail.com with ESMTPSA id k3sm11491993pgm.94.2021.01.16.09.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 09:52:43 -0800 (PST)
Subject: Re: [bitbake-devel] Backport changes for _PYTHON_SYSCONFIGDATA_NAME to Gatesgarth and Dunfell
To: Martin Jansa <martin.jansa@gmail.com>,
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: Steve Sakoman <steve@sakoman.com>, "Mittal, Anuj"
 <anuj.mittal@intel.com>,
 "OE Core (openembedded-core@lists.openembedded.org)"
 <openembedded-core@lists.openembedded.org>,
 "OE Development (openembedded-devel@lists.openembedded.org)"
 <openembedded-devel@lists.openembedded.org>,
 "BitBake Development (bitbake-devel@lists.openembedded.org)"
 <bitbake-devel@lists.openembedded.org>
References: <17b543581ffb421b812323891405dcfb@XBOX03.axis.com>
 <CA+chaQc0anOg2E=o1ouEca-QJDGqKxDoXm6aPVXzsc8TELW3zA@mail.gmail.com>
From: "akuster" <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
 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
 8CS2NxU=
Message-ID: <d9185d19-1f09-a1b6-2926-f54309190b24@gmail.com>
Date: Sat, 16 Jan 2021 09:52:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+chaQc0anOg2E=o1ouEca-QJDGqKxDoXm6aPVXzsc8TELW3zA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US



On 1/16/21 9:44 AM, Martin Jansa wrote:
> Aren't the missing spaces in appends fixes also needed for meta-oe
> recipes?


>
> I think at least top 5 commits from:
> https://git.openembedded.org/meta-openembedded/log/?qt=grep&q=space.*append
> were also follow-up from these changes in oe-core.
>
Do you mean something beyond the meta-openembedded commits mentioned
near the bottom of the email?

I need clarity so I can open an issue in gitlab for tracking purposes as
I am sure I will forget this

-armin

> On Thu, Jan 14, 2021 at 6:50 PM Peter Kjellerstedt
> <peter.kjellerstedt@axis.com <mailto:peter.kjellerstedt@axis.com>> wrote:
>
>     [ Cross-posting since these changes affect all of bitbake,
>     openembedded-core
>       and meta-openembedded and need to be made (at least somewhat) in
>     sync. ]
>
>     Can the solution for _PYTHON_SYSCONFIGDATA_NAME please be
>     backported to
>     Gatesgarth and Dunfell? We are seeing problems for developers who
>     have
>     updated the python3 version on their hosts when they try to do
>     devtool
>     modify on recipes that inherit python3native. The following relevant
>     changes should cherry-pick cleanly to the respective repositories for
>     both gatesgarth and dunfell:
>
>     openembedded-core:
>     5a118d4e python3: split python target configuration into own class
>     dadf001c python3-pycairo: use python3targetconfig
>     9c8f6660 distutils3-base.bbclass: use python3targetconfig
>     d3a81dd0 meta: drop _PYTHON_SYSCONFIGDATA_NAME hacks
>     38ecb83c gpgme: use python3targetconfig
>     c99bb790 python3targetconfig.bbclass: Make py3 dep and tasks only
>     for target recipes
>
>     bitbake:
>     47b64cfa lib/bb/fetch2/__init__.py: drop
>     _PYTHON_SYSCONFIGDATA_NAME unsetting
>
>     meta-openembedded:
>     a06cdf5a gedit: Inherit python3targetconfig
>     59f817bb openipmi: Inherit python3targetconfig
>     be7d2286 libplist: Inherit python3targetconfig
>     c499aaee postgresql: Inherit python3targetconfig
>
>     I guess there may be some controversy regarding whether these
>     changes should
>     be backported to the stable branches since they modify what
>     python3native
>     does and may require existing recipes to be modified to inherit
>     the new
>     python3targetconfig class. However, I believe that having devtool
>     modify
>     fail on random recipes without an easy solution for the user is
>     much worse
>     than having to update a recipe or two once due to a build failure
>     after
>     upgrading to a new version of OE-Core (in my book that is pretty
>     normal and
>     something I always have to do anyway when we update OE-Core). And
>     based on
>     the number of recipes in openembedded-core and meta-openembedded
>     that needed
>     to be updated (2+4), I do not expect there to be many other
>     recipes in the
>     first place that actually need to be updated.
>
>     //Peter
>
>
>     
>

