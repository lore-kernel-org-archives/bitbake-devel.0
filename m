Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.28567.1620632753357111113
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 May 2021 00:45:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CTdpAzHq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id n2so15560886wrm.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 May 2021 00:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yn0flWqO0aqD+o+7OL9qG4nG32wvDglBrdS5+FlWMr8=;
        b=CTdpAzHq8pm3fGEMcPivlNT7zwVEEVo7pUqAcUgxZyWH6Q3Cry992ePUWY7dyip1gu
         DYmribu2zNzhUTPFbgDnZHXjbYp639A+RDXrEKyL0s7duITtxSzn7tX1+XjBsYRw+Cyb
         t/H0u1zgSM+s0i/l0BfDvVieyPvzHvczqGPyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yn0flWqO0aqD+o+7OL9qG4nG32wvDglBrdS5+FlWMr8=;
        b=jhibUWuXKPlUQbtGCJbA02DYj8Po8DTmlN82eYwFSGy2DBdfTA+GIhHKwbDLe7YQmC
         jLe6BMjvUYvDT046aRsmVg+e8yTViYiCDtC5qXH2QPa5LthhN8bhkhv3FGmqC8zYpv5n
         qlSv9/pti1ss1H/EpiVtdmLdxCrhmY7hAw7rsTOLVbz2HdsSfYHNB/UAJPJxns3yBGM9
         Y4Yldroody9quZMkeuJiO70NwBQjHzfYYZ9IOWNItYOQ1VGDw3pXfnDab6INwhPopY2/
         K+Nll352W6gqFxJgVs7U4lQQmBT+7vZYT3GXLXr8z6CLgZFmU6bd25XtTcsNypNF8koo
         2rPw==
X-Gm-Message-State: AOAM532BBGSYy3F2pG9W+lqpc3v5xd6b26apTdWbVBBlzrXg4xnSROiR
	FkqdpoJ1mAEHrwzo+ZT4ZQdHlw==
X-Google-Smtp-Source: ABdhPJyJB5TYxVNa1THahlIf/vSW63dsyxiEGmlZ4QQbetLG2zUAkAVi7NUWqrzxLy7uQwhKB49RQw==
X-Received: by 2002:adf:e291:: with SMTP id v17mr28421987wri.149.1620632751748;
        Mon, 10 May 2021 00:45:51 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:67a1:e913:59c9:6aa6? ([2001:8b0:aba:5f3c:67a1:e913:59c9:6aa6])
        by smtp.gmail.com with ESMTPSA id z9sm18347998wmi.17.2021.05.10.00.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 00:45:51 -0700 (PDT)
Message-ID: <af9bfa8a948cf4be116cd031a3f20f0c4998bb09.camel@linuxfoundation.org>
Subject: Re: Help on Handle BASH_FUNC shellshock implication
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc: "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 10 May 2021 08:45:50 +0100
In-Reply-To: <DM6PR11MB42025DE7A846AF975F14E0DEFF549@DM6PR11MB4202.namprd11.prod.outlook.com>
References: 
	<DM6PR11MB42025DE7A846AF975F14E0DEFF549@DM6PR11MB4202.namprd11.prod.outlook.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2021-05-10 at 06:45 +0000, Zhang, Qiang wrote:
> Excuse me, I have some questions to ask
>  I've added this modification :
> http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=eb2ea6fd2d2dc626ead13de1ec334d4220651612
> 
> In Ubuntu 18.04
> but   I enter the following command , it will still fail:
> 
> foobar() { echo "foobar"; }
> 
> export -f foobar
> 
> bitbake -c menuconfig linux-yocto
> 
> the error occur, not launch menuconfig
> 
> 0: linux-yocto-5.4.x+gitAUTOINC+d676bf5ff7_1b10854a10-r0 do_menuconfig - 0s (pid 6398)
> Trying to run: tmux att -t devshell-6398
> can't find session devshell-6398
> Trying to run: tmux att -t devshell-6398
> can't find session devshell-6398

I'm not seeing the connection between the export command and menuconfig not 
starting. Are you saying that bash function exports are breaking menuconfig?

I'm not sure what you're asking...

Cheers,

Richard

