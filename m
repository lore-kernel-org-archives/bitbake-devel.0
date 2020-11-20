Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web09.23751.1605871031952040692
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Nov 2020 03:17:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=httD0M+E;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f65.google.com with SMTP id w24so9478989wmi.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Nov 2020 03:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FYliHLlLyRpP6JsrQcpxf7XQWJUViOUo2HudTYDVung=;
        b=httD0M+EztOSMXD86o2Z7ZG1cMo49fnhYImu3ry4Atf/J+4lrBNW7p74QO0hFvx85t
         jE48kEmL9uKCbzUKWd8DoD9CNI4oO1miUMF1GyI7gCAk9Uadbznbr7hyiEvrQxAhgURp
         Qsn+RtwvvMfWHF6PGXum+YwgMIM2+Grc1QOu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FYliHLlLyRpP6JsrQcpxf7XQWJUViOUo2HudTYDVung=;
        b=F1K7s7isoA+8oafEVVa+NSbDEeBCbEoJ/d5YxSfdwnCn4BflH2BHzRzrgK1B671HIn
         TisFR2fQXnokPBiC52zk7antqjNhiEztPBbFwW17RT2O41Wzif1yjJhX6qj3iILfWdeC
         fQmyOMIp2JF/rQBhsr4FsCW19C/X3uP1C20MYlV0eWKmrCL/0vbv5q6pBcyk349LynWV
         SCVd2y1XxeYkNJW+U/MBpses2WNCbxPwWFOL2HxBcrxuw6SQHxX+1X1FEnUO0c5y54F4
         a9/j4nfxmT12Izvq6dOWpgm/7fhsAa3mOM/ZKN5foIhXKc0r0yrGbHQlosZu7GfNksQH
         zMag==
X-Gm-Message-State: AOAM531Dh1TyK6/FhmoRzGzoFd2kUWr17zUgBXQnwMm12oS/CuRBz90F
	yjO7BYqNJk+TQHPccVsyrQLzfQ==
X-Google-Smtp-Source: ABdhPJxl5iFGOd+j81TlkZI5qUkYg7W/SQQAqAnCeZZzA3ZyTXsApXCNqS8lL4rkNzGjkY8LYSzFvA==
X-Received: by 2002:a1c:ed06:: with SMTP id l6mr9039106wmh.67.1605871030384;
        Fri, 20 Nov 2020 03:17:10 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from c.8.b.3.0.6.d.4.9.0.2.b.0.0.0.6.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (c.8.b.3.0.6.d.4.9.0.2.b.0.0.0.6.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:6000:b209:4d60:3b8c])
        by smtp.gmail.com with ESMTPSA id d63sm4085113wmd.12.2020.11.20.03.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 03:17:09 -0800 (PST)
Message-ID: <a9263142edda2b526d1b446df0fa6ec0a652f88f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
Cc: "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 20 Nov 2020 11:17:09 +0000
In-Reply-To: <SN1PR12MB2480E2F3894878B5CC62BE258BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
	 <79ada9503eb003e81ec3f90836837cccc787f836.camel@linuxfoundation.org>
	 <SN1PR12MB248066D339FDC42D95EB16218BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
	 <710819fcc1b29838ea7d2f2b332fdd44495219c7.camel@linuxfoundation.org>
	 <SN1PR12MB24809AE9781F70F9F4ADBCCD8BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
	 <989c6ad2362e7763866a566efa6715d66ebc2d0c.camel@linuxfoundation.org>
	 <SN1PR12MB2480E2F3894878B5CC62BE258BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-11-18 at 21:01 +0000, chris.laplante@agilent.com wrote:
> I hacked up a small Python script as my .git/hooks/sendemail-
> validate 
> to ensure the From: line is the first line in the message body. I
> just tested it by sending a patch to OE-Core for something I found a
> couple days ago.
> 
> If it looks OK please let me know. I can share the sendemail-validate 
> if you think it could be useful to others.

Sorry, I've been a bit distracted. I did just check and this worked
fine, thanks!

I think sharing that script somewhere (maybe OE-Core's contrib
directory?) would be useful. I'd like to add some documentation about
how to handle this as I doubt you'll be the first or last person to run
into this!

Cheers,

Richard

