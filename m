Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web09.10701.1604789495953431130
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 07 Nov 2020 14:51:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cHu/WoaH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f68.google.com with SMTP id c17so4951494wrc.11
        for <bitbake-devel@lists.openembedded.org>; Sat, 07 Nov 2020 14:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=XVMRfXAlVr9IaCpzOQwM8W0FFOtkeWcEqBWLOegXctE=;
        b=cHu/WoaH4fL8RoTKzHHAlewVlNWEr/x+Yp6m58jAAz5eU692d6uL9ji+fRLpgzgvTA
         juR/R1yZyv1qeGdjPQOjU3MmziaPEQRMfRWoH9QmePCzKG8gT15vm0MBP8F+84J6ir63
         I7TxCIjpA3q3iGUj4/aFauzi6ZWPlIEZhP3OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XVMRfXAlVr9IaCpzOQwM8W0FFOtkeWcEqBWLOegXctE=;
        b=UmPEy3Eo4J05gMDsN4I2GjH/br2mtrft0t/3XXGIaL05102DC15wFIpgiye9DQmHZ8
         OeErFoaNY5sXYdltHIWM8srI338i5KD1QdzpUFUckj42kAbT1VFG1EMQjx+1o56wZHK9
         EF8pE/j36nhPfHP3okoQBD3LinDiA53ITnAz60M7b0ljsCrSMSg+UoxhVqyePMs8SQXD
         ylaYf5Ywdu1m+mo+k4aWPx0aEc7RCFl3LdHogZu6OHc1PI0GKD9m0E7we6t4GacHWA1k
         eZRGon8RlAClHaAuyfkt1n0nK3HgGgfBY7Q7ujX9C957cKt4wWqBgDoK3zh64vw+sZQn
         MUew==
X-Gm-Message-State: AOAM530b1cGj+xXcVJzzZgh6z2tkbZnfW5fJnfk3BfU/kFl8LCZOf1zl
	MZo0benjho5w3Tb6t2r3wADg4g==
X-Google-Smtp-Source: ABdhPJzyhp1yBJnLmo1b7VszUmHreFB9TvlyxEV0Zl/X19ar7ELM1v0UBZxQ06UQ+S8w6YRiTM2aBg==
X-Received: by 2002:a05:6000:1006:: with SMTP id a6mr1225329wrx.367.1604789494443;
        Sat, 07 Nov 2020 14:51:34 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 7.e.4.c.9.7.4.3.c.6.2.9.7.2.8.5.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (7.e.4.c.9.7.4.3.c.6.2.9.7.2.8.5.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:5827:926c:3479:c4e7])
        by smtp.gmail.com with ESMTPSA id o10sm7764885wma.47.2020.11.07.14.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 14:51:33 -0800 (PST)
Message-ID: <940c12c0b27567eab634098ac0de1c7dbffaed65.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] build: defer processing of cleandirs until after lockfiles are acquired
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org
Date: Sat, 07 Nov 2020 22:51:33 +0000
In-Reply-To: <20201103151537.19348-1-chris.laplante@agilent.com>
References: <20201103151537.19348-1-chris.laplante@agilent.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-11-03 at 10:15 -0500, Chris Laplante via
lists.openembedded.org wrote:
> This is to avoid potential races for tasks that use both [cleandirs]
> and
> [lockfiles].
> 
> It is currently believed that normal [dirs] handling is fine as-is.

Unfortunately this caused all kinds of weird build failures in testing:

See the builds triggered by:
https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1550

I reverted this commit and things started working so there is something
wrong.

Cheers,

Richard

