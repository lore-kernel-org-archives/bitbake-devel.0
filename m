Return-Path: <sam@liddicott.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30B2C54E41
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 15:14:33 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.27562.1709219665564973161
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Feb 2024 07:14:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@liddicott-com.20230601.gappssmtp.com header.s=20230601 header.b=L87q44mI;
 spf=none, err=SPF record not found (domain: liddicott.com, ip: 209.85.208.52, mailfrom: sam@liddicott.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56682b85220so1875643a12.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Feb 2024 07:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liddicott-com.20230601.gappssmtp.com; s=20230601; t=1709219663; x=1709824463; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hcFvbh9wLpVWzj3oP5o7u9ykdCTuhmRxu6cvD3lO0No=;
        b=L87q44mIZ7C0sqah8hUp5fh5+K0xAbvmPRw/i0HytK+PjUULsbt+Yj1TTisWGx2EHe
         /JZrP2L8laN1XZ1j4d+niPdmjkqwrNz8r5mb2/57ok2ZWZMtn3gy1ZHRlfRhcKxDWbCh
         lBrS5qguZ3oR0NAi3FBKa3UQjm4+xixorVOYkjOEQvfz4GawQGmFjMB8HLX2q+Myc572
         5pmT5KzyHA/YcY8EwYqKH1WCgWkblwcsDav4DeYq9ITRrNRA2aGBnvYSSpFlou3qzB/k
         p+v/jjdbFAZWoLO8qMOtVIj6zL6wtGOG/mMLnxJ7llUb5FeAeuoWBSHI57KQNcmMf2wA
         wh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219663; x=1709824463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcFvbh9wLpVWzj3oP5o7u9ykdCTuhmRxu6cvD3lO0No=;
        b=N3sOSPqzn+pzxWX9IBfDyKwAtnPvuU+CgCnBr7bSzFeRj3b8/x4HMnaUPGkG3AsIp4
         VWrM65LOW6W3OvqqJiGyboOv2tF0v3j5uEENCboY9yz+2kH0rkguPjjbNk1r8pYirNW+
         +5b/O/Dz8O20iDN7FCUDQinpBt6ZB4HP40Fxn/4y9+vUPsoMgF/iMSFZNJ+9EuZyqE7O
         WoMBFYCCDUDM9hvqVNwldE5VcowXCIYs5YoWpERTDRvWNdRiF+UU6iKPaHk5PFoqM5OS
         ZOQHCJqWLJNLD4lHFhAhAGpZZgG1H4uPkyq4JtPdtpnpn9gJc8FatKEu35eePjOKg3SC
         N6sw==
X-Gm-Message-State: AOJu0Yzc6cUkx+VH5fH34/oKKdnhk+DyUdp7xWLrUXTwzj9agum7EtnM
	rZLj9pJMrbvxcl6Qe522plvO9p43xpNFYb0rLdCTCG0t1eV2Z9N3+Wy2XwqEzzOaScxVy8e/6GW
	VTUQ8vo+glGDXfklu3V+xmX4IddGt8KqXzpvf
X-Google-Smtp-Source: AGHT+IFZ8Rc4ckhPph00hxsUIPDll43A30Za+ZgetOeOz0TzYbYAjANfvZdb3J7ldKBSjMIHeE3YbsnYXyF9xPKP5as=
X-Received: by 2002:a17:906:f198:b0:a42:e079:f94d with SMTP id
 gs24-20020a170906f19800b00a42e079f94dmr1879348ejb.57.1709219663466; Thu, 29
 Feb 2024 07:14:23 -0800 (PST)
MIME-Version: 1.0
References: <17B810A24531435C.23432@lists.openembedded.org>
 <CAOj-5WAohNpyHRFFWbBkm2CWnFnfzAit4Kxm2=9WsbKcSPeb+Q@mail.gmail.com> <fc3346c4a626f8a5cdb5805c2ea8b666065fc86f.camel@linuxfoundation.org>
In-Reply-To: <fc3346c4a626f8a5cdb5805c2ea8b666065fc86f.camel@linuxfoundation.org>
From: Sam Liddicott <sam@liddicott.com>
Date: Thu, 29 Feb 2024 15:13:47 +0000
Message-ID: <CAOj-5WAfNxb45fpSbaJ0EyVtTHMs4wXbF4NYpR_1EKx=Tk4raw@mail.gmail.com>
Subject: Re: [bitbake-devel] pseudo abort with req '/proc/self/fd/3'
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000e261c0061286b63e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Feb 2024 15:14:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15980

--000000000000e261c0061286b63e
Content-Type: text/plain; charset="UTF-8"

Won't the symlink target have its own db entry when resolved?

Or if not, how should we cope with the inode clashes across different file
systems?

On Thu, 29 Feb 2024 at 10:31, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2024-02-28 at 22:56 +0000, Sam Liddicott wrote:
> > Despite my hints I don't think it is safe to use dev_t as part of the
> > key because I don't think it is guaranteed to be consistent across
> > reboots or even remounts for the case where temporary file system
> > mounts (e.g. overlayfs) might be in use for the build workspace or
> > subdirs.
> >
> > (I am using bind mounting in a mount namespace during bitbake to make
> > sure all workspaces appear as the same path in order to get better
> > caching of sstate artifacts compile and install steps).
> >
> > So maybe we want to limit pseudo caching only to the workdir
> > filesystem by default, but certainly exclude /proc /dev etc
>
> Unfortunately it isn't that simple. /proc/ can contain links and
> references to other places on the system.
>
> Even with your example, /proc/self/fd/3 might be a file in workdir
> which has been opened by a process and given a file descriptor. If you
> perform an ownership/mode change on that /proc entry, pseudo does need
> to intercept it and apply it to the file in workdir.
>
> So whilst /dev and /sys are perhaps arguable, we do have to look at
> proc.
>
> Cheers,
>
> Richard
>

--000000000000e261c0061286b63e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Won&#39;t the symlink target have its own db entry when re=
solved?<div><br></div><div>Or if not, how should we cope with the inode cla=
shes across different file systems?</div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 29 Feb 2024 at 10:31, Rich=
ard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richar=
d.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Wed, 2024-02-28 at 22:56 +0000, Sam Liddicot=
t wrote:<br>
&gt; Despite my hints I don&#39;t think it is safe to use dev_t as part of =
the<br>
&gt; key because I don&#39;t think it is guaranteed to be consistent across=
<br>
&gt; reboots or even remounts for the case where temporary file system<br>
&gt; mounts (e.g. overlayfs) might be in use for the build workspace or<br>
&gt; subdirs.<br>
&gt; <br>
&gt; (I am using bind mounting in a mount namespace during bitbake to make<=
br>
&gt; sure all workspaces appear as the same path in order to get better<br>
&gt; caching of sstate artifacts compile and install steps).<br>
&gt; <br>
&gt; So maybe we want to limit pseudo caching only to the workdir<br>
&gt; filesystem by default, but certainly exclude /proc /dev etc<br>
<br>
Unfortunately it isn&#39;t that simple. /proc/ can contain links and<br>
references to other places on the system.<br>
<br>
Even with your example, /proc/self/fd/3 might be a file in workdir<br>
which has been opened by a process and given a file descriptor. If you<br>
perform an ownership/mode change on that /proc entry, pseudo does need<br>
to intercept it and apply it to the file in workdir.<br>
<br>
So whilst /dev and /sys are perhaps arguable, we do have to look at<br>
proc.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--000000000000e261c0061286b63e--

