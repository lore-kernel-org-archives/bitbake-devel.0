Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
	[209.85.213.177])
	by mail.openembedded.org (Postfix) with ESMTP id A8D6660034
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Oct 2015 22:26:49 +0000 (UTC)
Received: by igbdj2 with SMTP id dj2so35759502igb.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Oct 2015 15:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=0CAdn4jTG9JXhv5RkktZzOCSblB8jhOOrXnoZK9/bGg=;
	b=PLSOMD2NzNmGWgPY6ZUaTSYxJsp9VcBBckcGqB62uFkpHO/NMppyJPm8l8PB9AboAF
	g1ABlL6nVcYCJF87cKqUrE+in2ZtupTWukVop4DEO7gp2KQ3zvm8dzXnYHWPE/cHzc9L
	o5iwOpKp9zaE3lyoeuTJQE63kxoEwmDWjmjFyaK0iKwVnzfPQ31tX6rmD67oM9vP8xKj
	t5XWjQLDi7QmZfihMVgoLt4w1UlU0Z91/0AYYL7XDQjYDXQs/eTgrVBo+WTQyt0y9z8z
	w+WXToTBGwwmA/7gI3LSMNYmSn5V/RhnENCUT3DkEB8ygS3dYIPNeuw9dMmxW2O7cvll
	4QQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth_com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=0CAdn4jTG9JXhv5RkktZzOCSblB8jhOOrXnoZK9/bGg=;
	b=PXDhcpexO+r6Ei4Y9sjEBD8cUQLA2PhhL46fvoYcItx7tCfD91qm8hAMQ7ka8jC8cu
	hU55zNHRm59bv8LhTXrkLj+GE9IROnTQgoVriSQK1w2jKNXbRISLHtXfwRNG8v1yM8tx
	iiVD4gWB2sBsOU4vovmSCA1bRAuc4YRkzV0Y/CZ5SO9rRZl+F0MwqgxCirQGtp5VIg+a
	fLZA6hHJa9G1CfFZDFx94ioTqx7v37z8b9XyUsMJCPjamKcoAgKshggi6HfNMOjSjsG5
	m9If/fLi2Qm8bdY3A57nclLRnhIri95o2aQSbQ+ytweV4WlI8ZpsXPnR9sFVc60fXhQM
	nuOg==
X-Received: by 10.50.60.74 with SMTP id f10mr12094943igr.10.1445725610221;
	Sat, 24 Oct 2015 15:26:50 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.65.204 with HTTP; Sat, 24 Oct 2015 15:26:30 -0700 (PDT)
In-Reply-To: <1445681946.21913.52.camel@linuxfoundation.org>
References: <1445681946.21913.52.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Sat, 24 Oct 2015 15:26:30 -0700
X-Google-Sender-Auth: 6er-NMC6dKXyfxT8ZpmyglGGae4
Message-ID: <CABcZAN=1UMLVqcqMvNW+hD1n48-X1o_YhPvZv4v9BDDC1e6Oww@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "Witt, Randy E" <randy.e.witt@intel.com>, "Avery,
	Brian" <brian.avery@intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Scott Rifenbark <srifenbark@gmail.com>,
	Tracy Graydon <tracy.graydon@intel.com>
Subject: Re: [PATCH] build/utils: Add BB_TASK_IONICE_LEVEL support
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
X-List-Received-Date: Sat, 24 Oct 2015 22:26:54 -0000
Content-Type: multipart/alternative; boundary=047d7b10ca7d70a7180522e13960

--047d7b10ca7d70a7180522e13960
Content-Type: text/plain; charset=UTF-8

