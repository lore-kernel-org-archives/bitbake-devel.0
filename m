Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB74D5B86C
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 09:38:41 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.10863.1730281111476023171
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 02:38:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KgRq6ETo;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5111747cso60411201fa.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730281109; x=1730885909; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ON2axavwID1B0f/OaCXM0exuT7dOCNycS53TtNoQio=;
        b=KgRq6EToVV8vJf/jh/ZEbA+xqD19jh59B1yAaz4c0QAFN+XYDl3H8tXi6jAKSMyxW0
         ZY9D2OAEtrvURO+gm7/PEVDDBPonKEuceMPT2/KED3hVLXXAe5n56lHkExtl8VbMkn3v
         gz0hlMwqHCF2rX04xAk+EnprVwosYo1qkQJZzzdu/rDTmTvKVb3Ckm0tvZsOxSaZ9JkD
         +uUaViKH5WFTXvLSX15W5YNu444b51HNnGK2eTUfaUyq7zBALzXr2icDlOmBlXsPYYZM
         J/Nwza5APJymA8cza7kTuavI++E+QA6EQzmrM+RAwIHNiMgog15HKc5gpxIO0iz5xreh
         Tk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730281109; x=1730885909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ON2axavwID1B0f/OaCXM0exuT7dOCNycS53TtNoQio=;
        b=WJiW4cpC+et1Y4RjzedCHcYkUMWvFOQtQnlcI2QB+NcA41rmGWHGJu6c+OxRM7awvp
         pVzpix4riCjJXOWtHUs6YOJAKHkfBvAsy3XzXvc0Q1bZaEa0eJsDxcrhWyO33qnsh3aD
         DGgZsZKtWnYBFVYsyutTVPmbB7iR9gMJSkNTKqO9RYdCn9mXoA6GFPgeJ+3Of8YqrGA4
         RvXxKfFLBTyp2zTOmn1VsPUz0JXLOpzbRPlAYASGeog7zByAs7ZS5viOEAmbTOjv55uK
         3H00SJtOzW65b3s3UwwwyAcuzQ0Ef+hAU+WLyrALP7vTnxzi+J0XPpOq8yS7dDGSgCVS
         MzcQ==
X-Gm-Message-State: AOJu0YyJYPsEVFxfxM9ez3Bku+55WTIaYyo9CAB0UNpp+3yMK8w2Fwrj
	DI97jkGWseu7JzWHQ9l/U6gy1CdPUbEqtUsf/4tKhVhOYiuBi4dLL38NB8OOewti5Hi6Hl8OPRy
	LVl3yEfrDbQMgqjgPoq4pPioH4CQ=
X-Google-Smtp-Source: AGHT+IE498OGNl49y/ltrmLGYgbYpRyM2qOd4hKy0umdHeyjl8MYNulFOfe/6pwveqoALx1fS6cjujk38NWmkzVWfqs=
X-Received: by 2002:a2e:130a:0:b0:2fb:587d:310 with SMTP id
 38308e7fff4ca-2fcbe065a96mr56309181fa.30.1730281109205; Wed, 30 Oct 2024
 02:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241030091721.1598782-1-philip.lorenz@bmw.de>
In-Reply-To: <20241030091721.1598782-1-philip.lorenz@bmw.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 30 Oct 2024 10:38:18 +0100
Message-ID: <CANNYZj_M50TJAWxhUX7vGHAso0YdKdxfMsmp7d0H8zy230251Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] codeparser: Fix handling of string AST
 nodes with older Python versions
To: philip.lorenz@bmw.de
Cc: bitbake-devel@lists.openembedded.org, steve@sakoman.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:38:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16741

I guess this is only aimed for kirkstone? If so, you need to put
[kirkstone] in the subject.

Alex

