Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web08.8850.1630742053073943712
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 04 Sep 2021 00:54:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NxJEdX6a;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so935553wms.4
        for <bitbake-devel@lists.openembedded.org>; Sat, 04 Sep 2021 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=1GdpaMJRNuTcPufE5nr8RlU/MFgAFFVdwTlhBv0UgWY=;
        b=NxJEdX6aN8ZsemZ7oYM826aXWIThDFfEPaSRvVUCbhD5UgqbK9sHNedoj9Uqkwhwgf
         tImzftPJTFAuucPspoxPUi5/YFkdQ+Di29gjBsn83mNc5UuGX+0nZ8XRag3uh3RlNhvn
         1YlLrp8lidmwlZZrRZsO4v5v/r62cCs8hlpyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1GdpaMJRNuTcPufE5nr8RlU/MFgAFFVdwTlhBv0UgWY=;
        b=fzwc3GjvPjHiCa+WRY1V4LqAxSucqWoWVnaJkDOkL2YrEb2NtSJ5FixNw9JhZsIAJO
         UkTCAIpTq6oP40FIwiP/DmF5tdwK5jky04Pp+ZnZM2HT9xmVdIHnjL+YU3N6UrKYYfNa
         RIbyDsrbEFkqWnlwVtIV4rZNq4RNh4T6j7ZsslathYrggqw2jTGp2hjX+AM+AfK5N67e
         hQmGjI8NOCi4PLowNHmfRq1/I7vNT6S5jBEGBSac+PcMm+CicVFFYM8EG1NaxIYGUJhl
         EGnE6lXlwmQKJP9f6J/u1s6N79fhafRTdLecv1LZ0cy8gJ69skttn5p2Yb1FdQnyFFOX
         qsXA==
X-Gm-Message-State: AOAM531BZzF3blZShwzoOTNfVuUPSuFBzYuJccfTpeSthtno5TtRSVP2
	OH8mFw3Z6UZUP8WYx+joTkN8Hg==
X-Google-Smtp-Source: ABdhPJyS12eYb1SfTKO9qZ3IsKaQFg4OOqkk0ZmxBTiOGo+rtWHCQ60WylwoQte19+R/1s/SCt1kGQ==
X-Received: by 2002:a05:600c:acd:: with SMTP id c13mr2172987wmr.28.1630742051345;
        Sat, 04 Sep 2021 00:54:11 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:435c:78bb:cd77:df6f? ([2001:8b0:aba:5f3c:435c:78bb:cd77:df6f])
        by smtp.gmail.com with ESMTPSA id a133sm1418770wme.5.2021.09.04.00.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 00:54:11 -0700 (PDT)
Message-ID: <209f7a813b8003ad75e5edb9600f729a91abee7b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] cooker: Only warn on potentially incompatible layer
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>, 
	bitbake-devel@lists.openembedded.org
Date: Sat, 04 Sep 2021 08:54:08 +0100
In-Reply-To: <22175.1630691638780132694@lists.openembedded.org>
References: 
	<b23f250a23dbd3273392b6694a442f5bb5602bf7.camel@linuxfoundation.org>
	 <22175.1630691638780132694@lists.openembedded.org>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-09-03 at 10:53 -0700, Damian Wrobel wrote:
> On Fri, Sep 3, 2021 at 07:07 PM, Richard Purdie wrote:
> > LAYERSERIES_COMPAT
> The problem is that there is inconsistency for treating layers with and
> without
> LAYERSERIES_COMPAT.
> 
> If the layer without LAYERSERIES_COMPAT works perfectly - only a warning is
> emitted.

This was from the time when we introduced the variable and we had to allow a
transition period. If you really want symmetry, we should perhaps make that one
an error now?

>  Then symmetrically the same should happen for a layer with LAYERSERIES_COMPAT
> - especially that this check is not able to detect any real problems in this
> layer - it only blindly rejects a valid layer.

We (as a TSC and a project) realised we had a lot of problems due to layers not
declaring which versions they are compatible with. We decided to make that a
requirement as it causes users a problem. I don't see that anything has changed
in this regard, if we drop this to a warning, people will just not declare the
layer compatibility and we're back to square one.

> Additionally, this bb.fatal generates compatibility problem as we're able to
> consume 3rd party layers which have LAYERSERIES_COMPAT in yocto morty (which
> doesn't use this compatibility check), but the same layers are false
> positively rejected by yocto dunfell.

As I say above, we have a period where we had to introduce this feature. We've
done that so perhaps now is the time to require it, not the other way around and
drop the check.

> Having this merged would allow to limit maintenance burden on 3rd party
> layers.

Adding a single keyword every six months to show the layer is active and meant
to work with a new release is not in my view a huge maintenance burden compared
to showing that the layer is actively maintained and clearly showing which
combinations are meant to work.

Cheers,

Richard

