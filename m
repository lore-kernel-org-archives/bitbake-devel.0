Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com
	[209.85.223.169])
	by mail.openembedded.org (Postfix) with ESMTP id 49A2A602D9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Feb 2016 00:16:00 +0000 (UTC)
Received: by mail-io0-f169.google.com with SMTP id l127so75451015iof.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Feb 2016 16:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:content-type; bh=U2am9yaZ310IGFoXdJs/kxcRcIEnRmSj0DChmWQY2ho=;
	b=AGoN5fGeU2R0ZpZ0W8cC5VH1eL9N6dd7IGLM+P8RumPsbAWykLgsgBTU7YzU6OisBN
	6kHsfw1/GOjcJiZqEXmOb3iNgUkUPcKisJQB9zUz3Ob04LJBdNIb30NfQPyFZGkzKbhJ
	pgmVy5HnAZ9Sxr870DZS7Wri2h3qsxTEQXm7lSFHQ497orVyr9hjJL+L9PdTpYY0Ggka
	6YxpniAlV00atEER9H66yI3mBk0gdwyPFhZEi8xeYbX+MyaP9c9Xr0fCpq8UQ2hm0UH1
	AE68Oo2M4XHqOzKuyFJDX8L7tmK1rJbbjAGCYbEDVO7FDipeCQpgpj+msdwRBJv++8Si
	WNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:content-type;
	bh=U2am9yaZ310IGFoXdJs/kxcRcIEnRmSj0DChmWQY2ho=;
	b=CSJaAbtBagb/Gy0aVWJ/mcDFL2zR8/+DNqpn+1pAAf9ENtM7g+LlnbqOwexb2+QPIR
	unLoznv3PlwTuVX5Y+QoU/Fqk/kblDOno1QjrkYN4V2/twlrAMk8pdz5FrNEXfv7/1KL
	jeCpIMe0za1TFkzLcQdSefLlPTsjzP7yIiOkO9dJZGmowv5bwDsekIY26EuTjdkNxUJm
	Di4yaW8l064y2d0wVdEJ+E2Q/qPQwTqXK3QomvSFLyGf5CvjK2Ji4Ee+enJjD0+0FMHl
	WQWAHZH9XK2iK/6X+dg45BLbBZKBYHvmDRGfpMkhZyoqqMdegyW2GeA4kdyE+OOjO4h6
	GKJQ==
X-Gm-Message-State: AG10YOQ3wPiXsH0dgr41u6OVOi6lpTnY04bmvJ3slrVhDmXYp7l9GdLRu2L2QZj+yZGRd1ra58kFREuUo+OWgw==
X-Received: by 10.107.29.209 with SMTP id d200mr47422230iod.27.1455236161757; 
	Thu, 11 Feb 2016 16:16:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1455235907.git.chris_larson@mentor.com>
	<bfefd7e111665ad68f9c30a115cf307921561f7d.1455235907.git.chris_larson@mentor.com>
In-Reply-To: <bfefd7e111665ad68f9c30a115cf307921561f7d.1455235907.git.chris_larson@mentor.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Fri, 12 Feb 2016 00:15:52 +0000
Message-ID: <CABcZANkGAQohdYSYsotAyTShaCqDWz441WPUHHf6jF+5J8bP=Q@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 1/1] bb.ui.knotty: prefix task messages with recipe/task
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
X-List-Received-Date: Fri, 12 Feb 2016 00:16:01 -0000
Content-Type: multipart/alternative; boundary=001a11408e9e7c6bc0052b87920c

--001a11408e9e7c6bc0052b87920c
Content-Type: text/plain; charset=UTF-8

On Thu, Feb 11, 2016 at 5:13 PM Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> An example prefix: `perl-5.22.1-r0 do_compile:`
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
>

I realize this may well be something to do for 2.2 rather than 2.1, but I
wanted to throw it out and get thoughts on it, as I'm sick of manually
prefixing our log messages in tasks :)

--001a11408e9e7c6bc0052b87920c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Feb 11=
, 2016 at 5:13 PM Christopher Larson &lt;<a href=3D"mailto:kergoth@gmail.co=
m">kergoth@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>From: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor.com" ta=
rget=3D"_blank">chris_larson@mentor.com</a>&gt;<br>
<br>
An example prefix: `perl-5.22.1-r0 do_compile:`<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com" target=3D"_blank">chris_larson@mentor.com</a>&gt;<br></blockquote><di=
v><br></div><div>I realize this may well be something to do for 2.2 rather =
than 2.1, but I wanted to throw it out and get thoughts on it, as I&#39;m s=
ick of manually prefixing our log messages in tasks :)</div></div></div>

--001a11408e9e7c6bc0052b87920c--
