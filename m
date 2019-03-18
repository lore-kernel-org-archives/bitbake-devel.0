Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id C58F96D4C6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Mar 2019 23:45:45 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id s15so3649364wra.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Mar 2019 16:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=G7WJqEYY/wwELLCt2o3bHT+tJ4lYZJacxf671mS/l/8=;
	b=aeeWETyRj5vb/tYx/rF6CmwZWkbUpkrTt98KvZ6/Hre5nsZws9JnwustG/1Hgz/KFn
	KP0SLOJ/gaBrQXGAhcaXLJjNbvNqydZpSQ3GJAdiV+UxR154yj2AXyEa4GEiE9QK0Wr3
	02VIiy1EgbV8lTxyrIJCGx8uojWgo0x6kc8IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=G7WJqEYY/wwELLCt2o3bHT+tJ4lYZJacxf671mS/l/8=;
	b=gqvsu+umJBPL+NTG7sn0N5D1qkQ2ALJhceaXa4Cvyq1nOLrmP4i1RpJPR/Mv1EVaOQ
	gje/NU/HXNR375WX8eCnSJlG80kjOpY5PTtAlWx5WbkVZVHSuYwqI8VzAS9B2A4Mn3PQ
	bV5uRBf1+9xVRUQHT4KtbpluANnwBtHZdAOME1sLuvaqHokNOamif+JOFQ/ixGyoytFZ
	eVQ+5zvjFVn0IWz5urcZlV62ErUkp3fy5Clp9xZtOpvSUm4bsd9dX2ljzK86fKTiV3yI
	OaXxQWd4bXW2z09pVhzM5+N+uPEloyJqq+tX4X9j2A/ITEQp0p+4kPoOrRSk4LQk3X55
	qpyA==
X-Gm-Message-State: APjAAAWDQVSJOWEhCpRPsjYmxC2n6x6KSq/q4MgVK+UbYbuF6/mnWAP9
	/R4xONkxxaPEldPtGGn3r3k8dg==
X-Google-Smtp-Source: APXvYqx2sh4+i3wajakg/mkMtDtxUB/sljSfXrQ0sJ/1q+u2dFKyHoXzJQbzOj7uV04Nq0ZohXcgyQ==
X-Received: by 2002:a5d:574c:: with SMTP id q12mr14880907wrw.50.1552952746663; 
	Mon, 18 Mar 2019 16:45:46 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	c126sm1240555wma.0.2019.03.18.16.45.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 18 Mar 2019 16:45:46 -0700 (PDT)
Message-ID: <cf989d646a50e462b36a9f93481a3aba1618e8b4.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Klug <stefan.klug@baslerweb.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 18 Mar 2019 23:45:45 +0000
In-Reply-To: <20190318135820.7344-3-stefan.klug@baslerweb.com>
References: <20190318135820.7344-1-stefan.klug@baslerweb.com>
	<20190318135820.7344-3-stefan.klug@baslerweb.com>
User-Agent: Evolution 3.31.90-1 
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] fetch2: Gracefully handle corrupt download-cache tarballs
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
X-List-Received-Date: Mon, 18 Mar 2019 23:45:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2019-03-18 at 14:58 +0100, Stefan Klug wrote:
> If the fullmirror tarball is corrupt for whatever reason
> (IMHO there are no checksums on the download cache)
> a series of nasty events was triggered:
> - tar left a partially extracted bare git repo there
> - on the next yocto build, the corrupt bare repo is
>   found and bitbake starts to update that bare repo using git
> - git fails to detect it as bare repo. Therefore
>   all following git commands ripple up the directory tree,
>   in our case modifying a top level git repo.
> 
> Signed-off-by: Stefan Klug <stefan.klug@baslerweb.com>
> ---
>  lib/bb/fetch2/git.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 1a8ebe3d..d5f9bbcd 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -334,8 +334,11 @@ class Git(FetchMethod):
>              ud.localpath = ud.fullshallow
>              return
>          elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clonedir):
> -            bb.utils.mkdirhier(ud.clonedir)
> -            runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
> +            try:
> +                bb.utils.mkdirhier(ud.clonedir)
> +                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir, cleanup=[ud.clonedir])
> +            except:
> +                logger.info("Extracting tarball of git repository failed, falling back to clone.")

General "except:" clauses are a world of pain. Can we be more specific
here?

For an example of what I mean, put a syntax error in the command...

Cheers,

Richard



