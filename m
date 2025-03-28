Return-Path: <sam@liddicott.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345A0C28B20
	for <webhook@archiver.kernel.org>; Fri, 28 Mar 2025 11:41:46 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.9021.1743162087859486550
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Mar 2025 04:41:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@liddicott-com.20230601.gappssmtp.com header.s=20230601 header.b=pv/6j7mH;
 spf=none, err=SPF record not found (domain: liddicott.com, ip: 209.85.208.42, mailfrom: sam@liddicott.com)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so3853322a12.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Mar 2025 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liddicott-com.20230601.gappssmtp.com; s=20230601; t=1743162086; x=1743766886; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zCq/JN+cXZZM/qY86dKahXv5i2SEQ/945tT8zGdNBkA=;
        b=pv/6j7mHoVYmE8A3KdXpXv3UknbBiAGpTHOHqJzcaDpjAjd0VStRWISLEWGvSFkMet
         VYpaGMh+uPTkKSu3pofzx/0L+gpMn1cpgLLOaXi30pGcNWnXnM4hRq5UjGsVwYwbaO5P
         qLP++MEe/ElETKypJ8G14aHX1/LHjD+sILeNG1N79OH8t93biJTqfTVnQKXQkOgqHMtb
         8tpBxQIRX8J57w6yhy6+agjC7n+mYMh8gFqkwLF4Md1S6IL5V3vRzoPbuWRtZdQdzfda
         rN+uCzmSKXEZ3zrQQeJAg5EPTI6frwOw/GWitgZzvCGEwWVGyFiH3jmkjIGjFsw8nzki
         syYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743162086; x=1743766886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCq/JN+cXZZM/qY86dKahXv5i2SEQ/945tT8zGdNBkA=;
        b=EZ6TP/jw5Hla0KxF6qRL4V4Se/IoSDI/D4AeuliZO+u522Gvw1LB6Lo2ojFnloN01s
         NEBip6/coywh56qBzn+mxagBu+aIeZ6yGW+mYLcMsOWZTmcj+lgAqAnzBxrxl4TJiaas
         EqN6NZK4cFqOD4mPW3D2a8iwgYNgbHt4IHWT/o5VvfpzULAFIJQvO6z5USvGuu/yq8G0
         tyUe9dtxOG8tyB0RpQRe9kcCt99MFIi/1cvCSQpyMyag2kQIfjuJQw9bSv5pWZQOAQ3x
         Tg2q+iEtUBtyWaG3l+f4M5111LVu4rX95XG6oqLkaZLD+PjxMO3t+7acu2Kul0f3RIR8
         6M1Q==
X-Gm-Message-State: AOJu0YwU4VnzLXG0A2+oacF0aUFTT0erl7qTohXLm00WAr4/w1nFR2b4
	Gvcvvu8EKs0TmvPFSBSnaO0zoW3gzUIRAc7/jGgCWTT1nHo4/63jXkZLO2thCwjIQ2j6aqBn1kL
	gE9tbzlqheYehCaEUOgFti4nkDgqVNouBRNO9
X-Gm-Gg: ASbGncsE2wvAhCmi3CIrRf2aJl+SEZKkty5H3Tqd5w4yjEdy381A433mEQ1VwZGcAl1
	potz3g0nDdL1gUXs/hiMsmvZ0QyK1Ze2VRzW8YOcmdhRe1Xu1PKVw4E2SthBqPEY+5ybddFaXOk
	PfAHv2ynmA2ZticONUeHbmgwcV90c=
X-Google-Smtp-Source: AGHT+IGfiyERy/XG9SLxrclInigj2+WfbvCjXSsUzT3YRq2qmOQBngFnud3NOUCRq6nq93smcuQzOhN2gbGL80KnmeA=
X-Received: by 2002:a05:6402:50d4:b0:5e7:87cd:2479 with SMTP id
 4fb4d7f45d1cf-5edc4c07421mr2043668a12.8.1743162085696; Fri, 28 Mar 2025
 04:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <17B810A24531435C.23432@lists.openembedded.org>
 <CAOj-5WAohNpyHRFFWbBkm2CWnFnfzAit4Kxm2=9WsbKcSPeb+Q@mail.gmail.com>
 <fc3346c4a626f8a5cdb5805c2ea8b666065fc86f.camel@linuxfoundation.org>
 <17B85E3B078DFE63.18468@lists.openembedded.org> <CAOj-5WCj04cnjeNrkfF2igx6a5nxERTFhKhd02q_NTd97AzYwA@mail.gmail.com>
 <9ce5ba6c0ea52f2c636874c88051d216fd2f2c9f.camel@linuxfoundation.org>
