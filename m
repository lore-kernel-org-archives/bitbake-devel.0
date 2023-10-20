Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89C6C0032E
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 23:29:22 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.68489.1697844557438951118
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Oct 2023 16:29:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=FOGa8bfO;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 567AB2000A;
	Fri, 20 Oct 2023 23:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697844555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wo/TUaqCBB2itchUzkibZXQI21V1uN6ResoNszpBnrw=;
	b=FOGa8bfOMrRqYmIfShf5iIkdCAiXmPhR0278cfkwnR6vx3p2vEJNeVUZc75ecpkCpdsHQr
	+K3fCbmEesj+M6qUdQ7oiMDWkNcXUTjZosQlj3appI+bT+jivSCtPoo59hHca6ulW73Taj
	FYkaaf0iNILwStwdvWMQt8mplhD82fJ3TiUqhvTxmIoXpRhHY3ynWiqE63rgeuA1E3ZSTZ
	5AKA8Bmz4lBDiZRHP11xkXtuXvuy+AsUWNsoSEdcDafMfYAigq2bl9XvKuV9HIwD3WWS4O
	y6YYwRz/GD+014i9whm1/3jMjjS9NI0sMtgxVlmUQdgXitL19huDRMkReU/3Rg==
Date: Sat, 21 Oct 2023 01:29:15 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: chris.laplante@agilent.com
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 2/3] codeparser/utils: clean up more
 deprecated AST usages
Message-ID: <20231020232915d8ce06bb@mail.local>
References: <20231020184459.1420806-1-chris.laplante@agilent.com>
 <20231020184459.1420806-2-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020184459.1420806-2-chris.laplante@agilent.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Oct 2023 23:29:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15272

Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/musl-qemux86/build/bitbake/bin/bitbake", line 21, in <module>
    import bb
  File "/home/pokybuild/yocto-worker/musl-qemux86/build/bitbake/lib/bb/__init__.py", line 137, in <module>
    import bb.msg
  File "/home/pokybuild/yocto-worker/musl-qemux86/build/bitbake/lib/bb/msg.py", line 20, in <module>
    import bb.event
  File "/home/pokybuild/yocto-worker/musl-qemux86/build/bitbake/lib/bb/event.py", line 23, in <module>
    import bb.utils
  File "/home/pokybuild/yocto-worker/musl-qemux86/build/bitbake/lib/bb/utils.py", line 1868, in <module>
    def ast_node_str_value(node: ast.AST) -> str | None:
TypeError: unsupported operand type(s) for |: 'type' and 'NoneType'

On 20/10/2023 14:44:58-0400, Chris Laplante via lists.openembedded.org wrote:
> From: Chris Laplante <chris.laplante@agilent.com>
> 
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---
>  lib/bb/codeparser.py | 22 ++++++++++------------
>  lib/bb/utils.py      |  9 +++++++++
>  2 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
> index cd39409434..92ed31fa5f 100644
> --- a/lib/bb/codeparser.py
> +++ b/lib/bb/codeparser.py
> @@ -256,19 +256,18 @@ class PythonParser():
>      def visit_Call(self, node):
>          name = self.called_node_name(node.func)
>          if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs or name in self.containsanyfuncs):
> -            if isinstance(node.args[0], ast.Constant) and isinstance(node.args[0].value, str):
> -                varname = node.args[0].value
> -                if name in self.containsfuncs and isinstance(node.args[1], ast.Str):
> +            if (varname := bb.utils.ast_node_str_value(node.args[0])) is not None:
> +                if name in self.containsfuncs and bb.utils.ast_node_str_value(node.args[1]) is not None:
>                      if varname not in self.contains:
>                          self.contains[varname] = set()
> -                    self.contains[varname].add(node.args[1].s)
> -                elif name in self.containsanyfuncs and isinstance(node.args[1], ast.Str):
> +                    self.contains[varname].add(node.args[1].value)
> +                elif name in self.containsanyfuncs and bb.utils.ast_node_str_value(node.args[1]) is not None:
>                      if varname not in self.contains:
>                          self.contains[varname] = set()
> -                    self.contains[varname].update(node.args[1].s.split())
> +                    self.contains[varname].update(node.args[1].value.split())
>                  elif name.endswith(self.getvarflags):
> -                    if isinstance(node.args[1], ast.Str):
> -                        self.references.add('%s[%s]' % (varname, node.args[1].s))
> +                    if bb.utils.ast_node_str_value(node.args[1]) is not None:
> +                        self.references.add('%s[%s]' % (varname, node.args[1].value))
>                      else:
>                          self.warn(node.func, node.args[1])
>                  else:
> @@ -276,8 +275,7 @@ class PythonParser():
>              else:
>                  self.warn(node.func, node.args[0])
>          elif name and name.endswith(".expand"):
> -            if isinstance(node.args[0], ast.Str):
> -                value = node.args[0].s
> +            if (value := bb.utils.ast_node_str_value(node.args[0])) is not None:
>                  d = bb.data.init()
>                  parser = d.expandWithRefs(value, self.name)
>                  self.references |= parser.references
> @@ -287,8 +285,8 @@ class PythonParser():
>                          self.contains[varname] = set()
>                      self.contains[varname] |= parser.contains[varname]
>          elif name in self.execfuncs:
> -            if isinstance(node.args[0], ast.Str):
> -                self.var_execs.add(node.args[0].s)
> +            if bb.utils.ast_node_str_value(node.args[0]) is not None:
> +                self.var_execs.add(node.args[0].value)
>              else:
>                  self.warn(node.func, node.args[0])
>          elif name and isinstance(node.func, (ast.Name, ast.Attribute)):
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index b401fa5ec7..55f8231999 100644
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
> @@ -1863,3 +1864,11 @@ def lock_timeout(lock):
>          yield held
>      finally:
>          lock.release()
> +
> +def ast_node_str_value(node: ast.AST) -> str | None:
> +    """
> +    Returns node value if it is an `ast.Constant` str; None otherwise
> +    """
> +    if isinstance(node, ast.Constant) and isinstance(node.value, str):
> +        return node.value
> +    return None
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15270): https://lists.openembedded.org/g/bitbake-devel/message/15270
> Mute This Topic: https://lists.openembedded.org/mt/102087479/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

