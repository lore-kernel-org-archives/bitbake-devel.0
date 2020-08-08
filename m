Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web11.999.1596869372844970671
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Aug 2020 23:49:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RpdAuvvN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f65.google.com with SMTP id f1so3527543wro.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Aug 2020 23:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=hQId6LILkNkwzeWxGsMOQbBKklTRYWAVW9RzEcg1K/Y=;
        b=RpdAuvvN5Rl90rZ1B89t5PI2iMP9oC+S2Axcy8ZRfF/vTgnsmaZaYCyKeuD14DN1ZZ
         44YTcwfGttDoRNn92LKLc9sbfh7m2qYu2XFerYpeaGuXEqZhvYHCc5Zy6WkRyUfwe5XW
         biOHeDDj8IBJNedClizoSnXoPWHFA6chhmU9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hQId6LILkNkwzeWxGsMOQbBKklTRYWAVW9RzEcg1K/Y=;
        b=UaXRuLKO9UI5rNoIAJTezisjixANdPdkt1WtWYPFTPyDbXpFYVYHn18KKhUofp1GjL
         4AybzskTdrfw2KJuw5P42CzQEOKU+X1egc16O1cs+2kA09jBsPkUmKj/aiScXRczc/sH
         X1Ht78QSggpyEIXpvssaBvnbthL0rC29lAq+6e4omaBuTzBJ2fLhEnGznOEolowHHYRi
         2cnL/SvOBoKqXeeaz27yNfBTkjrjLSixafFT/ekDPvRA7zS++3xn8lPagpF2+cjNpGi7
         GgNUGyEwHkslQD6LCkGkntg+b69aMIOBg/afHs2YMjQN7IMMHl3p0E68dLMtS/Dqe6mA
         A0Vw==
X-Gm-Message-State: AOAM532X004mApuSF86iN7zeG6TWcsAYsSBs6T9Yf9wFpRspeeAMALmk
	D361OO1g92lSk7a2obTchlInzA==
X-Google-Smtp-Source: ABdhPJzbA8syn4AptJf9Lx3UlZA75VMWPSx53/8M0nOMpjsqvNdqkTgvVzwDgCzGLWWMg/f4Y9wwhg==
X-Received: by 2002:adf:a35e:: with SMTP id d30mr16179564wrb.53.1596869371314;
        Fri, 07 Aug 2020 23:49:31 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 9.a.b.2.3.a.a.7.c.e.f.b.f.8.9.f.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (9.a.b.2.3.a.a.7.c.e.f.b.f.8.9.f.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:f98f:bfec:7aa3:2ba9])
        by smtp.gmail.com with ESMTPSA id y145sm13461490wmd.48.2020.08.07.23.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 23:49:30 -0700 (PDT)
Message-ID: <dcc49121d8f04e3886533ff31a61185657cbd2e1.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Sat, 08 Aug 2020 07:49:27 +0100
In-Reply-To: <MW2PR12MB2474D07083D73046771266858B460@MW2PR12MB2474.namprd12.prod.outlook.com>
References: <20200802143505.88409-1-chris.laplante@agilent.com>
	 <db9d507a16a5cc57634642dc2245df1a05eab447.camel@linuxfoundation.org>
	 <SN1PR12MB248071CBED17813537857DC48B490@SN1PR12MB2480.namprd12.prod.outlook.com>
	 <31be36c0a9c86f735e8dbc56053a011fde0c0bee.camel@linuxfoundation.org>
	 <MW2PR12MB2474D07083D73046771266858B460@MW2PR12MB2474.namprd12.prod.outlook.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sat, 2020-08-08 at 00:19 +0000, chris.laplante@agilent.com wrote:
> > > > This didn't work well in testing:
> > > > 
> > > > https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/12
> > > > 39/ste
> > > > ps/10/logs/step1b
> > > > from
> > > > https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/12
> > > > 39
> > > 
> > > How do I view the log file it talks about, /home/pokybuild/yocto-
> > > worker/a-
> > full/build/build/tmp/log/error-
> > report/error_report_20200807202843.txt ?
> > 
> > That would be the data uploaded onto errors.yoctoproject.org but
> > the above
> > logs should have all the data too.
> 
> /home/pokybuild/yocto-worker/a-full/build/build/tmp/work/core2-32-
> poky-linux/distcc/3.3.3-r0/temp/run.fixup_distcc_mirror_tarball.9175: 
> 18: /home/pokybuild/yocto-worker/a-full/build/build/tmp/work/core2-
> 32-poky-linux/distcc/3.3.3-
> r0/temp/run.fixup_distcc_mirror_tarball.9175: Syntax error: Bad for
> loop variable
> 
> So I guess it's a 'sh' problem. I thought I had the code set up
> correctly to handle sh vs bash (specifically, basically all of this
> is turned off for sh since it doesn’t have the backtrace capability).
> But I guess not.
> 
> Can you confirm that the autobuilder is using sh and not bash?

That worker has dash:

rpurdie@debian10-ty-1:~$ ls -la /bin/sh
lrwxrwxrwx 1 root root 4 Jul 10  2019 /bin/sh -> dash

Cheers,

Richard

