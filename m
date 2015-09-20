Return-Path: <romain.perier@gmail.com>
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
	[209.85.217.180])
	by mail.openembedded.org (Postfix) with ESMTP id E003D72A78
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 Sep 2015 17:06:35 +0000 (UTC)
Received: by lbbmp1 with SMTP id mp1so41928530lbb.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 Sep 2015 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=references:from:mime-version:in-reply-to:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=sZLeouSA+Ma9PRt4qIRIpflHbtNsmQw2hQzbpzCAwwE=;
	b=vP3C0Dd72VY0Zi2lCP/4EsRKd7fpRzhCH0gOy2baw8D8neJPwLOLJkCqYGuQIsLeCA
	V7zJYlYWy2+OiZw/3rfD52TKPw2WJYgOglrAA47lVN3uAfmh40K1rsZR/430qPFSqVik
	wZ39ODsXGQXo0obKuMCCZvHzKwDY9atFPS8pHzCJaSISN4q8B+B9j39WEnCMmG39Skb8
	EVERXqRsLUYg+fCgKzLXWSfLlOPl2KjJf2M8KBIQnKV3HcWwY/bwevYgV13SdLoq40dT
	u3guIbsrqto5nNV7EwD13CEwZhTFCmz6bEqEW1PNciMBYhGyzSm+sN8RMa7tUxX+5qBC
	R22g==
X-Received: by 10.112.12.165 with SMTP id z5mr6171680lbb.33.1442768793603;
	Sun, 20 Sep 2015 10:06:33 -0700 (PDT)
References: <1442697816-11303-1-git-send-email-raj.khem@gmail.com>
From: Romain Perier <romain.perier@gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <1442697816-11303-1-git-send-email-raj.khem@gmail.com>
Date: Sun, 20 Sep 2015 19:06:33 +0200
Message-ID: <4572846161197673833@unknownmsgid>
To: Khem Raj <raj.khem@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH V2] bitbake: bb.fetch2.git: Import errno module
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
X-List-Received-Date: Sun, 20 Sep 2015 17:06:36 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

If this is the patch rebased on the bibake repo, thanks you. I am on
vacations these days ;)

Romain

> Le 19 sept. 2015 =C3=A0 23:14, Khem Raj <raj.khem@gmail.com> a =C3=A9crit=
 :
>
> From: Romain Perier <romain.perier@gmail.com>
>
> Currently this module is dereferencing errno.ENOENT but the python module=
 "errno"
> is not imported, which causes a crash when fetching from a git repository=
.
>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Acked-by: Christopher Larson <chris_larson@mentor.com>
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
> lib/bb/fetch2/git.py | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 4a32a31..9c04da0 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -69,6 +69,7 @@ Supported SRC_URI options are:
> import os
> import re
> import bb
> +import errno
> from   bb    import data
> from   bb.fetch2 import FetchMethod
> from   bb.fetch2 import runfetchcmd
> --
> 2.5.2
>

