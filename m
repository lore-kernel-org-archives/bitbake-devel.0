Return-Path: <garbados@gmail.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail.openembedded.org (Postfix) with ESMTP id EA5486E666
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 20:34:39 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id x124so5227753wmf.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 13:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to; 
	bh=IRLkFZPCO7E+kO1Ln4FaEC+V1ViUfYo/R6aOUGyeIwY=;
	b=PUzvQUUZW6oz1S2akq8MdAzvTzFj7pSM66puLns7v4dxhtLsX6rYvlhMsx3YdiasTz
	BBK6HEtvbddLcmdvzkRvjZd2AUKCwJmwnvNb5Z1pV4hyA7xcLJ6bDISq5Ta0SyhvXGKz
	4WoAHf++gNxBqtBtpQZLMo4Sy5MLLlaEgi1fzdliUC3d1pDzFOWwArdH4Y/xuSjUMwtc
	HZw/1fdaOjwCe5unZI8DvQ2K3VebqKLYo3PxwEQvs37UGvLX0x37pb1DrmH9mOVGQKia
	ScvBoF28P+EjOFtlBxCbu9WCW6mFDOD+Xo4vWFCZ4NIQHdFbEFWuWpKN0iPwreqZqPOJ
	xZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to;
	bh=IRLkFZPCO7E+kO1Ln4FaEC+V1ViUfYo/R6aOUGyeIwY=;
	b=uT222ekRHFmbAsz1MROnjzxSUu+HSKCqPbaM2r7WgJWMe4FiyMUEEhN83koMidyzGv
	CY7feH8BK30J3YyzBT/API/ps4qPlaz9rn/yAr+qMiVramzxp4KsW9qNR2Mj1h3Tg0Fv
	n4GFo69AegAgtBuSOHGFJoAXsRb6+svkeeko4dEJF3Lu18SPRYc+MyZpGThcszoAfi+z
	FXC3MIEj6R5pH2Kfs7EI4qWeHnz0jWBAhzr9jcBZu37zJ462ToIKxNHt1yKoeRRwyBC5
	QaPUXqOvMQ4I1O6YznHZ0qFlurSumlnphieHmQsWKwXQl8wMiWn5jXPUrzTAy9cYWgfx
	jJiA==
X-Gm-Message-State: AFeK/H1mr+GoKXHF95DWQ/v9G0PtBHJef5026WQOc7bGwK2OgNTOgHGqx/g/YUn51Y0DLsD0UUtYCQxNViYqAg==
X-Received: by 10.28.73.6 with SMTP id w6mr4177085wma.84.1490128480230; Tue,
	21 Mar 2017 13:34:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.153.137 with HTTP; Tue, 21 Mar 2017 13:33:59 -0700 (PDT)
In-Reply-To: <1490128025-7864-1-git-send-email-garbados@gmail.com>
References: <1490128025-7864-1-git-send-email-garbados@gmail.com>
From: Diana Thayer <garbados@gmail.com>
Date: Tue, 21 Mar 2017 13:33:59 -0700
Message-ID: <CA++8a_CFVb+=mHSH5x45Fg==D5pG-Ja=OiAiNpd2H4gvD3zSjA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bug 9962: improve -v, -D documentation
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
X-List-Received-Date: Tue, 21 Mar 2017 20:34:40 -0000
Content-Type: multipart/alternative; boundary=001a114aff66bbe82b054b4392dc

--001a114aff66bbe82b054b4392dc
Content-Type: text/plain; charset=UTF-8

Hi!

I did my best to follow patch submission guidelines
<https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded>
and code styleguide <https://www.openembedded.org/wiki/Styleguide> but this
is my very first patch to anything in the Yocto project. Please let me know
if and how I can improve future patch submissions! I figured since it's my
first time, I would follow up and say hello :)

This patch addresses bug 9962
<https://bugzilla.yoctoproject.org/show_bug.cgi?id=9962> by updating the
documentation of bitbake's -v and -D CLI options. I copied the updated text
directly from the bug report, and changed it both in the code and in the
user manual.

Anyway hi! I hope to contribute more soon :)

On Tue, Mar 21, 2017 at 1:27 PM, Diana Thayer <garbados@gmail.com> wrote:

