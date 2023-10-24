Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFAFC07545
	for <webhook@archiver.kernel.org>; Tue, 24 Oct 2023 10:44:48 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.15152.1698144279028252372
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Oct 2023 03:44:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XnO4xsGL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-32d8c2c6dfdso2771266f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Oct 2023 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1698144277; x=1698749077; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0pP6cxjejMwSFeiPOjf81rBiueAaZ7Y7uaSydqu+Oc=;
        b=XnO4xsGLiOmgujHFf6vpy3GZ3W9xOb2tHlleE51SlTs/1GKm0pJdsLfsoizTZOkLOi
         9EBBy/A8biAaGV3CjVzgBPhfnUkVm2lj3HC9WlJEIV1T4GKPf99awcGRYu9F+3cOJZfR
         49XKfbLfqCZZ3o7ccRbTX5XAASoJMje6dyTWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698144277; x=1698749077;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0pP6cxjejMwSFeiPOjf81rBiueAaZ7Y7uaSydqu+Oc=;
        b=VsxsDtFn4jy3mJiQ5Qg7UwHXLr2FOHNa8zJcagRA0BEceFZNi4+LZsU4KjF/eLYcz+
         rkTAK01gJu67SwDIS6/jWdQQwIxLCDBLZuqRSbwkdSeZ0Sg4MJPnUnweaLH6blImb7xB
         ikItrWz+S+2LMwo2ZjAypf4rp6/C59nP7zBxGGi4DMIF5Ca5feL99JFNdwvIXY4SwAgS
         s/0hE6o7NIpmsOy4OxwTXf6bEFzX+DJdMaXduldRMAS4uLz2XLPB4HNUFGcVQuOOGM16
         ZyV8r7dePu3N1RUr5vpXnAttwn9uEW/BDAalE4hhA8Z5nASvTwbwt8bj38urEbcFs3VL
         oZ2g==
X-Gm-Message-State: AOJu0YypDLBSw6W3pfeprDQjWMlgJ68Hlk6pSJSAs+29ffS2Uw7lLS6K
	H3LFMDWMRXHzdkzW2gFX1zbt6Q==
X-Google-Smtp-Source: AGHT+IFzZrm4smr/mEREMfvN9peAXtm2p6ybMZDGKkIDG0DlDQyHikMq9eXjtPYm76so6t23wzPY5Q==
X-Received: by 2002:a5d:6152:0:b0:31a:d9bc:47a2 with SMTP id y18-20020a5d6152000000b0031ad9bc47a2mr7277265wrt.53.1698144277346;
        Tue, 24 Oct 2023 03:44:37 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:18d6:7c14:536c:fd67? ([2001:8b0:aba:5f3c:18d6:7c14:536c:fd67])
        by smtp.gmail.com with ESMTPSA id dj18-20020a0560000b1200b0032d96dd703bsm9704726wrb.70.2023.10.24.03.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:44:37 -0700 (PDT)
Message-ID: <928101e5e266ca3ffc86bc8fb07a4a67ba51e938.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 1/2] codeparser/utils: clean up more
 deprecated AST usages
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org
Date: Tue, 24 Oct 2023 11:44:36 +0100
In-Reply-To: <20231023164613.1441846-1-chris.laplante@agilent.com>
References: <20231023164613.1441846-1-chris.laplante@agilent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Oct 2023 10:44:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15278

On Mon, 2023-10-23 at 12:46 -0400, Chris Laplante via
lists.openembedded.org wrote:
> From: Chris Laplante <chris.laplante@agilent.com>
>=20
> Also introduces bb.utils.ast_node_str_value method to simplify handling
> of AST str nodes.
>=20
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---
>  lib/bb/codeparser.py | 22 ++++++++++------------
>  lib/bb/utils.py      | 10 ++++++++++
>  2 files changed, 20 insertions(+), 12 deletions(-)
>=20
> diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
> index cd39409434..92ed31fa5f 100644
> --- a/lib/bb/codeparser.py
> +++ b/lib/bb/codeparser.py
> @@ -256,19 +256,18 @@ class PythonParser():
>      def visit_Call(self, node):
>          name =3D self.called_node_name(node.func)
>          if name and (name.endswith(self.getvars) or name.endswith(self.g=
etvarflags) or name in self.containsfuncs or name in self.containsanyfuncs)=
:
> -            if isinstance(node.args[0], ast.Constant) and isinstance(nod=
e.args[0].value, str):
> -                varname =3D node.args[0].value
> -                if name in self.containsfuncs and isinstance(node.args[1=
], ast.Str):
> +            if (varname :=3D bb.utils.ast_node_str_value(node.args[0])) =
is not None:
> +                if name in self.containsfuncs and bb.utils.ast_node_str_=
value(node.args[1]) is not None:

