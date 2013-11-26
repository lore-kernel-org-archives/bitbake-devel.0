Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
	[209.85.215.53])
	by mail.openembedded.org (Postfix) with ESMTP id 71CC06DD0F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Nov 2013 02:07:28 +0000 (UTC)
Received: by mail-la0-f53.google.com with SMTP id ea20so3678675lab.40
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 18:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=cdOtjFLC5ro+G4sdggOjTozjDijnAD+uMfnO6I19bCQ=;
	b=lgs6hAVV1yxXIMaN2F96x06FwxPgFpNJiC8j+I9Fyhy0eEFIvAradpGvSXB5htK1aM
	o4Ll/ODswjV7HsNdDOmuCQK4Tkw6pOXnYzp+HFOzcPBkuNVDwd231DD5S23jnTo8F6di
	Yc1xst4w1lpwL4rz1CyY8wKP37bSH1ut76VkLuT0KPAWGwKZGN+/YVboqJYF9pdXfqOI
	e4I5A7WKJvKIQVPz2H1gg379yRnLSzSc9q9653xot+JjXdgjS+zGLECjhIM1BrDXTVfo
	CMoHdaOHFR6UYoARqfQMTVSYTBRm9CxMiub0NN5rVN6ymCxmTHWfKgHMpjpbuHvRjKQn
	34Hw==
X-Received: by 10.112.29.147 with SMTP id k19mr23628936lbh.9.1385431646975;
	Mon, 25 Nov 2013 18:07:26 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.53.197 with HTTP; Mon, 25 Nov 2013 18:07:06 -0800 (PST)
In-Reply-To: <1385420379.24083.22.camel@ted>
References: <1385420379.24083.22.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 25 Nov 2013 19:07:06 -0700
X-Google-Sender-Auth: DGqRPKKwaVwoykK_C6ELgqzMNZw
Message-ID: <CABcZAN=O7Uov0xBXEQn8=Gaq2YBSNC9yFGvrKhhdeQfLi4NW+Q@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] data/codeparser: Improve handling of contains functions
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
X-List-Received-Date: Tue, 26 Nov 2013 02:07:29 -0000
Content-Type: multipart/alternative; boundary=001a1133aa862dc84d04ec0af1f7

--001a1133aa862dc84d04ec0af1f7
Content-Type: text/plain; charset=UTF-8

On Mon, Nov 25, 2013 at 3:59 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> One of the current frustrations with the sstate checksums is that
> code like base_contains('X', 'y',...) adds a full dependency on X
> and varies depend even on whitespace changes in X.
>
> This patch adds special handling of the contains functions to expand
> the first parameter and check for the flag specified by the second
> parameter (assuming its a string).
>
> The result is then appended to the value of the variable with a "Set"
> or "Unset" status. If the flag is added/removed, the stored variable
> value changes and hence the checksum changes. No dependency on X
> is added so it is free to change with regard to other flags or
> whitespace.
>
> This code is far from ideal, ideally we'd have properly typed variables
> however it fixes a major annoyance of the current checksums and
> is of enough value its worth adding in a stopgap solution. It shouldn't
> significantly restrict any propely typed variable implementation in
> future.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Looks good, will be very helpful for now.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
-- 
Christopher Larson

--001a1133aa862dc84d04ec0af1f7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Nov 25, 2013 at 3:59 PM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":11v" style=3D"overflow:hidden">O=
ne of the current frustrations with the sstate checksums is that<br>
code like base_contains(&#39;X&#39;, &#39;y&#39;,...) adds a full dependenc=
y on X<br>
and varies depend even on whitespace changes in X.<br>
<br>
This patch adds special handling of the contains functions to expand<br>
the first parameter and check for the flag specified by the second<br>
parameter (assuming its a string).<br>
<br>
The result is then appended to the value of the variable with a &quot;Set&q=
uot;<br>
or &quot;Unset&quot; status. If the flag is added/removed, the stored varia=
ble<br>
value changes and hence the checksum changes. No dependency on X<br>
is added so it is free to change with regard to other flags or<br>
whitespace.<br>
<br>
This code is far from ideal, ideally we&#39;d have properly typed variables=
<br>
however it fixes a major annoyance of the current checksums and<br>
is of enough value its worth adding in a stopgap solution. It shouldn&#39;t=
<br>
significantly restrict any propely typed variable implementation in<br>
future.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;</div></blockquote><=
/div><br>Looks good, will be very helpful for now.</div><div class=3D"gmail=
_extra">

<br></div><div class=3D"gmail_extra">Signed-off-by: Christopher Larson &lt;=
<a href=3D"mailto:chris_larson@mentor.com">chris_larson@mentor.com</a>&gt;<=
br>-- <br>Christopher Larson</div></div>

--001a1133aa862dc84d04ec0af1f7--
