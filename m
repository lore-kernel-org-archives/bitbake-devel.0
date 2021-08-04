Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web08.6799.1628071129289604556
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Aug 2021 02:58:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GENbZOG6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id j2so1538439wrx.9
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Aug 2021 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FvCHxTqV/5/CF8QkyjlqdFLSq8LD+UyyqsYWQjysLkI=;
        b=GENbZOG6dvxtr1C9LQeKFn8ffGs14Hw8dt1Aq6rL2swHDnYVoXvlyBQFPI1YqEUFs2
         e16arT5eZeT96aS+az/y4zMthM6Lqwi87ER7Dsv0HJpHWVGz0J9NSlxjGy5ToCEbCHXU
         bqnp+QpVSOuvRspVMMUY/pW0JA+SE9nPY7T88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FvCHxTqV/5/CF8QkyjlqdFLSq8LD+UyyqsYWQjysLkI=;
        b=o+7Cxw9YbZQRZ1Jlhd2omtFTg97iu6vasoo56Oi0knqn0kvDWvo06xabbOsG7VJxIW
         DVbX89beIIXvsOx/zt/1hqPPnzUHlFsrubvfVnde0b16NAh1l/mtFhYVymY/MMd7rVHp
         QuZyvtyj3kVidYzGeVf9B3m0pD90YZkk6oJnxdEOI7r5C0Olew3Hj62y9Ld4S8+lPPVO
         QmyNxgbBnvrrFDhvyWaEw6Oqtq+YPJMta+oy/MMQzxdVqJN8EQpg6Tj7CISeDZyICHXn
         oowDNYFHE5aSaJKbR8jkQMbmkXuzJeUoOTNI+mtsOqcSce1mUuI2FVcG3Qbqgtc0SEyw
         b3Cg==
X-Gm-Message-State: AOAM533216NUqdJq2GN9KTHyE7XnjzOqSbERQkdi40boT0ze013sfFUf
	o4WsVdTXVnsrf1JEIr79T81EPItoX/cXmg==
X-Google-Smtp-Source: ABdhPJzuGGggN/ThifGY0zYpxcJAYCoqZERaaBVLSaCH6uhrkpG40V3peHHSfr2h3HQzjHRh2RwRmA==
X-Received: by 2002:adf:efc7:: with SMTP id i7mr27870871wrp.87.1628071127669;
        Wed, 04 Aug 2021 02:58:47 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:895b:15d0:6c2e:72fa? ([2001:8b0:aba:5f3c:895b:15d0:6c2e:72fa])
        by smtp.gmail.com with ESMTPSA id c204sm5304868wme.15.2021.08.04.02.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 02:58:47 -0700 (PDT)
Message-ID: <29b60e64d2f40f7064b87e0b3c7c52583fddab63.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/4] doc/lib: Add fixes for issues missed by the automated conversion
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Quentin Schulz <foss@0leil.net>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 04 Aug 2021 10:58:46 +0100
In-Reply-To: <249e08c0bda32c45a6ed1de71638bb36@0leil.net>
References: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
	 <20210730134706.3360651-3-richard.purdie@linuxfoundation.org>
	 <249e08c0bda32c45a6ed1de71638bb36@0leil.net>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2021-08-03 at 00:09 +0200, Quentin Schulz wrote:
> I can suggest the following additional changes. Please note that there 
> are two sections for which I have doubts about their correctness. They 
> are preceded by a FIXME FIXME FIXME comment that can (should) easily be 
> removable after applying this diff with `patch`.

Thanks. I couldn't get the patch to apply for some reason (line wrapping?)
so I just fixed up the references.

> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 60aaf390..46ce78a6 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1146,9 +1146,10 @@ def srcrev_internal_helper(ud, d, name):
>       pn = d.getVar("PN")
>       attempts = []
>       if name != '' and pn:
> -        attempts.append("SRCREV_%s_pn-%s" % (name, pn))
> +        #FIXME FIXME FIXME not sure about the SRCREV_%s to SRCREV:%s change
> +        attempts.append("SRCREV:%s:pn-%s" % (name, pn))
>       if name != '':
> -        attempts.append("SRCREV_%s" % name)
> +        attempts.append("SRCREV:%s" % name)

This one shouldn't be changed, at least not at this point as name is never
an override.

> diff --git a/lib/toaster/toastergui/views.py 
> b/lib/toaster/toastergui/views.py
> index 04ab8bcb..34afacc1 100644
> --- a/lib/toaster/toastergui/views.py
> +++ b/lib/toaster/toastergui/views.py
> @@ -1839,6 +1839,7 @@ if True:
>           except ProjectVariable.DoesNotExist:
>               pass
>           try:
> +            #FIXME FIXME FIXME Is this correct? it could also be 
> image_install_append_defined or image_install:append:defined
>               context['image_install:append'] =  
> ProjectVariable.objects.get(project = prj, name = 
> "IMAGE_INSTALL:append").value
>               context['image_install:append_defined'] = "1"
>           except ProjectVariable.DoesNotExist:

Kicking myself on this one as I meant to fix it and something must have got 
lost in the process. It should stay as image_install_append_defined

I've sent out a couple of patches with the updated version of this, 
thanks again.

Cheers,

Richard

