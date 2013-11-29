Return-Path: <alex.r.damian@gmail.com>
Received: from mail-qa0-f41.google.com (mail-qa0-f41.google.com
	[209.85.216.41])
	by mail.openembedded.org (Postfix) with ESMTP id 371846BEFB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2013 14:29:25 +0000 (UTC)
Received: by mail-qa0-f41.google.com with SMTP id j5so1882794qaq.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2013 06:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=XHRFjB9FqsamllWCEK9kbCMBfuYP/alQM7nckllAWZ0=;
	b=PBVWSLu0rcSg0PEEXSlUrVqxMmWsAXCXFOiPnircbzp9ToC3XgN5ClAqCUtntG6qBZ
	ySg+IPLx8H0mx99AG/OQnyQPq/YKV81rXla8eTNpw4rkUgWpuZ3HoQaHqqQsFH1zsqnx
	f3ROnRF8JAXyeeIdv4uMe4x5UNTcBYWTGscgW1uaM1jwcQ/g1+DPKtUy8r9jUkDulSoU
	q/eB+dxKEN6ML479iEY850E03XBoQMjxJcY4ESScJZ4ZW21UDVUz0adYaSkYVzPWvtiM
	4YY1SMyMVuwLenwlEBGFB37xCX4eTbLOr/d33fWmJcS2s5dBzxIj67no7anKSltq9vn5
	s6Ig==
MIME-Version: 1.0
X-Received: by 10.229.105.9 with SMTP id r9mr68198978qco.12.1385735363972;
	Fri, 29 Nov 2013 06:29:23 -0800 (PST)
Received: by 10.224.3.2 with HTTP; Fri, 29 Nov 2013 06:29:23 -0800 (PST)
In-Reply-To: <1385724682-2289-1-git-send-email-cristiana.voicu@intel.com>
References: <1385724682-2289-1-git-send-email-cristiana.voicu@intel.com>
Date: Fri, 29 Nov 2013 14:29:23 +0000
Message-ID: <CAL7ttbd2NN-bU6fcUwoRrVvaODbKiQ6ShGwC3rCGy-XUN5uYrw@mail.gmail.com>
From: Alex Damian <alex.r.damian@gmail.com>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: btibake server must reparse the conf between builds
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
X-List-Received-Date: Fri, 29 Nov 2013 14:29:25 -0000
Content-Type: multipart/alternative; boundary=001a113382b41f54df04ec51a80d

--001a113382b41f54df04ec51a80d
Content-Type: text/plain; charset=ISO-8859-1

Apart from the misspell in the subject, I really like this patch :).

Very creative, simple, straight to the point :)

Alex


On Fri, Nov 29, 2013 at 11:31 AM, Cristiana Voicu <cristiana.voicu@intel.com
> wrote:

> When the UI event handlers are registered, the cooker reset is
> triggered. In this way it doesn't affect the cooker state.
>
> [YOCTO #5535]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/server/xmlrpc.py |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/bitbake/lib/bb/server/xmlrpc.py
> b/bitbake/lib/bb/server/xmlrpc.py
> index 82c0e8d..fb7a8b4 100644
> --- a/bitbake/lib/bb/server/xmlrpc.py
> +++ b/bitbake/lib/bb/server/xmlrpc.py
> @@ -103,8 +103,9 @@ class BitBakeServerCommands():
>          for f in featureset:
>              self.cooker.featureset.setFeature(f)
>
> -        if (original_featureset != list(self.cooker.featureset)):
> -            self.cooker.reset()
> +        #always reset the cooker when a remote UI Event Handler is
> registered,
> +        #in order to reparse the configuration files
> +        self.cooker.reset()
>
>          self.event_handle = bb.event.register_UIHhandler(s)
>          return self.event_handle
> --
> 1.7.9.5
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--001a113382b41f54df04ec51a80d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Apart from the misspell in the subject, I really like=
 this patch :).<br><br></div><div>Very creative, simple, straight to the po=
int :)<br></div><div><br></div>Alex<br></div><div class=3D"gmail_extra"><br=
>
<br><div class=3D"gmail_quote">On Fri, Nov 29, 2013 at 11:31 AM, Cristiana =
Voicu <span dir=3D"ltr">&lt;<a href=3D"mailto:cristiana.voicu@intel.com" ta=
rget=3D"_blank">cristiana.voicu@intel.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
When the UI event handlers are registered, the cooker reset is<br>
triggered. In this way it doesn&#39;t affect the cooker state.<br>
<br>
[YOCTO #5535]<br>
Signed-off-by: Cristiana Voicu &lt;<a href=3D"mailto:cristiana.voicu@intel.=
com">cristiana.voicu@intel.com</a>&gt;<br>
---<br>
=A0bitbake/lib/bb/server/xmlrpc.py | =A0 =A05 +++--<br>
=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc=
.py<br>
index 82c0e8d..fb7a8b4 100644<br>
--- a/bitbake/lib/bb/server/xmlrpc.py<br>
+++ b/bitbake/lib/bb/server/xmlrpc.py<br>
@@ -103,8 +103,9 @@ class BitBakeServerCommands():<br>
=A0 =A0 =A0 =A0 =A0for f in featureset:<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0self.cooker.featureset.setFeature(f)<br>
<br>
- =A0 =A0 =A0 =A0if (original_featureset !=3D list(self.cooker.featureset))=
:<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.cooker.reset()<br>
+ =A0 =A0 =A0 =A0#always reset the cooker when a remote UI Event Handler is=
 registered,<br>
+ =A0 =A0 =A0 =A0#in order to reparse the configuration files<br>
+ =A0 =A0 =A0 =A0self.cooker.reset()<br>
<br>
=A0 =A0 =A0 =A0 =A0self.event_handle =3D bb.event.register_UIHhandler(s)<br=
>
=A0 =A0 =A0 =A0 =A0return self.event_handle<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.9.5<br>
<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l</a><br>
</font></span></blockquote></div><br></div>

--001a113382b41f54df04ec51a80d--