In-Reply-To: <9ce5ba6c0ea52f2c636874c88051d216fd2f2c9f.camel@linuxfoundation.org>
From: Sam Liddicott <sam@liddicott.com>
Date: Fri, 28 Mar 2025 11:40:48 +0000
X-Gm-Features: AQ5f1JpTa-OYw1GDVhUwDP6rl-Twxe4Pv7ffqMpHaIIRp1qkBKXxOFLv5zXQT3w
Message-ID: <CAOj-5WDWoY_gqnu8P6ySSHogADS4yT3OyzYsqUQhMU46knijgA@mail.gmail.com>
Subject: Re: [bitbake-devel] pseudo abort with req '/proc/self/fd/3'
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, matt.cowell@nokia.com
Content-Type: multipart/alternative; boundary="000000000000e7992d0631658c36"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Mar 2025 11:41:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17504

--000000000000e7992d0631658c36
Content-Type: text/plain; charset="UTF-8"

An interesting update from me, with my (now out-of-date) pseudo version:

Without excluding /proc via PSEUDO_IGNORE_PATHS the chown executed by the
yocto build-tools tar command causes this pseudo abort:

path mismatch [1 link]: ino 3117695 db
'/.../build/build_output/work/all-distro-linux/autoconf-archive/2022.02.11-r0/package/usr/share/info'
req '/proc/self/fd/5/./usr/share/info'.

