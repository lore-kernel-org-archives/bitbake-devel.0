Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF9BCD6E56
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 12:53:39 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27922.1780318414930151885
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2026 05:53:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FVmdpD3R;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef82204c6so1102683f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 05:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780318413; x=1780923213; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DC44b610l4pWkoghr6oWSZXl6mov6pko9/PX1lhZP+o=;
        b=FVmdpD3RJNA/+KUZevO5E4H8MKS1OWitvggAMjmw+M6ng0H8v96Did17kDXRCPzFER
         eJkiS9V0WnqS38BvkChlTC8PFsHuEk4WGHXHOtbI5kVBAlHWhSTCW5Sr4JVLdMhalkGk
         ZoscyOUfZ6XhyZzzeXCdMi4g7uzpm7ERhgWlfMgAMcK/bch7BFkbZ9k+xEeJIDIkAqpG
         6j6djjWgKT3UwphqA7fgx0XEFjICHia9fHyoQB4+rAzhGHqLUOMwyG7MqBTx4SPgJOkj
         ArxreJCLr05Bgh8gCrg6SA89skSL+M7qsZ9yrF+EaWYmBJhiGXTVZ0sRFvMbBl+3Xg98
         es6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318413; x=1780923213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC44b610l4pWkoghr6oWSZXl6mov6pko9/PX1lhZP+o=;
        b=L1kEatXC6fUVy24Eo8tEfNBl4mx5GTBsKqNCpjBBlbrdPuezdxhrSnAF37rfKgHUn6
         V8NCVOJoNq9H6o4Vzvxv3Aamk4IYiQX8vNSvp2kHXynYLVJT7uTJxNrZyf3rU1S2zXLu
         CZBeW+MzRNoEqdJ70FdJ/rVps4G9ymvJw9XQN0BpZUAnyMV4AwSAzmSCKn5LN1kzPvPz
         4ptXB5ierhFJMR3UEpodOhU15itWPXzG9+pWrjKiQ0ooRffC5ckAYLgHvWTG6p+Q3bt/
         EOYxUfC7kyy4NuIRzkgNNrCD6pl0w+uQzcz6MmUtiLj73RHLI9fjvL/wFqZ24ap/W5DR
         CWZw==
X-Gm-Message-State: AOJu0Yy9avbInJkbgE3kVc8/mq6ne8hRvBE0bavF+Ry5t9fAeSiJ6c5I
	uubpy/JUPX4wFyCFswkxOZZ5m+0URs1lgTH5pR/8wNznA8HkpjGN4xoC
X-Gm-Gg: Acq92OEidYrIdeYAPH8ebmnsx+nRRfClRa5ij6DyUKmcIPBT10kjEzPm6C7t6K5R64B
	/PqhLI/q0QrIdzUFa3OD604WnZ5C1HR1wkhD2EYFKwch2zg+5bJHIzKsO8e5pobW4smp/2/eHWF
	uqGt/QPlbGoUicYZq6upDjOw2lg/c9gw4Y/s9rXj4HkdHtwJg4Ot8JvLjtVAjp/7R+7ZSl7gUzv
	phm9sAtb8CnbR1Vf9GN1sv8hzIlt/LuPAK42wUNJOCBtaoIxXGIphwSla7WxMjpktHDeQFnmSen
	fAOoLJL9rJGhPEiTMeMe5cTsJuRmyNVWeJb/J0UFx7pkynAsbzFFugLt1IqGvdiYaKrDODQt/Jv
	IdKYN7ydkD877KQ3Rul2lAW/opgC4+vYqS5DhRvuF4+dnCa8FcKeovB44Dm2Mi+sftXkejjr0Ms
	i83FSRnKcS8z5OMbe8gkwY49XUQp3GRhVlJDk3wu5qQjkwbVAOV756ucop2FyHbvZ+dNGMAkQrW
	8YqUBlROa92133MOmUyeLqAlFY/xOXs4Nkwjg==
X-Received: by 2002:a05:6000:1285:b0:43d:1c4a:37c with SMTP id ffacd0b85a97d-45ef6af6c2cmr16737884f8f.4.1780318413165;
        Mon, 01 Jun 2026 05:53:33 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35601d7sm35530684f8f.28.2026.06.01.05.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:53:32 -0700 (PDT)
Date: Mon, 1 Jun 2026 14:53:31 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: write notes for
 generated build configs
Message-ID: <3kgay5cukb3dd6ojc7ysbtd5jgglbe7i4shvcksa2wb3kh2zyc@3oegr7dacucw>
References: <20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com>
 <20260529-bb-setup-notes-v1-2-a251ef1c5af4@toradex.com>
 <DIXISSZ5047B.PSMH6SMC4CF8@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIXISSZ5047B.PSMH6SMC4CF8@bootlin.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 12:53:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19582

On Mon, Jun 01, 2026 at 09:05:17AM +0200, Antonin Godard wrote:
> On Fri May 29, 2026 at 5:00 PM CEST, Ernest Van Hoecke via lists.openembedded.org wrote:
> > From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> >
> > For bb-layers configurations, bitbake-setup currently writes an empty
> > "conf-notes.txt". Configurations using "oe-template" get this file from
> > the template.
> >
> > Add an optional field called "notes" to configurations that populates
> > this field when "bb-layers" is used instead of "oe-template".
> 
> Suggestion: call the field "conf-notes" so it matches the resulting filename?
> 
> Also, I supposed newlines must be explicitly written in the string ("\n")? Are
> those properly converted, or does it need escaping of some sorts?
> 
> Thanks,
> Antonin
> 

Hi Antonin,

Yes, I tested with some newlines explicitly written and this worked fine.
Since it just comes from a json string and is passed to `f.write()` I
don't believe any special escaping is necessary, just "\n" is fine.

My understanding is that the Python json library should handle this well
and converts it to a real newline in the python string.

Thanks,
Ernest


