Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web11.6163.1596835542284804346
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Aug 2020 14:25:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Su4PhlEr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f65.google.com with SMTP id 184so3094960wmb.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Aug 2020 14:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=rdLxRtmd8donQdhB3u04wp5HOGFEeS5DzFT2w+34vPs=;
        b=Su4PhlErMFHH/0plazlPpPJGOUWdEhGo2dnQYTPasfk1Tvz6vVF91RWdudhC0em4jI
         NeOCL64rMVC7IDJMqA/gQ/Ysyn0XSLa/MmMPTCVFR/yeDDitS1tceKzJU/v1+g6zAnsC
         qUjVZSHTzE7A/Aar7ODcD9oeMmpcquv0ZnF/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rdLxRtmd8donQdhB3u04wp5HOGFEeS5DzFT2w+34vPs=;
        b=ahA1Mw1oq4K1j1wUvyjHUSgypuWNhaIHx0JYk7meAM3suLHyH+02MTmE+YY9/Rv7D1
         IhDIG2C/7cEQDktnZiedRv/ih2t8MrbOfvGdqPpVnj5MPJpTthg46YMEGRGoOPSBSk2Q
         /JBXc6MbWS6bHeKSADk6HoZI404JnGa9ZvvGNewp3gpllK4TpXjCTiaRyUdof2CBaYkq
         s5tf1MGzZ1ezyo3EerQt+2OPxdIPfrRt2+S5qnqL8x0pzUJNcbjI+B5ByeFjN5nec/M0
         dGXn4Lw3lrSF2rPmmZ04oEvxyFdWTdlybl4c8xcxwYpuXllnMxNur0a1wzTwVLleWzS1
         tdpA==
X-Gm-Message-State: AOAM5308T3zkvsK/P/M+I3XhwzhuxRnibLba+TtGa071Mb5lrZwwFe5i
	EhRXgH1Z8b9tYI1GgcUzMrzgFQ==
X-Google-Smtp-Source: ABdhPJxeMSNe//jeghlT+NiPU6G6ILISV3NLYWLe7Kkldl3ZFuG/rt/4SwWh4wSIofSzqL4RFV8xaw==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr13952896wmc.135.1596835540828;
        Fri, 07 Aug 2020 14:25:40 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 9.a.b.2.3.a.a.7.c.e.f.b.f.8.9.f.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (9.a.b.2.3.a.a.7.c.e.f.b.f.8.9.f.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:f98f:bfec:7aa3:2ba9])
        by smtp.gmail.com with ESMTPSA id i9sm11549700wmb.11.2020.08.07.14.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 14:25:40 -0700 (PDT)
Message-ID: <31be36c0a9c86f735e8dbc56053a011fde0c0bee.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 07 Aug 2020 22:25:39 +0100
In-Reply-To: <SN1PR12MB248071CBED17813537857DC48B490@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20200802143505.88409-1-chris.laplante@agilent.com>
	 <db9d507a16a5cc57634642dc2245df1a05eab447.camel@linuxfoundation.org>
	 <SN1PR12MB248071CBED17813537857DC48B490@SN1PR12MB2480.namprd12.prod.outlook.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-08-07 at 21:24 +0000, chris.laplante@agilent.com wrote:
> > This didn't work well in testing:
> > 
> > https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1239/ste
> > ps/10/logs/step1b
> > from
> > https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1239
> 
> How do I view the log file it talks about, /home/pokybuild/yocto-worker/a-full/build/build/tmp/log/error-report/error_report_20200807202843.txt ?

That would be the data uploaded onto errors.yoctoproject.org but the
above logs should have all the data too.

Cheers,

Richard

