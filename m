Return-Path: <jacob.kroon@gmail.com>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
	[209.85.214.49])
	by mail.openembedded.org (Postfix) with ESMTP id 925FD620B7
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 15:53:23 +0000 (UTC)
Received: by mail-bk0-f49.google.com with SMTP id my13so647648bkb.36
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Apr 2014 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=+x3RuF+r0CwZkdlxmBJ1vBjrg53tXKbpldsoXgwiNh0=;
	b=LcSVbfd6B8VWQO5Ne7EgVTQ9bWwuPPaN+Qneeh1D59bbEEnXRe1k8Iqnu9a9UUJh0v
	QgomxbkYDLEqOxRsN1tXumR6+Dr23/w55pygLzn7fGENJQlf1J7jg6b75R/2Jqx59lBT
	ORPQjMuFwzMuJDsYlP8I43hQDyGoOVigGKEgKlQsDMXQ5/d2maQeA7KG7tdIsHh+XrjH
	X0im/pieh6OirxcP9RF0faRuQKSq9F2Fqgjdcggr49J4Mq5yIgRgJfSWBmN1kJIO9F1Q
	9LEB2ITSF/k8saD8z29bgSHt2R0W5/c3WoyJXwyuDul+8henUfQMXzya/qlDBGOeACyG
	rPEw==
MIME-Version: 1.0
X-Received: by 10.152.88.70 with SMTP id be6mr16872487lab.13.1396780746302;
	Sun, 06 Apr 2014 03:39:06 -0700 (PDT)
Received: by 10.112.53.73 with HTTP; Sun, 6 Apr 2014 03:39:06 -0700 (PDT)
In-Reply-To: <1396778902.24597.3.camel@ted>
References: <1396778902.24597.3.camel@ted>
Date: Sun, 6 Apr 2014 12:39:06 +0200
Message-ID: <CAPbeDCnEFRneQq7=uXtaW0EYGU8bUtG15Cmtico1fHYsQLeVWQ@mail.gmail.com>
From: Jacob Kroon <jacob.kroon@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: Fix bug in file checksum generation
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
X-List-Received-Date: Tue, 08 Apr 2014 15:53:25 -0000
Content-Type: multipart/alternative; boundary=001a11c2617636672504f65d5c0a

--001a11c2617636672504f65d5c0a
Content-Type: text/plain; charset=ISO-8859-1

Hi Richard,

diff --git a/bitbake/lib/bb/fetch2/__init__.py
b/bitbake/lib/bb/fetch2/__init__.py

> index 4335e7a..8e5342f 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -969,6 +969,7 @@ def get_file_checksums(filelist, pn):
>                  checksum = checksum_file(f)
>                  if checksum:
>                      checksums.append((f, checksum))
> +            continue
>          elif os.path.isdir(pth):
>              # Handle directories
>              for root, dirs, files in os.walk(pth):
> @@ -977,6 +978,7 @@ def get_file_checksums(filelist, pn):
>                      checksum = checksum_file(fullpth)
>                      if checksum:
>                          checksums.append((fullpth, checksum))
> +            continue
>          else:
>              checksum = checksum_file(pth)
>

Perhaps it would be cleaner to do

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 4335e7a..03ab234 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -979,9 +979,8 @@ def get_file_checksums(filelist, pn):
                         checksums.append((fullpth, checksum))
         else:
             checksum = checksum_file(pth)
-
-        if checksum:
-            checksums.append((pth, checksum))
+            if checksum:
+                checksums.append((pth, checksum))

     checksums.sort(key=operator.itemgetter(1))
     return checksums

or am I missing something here ?

/Jacob

--001a11c2617636672504f65d5c0a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard,<br><div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbak=
e/lib/bb/fetch2/__init__.py<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">

index 4335e7a..8e5342f 100644<br>
--- a/bitbake/lib/bb/fetch2/__init__.py<br>
+++ b/bitbake/lib/bb/fetch2/__init__.py<br>
@@ -969,6 +969,7 @@ def get_file_checksums(filelist, pn):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0checksum =3D checksum_file(f)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if checksum:<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0checksums.append((f, checksum))<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0continue<br>
=A0 =A0 =A0 =A0 =A0elif os.path.isdir(pth):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0# Handle directories<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0for root, dirs, files in os.walk(pth):<br>
@@ -977,6 +978,7 @@ def get_file_checksums(filelist, pn):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0checksum =3D checksum_file(fullp=
th)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if checksum:<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0checksums.append((fullpt=
h, checksum))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0continue<br>
=A0 =A0 =A0 =A0 =A0else:<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0checksum =3D checksum_file(pth)<span class=3D"">=
<font color=3D"#888888"></font></span><br></blockquote><div><br></div><div>=
Perhaps it would be cleaner to do <br><br>diff --git a/lib/bb/fetch2/__init=
__.py b/lib/bb/fetch2/__init__.py<br>
index 4335e7a..03ab234 100644<br>--- a/lib/bb/fetch2/__init__.py<br>+++ b/l=
ib/bb/fetch2/__init__.py<br>@@ -979,9 +979,8 @@ def get_file_checksums(file=
list, pn):<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 checksums.append((fullpth, checksum))<br>
=A0=A0=A0=A0=A0=A0=A0=A0 else:<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chec=
ksum =3D checksum_file(pth)<br>-<br>-=A0=A0=A0=A0=A0=A0=A0 if checksum:<br>=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 checksums.append((pth, checksum))<br>+=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if checksum:<br>+=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 checksums.append((pth, checksum))<br>
=A0<br>=A0=A0=A0=A0 checksums.sort(key=3Doperator.itemgetter(1))<br>=A0=A0=
=A0=A0 return checksums<br><br></div><div>or am I missing something here ?<=
br><br></div><div>/Jacob<br></div></div></div></div></div>

--001a11c2617636672504f65d5c0a--
