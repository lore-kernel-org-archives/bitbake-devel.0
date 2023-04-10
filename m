Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17635C77B61
	for <webhook@archiver.kernel.org>; Mon, 10 Apr 2023 09:43:39 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web10.41143.1681119812801963632
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Apr 2023 02:43:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=II0heS/p;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id c9so51382296lfb.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Apr 2023 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681119810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dbhgLGr2sCyNSzRsIo98RVFi+95REozFs9npxHnTN0g=;
        b=II0heS/pcWdPB0NLXL+Bi8u5kFB5veU6zz4rsQANSMputJEpp/sB7ZXT6WVVWqzWAn
         edj8bWlmKyT2EEQMl9XGnI2DtUrx3xZTvbsV43Q4D2HJ7836Gkp7MmPd8qcBsTT296qG
         zB6utdI4wdugJu1nDf6nSYv0m3/H5u6HVHjRQmxxJDX1ce19XdxgXxU3XJDYE/4CtgzG
         am+Heoyewg4aoMCLfMilsgj+omVLpVBRc8im/66s+Sz6eqQC0/OMHk/futTG9v/GIwLK
         nL0GXFtW0ExPwTMOUEyT50UHKmb6E2/3r3Cm2WsZpvJTUvt4Oi8AM2Qn3JiDhrUT6ZVn
         Ny3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681119810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbhgLGr2sCyNSzRsIo98RVFi+95REozFs9npxHnTN0g=;
        b=r0TaU5I5QiYVXfOWfHdQKUqnJzK8jQ36xUa4GqmUfCu+xVftX12uahEowstocSgMFI
         vTsF57L5CxqxVBKFiZhZ8y8ohl71YmBUCaWuS8Q28uttJjICdOqRD3bJiTbPNoTm5s4g
         JsGpvKpI5iix7ryfAbDGlhUHCaD8Xx4J+Mn961QmLnekg4RuJ9AvfrX4JT8h0pLneNC9
         vv/jZZdrYUB5hUhNOQrLx/luxsORcBU72TOWipZZ72BzpgeiAUmRR4vazvFn2Pprvhip
         CcHGMzLyQEqSGBXs9P1puNEHLTBRCjukK+uNCPAHR6/JtbNIcJEZvClG7EpfhPP+1rvV
         stNA==
X-Gm-Message-State: AAQBX9ffZd6ZjvCtH4BENZgVwDx8rI7wPfcjhqVYJHTXUgtAvk+uKjrg
	bcHdT8kC5xPDdrXXIW4/LuvsJcRlBk/XskLeX/JhVUtJ
X-Google-Smtp-Source: AKy350aRouOJIt6QvgzWKK2hgwStIjl0RLngmTDHsc3XIoia1xGcT8/ZCRwDib2n2PPxcEYcoBUcoLTIBaYfTUNEieE=
X-Received: by 2002:a19:ac07:0:b0:4ec:8aff:847f with SMTP id
 g7-20020a19ac07000000b004ec8aff847fmr554857lfc.12.1681119810136; Mon, 10 Apr
 2023 02:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230410091900.2897894-1-mingli.yu@eng.windriver.com>
In-Reply-To: <20230410091900.2897894-1-mingli.yu@eng.windriver.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Mon, 10 Apr 2023 11:43:18 +0200
Message-ID: <CA+cAkerDZ_d7HPh3V90OqZkPxVGsjRVX+CvUCDn3Kc7eY=Ospg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] event: add bb.event.ParseError
To: "Yu, Mingli" <mingli.yu@eng.windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000001bb03605f8f83598"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Apr 2023 09:43:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14688

--0000000000001bb03605f8f83598
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Apr 2023 at 11:19, Yu, Mingli <mingli.yu@eng.windriver.com>
wrote:

