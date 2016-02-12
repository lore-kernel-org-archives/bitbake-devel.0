Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com
	[209.85.223.176])
	by mail.openembedded.org (Postfix) with ESMTP id 1F505602D9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Feb 2016 00:15:01 +0000 (UTC)
Received: by mail-io0-f176.google.com with SMTP id z135so6417353iof.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Feb 2016 16:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:content-type; bh=YNp+QkVqR5q8nm0m/KKINXLRPZ///jysV217RJitHLg=;
	b=uXGCRjCB3+75rkSH0RFvQ1/VSBUzMUr0FKCU6Bzrom3AJuPXCITx60+L+IiFDobLMB
	TtWItsFH6zO6uzWuqFs6HCraNwkjR8s93ZpXoGKx8i5KXeDVFvSGqtSStt3MvlpF0Pwz
	IPLUqI+i8L780FU1oeZpe34GDqfdqkpsnfnGCL/REOMMKXjamwZASfcQZZFIFMJvnuo/
	77mnQbf+mXwkOnhlAk1o0HYuHLIAnf8FvzkE7+MaxLve4rENVxP5FWhAkve+cE0HZEef
	/opnxio6SuGxXDmwm6FrAsFqQscWUUuaXUJYk5z8MO3oZsldSkxs4Vq9OnZzZqv9lgNv
	tbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:content-type;
	bh=YNp+QkVqR5q8nm0m/KKINXLRPZ///jysV217RJitHLg=;
	b=JAHsoDoRsXzCmWDofahqqJNrRK9Pp3bboaWCwmj9DS5UqYiZMd/XrWTX91Bbr/65hd
	WToQ6IoORkRWzeRSP+r8l+VidZv1t9RbOhhEct6V9IrqR7lwgBGnv8ejiuwg3dsn2pcU
	ZENuIWYBZOzt9CA6OJ4oWjLTk0MqKeMPE3pDrZfjhPhNrZaOrN5MBGQelh/kRyXzY2DB
	qAeucjI6jFg1RAtPnOCTMkLo4RCeYkBydkVD5fMrlVLH4ZbDugCpXzZduycz8Unje70F
	yVH+SqHkSpclxhqL8zINWbXhL5x/gcIw9dIjzSZ9+OcR9OFccuhGo0mqfQ8VIn2ohuZs
	iwyg==
X-Gm-Message-State: AG10YOSuTThS3TH1ccEp+ad+T7UxiOgp/FsLBPxJx+lROvlDt1KM/6VJV52CetcJjUxARJG4BFuaYHb5yM9wLw==
X-Received: by 10.107.34.133 with SMTP id i127mr50298103ioi.150.1455236102345; 
	Thu, 11 Feb 2016 16:15:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1455235936.git.chris_larson@mentor.com>
	<8a2dddd65c84e749e1af2e2d03175dd51b4f59b0.1455235936.git.chris_larson@mentor.com>
In-Reply-To: <8a2dddd65c84e749e1af2e2d03175dd51b4f59b0.1455235936.git.chris_larson@mentor.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Fri, 12 Feb 2016 00:14:53 +0000
Message-ID: <CABcZAN=1ayiRwCR7v5g=DrF-UQdBK86vdd+16vYjDQ=Y=G0tmg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 1/1] Move bb.{debug, note, ..} into their own logging domain
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
X-List-Received-Date: Fri, 12 Feb 2016 00:15:02 -0000
Content-Type: multipart/alternative; boundary=001a1140ef84f1f381052b878e20

--001a1140ef84f1f381052b878e20
Content-Type: text/plain; charset=UTF-8

On Thu, Feb 11, 2016 at 5:13 PM Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> This lets us filter and use -l to show messages from that source
> specifically.
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
>

This should have no user-visible effects, as it's still under the BitBake
main domain.

--001a1140ef84f1f381052b878e20
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Feb 11=
, 2016 at 5:13 PM Christopher Larson &lt;<a href=3D"mailto:kergoth@gmail.co=
m">kergoth@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>From: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor.com" ta=
rget=3D"_blank">chris_larson@mentor.com</a>&gt;<br>
<br>
This lets us filter and use -l to show messages from that source specifical=
ly.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com" target=3D"_blank">chris_larson@mentor.com</a>&gt;<br></blockquote><di=
v><br></div><div>This should have no user-visible effects, as it&#39;s stil=
l under the BitBake main domain.=C2=A0</div></div></div>

--001a1140ef84f1f381052b878e20--
