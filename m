Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.25842.1584867379155626337
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Mar 2020 01:56:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WZwllZqP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f67.google.com with SMTP id m17so3712309wrw.11
        for <bitbake-devel@lists.openembedded.org>; Sun, 22 Mar 2020 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xVUDRBRL3uY0qJkG76IAsaXRsNb/DKJI5TEJYRmVu+o=;
        b=WZwllZqPeCkVzuoa4Uai2wDTfHLhJGoh9jpcZwnZcyiSIX+5Lp6sBaODazw+2TzRWf
         U9z37c5vTcHflIQuZsblQRIOg/Iw3bnC8WqgOv5if0N8/OVQGLgIpI6mZAEijGyMPkHb
         Vwe21SwYUW1dVXUAwexMCXaeY3E3M259FvwOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xVUDRBRL3uY0qJkG76IAsaXRsNb/DKJI5TEJYRmVu+o=;
        b=cZlqW17LbvJyFEAyKX4Eavkxv1TzU+Ly50GrEn969rDgUkrHcGMiOXh6LB13+WF0wI
         cUEHfLGmZZz16Nl5KCZA67PnPZYPnSfXY9+MPyGyM9/Si4GVTuJkei39KxaHsi0h3zKy
         4gtgBXMn2B7jCmKAhlNu5iwnT5gJhAwxeLjr808vrubjx2YcYpBvFOuzmBzp4JM64vkl
         ONtJVG6/L4QxUqB3S+RFM00DNhA6+yPQKYquNER784m9cDt5rSjiAH43L8m17jU5i3C1
         DI9oo2R/iJ1AKpGetsV3f5R+Xv7cp0vSFrumSVmAPyo9J3kFe8vESptv/6LiK49H2jeV
         ZxvQ==
X-Gm-Message-State: ANhLgQ0Xs2G83pn/2CS7zkYZGkw/7kQ5spOI4G3XPo/bRANi56JcU+aY
	kmGue0zHq6oGtI0Nhso2IRD3Eg==
X-Google-Smtp-Source: ADFU+vs4Z7mmTW+CQcyD/3HMMYA7vErjkDW+Q0TMgtwLp2gjcP4z8mLKKgaUXrmQyWr7vDZDDdvd0A==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr23131899wro.16.1584867377554;
        Sun, 22 Mar 2020 01:56:17 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id v8sm17758653wrw.2.2020.03.22.01.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 01:56:16 -0700 (PDT)
Message-ID: <0fa4ecce8452d9f015c00afe29710c45e5328899.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, Khem Raj
	 <raj.khem@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Sun, 22 Mar 2020 08:56:12 +0000
In-Reply-To: <2f891d304ee448538457d2b94c32bba3@XBOX03.axis.com>
References: <20200215032955.3958-3-pkj@axis.com>
	 <5532.1584827063458682607@lists.openembedded.org>
	 <1cdd50184c1f4af488baee9ee691b495@XBOX03.axis.com>
	 <CAMKF1srOQVRW8n9bzr9GXiA3NBOX=cE5EV-W9S_dq+JFRqNjMQ@mail.gmail.com>
	 <2f891d304ee448538457d2b94c32bba3@XBOX03.axis.com>
User-Agent: Evolution 3.35.91-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sun, 2020-03-22 at 00:38 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: Khem Raj <raj.khem@gmail.com>
> > Sent: den 22 mars 2020 00:59
> > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > Cc: bitbake-devel@lists.openembedded.org
> > Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow
> > ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
> > 
> > On Sat, Mar 21, 2020 at 4:50 PM Peter Kjellerstedt
> > <peter.kjellerstedt@axis.com> wrote:
> > > Rather than blindly reverting, can’t we update the documentation
> > > instead? If you use ${AUTOREV} you obviously do it because you always want
> > > the latest revision.
> >  
> > Autorev + clear srcrev policy if you want that
> 
> Well, obviously ${AUTOREV} works with BB_SRCREV_POLICY = "clear". But 
> BB_SRCREV_POLICY is a distro configuration and it is not possible to override 
> it per recipe.

BB_SRCREV_POLICY is quite an old piece of code and its design has
issues. It should really be changed to work per recipe (and use
something other than persist db but that is another story).
 
>  Which means that if it is set to "cache", it is not possible 
> to use ${AUTOREV}. This is not documented, and to the developers it will look 
> as if it is working, since it fetches the very first time the recipe is built.
> But there will be no updates, so it is as useful as setting SRCREV = "master" 
> (which some of our developers also have tried before being educated to how 
> BitBake works)...
> 
> > > Before this change, using ${AUTOREV} in combination with
> > > BB_SRCREV_POLICY = "cache" didn’t work, which also wasn’t documented.
> > 
> > It could be interpreted also that cache also caches AUTOREVs
> > this will break downstream projects. Its equivalent of ABI change,
> > that perhaps will do more harm then what it fixes.
> 
> I fail to see how it will break stuff as it was not possible to use ${AUTOREV} 
> before in a meaningful way together with BB_SRCREV_POLICY = "cache".

It gives a behaviour people asked for and need under certain scenarios.
I appreciate that isn't yours. I should not have merged the patch as it
breaks behaviour that people do use and I misunderstood what the patch
was doing :(.

The question is where from here, technically a revert is justified but
I do understand the per recipe configuration issue.

Cheers,

Richard

