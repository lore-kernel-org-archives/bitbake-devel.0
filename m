Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.30019.1604316610301251631
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Nov 2020 03:30:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=a27CAx0A;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f67.google.com with SMTP id i16so8745511wrv.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Nov 2020 03:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eYgEwYSrDgGkowbNLpzkTFtqDO2ifTPBprc7R/ZK3Uo=;
        b=a27CAx0AUuHaH9gKWFmDv3sQZ/WsH8NqGQHxBKglMorB4xk+5xhSTQ1GV9Ie+cM4PN
         0cBGW2Ih2ro8HqiSwmfMgrS9rMz/sG2JTLDrT6YlXyjpbJToenyopf4CjROb0xb7XT06
         FVUa9rydCN0Q8UwYR1m+8WMbms1pehoEacE2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eYgEwYSrDgGkowbNLpzkTFtqDO2ifTPBprc7R/ZK3Uo=;
        b=bYZghXejcsfMYmiL2ZgWk4zeUCpQPP5ie9zakZkimI+z9Y92lgpFliU5Rg3JCdBwsf
         cdJGJRmUvrrmUr6JAkbSB3zhW2VIUJann3Nsgx5PA6pRtnzU8IEKtALXEDBLvxTFNu2f
         JCOY7r4R7txjLXn8cCs1Ke9guuMRtx5ygWL5SyE5bhZvktukyHUnG99m+t9YqUvmdUDA
         xeWam2BrZp7iZgbyf5AkW//Ox7kALIFveMF982/51GD5A3weDp/HBMkf37HNGWNAcw7g
         XMUAYcg9338BmTqorNtIpjII4xBuxx5x5LL66+LkFfPmxQ9sWlzLbkyLAEnB/EDEtwjO
         J+CQ==
X-Gm-Message-State: AOAM531QWEmFQ0zQY3f2JG7IOXv12ZfNy0zi+1KM1oWBw5/sV8vRXC0z
	LVDkTBfKClfIdmYB/XYvd84IyA==
X-Google-Smtp-Source: ABdhPJxRbQD4SweD0H/hIhyqd4pSNCnNOUG8EkACRzf1KOHWKvkdO5AhlCr4AQd7dZ4pkh5omVsdQg==
X-Received: by 2002:adf:804b:: with SMTP id 69mr19554352wrk.274.1604316608764;
        Mon, 02 Nov 2020 03:30:08 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.3.f.c.c.4.3.5.e.4.0.8.b.a.1.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.3.f.c.c.4.3.5.e.4.0.8.b.a.1.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:11ab:804e:534c:cf3d])
        by smtp.gmail.com with ESMTPSA id n4sm6218028wrv.13.2020.11.02.03.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:30:08 -0800 (PST)
Message-ID: <9698ab1cae3f17fb867bbeff9821b2ea8e1e91cd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] Append the password to the username on git URI reassembling.
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Paul Barker <pbarker@konsulko.com>, Dominik Schmidt <ds@technokrat.ch>
Cc: bitbake-devel@lists.openembedded.org
Date: Mon, 02 Nov 2020 11:30:05 +0000
In-Reply-To: <CAM9ZRVsFPUgvW79gujg=sRfS_wMpq_vwJ7SW3TXb3u6sns6fvw@mail.gmail.com>
References: <20201102102452.777-1-ds@technokrat.ch>
	 <CAM9ZRVsFPUgvW79gujg=sRfS_wMpq_vwJ7SW3TXb3u6sns6fvw@mail.gmail.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-11-02 at 10:52 +0000, Paul Barker wrote:
> On Mon, 2 Nov 2020 at 10:25, Dominik Schmidt <ds@technokrat.ch>
> wrote:
> > This allows the users to specify SRC_URIs of the form
> > 
> >         git://user:password@host.tld/path/to/repo.git
> > 
> > which allows pulling in private repositories.
> 
> This has been discussed and rejected before multiple times, see for
> example https://lists.openembedded.org/g/bitbake-devel/topic/72129859
> .

I think we should put a comment in the code about this as we keep
getting patches...

Cheers,

Richard

