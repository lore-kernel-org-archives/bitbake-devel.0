Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
	[209.85.215.53])
	by mail.openembedded.org (Postfix) with ESMTP id A2A17608F7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 16:51:39 +0000 (UTC)
Received: by mail-la0-f53.google.com with SMTP id ea20so1598860lab.12
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=yrAGZCi8y72MZVwSDCe12Ob8cDfmOrS0/XymNnpdFjY=;
	b=u2KzeFe/mbgc9wad91iNXojbEeqNMUfi/7meeV9CQ21tGs4twp7rP3rQT8nBx5hSFk
	kDewfvFwlo2QoZsQU+wAgdWhKnuvtd/4TRyrNVoTvLQyB4jKeUC/ARUOLx7d3gZTXgKf
	2UaATzQq8XUywQPGySIfzAnryH7y3rNTVtxi6D9bMvOW1kgJ+fhsaIgzDc+nlBoJzYGA
	KXJ5tcMrfxJVs9zfov0JYW92XQhl7V5qYwXVHOXkgKHyjqZXF3oalLB2TrpynNYlZni1
	p8I57vICjRBlHvEQI57o7Ful+jsqUw23pLhXTK3N1Ivv5PJOX9NON5Q5mIDi1ycVAIZd
	Q8IA==
X-Received: by 10.112.185.104 with SMTP id fb8mr6401990lbc.9.1370019099254;
	Fri, 31 May 2013 09:51:39 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.4.66 with HTTP; Fri, 31 May 2013 09:51:19 -0700 (PDT)
In-Reply-To: <1370009954-14292-1-git-send-email-bogdan.a.marinescu@intel.com>
References: <1370009954-14292-1-git-send-email-bogdan.a.marinescu@intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 31 May 2013 09:51:19 -0700
X-Google-Sender-Auth: lmwXyquil5DraJX_lsyCz3wQvHo
Message-ID: <CABcZANm=WTC9e5QLepdt7im0mY++_g9a3fk0xvmJx3sKxpKp4w@mail.gmail.com>
To: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: add event masks
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 31 May 2013 16:51:40 -0000
Content-Type: multipart/alternative; boundary=001a11c3c9a4bf264f04de066d51

--001a11c3c9a4bf264f04de066d51
Content-Type: text/plain; charset=UTF-8

On Fri, May 31, 2013 at 7:19 AM, Bogdan Marinescu <
bogdan.a.marinescu@intel.com> wrote:

> Add more arguments to an "addhandler" command. Each argument (after the
> first one, which is the name of the handler) is the name of an event class
> that the handler wants to be notified on. "*" is a shortcut for "listen
> to all events". This changes the current behaviour of bitbake, which is
> to broadcast all events to all listeners; instead, only the handlers
> that registered themselves to an event with "addhandler" will receive
> that event. This should improve performance, although only performance
> measurements will be confirm or deny this claim.
> This is part of the fix for YOCTO #3812, but implements filtering only
> for class event handlers; the other part (events filter for UIs) will be
> the subject of a different patch.
>
> Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
>

Wouldn't it be simpler, as well as less invasive to the file format, to add
an 'event' or 'events' flag to the handler which indicates what events it
wishes to handle?
-- 
Christopher Larson

--001a11c3c9a4bf264f04de066d51
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On F=
ri, May 31, 2013 at 7:19 AM, Bogdan Marinescu <span dir=3D"ltr">&lt;<a href=
=3D"mailto:bogdan.a.marinescu@intel.com" target=3D"_blank">bogdan.a.marines=
cu@intel.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":2a" style=3D"overflow:hidden">Ad=
d more arguments to an &quot;addhandler&quot; command. Each argument (after=
 the<br>


first one, which is the name of the handler) is the name of an event class<=
br>
that the handler wants to be notified on. &quot;*&quot; is a shortcut for &=
quot;listen<br>
to all events&quot;. This changes the current behaviour of bitbake, which i=
s<br>
to broadcast all events to all listeners; instead, only the handlers<br>
that registered themselves to an event with &quot;addhandler&quot; will rec=
eive<br>
that event. This should improve performance, although only performance<br>
measurements will be confirm or deny this claim.<br>
This is part of the fix for YOCTO #3812, but implements filtering only<br>
for class event handlers; the other part (events filter for UIs) will be<br=
>
the subject of a different patch.<br>
<br>
Signed-off-by: Bogdan Marinescu &lt;<a href=3D"mailto:bogdan.a.marinescu@in=
tel.com">bogdan.a.marinescu@intel.com</a>&gt;</div></blockquote></div><br>W=
ouldn&#39;t it be simpler, as well as less invasive to the file format, to =
add an &#39;event&#39; or &#39;events&#39; flag to the handler which indica=
tes what events it wishes to handle?<br>

-- <br>Christopher Larson</div></div>

--001a11c3c9a4bf264f04de066d51--
