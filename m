Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.22852.1596976327218088067
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 09 Aug 2020 05:32:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WThLZQj9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f65.google.com with SMTP id l2so5693062wrc.7
        for <bitbake-devel@lists.openembedded.org>; Sun, 09 Aug 2020 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=jH161lOB5mELri9d7KGzSkmAyWVvfOAhfiljmEcrySw=;
        b=WThLZQj9K7WmliCVdvKcEdRhn/9uXvozmbwQj+mpOlYZyXfTDA8AVTyC6kCz4VlRTS
         oSuyxknH2939bwTXHVmkCNOuYdVaQU7saM3GdW9oH1a/75Zz/bGpurI++yESTNvuKhWO
         M6ACL3d8IVLcjvZkMoc39l8bhYEUGzpx/pN30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jH161lOB5mELri9d7KGzSkmAyWVvfOAhfiljmEcrySw=;
        b=cu+kxIkdtvZwm6LbXLn0nlBK9YYgXsGYMntN0PaNkcgLMgoiCyCvVmsM1z+BFKMJa+
         HqwbzFRcorLUIDV9F5VZYcWjzOgOP0yMDmrQz00didsSCYZsnGmxNCPNskizjtjINBWn
         PgeN4Loq5T5wAFqUGaABCAeZWc/Pebw7to2yJMvx2Et5NTBHLZKY9VGroFL/Wru+DPW4
         sD6MXjvF2qlHWyBMxWFY79MDKjTaojFKrXcDnpUxY6KgqYzk3/LViOIIBUtBAHQB0FCx
         gTnSHr2NeBA5JHlsshabjNfnxjvrDGoIVVxYNG/FgJeIkdZh+73KHRu+au+FoC3SeUnl
         Ywpw==
X-Gm-Message-State: AOAM533fEzZ5vK1gUqONj9Uhinvg9LJpPDd/PhYp3P2583c725tJylrj
	hDC9XhIaONd0TfQrcM44Iu9jjQ==
X-Google-Smtp-Source: ABdhPJzxk4QgmWiJemtt/YlSNI4OmsIof5F4R0PiA8KtU2bQ+mK96RhuexoAaDqCS675d5AonMKuuA==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr19694091wrv.387.1596976325635;
        Sun, 09 Aug 2020 05:32:05 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 9.a.b.2.3.a.a.7.c.e.f.b.f.8.9.f.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (9.a.b.2.3.a.a.7.c.e.f.b.f.8.9.f.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:f98f:bfec:7aa3:2ba9])
        by smtp.gmail.com with ESMTPSA id 65sm17198683wre.6.2020.08.09.05.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 05:32:05 -0700 (PDT)
Message-ID: <7b4fa2825325e8fcae74d6c780714cc997c104cd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Aug 2020 13:32:04 +0100
In-Reply-To: <SN1PR12MB24803805C0F12CF4F833C8838B460@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20200802143505.88409-1-chris.laplante@agilent.com>
	 <db9d507a16a5cc57634642dc2245df1a05eab447.camel@linuxfoundation.org>
	 <SN1PR12MB248071CBED17813537857DC48B490@SN1PR12MB2480.namprd12.prod.outlook.com>
	 <31be36c0a9c86f735e8dbc56053a011fde0c0bee.camel@linuxfoundation.org>
	 <MW2PR12MB2474D07083D73046771266858B460@MW2PR12MB2474.namprd12.prod.outlook.com>
	 <dcc49121d8f04e3886533ff31a61185657cbd2e1.camel@linuxfoundation.org>
	 <SN1PR12MB24803805C0F12CF4F833C8838B460@SN1PR12MB2480.namprd12.prod.outlook.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2020-08-08 at 18:40 +0000, chris.laplante@agilent.com wrote:
> > That worker has dash:
> > 
> > rpurdie@debian10-ty-1:~$ ls -la /bin/sh
> > lrwxrwxrwx 1 root root 4 Jul 10  2019 /bin/sh -> dash
> 
> OK. Even though dash isn't executing the bash part of the code, it is
> still choking on the syntax. I'll have to change the 'for' loop
> syntax to be POSIX-compliant.
> 
> Of course, dash and vanilla sh lack pretty much every piece of
> functionality I need to implement the backtracing. So once I fix the
> syntax, you still won't actually get any interesting output by using
> the autobuilder to test the patches.

Some of the autobuilder workers have bash as /bin/sh, others don't, the
cluster is deliberately non-homogeneous. So it should see some testing.
Obviously we can't break dash users though...

Cheers,

Richard

