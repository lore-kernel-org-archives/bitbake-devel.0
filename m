Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.20833.1593442844562519526
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2020 08:00:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JP7XkWho;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f68.google.com with SMTP id r12so16817100wrj.13
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2020 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=5rQ++7xe8X4EPG4uZvht5chdjA+SHYfTX+ESlqjeZ60=;
        b=JP7XkWhoSQ8gyUjSSOnV7UFP7ETaPfA0kRV54L0HTpF14g/ieGpjtcDiyxvA9wXpO7
         k+VFYmK8lTaRcTzldYW1b/WcPE64AOUJXcktfQGQVG/ZKRW1PBml6+oZTIZNpJ8S+fyB
         vTYSuzM0LO5etMpNbWJhMG3jZXbMPb2JCZHtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5rQ++7xe8X4EPG4uZvht5chdjA+SHYfTX+ESlqjeZ60=;
        b=lWnHN7N7fSlgu30Hz0aD4+OUXL1/RPAue9g8kDbDVUAOzGl+8MhL+VtnxmfND2c2V/
         L0K956ZHRYSnv0HrYfDlcvA1PZu7UVv8tpFRGXLMWAs752OF/DKt9Tl4JRt5NO0ly5Rf
         x5Cu6qt1qk/gecXuYrJCWbIUTGi9XuNXpDCPWui2l1fAyFXOX+toinvgeB0MLRYs0vNJ
         r5pVpiB7ydM1MKIR/PDHfg1a0R4OysKgi4ex0m5O3kRkYjzHfcMnrvSEuEcZj/8ETvDC
         iWRuWsHX5dhChT8Xg9EOUORG777ukKd+MfqG63KUo7dtVyTaBEAQuqdzI9JVi9yhv9W1
         ayEw==
X-Gm-Message-State: AOAM531OgX8OGYye+gSmOajpZu5D+9YH2TBzcTz48GWIV2xewr7SR4+1
	ZV0NacAqH6O8HDBis2JBtuE+Fw==
X-Google-Smtp-Source: ABdhPJw84Hb8QJf5KtYkHnYNf1VPPCFPUfXShgyC0K3BKXqJtp6YwCk2qUO1m4/NMf7D5wvs0bLg9g==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr16598114wrc.377.1593442842996;
        Mon, 29 Jun 2020 08:00:42 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id u74sm41465wmu.31.2020.06.29.08.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 08:00:42 -0700 (PDT)
Message-ID: <5df9ead4c1f5068f141c57eeaed8a60aa05779f4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] tests/fetch: Switch from git.infradead.org to a YP mirror
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Mittal, Anuj" <anuj.mittal@intel.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 29 Jun 2020 16:00:40 +0100
In-Reply-To: <9fb2637ecedb143f09453529f4716ea8c64ccf19.camel@intel.com>
References: <20200622193832.571813-1-richard.purdie@linuxfoundation.org>
	 <9fb2637ecedb143f09453529f4716ea8c64ccf19.camel@intel.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-06-29 at 12:54 +0000, Mittal, Anuj wrote:
> Hi Richard
> 
> On Mon, 2020-06-22 at 20:38 +0100, Richard Purdie wrote:
> > Upstream is unavailable, breaking tests. Switch to a YP mirror
> > since
> > if we can't reach that there are bigger problems. This should
> > remove
> > a source of intermittent failures on the autobuilder.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
> Could you please merge this in 1.44/zeus as well?

Done.

Cheers,

Richard