On Sat, Oct 24, 2015 at 3:19 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index eb219c1..86a5328 100644
> --- a/bitbake/lib/bb/utils.py
> +++ b/bitbake/lib/bb/utils.py
> @@ -1310,3 +1310,27 @@ def signal_on_parent_exit(signame):
>      result = cdll['libc.so.6'].prctl(PR_SET_PDEATHSIG, signum)
>      if result != 0:
>          raise PrCtlError('prctl failed with error code %s' % result)
> +
> +#
> +# Manually call the ioprio syscall. We could depend on other libs like
> psutil
> +# however this gets us enough of what we need to bitbake for now without
> the
> +# dependency
> +#
> +_unamearch = os.uname()[4]
> +IOPRIO_WHO_PROCESS = 1
> +IOPRIO_CLASS_SHIFT = 13
> +
> +def ioprio_set(who, cls, value):
> +    NR_ioprio_set = None
> +    if _unamearch == "x86_64":
> +      NR_ioprio_set = 251
> +    elif _unamearch[0] == "i" and _unamearch[2:3] == "86":
> +      NR_ioprio_set = 289
> +
> +    if NR_ioprio_set:
> +        ioprio = value | (cls << IOPRIO_CLASS_SHIFT)
> +        rc = cdll['libc.so.6'].syscall(NR_ioprio_set, IOPRIO_WHO_PROCESS,
> who, ioprio)
> +        if rc != 0:
> +            raise ValueError("Unable to set ioprio, syscall returned %s"
> % rc)
>

Question, is the only way the syscall ran return non-zero the case where
the ioprio vaue is wrong? If it can fail for any other reason (e.g.
interrupted syscall), this probably isn't always a ValueError.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7b10ca7d70a7180522e13960
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Oct 24, 2015 at 3:19 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div id=3D":1fv" class=3D"a3s" style=3D"overflow:hidden">diff --git=
 a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py<br>
index eb219c1..86a5328 100644<br>
--- a/bitbake/lib/bb/utils.py<br>
+++ b/bitbake/lib/bb/utils.py<br>
@@ -1310,3 +1310,27 @@ def signal_on_parent_exit(signame):<br>
=C2=A0 =C2=A0 =C2=A0result =3D cdll[&#39;libc.so.6&#39;].prctl(PR_SET_PDEAT=
HSIG, signum)<br>
=C2=A0 =C2=A0 =C2=A0if result !=3D 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise PrCtlError(&#39;prctl failed with e=
rror code %s&#39; % result)<br>
+<br>
+#<br>
+# Manually call the ioprio syscall. We could depend on other libs like psu=
til<br>
+# however this gets us enough of what we need to bitbake for now without t=
he<br>
+# dependency<br>
+#<br>
+_unamearch =3D os.uname()[4]<br>
+IOPRIO_WHO_PROCESS =3D 1<br>
+IOPRIO_CLASS_SHIFT =3D 13<br>
+<br>
+def ioprio_set(who, cls, value):<br>
+=C2=A0 =C2=A0 NR_ioprio_set =3D None<br>
+=C2=A0 =C2=A0 if _unamearch =3D=3D &quot;x86_64&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 NR_ioprio_set =3D 251<br>
+=C2=A0 =C2=A0 elif _unamearch[0] =3D=3D &quot;i&quot; and _unamearch[2:3] =
=3D=3D &quot;86&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 NR_ioprio_set =3D 289<br>
+<br>
+=C2=A0 =C2=A0 if NR_ioprio_set:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ioprio =3D value | (cls &lt;&lt; IOPRIO_CLASS_=
SHIFT)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D cdll[&#39;libc.so.6&#39;].syscall(NR_io=
prio_set, IOPRIO_WHO_PROCESS, who, ioprio)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if rc !=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ValueError(&quot;Unable to=
 set ioprio, syscall returned %s&quot; % rc)</div></blockquote></div><br>Qu=
estion, is the only way the syscall ran return non-zero the case where the =
ioprio vaue is wrong? If it can fail for any other reason (e.g. interrupted=
 syscall), this probably isn&#39;t always a ValueError.<br>-- <br><div clas=
s=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot com<br>F=
ounder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior =
Software Engineer, Mentor Graphics</div>
</div></div>

--047d7b10ca7d70a7180522e13960--
