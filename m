Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web12.10245.1631285385052970029
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 07:49:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ws532pmb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so1196040wmh.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=M+3Xy+t+wviMPRKYpJNNE7LG5Mcf46RdpxvNtV1VYXo=;
        b=Ws532pmbrNcsMiXOO8jcctJVlfk9SzYCJsSykazR+yvnIBo+T995iOvo3QEFHYzOls
         g6mIaD0//CBZQTkdJxHROTUuY+ih1pQ4JB8vecw5Xpv4Q55592Niy1JlbgfArZAJHE/S
         44qOSykOjm+i0l239TTVWt7tDYqvbfk2nUtDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=M+3Xy+t+wviMPRKYpJNNE7LG5Mcf46RdpxvNtV1VYXo=;
        b=zFAz84+0QwAoluw4Ry5cygVCr6oeYnaPrtWg3J0C0gE78ANUwbCbpmGm3z25dtvVn7
         BsZfRjtDVKDLRbsyLohaaV8Fk0i9BsrlwWHUqS3h+cpnBIEhL3eFB1ckL4lEnoCk/c8J
         Tqr4aEoRBFQow1vqQt0FCOGcV339vznsJwId+l9sRRn5BOl0dWfr7BzoHZC4xJe3M3zO
         zXnKAEp2XPDOp1JHV+5YgAz3RcOB3aYTf2lngshA3Rf4McRvf6bBpAVqU8bEDy7Kw0g1
         mlcsdRUUZXQt9lALCbTmHQ2vkkACuM59/fN49KlLLUGfbDw1FzLKn9wg2lvWLaATFHkf
         OzQg==
X-Gm-Message-State: AOAM533CEJVAH3qYui+weOJ5maSQM6NIQ+aPjNqgmbI8RSScMgj9Oboe
	BSsWrVxXSPCdQvu4E6kQ1aT1ZQ==
X-Google-Smtp-Source: ABdhPJxJWkZXcTim5UcNRmHKe/n9m+ADJjmtvyoqcj4e6E1DN5h5OWaiNWot/ql5uWd4D0Pd9z+S5A==
X-Received: by 2002:a7b:cb02:: with SMTP id u2mr8888892wmj.103.1631285383568;
        Fri, 10 Sep 2021 07:49:43 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45? ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id k17sm4121691wmj.0.2021.09.10.07.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:49:43 -0700 (PDT)
Message-ID: <d691cc221010d5f5d26df7ffe646228a095b3f02.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/3] fetch2: Add recursion guard
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Sep 2021 15:49:42 +0100
In-Reply-To: <20210910144809.dngz75n4k4kpis4l@fedora>
References: <20210910140740.1256597-1-richard.purdie@linuxfoundation.org>
	 <20210910140740.1256597-3-richard.purdie@linuxfoundation.org>
	 <20210910144809.dngz75n4k4kpis4l@fedora>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-09-10 at 16:48 +0200, Quentin Schulz wrote:
> Hi Richard,
> 
> On Fri, Sep 10, 2021 at 03:07:40PM +0100, Richard Purdie wrote:
> > Users sometimes put ${S} references in ${SRC_URI} without realising this can be
> > problematic. Improve the error messages if they accidentally do.
> > 
> 
> I think we could also add this check to
> insane.bbclass:package_qa_check_src_uri ?

It is a nice idea but would be problematic as it causes a parsing failure
unfortunately.

Cheers,

Richard

