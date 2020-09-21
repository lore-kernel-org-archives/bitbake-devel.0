Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.47806.1600711416140248895
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Sep 2020 11:03:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gzrLvLAh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id k18so377166wmj.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 21 Sep 2020 11:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=+M9aNwR3q/DWHnr39/jHvSxOpovmKcbEV9PReFtFLOI=;
        b=gzrLvLAh2nDDRRjv3HQlzKzkpYY1VPKDkoXncgIA2a00t1Ke9jycW7IyTJilq+gaEs
         S/gWBX+QSnLEnOCNuQMIL0wKjPUNEQg1NYDjt2PLkVkYUBm2fQht5mw5PJcAhcbEb2gu
         XNg546GP6qY/V8a0SlfOeVtKpkLBFOe7BrWAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+M9aNwR3q/DWHnr39/jHvSxOpovmKcbEV9PReFtFLOI=;
        b=iZX/znrjwSaP4y6wkNCnetTFDuiA/Dwdtc1UcA8BN4e3NEkIxqKJRabD3SH/UCHlU+
         U5B5n29sZvDbxQz5KCF5fOSdZKoVWxpLnXBt3T30hOKsddvB2MQQoqLEAo8Aoh2CFiQN
         00DccI7Q4+sL6cKpJ6McCSAGfKoSJayZ4ZpjQT9Ip7UCFiYEdq9dy4cFK1yxo6U/j/6c
         zXU/tRv1Ey75Ov9/dXNTuLA0wQsABAkR7+U+2maSJPHsuCs2G+R7PEIm5lRutWlcMIFj
         gzdsmtTph9XITfmbceVwvwYui5QuI0N+38aV+u3JfctUDOJjQhTQHVT5BOndQXcQfCNp
         Pl+w==
X-Gm-Message-State: AOAM531COhj8+2/syJgpNa+kd1imhSEEeCuIasVdu2WQFUTXj47kP5QD
	7FFccxnLihGhdDHCvRDAk/X+ZA==
X-Google-Smtp-Source: ABdhPJwmnblCyYZXSOtyiRdEWpq9JSI9y6DwJCuZVNS2eFLFZiQRVgO9Rrd38tlaXD3OYzKIdwac0g==
X-Received: by 2002:a1c:6341:: with SMTP id x62mr589347wmb.70.1600711414356;
        Mon, 21 Sep 2020 11:03:34 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 4.0.c.9.a.6.a.b.7.4.d.7.f.b.8.3.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (4.0.c.9.a.6.a.b.7.4.d.7.f.b.8.3.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:38bf:7d47:ba6a:9c04])
        by smtp.gmail.com with ESMTPSA id y1sm457537wmi.36.2020.09.21.11.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 11:03:33 -0700 (PDT)
Message-ID: <f74b7cc1ca622231e5570807873dade8b257b18b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Downgrade util-linux
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Mathias Radtke <m.radtke@uib.de>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 21 Sep 2020 19:03:30 +0100
In-Reply-To: <kcEE.5s8ZgDnjR+m5TxjkKS3lEQ.AESCHgiQ1gE@groupware.mz.uib.gmbh>
References: <kcEE.5s8ZgDnjR+m5TxjkKS3lEQ.AESCHgiQ1gE@groupware.mz.uib.gmbh>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-09-21 at 11:12 +0000, Mathias Radtke wrote:
> Hi
> I am currently experimenting with yocto and I was having a good start
> until now.
> I want to rebuild a bootimage we have with yocto.
> Currently the bootimage uses sfdisk 2.25.2 as later on the outputs
> changed and I didn't have time to adapt I always downgraded util-
> linux on the old bootimage.
> To get quick results with a yocto based bootimage I wanted to do the
> same. I found a receive for a util-linux 2.25.2 package and added it
> to my recipes.
> In my local.conf I added:
> 
> # downgrade util-linux
> PREFERRED_VERSION_util-linux = "2.25.2"
>  
> However this seems to work partially as the output of bitbake is now
> the following
>  
> ERROR: Multiple versions of util-linux are due to be built
> (/home/user/opsi-linux-bootimage-yocto/poky/build/../meta-opsi-
> bootimage/recipes-opsi-bootimage/util-linux/util-linux_2.25.2.bb
> /home/user/opsi-linux-bootimage-yocto/poky/build/../meta/recipes-
> core/util-linux/util-linux_2.35.1.bb). Only one version of a given PN
> should be built in any given build. You likely need to set
> PREFERRED_VERSION_util-linux to select the correct version or don't
> depend on multiple versions.
> 
> How can I build a bootimage with a downgraded util-linux package?

I'd suggest you move the old recipe out the way and that should quickly
give a clear idea on why its trying to build it.

I appreciate that isn't an ideal way to debug this but it is usually
effective...

Cheers,

Richard

