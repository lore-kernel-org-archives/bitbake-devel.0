Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C305BC4345F
	for <webhook@archiver.kernel.org>; Wed, 17 Apr 2024 15:21:43 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.16166.1713367301699031654
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Apr 2024 08:21:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mZ1Aq4CQ;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso702977a91.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Apr 2024 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713367301; x=1713972101; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MjlZcleHFwQe7/QT9k0DxkXTyqDT8Al5C/OM9YsfVIU=;
        b=mZ1Aq4CQ90LPxDWghmIllqKnOo7t9Hy8PgfaZ7pXJbSM4ilLVoj9N9oRTQ2TPGsRa4
         Z+YZ1A5GA/R4WCTM1mZT7oXBnsPemj5gq8xXn0Oht7Vt8HFHlNaFWjTM5S4Z/NzllnvG
         Q5j3E4MxkO788e2cseFtuq4rY6q5q+kkZF6fUWyglsfINvYF1SPF3tVdusXJmLwlQdNK
         cOb16Yl5AODgfdz7mJAQIZrX2Qd+FeH6Xl0QkHsa8XjHlfej3tCEFDezLilh8lUZMo9h
         3vDvbTjD2qIMlfQ9giSxnWZetQIAfQ8ADJ7BdkG14t9ZRGMX+WaC98EQDIcogee7pyEy
         pKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713367301; x=1713972101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjlZcleHFwQe7/QT9k0DxkXTyqDT8Al5C/OM9YsfVIU=;
        b=PyKSjThYtDZBbxDUkaTLF3iNWHbDLHBs2R7HxoMnEU4gllS55hjYhxeNcQZuBJMpix
         QFQklzwh5I22k+co4HNrCtvKVtE5L2HZQxujJZfDPbDNVdlQP8FpmN/0d/R9N2Ijwr7u
         C4S8+TUfVR8lFJ5sPhrvMgR7E7POGGiDiSaAtJJSPAZZirVs9mGrrEGLiJIxeUi70xh5
         QsBkdL2ourHWJ+HxSEW1j0iMYXB03vfbiShoHjHAlzcLg5QHo/+IgeI7su1WsodzFUK3
         YOlAEO+L9QPM9XTlDOhyIzfm6G7ueDBFY9xMaWKs9BM1gjl6DHltJ5dg6DLzOUUmslHk
         guFA==
X-Gm-Message-State: AOJu0YyMfolyQXbjNcgMAk//+5W7IF6jED+ksjBohj7rgeK/PVdJ1JEk
	2RiyFolowdR6SBbtTpD+jcTbco0H6ZCsozY8ICjKQ5nDnHSqjCEz2uQMC+PNva0BIDUDl+ZCf5Z
	YPXcUKgVplyIRYcqxGkQj8sAFAF0=
X-Google-Smtp-Source: AGHT+IF3NcQKu6Rz/AV35QJ7yNoR9Eif2eRVduW97gUgD1vb8Kpb/slY6tkR0XZMNGNmPuzKzNqS5VxEKmj4V5qXydM=
X-Received: by 2002:a17:90a:6fe5:b0:2a9:e879:c83d with SMTP id
 e92-20020a17090a6fe500b002a9e879c83dmr8227460pjk.5.1713367300834; Wed, 17 Apr
 2024 08:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240412090234.4110915-1-michael.opdenacker@bootlin.com> <20240412090234.4110915-13-michael.opdenacker@bootlin.com>
In-Reply-To: <20240412090234.4110915-13-michael.opdenacker@bootlin.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Wed, 17 Apr 2024 11:21:29 -0400
Message-ID: <CADkTA4N9ZKKo1s7+THXd8AvO1CEvxYskNLGP5ji_Ly-2aP6wYw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 12/12] prserv: add "history" argument to
 "get-pr" request
To: michael.opdenacker@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Joshua Watt <JPEWhacker@gmail.com>, 
	Tim Orling <ticotimo@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000560c4506164c695c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Apr 2024 15:21:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16107

--000000000000560c4506164c695c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I can't say that I understand the difference between history and no-history
from
just reading this series .. but I realize it isn't something being added as
part of
this feature addition.

I just wanted to comment that from the name "history" alone, I can't figure
out what it is doing and how it impacts PR values.

Bruce

On Fri, Apr 12, 2024 at 5:02=E2=80=AFAM Michael Opdenacker via
lists.openembedded.org <michael.opdenacker=3D
bootlin.com@lists.openembedded.org> wrote:

> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> This makes it possible to test the "history" mode in the
> future bitbake selftests, to make sure that both "history"
> and "no history" modes work as expected.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Tim Orling <ticotimo@gmail.com>
> ---
>  lib/prserv/client.py |  4 ++--
>  lib/prserv/db.py     | 16 ++++++++--------
>  lib/prserv/serv.py   |  5 +++--
>  3 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/lib/prserv/client.py b/lib/prserv/client.py
> index 89760b6f74..389172f055 100644
> --- a/lib/prserv/client.py
> +++ b/lib/prserv/client.py
> @@ -14,9 +14,9 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
>      def __init__(self):
>          super().__init__("PRSERVICE", "1.0", logger)
>
> -    async def getPR(self, version, pkgarch, checksum):
> +    async def getPR(self, version, pkgarch, checksum, history=3DFalse):
>          response =3D await self.invoke(
> -            {"get-pr": {"version": version, "pkgarch": pkgarch,
> "checksum": checksum}}
> +            {"get-pr": {"version": version, "pkgarch": pkgarch,
> "checksum": checksum, "history": history}}
>          )
>          if response:
>              return response["value"]
> diff --git a/lib/prserv/db.py b/lib/prserv/db.py
> index 8305238f7a..d41b781622 100644
> --- a/lib/prserv/db.py
> +++ b/lib/prserv/db.py
> @@ -163,7 +163,7 @@ class PRTable(object):
>
>          self.dirty =3D True
>
> -    def _get_value(self, version, pkgarch, checksum):
> +    def _get_value(self, version, pkgarch, checksum, history):
>
>          max_value =3D self.find_max_value(version, pkgarch)
>
> @@ -177,7 +177,11 @@ class PRTable(object):
>              # version, pkgarch found but not checksum. Create a new valu=
e
> from the maximum one
>              return increase_revision(max_value)
>
> -        if self.nohist:
> +        if history:
> +            # "history" mode: we found an existing value. We can return =
it
> +            # whether it's the maximum one or not.
> +            return value
> +        else:
>              # "no-history" mode: only return a value if that's the
> maximum one for
>              # the version and architecture, otherwise create a new one.
>              # This means that the value cannot decrement.
> @@ -185,13 +189,9 @@ class PRTable(object):
>                  return value
>              else:
>                  return increase_revision(max_value)
> -        else:
> -            # "hist" mode: we found an existing value. We can return it
> -            # whether it's the maximum one or not.
> -            return value
>
> -    def get_value(self, version, pkgarch, checksum):
> -        value =3D self._get_value(version, pkgarch, checksum)
> +    def get_value(self, version, pkgarch, checksum, history):
> +        value =3D self._get_value(version, pkgarch, checksum, history)
>          self.store_value(version, pkgarch, checksum, value)
>          return value
>
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index 9e07a34445..f692d050b8 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -76,9 +76,10 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection=
):
>          version =3D request["version"]
>          pkgarch =3D request["pkgarch"]
>          checksum =3D request["checksum"]
> +        history =3D request["history"]
>
>          if self.upstream_client is None:
> -            value =3D self.server.table.get_value(version, pkgarch,
> checksum)
> +            value =3D self.server.table.get_value(version, pkgarch,
> checksum, history)
>              return {"value": value}
>
>          # We have an upstream server.
> @@ -105,7 +106,7 @@ class
> PRServerClient(bb.asyncrpc.AsyncServerConnection):
>              # The package is not known upstream, must be a local-only
> package
>              # Let's compute the PR number using the local-only method
>
> -            value =3D self.server.table.get_value(version, pkgarch,
> checksum)
> +            value =3D self.server.table.get_value(version, pkgarch,
> checksum, history)
>              return {"value": value}
>
>          # The package is known upstream, let's ask the upstream server
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16087):
> https://lists.openembedded.org/g/bitbake-devel/message/16087
> Mute This Topic: https://lists.openembedded.org/mt/105479102/1050810
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> bruce.ashfield@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--000000000000560c4506164c695c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">I c=
an&#39;t say that I understand the difference between history and no-histor=
y from</div><div class=3D"gmail_default" style=3D"font-size:small">just rea=
ding this series .. but I realize it isn&#39;t something being added as par=
t of</div><div class=3D"gmail_default" style=3D"font-size:small">this featu=
re addition.</div><div class=3D"gmail_default" style=3D"font-size:small"><b=
r></div><div class=3D"gmail_default" style=3D"font-size:small">I just wante=
d to comment that from the name &quot;history&quot; alone, I can&#39;t figu=
re</div><div class=3D"gmail_default" style=3D"font-size:small">out what it =
is doing and how it impacts PR values.</div><div class=3D"gmail_default" st=
yle=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"fon=
t-size:small">Bruce</div></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Fri, Apr 12, 2024 at 5:02=E2=80=AFAM Michael Op=
denacker via <a href=3D"http://lists.openembedded.org">lists.openembedded.o=
rg</a> &lt;michael.opdenacker=3D<a href=3D"mailto:bootlin.com@lists.openemb=
edded.org">bootlin.com@lists.openembedded.org</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">From: Michael Opdenacker &lt;<=
a href=3D"mailto:michael.opdenacker@bootlin.com" target=3D"_blank">michael.=
opdenacker@bootlin.com</a>&gt;<br>
<br>
This makes it possible to test the &quot;history&quot; mode in the<br>
future bitbake selftests, to make sure that both &quot;history&quot;<br>
and &quot;no history&quot; modes work as expected.<br>
<br>
Signed-off-by: Michael Opdenacker &lt;<a href=3D"mailto:michael.opdenacker@=
bootlin.com" target=3D"_blank">michael.opdenacker@bootlin.com</a>&gt;<br>
Cc: Thomas Petazzoni &lt;<a href=3D"mailto:thomas.petazzoni@bootlin.com" ta=
rget=3D"_blank">thomas.petazzoni@bootlin.com</a>&gt;<br>
Cc: Joshua Watt &lt;<a href=3D"mailto:JPEWhacker@gmail.com" target=3D"_blan=
k">JPEWhacker@gmail.com</a>&gt;<br>
Cc: Tim Orling &lt;<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">=
ticotimo@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/prserv/client.py |=C2=A0 4 ++--<br>
=C2=A0lib/prserv/db.py=C2=A0 =C2=A0 =C2=A0| 16 ++++++++--------<br>
=C2=A0lib/prserv/serv.py=C2=A0 =C2=A0|=C2=A0 5 +++--<br>
=C2=A03 files changed, 13 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/lib/prserv/client.py b/lib/prserv/client.py<br>
index 89760b6f74..389172f055 100644<br>
--- a/lib/prserv/client.py<br>
+++ b/lib/prserv/client.py<br>
@@ -14,9 +14,9 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().__init__(&quot;PRSERVICE&quot;, &=
quot;1.0&quot;, logger)<br>
<br>
-=C2=A0 =C2=A0 async def getPR(self, version, pkgarch, checksum):<br>
+=C2=A0 =C2=A0 async def getPR(self, version, pkgarch, checksum, history=3D=
False):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0response =3D await self.invoke(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;get-pr&quot;: {&quot;vers=
ion&quot;: version, &quot;pkgarch&quot;: pkgarch, &quot;checksum&quot;: che=
cksum}}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;get-pr&quot;: {&quot;vers=
ion&quot;: version, &quot;pkgarch&quot;: pkgarch, &quot;checksum&quot;: che=
cksum, &quot;history&quot;: history}}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if response:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return response[&quot;value=
&quot;]<br>
diff --git a/lib/prserv/db.py b/lib/prserv/db.py<br>
index 8305238f7a..d41b781622 100644<br>
--- a/lib/prserv/db.py<br>
+++ b/lib/prserv/db.py<br>
@@ -163,7 +163,7 @@ class PRTable(object):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.dirty =3D True<br>
<br>
-=C2=A0 =C2=A0 def _get_value(self, version, pkgarch, checksum):<br>
+=C2=A0 =C2=A0 def _get_value(self, version, pkgarch, checksum, history):<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max_value =3D self.find_max_value(version=
, pkgarch)<br>
<br>
@@ -177,7 +177,11 @@ class PRTable(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# version, pkgarch found bu=
t not checksum. Create a new value from the maximum one<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return increase_revision(ma=
x_value)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.nohist:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if history:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # &quot;history&quot; mode: we f=
ound an existing value. We can return it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # whether it&#39;s the maximum o=
ne or not.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return value<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# &quot;no-history&quot; mo=
de: only return a value if that&#39;s the maximum one for<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# the version and architect=
ure, otherwise create a new one.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# This means that the value=
 cannot decrement.<br>
@@ -185,13 +189,9 @@ class PRTable(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return value<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return increa=
se_revision(max_value)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # &quot;hist&quot; mode: we foun=
d an existing value. We can return it<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # whether it&#39;s the maximum o=
ne or not.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return value<br>
<br>
-=C2=A0 =C2=A0 def get_value(self, version, pkgarch, checksum):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D self._get_value(version, pkgarch, ch=
ecksum)<br>
+=C2=A0 =C2=A0 def get_value(self, version, pkgarch, checksum, history):<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D self._get_value(version, pkgarch, ch=
ecksum, history)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.store_value(version, pkgarch, checks=
um, value)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return value<br>
<br>
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py<br>
index 9e07a34445..f692d050b8 100644<br>
--- a/lib/prserv/serv.py<br>
+++ b/lib/prserv/serv.py<br>
@@ -76,9 +76,10 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version =3D request[&quot;version&quot;]<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgarch =3D request[&quot;pkgarch&quot;]<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checksum =3D request[&quot;checksum&quot;=
]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 history =3D request[&quot;history&quot;]<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.upstream_client is None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D self.server.table.get_=
value(version, pkgarch, checksum)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D self.server.table.get_=
value(version, pkgarch, checksum, history)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return {&quot;value&quot;: =
value}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# We have an upstream server.<br>
@@ -105,7 +106,7 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection)=
:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# The package is not known =
upstream, must be a local-only package<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Let&#39;s compute the PR =
number using the local-only method<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D self.server.table.get_=
value(version, pkgarch, checksum)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D self.server.table.get_=
value(version, pkgarch, checksum, history)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return {&quot;value&quot;: =
value}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# The package is known upstream, let&#39;=
s ask the upstream server<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16087): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16087" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16087</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/105479102/105=
0810" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/105479102/1050810</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:bruce.ashfield@gmail.com" target=
=3D"_blank">bruce.ashfield@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">- =
Thou shalt not follow the NULL pointer, for chaos and madness await thee at=
 its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star Trek II<br><b=
r></div>

--000000000000560c4506164c695c--

