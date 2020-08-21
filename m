Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.134018.1598019491843479443
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2020 07:18:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FA2dQNJM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f66.google.com with SMTP id r2so2090958wrs.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2020 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Zvy43TJui7uR4sdgXJr7b90EpI1td+P+gZI1LeZDLBE=;
        b=FA2dQNJMDKjWEer/8J6B3aMC6P9CGdNgwE4sRsrchPWX1D7kybqx8WzDgmWjgzE7PB
         OS4P/jsj3tlFdLQ6R+OUv3zYhhGJCDgR7UTJSYOSd5LebRZZ5kYQn0zJntHRK7SzjHMF
         UslBRIRuaxLrnxK7xBb9r/3XP2u0s+PdhXpWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Zvy43TJui7uR4sdgXJr7b90EpI1td+P+gZI1LeZDLBE=;
        b=BtDpniamM7A+5oV4IZs7Hw8yiiYsqpH6JuxmMtyz9uUmw9SV0gbPIR6s5RsdcIV6on
         qseKgZeW9WuwTCwc9iHteW7U8xSNPro2e/etjp5N+kZIAzk9nCTa8bXpFPYSOZbkAQQK
         5XAfyeqYtcXvw1jDQOsdXsBqc2HKZ/jzU0f7du0UaxnVUhqTzVzr6HyjzpsiOc9t1cTn
         UJXKf1Wod8M30fojGGqbaWq79En99U3kdegr6O/VW5LQWy4AJqJnMOr69HFxOqZRfvSG
         mpwwiVsspn35y8uFqDHTccUccl1RJk4F1ylArItQaFKT2W8mS7CYvVAssnJfOlVMyv0W
         l/BA==
X-Gm-Message-State: AOAM533GuJhv3p0208kvsVquX9E+e2yrF5GfZ7xFALSRaoWmooriN/RG
	9tjCXrGGz0EXhpkvsGA0wvQ2Bw==
X-Google-Smtp-Source: ABdhPJxXdmrzRJPkrYUn2ulqMEKKv9H4Cn9fsx/xVn3GoLmt3qNYtiRsUHl6neOBGQgwS3MpIO5T6A==
X-Received: by 2002:a05:6000:124c:: with SMTP id j12mr2963278wrx.83.1598019490158;
        Fri, 21 Aug 2020 07:18:10 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id x14sm5358696wmc.5.2020.08.21.07.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 07:18:09 -0700 (PDT)
Message-ID: <1819f13202abc9339dbdd0215d714fda8a9b070b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC] siggen: clean_basepath leaks full recipe file path
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Maxime =?ISO-8859-1?Q?Roussin-B=E9langer?=
	 <maxime.roussinbelanger@gmail.com>, guillaume.champagne@sonatest.com
Date: Fri, 21 Aug 2020 15:18:08 +0100
In-Reply-To: <20200820215000.30818-1-jeff.dagenais@gmail.com>
References: <20200820215000.30818-1-jeff.dagenais@gmail.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 2020-08-20 at 17:49 -0400, Jean-Francois Dagenais wrote:
> While investigating constant mismatches of hashes from our
> SSTATE_MIRROR depot,
> Maxime and I came across a bitbake-diffsigs which showed a suspicious
> cause for
> the mismatch. It appeared to be an underlying taskdeptasks which
> contains the
> full path of the recipe, which is totally a local build thing.
> 
> After searching for a little while. We came accross the
> `clean_basepath(a)`
> function in siggen.py. We added prints on it:
> 
> def clean_basepath(a):
>     mc = None print('a: ' + a) if a.startswith("mc:"):
>         _, mc, a = a.split(":", 2)
>     b = a.rsplit("/", 2)[1] + '/' + a.rsplit("/", 2)[2] print('b: ' +
> b) if
>     a.startswith("virtual:"):
>         b = b + ":" + a.rsplit(":", 1)[0]
>     if mc:
>         b = b + ":mc:" + mc
>     print('b+: ' + b) return b
> 
> Sure enough, this looks like the culprit. Consider the following
> trace:
> a: virtual:native:/full/path/to/poky/meta/recipes-devtools/gnu-
> config/gnu-config_git.bb:do_populate_sysroot
> b: gnu-config/gnu-config_git.bb:do_populate_sysroot
> b+: gnu-config/gnu-
> config_git.bb:do_populate_sysroot:virtual:native:/full/path/to/poky/m
> eta/recipes-devtools/gnu-config/gnu-config_git.bb
> 
> Looking at this, it really seems like the intent of the `if
> a.startswith("virtual:")` case is to insert only the
> `:virtual:native` at the
> end.
> 
> The simplest fix we suggest is simply changing `a.rsplit(":", 1)[0]`
> to
> `a.rsplit(":", 2)[0]` and causes b+ to become:
> 
> b+: gnu-config/gnu-config_git.bb:do_populate_sysroot:virtual:native
> 
> Since this is so profound and core to the way signatures work,
> coupled with the
> fact that this code hasn't changed in years, we feel being the ones
> to find and
> fix this is unlikely.
> 
> Perpahps the content/format of the passed `a` variable has changed
> recently?
> 
> The following email is a patch which could be applied if deemed
> correct. But please
> consider this re-written version:
> 
> def clean_basepath(basepath):
>     # basepath is a string like '/full/path/to/recipes-
> whatever/helloworld/helloworld_0.1.2.bb:do_compile'
>     # or 'virtual:native:/full/path/to/recipes-
> whatever/helloworld/helloworld_0.1.2.bb:do_compile'
>     # or 'mc:somemachine:/full/path/to/recipes-
> whatever/helloworld/helloworld_0.1.2.bb:do_compile'
> 
>     _, parent_dir, recipe_task = basepath.rsplit("/", 2)
>     # drop what is left of the second slash, searching from right to
> left
>     cleaned = parent_dir + '/' + recipe_task
> 
>     # if there was a 'abc:xyz' prefix, add it to the end
>     if not basepath.startswith('/'):
>         cleaned += ':' + basepath.split('/', 1)[0].rstrip(':')
> 
>     return cleaned
> 
> Both simple fix and this rewrite were tested with `oe-selftest -r
> sstatetests`.
> 
> We feel this version has these advantages:
> * improved readablility
> * improved efficiency (the split is not repeated twice and function
> it has fewer `if`s)
> * honours the open/close principle better by not hardcoding
> "virtual:" nor "mc:"
> 
> Thanks for your feedback! I will submit this version as a patch if it
> is positive.

Well done finding this, the bug has clearly been there a while! I've
had a feeling there was something going on somewhere but never found
it.

I've taken the opportunity to make the code slightly clearer so have
written and sent a modified version of your patch. I hope that is ok!
Please take a look and let me know if I've missed anything too.

Cheers,

Richard

