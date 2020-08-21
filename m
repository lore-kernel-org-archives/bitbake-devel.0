Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web12.135172.1598022643881292405
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2020 08:10:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Pvj5d0Dw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id p20so2292099wrf.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2020 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=50pE9uMkViknuGXyaOifvmDw4++RMTcW3PhJAjTEk/k=;
        b=Pvj5d0Dw1KhIqIM8UYqFenwTHyMnMyNxIcuwzaIRXXM7U9kkPZ/5jOvXoRqSEWwNZO
         CsTqF1FS90n+yTsScm1prJgrrHlLLYa0drMQxVB1V/W+jJQqgzjcgkpwUDpavr2sz87N
         ambvT+g4KO8sjNlZ2R4aQgNguxMRYaKIpmzhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=50pE9uMkViknuGXyaOifvmDw4++RMTcW3PhJAjTEk/k=;
        b=NveFKMOJBrC1rsmJER8MUdg0M9UpCbCPS49MFE6zcVO6sA1YWU/dL1AmCgQ3vXx55J
         Os+QEsJ0zi1h7hIMhw7PEivgsE9h+1dudaEJ23JSamKbGlh2S/Um/HeauGBxcp+7ZrJL
         Efb/zgUDe9AXRvdDFzGa/5Qif7GZfF0RGO6uzpU1XiLY1u9bLRMigw/0V3pmXNdehS9H
         8zVVqbYUSLWA2as29V5BeAejq3HeiI49RSQaz32lNu4Iz7dqBYULSFtoT6RE/TUx/qTd
         qSx0QcKd5AC10C/4WFzpdGFAVyGcByhgCuBjthrFyMm0I8MKM7Cd6rKTq3vLqI+feS4Z
         ZYsQ==
X-Gm-Message-State: AOAM533CEfNLVaIvL6I34FeEvMKlthrZee4AVj0Ul+HRMKFCHhNlcjfe
	Olk96Oc+TARiykWYjyKN7QwZHw==
X-Google-Smtp-Source: ABdhPJyhgFdpbrCzu6Qs7iSO81xDQM7jKq55pXXmNuITYjNXrkNRgkozMvRL85C9Cg4sW+gfwBdvtQ==
X-Received: by 2002:adf:a1c6:: with SMTP id v6mr3104895wrv.197.1598022642324;
        Fri, 21 Aug 2020 08:10:42 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id 68sm4916099wra.39.2020.08.21.08.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:10:41 -0700 (PDT)
Message-ID: <376560ff987c4585f7f21c2cae4c8f50451ad743.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC] siggen: clean_basepath leaks full recipe file path
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Maxime
	=?ISO-8859-1?Q?Roussin-B=E9langer?=
	 <maxime.roussinbelanger@gmail.com>, guillaume.champagne@sonatest.com
Date: Fri, 21 Aug 2020 16:10:40 +0100
In-Reply-To: <29032972-1F01-4FE9-A3BD-13E1FFD43790@gmail.com>
References: <20200820215000.30818-1-jeff.dagenais@gmail.com>
	 <1819f13202abc9339dbdd0215d714fda8a9b070b.camel@linuxfoundation.org>
	 <29032972-1F01-4FE9-A3BD-13E1FFD43790@gmail.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-08-21 at 10:54 -0400, Jean-Francois Dagenais wrote:
