Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.7089.1618309383593596890
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Apr 2021 03:23:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NOR/s/GO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 12so8417930wmf.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Apr 2021 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RjN7VVPaqy4x4KEK2e0e9K6LhJzRFQPxtGscc13LhSo=;
        b=NOR/s/GOyRgvtozJeCpUBW+NKwnSwsJ0bUyTvDMvMUYy0EAJ1N0TkYgSlshlzGm4Mz
         5Ax/tYP8D2esGR4M/XJmcIU2q+LBd943I9TEYUedgfvem4EfidIcyP1ii5vFbwwu9+iu
         DmMIqfjJajaXRTJhH3eE9EqYLn6MHpn6kj7Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RjN7VVPaqy4x4KEK2e0e9K6LhJzRFQPxtGscc13LhSo=;
        b=QsFZyTTZBuRS+1jnG/Mvn0GQk1P/u7yQy4xYj+0oi8qSzxowXAYkzskStrmBmFZk7x
         rDa7d3rY+3HFZRsZMZh8B/AsPwau8KIhETYkMXgJJQ+A1eBlo5++PaWoif/gT3p3K0yf
         b99JnDjEfEtgEXmXU7tZdjQ1YtpT27YcGmWKdeuGiY9TX9UCm/t6842jgRV7dwZXcVRj
         nv7vxToNCNsAOhZ6/0Xmdq82h3Sq9X0sq2N4Bn6MFO6zdYfZuK27+Na+PS5DS5I9MMNi
         PQhDXosZ2ak8pl2l9L07HZeO5OE075m+Wk89tjoWR3O3AnkoV11nlr4P73q2kr4ymxYC
         Ef1w==
X-Gm-Message-State: AOAM530btNw3mkcYA6KZ+NaL3fnU5GN0W2/5y9GHdEx7896UUa4jIQ/V
	KdIbe00j7wJjZ6ATx3rpBenSWQ==
X-Google-Smtp-Source: ABdhPJxpTu5ieJvPUNb2xZ6qzJY8dE8f8+FJ178dUtq1uzr9YfWSU6z6wUIER9pwRKhWXiCApFgcJA==
X-Received: by 2002:a05:600c:4142:: with SMTP id h2mr3433746wmm.87.1618309382116;
        Tue, 13 Apr 2021 03:23:02 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:cfa:4562:e70e:c00b? ([2001:8b0:aba:5f3c:cfa:4562:e70e:c00b])
        by smtp.gmail.com with ESMTPSA id o14sm18176467wrc.3.2021.04.13.03.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 03:23:01 -0700 (PDT)
Message-ID: <65bf5f7ea9041131d5106cd45cf19e709f468d2d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: add support for disabling shared clones on unpack
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Henning Schild <henning.schild@siemens.com>, 
	bitbake-devel@lists.openembedded.org
Cc: isar-users@googlegroups.com
Date: Tue, 13 Apr 2021 11:23:00 +0100
In-Reply-To: <20210412170519.53612c01@md1za8fc.ad001.siemens.net>
References: <20171220164209.9609-1-henning.schild@siemens.com>
	 <20171220174538.441d517f@mmd1pvb1c.ad001.siemens.net>
	 <20180130131805.4725ccf3@mmd1pvb1c.ad001.siemens.net>
	 <20210412170519.53612c01@md1za8fc.ad001.siemens.net>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

On Mon, 2021-04-12 at 17:05 +0200, Henning Schild wrote:
> this is still pretty much relevant to Isar, where an unpack with git
> goes into a chroot. Having a way not clone "shared" would really help
> us in Isar.
> 
> Any comments? Except for this one maybe not applying anymore, did not
> try.

I'm torn on this, I can see the use case but it isn't one we've typically
run into. I can see how it is Isar specific.

I'm hesitant as the more "forks" in codepath we add to the fetcher, the 
harder it becomes to test and maintain.

Would you be able to add some tests for this to the testsuite 
(bitbake-selftest)? If we have some tests we could probably add something.

I did also wonder whether this should be a per url parmeter or a global 
fetcher behaviour option? You'd end up adding this to all urls in your 
usecase?


Cheers,

Richard


