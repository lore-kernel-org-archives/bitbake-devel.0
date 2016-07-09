Return-Path: <kergoth@gmail.com>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
	[209.85.214.68])
	by mail.openembedded.org (Postfix) with ESMTP id 066A4605BA
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Jul 2016 04:03:51 +0000 (UTC)
Received: by mail-it0-f68.google.com with SMTP id h190so6280993ith.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Jul 2016 21:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=nrWPwYC3a0xJYccNaCt5zklVQon821I4Kemk8LQLWQk=;
	b=idgVVooqvsTLeAKkF7X4zlziQh71umGXEwRDIcT0ChfR8zIphJSlC0hi+PILRHcK0x
	1rAuJJAjbr4/cMyMJO9W1WiXw/y9Yd6d8H5Qzas5f91fTgB6v8wRfDF7vLC+dcYkLO48
	NOQhbuwR0jcYMZnh2M91ZyxQTFD/t/yyBicplNmhyiXIcvUAjBjqDdYV0tczaoskYAuu
	kI9rLb9VZbq7TZOag1dZTfQEFVsBalF+BafmdQ8cspIfGnmJ5NDv141QjYxo0UAXQwqC
	v45/8j1WTWsCn5ye9bI0x/I1MYIr7oXMQ2ZSmf7XZNmJpTbGdBQtCvMNBaRDJfVd7TbJ
	GwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=nrWPwYC3a0xJYccNaCt5zklVQon821I4Kemk8LQLWQk=;
	b=myRQIIZAQ9g8AvHr+XLoZWILtF9ERPYupUeYS/AOuAWZMPgX/7LdbxWx1dL4YQuF9y
	k9fZaRxbacDu33Bgr28zxeSikr8YLtS56/GU8UUCvITH3/DcGn/I1ruY52y3oVGYn3u3
	Kf5hpnUSSIsapmtctBH+B7D92tFYKCF5m3TPryxK4Pk2wrUYuJnlwtzQONvSPorlD+3+
	G53DJdj9rfrITXqPP2ykwW1+9pwUbdXgMU3cT3YRtLT3RxFcnwvi02Wc7M8TVKTIkIsq
	eQaEZYl8tosF33xJMDAHatAtH6vGgmU8xCFBpOjY6pp+uqQXa1tGo83WxuJ2EoC8zkhX
	PWpQ==
X-Gm-Message-State: ALyK8tKgFpHpYMBwBbZusTDVtY4cwgYBBM4CvivX6PO3D6E+j4XHTCtJNqTJbenMNCQUGCgZKvkJRCJ/Ia7pfA==
X-Received: by 10.36.107.88 with SMTP id v85mr1595504itc.19.1468037032236;
	Fri, 08 Jul 2016 21:03:52 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.19.70 with HTTP; Fri, 8 Jul 2016 21:03:32 -0700 (PDT)
In-Reply-To: <fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
References: <cover.1468024992.git.brian.avery@intel.com>
	<fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Fri, 8 Jul 2016 21:03:32 -0700
X-Google-Sender-Auth: 8ODbJXKE94Rt9yTDr_sDesBy9Ew
Message-ID: <CABcZANnHUGwrvoRdYmmpA_=Z5gfkT3Rbyxc9gnR8U71Ekj7gGg@mail.gmail.com>
To: brian avery <avery.brian@gmail.com>
Cc: brian avery <brian.avery@intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/7] runqueue: improve exception logging
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
X-List-Received-Date: Sat, 09 Jul 2016 04:03:52 -0000
Content-Type: multipart/alternative; boundary=001a114a958cd2dd3d05372c01ef

--001a114a958cd2dd3d05372c01ef
Content-Type: text/plain; charset=UTF-8

On Fri, Jul 8, 2016 at 5:52 PM, brian avery <avery.brian@gmail.com> wrote:

> From: Ed Bartosh <ed.bartosh@linux.intel.com>
>
> Runqueue errors direct the user to view the "failure below",
> but no additional error message is available.
>
> Log the stacktrace so that the user can see what went wrong.
>
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> Signed-off-by: brian avery <brian.avery@intel.com>
> ---
>  lib/bb/runqueue.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 57be15a..04f2f4c 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -1219,8 +1219,10 @@ class RunQueue:
>                  pass
>              self.state = runQueueComplete
>              raise
> -        except:
> -            logger.error("An uncaught exception occured in runqueue,
> please see the failure below:")
> +        except Exception as err:
> +            import traceback
> +            logger.error("An uncaught exception occured in runqueue:
> '%s'" % err)
> +            logger.error(traceback.format_exc())
>

Is there a reason we aren't just passing the exception in and letting the
logging format it and pass it through to the UI for formatting? See
logger.exception() and the exc_info= keyword argument for error().
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a114a958cd2dd3d05372c01ef
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jul 8, 2016 at 5:52 PM, brian avery <span dir=3D"ltr">&lt;<a href=
=3D"mailto:avery.brian@gmail.com" target=3D"_blank">avery.brian@gmail.com</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1p7" cla=
ss=3D"a3s aXjCH m155cd253839bccde">From: Ed Bartosh &lt;<a href=3D"mailto:e=
d.bartosh@linux.intel.com">ed.bartosh@linux.intel.com</a>&gt;<br>
<br>
Runqueue errors direct the user to view the &quot;failure below&quot;,<br>
but no additional error message is available.<br>
<br>
Log the stacktrace so that the user can see what went wrong.<br>
<br>
Signed-off-by: Ed Bartosh &lt;<a href=3D"mailto:ed.bartosh@linux.intel.com"=
>ed.bartosh@linux.intel.com</a>&gt;<br>
Signed-off-by: brian avery &lt;<a href=3D"mailto:brian.avery@intel.com">bri=
an.avery@intel.com</a>&gt;<br>
---<br>
=C2=A0lib/<span class=3D"il">bb</span>/runqueue.py | 6 ++++--<br>
=C2=A01 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/<span class=3D"il">bb</span>/runqueue.py b/lib/<span class=
=3D"il">bb</span>/runqueue.py<br>
index 57be15a..04f2f4c 100644<br>
--- a/lib/<span class=3D"il">bb</span>/runqueue.py<br>
+++ b/lib/<span class=3D"il">bb</span>/runqueue.py<br>
@@ -1219,8 +1219,10 @@ <span class=3D"il">class</span> RunQueue:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.state =3D runQueueComp=
lete<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 except:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.error(&quot;An uncaught e=
xception occured in runqueue, please see the failure below:&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except Exception as err:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 import traceback<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.error(&quot;An uncaught e=
xception occured in runqueue: &#39;%s&#39;&quot; % err)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.error(traceback.format_ex=
c())</div></blockquote></div><br>Is there a reason we aren&#39;t just passi=
ng the exception in and letting the logging format it and pass it through t=
o the UI for formatting? See logger.exception() and the exc_info=3D keyword=
 argument for error().<br>-- <br><div class=3D"gmail_signature" data-smartm=
ail=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot com<br=
>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senio=
r Software Engineer, Mentor Graphics</div>
</div></div>

--001a114a958cd2dd3d05372c01ef--
