Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web08.6728.1631265397949563925
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 02:16:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UDAsju5Y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so863011wms.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 02:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=CRJcK5o0xNAmSVTtoAjZ9hdVHMYo8dRK4oiblv5RcnY=;
        b=UDAsju5Y00C86HY6cI49BEQhrVVAzuIO1/0yUJjrSbiALL2fTLCvh76KSWHnYDD+8b
         2QKC/fPntEyoZUJhPOIiTt6rbHqecIlVwnbjhMLiksKWlL83kv+kd5z6/eXHlFK1/QUu
         REHeXaNvWkyYyTQtawSWmZesOLY/Aarf4w8hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CRJcK5o0xNAmSVTtoAjZ9hdVHMYo8dRK4oiblv5RcnY=;
        b=pKLkSsnEVHQh4zG5l1KlSh3ZzcCoISDXtkMvpG74L0PNVFodLG9EyY4Tzl8+gshDhq
         iX4o/Aw9rYPMwK/H5YMXKQlcI9ROsAwi4DpCQgpRaLduAMGmM5s6cxUaYeRUHDciV12a
         Bh+Vy/0vsecJy3pz/qmZQRasaobpQUPk290Jwfz0EhrbMk7qDhqgns7jOF9D+8SNCPml
         o5AI3N4RrSOvy3l7CIdDv6GDKqWIrnQU79CtuPP3c/5MVX26aRroMn2YxYy4jGXhgVIC
         S6I232/IU9rT+AH82fp6KkAqQZr7BF4B3t8t3wBvJfneAZW4hJ49snSnPvCyO1mDH6ub
         kk+Q==
X-Gm-Message-State: AOAM533yTVD4Y1Q9EvwypnE8iiO8IEGqDYCU544QFfhiBOyV01olMHfE
	9z7GVEnoRi5depjt5bDZ4xhiaVkDg6y5rqGQ
X-Google-Smtp-Source: ABdhPJxmRueRfMGwpATr3c8tTnLvYWkGl4SVL4aqXaI2ZDkXa9NOAD+J5QuJwZRpKwC9AmuNqqNSBw==
X-Received: by 2002:a1c:488:: with SMTP id 130mr7153448wme.156.1631265396336;
        Fri, 10 Sep 2021 02:16:36 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45? ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id c9sm4212337wrf.77.2021.09.10.02.16.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 02:16:36 -0700 (PDT)
Message-ID: <88acbda2e5d9e10d61cc8ca3eae3ca0cfef815be.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/3] bin: Drop unused warnings import
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Sep 2021 10:16:35 +0100
In-Reply-To: <16A3416C46EA4D69.981@lists.openembedded.org>
References: <20210909203019.1231314-1-richard.purdie@linuxfoundation.org>
	 <16A3416C46EA4D69.981@lists.openembedded.org>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-09-09 at 21:30 +0100, Richard Purdie via lists.openembedded.org
wrote:
> Drop some unused module imports.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  bin/bitbake-diffsigs | 1 -
>  bin/bitbake-server   | 1 -
>  bin/bitbake-worker   | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
> index 19420a2df6..2786ecd673 100755
> --- a/bin/bitbake-diffsigs
> +++ b/bin/bitbake-diffsigs
> @@ -10,7 +10,6 @@
>  
>  import os
>  import sys
> -import warnings
>  import argparse
>  import logging
>  import pickle
> diff --git a/bin/bitbake-server b/bin/bitbake-server
> index 8e53947361..b5d275b70e 100755
> --- a/bin/bitbake-server
> +++ b/bin/bitbake-server
> @@ -7,7 +7,6 @@
>  
>  import os
>  import sys
> -import warnings
>  import logging
>  sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
>  
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 7d982f90ba..a9e33ca7c7 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -5,7 +5,6 @@
>  
>  import os
>  import sys
> -import warnings
>  sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
>  from bb import fetch2
>  import logging

Whilst this is a valid cleanup, I think AlexK may have a better proposal for
this.

Cheers,

Richard

