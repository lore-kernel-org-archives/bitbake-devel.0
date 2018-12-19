Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 169D56C44B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Dec 2018 11:42:05 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id m1so5759887wml.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Dec 2018 03:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=U6bja3PIQE77mmbODqLzhHzWr6g3r7fnotpaa6MuHtA=;
	b=GwD7JP1GvazZep2FsE8wZmCcbyU+J+gFiAGOSf3fYzL3V0gwrFi8k6b/WZj0sUk7eS
	ix6fBW3rG72lAgPba3gWWzvBoty2pq+wtQnhYuEhBMPdj34cd/qyB0mnmCIq+NK79DbT
	vmpFu2c9kbwpkjr19PP3Dr7V6sgVDV2Er2NRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=U6bja3PIQE77mmbODqLzhHzWr6g3r7fnotpaa6MuHtA=;
	b=TrnOWV5Y1b3pJT4CRT58fbGG1sUG+nw9Ix9iuWQjVpxKYNage81SZEXBSLj2Lb2E9d
	OW0CgWwvDrhHy2O/e7qrdfcUI6ojQgql8k/Mc/HhXEelZDsKi85qEHo8ShYBq6Haem7f
	GkGx/eI3Mitq9GEt00AecxsP3rdcIXaBDNOxCsVRaSHV4NVbKET677W1WukrNwZjBUDg
	nyKc8Gvi/QrDuUTHhyq6H6kVrXdZv9NYrCB9hZ1SeCF7DJMbY/I9SXUsmUjYoSECjfBP
	kHyAURv6ROj7Pgo3JbELEDXDS7sSeErXc8Con8kX9uOslMvoh+3p53jjxsaXAPvYNr+n
	lCfg==
X-Gm-Message-State: AA+aEWZ2vSzMEtdwhY22MvBB+VrC3WnQh7Yy4TW460R+qA8ouL06uby0
	XsYRM5YMwX8Sxsp7a3NhCWjk8g==
X-Google-Smtp-Source: AFSGD/Wso5wJOb6Df7SJHulswUse3eQ4OBGSMdpfL0e5oRb1aVq+EMLqupXe3QuRefiBgW1XHIlLjQ==
X-Received: by 2002:a1c:e046:: with SMTP id x67mr6732762wmg.122.1545219726658; 
	Wed, 19 Dec 2018 03:42:06 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id k7sm4874999wrl.51.2018.12.19.03.42.05
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 19 Dec 2018 03:42:06 -0800 (PST)
Message-ID: <ab481f529628568941f4790a2cad883ac00b6384.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 19 Dec 2018 11:42:05 +0000
In-Reply-To: <0963d345ec074cbfac6a7e79ccbb0a9e@XBOX04.axis.com>
References: <20181214140219.1553-1-richard.purdie@linuxfoundation.org>
	<20181214140219.1553-2-richard.purdie@linuxfoundation.org>
	<ca187ac1c83d43b282db6b8d66d416a8@XBOX04.axis.com>
	<eae945fea01f12c8abd559b4988ae34f9e2fe405.camel@linuxfoundation.org>
	<0963d345ec074cbfac6a7e79ccbb0a9e@XBOX04.axis.com>
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
Subject: Re: [PATCH 2/3] data_smart: Allow numeric characters in	overrides
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Dec 2018 11:42:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2018-12-19 at 10:55 +0000, Peter Kjellerstedt wrote:
> I don't understand the commit message either. It says that there are 
> problems with x86-64 because it contains digits, but x86 (which the 
> commit message says works) contains digits too, so that cannot
> really 
> be the case. If it is actually the dash in x86-64 that is supposedly 
> a cause of problems, then islower() ignores both digits and non-
> alpha 
> characters like the dash so that cannot really be a reason to change 
> the code either. All in all I'm confused by this commit and what it 
> is trying to solve...

Consider this output from python:

>>> "64".islower()
False
>>> "x64".islower()
True
>>> "x64A".islower()
False
>>> 

The problem is that "64".islower() returns False when we need True
(overrides get split by '_' so x86_64 turns into "x86" and "64" in the
code in question).

Cheers,

Richard


