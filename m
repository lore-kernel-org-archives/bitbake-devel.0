Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.6311.1588599607607447934
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 May 2020 06:40:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=C9e1giDW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f66.google.com with SMTP id x4so8508996wmj.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 04 May 2020 06:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=l0pPL+xXF0s67857u/urQnaswAZFbL2Ph3EGT3Pv0qA=;
        b=C9e1giDWxlxy9qBe218V8VpiSO19BO6bFaKD9SbgQvNNtVxumTHQTpGXC+mxVShFyy
         /hLV5XweSdPLHUiv4qxHlt0JT9eXdrK0kBs9NA3l77z2XQxCSfy71DpSJDeOKtDefW5q
         yirsMcNqNbDBffotGG7FMjXKOYVSFKDSc8N7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=l0pPL+xXF0s67857u/urQnaswAZFbL2Ph3EGT3Pv0qA=;
        b=hkvvS9raDEiS/+30oGikGOX/80Q2+pUG1+cqjfbTJTQJUwG/22Vf2lC+WJJsvPjfzz
         yIglokvlQOQ5B8nxmhLyhtdfEK+j4cX1Qk9pkrWtKIrCnvxKYdm55XIvDEZ4WMxUoXa/
         Qu8k1njlXFwjXzpHdC+Jb9E3GUsy0Y9OkNw3yo3C/PZgZozr4hB0CxEMfBN55Ig7YWJz
         H7DZzGU1yxigeX9HfYcKOCnR426dKMB+1NWXKvd4kTVc0tN85t39gXQ3Xyk0MGTYWIXG
         nh7IaWEleH1TDNsKoVg4FgXH2f17vbvq5O0kblmKAKHwZwbcw7hGckjrLtaMKzn+GGb1
         3uHQ==
X-Gm-Message-State: AGi0PuYzXq4attWA3RZkzZyYREvmJbBIEPZHbSwZQWEzNFJ6+mMy+shr
	v1pc4p0WZGHEZWsvhzJUASBukAMJCFc=
X-Google-Smtp-Source: APiQypJQQs62YVSQL2wFQD468weoBnJREncMs2jX/Q10jb+ofEgDWSW/BwI7cc1UGIv2sfcrfgO0yQ==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr14816829wmc.69.1588599605699;
        Mon, 04 May 2020 06:40:05 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id x23sm12977472wmj.6.2020.05.04.06.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 06:40:04 -0700 (PDT)
Message-ID: <0f87055b188c7f590385f825ac37571ec86fdf7d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] bitbake manual: emphasizing "PROVIDES =", not "PROVIDES +="
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org, "Robert P. J. Day"
	 <rpjday@crashcourse.ca>
Date: Mon, 04 May 2020 14:40:03 +0100
In-Reply-To: <alpine.LFD.2.21.2005040925430.208011@localhost.localdomain>
References: <alpine.LFD.2.21.2005040925430.208011@localhost.localdomain>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-05-04 at 09:29 -0400, Robert P. J. Day wrote:
>   i believe we clarified recently that the use of "PROVIDES +=" was
> superfluous, as ${PN} is already implicitly part of the PROVIDES
> content of a recipe, so "PROVIDES =" is sufficient to add *extra*
> entries.

You keep bringing this up and sorry but I don't agree with you. I've
said this several times but you keep ignoring me as you don't like my
perspective as it isn't neat or clear cut.

We hacked bitbake.conf so that it always worked even if people didn't
use =+ in recipes. That doesn't mean that using = is correct or the
right thing to do.

Conceptually, base.bbclass and bitbake.conf set up a nice set of
defaults which the recipe them appends to. Recipes then to append to
it. The fact we hack bitbake.conf to append to it is an implementation
detail and safety net.

>   Section 2.3 of the BB manual gives the distinct impression that one
> should use "+=", so i can submit a patch to adjust that. there's
> quite
> a lot of "+=" usage in the oe-core layer -- is it worth cleaning that
> up? it does not, of course, hurt anything, but it potentially leads
> to
> confusion if one is RTFS.

Since we're being pedantic, note this is the bitbake manual.
bitbake.conf in the bitbake repo sets PROVIDES = "" so appending is
perfectly correct there.

Cheers,

Richard



