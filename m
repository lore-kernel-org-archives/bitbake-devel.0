Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E715CC636D4
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 15:20:08 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.17760.1676474402814867815
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 07:20:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ANjGPXnu;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id s13so1793521wrw.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 07:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FPFhBVupcKJlD4o3qBU5jhbfQpZKEJcBUzSKRiPqjN0=;
        b=ANjGPXnur0GqfRRjiJIkRsuI23/KHApBp2PdF3La8lS2uBT3w8NNq8y0mqkwoBQIf4
         HC5o6BS9Zw4KfiYLosTg8IWgZ44qOAjDfXYq2OGSTpP2l6+Z/H7FLzYMBhAv7bPDSh9G
         wFnSaL5+wqSLgedTqVaPYY3tmn7R8sN9CjClhW+y1xygmsE1QM7ggLhtmq53pgvblwkZ
         uX36ia17pkqWoe0qiU/VmdThfbSeKMXBbgMGDjfB9CKXpmRK/MfOrAUxyZXCvTv3gcl9
         yKMYu/BADlMrBlbMuW4RbGZaOuQvzdDuFnNhwyrj4zf2tXo8LdZ51X0ftV0PIq9Ssqgw
         UKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPFhBVupcKJlD4o3qBU5jhbfQpZKEJcBUzSKRiPqjN0=;
        b=5ymyG9ElTwF0i72wZL8NjNvFS1C2bYZNw2q0fSgagZ6kMul7G1fAzRjkZRdwUdSbN2
         TZFHzT4la/+WtFCRBUQOWTR1k1bZzNAZJhZ5pW8C1muePwfluikvzh8kUxnJH+ZwpEKc
         9XwP+KWJ4t+nyTsA5sqoz6J1NHPCuvrERnZdcTXwXKqLv83a5ZpDNqlK5baMCp80jwBF
         fjLkFtZGD3QSVM7xeWmZXaT37zT4cSG/RQEpPLLMUrmwL0HR2ZWL1houxXgbA3ukt9L5
         s+ax9Zx9IZJfDqSTdUCAWYcTMdgk4d/JwC+/XtONVKd61Fi9jHRwXyMPN9F+LS4pX0gW
         gziQ==
X-Gm-Message-State: AO0yUKWihUoSaAEnWRG5qTIxglStltuZDHhBwU6lzy3NgsXWXXJEHDDa
	qiEfEorY2dckLxLegQVx9XD4kRVVDb5yZB5Vs34=
X-Google-Smtp-Source: AK7set+93rZS3V/ch7xa3fjXoLBGTM1UN/OkdYqAV+oDj357W2V6bYu+Iv767MgNSUC7XOlTLuRciyzKg21DFZTo664=
X-Received: by 2002:a5d:4202:0:b0:2c5:588b:a77d with SMTP id
 n2-20020a5d4202000000b002c5588ba77dmr66703wrq.697.1676474401073; Wed, 15 Feb
 2023 07:20:01 -0800 (PST)
MIME-Version: 1.0
References: <20221212160334.54431-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20221212160334.54431-1-richard.purdie@linuxfoundation.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 15 Feb 2023 16:19:47 +0100
Message-ID: <CA+chaQdrzVxHjKGPGSaoWxkr_pYShj5z9o8QFV5b585cG-9Z7g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] ast/data/codeparser: Add dependencies
 from python module functions
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000026adf005f4be9d54"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 15:20:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14434

--00000000000026adf005f4be9d54
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 12, 2022 at 5:03 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Moving code into python modules is a very effective way to reduce parsing
> time and overhead in recipes. The downside has always been that any
> dependency information on which variables those functions access is lost
> and the hashes can therefore become less reliable.
>
> This patch adds parsing of the imported module functions and that
> dependency
> information is them injected back into the hash dependency information.
>
> Intermodule function references are resolved to the full function
> call names in our module namespace to ensure interfunction dependencies
> are correctly handled too.
>
> (Bitbake rev: 605c478ce14cdc3c02d6ef6d57146a76d436a83c)
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
...

> diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> index 862087c77d..375ba3cb79 100644
> --- a/lib/bb/parse/ast.py
> +++ b/lib/bb/parse/ast.py
> @@ -290,6 +290,18 @@ class PyLibNode(AstNode):
>              toimport = getattr(bb.utils._context[self.namespace],
> "BBIMPORTS", [])
>              for i in toimport:
>                  bb.utils._context[self.namespace] =
> __import__(self.namespace + "." + i)
> +                mod = getattr(bb.utils._context[self.namespace], i)
> +                fn = getattr(mod, "__file__")
> +                funcs = {}
> +                for f in dir(mod):
> +                    if f.startswith("_"):
> +                        continue
> +                    fcall = getattr(mod, f)
> +                    if not callable(fcall):
> +                        continue
> +                    funcs[f] = fcall
> +                bb.codeparser.add_module_functions(fn, funcs, "%s.%s" %
> (self.namespace, i))
> +
>          except AttributeError as e:
>              bb.error("Error importing OE modules: %s" % str(e))
>

Hi,

a while ago I've mentioned that after making syntax error in metadata I got
no output at all from bitbake.

I've narrowed it down to this chunk and the issue is that my syntax error
was in qa.py and it was failing in:
bb.utils._context[self.namespace] = __import__(self.namespace + "." + i)

without any output from bitbake (nor bitbake-cookerdaemon.log).

If I add simple try-catch around this like:
-                bb.utils._context[self.namespace] =
__import__(self.namespace + "." + i)
+                try:
+                    bb.utils._context[self.namespace] =
__import__(self.namespace + "." + i)
+                except Exception as e:
+                    bb.error("Error importing OE module %s: %s" % (i,
str(e)))
+                    continue

