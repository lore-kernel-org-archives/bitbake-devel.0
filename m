Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1A2FF8868
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 18:14:29 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2506.1777313661442414540
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Apr 2026 11:14:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=IgVCLKbw;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso52625895e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Apr 2026 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777313660; x=1777918460; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lU2hFO35lQ/6lsNT/GMS2wzI4J2DCb+H81By6kYtJ4U=;
        b=IgVCLKbwi65csUljwmMu6BHScxM87aJzl8vuVMhpuTohAVsT87WoFtq1i9WkE6R5lw
         sZW0eUHi7UH56xBTAgRFdV3+W1b2Ex/msOiAVQSw6CGwZTGNCRAUpZRdy7oLQwFkYKAu
         lQUi4DW6+67gPVE4qzY5a0kirdbtrCKI+Ek+y7U3EMTk3BlBzO7SzFFJ52cpzTWnzoTJ
         DruLYo3akoSG31PbqzBkLhTpmyJvwqvBCjZZ+S2F7seW44eLRpbJXK8G8S2sk0IyE+1T
         7ArrtqSIUy7EcZnNvSEoFr6Jc4tw20rnjmeKBb1xl6PVxAxjc50uetH1ffbSE4+VuZ0q
         kv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777313660; x=1777918460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU2hFO35lQ/6lsNT/GMS2wzI4J2DCb+H81By6kYtJ4U=;
        b=GQ9z0JYB/t9iySETkk9VumyU9iqxwNc5dsLhIISYYPv9eMTzFtfEfDcpW7R8rihN3W
         mIziB2c6AnbyMeOz4I5vaXk228qSiBCrLBSKVYMgP22hr+rQLhSz1tGGZ8JFd+0ibk4a
         WBLGmvhk6a4LU281fIsiaxQvO+RhQiwt7Bn8sCCpcTvEFSf7NotOTSZcaKqlhPvloiNy
         MvKH6x76E+cg7+XK+7387lTQw/DM0bXs2xwbL/YThEIR64sYZdEzyuE4YcfEXVPEGG8Q
         8OEnIESAFaO0SUhQplik9WJ9rzEnN2YKT2OqAC5XvmrkYu09YL4z8TEE0OA/XNr29NKj
         o99w==
X-Gm-Message-State: AOJu0Ywtg9iqUi8RzXXfa2QAdarDqw3RC5rHCmhtcCtLpeAvRdHCX0k3
	/VMUXq81vAOvlFkIQWpLssELXTpQ0faLVAkXfIR+Y383OuviJcmWudXM
X-Gm-Gg: AeBDiev5dAJ+6Sn4+KKAo3wtpki40u4s3VjjemJMB8K47P1OFQMwmLr7pPlDCGRBCAR
	0/4NSEo7okpOdSIlq2cWMLzsh+5pjaD1WDibfj43xMDoUNbCG0+Nvfx9ATDYKMrsYKL5tVKcnix
	A0JMUdl0axFAKyDUBTjDSMDQOOyym2Ybt091wwawkgPMFqsj2SZAZMZwuZN1RTctQufFBJkwLsd
	WbnBMILw/63Q1AFlOxBZRnbQL4JweGknqDCl59fKidQOwr4OoQbc4pqh5YypRHsuJVNB5flk8y9
	zRJEYnEEEvp4qYnRSk8TeR0zrI25lX+5hc6YcQ5+sGDq5njGskUcalFXmUYS4NaDdgGQRH5AQqa
	qsh3qKkHqM5jqOvQeKkwpOcOzPNpi+vD/qqJ8SFKloHtQdWkgOhFFvEl6qbeAhRjPj1EhgxD01c
	QHYzxgPxbViDicLBSg6HdK0jiWwpj55NCfELetCFaI5yh9X8mdyVqkPO3kRjyfWtdhmsYC91olm
	RnhFW0u18TK12E+WqCJHamxrMVKPdjJPz9eELVcCodxJF8VRpcXSQVUv86s
X-Received: by 2002:a05:600c:4fc5:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-48a76f8e680mr4985205e9.26.1777313659552;
        Mon, 27 Apr 2026 11:14:19 -0700 (PDT)
Received: from thinkpad ([2a02:8070:d188:380:a171:2495:6920:2d36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a76f7ecb2sm7957325e9.0.2026.04.27.11.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 11:14:19 -0700 (PDT)
Date: Mon, 27 Apr 2026 20:14:16 +0200
From: Dawid Bijak <bijak.dawid@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH 1/1] doc: bitbake-user-manual-metadata: fix
 inherit_defer documentation
Message-ID: <ljbjkwt32h72aziah2gepb6k5rfxygfrhkfysmulj5scnca5pu@o4vikz4hfmh3>
References: <20260424062327.820993-1-bijak.dawid@gmail.com>
 <20260424062327.820993-2-bijak.dawid@gmail.com>
 <c25e0e9a-8809-4ac6-90ee-3687972e03af@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25e0e9a-8809-4ac6-90ee-3687972e03af@cherry.de>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Apr 2026 18:14:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19398

On Mon, Apr 27, 2026 at 02:35:45PM +0200, Quentin Schulz wrote:
> Hi Dawid,
> 
> On 4/24/26 8:23 AM, Dawid Bijak via lists.yoctoproject.org wrote:
> > [You don't often get email from bijak.dawid=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > The documentation for inherit_defer contained the claim
> > 
> > "If VARNAME is going to be set, it needs to be set before the
> > inherit_defer statement is parsed"
> > 
> > which is incorrect and contradicts the purpose of inherit_defer.
> > The wrong claim is replaced with an example which demonstrates
> > the contrast between a plain defer statement and the inherit_defer
> > statement by using an override assignment placed after inherit_defer
> > 
> > Additionally the inline python expression examples have been
> > moved from the inherit_defer section up to the inherit section, since
> > they apply to both directives
> > 
> 
> I'm pretty sure the whole inherit_defer thing started because an inline
> Python expression didn't work. I vaguely remember a bbappend either adding
> this new inherit based on PACKAGECONFIG containing a value, or having the
> main recipe with this inherit <PACKAGECONFIG.contains> and a bbappend modify
> PACKAGECONFIG. See commit 5c2e840eafeb ("ast/BBHandler: Add inherit_defer
> support") in BitBake.
> 
> So I'm very skeptical this is correct.

Hi Quentin,
Thanks for your response.
I'm afraid I don't quite follow your point about PACKAGECONFIG.contains.
I'm not sure what you're referring to exactly.
But, as far as I can tell, the inherit statement works fine with inline python expressions. 
I think, it evaluates the expression in place, much like := would.

For example, on current master I tried the following:
 COND = ""
 COND:append = " x"
 inherit ${@bb.utils.contains('COND', 'x', 'foo', 'bar', d)}
This inherits foo. 

However, if I move the :append below the inherit directive:
 COND = ""
 inherit ${@bb.utils.contains('COND', 'x', 'foo', 'bar', d)}
 COND:append = " x"
it inherits bar.

Greets,
Dawid

