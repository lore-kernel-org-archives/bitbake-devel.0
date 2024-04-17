Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996C4C4345F
	for <webhook@archiver.kernel.org>; Wed, 17 Apr 2024 14:45:43 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.14952.1713365135958877663
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Apr 2024 07:45:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ijb6RZ3H;
 spf=pass (domain: gmail.com, ip: 209.85.214.175, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3c3aa8938so36205625ad.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Apr 2024 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713365135; x=1713969935; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yiHyPs80dbq6ZCCdjWilwLRzsKPLTjpMna39cQwRKZY=;
        b=ijb6RZ3HoqWM0WJ0EdiPbMYItbdmiZYvoNC2eCya/m6NSHs6xqwqQYN6z/sXRijgJj
         oS5c/VlRr4Ru5Frx9GWgqOtKaKfm3JUhKj0WKYTC+G1krzK7FAjuF+W8/4kBN30E6pAq
         ysU/JElAK4vbesEn+nOZL0SZnUyftaDUkh0u3iVHCXr4o3BbGCuwuiDRKUDhNIy0ftNs
         IPqTtc3FFHdFhwueH3mex6yLZ7458ijLCjF3gqd0XFcqBedQpUcRKFNSJFH16Xv1FuLE
         ln2c+Ofwtxegg7lNRYDlR/GUOP52tSOzR8kDjr4jQtx2+UFjtthAcRSkpUFNLVtWOn+/
         +YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365135; x=1713969935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiHyPs80dbq6ZCCdjWilwLRzsKPLTjpMna39cQwRKZY=;
        b=MEgOdEjYzWAqTgytX1LQyT/M75R+UrFSdQK1YSVPYXZw/vRZH5GiNm/pSaVR5ZhizD
         uU1U/gPkz2BoJMBSubji6mmo1RxqBY0o4EKpGOkyg48Fje3q1QGX5mPn49+XbvFRLEXr
         mrw+TXm0XGOcKd8bc0BK9utt7wuya2X7aY1ThwSNW0LktptCbOukXTzSgHDGtlPsLtZD
         SwmI9uc64uC+Fve/oSHQhoYUkgZbKXyEVnEt9Xbycyt5yJ2R/iTTO7c4iX4rqotYySLr
         QCFuSQffdZpw4HArUEowIwbsJPcdgN9a3JTuoTsGSK0z/YNmbMv32Y1YFmflBLnb9WMo
         nh3A==
X-Gm-Message-State: AOJu0Yy3/M7aoVbh+J0kKaL21oHIR+MC7fNtL8SFFQ3BJhz4fQHYTRV2
	eCHfNYse19loJ/BYmQAJoe+HvnxFFOpAQ65Z0Hg7Whtw+AkxY1Q7Y4XxcdFrxlTuk+WGjQ954qV
	+fACZySl8I7wVFZgfsDdPIrNBZ7E=
X-Google-Smtp-Source: AGHT+IEYYUZFmCzl3Rcbt8CcARkJmUyg9DaheRjWBIKfOBsREm/qeGYMgkJnIUtAfuPJAgCu3wB54aS3PRyOCHjQ4K8=
X-Received: by 2002:a17:902:7c96:b0:1e3:e380:8724 with SMTP id
 y22-20020a1709027c9600b001e3e3808724mr12745304pll.48.1713365135091; Wed, 17
 Apr 2024 07:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240412090234.4110915-1-michael.opdenacker@bootlin.com> <20240412090234.4110915-8-michael.opdenacker@bootlin.com>
In-Reply-To: <20240412090234.4110915-8-michael.opdenacker@bootlin.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Wed, 17 Apr 2024 10:45:23 -0400
Message-ID: <CADkTA4NE+x=P2UkN5VqheHRpinvZK7Oj=SMR3PfBcZOFza8owQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 07/12] prserv: add extra requests
To: michael.opdenacker@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>, 
	Tim Orling <ticotimo@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: multipart/alternative; boundary="0000000000003f737906164be83f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Apr 2024 14:45:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16105

--0000000000003f737906164be83f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 5:02=E2=80=AFAM Michael Opdenacker via
lists.openembedded.org <michael.opdenacker=3D
bootlin.com@lists.openembedded.org> wrote:

> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> Useful for connecting a PR server to an upstream one
>
> - "test-package" checks whether the specified package
>   version and arch is known in the database.
>
> - "test-pr" checks a specified output hash is found in the database.
>   Otherwise it returns 'None' instead of a new value.
>
> - "max-package-pr" returns the highest PR number for
>   (version, arch) entries in the database, and None if not found
>
> Add new DB functions supporting the above, plus test_value()
> which tells whether a given value is available for the specified
> package and architecture.
>

I always bounce around in my own code on whether I prefer
the "action" or the "object" to be more prominent in my method
naming.

i.e. pr_get or get_pr

I tend to land on pr_get() -style most of the time.

That being said, your routines match up wth the existing style
so my comment is literally that .. commentary. And I have no
concerns with the change.

Reviewed-by: Bruce Ashfield <bruce.ashfield@gmail.com>



>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Tim Orling <ticotimo@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  lib/prserv/client.py | 23 +++++++++++++++++++++-
>  lib/prserv/db.py     | 46 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/prserv/serv.py   | 28 +++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/lib/prserv/client.py b/lib/prserv/client.py
> index 7bc5188c53..8471ee3046 100644
> --- a/lib/prserv/client.py
> +++ b/lib/prserv/client.py
> @@ -20,6 +20,27 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
>          if response:
>              return response["value"]
>
> +    async def test_pr(self, version, pkgarch, checksum):
> +        response =3D await self.invoke(
> +            {"test-pr": {"version": version, "pkgarch": pkgarch,
> "checksum": checksum}}
> +        )
> +        if response:
> +            return response["value"]
> +
> +    async def test_package(self, version, pkgarch):
> +        response =3D await self.invoke(
> +            {"test-package": {"version": version, "pkgarch": pkgarch}}
> +        )
> +        if response:
> +            return response["value"]
> +
> +    async def max_package_pr(self, version, pkgarch):
> +        response =3D await self.invoke(
> +            {"max-package-pr": {"version": version, "pkgarch": pkgarch}}
> +        )
> +        if response:
> +            return response["value"]
> +
>      async def importone(self, version, pkgarch, checksum, value):
>          response =3D await self.invoke(
>              {"import-one": {"version": version, "pkgarch": pkgarch,
> "checksum": checksum, "value": value}}
> @@ -44,7 +65,7 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
>  class PRClient(bb.asyncrpc.Client):
>      def __init__(self):
>          super().__init__()
> -        self._add_methods("getPR", "importone", "export", "is_readonly")
> +        self._add_methods("getPR", "test_pr", "test_package",
> "importone", "export", "is_readonly")
>
>      def _get_async_client(self):
>          return PRAsyncClient()
> diff --git a/lib/prserv/db.py b/lib/prserv/db.py
> index 7bc2b2dc2d..7c200602ed 100644
> --- a/lib/prserv/db.py
> +++ b/lib/prserv/db.py
> @@ -78,6 +78,52 @@ class PRTable(object):
>              self.sync()
>              self.dirty =3D False
>
> +    def test_package(self, version, pkgarch):
> +        """Returns whether the specified package version is found in the
> database for the specified architecture"""
> +
> +        # Just returns the value if found or None otherwise
> +        data=3Dself._execute("SELECT value FROM %s WHERE version=3D? AND
> pkgarch=3D?;" % self.table,
> +                           (version, pkgarch))
> +        row=3Ddata.fetchone()
> +        if row is not None:
> +            return True
> +        else:
> +            return False
> +
> +    def test_value(self, version, pkgarch, value):
> +        """Returns whether the specified value is found in the database
> for the specified package and architecture"""
> +
> +        # Just returns the value if found or None otherwise
> +        data=3Dself._execute("SELECT value FROM %s WHERE version=3D? AND
> pkgarch=3D? and value=3D?;" % self.table,
> +                           (version, pkgarch, value))
> +        row=3Ddata.fetchone()
> +        if row is not None:
> +            return True
> +        else:
> +            return False
> +
> +    def find_value(self, version, pkgarch, checksum):
> +        """Returns the value for the specified checksum if found or None
> otherwise."""
> +
> +        data=3Dself._execute("SELECT value FROM %s WHERE version=3D? AND
> pkgarch=3D? AND checksum=3D?;" % self.table,
> +                           (version, pkgarch, checksum))
> +        row=3Ddata.fetchone()
> +        if row is not None:
> +            return row[0]
> +        else:
> +            return None
> +
> +    def find_max_value(self, version, pkgarch):
> +        """Returns the greatest value for (version, pkgarch), or None if
> not found. Doesn't create a new value"""
> +
> +        data =3D self._execute("SELECT max(value) FROM %s where version=
=3D?
> AND pkgarch=3D?;" % (self.table),
> +                             (version, pkgarch))
> +        row =3D data.fetchone()
> +        if row is not None:
> +            return row[0]
> +        else:
> +            return None
> +
>      def _get_value_hist(self, version, pkgarch, checksum):
>          data=3Dself._execute("SELECT value FROM %s WHERE version=3D? AND
> pkgarch=3D? AND checksum=3D?;" % self.table,
>                             (version, pkgarch, checksum))
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index efb2e0cf93..86bd3bb75f 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -26,6 +26,9 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection)=
:
>
>          self.handlers.update({
>              "get-pr": self.handle_get_pr,
> +            "test-pr": self.handle_test_pr,
> +            "test-package": self.handle_test_package,
> +            "max-package-pr": self.handle_max_package_pr,
>              "import-one": self.handle_import_one,
>              "export": self.handle_export,
>              "is-readonly": self.handle_is_readonly,
> @@ -43,6 +46,31 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection=
):
>          else:
>              self.server.table.sync_if_dirty()
>
> +    async def handle_test_pr(self, request):
> +        '''Finds the PR value corresponding to the request. If not found=
,
> returns None and doesn't insert a new value'''
> +        version =3D request["version"]
> +        pkgarch =3D request["pkgarch"]
> +        checksum =3D request["checksum"]
> +
> +        value =3D self.server.table.find_value(version, pkgarch, checksu=
m)
> +        return {"value": value}
> +
> +    async def handle_test_package(self, request):
> +        '''Tells whether there are entries for (version, pkgarch) in the
> db. Returns True or False'''
> +        version =3D request["version"]
> +        pkgarch =3D request["pkgarch"]
> +
> +        value =3D self.server.table.test_package(version, pkgarch)
> +        return {"value": value}
> +
> +    async def handle_max_package_pr(self, request):
> +        '''Finds the greatest PR value for (version, pkgarch) in the db.
> Returns None if no entry was found'''
> +        version =3D request["version"]
> +        pkgarch =3D request["pkgarch"]
> +
> +        value =3D self.server.table.find_max_value(version, pkgarch)
> +        return {"value": value}
> +
>      async def handle_get_pr(self, request):
>          version =3D request["version"]
>          pkgarch =3D request["pkgarch"]
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16081):
> https://lists.openembedded.org/g/bitbake-devel/message/16081
> Mute This Topic: https://lists.openembedded.org/mt/105479094/1050810
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

