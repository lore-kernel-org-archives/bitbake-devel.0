Return-Path: <kergoth@gmail.com>
Received: from mail-yh0-f45.google.com (mail-yh0-f45.google.com
	[209.85.213.45])
	by mail.openembedded.org (Postfix) with ESMTP id 1F0E3606E9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 12:20:53 +0000 (UTC)
Received: by mail-yh0-f45.google.com with SMTP id a41so7272905yho.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 04:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=2AE7Hn6h3blq7RT4bHEHhw3uSisfPq0KwJXgyftxcfo=;
	b=D+2CK8w5a5jUtE1vWC3/1aUCDcKB4TR+hz7qsoAqNn0CAvLBZ8hVdazI7eIVg9xmy3
	9K5hcAcDp/apKA69Q8qW+LX6+sl5x3bS4SKkfsmVWgfNmPZ5Cq1OjkYIGP02lIxU3q7K
	2bPRuwV5RfaEEFSEvEA1NOwhuQVO2gElHDLqmZRkPLBt297lO6mrwmRNDJIJ9lajTMxS
	CBYw/lWfl1QNsMbblpXftooI46PUNipEPMhRG/Y2+QrlVUkcIfbFXfUiWbDhTUaqDoSu
	YdlLqH8MhiwuOQqdJtY1bIR4hMGG4IxI9tRnL8pfGniQHabrrhO9ZuWuDMtIWugD40B1
	zIRw==
X-Received: by 10.170.209.14 with SMTP id a14mr6567990ykf.11.1423484454505;
	Mon, 09 Feb 2015 04:20:54 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.170.205.88 with HTTP; Mon, 9 Feb 2015 04:20:34 -0800 (PST)
In-Reply-To: <1423481849-5774-1-git-send-email-maxin.john@enea.com>
References: <1423481849-5774-1-git-send-email-maxin.john@enea.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 9 Feb 2015 05:20:34 -0700
X-Google-Sender-Auth: SsaYjzXQagCMe6Bb9vn7dVLpbJ4
Message-ID: <CABcZAN=GvNVLJgN=vWoor11rbBqYvg8EGPJt-okZyHs3+pvaEw@mail.gmail.com>
To: "Maxin B. John" <maxin.john@enea.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] depexp.py: Fix segfault if DISPLAY is not set
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
X-List-Received-Date: Mon, 09 Feb 2015 12:21:00 -0000
Content-Type: multipart/alternative; boundary=001a11398f62412c51050ea6cde9

--001a11398f62412c51050ea6cde9
Content-Type: text/plain; charset=UTF-8

On Mon, Feb 9, 2015 at 4:37 AM, Maxin B. John <maxin.john@enea.com> wrote:

> +    try:
> +        gtk.init_check()
> +    except:
> +        print "Please set DISPLAY variable before running this command."
> +        sys.exit(1)
> +
>

It's good that you're fixing this, but 1) this uses the old style
non-function print, which isn't supported in new python, and 2) it outputs
the error message to stdout rather than stderr, and 3) it looks like just
returning rather than exiting is likely the best move.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11398f62412c51050ea6cde9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Feb 9, 2015 at 4:37 AM, Maxin B. John <span dir=3D"ltr">&lt;<a href=
=3D"mailto:maxin.john@enea.com" target=3D"_blank">maxin.john@enea.com</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1ax" class=
=3D"a3s" style=3D"overflow:hidden">+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gtk.init_check()<br>
+=C2=A0 =C2=A0 except:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Please set DISPLAY variable before=
 running this command.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(1)<br>
+</div></blockquote></div><br>It&#39;s good that you&#39;re fixing this, bu=
t 1) this uses the old style non-function print, which isn&#39;t supported =
in new python, and 2) it outputs the error message to stdout rather than st=
derr, and 3) it looks like just returning rather than exiting is likely the=
 best move.<br>-- <br><div class=3D"gmail_signature">Christopher Larson<br>=
clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<b=
r>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a11398f62412c51050ea6cde9--
