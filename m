Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
	[209.85.128.51])
	by mail.openembedded.org (Postfix) with ESMTP id 4C71B7C40D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Feb 2019 16:29:55 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id b11so518138wmj.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Feb 2019 08:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=xzvHZeMM9VfAI7FxknypdSIEJTmm4rHnyGvlEI/0cTc=;
	b=OMiZ4Mb5CFgATcgXe6QaGnMdcN4UGr/XN+tkfwGv2nhLq/iRo3gPP7KT57XPHsuCtz
	60T37QlfwGCR5J6cP8cFJcHujmqZSZ6AzkQAfZi/+71mdhB/88w5NY+c8vVV8SIJYvQ0
	sZdvB4fgUkGeWlldc062sLB3X+47O615yqsE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=xzvHZeMM9VfAI7FxknypdSIEJTmm4rHnyGvlEI/0cTc=;
	b=CXapjlrGC+3cG5GU+Uyxix/LTxxGclbI9+NXakwUcx5UAOhhYAok+v+pWLou9IudAe
	qw7ice7YRWEsMw3+/tPs3A3AqajFvgQZsNsZbpYftdhsV97IaVJoOQk3PUpwli/QrsP/
	8oi6uP1+LRFlTxw8Q/ZkTQt3/nDVNoOIt85QqyxvoMkqXuzeKs/THGTbT4Xq9PR4ietr
	IE5v9cbblzdKShrvQZXTnMxWLPhR+X1MTbKRQZhhFt8bplVFCcrjpOiohQq4jUlVvGTe
	iGYVQu70lRsbgHGgA2hGrnf+DkBUmoP+kdcp1MFs71gFRDFR0UkmZCehxuuB/abQQTHJ
	821w==
X-Gm-Message-State: AHQUAuYOc6q0Z0Qb3dcXtPAAV5H+yNhBYq18Azd80eYW6OnAcEn7JlTk
	elGgPBxd9B8kYkYy3eke/S0/onyvATE=
X-Google-Smtp-Source: AHgI3IZFC35n8IQIIEysFgQ8KMzi4cC54PE9SbpQdo7gV6SQBQlqZkBodnSG2W3I+FmSRLsmckEMKg==
X-Received: by 2002:a7b:c30b:: with SMTP id k11mr6631804wmj.65.1549556995745; 
	Thu, 07 Feb 2019 08:29:55 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a8sm24525166wme.23.2019.02.07.08.29.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 07 Feb 2019 08:29:54 -0800 (PST)
Message-ID: <80f9feccb12a5ebc9b9e76620a5399abee3897e1.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cameron Kellough <cameron@paloaltoinnovation.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 07 Feb 2019 16:29:53 +0000
In-Reply-To: <CAHWfWz=EQrrUXBeSUqu6mxCd5A-Yw+yLWJxETfwW+D1AdNFPoQ@mail.gmail.com>
References: <CAHWfWz=EQrrUXBeSUqu6mxCd5A-Yw+yLWJxETfwW+D1AdNFPoQ@mail.gmail.com>
User-Agent: Evolution 3.30.4-1 
Mime-Version: 1.0
Subject: Re: Bitbaking recipe with patchdir in SRC_URI creates parse error
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
X-List-Received-Date: Thu, 07 Feb 2019 16:29:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-02-06 at 11:13 -0800, Cameron Kellough wrote:
> Hi bitbake developers,
> I'm working in a Rocko based bsp.  I've used the patchdir construct
> in SRC_URI to apply patches in the tree where the build is expecting
> them.  When I set PV="1.0+git${SRCPV}", I get the following error and
> traceback if any of the patchdir directives are present in SRC_URI:

The error is annoying but understandable as you've created a circular
variable reference.

In order to calculate PV which includes the git revision, it needs to
expand SRC_URI. SRC_URI contains WORKDIR which includes PV.

You could try defining a WORKDIR without PV in it, or a subset of PV?

Cheers,

Richard



