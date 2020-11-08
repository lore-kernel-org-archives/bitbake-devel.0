Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web08.19582.1604852612274563708
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2020 08:23:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IkyNjZ/D;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id p22so5866858wmg.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 08 Nov 2020 08:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=ARRNLq9fvl2oXXcUaPX+p+1rEeq+dwXUjNeO4NOXTDA=;
        b=IkyNjZ/DVI7miIc0TrMKe/ot2kK2fhQ5VTE6DFrE4JRAmaSaoM5vdEvJnvZkQACE/t
         mpKQCRHvvZNFLAQOWwuaOdw9VsNlsDBKZBIsOEIAztqvmI6dUOW02r2ffidboUhesi9y
         jBG4+3nsDxN5C9DahJPu9D5bmJ04VAiz8q8M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ARRNLq9fvl2oXXcUaPX+p+1rEeq+dwXUjNeO4NOXTDA=;
        b=qU5McTKaI7eFQqn1GOXs1gfDIQVliaPqWAB81KHfmGUQYqEzvqNxG1rAXdF9CrWKe9
         xbHVm5XtxRB2WAu3+PRjHAoTEZjsmwhZ3c70rgvp5hJOOeTr5FF6zLmE/TmzXuRZMQN4
         7Z+a5RFJcqG1TCWGVMQfEq3/BbnqPL8pYeH3fwafLYR300xwQuQhhIi3pQCwZn1Wkzo5
         JtfNLAj+fHVp2nOmdckYa4lsZpGhYvQJ4HB4gFY13eUx4xY0ljyTLVY0cnMpj8GtRnvy
         953M1t8SiY12svc3I+v3QNx1AnJUk3eEXgT/tfm2acOuduYrSztD3aT64I2IyQLyzhhE
         PZrQ==
X-Gm-Message-State: AOAM530Dk/CiF0liU0D+afuRDsZF/TNbkZ1CsmX9jUsZLb5/vYUcvZOY
	Av/z1/o4+d+ZuwQnpSLWpN1grA==
X-Google-Smtp-Source: ABdhPJxsYPv4JqjcvKtmQDfBSkSzQEglnQwQZSJbS4tEEgnS/EvtN+hh6R7PGTYaW+jiVakljLX02w==
X-Received: by 2002:a1c:bb02:: with SMTP id l2mr9677875wmf.166.1604852610776;
        Sun, 08 Nov 2020 08:23:30 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 7.e.4.c.9.7.4.3.c.6.2.9.7.2.8.5.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (7.e.4.c.9.7.4.3.c.6.2.9.7.2.8.5.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:5827:926c:3479:c4e7])
        by smtp.gmail.com with ESMTPSA id n14sm10474869wrt.8.2020.11.08.08.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 08:23:30 -0800 (PST)
Message-ID: <c332c4a65509274710a782edf25d9f47af4aa7d9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/5] optparse => argparse
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org
Date: Sun, 08 Nov 2020 16:23:27 +0000
In-Reply-To: <20201107022106.84056-1-chris.laplante@agilent.com>
References: <20201107022106.84056-1-chris.laplante@agilent.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-11-06 at 21:21 -0500, Chris Laplante via
lists.openembedded.org wrote:
> v1: initial
> v2: fix intermixed argument parsing

Thanks for the new version. I did run this through testing but it looks
like there are still some issues to resole:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1567

Cheers,

Richard