Personally, I really don't like condition tests modifying variables as
it can be easy to miss when reading the code. I therefore have a bit of
a preference for not doing that.

Perhaps it just takes time to get used to the new syntax, perhaps I'm
just old fashioned.


>                      if varname not in self.contains:
>                          self.contains[varname] =3D set()
> -                    self.contains[varname].add(node.args[1].s)
> -                elif name in self.containsanyfuncs and isinstance(node.a=
rgs[1], ast.Str):
> +                    self.contains[varname].add(node.args[1].value)
> +                elif name in self.containsanyfuncs and bb.utils.ast_node=
_str_value(node.args[1]) is not None:
>                      if varname not in self.contains:
>                          self.contains[varname] =3D set()
> -                    self.contains[varname].update(node.args[1].s.split()=
)
> +                    self.contains[varname].update(node.args[1].value.spl=
it())
>                  elif name.endswith(self.getvarflags):
> -                    if isinstance(node.args[1], ast.Str):
> -                        self.references.add('%s[%s]' % (varname, node.ar=
gs[1].s))
> +                    if bb.utils.ast_node_str_value(node.args[1]) is not =
None:
> +                        self.references.add('%s[%s]' % (varname, node.ar=
gs[1].value))
>                      else:
>                          self.warn(node.func, node.args[1])
>                  else:
> @@ -276,8 +275,7 @@ class PythonParser():
>              else:
>                  self.warn(node.func, node.args[0])
>          elif name and name.endswith(".expand"):
> -            if isinstance(node.args[0], ast.Str):
> -                value =3D node.args[0].s
> +            if (value :=3D bb.utils.ast_node_str_value(node.args[0])) is=
 not None:
>                  d =3D bb.data.init()
>                  parser =3D d.expandWithRefs(value, self.name)
>                  self.references |=3D parser.references
> @@ -287,8 +285,8 @@ class PythonParser():
>                          self.contains[varname] =3D set()
>                      self.contains[varname] |=3D parser.contains[varname]
>          elif name in self.execfuncs:
> -            if isinstance(node.args[0], ast.Str):
> -                self.var_execs.add(node.args[0].s)
> +            if bb.utils.ast_node_str_value(node.args[0]) is not None:
> +                self.var_execs.add(node.args[0].value)
>              else:
>                  self.warn(node.func, node.args[0])
>          elif name and isinstance(node.func, (ast.Name, ast.Attribute)):
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index b401fa5ec7..0ac304163c 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -11,6 +11,7 @@ import re, fcntl, os, string, stat, shutil, time
>  import sys
>  import errno
>  import logging
> +import ast
>  import bb
>  import bb.msg
>  import locale
> @@ -33,6 +34,7 @@ import random
>  import socket
>  import struct
>  import tempfile
> +from typing import Optional
>  from subprocess import getstatusoutput
>  from contextlib import contextmanager
>  from ctypes import cdll
> @@ -1863,3 +1865,11 @@ def lock_timeout(lock):
>          yield held
>      finally:
>          lock.release()
> +
> +def ast_node_str_value(node: ast.AST) -> Optional[str]:
> +    """
> +    Returns node value if it is an `ast.Constant` str; None otherwise
> +    """
> +    if isinstance(node, ast.Constant) and isinstance(node.value, str):
> +        return node.value
> +    return None

We were previously asked about adding typing and again I'm a little
unsure we want to do that. Personally, I think it looks horribly ugly
and I'm not convinced it buys us that much. I know others have other
opinions.

Whilst I am in theory bitbake's maintainer and in theory I can say no,
I know I'll get asked when we're converting everything time and time
again so again I'm really torn on this :/.

Cheers,

Richard



