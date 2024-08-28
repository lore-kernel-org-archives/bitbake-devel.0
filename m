Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD884C636E3
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 16:36:13 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.1013.1724862972940721774
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Aug 2024 09:36:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ij7R1c5/;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53343bf5eddso9237202e87.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Aug 2024 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724862971; x=1725467771; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiqMw8GSg0smt3H4LdsFsj7leC0fktDEUqnNSKjAwxU=;
        b=Ij7R1c5/M+HcSKcgx4K1Ob+rT7mCcisJylI/imueBH0bNWdwoP0tcqaEvHrG5RvC9V
         qfkNGKOEM/u0vCTmtKdjUBA3Vb4jkmeaBYDxr7p7rpuwLZuob6r6yn4S/tFpXj1jYqrK
         ZYDGVMh5tcrj3Ii8SvYXvkRp54FhO4/JDMqIfWJKKwp3geTUmexZmStwzjZQIvUo68Qe
         Be/4zLwdKnVkCPfG8B8JFL/YLUFDUTD7cqc0svJpqKYDS7ZABvToLeotZEInPLIA46is
         mEUTa5jnJYafBBmGAxxylMk2NxnrsIptIL9hiizlEs0H7ys+bywrEuH3YJ6ZftYtda5Q
         XP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724862971; x=1725467771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiqMw8GSg0smt3H4LdsFsj7leC0fktDEUqnNSKjAwxU=;
        b=ZUjm4fyEQqgH/YQiG1H7z5pRyvPsuVatGMYmK1UiSjkBhC8TgnE0hcpK8DXUaHC0K5
         gYwNuZ5EA/ZPKONEafKAilBXKhtbHGpBrWuj25qYAMc0L8uMU8+zVMJRjU5ubPR9Bk9g
         l21DWnvl9uUvaRlh/bZpCefft/x/LEWyBAnQewcEXscCZpNyJIo+Z51XcDYiVfB5jjd8
         +hV5fIIL/rNR71Bq36R7l4xzOP9wI9vE+oeZ3DjFbGw7IMBucSYgp6i7yM+vvQ1Nk+84
         dXQhmVXbvwQsaWxGbS42eleGAsuKWdQit0K2gJSYSr+goTHLYzZp6lHyyiogbywZsmDw
         eNoQ==
X-Gm-Message-State: AOJu0YzWuprRKrEET2J7VVZdZ0PJhScyQnSjtoAJVJ1nf9+VLXNcrtCJ
	iOBUq2J3SY/3cqaRmWKzi0S67BGRoF2QoC/YN6tCLn89Eu0dU70i3yICRc51CkOtvG0GK26ewaK
	h5N2UAWNO7+YMrieJk2ly5sk5tomHaA==
X-Google-Smtp-Source: AGHT+IEA0U5lcksZC3gzB99m5g47ABjB/pmf3tFL4tnu7K4IamTGllFdnuAAQopucD1GhBbZD/q4xezb4tCiMJHXoVc=
X-Received: by 2002:a05:6512:694:b0:533:901:e441 with SMTP id
 2adb3069b0e04-5346c3f90afmr2184863e87.10.1724862970540; Wed, 28 Aug 2024
 09:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240828120646.1458872-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20240828120646.1458872-1-richard.purdie@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 28 Aug 2024 10:35:57 -0600
Message-ID: <CAJdd5GYBV11awouRqMLh4_cmfZgyMdyR+v7q=--by-foTwBnqA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] coreparser: Allow code visitor
 expressions to be declared in metadata
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Aug 2024 16:36:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16525

On Wed, Aug 28, 2024 at 6:06=E2=80=AFAM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> Allow the metadata to define code visitor expressions which mean that
> custom dependencies can be handled in function libraries.
>
> An example is the qa.handle_error function in OE which can set something
> like:
>
> handle_error.visitorcode =3D """
> if isinstance(args[0], ast.Constant) and isinstance(args[0].value, str):
>     for i in ["ERROR_QA", "WARN_QA"]:
>         if i not in self.contains:
>             self.contains[i] =3D set()
>     self.contains[i].add(args[0].value)
> else:
>     self.warn(node.func, args[0])
>     self.execs.add(name)
> """

Open ended code feels like it could pretty easily get us in trouble
(plus, you have to compile it to boot, so you don't know if it's bad
until then and have to deal with that error). Can a function be used
instead? Something like:

def handle_error_visitor(... some argos...)
   ... return some thing useful

handle_error.visitorcode =3D handle_error_visitor

