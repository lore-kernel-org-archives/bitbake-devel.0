Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.11122.1604050784901546800
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Oct 2020 02:39:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=b5nPDDo+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 13so2247359wmf.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Oct 2020 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=h9so5WFmHHi/sZfgCd207K45921T6Z589p3dm1qbiDQ=;
        b=b5nPDDo+zuec/EI3FE/EDtGqFIIAZZz7fDx8/MnkXArSgheGEoan5ow2VHTAGXZGj1
         K/lOC6i9pSDMGyEWg/72FyDMHEnMYTdqEJXB/2VkwW59rfJmaJ7g4o40ZDrjrQCpZNwj
         jb6okKGqG9rHwdRBW58tcGEHYnKr5woQQvXDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=h9so5WFmHHi/sZfgCd207K45921T6Z589p3dm1qbiDQ=;
        b=nJifcdLfP4l6NgQyMeUH0bRFn+2MPJbjzeuhBJoS89d4np0QuAIQXxcTkmX5/AHCkJ
         0rKGIZV1cT3eTv/XA6OUp9Jvbn5JKEEq8tkfyYY+azAHv4h0k78vSjLVxiEGuhkazipz
         F6rzSyAIvposph4YHYOmqwRpNCwuYcG9gDzHxKoRhY8oXVQRBuACZsAodpxgA3do27K3
         8wA2Wr0Macv+CaH80cuLdzJ1FV1G7UBsacB/K+Bxt6/WIKcHNfa8LZtrx8pgAHCnrGtA
         HX+SsJD7iuetefrYdBt8p7jlsAD3e2JMQ5vYTKG66GNoamnpWTLZ3ygAipp7nbNuJRTy
         eOfw==
X-Gm-Message-State: AOAM533tQacLbygm1JOXcyq2Ci8Ct6JIIOwWPbkyuNb10h5PiNIlVESO
	LzjYjuEqIxOZCcXtW3XfBpqcPQ==
X-Google-Smtp-Source: ABdhPJx313XZ41OVWU4/g4ZbM6ozNF8yT1gRD88KQ2uVRNgx+zkE84IXVwcOaDN+B0M02jLFJuHEjQ==
X-Received: by 2002:a1c:383:: with SMTP id 125mr1627867wmd.175.1604050783396;
        Fri, 30 Oct 2020 02:39:43 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 4.f.b.1.1.e.8.3.0.4.2.f.2.4.4.d.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (4.f.b.1.1.e.8.3.0.4.2.f.2.4.4.d.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:d442:f240:38e1:1bf4])
        by smtp.gmail.com with ESMTPSA id b1sm4169797wmd.43.2020.10.30.02.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 02:39:42 -0700 (PDT)
Message-ID: <7bfa5ef62fadfad8fbb778f0ffa64920826e624a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] fetch: git: add reference parameter
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 30 Oct 2020 09:39:41 +0000
In-Reply-To: <f1b06485-fc60-df76-f6c5-7973727f605a@prevas.dk>
References: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
	 <1640541B397C8D4C.8847@lists.openembedded.org>
	 <f1b06485-fc60-df76-f6c5-7973727f605a@prevas.dk>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Rasmus,

On Fri, 2020-10-30 at 09:52 +0100, Rasmus Villemoes wrote:
> On 22/10/2020 15.38, Rasmus Villemoes via lists.openembedded.org
> wrote:
> > The --reference(-if-able) option to git clone can significantly
> > speed
> > up the initial do_fetch if one is able to point git at a local
> > repository containing a large number of the objects that would
> > otherwise need to be downloaded.
> > 
> > Allow the developer to define a directory BBFETCH_GIT_REFERENCEDIR,
> > subdirectories of which can be used as keys for the new reference=
> > parameter to git SRC_URIs. 
> 
> Is there anything I can do to help move this forward?

There are several things concerning me:

a) no test case for bitbake-selftest

b) no update to the git fetcher in the documentation

c) the functionality I mentioned to make this more useful to others is
left as an exercise for someone else

d) the maintainer is apparently misguided about c) in the first place
having taken the time to try and explain it

e) we're in the middle of a feature freeze and release


If c) is left there is the risk we find the interface needs tweaking to
support it and we become a little stuck if the functionality already
merged. I often wish I could say I didn't need or like something so I'd
not work on it but if I did that the project would look very different.

Cheers,

Richard


