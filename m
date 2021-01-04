Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.16978.1609781998643458812
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Jan 2021 09:39:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G1XDOm96;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id t16so33026349wra.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 04 Jan 2021 09:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sQjzyOYN/2ZR4iUbr7+DNgwkk/8P5VMYh5Fr1W/ZUz4=;
        b=G1XDOm96q27ndSQTCw7xrTW671uf9KKkSV6rUXHgdzi/tvCnUcYjcJK2nfwqvpzDT5
         zWIGYDKn9NVg8qnCSlykCwz2HwXgHUYxCdRaUfOsLdKGg0j/rxh/pAIvL/FKdePcAdVq
         gobLSX3R2FUdMKFae8qc5YSnfCtSJgqV9aIyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=sQjzyOYN/2ZR4iUbr7+DNgwkk/8P5VMYh5Fr1W/ZUz4=;
        b=PTyDcqAxIoial41W5v4OzSMj5nIssean7/G2A5eBVlZ9FE7qqhi5hScsUaiL0Wn+jZ
         PBra79ouq2gIldQuUYBiM3bIuETJ5pOyxLp4vvNAqqFdTZLlHtnziRJ32tWjfJxXyAge
         F/GO8qzNahh8sMZh+waslUJ90G/XbNo57/UY4UH6ouMRIsLUzWHcSZHpuZGZxWVmudeG
         QSLTwZJN9sElK7ntUaouXB30yFendmSA4KscZYXc4x1h81XP7Vt8ej3bcaYqJ2H5SGOU
         uA+f3bBPKF2aqWRnh0eCMXw2mcGdVOvm79fhmE4b2qpozip5iTXo5Nl17tVLmQ86yyIp
         mxXw==
X-Gm-Message-State: AOAM532/MYXDy2JJ7sovtdNW4us1H2g1Fs/90b2/4y01VfypJIto9V/e
	pOVt110Hp09wEV/UQ1MwUQKFjQ==
X-Google-Smtp-Source: ABdhPJzKrfALYQrFGWDQR/Kw1+JD6Hyc7Or6jKVYdE/CoUWZi8Fmcni9JZd+rWTyaQMHDGETDnx65w==
X-Received: by 2002:adf:eac7:: with SMTP id o7mr81718401wrn.23.1609781997135;
        Mon, 04 Jan 2021 09:39:57 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:4767:d28d:f91a:aa32? ([2001:8b0:aba:5f3c:4767:d28d:f91a:aa32])
        by smtp.gmail.com with ESMTPSA id a17sm95423975wrs.20.2021.01.04.09.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 09:39:56 -0800 (PST)
Message-ID: <6ceb5594aa870d2cc1fab252c17852bfca4bb71e.camel@linuxfoundation.org>
Subject: Re: [PATCH] bitbake: fetch/git: Fix usehead for non-default names
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Joey Degges <jdegges@gmail.com>, markus.lehtonen@linux.intel.com, 
	jonathan.yong@intel.com, srifenbark@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Date: Mon, 04 Jan 2021 17:39:53 +0000
In-Reply-To: <CAFYOfTE=OgvMCqTeOkoz-rHMPY5yaw0hQjEEKPSqqAjG=6M4vA@mail.gmail.com>
References: <20201214094308.15483-1-jdegges@gmail.com>
	 <CAFYOfTE=OgvMCqTeOkoz-rHMPY5yaw0hQjEEKPSqqAjG=6M4vA@mail.gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2021-01-04 at 09:12 -0800, Joey Degges wrote:
> I noticed that you've each had a hand in the usehead feature since it
> was introduced. Any thoughts on this patch? Is this the right forum
> to submit such a change?
> 
> This patch is intended to allow the usehead feature to work for URLs
> with non-default names.

The patch looks reasonable to me, I did ask on the mailing list in
reply to it whether you could extend our tests to ensure if didn't
regress again?

Cheers,

Richard

