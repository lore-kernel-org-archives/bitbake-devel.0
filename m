Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web12.2796.1587026832182248549
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Apr 2020 01:47:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LBGfjYgm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f65.google.com with SMTP id z6so3914874wml.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Apr 2020 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=3+hoZEtCzftgX3cAwasLQSDgaifV53lQD88WLlj6suw=;
        b=LBGfjYgm2hRmgvlCgGxIcjz1YUQTwfPcPfU9U9Enrenb0V+TMps2YOwz87iIWL0KmF
         n7jUfTJaTuyEmkHdkztARyECOh4bfLM7PMYI68vQi/bBZyDoBhmHczGbzMyqRe1v4vF9
         H9Wa3RPZ0xwQ10nrbWSvq39jvf01oLKakkSJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3+hoZEtCzftgX3cAwasLQSDgaifV53lQD88WLlj6suw=;
        b=XrGGSu6C5oMr0NMOtk7kqEAZA08z8KMm45UskbYM1oY6lAnP1nNLqD/SLzJt48cBu5
         iWhv9XIIl/t68wsfMiXiA7V9sC8qHwAOK5B+DDbwNPK5kBhVptPugJxWVJ3ZLNmgx2ga
         /+Vn03l3mHhpf0Vd4sXqD2HDElq7By6Yjeexdx+41yjXMOvgdmxc5wr3mhQejCI4R2z2
         QtpAJk3B1enBAnBRcA/on0C4Ldtz6g8YqB3loFwn0m7a66vyvmHB1/oEfAmGs81L0vn8
         FP2rssrgGgs/OZSTLTwemniVw+pQw7jtAMrbLuvHWaP9ciyhu/tuWC3Zu+04bHGrWl5j
         HdBA==
X-Gm-Message-State: AGi0PubmBVAOIV0HVxPAyO2BapFMFMzwPuWyXpoPZE88AIQMUtpFOfgj
	ketc7p50IuzSjU5/M5axX2i9fQ==
X-Google-Smtp-Source: APiQypJ0CRx2FnXOUp4glEvz0PYZilYDq8u5v39pwTW8YNsQAZ1kczJAjhM4+UHBCmoj3moZqUI4dQ==
X-Received: by 2002:a7b:c002:: with SMTP id c2mr3622649wmb.123.1587026830587;
        Thu, 16 Apr 2020 01:47:10 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id s9sm15185105wrg.27.2020.04.16.01.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 01:47:10 -0700 (PDT)
Message-ID: <74e3f669d62abd35545e3552614bb303c13257af.camel@linuxfoundation.org>
Subject: Re: [PATCH] tinfoil: fix config_data mess up insane check while parsing multiple recipes
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Hongxu Jia <hongxu.jia@windriver.com>, 
	bitbake-devel@lists.openembedded.org, paul.eggleton@linux.intel.com
Date: Thu, 16 Apr 2020 09:47:08 +0100
In-Reply-To: <20200416074427.1716-1-hongxu.jia@windriver.com>
References: <20200416074427.1716-1-hongxu.jia@windriver.com>
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2020-04-16 at 15:44 +0800, Hongxu Jia wrote:
> Since commit [tinfoil: Simplify remote datastore connections][1] and
> [tinfoil: Add back ability to parse on top of a datastore][2]
> applied,
> bitbake run command parseRecipeFile with param config_data.dsindex
> rather
> than config_data.
> 
> While calling tinfoil.parse_recipe_file() with one config_data (with
> the same
> config_data.dsindex) to parse multiple recipes, it will mess up
> insane check.

Well spotted, thanks!

Cheers,

Richard

