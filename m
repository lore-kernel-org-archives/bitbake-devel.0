Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.web09.740.1615994775857653960
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Mar 2021 08:26:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=P0r25z+5;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: raj.khem@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id a9so39183069qkn.13
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Mar 2021 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00EAyzjeCZm8I6qiOjwGHzDVIBRSXkuGDkCID5eKqxU=;
        b=P0r25z+5m5kYHMmzWA0NHjnqJLO2n3F63rUWQLJAT+EXlErAPmiEFcgGBrHz5mVavX
         hgIXmt3zI8rh0VHdjlMpOUGfszDgQXzx4hpleYzwUzc1tENxpNHm7phF843V12/L02Jr
         o7n+aHmZl6qjvhCEHyy9a1ir01oEC/vlxyAMFmRFkP2vTqTSUBTwW3DYF1LmUXk8LySs
         BJSfKLCOlQlVR+8xs1+lCRBlV1ZmPYhIwS7HUHWDk1VnRIVoOlX+Bi0LvlA8sWQUpdtF
         AE+XAovgPv9Kjiul92eEln2yjmrnhhCnXEfZeaa1mlavBwrlfV/kthuO0JY+GtFTUH26
         dBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00EAyzjeCZm8I6qiOjwGHzDVIBRSXkuGDkCID5eKqxU=;
        b=Z7m3k2PENZb90vYU4MmfUucalulB/nv+iJTtqQ1P9rxcnOeRmqGSuWJJhHyAf2ylfp
         9KH6Y6imWiS8rhVf17+oFHlbJMGtYaGhaZm5TE/t5LGSzv66xEtNdpCNPWVwxAPsEl5P
         w08/5bTwbidPserj0/1FaKutbgiRa+rG/n5A0uUXdLCL/RXVMfku/TkucYo9JuYH5wtU
         B66Yu2AKlLJvZ3814uftCtnIOvhqtrlw/+dVduHRXWxUX1EiRtE2e+bgltm1h8gX6Pzl
         cejW+vlEpH57E+aW6txNsaI7X1vHvtfUeZODrJuKAQiJSOoMqG4GFx5Bg47GKa/jiISX
         ma+g==
X-Gm-Message-State: AOAM531FVk+UCAHWxwOEDgsk7LBBtfhRT/O22JuIgQqrpNp4ZXAtt3fz
	iHluvMp0Cj/V4ujJrwrBED/jdvxQbbd+Ih43/LoKGGwv3AM=
X-Google-Smtp-Source: ABdhPJw6OgvsmVKiT0VteB+LCY47eXAJoOxIFoq3ZtxUK0+qMO2uuqygJNpQkjvJPy4vpvUxESxOY1Wt4meU/f7+hSU=
X-Received: by 2002:a05:620a:124f:: with SMTP id a15mr5269744qkl.125.1615994774777;
 Wed, 17 Mar 2021 08:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <9914cbb9-eb88-c215-4fec-185762583ed@crashcourse.ca>
In-Reply-To: <9914cbb9-eb88-c215-4fec-185762583ed@crashcourse.ca>
From: "Khem Raj" <raj.khem@gmail.com>
Date: Wed, 17 Mar 2021 08:25:46 -0700
Message-ID: <CAMKF1so2rS8miJHs-V+DHV5SXLAMd=F1FizmnQ9GzuaTfQ4mKw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] doc: Mention OE routine for setting BB_NUMBER_THREADS
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 17, 2021 at 3:34 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> Given the discussion of BB_NUMBER_THREADS, what it means and how to
> set it, it seems only fair to mention that it's probably already set.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> index d74e768f..a2003997 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> @@ -45,6 +45,13 @@ the BitBake command and its options, see ":ref:`The BitBake Command
>     A possibly simpler solution is that some Linux distributions (e.g.
>     Debian and Ubuntu) provide the ``ncpus`` command.
>
> +   If you're using a relatively recent version of Poky or Openembedded,

I think it would be better to avoid distro names in generic documentation

> +   the provided ``bitbake.conf`` file already comes with a call to an OE
> +   utility routine that does this calculation for you::
> +
> +     # Default to setting automatically based on cpu count
> +     BB_NUMBER_THREADS ?= "${@oe.utils.cpu_count()}"
> +
>  Parsing the Base Configuration Metadata
>  =======================================
>
>
> --
>
> ========================================================================
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                          http://crashcourse.ca
>
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ========================================================================
>
> 
>
