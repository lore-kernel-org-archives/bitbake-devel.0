Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
	[209.85.213.182])
	by mail.openembedded.org (Postfix) with ESMTP id 8D72660667
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jan 2016 21:42:52 +0000 (UTC)
Received: by mail-ig0-f182.google.com with SMTP id ik10so41498801igb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Jan 2016 13:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=5YUBvmjxg8eRGtA5+VzwE8yC9cOwudkdZ2m/hXRUFuY=;
	b=BuWR+/GpxhBjM9JV8KdvMkU3B183AfhFbegeBIpD0/Rxxl1k6jnF1ZjWGiKmJX1UcK
	80zBugVlRGrVR9ksYRyoLQ3ec2kOk2C1eqpjRMYZXFZODYw2Arygg+6VcF6wr/9FjzCr
	EF79SXb5t2H/xoWtsHruZHYqUZCYAwALVpAi/m62tAoC8JpGPC2LziESThtkE9ml0NhU
	yXlWQluvsRipg9imahssSTWu6qFwJYrL7HqU2Z9E1TpSuM8Nm8wCnUEGj1CSngKzSLNq
	UQw8WByayy+AGiDtWszisLzk+AAteXILSw8OTP035IolstCWHKn7LI98DHmrK13sDSeV
	g4YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=5YUBvmjxg8eRGtA5+VzwE8yC9cOwudkdZ2m/hXRUFuY=;
	b=xRNHQ2uXnab05Cx2hzsbgOtu8wznd0K6u5BbCvK1O/iuyjizCSP3Gnxk+W6L5KM4io
	4u/OPsLAEVFLNPAeW2yIMDogGb5TgwqYMoTY9ewuN53umjFuGTTVjVj78IHVUz+SHI+o
	3bf0J99jwEigLuDR9AKru461AgASBsV9sdgNdJpHE2yCoiH3fA1xNvEL6nXZra7UMefw
	vzRiPEoO46lubvyTOL2CVN1J6E9o2AUU46fkrlR09Eb2T7OejcILfq8O2rezxQOOeSF4
	80+OYcUHfy22EE9L8ao9tioraWqqygq1IhIuNV4BeF2boPbJKPt3FuzyBjJeOmyNzG9O
	cUVQ==
X-Received: by 10.50.79.165 with SMTP id k5mr12064064igx.10.1452116572956;
	Wed, 06 Jan 2016 13:42:52 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.104.194 with HTTP; Wed, 6 Jan 2016 13:42:33 -0800 (PST)
In-Reply-To: <1452097500-18426-1-git-send-email-ross.burton@intel.com>
References: <1452097500-18426-1-git-send-email-ross.burton@intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 6 Jan 2016 14:42:33 -0700
X-Google-Sender-Auth: B7OuBBcvFGDh4V3alAdIl7yU6GE
Message-ID: <CABcZANnO9qiA0-7+tcz8Y03pa5gNEb4EcdKa1MQ6O_hkjgLsvA@mail.gmail.com>
To: Ross Burton <ross.burton@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH][RFC] bitbake-worker: set the process name when starting a task
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
X-List-Received-Date: Wed, 06 Jan 2016 21:42:54 -0000
Content-Type: multipart/alternative; boundary=089e013a032e80ee7b0528b13ce3

--089e013a032e80ee7b0528b13ce3
Content-Type: text/plain; charset=UTF-8

On Wed, Jan 6, 2016 at 9:25 AM, Ross Burton <ross.burton@intel.com> wrote:

> If the setproctitle module is present then use it to change the process
> name
> when the worker starts a task.  This results in each worker showing what
> task it
> is executing in a process listing.
>
> Signed-off-by: Ross Burton <ross.burton@intel.com>
>

Very nice. Do you know if it's overwriting just the process name or the
entire commandline? I'm wondering if pkill bitbake-worker would do what you
want, or if you'd still need to use pkill -f, for example. I'd like to see
the toplevel bitbake processes named nicely without the python path and
whatnot too eventually. We could also name the parallel parsing processes
(though admittedly they're not long lived). Perhaps this should go into a
helper function in bb.utils or bb.process?
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e013a032e80ee7b0528b13ce3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">On Wed, Jan 6, 2016 at 9:25 AM,=
 Ross Burton <span dir=3D"ltr">&lt;<a href=3D"mailto:ross.burton@intel.com"=
 target=3D"_blank">ross.burton@intel.com</a>&gt;</span> wrote:<br><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":ux" class=3D"a=
3s" style=3D"overflow:hidden">If the setproctitle module is present then us=
e it to change the process name<br>
when the worker starts a task.=C2=A0 This results in each worker showing wh=
at task it<br>
is executing in a process listing.<br>
<br>
Signed-off-by: Ross Burton &lt;<a href=3D"mailto:ross.burton@intel.com">ros=
s.burton@intel.com</a>&gt;</div></blockquote></div><br></div><div class=3D"=
gmail_extra">Very nice. Do you know if it&#39;s overwriting just the proces=
s name or the entire commandline? I&#39;m wondering if pkill bitbake-worker=
 would do what you want, or if you&#39;d still need to use pkill -f, for ex=
ample. I&#39;d like to see the toplevel bitbake processes named nicely with=
out the python path and whatnot too eventually. We could also name the para=
llel parsing processes (though admittedly they&#39;re not long lived). Perh=
aps this should go into a helper function in bb.utils or bb.process?<br>-- =
<br><div class=3D"gmail_signature">Christopher Larson<br>clarson at kergoth=
 dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tsl=
ib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--089e013a032e80ee7b0528b13ce3--
