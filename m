Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880CBCD4F54
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 16:06:10 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14011.1780070766962733468
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2026 09:06:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=AILOwCpN;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45eea3448f2so1118554f8f.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780070765; x=1780675565; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/8T0J6gF8Lzq5D3dc2xUPEy52qa3IYij5P4sXAqe+L0=;
        b=AILOwCpNO2cKMt5yaNx9mRzfMFx/6+qPZF3IK73pGEieE0h28MB1bTmXX02a5lWkuC
         gzNAPXAIBeOYp/9v6d8TvFhF+HIi4kct+HgDilZNQnU+KM9p/yoHH9WoHrZyxJPcPV6y
         CSxL+kA1cVbrOiY3b6S/RVuaVXPciolqA0tKyp/1GFzqCDUdK0GgYkZ3DHx4GojkbU+o
         UxYNtGMLbJYA9iqfjA5+ApQWWJ8xXCFaVlopngmIEVmS0APg8V/2d5AUZyOrcyG6Dk2b
         AfYmcR1LtcFuxzd7mq9ylUZP5FAbIDNYspXL3oWF9KmVpF5+SZUePOWh8nhoe4M9k9Ja
         mQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780070765; x=1780675565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8T0J6gF8Lzq5D3dc2xUPEy52qa3IYij5P4sXAqe+L0=;
        b=Dl1vcKc5UXulQYTDm20zySZr5tLhxgW5K3DsmtSf1xdWkt84KdinWceeqTJWSHDr/e
         UXb986U8uaCkqyVP/E09QtZ/pBXcculvMyYiKlGKN6U5fXH10/WTYcSSlQV8dKEYofEi
         E9qUFM4LaLCE5aa3ND/Oshm8bHX9WVCKuDqZs5exA+y2hhpg0RCUDQ3vkgctGEdivTnr
         mKKKW05LqA+H8Mw7HSfe66tM535lsvtMh9kDpHHYSmGfhXQbvs5nPMy1gwSaOEJuEFCy
         SP7xskLuWYwL4BnK8Hgg+38OvuBiv7F6jI4lxRjwsWnj045o6w0VTooVqwoe9Pcyc0Fu
         Zg2Q==
X-Gm-Message-State: AOJu0Yz8xrg7p1o/Q46v/152MgVy3LXum0KDDOdaBAkBRjSeFZAamE3F
	/wR8CEo4ustFWTPn9kub1Gewh3d+Z1JkUOrIASIbNrIXBiAu5icOpJdV
X-Gm-Gg: Acq92OGOtOZdcKJ2Y/2qXfLlb2nVmOOJ8vdi/2YEn6Qj9Xo/Us5fVhgvfDLp+6+fu+W
	rUHg1UfUx4gDXaxdTW57UsHVIeAL6K+O4WmA7unEQACQq3p3mtrUEJOgIOryYdzplDSdUZsdj0p
	06YnEt9DIALfskEJdVP5PM+sIKjAqZ6jgioeJv3DQYZTFD/zFo7uP1anS1N1jm/pvWA5HTLTlQP
	xViy0Puq41UM06j9+RE20tvKldx0jPqUYvuhTa5PqCnMJotvkIP/C27+n7MHBLeUaAuiolH8Nvc
	BKIK7iFVuu4laahlPHn0vrTPtG4mzhmu1aaN1TZhEyD9lhK6tiJiyJ6Bal9zr3OTgfnJGC7yi+0
	/O+gkJafQl5fRQRkKDKeSgfEkH0dRLon1QH+Turi3PnU9EGx4Q+0/wLIo6F+KqeGSl1ywxEoIs5
	GX3sS+AMpl8iZhUKI6dApIwd+W4j+y2++1iRZ8wX+9XNTgOfKciQ8EYqrDEG2ZI9JqXNDqasIho
	Qy7mwVCUWAQd5gSpSfA5izxw3mEZDZKmjqWJISqWWFk8QJTbyCcWy1M7aMuIk5C
X-Received: by 2002:a05:600c:4f89:b0:490:6237:5212 with SMTP id 5b1f17b1804b1-490a292eda5mr3668865e9.9.1780070764948;
        Fri, 29 May 2026 09:06:04 -0700 (PDT)
Received: from ernest.hoecke-nb (static-2a02-1368-6200-2fbc-dda0-9952-5f33-942c.cust.swissbackbone.net. [2a02:1368:6200:2fbc:dda0:9952:5f33:942c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef32fabcasm4739473f8f.0.2026.05.29.09.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:06:04 -0700 (PDT)
Date: Fri, 29 May 2026 18:06:02 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: support default
 source overrides
Message-ID: <tgfbutopbavkq6ehs2g62lkfpw7guzyfpucg46lj2p2j534f2b@aaiam4e7b4xf>
References: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
 <20260529-bb-setup-override-improvements-v1-2-91db62e0149e@toradex.com>
 <CANNYZj9FxhgKEfBu0M=1o7pc3RYZ67XdcpOyr5dEKTpmTAWYYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANNYZj9FxhgKEfBu0M=1o7pc3RYZ67XdcpOyr5dEKTpmTAWYYg@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 16:06:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19567

On Fri, May 29, 2026 at 05:56:46PM +0200, Alexander Kanavin wrote:
> On Fri, 29 May 2026 at 16:52, Ernest Van Hoecke via
> lists.openembedded.org
> <ernestvanhoecke=gmail.com@lists.openembedded.org> wrote:
> > Allow a BitBake configuration to list source override files to apply by
> > default when that configuration is selected. This allows specifying
> > source-overrides files (such as fixed revisions) that live in a remote
> > registry, which is not possible with the CLI argument
> > '--source-overrides'.
> 
> I'm not sure I like the idea. One of the design goals was that a
> configuration file is self-contained, and adding references to other
> files greatly complicates the logic (e.g. I can't figure out from
> reading the changes if 'update' and 'status' operations will still
> work properly, probably they won't, as the tests don't check updates
> to the default overrides, or going from using default overrides to not
> using them), and decreases readability.
> 
> Is the issue that you'd like to avoid having multiple files for tagged
> releases, with largely same configuration content, and different
> source revisions? I'd like to understand the use case first.
> 
> Alex
> 

Hi Alex,

Thanks for your feedback, I understand your concern and was not sure how
to go about it for that reason.

Yes, that's exactly the issue I'm facing. We would like to have a "dev"
and "release" setup. My current idea was to have the "dev" setup be the
default, with all revisions pointing to master/tip of the branch and use
source-overrides to create a "release" without relying on users to pass
it correctly.

If users have to pass it on the CLI, it also creates an awkward
bootstrapping where they first have to check out our registry locally
before setting up the release build.

And if revisions are tightly specified in the main conf.json, it's also
less straight forward to update it with the current fixed-revisions
system.

Kind regards,
Ernest