The other advantage I can see of doing this is that you can picky
about the passed arguments and the return code to put some limitations
(i.e define a clear API) on what you allow a visitor to actual do, and
you don't have to worry about visitor code squatting/corrupting
variable names, etc.



>
> Meaning that it can have contains optimisations on ERROR and WARN_QA
> instead of hard dependencies.
>
> One drawback to this solution is the parsing order. Functions with
> visitorcode need to be defined before anything else references them
> or the visitor code will not function for the earlier references.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cache.py      |  2 +-
>  lib/bb/codeparser.py | 14 ++++++++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/lib/bb/cache.py b/lib/bb/cache.py
> index c48feb7138..958652e0e3 100644
> --- a/lib/bb/cache.py
> +++ b/lib/bb/cache.py
> @@ -28,7 +28,7 @@ import shutil
>
>  logger =3D logging.getLogger("BitBake.Cache")
>
> -__cache_version__ =3D "155"
> +__cache_version__ =3D "156"
>
>  def getCacheFile(path, filename, mc, data_hash):
>      mcspec =3D ''
> diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
> index b25a2133d2..01134edd4e 100644
> --- a/lib/bb/codeparser.py
> +++ b/lib/bb/codeparser.py
> @@ -87,14 +87,17 @@ def add_module_functions(fn, functions, namespace):
>              if e in functions:
>                  execs.remove(e)
>                  execs.add(namespace + "." + e)
> -        modulecode_deps[name] =3D [parser.references.copy(), execs, pars=
er.var_execs.copy(), parser.contains.copy(), parser.extra]
> +        visitorcode =3D None
> +        if hasattr(functions[f], 'visitorcode'):
> +            visitorcode =3D compile(getattr(functions[f], "visitorcode")=
, f + ".visitorcode", 'exec')
> +        modulecode_deps[name] =3D [parser.references.copy(), execs, pars=
er.var_execs.copy(), parser.contains.copy(), parser.extra, visitorcode]
>          #bb.warn("%s: %s\nRefs:%s Execs: %s %s %s" % (name, fn, parser.r=
eferences, parser.execs, parser.var_execs, parser.contains))
>
>  def update_module_dependencies(d):
>      for mod in modulecode_deps:
>          excludes =3D set((d.getVarFlag(mod, "vardepsexclude") or "").spl=
it())
>          if excludes:
> -            modulecode_deps[mod] =3D [modulecode_deps[mod][0] - excludes=
, modulecode_deps[mod][1] - excludes, modulecode_deps[mod][2] - excludes, m=
odulecode_deps[mod][3], modulecode_deps[mod][4]]
> +            modulecode_deps[mod] =3D [modulecode_deps[mod][0] - excludes=
, modulecode_deps[mod][1] - excludes, modulecode_deps[mod][2] - excludes, m=
odulecode_deps[mod][3], modulecode_deps[mod][4], modulecode_deps[mod][5]]
>
>  # A custom getstate/setstate using tuples is actually worth 15% cachesiz=
e by
>  # avoiding duplication of the attribute names!
> @@ -161,7 +164,7 @@ class CodeParserCache(MultiProcessCache):
>      # so that an existing cache gets invalidated. Additionally you'll ne=
ed
>      # to increment __cache_version__ in cache.py in order to ensure that=
 old
>      # recipe caches don't trigger "Taskhash mismatch" errors.
> -    CACHE_VERSION =3D 12
> +    CACHE_VERSION =3D 14
>
>      def __init__(self):
>          MultiProcessCache.__init__(self)
> @@ -261,7 +264,10 @@ class PythonParser():
>
>      def visit_Call(self, node):
>          name =3D self.called_node_name(node.func)
> -        if name and (name.endswith(self.getvars) or name.endswith(self.g=
etvarflags) or name in self.containsfuncs or name in self.containsanyfuncs)=
:
> +        if name and name in modulecode_deps and modulecode_deps[name][5]=
:
> +            args =3D node.args
> +            exec(modulecode_deps[name][5])
> +        elif name and (name.endswith(self.getvars) or name.endswith(self=
.getvarflags) or name in self.containsfuncs or name in self.containsanyfunc=
s):
>              if isinstance(node.args[0], ast.Constant) and isinstance(nod=
e.args[0].value, str):
>                  varname =3D node.args[0].value
>                  if name in self.containsfuncs and isinstance(node.args[1=
], ast.Constant):
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16523): https://lists.openembedded.org/g/bitbake-deve=
l/message/16523
> Mute This Topic: https://lists.openembedded.org/mt/108140370/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

