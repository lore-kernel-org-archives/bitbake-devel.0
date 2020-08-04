Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.2169.1596578926214845856
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Aug 2020 15:08:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Lir291Oi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id f12so2945147wru.13
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Aug 2020 15:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=95vMc6+Hn8bKNmJJ4K5XjoYrLo5Q0/NqMtYqk7v5UtY=;
        b=Lir291OiROzqdt8O/Lis9RnzLwCbw0+e/pUrp4O1Mgacq9RSeoWAliEVr81actp4uQ
         EiF+xEUzpy18gvjh3tjmSgcWSFjRqOW51jDvDcinEE7acCX1+vbyYmtwtGTZuL5DF5/C
         6LqIeZ3nKRm9/V6ZltXAOIm1/wuqcXHTa3Sb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=95vMc6+Hn8bKNmJJ4K5XjoYrLo5Q0/NqMtYqk7v5UtY=;
        b=TsaYw5x5i38whklN6QzbcyjHtN1bE1X+MVRVHQntr+NpQR9swnJUH2a4Pit2GWOeZx
         DzmFvFHBjpyXyMsVoG8xK2eCOfv5zdFCRS9lH0MF8FHT1goD1tOFg3kfYk3mfTcDFSED
         8oSE/Viv+6pRUdkAsd3ImQPn8nugYjAv+UUGMxpXWGa3tn7ZpJXrgAgaXrXxykAQE1CL
         Pi9eBnWIRA9reEDJWMH4eeIhvNTJRLxMrsR63veCEypHy6TRdbsiMe4t/jPLpKJP9hDR
         sFiapSRVZhq/bkJmVqLZF0AE6lzR+/rvyiC3AvBfAtAPAT5VzQtPvkIahsvT8XOkgPcr
         7ISQ==
X-Gm-Message-State: AOAM5333ByQQlxvbLFxxu30wJqoltr/xKU9wxAOoUJ8UA6Eq1Z4/b36c
	rUqDPTUDEpWIsKH6ssGgFrvX0Q==
X-Google-Smtp-Source: ABdhPJxPbKp7JNFS+/kSW1Hf0oCCI+msT4jLaxOnbBhXVpYjigs+YlEMtSub9WCz7792dU7U9ezTlA==
X-Received: by 2002:adf:d84f:: with SMTP id k15mr49834wrl.176.1596578924723;
        Tue, 04 Aug 2020 15:08:44 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 1.8.8.2.4.4.9.8.7.6.b.0.9.5.0.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (1.8.8.2.4.4.9.8.7.6.b.0.9.5.0.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7059:b67:8944:2881])
        by smtp.gmail.com with ESMTPSA id p22sm176807wmc.38.2020.08.04.15.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 15:08:44 -0700 (PDT)
Message-ID: <125ecdee4e72bbb5a9c0f34ae7ffd23437e7fc7f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Question about git _latest_revision
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Tue, 04 Aug 2020 23:08:41 +0100
In-Reply-To: <SN1PR12MB24806D95998A7DB230FA56DD8B4A0@SN1PR12MB2480.namprd12.prod.outlook.com>
References: 
	<SN1PR12MB24806D95998A7DB230FA56DD8B4A0@SN1PR12MB2480.namprd12.prod.outlook.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2020-08-04 at 15:38 +0000, Chris Laplante via
lists.openembedded.org wrote:
> Question regarding the _latest_revision method in bb.fetch2.git: why
> do we do an unfiltered ‘git ls-remote’ and then filter the output on
> the client side? Wouldn’t it be more efficient to just call ‘git ls-
> remote <rev>’ with the rev(s) that we actually care about?

I had vague memories about a good reason:

http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake/lib/bb/fetch2/git.py?id=83a30dfd495f0b8e90b7b5725c946c659ecbd93d

so it was a sorting problem between proper and lightweight tags.

Cheers,

Richard