> On Aug 21, 2020, at 10:18, Richard Purdie <richard.purdie@linuxfoundation.org> wrote:
> > The following email is a patch which could be applied if deemed
> > > correct. But please
> > > consider this re-written version:
> > > 
> > > def clean_basepath(basepath):
> > >    # basepath is a string like '/full/path/to/recipes-
> > > whatever/helloworld/helloworld_0.1.2.bb:do_compile'
> > >    # or 'virtual:native:/full/path/to/recipes-
> > > whatever/helloworld/helloworld_0.1.2.bb:do_compile'
> > >    # or 'mc:somemachine:/full/path/to/recipes-
> > > whatever/helloworld/helloworld_0.1.2.bb:do_compile'
> > > 
> > >    _, parent_dir, recipe_task = basepath.rsplit("/", 2)
> > >    # drop what is left of the second slash, searching from right to
> > > left
> > >    cleaned = parent_dir + '/' + recipe_task
> > > 
> > >    # if there was a 'abc:xyz' prefix, add it to the end
> > >    if not basepath.startswith('/'):
> > >        cleaned += ':' + basepath.split('/', 1)[0].rstrip(':')
> > > 
> > >    return cleaned
> > > 
> > > Both simple fix and this rewrite were tested with `oe-selftest -r
> > > sstatetests`.
> > > 
> > > We feel this version has these advantages:
> > > * improved readablility
> > > * improved efficiency (the split is not repeated twice and function
> > > it has fewer `if`s)
> > > * honours the open/close principle better by not hardcoding
> > > "virtual:" nor "mc:"
> > > 
> > > Thanks for your feedback! I will submit this version as a patch if it
> > > is positive.
> > 
> > Well done finding this, the bug has clearly been there a while! I've
> > had a feeling there was something going on somewhere but never found
> > it.
> 
> Cache misses/extra tasks running has always bugged me but it never became a high
> priority target until this week. We started using the hash equivalence server a
> few months back and just recently, CI pipelines of what should have otherwise
> been all cached work started talking hours and hours. This current issue might
> not be completely responsible for what we were rebuilding since all CI runners
> experience the same recipe space checkout path. Which means even though the full
> recipe paths are in the sstate cache objects, they are the same for all runners.

FWIW there was a recent change to package.bbclass to add a sorted()
from Mark Hatle which would also have the above kind of affect, in that
case based on disk directory entry ordering.

> Your confirmation that we did find something so core and were able to fix it
> gives us more confidence to take a crack at the other issues we're seing. ;)

Please do try and figure these out! If I can help I will but obviously
its difficult with no data...

> > I've taken the opportunity to make the code slightly clearer so have
> > written and sent a modified version of your patch. I hope that is ok!
> > Please take a look and let me know if I've missed anything too.
> > 
> 
> It looks good, just using a slightly different method than the patch I sent:
> https://lists.openembedded.org/g/bitbake-devel/topic/patch_siggen/76318034
> 
> Can you share why you remade it?

I was thinking something slightly clearer was possible, I'd forgotten
why it works the way it does though.

> Also, my colleague Maxime mentioned test cases... It would be nice to write
> actual unit tests targetted directly on this function so I would then be able to
> submit with more confidence the refactored version of the function I included in
> the RFC just above here. (I still would like the community's review on it and
> comments on the advantages I submitted BTW.)
> 
> Perhaps if someone more familiar with these parts could send a list of possible
> formats the function encounters in all the different scenarios and give dummy
> before -> after strings. I could bundle this into unit tests along with my
> refactored function in an upcoming series.
> 
> Example: *
> 'virtual:something:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask'
> --> 'helloworld/helloworld_1.2.3.bb:do_sometask:virtual:something' * 'mc:...' ->
> '...' * etc.

As far as I can think offhand, the function accepts:

/path/recipedir/recipe_verison.bb:do_task
virtual:A:/path/recipedir/recipe_verison.bb:do_task
virtual:A:B:/path/recipedir/recipe_verison.bb:do_task
virtual:A:B:C:/path/recipedir/recipe_verison.bb:do_task
mc:X:virtual:A:/path/recipedir/recipe_verison.bb:do_task
mc:X:virtual:A:B:/path/recipedir/recipe_verison.bb:do_task
mc:X:virtual:A:B:C:/path/recipedir/recipe_verison.bb:do_task

and what we care about particularly is that given a list of these, the
sorted() result of the return values is consistent, independent of
path.

For example, we should get the same value back for:

/short/recipedir/recipe_version.bb
and
/this/is/a/long/path/recipedir/recipe_version.bb

so perhaps a unittest which tested that, iterating the above formats?

Cheers,

Richard