--0000000000003f737906164be83f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Apr 12, 2024 at 5:02=E2=80=AFAM Michael Opd=
enacker via <a href=3D"http://lists.openembedded.org">lists.openembedded.or=
g</a> &lt;michael.opdenacker=3D<a href=3D"mailto:bootlin.com@lists.openembe=
dded.org">bootlin.com@lists.openembedded.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">From: Michael Opdenacker &lt;<a=
 href=3D"mailto:michael.opdenacker@bootlin.com" target=3D"_blank">michael.o=
pdenacker@bootlin.com</a>&gt;<br>
<br>
Useful for connecting a PR server to an upstream one<br>
<br>
- &quot;test-package&quot; checks whether the specified package<br>
=C2=A0 version and arch is known in the database.<br>
<br>
- &quot;test-pr&quot; checks a specified output hash is found in the databa=
se.<br>
=C2=A0 Otherwise it returns &#39;None&#39; instead of a new value.<br>
<br>
- &quot;max-package-pr&quot; returns the highest PR number for<br>
=C2=A0 (version, arch) entries in the database, and None if not found<br>
<br>
Add new DB functions supporting the above, plus test_value()<br>
which tells whether a given value is available for the specified<br>
package and architecture.<br></blockquote><div><br></div><div><div class=3D=
"gmail_default" style=3D"font-size:small">I always bounce around in my own =
code on whether I prefer</div><div class=3D"gmail_default" style=3D"font-si=
ze:small">the &quot;action&quot; or the &quot;object&quot; to be more promi=
nent in my method</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">naming.</div><div class=3D"gmail_default" style=3D"font-size:small"><br>=
</div><div class=3D"gmail_default" style=3D"font-size:small">i.e. pr_get or=
 get_pr</div><div class=3D"gmail_default" style=3D"font-size:small"><br></d=
