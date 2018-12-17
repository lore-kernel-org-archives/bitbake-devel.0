Return-Path: <jacob.kroon@gmail.com>
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
	[209.85.166.66])
	by mail.openembedded.org (Postfix) with ESMTP id 431FB7BF3E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Dec 2018 18:48:06 +0000 (UTC)
Received: by mail-io1-f66.google.com with SMTP id v12so7188193iop.7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Dec 2018 10:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=DC4KUIRq5UfttlownMagijahOIidMCQlXeYUbpoXeOo=;
	b=escOu1trI0Kkfhgo4ghSDyLOnezNrmNq83uGhgf6gJ1djFrbI4cWffawI8CcW79WXd
	nihoGR1Bzb5qpJ3eFmrs9OOWOxjp7jIT6RmABaXh17cj+aUzEvnQN8qLPpb1nvHCSF16
	sN/Um1936gV8mfN2MxlwWbJh9v4tPtn8WDrN3Tv5ZGFmQSG5Ag7nAf1LpP9We8UvDA3i
	cufJHF7A8NnlZny1Juj/I72z4CpxWibXIVODnAlg3w8DN+vbJa2adHFqNC54lhtbzVy/
	K3jxCVx3QZDWa7Hs1P610m5pdxYysfHnwbOsOHJ4eImRKN0yDrflRDlJDOOkfmZJtUJy
	raLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=DC4KUIRq5UfttlownMagijahOIidMCQlXeYUbpoXeOo=;
	b=NIbgI2Xy5KFoe5bXZHGBcEju7FkCXIZ9v23GQYtC7Owj6JD2t6StGbdfHfnfF1PfyI
	Sdyd3CUV1erD97+s4AM+PDzN0WXay89m1rTOOhLEXLcHOky8L9WY9SHnplnsqRvBzwPB
	1MhPkFizTgwgeLwvf3LZzxqlgpAoW1Q7iNd79TZ/PcUZxrLt7YYODidYzzgQ8niE0cHp
	vW8aPbhpW1q0jQNwyyExUjfg5Xm7FKrNOb09fDmf8NH04QrRw7DnPgXgkDNAWbLZ5wxy
	OXBHnKWmpfwIhKCY4BadX1kE//Xxde7i7/rem8TSNGB+ECRP3LC23kJHQr945/rw4xOI
	kQ+w==
X-Gm-Message-State: AA+aEWaeqGvVZUwo8AxdY8gOYuz4UhsJXGVgnFUZCF0ENZXloWZXIiOT
	/noh5KcYmDj2s3gCFgsWoJqjfUZ0l8jBHDmu3ME=
X-Google-Smtp-Source: AFSGD/VUtoirXbYlF9SnpFaDXK/6kaBNYM03S6ywJOuk2yG5EvW3CseF3gbGczvqGz3euYMXGABBPoMAxY5rfuHIUWs=
X-Received: by 2002:a5d:8d85:: with SMTP id b5mr12893904ioj.38.1545072488062; 
	Mon, 17 Dec 2018 10:48:08 -0800 (PST)
MIME-Version: 1.0
References: <20181217144006.32015-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20181217144006.32015-1-richard.purdie@linuxfoundation.org>
From: Jacob Kroon <jacob.kroon@gmail.com>
Date: Mon, 17 Dec 2018 19:47:56 +0100
Message-ID: <CAPbeDCk51q9Fz4ZsJ1jZP64aLdZc7YRaWCQVK5=kNSO=xfScrw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] codeparser: Switch to sha256 from md5
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
X-List-Received-Date: Mon, 17 Dec 2018 18:48:07 -0000
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 17, 2018 at 3:40 PM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> We've reports of hash collision with codeparser. Looking at the way collision
> problems occur with md5 and the way our function templating works, I can believe
> we may run into issues.
>
> This patch therefore switches to sha256.
>
> Performance wise, parse time could appear to rise by 4s in 374s
>
> Before:
>
> 384329 in 2.966s (md5)
>
> After:
>
> 349743 in 2.340s (sha256)
> 34723 in 1.245s (md5)
>
> since we still have md5 used elsewhere in the code, something we should look at
> next (using sha256 everywhere is around 5.3s in total)
>
> Unfortunately this does nearly double the size of the codeparser cache file
> due to the hash size change.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/codeparser.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
> index 3f8ac1d5f6..ac995a6a1d 100644
> --- a/lib/bb/codeparser.py
> +++ b/lib/bb/codeparser.py
> @@ -33,7 +33,7 @@ from bb.cache import MultiProcessCache
>  logger = logging.getLogger('BitBake.CodeParser')
>
>  def bbhash(s):
> -    return hashlib.md5(s.encode("utf-8")).hexdigest()
> +    return hashlib.sha256(s.encode("utf-8")).hexdigest()
>
>  def check_indent(codestr):
>      """If the code is indented, add a top level piece of code to 'remove' the indentation"""
> @@ -140,7 +140,7 @@ class CodeParserCache(MultiProcessCache):
>      # so that an existing cache gets invalidated. Additionally you'll need
>      # to increment __cache_version__ in cache.py in order to ensure that old
>      # recipe caches don't trigger "Taskhash mismatch" errors.
> -    CACHE_VERSION = 10
> +    CACHE_VERSION = 11

The comment above mentions a "__cache_version__" in cache.py. Should
that be bumped as well ?

>      def __init__(self):
>          MultiProcessCache.__init__(self)
> --
> 2.19.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