> Per bug-9962, expanded and clarified documentation
> for -v, --verbose and -D, --debug.
>
> Signed-off-by: Diana Thayer <garbados@gmail.com>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-intro.xml | 16
> +++++++++++++---
>  lib/bb/main.py                                        | 15 +++++++++++++--
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> index 7248a0b..5bbfc67 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> @@ -504,9 +504,19 @@
>                               Read the specified file before bitbake.conf.
>         -R POSTFILE, --postread=POSTFILE
>                               Read the specified file after bitbake.conf.
> -       -v, --verbose         Output more log message data to the terminal.
> -       -D, --debug           Increase the debug level. You can specify
> this more
> -                             than once.
> +       -v, --verbose         Enable tracing of shell tasks (with 'set
> -x').
> +                             Also print bb.note(...) messages to stdout
> (in
> +                             addition to writing them to
> ${T}/log.do_<task>).
> +       -D, --debug           Increase the debug level. You can specify
> this
> +                             more than once. -D sets the debug level to 1,
> +                             where only bb.debug(1, ...) messages are
> printed
> +                             to stdout; -DD sets the debug level to 2,
> where
> +                             both bb.debug(1, ...) and bb.debug(2, ...)
> +                             messages are printed; etc. Without -D, no
> debug
> +                             messages are printed. Note that -D only
> affects
> +                             output to stdout. All debug messages are
> written
> +                             to ${T}/log.do_taskname, regardless of the
> debug
> +                             level.
>         -n, --dry-run         Don't execute, just go through the motions.
>         -S SIGNATURE_HANDLER, --dump-signatures=SIGNATURE_HANDLER
>                               Dump out the signature construction
> information, with
> diff --git a/lib/bb/main.py b/lib/bb/main.py
> index b3cd2cf..8c948c2 100755
> --- a/lib/bb/main.py
> +++ b/lib/bb/main.py
> @@ -174,10 +174,21 @@ class BitBakeConfigParameters(
> cookerdata.ConfigParameters):
>                            help="Read the specified file after
> bitbake.conf.")
>
>          parser.add_option("-v", "--verbose", action="store_true",
> dest="verbose", default=False,
> -                          help="Output more log message data to the
> terminal.")
> +                          help="Enable tracing of shell tasks (with 'set
> -x'). "
> +                               "Also print bb.note(...) messages to
> stdout (in "
> +                               "addition to writing them to
> ${T}/log.do_<task>).")
>
>          parser.add_option("-D", "--debug", action="count", dest="debug",
> default=0,
> -                          help="Increase the debug level. You can specify
> this more than once.")
> +                          help="Increase the debug level. You can specify
> this "
> +                               "more than once. -D sets the debug level
> to 1, "
> +                               "where only bb.debug(1, ...) messages are
> printed "
> +                               "to stdout; -DD sets the debug level to 2,
> where "
> +                               "both bb.debug(1, ...) and bb.debug(2,
> ...) "
> +                               "messages are printed; etc. Without -D, no
> debug "
> +                               "messages are printed. Note that -D only
> affects "
> +                               "output to stdout. All debug messages are
> written "
> +                               "to ${T}/log.do_taskname, regardless of
> the debug "
> +                               "level.")
>
>          parser.add_option("-q", "--quiet", action="count", dest="quiet",
> default=0,
>                            help="Output less log message data to the
> terminal. You can specify this more than once.")
> --
> 2.7.4
>
>

--001a114aff66bbe82b054b4392dc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi!<br><br></div>I did my best to follow <a=
 href=3D"https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmb=
edded">patch submission guidelines</a> and <a href=3D"https://www.openembed=
ded.org/wiki/Styleguide">code styleguide</a> but this is my very first patc=
h to anything in the Yocto project. Please let me know if and how I can imp=
rove future patch submissions! I figured since it&#39;s my first time, I wo=
uld follow up and say hello :)<br><br></div>This patch addresses <a href=3D=
"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D9962">bug 9962</a> by =
updating the documentation of bitbake&#39;s -v and -D CLI options. I copied=
 the updated text directly from the bug report, and changed it both in the =
code and in the user manual.<br><br></div>Anyway hi! I hope to contribute m=
ore soon :)<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Mar 21, 2017 at 1:27 PM, Diana Thayer <span dir=3D"ltr">&lt;<a =
href=3D"mailto:garbados@gmail.com" target=3D"_blank">garbados@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Per bug-9962, expanded=
 and clarified documentation<br>