On Wed, 30 Oct 2024 at 10:33, Philip Lorenz via lists.openembedded.org
<philip.lorenz=bmw.de@lists.openembedded.org> wrote:
>
> Commits 4591011449212c8e494ea42348acb2d27a82a51b and
> 6c19b6cf105ac321ec89da1a876a317020c45ab7 unconditionally changed
> codeparser to rely on CPython 3.8 semantics. However, kirkstone
> continues to support CPython versions >= 3.6.0 and as such string AST
> nodes were no longer correctly identified.
>
> Fix this by continuing to use `ast.Str` for Python versions < 3.8.0 and
> only using the new code path for more recent versions. Detecting which
> version of the AST API to use seems to be non-trivial so the Python
> feature version is used instead.
>
> Instances of this issue can be identified when executing bitbake with
> debug logging:
>
>     while parsing MACHINE_ARCH, in call of d.getVar, argument
>         ''TUNE_PKGARCH'' is not a string literal
>
> As a consequence of these parsing issues, bitbake may assume that task
> inputs haven't changed and as such erroneously reuse sstate objects when
> it shouldn't.
>
> Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
> ---
>  lib/bb/codeparser.py | 46 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 13 deletions(-)
>
> diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
> index 6ce0c5182..39dba266c 100644
> --- a/lib/bb/codeparser.py
> +++ b/lib/bb/codeparser.py
> @@ -201,6 +201,22 @@ class DummyLogger():
>      def flush(self):
>          return
>
> +
> +# Starting with Python 3.8, the ast module exposes all string nodes as a
> +# Constant. While earlier versions of the module also have the Constant type
> +# those use the Str type to encapsulate strings.
> +if sys.version_info < (3, 8):
> +    def node_str_value(node):
> +        if isinstance(node, ast.Str):
> +            return node.s
> +        return None
> +else:
> +    def node_str_value(node):
> +        if isinstance(node, ast.Constant) and isinstance(node.value, str):
> +            return node.value
> +        return None
> +
> +
>  class PythonParser():
>      getvars = (".getVar", ".appendVar", ".prependVar", "oe.utils.conditional")
>      getvarflags = (".getVarFlag", ".appendVarFlag", ".prependVarFlag")
> @@ -225,19 +241,22 @@ class PythonParser():
>      def visit_Call(self, node):
>          name = self.called_node_name(node.func)
>          if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs or name in self.containsanyfuncs):
> -            if isinstance(node.args[0], ast.Constant) and isinstance(node.args[0].value, str):
> -                varname = node.args[0].value
> -                if name in self.containsfuncs and isinstance(node.args[1], ast.Constant):
> +            varname = node_str_value(node.args[0])
> +            if varname is not None:
> +                arg_str_value = None
> +                if len(node.args) >= 2:
> +                    arg_str_value = node_str_value(node.args[1])
> +                if name in self.containsfuncs and arg_str_value is not None:
>                      if varname not in self.contains:
>                          self.contains[varname] = set()
> -                    self.contains[varname].add(node.args[1].value)
> -                elif name in self.containsanyfuncs and isinstance(node.args[1], ast.Constant):
> +                    self.contains[varname].add(arg_str_value)
> +                elif name in self.containsanyfuncs and arg_str_value is not None:
>                      if varname not in self.contains:
>                          self.contains[varname] = set()
> -                    self.contains[varname].update(node.args[1].value.split())
> +                    self.contains[varname].update(arg_str_value.split())
>                  elif name.endswith(self.getvarflags):
> -                    if isinstance(node.args[1], ast.Constant):
> -                        self.references.add('%s[%s]' % (varname, node.args[1].value))
> +                    if arg_str_value is not None:
> +                        self.references.add('%s[%s]' % (varname, arg_str_value))
>                      else:
>                          self.warn(node.func, node.args[1])
>                  else:
> @@ -245,10 +264,10 @@ class PythonParser():
>              else:
>                  self.warn(node.func, node.args[0])
>          elif name and name.endswith(".expand"):
> -            if isinstance(node.args[0], ast.Constant):
> -                value = node.args[0].value
> +            arg_str_value = node_str_value(node.args[0])
> +            if arg_str_value is not None:
>                  d = bb.data.init()
> -                parser = d.expandWithRefs(value, self.name)
> +                parser = d.expandWithRefs(arg_str_value, self.name)
>                  self.references |= parser.references
>                  self.execs |= parser.execs
>                  for varname in parser.contains:
> @@ -256,8 +275,9 @@ class PythonParser():
>                          self.contains[varname] = set()
>                      self.contains[varname] |= parser.contains[varname]
>          elif name in self.execfuncs:
> -            if isinstance(node.args[0], ast.Constant):
> -                self.var_execs.add(node.args[0].value)
> +            arg_str_value = node_str_value(node.args[0])
> +            if arg_str_value is not None:
> +                self.var_execs.add(arg_str_value)
>              else:
>                  self.warn(node.func, node.args[0])
>          elif name and isinstance(node.func, (ast.Name, ast.Attribute)):
> --
> 2.47.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16740): https://lists.openembedded.org/g/bitbake-devel/message/16740
> Mute This Topic: https://lists.openembedded.org/mt/109292959/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

