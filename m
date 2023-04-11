Return-Path: <ola.x.nilsson@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8660C76196
	for <webhook@archiver.kernel.org>; Tue, 11 Apr 2023 08:46:30 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.8863.1681202787007095205
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Apr 2023 01:46:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=KYIzajoc;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: ola.x.nilsson@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1681202787;
  x=1712738787;
  h=references:from:to:subject:date:in-reply-to:message-id:
   mime-version;
  bh=E6fFoUJpCbSlEMtwa1AxD00Zk6qjYsMLgUeJEvr/ZmE=;
  b=KYIzajoc0WsX66aXdDkBwfPwh1GrI6CPAnDS7RTpqUWmIgv7PuBu0ddY
   rwXE4q80d7wXNZKRqBxcJugDJi/s+KfifuJ9jOjQXgdlgrhhQpRbSkuaP
   DrZNj8hWH+dyXdQfbGRXjOJF/KZt3bDoCMQWjeq0uDEjw32V2ohhucONJ
   RibZA2c1mxEFPlRKU451CyMSX72U3MYJX+kIkdILw7v9zxnVz2MESLdWI
   /IWP0P9Z8lrmEtYatL9oO5UsiO8UvpTt9MjGvJnZ7XHa9IsMLEDgw1NQE
   N98EfD6GvJ9GF60BWiuoCJz2y1uT0tD3DWCUDMO+AznhR8vkS6NpkmSGS
   w==;
References: <20230411060654.19442-1-kai.kang@windriver.com>
User-agent: mu4e 1.8.14; emacs 29.0.90
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: ConfHandler: Allow variable
 flag name with a single character
Date: Tue, 11 Apr 2023 10:44:27 +0200
Organization: Axis Communications AB
In-Reply-To: <20230411060654.19442-1-kai.kang@windriver.com>
Message-ID: <jwqile2q00y.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 08:46:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14690


On Tue, Apr 11 2023, Kai Kang wrote:

> From: Kai Kang <kai.kang@windriver.com>
>
> Update regex pattern to allow variable flag name with a single character.
>
> Regression tests have also been updated in `bb.parse` and
> `bin/bitbake-selftest -k ParseTest` has been successfully executed.
>
> Signed-off-by: Kai Kang <kai.kang@windriver.com>
> ---
>  bitbake/lib/bb/parse/parse_py/ConfHandler.py | 2 +-
>  bitbake/lib/bb/tests/parse.py                | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
> index 05c627ec8b..0bfe357012 100644
> --- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
> +++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
> @@ -21,7 +21,7 @@ __config_regexp__  = re.compile( r"""
>      ^
>      (?P<exp>export\s+)?
>      (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
> -    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]+)\])?
> +    (\[(?P<flag>[a-zA-Z0-9\-_+.]([a-zA-Z0-9\-_+.@]+)?)\])?

It would be better to use the simpler expression
(\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]*)\])?


/Ola


>      \s* (
>          (?P<colon>:=) |
> diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
> index d27c7c6f15..a3165d95bd 100644
> --- a/bitbake/lib/bb/tests/parse.py
> +++ b/bitbake/lib/bb/tests/parse.py
> @@ -222,6 +222,7 @@ VAR = " \\
>      at_sign_in_var_flag = """
>  A[flag@.service] = "nonet"
>  B[flag@.target] = "ntb"
> +C[f] = "flag"
>  
>  unset A[flag@.service]
>  """
> @@ -232,6 +233,7 @@ unset A[flag@.service]
>          self.assertEqual(d.getVar("B"), None)
>          self.assertEqual(d.getVarFlag("A","flag@.service"), None)
>          self.assertEqual(d.getVarFlag("B","flag@.target"), "ntb")
> +        self.assertEqual(d.getVarFlag("C","f"), "flag")
>  
>      def test_parse_invalid_at_sign_in_var_flag(self):
>          invalid_at_sign = self.at_sign_in_var_flag.replace("B[f", "B[@f")