> From: Mingli Yu <mingli.yu@windriver.com>
>
> Add bb.event.ParseError to let error-report can catch this kind of error.
>
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
>  lib/bb/cooker.py | 6 ++++--
>  lib/bb/event.py  | 8 ++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 1797a1d4..206f8ffb 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -2223,7 +2223,7 @@ class CookerParser(object):
>
>              self.results = itertools.chain(self.results,
> self.parse_generator())
>
> -    def shutdown(self, clean=True):
> +    def shutdown(self, clean=True, eventmsg=""):
>          if not self.toparse:
>              return
>          if self.haveshutdown:
> @@ -2238,6 +2238,8 @@ class CookerParser(object):
>
>              bb.event.fire(event, self.cfgdata)
>          else:
> +            if eventmsg:
> +                bb.event.fire(bb.event.ParseError(eventmsg), self.cfgdata)
>              bb.error("Parsing halted due to errors, see error messages
> above")
>
>          # Cleanup the queue before call process.join(), otherwise there
> might be
> @@ -2355,7 +2357,7 @@ class CookerParser(object):
>          except bb.parse.ParseError as exc:
>              self.error += 1
>              logger.error(str(exc))
> -            self.shutdown(clean=False)
> +            self.shutdown(clean=False, eventmsg=str(exc))
>              return False
>          except bb.data_smart.ExpansionError as exc:
>              self.error += 1
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index 37cc630c..72393829 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -856,3 +856,11 @@ class FindSigInfoResult(Event):
>      def __init__(self, result):
>          Event.__init__(self)
>          self.result = result
> +
> +class ParseError(Event):
> +    """
> +    Event to indicate parse failed
> +    """
> +    def __init__(self, msg):
> +        Event.__init__(self)
> +        self._msg = msg
> --
> 2.25.1
>
>
Can't we just use super ?
super().__init__() instead of Event.__init__(self)
I didn't find a reference but I think it is a more pythonic way of calling
parent class.

--0000000000001bb03605f8f83598
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, 10 Apr 2023 at 11:19, Yu, Min=
gli &lt;<a href=3D"mailto:mingli.yu@eng.windriver.com">mingli.yu@eng.windri=
ver.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">From: Mingli Yu &lt;<a href=3D"mailto:mingli.yu@windriver.com" targe=
t=3D"_blank">mingli.yu@windriver.com</a>&gt;<br>
<br>
Add bb.event.ParseError to let error-report can catch this kind of error.<b=
r>
<br>
Signed-off-by: Mingli Yu &lt;<a href=3D"mailto:mingli.yu@windriver.com" tar=
get=3D"_blank">mingli.yu@windriver.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/cooker.py | 6 ++++--<br>
=C2=A0lib/bb/event.py=C2=A0 | 8 ++++++++<br>
=C2=A02 files changed, 12 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py<br>
index 1797a1d4..206f8ffb 100644<br>
--- a/lib/bb/cooker.py<br>
+++ b/lib/bb/cooker.py<br>
@@ -2223,7 +2223,7 @@ class CookerParser(object):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.results =3D itertools.=
chain(self.results, self.parse_generator())<br>
<br>
-=C2=A0 =C2=A0 def shutdown(self, clean=3DTrue):<br>
+=C2=A0 =C2=A0 def shutdown(self, clean=3DTrue, eventmsg=3D&quot;&quot;):<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.toparse:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.haveshutdown:<br>
@@ -2238,6 +2238,8 @@ class CookerParser(object):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.event.fire(event, self.c=
fgdata)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if eventmsg:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.event.fire(bb.e=
vent.ParseError(eventmsg), self.cfgdata)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.error(&quot;Parsing halt=
ed due to errors, see error messages above&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Cleanup the queue before call process.j=
oin(), otherwise there might be<br>
@@ -2355,7 +2357,7 @@ class CookerParser(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except bb.parse.ParseError as exc:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.error +=3D 1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error(str(exc))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.shutdown(clean=3DFalse)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.shutdown(clean=3DFalse, eve=
ntmsg=3Dstr(exc))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except bb.data_smart.ExpansionError as ex=
c:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.error +=3D 1<br>
diff --git a/lib/bb/event.py b/lib/bb/event.py<br>
index 37cc630c..72393829 100644<br>
--- a/lib/bb/event.py<br>
+++ b/lib/bb/event.py<br>
@@ -856,3 +856,11 @@ class FindSigInfoResult(Event):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, result):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Event.__init__(self)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result =3D result<br>
+<br>
+class ParseError(Event):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Event to indicate parse failed<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 def __init__(self, msg):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Event.__init__(self)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._msg =3D msg<br>
-- <br>
2.25.1<br><br></blockquote><div><br></div><div>Can&#39;t we just use super =
?</div><div>super().__init__() instead of Event.__init__(self)</div><div>I =
didn&#39;t find a reference but I think it is a more pythonic way of callin=
g parent class.</div><div><br></div></div></div>

--0000000000001bb03605f8f83598--

