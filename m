Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web12.1177.1631898020605126075
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Sep 2021 10:00:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZKpce2gO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id s24so7850967wmh.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Sep 2021 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dvIBXJuTtfSDiQ9gT15fedc1qwITpucOhoI8AYV1K0g=;
        b=ZKpce2gOvsXD6b25aBhVveS/RWOnuCt00em5T8cUyzgOLxPanopHLCZKv7Z3sgyKPV
         KA+h7S62bbRcEUzyJGqPZ1LkF8b9DwQsplkHa9/Ve+2U4mDu84O7Au1Y4DTCGamikrqd
         uAhWazCvoIasz+WxbTTS5eRnDM4d3iVx4IUpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dvIBXJuTtfSDiQ9gT15fedc1qwITpucOhoI8AYV1K0g=;
        b=m39tQaqeVh72WwMxZpDS8j4/1V1xQDYhilB4Hb/SYdINAbeJKvEPrBv2zWpWVlXoB+
         Yax5eX33ipBfeDuo8ItaCePpKUbujY3pH/U6VIXPwEs8MxwavgweaTh432GuR/foUUyk
         MPzaXUi/40SJkzhdKykBZfizkpQ4Qy/RJ+BqXDJp9VTu5nuA9K24K6ArlBkVOasjpyeS
         tqV2XsIlqZq+Jbzw+N+4botH6KQ9hQYzhcufDNYss8Kr8IVeZCBeYhOezQtUZvb9yz1+
         0J9tZXXAh4YQVi0BkgSSLgAFmw3ft2tAGDHrrBiHOiMvptRINNWt8//aimAuSeWLBvdP
         MzBA==
X-Gm-Message-State: AOAM53264KKrpDrkqX9O/57942LOiI/qSqpxWRFJPVMN/4CoxufcR91p
	2iNNJz4gCz0OCpMh11UVbFZIoT1ermelsVaI
X-Google-Smtp-Source: ABdhPJxJ7g/9Mt6ZiQjAOi13s8mefEQqKtUUdlghx2heqhgYT4Jj51jSWXTB6a8Dlz+QKBWzmQ/X3g==
X-Received: by 2002:a1c:80cd:: with SMTP id b196mr16224371wmd.36.1631898018937;
        Fri, 17 Sep 2021 10:00:18 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:8eaa:e937:fa97:b2fc? ([2001:8b0:aba:5f3c:8eaa:e937:fa97:b2fc])
        by smtp.gmail.com with ESMTPSA id g1sm7302413wrr.2.2021.09.17.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 10:00:18 -0700 (PDT)
Message-ID: <4a85154f3adbef12e3db4e2407e0944ba18d8108.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Avoid races over mirror tarball creation
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Sep 2021 18:00:15 +0100
In-Reply-To: <CABcZANnHTKDbdBW1BauJrUURe39yovtaooJ7k_4_CCgqq_zxAA@mail.gmail.com>
References: <20210916142549.1464585-1-richard.purdie@linuxfoundation.org>
	 <CABcZANnHTKDbdBW1BauJrUURe39yovtaooJ7k_4_CCgqq_zxAA@mail.gmail.com>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-09-17 at 09:50 -0700, Christopher Larson wrote:
> This looks good, though if we're creating the temporary file in the same
> directory as the resulting file, which seems to be the case, could we not just
> os.rename() rather than calling a subprocess?

I meant to check that, I had some recollection the rename might not work if the
file already exists in the os.rename() case. I got distracted by other things
and didn't get back to it but it looks like that should be fine glancing at the
manual.

Cheers,

Richard

