Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web12.1433.1631569904635111415
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Sep 2021 14:51:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=H9cPHjfS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id g16so16889739wrb.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 13 Sep 2021 14:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=uj8He/4SmPbKYiANBgJBpw0eDikTHmL5InwjS8/F8oA=;
        b=H9cPHjfSeq6xqiZYe+e2QtySCVoxCl3ZG3FNyKK7cAdratvncixXIMj56fxyq0le/I
         5EnBXILvU7fPre7cAFyGeuSYNwXjPlDuG3WylcvZ5vfoxkweq5iPt0DFp1EXBLXi0wcW
         gYZ3ANf6Sevm88ivFpMVnxYBA5sCj1mDthkdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uj8He/4SmPbKYiANBgJBpw0eDikTHmL5InwjS8/F8oA=;
        b=zTbbmeQuXz/AV58GE74S4grgna75tSIJo5/9rq2SDy/I6ba3LdTgB52MFcVg3c4wBh
         Vv4gdCkJLGO+ERKHJbHXxGJ4DCJGfCGRU8CAkWmwbsEkBri0da1ktxch4ncN0DTzL2lt
         AgA/Xc6b2AVwOzIwHnxxfP5J8JVR684rfemvbeMCmm7Tacgm4pfhPJfeEd9oDupF3fxf
         XcO5QnDTJmJmlmYxWiJVbxOxG6cbcZm6FU7lx8Pk5gQPNzPxAgplYMOKkxmmODei1jgN
         EX5TE+Ca4a/ZIh83zC1KKGVuxdhNGRNNYHOq7DAGNN9RZ8P89PEZ/8TN9UkLToQtcTMV
         Fy1w==
X-Gm-Message-State: AOAM530FguLyRmbgE2StC1V4j1qprV6hdix8Fg+T61viwfbfI4R7F1Wn
	hsM/W3iir2XKisoK5FRQe9OtCw==
X-Google-Smtp-Source: ABdhPJyeLsykl4jH6vujGDaN5vdIU2dNWfEcUbuJ5009Jp7bqBWZXKi/dd2KvCtFB2ckOFso3q1KnQ==
X-Received: by 2002:adf:9f4a:: with SMTP id f10mr15018274wrg.384.1631569902909;
        Mon, 13 Sep 2021 14:51:42 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:2da1:111a:66bf:1f1? ([2001:8b0:aba:5f3c:2da1:111a:66bf:1f1])
        by smtp.gmail.com with ESMTPSA id z19sm9332583wma.0.2021.09.13.14.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 14:51:42 -0700 (PDT)
Message-ID: <0c08eb02be04e948204db6200fbd3312f38ff1ab.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Git operations during parse
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: david.weidenkopf@arthrex.com, bitbake-devel@lists.openembedded.org
Date: Mon, 13 Sep 2021 22:51:41 +0100
In-Reply-To: <ZIhY.1631557405234165608.d5Ap@lists.openembedded.org>
References: <ZIhY.1631557405234165608.d5Ap@lists.openembedded.org>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2021-09-13 at 11:23 -0700, david.weidenkopf@arthrex.com wrote:
> It appears that during bitbake parse phase, git operations are performed.

It depends how you have recipes and bitbake configured. It can be configured
such that sources are pulled from upstream git repos which are checked for
updates or it can be configured such that it doesn't touch the network at all.

> Is this true? It seems that network operations are performed before the
> dependency tree is computed. As a result, a build may fail in the parse phase
> due to a failure to reach a git repo that ultimately is not needed because the
> package it is in does not end up in the dependency tree. Is that correct?

Depending on the configuration that could happen, but it can be configured such
that it doesn't/can't.

We do recommend recipes don't default to touching the network.

Cheers,

Richard