I was expecting that the /proc/self and /proc/self/fd/5 symlinks would be
resolved back into the file system and the chown would complete (I should
look and see why that didn't happen)

But this becomes is a very re-producible example of my recent problem for
which I excluded /proc
but sadly, by excluding /proc, I get:

4132110: chown ignored path, calling real syscall.
/.../x86_64-buildtools-extended-nativesdk-standalone-3.4/sysroots/x86_64-pokysdk-linux/usr/bin/tar:
./usr/share: Cannot change ownership to uid 0, gid 0: Invalid argument

Fortunately, the native tar uses a different chown method so for now I can
drop the build-tools tar
I think I'm going to have to revisit the problem that this languishing
patch was addressing in the context of the most current source, however I'm
aware the possible the yocto build-tools (3.4 in this case) are just
incompatible with pseudo in the same way that /dev/fd/3 also was, and I
just didn't properly understand the failure mechanism at the time.

Sam

On Sun, 7 Apr 2024 at 11:04, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Sat, 2024-04-06 at 12:03 +0100, Sam Liddicott wrote:
> > This is becoming a problem for quite a few of our developers who are
> > able to proceed with PSEUDO_IGNORE_PATHS:append=",/proc,/dev,/sys"
> >
> > I understand that PSEUDO_IGNORE_PATHS refers to the host file system
> > paths, not the pseudo file system paths so how does excluding these
> > cause a problem?
> >
> > I should add that we are also using the patch from Matt Cowell in
> > 2019:
> >
> > > From cb69146d18382f272e347338cfc5a8930f693ed6 Mon Sep 17 00:00:00
> > > 2001
> > > From: Matt Cowell <matt.cowell@nokia.com>
> > > Date: Wed, 17 Apr 2019 15:51:07 -0500
> > > Subject: [PATCH] pseudo_fix_path: do not expand symlinks in /proc
> >
> > otherwise our recipes fail on access to /dev/fd/3 and /dev/stdout and
> > "files" of that nature, due to pseudo failing to properly resolve
> > symlinks, as discussed
> > here: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13288#c14
> >
> > In any case, the general problem exists of how to deal with clashing
> > inodes. Perhaps we are more prone to this issue because we are using
> > user namespaces and mount namespaces to bind mount the build output
> > dir so that it always appears at the same path, so that we get better
> > SSTATE caching, maybe this makes inode clashing more likely.
>
> This get a bit tricky as you're using a patch we weren't able to merge
> because of issues, then you're running into issues and needing to add
> other changes on top. Your workflow sounds to be one the project isn't
> actively using right now. I can't tell if the original patch required
> the change, whether it's specific to your workflow or exactly which
> behaviour we're really trying to fix, or if it is really broken.
>
> I still suspect that some code may open via /proc/self/fd/X and then do
> chown() or similar on it and we'd then miss data we need. /sys and /dev
> are arguable and likely less of an issue.
>
> I haven't really used user namespaces/mounts so I don't know what the
> inode situation is there. Do they persist consistently between
> executions of bitbake or between processes? I suspect you're right and
> this is related to that, however since we don't use that and we don't
> have any examples of that code, it is hard to say.
>
> If the problem is different filesystems clashing, we may need to be
> more careful about storing filesystem/inode pairs. The hard part is
> finding an ID for the filesystem that will be consistent as some IDs we
> could use would change at reboot. That obviously will have a
> performance impact.
>
> Cheers,
>
> Richard
>

--000000000000e7992d0631658c36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>An interesting update from me, with my (now out-of-da=
te) pseudo version:</div><div><br></div><div>Without excluding /proc via PS=
EUDO_IGNORE_PATHS the chown executed by the yocto build-tools tar command c=
auses this pseudo abort: <br><p><span class=3D"gmail-code">path mismatch [1=
 link]: ino 3117695 db &#39;/.../build/build_output/work/all-distro-linux/a=
utoconf-archive/2022.02.11-r0/package/usr/share/info&#39; req &#39;/proc/se=
lf/fd/5/./usr/share/info&#39;.</span></p><p><span class=3D"gmail-code">I wa=
s expecting that the /proc/self and /proc/self/fd/5 symlinks would be resol=
ved back into the file system and the chown would complete (I should look a=
nd see why that didn&#39;t happen)</span></p><p><span class=3D"gmail-code">=
But this becomes is a very re-producible example of my recent problem for w=
hich I excluded /proc<br>but sadly, by excluding /proc, I get:</span></p><p=
>4132110: chown ignored path, calling real syscall.<br>/.../x86_64-buildtoo=
ls-extended-nativesdk-standalone-3.4/sysroots/x86_64-pokysdk-linux/usr/bin/=
tar: ./usr/share: Cannot change ownership to uid 0, gid 0: Invalid argument=
</p><p>Fortunately, the native tar uses a different chown method so for now=
 I can drop the build-tools tar</p>I think I&#39;m going to have to revisit=
 the problem that this languishing patch was addressing in the context of t=
he most current source, however I&#39;m aware the possible the yocto build-=
tools (3.4 in this case) are just incompatible with pseudo in the same way =
that /dev/fd/3 also was, and I just didn&#39;t properly understand the fail=
ure mechanism at the time.</div><div><br></div><div>Sam</div></div><br><div=
 class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Sun, 7 Apr 2024 at 11:04, Richard Purdie &lt;<a href=3D"mailto:r=
ichard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Sat=
, 2024-04-06 at 12:03 +0100, Sam Liddicott wrote:<br>
&gt; This is becoming a problem for quite a few of our developers who are<b=
r>
&gt; able to proceed with PSEUDO_IGNORE_PATHS:append=3D&quot;,/proc,/dev,/s=
ys&quot;<br>
&gt; <br>
&gt; I understand that PSEUDO_IGNORE_PATHS refers to the host file system<b=
r>
&gt; paths, not the pseudo file system paths so how does excluding these<br=
>
&gt; cause a problem?<br>
&gt; <br>
&gt; I should add that we are also using the patch from Matt Cowell in<br>
&gt; 2019:<br>
&gt; <br>
&gt; &gt; From cb69146d18382f272e347338cfc5a8930f693ed6 Mon Sep 17 00:00:00=
<br>
&gt; &gt; 2001<br>
&gt; &gt; From: Matt Cowell &lt;<a href=3D"mailto:matt.cowell@nokia.com" ta=
rget=3D"_blank">matt.cowell@nokia.com</a>&gt;<br>
&gt; &gt; Date: Wed, 17 Apr 2019 15:51:07 -0500<br>
&gt; &gt; Subject: [PATCH] pseudo_fix_path: do not expand symlinks in /proc=
<br>
&gt; <br>
&gt; otherwise our recipes fail on access to /dev/fd/3 and /dev/stdout and<=
br>
&gt; &quot;files&quot; of that nature, due to pseudo failing to properly re=
solve<br>
&gt; symlinks, as discussed<br>
&gt; here:=C2=A0<a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?i=
d=3D13288#c14" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctop=
roject.org/show_bug.cgi?id=3D13288#c14</a><br>
&gt; <br>
&gt; In any case, the general problem exists of how to deal with clashing<b=
r>
&gt; inodes. Perhaps we are more prone to this issue because we are using<b=
r>
&gt; user namespaces and mount namespaces to bind mount the build output<br=
>
&gt; dir so that it always appears at the same path, so that we get better<=
br>
&gt; SSTATE caching, maybe this makes inode clashing more likely.<br>
<br>
This get a bit tricky as you&#39;re using a patch we weren&#39;t able to me=
rge<br>
because of issues, then you&#39;re running into issues and needing to add<b=
r>
other changes on top. Your workflow sounds to be one the project isn&#39;t<=
br>
actively using right now. I can&#39;t tell if the original patch required<b=
r>
the change, whether it&#39;s specific to your workflow or exactly which<br>
behaviour we&#39;re really trying to fix, or if it is really broken.<br>
<br>
I still suspect that some code may open via /proc/self/fd/X and then do<br>
chown() or similar on it and we&#39;d then miss data we need. /sys and /dev=
<br>
are arguable and likely less of an issue.<br>
<br>
I haven&#39;t really used user namespaces/mounts so I don&#39;t know what t=
he<br>
inode situation is there. Do they persist consistently between<br>
executions of bitbake or between processes?=C2=A0I suspect you&#39;re right=
 and<br>
this is related to that, however since we don&#39;t use that and we don&#39=
;t<br>
have any examples of that code, it is hard to say.<br>
<br>
If the problem is different filesystems clashing, we may need to be<br>
more careful about storing filesystem/inode pairs. The hard part is<br>
finding an ID for the filesystem that will be consistent as some IDs we<br>
could use would change at reboot. That obviously will have a<br>
performance impact. <br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--000000000000e7992d0631658c36--