iv><div class=3D"gmail_default" style=3D"font-size:small">I tend to land on=
 pr_get() -style most of the time.</div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small">That being said, your routines match up wth=C2=A0the existing st=
yle</div><div class=3D"gmail_default" style=3D"font-size:small">so my comme=
nt is literally that .. commentary. And I have no</div><div class=3D"gmail_=
default" style=3D"font-size:small">concerns with the change.</div><div clas=
s=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail=
_default" style=3D"font-size:small">Reviewed-by: Bruce Ashfield &lt;<a href=
=3D"mailto:bruce.ashfield@gmail.com">bruce.ashfield@gmail.com</a>&gt;</div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
Signed-off-by: Michael Opdenacker &lt;<a href=3D"mailto:michael.opdenacker@=
bootlin.com" target=3D"_blank">michael.opdenacker@bootlin.com</a>&gt;<br>
Cc: Joshua Watt &lt;<a href=3D"mailto:JPEWhacker@gmail.com" target=3D"_blan=
k">JPEWhacker@gmail.com</a>&gt;<br>
Cc: Tim Orling &lt;<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">=
ticotimo@gmail.com</a>&gt;<br>
Cc: Thomas Petazzoni &lt;<a href=3D"mailto:thomas.petazzoni@bootlin.com" ta=
rget=3D"_blank">thomas.petazzoni@bootlin.com</a>&gt;<br>
---<br>
=C2=A0lib/prserv/client.py | 23 +++++++++++++++++++++-<br>
=C2=A0lib/prserv/db.py=C2=A0 =C2=A0 =C2=A0| 46 ++++++++++++++++++++++++++++=
++++++++++++++++<br>
=C2=A0lib/prserv/serv.py=C2=A0 =C2=A0| 28 +++++++++++++++++++++++++++<br>
=C2=A03 files changed, 96 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/prserv/client.py b/lib/prserv/client.py<br>
index 7bc5188c53..8471ee3046 100644<br>
--- a/lib/prserv/client.py<br>
+++ b/lib/prserv/client.py<br>
@@ -20,6 +20,27 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if response:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return response[&quot;value=
&quot;]<br>
<br>
+=C2=A0 =C2=A0 async def test_pr(self, version, pkgarch, checksum):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 response =3D await self.invoke(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;test-pr&quot;: {&quot;ver=
sion&quot;: version, &quot;pkgarch&quot;: pkgarch, &quot;checksum&quot;: ch=
ecksum}}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if response:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return response[&quot;value&quot=
;]<br>
+<br>
+=C2=A0 =C2=A0 async def test_package(self, version, pkgarch):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 response =3D await self.invoke(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;test-package&quot;: {&quo=
t;version&quot;: version, &quot;pkgarch&quot;: pkgarch}}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if response:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return response[&quot;value&quot=
;]<br>
+<br>
+=C2=A0 =C2=A0 async def max_package_pr(self, version, pkgarch):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 response =3D await self.invoke(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;max-package-pr&quot;: {&q=
uot;version&quot;: version, &quot;pkgarch&quot;: pkgarch}}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if response:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return response[&quot;value&quot=
;]<br>
+<br>
=C2=A0 =C2=A0 =C2=A0async def importone(self, version, pkgarch, checksum, v=
alue):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0response =3D await self.invoke(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;import-one&quot;: {&=
quot;version&quot;: version, &quot;pkgarch&quot;: pkgarch, &quot;checksum&q=
uot;: checksum, &quot;value&quot;: value}}<br>
@@ -44,7 +65,7 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):<br>
=C2=A0class PRClient(bb.asyncrpc.Client):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().__init__()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._add_methods(&quot;getPR&quot;, &quot;imp=
ortone&quot;, &quot;export&quot;, &quot;is_readonly&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._add_methods(&quot;getPR&quot;, &quot;tes=
t_pr&quot;, &quot;test_package&quot;, &quot;importone&quot;, &quot;export&q=
uot;, &quot;is_readonly&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _get_async_client(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PRAsyncClient()<br>
diff --git a/lib/prserv/db.py b/lib/prserv/db.py<br>
index 7bc2b2dc2d..7c200602ed 100644<br>
--- a/lib/prserv/db.py<br>
+++ b/lib/prserv/db.py<br>
@@ -78,6 +78,52 @@ class PRTable(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.sync()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.dirty =3D False<br>
<br>
+=C2=A0 =C2=A0 def test_package(self, version, pkgarch):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns whether the specifie=
d package version is found in the database for the specified architecture&q=
uot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Just returns the value if found or None othe=
rwise<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data=3Dself._execute(&quot;SELECT value FROM %=
s WHERE version=3D? AND pkgarch=3D?;&quot; % self.table,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(version, pkgarch))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 row=3Ddata.fetchone()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if row is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
+<br>
+=C2=A0 =C2=A0 def test_value(self, version, pkgarch, value):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns whether the specifie=
d value is found in the database for the specified package and architecture=
&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Just returns the value if found or None othe=
rwise<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data=3Dself._execute(&quot;SELECT value FROM %=
s WHERE version=3D? AND pkgarch=3D? and value=3D?;&quot; % self.table,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(version, pkgarch, value))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 row=3Ddata.fetchone()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if row is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
+<br>
+=C2=A0 =C2=A0 def find_value(self, version, pkgarch, checksum):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the value for the sp=
ecified checksum if found or None otherwise.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data=3Dself._execute(&quot;SELECT value FROM %=
s WHERE version=3D? AND pkgarch=3D? AND checksum=3D?;&quot; % self.table,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(version, pkgarch, checksum))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 row=3Ddata.fetchone()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if row is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return row[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
+<br>
+=C2=A0 =C2=A0 def find_max_value(self, version, pkgarch):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the greatest value f=
or (version, pkgarch), or None if not found. Doesn&#39;t create a new value=
&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D self._execute(&quot;SELECT max(value)=
 FROM %s where version=3D? AND pkgarch=3D?;&quot; % (self.table),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(version, pkgarch))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 row =3D data.fetchone()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if row is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return row[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def _get_value_hist(self, version, pkgarch, checksum):<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data=3Dself._execute(&quot;SELECT value F=
ROM %s WHERE version=3D? AND pkgarch=3D? AND checksum=3D?;&quot; % self.tab=
le,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (version, pkgarch, checksum))<br>
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py<br>
index efb2e0cf93..86bd3bb75f 100644<br>
--- a/lib/prserv/serv.py<br>
+++ b/lib/prserv/serv.py<br>
@@ -26,6 +26,9 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.handlers.update({<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;get-pr&quot;: self.ha=
ndle_get_pr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;test-pr&quot;: self.handle=
_test_pr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;test-package&quot;: self.h=
andle_test_package,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;max-package-pr&quot;: self=
.handle_max_package_pr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;import-one&quot;: sel=
f.handle_import_one,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;export&quot;: self.ha=
ndle_export,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;is-readonly&quot;: se=
lf.handle_is_readonly,<br>
@@ -43,6 +46,31 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.server.table.sync_if_d=
irty()<br>
<br>
+=C2=A0 =C2=A0 async def handle_test_pr(self, request):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&#39;&#39;Finds the PR value correspondin=
g to the request. If not found, returns None and doesn&#39;t insert a new v=
alue&#39;&#39;&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 version =3D request[&quot;version&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarch =3D request[&quot;pkgarch&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 checksum =3D request[&quot;checksum&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D self.server.table.find_value(version=
, pkgarch, checksum)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return {&quot;value&quot;: value}<br>
+<br>
+=C2=A0 =C2=A0 async def handle_test_package(self, request):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&#39;&#39;Tells whether there are entries=
 for (version, pkgarch) in the db. Returns True or False&#39;&#39;&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 version =3D request[&quot;version&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarch =3D request[&quot;pkgarch&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D self.server.table.test_package(versi=
on, pkgarch)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return {&quot;value&quot;: value}<br>
+<br>
+=C2=A0 =C2=A0 async def handle_max_package_pr(self, request):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&#39;&#39;Finds the greatest PR value for=
 (version, pkgarch) in the db. Returns None if no entry was found&#39;&#39;=
&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 version =3D request[&quot;version&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarch =3D request[&quot;pkgarch&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D self.server.table.find_max_value(ver=
sion, pkgarch)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return {&quot;value&quot;: value}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0async def handle_get_pr(self, request):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version =3D request[&quot;version&quot;]<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgarch =3D request[&quot;pkgarch&quot;]<=
br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16081): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16081" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16081</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/105479094/105=
0810" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/105479094/1050810</a><br>
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
r></div></div>

--0000000000003f737906164be83f--

