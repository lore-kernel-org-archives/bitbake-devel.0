Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.61534.1629325233408866949
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Aug 2021 15:20:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=abR/8UBt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id l11so5865896wrx.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Aug 2021 15:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=FOep0riu5l2hsiNAtjY9Hw+x1ttBBUHEoOO+hOB7VIw=;
        b=abR/8UBtV+L57+zn8GE8S01ZA6slvhX+CpR3izsaJIGlxemY6KmyUFsEU7QhAsq4f/
         DmJbU8UyE+/CZYm4hi7RDC8TQDyPreNHHX6CYnepajRvbpi5LCbydXjrswXsmIwwSRcv
         nRBrfX1d/Nd1wno6USqt6oN0CL//JI2ao77O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FOep0riu5l2hsiNAtjY9Hw+x1ttBBUHEoOO+hOB7VIw=;
        b=oHzKlQyNFFKNqLiVw5/FNy94aE7H2RSQZ297TgPAnjhfPwwBEo/hshCX8sskYrIWVl
         Vz7I8FLkd82tOsdt1s2Jo1jVRMHwDkujQnu5xmcK5E+diZulIpH+g83tuWUysvvB7EZ7
         3JAavfaYNgZD27cYQsZfk/sJSPx31k23EBkcNPw1I56qr2rGjfEIqj1PRAco7SEkGN/h
         VqrFRKatVFHV/IvBqlkrFMs6X9eWtSuYTqg/1VUuoQCoeTtG24yvqs3Ibqmvqfz3JtMR
         zlQ2Aana7p4diHj3EJGO1a2N7E+nBaf3XZXkiJ/R5aNhC5Z4eLuKZpgKgkd2noiVartl
         snLg==
X-Gm-Message-State: AOAM532lbrmWxHqeFSKJgId4p/le5Tbv0X8fiDGZPb476KRmX3mGz492
	xOG37AEJMR+EPNVQLcupyhSwAg==
X-Google-Smtp-Source: ABdhPJxPSVxn61xClWP4HMzWR35tDx16GFfMX8oBrYpLnDKgLBbKLzA70SBD20FpLZJ8K+x68qDkpA==
X-Received: by 2002:a5d:64cb:: with SMTP id f11mr12956296wri.85.1629325231824;
        Wed, 18 Aug 2021 15:20:31 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:893b:b0d7:8112:9a58? ([2001:8b0:aba:5f3c:893b:b0d7:8112:9a58])
        by smtp.gmail.com with ESMTPSA id w29sm1097533wra.88.2021.08.18.15.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 15:20:31 -0700 (PDT)
Message-ID: <eb65ff99d5863afa3425269ff7e3b0d532c5fa0e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Trouble capturing layer revision as variable in recipe
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Wed, 18 Aug 2021 23:20:30 +0100
In-Reply-To: <DM8PR12MB5430C5689FA1BE41556758938BFF9@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
	<DM8PR12MB5430C5689FA1BE41556758938BFF9@DM8PR12MB5430.namprd12.prod.outlook.com>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2021-08-18 at 19:21 +0000, Chris Laplante via lists.openembedded.org wrote:
> Hello all,
>  
> We are on Yocto ‘zeus’.
>  
> Our u-boot recipe generates a versions.txt file containing the git commit of 
> the U-Boot source tree. It was pointed out that since recipes can patch the 
> source, just the source commit ID isn’t quite enough. So we wanted to also 
> include the git commit of the layer housing the recipe. Call this layer 
> “meta-our-layer”.
>  
> This is the implementation we tried:
>  
> def get_layer_path(d, name):
>     layer_list = (d.getVar("BBLAYERS") or "").split()
>     return [os.path.abspath(l) for l in layer_list if l.endswith(name)][0]
>  
> def get_meta_our_layer_commit(d):
>     import subprocess
>     output = subprocess.check_output(["git", "rev-parse", "HEAD"], universal_newlines=True,
> cwd=d.getVar("OUR_LAYER_PATH"))
>     return output.strip()
>  
> OUR_LAYER_PATH := "${@get_layer_path(d, "meta-our-layer")}"
>  
> OUR_LAYER_COMMIT = "${@get_meta_our_layer_commit(d)}"
> OUR_LAYER_COMMIT[vardepvalue] = "${@get_meta_our_layer_commit(d)}"
>  
> do_deploy_append() {
>     echo “meta-our-layer:${OUR_LAYER_COMMIT}” >> ${DEPLOYDIR}/versions.txt
> }
>  
>  
> However there are two problems:
>    1. Making an empty commit to meta-our-layer doesn’t cause the recipe to be 
> re-run. What’s weird is that when I use ‘bitbake u-boot –e’, I can see that 
> the value of  OUR_LAYER_COMMIT is indeed changing. And with bitbake-dumpsig
>  I can see that OUR_LAYER_COMMIT is in the task deps for do_deploy.
>    2. If I build ‘u-boot’, then make an empty commit to meta-our-layer, and 
> then run “bitbake-whatchanged u-boot”, I get a “The metadata is not deterministic
>  and this needs to be fixed.” error.
>  
> Am I misunderstanding the purpose of vardepvalue? I thought it could be used to 
> here to help bitbake ‘see’ through values that otherwise change unexpectedly.

I suspect you need to have bitbake always reparse the recipe too. Maybe
BB_DONT_CACHE = "1" ?

Cheers,

Richard