for -v, --verbose and -D, --debug.<br>
<br>
Signed-off-by: Diana Thayer &lt;<a href=3D"mailto:garbados@gmail.com">garba=
dos@gmail.com</a>&gt;<br>
---<br>
=C2=A0doc/bitbake-user-manual/<wbr>bitbake-user-manual-intro.xml | 16 +++++=
++++++++---<br>
=C2=A0lib/bb/main.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 15 +++++++++++++--<br>
=C2=A02 files changed, 26 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/doc/bitbake-user-manual/<wbr>bitbake-user-manual-intro.xml b/d=
oc/bitbake-user-manual/<wbr>bitbake-user-manual-intro.xml<br>
index 7248a0b..5bbfc67 100644<br>
--- a/doc/bitbake-user-manual/<wbr>bitbake-user-manual-intro.xml<br>
+++ b/doc/bitbake-user-manual/<wbr>bitbake-user-manual-intro.xml<br>
@@ -504,9 +504,19 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Read the specified file before bitbake.conf=
.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -R POSTFILE, --postread=3DPOSTFILE<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Read the specified file after bitbake.conf.=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-v, --verbose=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Output more log message data to the terminal.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-D, --debug=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Increase the debug level. You can specify this more<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0than once.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-v, --verbose=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Enable tracing of shell tasks (with &#39;set -x&#39;).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Also print bb.note(...) messages to stdout (=
in<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addition to writing them to ${T}/log.do_&lt;=
task&gt;).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-D, --debug=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Increase the debug level. You can specify this<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0more than once. -D sets the debug level to 1=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0where only bb.debug(1, ...) messages are pri=
nted<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to stdout; -DD sets the debug level to 2, wh=
ere<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0both bb.debug(1, ...) and bb.debug(2, ...)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0messages are printed; etc. Without -D, no de=
bug<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0messages are printed. Note that -D only affe=
cts<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output to stdout. All debug messages are wri=
tten<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to ${T}/log.do_taskname, regardless of the d=
ebug<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0level.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -n, --dry-run=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Don&#39;t execute, just go through the motions.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -S SIGNATURE_HANDLER, --dump-signatures=3DSIGNA=
TURE_<wbr>HANDLER<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Dump out the signature construction informa=
tion, with<br>
diff --git a/lib/bb/main.py b/lib/bb/main.py<br>
index b3cd2cf..8c948c2 100755<br>
--- a/lib/bb/main.py<br>
+++ b/lib/bb/main.py<br>
@@ -174,10 +174,21 @@ class BitBakeConfigParameters(<wbr>cookerdata.ConfigP=
arameters):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0help=3D&quot;Read the specified file after bitbake.=
conf.&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parser.add_option(&quot;-v&quot;, &quot;-=
-verbose&quot;, action=3D&quot;store_true&quot;, dest=3D&quot;verbose&quot;=
, default=3DFalse,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 help=3D&quot;Output more log message data to the terminal=
.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 help=3D&quot;Enable tracing of shell tasks (with &#39;set=
 -x&#39;). &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Also print bb.note(...) message=
s to stdout (in &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;addition to writing them to ${T=
}/log.do_&lt;task&gt;).&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parser.add_option(&quot;-D&quot;, &quot;-=
-debug&quot;, action=3D&quot;count&quot;, dest=3D&quot;debug&quot;, default=
=3D0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 help=3D&quot;Increase the debug level. You can specify th=
is more than once.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 help=3D&quot;Increase the debug level. You can specify th=
is &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;more than once. -D sets the deb=
ug level to 1, &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;where only bb.debug(1, ...) mes=
sages are printed &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;to stdout; -DD sets the debug l=
evel to 2, where &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;both bb.debug(1, ...) and bb.de=
bug(2, ...) &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;messages are printed; etc. With=
out -D, no debug &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;messages are printed. Note that=
 -D only affects &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;output to stdout. All debug mes=
sages are written &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;to ${T}/log.do_taskname, regard=
less of the debug &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;level.&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parser.add_option(&quot;-q&quot;, &quot;-=
-quiet&quot;, action=3D&quot;count&quot;, dest=3D&quot;quiet&quot;, default=
=3D0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0help=3D&quot;Output less log message data to the te=
rminal. You can specify this more than once.&quot;)<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.7.4<br>
<br>
</font></span></blockquote></div><br></div>

--001a114aff66bbe82b054b4392dc--