Then I immediately get expected syntax error:
ERROR: Error importing OE module qa: invalid syntax (qa.py, line 229)
(followed by many errors about missing qa "Exception: AttributeError:
module 'oe' has no attribute 'qa'")

Where would be the right place to handle this?

If I break qa.py in langdale, I get reasonable error:
$ echo "def break()" >> oe-core/meta/lib/oe/qa.py
$ bitbake -k zlib-native
ERROR: Unable to parse Var <OE_IMPORTED[:=]>
Traceback (most recent call last):
  File "Var <OE_IMPORTED[:=]>", line 1, in <module>
  File
"/OE/lge/build/webos/langdale/oe-core/meta/classes-global/base.bbclass",
line 35, in oe_import(d=<bb.data_smart.DataSmart object at 0x7fa09b142790>):
                 # Make a python object accessible from the metadata
    >            bb.utils._context[toimport.split(".", 1)[0]] =
__import__(toimport)
             except AttributeError as e:
bb.data_smart.ExpansionError: Failure expanding variable OE_IMPORTED[:=],
expression was ${@oe_import(d)} which triggered exception SyntaxError:
expected ':' (qa.py, line 222)
The variable dependency chain for the failure is: OE_IMPORTED[:=]

with master:
$ time bitbake -DDDDDD -vvvvv zlib-native

real    0m0.564s
user    0m0.149s
sys     0m0.033s

--00000000000026adf005f4be9d54
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Dec 12, 2022 at 5:03 PM Richard P=
urdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.pur=
die@linuxfoundation.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Moving code into python m=
odules is a very effective way to reduce parsing<br>
time and overhead in recipes. The downside has always been that any<br>
dependency information on which variables those functions access is lost<br=
>
and the hashes can therefore become less reliable.<br>
<br>
This patch adds parsing of the imported module functions and that dependenc=
y<br>
information is them injected back into the hash dependency information.<br>
<br>
Intermodule function references are resolved to the full function<br>
call names in our module namespace to ensure interfunction dependencies<br>
are correctly handled too.<br>
<br>
(Bitbake rev: 605c478ce14cdc3c02d6ef6d57146a76d436a83c)<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r></blockquote><div>...=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py<br>
index 862087c77d..375ba3cb79 100644<br>
--- a/lib/bb/parse/ast.py<br>
+++ b/lib/bb/parse/ast.py<br>
@@ -290,6 +290,18 @@ class PyLibNode(AstNode):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0toimport =3D getattr(bb.uti=
ls._context[self.namespace], &quot;BBIMPORTS&quot;, [])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for i in toimport:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils._con=
text[self.namespace] =3D __import__(self.namespace + &quot;.&quot; + i)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod =3D getattr(bb=
.utils._context[self.namespace], i)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D getattr(mod=
, &quot;__file__&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 funcs =3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in dir(mod):=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if f=
.startswith(&quot;_&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fcal=
l =3D getattr(mod, f)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if n=
ot callable(fcall):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func=
s[f] =3D fcall<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.codeparser.add_=
module_functions(fn, funcs, &quot;%s.%s&quot; % (self.namespace, i))<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except AttributeError as e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.error(&quot;Error import=
ing OE modules: %s&quot; % str(e))<br></blockquote><div><br></div><div>Hi,<=
/div><div><br></div><div>a while ago I&#39;ve mentioned that after making s=
yntax error in metadata I got no output at all from bitbake.</div><div><br>=
</div><div>I&#39;ve narrowed it down to this chunk and the issue is that my=
 syntax error was in qa.py and it was failing in:</div><div>bb.utils._conte=
xt[self.namespace] =3D __import__(self.namespace + &quot;.&quot; + i)<br></=
div><div><br></div><div>without any output from bitbake (nor bitbake-cooker=
daemon.log).</div><div><br></div><div>If I add simple try-catch around this=
 like:</div><div>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b=
b.utils._context[self.namespace] =3D __import__(self.namespace + &quot;.&qu=
ot; + i)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb=
.utils._context[self.namespace] =3D __import__(self.namespace + &quot;.&quo=
t; + i)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except =
Exception as e:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bb.error(&quot;Error importing OE module %s: %s&quot; % (i=
, str(e)))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue<br></div><div><br></div><div>Then I immediately get expe=
cted syntax error:</div><div>ERROR: Error importing OE module qa: invalid s=
yntax (qa.py, line 229)</div><div>(followed by many errors about missing qa=
 &quot;Exception: AttributeError: module &#39;oe&#39; has no attribute &#39=
;qa&#39;&quot;)</div><div><br></div><div>Where would be the right place to =
handle this?</div><div><br></div><div>If I break qa.py in langdale, I get r=
easonable error:</div><div>$ echo &quot;def break()&quot; &gt;&gt; oe-core/=
meta/lib/oe/qa.py<br></div><div>$ bitbake -k zlib-native<br>ERROR: Unable t=
o parse Var &lt;OE_IMPORTED[:=3D]&gt;<br>Traceback (most recent call last):=
<br>=C2=A0 File &quot;Var &lt;OE_IMPORTED[:=3D]&gt;&quot;, line 1, in &lt;m=
odule&gt;<br>=C2=A0 File &quot;/OE/lge/build/webos/langdale/oe-core/meta/cl=
asses-global/base.bbclass&quot;, line 35, in oe_import(d=3D&lt;bb.data_smar=
t.DataSmart object at 0x7fa09b142790&gt;):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Make a python object accessible from th=
e metadata<br>=C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b=
b.utils._context[toimport.split(&quot;.&quot;, 1)[0]] =3D __import__(toimpo=
rt)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except AttributeErro=
r as e:<br>bb.data_smart.ExpansionError: Failure expanding variable OE_IMPO=
RTED[:=3D], expression was ${@oe_import(d)} which triggered exception Synta=
xError: expected &#39;:&#39; (qa.py, line 222)<br>The variable dependency c=
hain for the failure is: OE_IMPORTED[:=3D]<br></div><div><br></div><div>wit=
h master:</div><div>$ time bitbake -DDDDDD -vvvvv zlib-native<br><br>real =
=C2=A0 =C2=A00m0.564s<br>user =C2=A0 =C2=A00m0.149s<br>sys =C2=A0 =C2=A0 0m=
0.033s</div></div></div>

--00000000000026adf005f4be9d54--

