Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Tjcp6-0000uc-Nc
	for bitbake-devel@lists.openembedded.org;
	Fri, 14 Dec 2012 22:29:37 +0100
Received: by mail-lb0-f175.google.com with SMTP id gg13so3181918lbb.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2012 13:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=BT3BmOQIWMKxsmVWZgBXQe2ktb5x8x9IJ0tfwhMVxPY=;
	b=JVO0xASsttVgTRZ7qYpMtDVuXRS/dS4w2DoFMg3bfw2yvLUYYDp8IR06CznnC5WjuP
	yYEzErxmLHsWURzfHjRSmIB1SfaggnmvkzwGiJYEjRQBQw8d+TgYGhZckNQvbD6MqCXQ
	pID/3kHTSbpXIBqYf32Sn8NPjTtMxw8U2I5j197SdrmAaHA9Mr7/Y/TzgrHyONtcG9ph
	4G336idpNeXNzqX0a4K+8wIYk8E0ex7VymEUhzU5kHv0EYwSYZWlPV2kwa8FJwOWAw/k
	odIjPjmjzg2ehRWYpUNaFDM7Q9RI+9TmKsRO8QVgJoZiCUPc+LVz2b3W4TQariweNcGW
	6MNA==
Received: by 10.152.111.41 with SMTP id if9mr3780428lab.23.1355519700026; Fri,
	14 Dec 2012 13:15:00 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Fri, 14 Dec 2012 13:14:39 -0800 (PST)
In-Reply-To: <1355502352.32519.28.camel@ted>
References: <1355502352.32519.28.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 14 Dec 2012 14:14:39 -0700
X-Google-Sender-Auth: wA3VhylI0NjzfjWnREWs98P-NKg
Message-ID: <CABcZANnj3M8zfj7b2iOYcR8y8fkntAKPpPGrfwpJswFF_-Di-A@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] data: Ensure emit_func honours vardeps flag
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 14 Dec 2012 21:29:37 -0000
Content-Type: multipart/alternative; boundary=f46d0407152934c66004d0d68668

--f46d0407152934c66004d0d68668
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 14, 2012 at 9:25 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Currently, calling a shell function using exec_func may result in
> dependent functions being missing, if the shell parser can't detect
> the dependency, even if it was specified with the vardeps flag.
>
> This patch ensures the function looks at the flag and considers it
> when deciding which other functions need to be output.
>
> [YOCTO #3561]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Looks reasonable to me, thanks.

Acked-by: Christopher Larson <chris_larson@mentor.com>
-- 
Christopher Larson

--f46d0407152934c66004d0d68668
Content-Type: text/html; charset=UTF-8

<div class="gmail_extra">On Fri, Dec 14, 2012 at 9:25 AM, Richard Purdie <span dir="ltr">&lt;<a href="mailto:richard.purdie@linuxfoundation.org" target="_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><div class="gmail_quote">

<blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=":31">Currently, calling a shell function using exec_func may result in<br>
dependent functions being missing, if the shell parser can&#39;t detect<br>
the dependency, even if it was specified with the vardeps flag.<br>
<br>
This patch ensures the function looks at the flag and considers it<br>
when deciding which other functions need to be output.<br>
<br>
[YOCTO #3561]<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href="mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt;</div></blockquote></div><div class="gmail_extra"><br></div>Looks reasonable to me, thanks.<br>

<br></div><div class="gmail_extra">Acked-by: Christopher Larson &lt;<a href="mailto:chris_larson@mentor.com">chris_larson@mentor.com</a>&gt;<br>-- <br>Christopher Larson<br>
</div>

--f46d0407152934c66004d0d68668--
