Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.25815.1584867052749772513
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Mar 2020 01:50:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PlqzVci9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f68.google.com with SMTP id z15so12685345wrl.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 22 Mar 2020 01:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=dde/Ol/iOru3NvAk8Ao/BqLZpbsxlP72y8j3UYaC+Zw=;
        b=PlqzVci9HbCw/hYlW0Qmkv614gDMwqEjO03uAFG9skuPOqzVpM/bTM0LgRlyJm98wh
         TPKDg/vcnCBDB8+Yd5o8zFtfKeEY12TdL94jgLsF7lXdS21/fxp1unahpeBfYLeAuJf/
         clZknG5xJeqhv434DbJN2XBm8LivXBhTsEhvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dde/Ol/iOru3NvAk8Ao/BqLZpbsxlP72y8j3UYaC+Zw=;
        b=Bcxgl9vc1cw+kRy/K+jWvIvxjc8nSfDIGIjuYn86b8nyAYLY3YoiRBTjcZ1NvqmXu6
         nHVuULlIDsHpucLrgsM7jTbMCvINmZB7AARC8vA2TbvxHDxvhV8WCEwjTmPLUQKDeK24
         DJlyteaPHhGkfNISfFrsPs54eztdQyvYHkuSXUImegtlHZZ8H7bcUM38FaDzqkJlbyrU
         lPHYyD5Tnlukc3fducVFMSeZIhp9jReohQbh970KNC1b0h3A0dbYfzbxv2mhQRA/W8ge
         qpXoCxd9WCasGwu5WwuXmWucGrLC61buNFyLXlt9x5+ubDJHosGvMzsHXezf3OqZenU7
         xG/Q==
X-Gm-Message-State: ANhLgQ0AKhrUvwEGoEypWttZd1cW9Qc64hZPRvy67T/jdJ2ULIPkQJAX
	g4XVPqXVUGFPrpWYYwGQKpMGeA==
X-Google-Smtp-Source: ADFU+vsTRI7skEdj6otJWq5WR0BqA0uPNeT/TsZLF/a2PI3BiGplZz6IPEy5gzgKhYzoCjDp5xDhNA==
X-Received: by 2002:a05:6000:12c6:: with SMTP id l6mr1389258wrx.152.1584867051286;
        Sun, 22 Mar 2020 01:50:51 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id b15sm17500057wru.70.2020.03.22.01.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 01:50:50 -0700 (PDT)
Message-ID: <0ce06fedd8acec9c7f9a1bd028a1e82b321111bf.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, Khem Raj
	 <raj.khem@gmail.com>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Sun, 22 Mar 2020 08:50:49 +0000
In-Reply-To: <1cdd50184c1f4af488baee9ee691b495@XBOX03.axis.com>
References: <20200215032955.3958-3-pkj@axis.com>
	 <5532.1584827063458682607@lists.openembedded.org>
	 <1cdd50184c1f4af488baee9ee691b495@XBOX03.axis.com>
User-Agent: Evolution 3.35.91-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sat, 2020-03-21 at 23:50 +0000, Peter Kjellerstedt wrote:
> Rather than blindly reverting, can’t we update the documentation
> instead? If you use ${AUTOREV} you obviously do it because you always
> want the latest revision. 
>  
> Before this change, using ${AUTOREV} in combination with
> BB_SRCREV_POLICY = “cache” didn’t work, which also wasn’t documented.

I can confirm that the design of "cache" with AUTOREV was only to
update the first time.

This differentiates it from the other option or clear where you'd get
the behaviour you'd describe.

Cheers,

Richard

