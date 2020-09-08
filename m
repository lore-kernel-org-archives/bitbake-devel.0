Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.23341.1599579572390302248
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Sep 2020 08:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DaGkz3vI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f65.google.com with SMTP id z4so19634631wrr.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Sep 2020 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=TOw2PnNBy9nbrC2X3eqeDX/1Ur+Ye3bsw92Cvj+EaBQ=;
        b=DaGkz3vIohlryuK+rFyfuxuqTF6yB4OhV3BDcGGC09+X9t9tnN8l7U5l65sQe4aKX8
         kntrJiIJEyLiOIiivld/0+TP3a6taTDla1S++cMuNoSOyl6hC1ns0tOdq6CWU0xBnZBc
         loondRXii427dve4AHtJNmFZkoZkTM0oeNtNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TOw2PnNBy9nbrC2X3eqeDX/1Ur+Ye3bsw92Cvj+EaBQ=;
        b=TK+MsIAV4opLyJe4zIB5nPxYeTolnB4fbd9YvByYq37xSuxNG1rMKUkl06YTwS9mEZ
         G5yfw/HT5v/AvG21AvSGKlBSYEE0h8WIX08nOaN5KsbUDG9P2Bnw9NfdedoT47pliQqr
         N6LC9DmLfv16VsPZ5ZnuLBEYHDb1zM7GLSd06mixn/4QS4Tv6mWciQ8SGGKsH3RRKiUD
         htVBVxCxfhzLjPIgzysT9hlHC5cSkvSaim/rCxmqh6ebS+oMumDdeLQOUnxexFL50hMM
         WIVW7NH1Gk3kVMft7nutE6eR5+5RkYMJJ+Xibino0hBCsZQkexYHjz7ZZplvQp8XOBDE
         h4KA==
X-Gm-Message-State: AOAM532i1XXzLMt+cgwNaoSrj7p0QFSThrF4V6M4blXF3WPTIbijIw5c
	O81MhnswSTseT7R19Tykn5H/BA==
X-Google-Smtp-Source: ABdhPJxF9SkTAHejkUULVL3hSSnfFztXLnbZb8ssDeX7mOtJua0N9f/4zn/f+WNkG0U6ig6cT/Pi/g==
X-Received: by 2002:adf:f586:: with SMTP id f6mr202143wro.299.1599579570754;
        Tue, 08 Sep 2020 08:39:30 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from e.4.4.b.0.8.f.4.f.c.f.0.9.0.5.8.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (e.4.4.b.0.8.f.4.f.c.f.0.9.0.5.8.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:8509:fcf:4f80:b44e])
        by smtp.gmail.com with ESMTPSA id q12sm34373587wrp.17.2020.09.08.08.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:39:30 -0700 (PDT)
Message-ID: <e7754a3974063f48276cc06ffec8dee508ae6331.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/3] Fix performance issues for bitbake-layers show-recipes (Saves 95% time)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 08 Sep 2020 16:39:27 +0100
In-Reply-To: <cover.1599560025.git.liezhi.yang@windriver.com>
References: <cover.1599560025.git.liezhi.yang@windriver.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-09-08 at 03:21 -0700, Robert Yang wrote:
> * V2
>   - Save prioritized BBFILES to BBFILES_PRIORITIZED
> 
>   - "bitbake-layers show-recipes" requires 14 min to run which was
> too slow,
>     these 3 patches can make it run in 40s which can save 95% time.
> 
>   - It becomes slow since the following commit:
>     (85e03a64: tinfoil: Simplify remote datastore connections)
> 
> * V1
>   - Initial version
> 
> // Robert
> 

Breaks oe-selftest:

https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/1341
https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/1341
and so on.

Cheers,

Richard

