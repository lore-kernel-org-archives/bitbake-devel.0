Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id D0F7A6C4F2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Mar 2019 23:44:01 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id n19so14768387wmi.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Mar 2019 16:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=/0FBiUq0DH5EXLCjI7SDc6kzM3Z9PZm5l/v36go/7XM=;
	b=DM6saT06inV1/kQsqiuiMx/8S3NFTL1IBE453Ju8MGttE8t7jCII2uzXr2VZfUCPxA
	Op+QP54s4a21Ig+eWLblmnyiy1O1g6vw3Zhu0EKfJBkRldN8Asx1GAF2JkvW1ncsBusm
	2kouZ43zpVoVxXAGSt+H5WGKTeT+/7B8oqXsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=/0FBiUq0DH5EXLCjI7SDc6kzM3Z9PZm5l/v36go/7XM=;
	b=Kxzi/hKrf4GyfvRlakVs+KQD7SKINckGwwbHmD0mfaTaxOENfeNXUe93uUD6864a2T
	7dtjapC3/WAD7OUi+fmFTopeW9RmFAXwoYY++Ooxc+G+Az3LCk1JOYbdc+1ho/7m9eRm
	EWYKYLMv4+YuWZD/mbNg06thBrBztZ16QJzHEx/oaZ6UCJF+RLDv06xd9z+uIScizYJs
	62IKiLmVfp/x396aqgWK9ZUzxihQiFym7oz2xjL3PkDR3T7lQDShnmQBdTQ8R8UaP328
	8WMsdsmpWHRP2y802bz5VjfQiJLtcQdQ+UQd6sAtNdRD8Zwr0jmKgDVJBvcL3hlLAbQg
	nBJQ==
X-Gm-Message-State: APjAAAXz2z107u4FKvnyQkHCN6vsYHmO2LilQAi6YhEE2KbAbOTEMei0
	H8n2mLsiZfdbifhhikjezzRO6A==
X-Google-Smtp-Source: APXvYqytMe5HPPnSuL0DHchFRTCcADbAsMnYk8McBO0dlSv5uOxlfJGHu5gOlc9RYQ1DP+1CXBnfYQ==
X-Received: by 2002:a1c:9e89:: with SMTP id h131mr458208wme.41.1552952642661; 
	Mon, 18 Mar 2019 16:44:02 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id o8sm789248wma.1.2019.03.18.16.44.01
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 18 Mar 2019 16:44:01 -0700 (PDT)
Message-ID: <ebb1c8ec84b5ae4f428a4899b4bfd535f4801aa2.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Klug <stefan.klug@baslerweb.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 18 Mar 2019 23:44:00 +0000
In-Reply-To: <20190318135820.7344-2-stefan.klug@baslerweb.com>
References: <20190318135820.7344-1-stefan.klug@baslerweb.com>
	<20190318135820.7344-2-stefan.klug@baslerweb.com>
User-Agent: Evolution 3.31.90-1 
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] fetch2: Fix fetching of git repositories with kerberos authentication
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
X-List-Received-Date: Mon, 18 Mar 2019 23:44:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2019-03-18 at 14:58 +0100, Stefan Klug wrote:
> When using pam_krb to login to a system KRB5CCNAME is set to the
> corresponding kerberos auth cache file. The bitbake fetcher removes
> this variable from the environment leading to a git authentication
> failure.
> Also the fetcher ignores the normally used BB_ENV_[EXTRA_]WHITE
> variables and relies on a hardcoded list.

This code should probably include the BB_ENV_[EXTRA_]WHITE list
variables...

That doesn't invalidate this patch but does suggest we have a bigger
problem.

Cheers,

Richard

> Therefore it is impossible to fix this issue outside of bitbake.
> 
> Signed-off-by: Stefan Klug <stefan.klug@baslerweb.com>
> ---
>  lib/bb/fetch2/__init__.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index f112067d..df8e83e7 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -830,6 +830,7 @@ def runfetchcmd(cmd, d, quiet=False,
> cleanup=None, log=None, workdir=None):
>                    'GIT_SSH',
>                    'GIT_SSL_CAINFO',
>                    'GIT_SMART_HTTP',
> +                  'KRB5CCNAME',
>                    'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
>                    'SOCKS5_USER', 'SOCKS5_PASSWD',
>                    'DBUS_SESSION_BUS_ADDRESS',
> -- 
> 
> 


