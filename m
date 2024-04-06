Return-Path: <sam@liddicott.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A20FC67861
	for <webhook@archiver.kernel.org>; Sat,  6 Apr 2024 11:04:28 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.15845.1712401459372708657
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Apr 2024 04:04:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@liddicott-com.20230601.gappssmtp.com header.s=20230601 header.b=iR8Ck00X;
 spf=none, err=SPF record not found (domain: liddicott.com, ip: 209.85.218.54, mailfrom: sam@liddicott.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4715991c32so427522166b.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Apr 2024 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liddicott-com.20230601.gappssmtp.com; s=20230601; t=1712401457; x=1713006257; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dbBeY5pO49l/KqinEMo7ly7R2JPIYht/78GRTx23mF4=;
        b=iR8Ck00XZTHZZ4g651By270p7pAhGV5UJFdocElwtQjuWCZfRrD7V/MopLZniRfOyt
         /quJV1mT5QN9sF14s5LU0PXy5TSPpAzDAGpwunS/0v005G7Vwz23hEowNN6ZzU3gC3ox
         8hUjGEa3wJnR2bSdJlaXm9Q6lyGVqKhXhkW1W+Ci3Xz9KrfiPcwmm2y0z6qBnBdBcAKE
         3iRIDO6DZ1osBXO/0ALpLuOBSPo7qkU1BLaeYGXdsnhmRh0vME/ckAX990+Sact+j3yE
         OyYTLI4dbE7cuc+I2zXNyVyV2NI3D/LHsVnM7QheFHeFHTArB0jMgNTHCTZa0goqkqaH
         3ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712401457; x=1713006257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbBeY5pO49l/KqinEMo7ly7R2JPIYht/78GRTx23mF4=;
        b=jhOamvad0SLuApG2nW/Uni9X+n5vAQj1eMS87NnBr1JS5eDVux0GWP+c6ax2uGK28f
         dxNNYyR/YVW71IuQsWMaUTxMuzIrMwTrB7QDRNTjod1tvhC0n68XlwxKob/xeijci42i
         eP1b2u/cShDiwK+iVtfp2k91V2X1k/dqV/CahpRUDX0d9GCxz8zxf951P8JKOyl+hJMH
         DMOZTIjqJ1YU0A1iZlTpQhh1vCip8dq0wyZjRSv4Yop6+/T3hLUckx283ey4d15tKKcZ
         D6CwHyRM/7qZhkG0WHhRj/UyamOPu1EZWtiO7hqNVKgHwhmUYvlpG7UkHUm8kRCFByQl
         vDGA==
X-Forwarded-Encrypted: i=1; AJvYcCUE23rEfvoDKTWDS51R23HOcE3YD/vnUk2z/LFduEoeq/zNLk8h0FQbptCdoeJ4aX0/+/ZJ1Djm/PwvZbg1YYylCNkdw9ISk7SLe2ZDEFHzuOD1nz8=
X-Gm-Message-State: AOJu0YzmsmgADmK62xJpcYmGhP9z4aks8BA6dT14745YG9ICbnKpuyZb
	y/GD/UbRLKmQrCZBVXXxpufs/e/yKW9iN+gwCpze5tWEd5aoYtHFhsIHhbITy5ik31nJTz0RukP
	f/RL+ziq2uk8zuEHhpvRyiE4ZUC1tynpMHrWE
X-Google-Smtp-Source: AGHT+IEWb1BBfAUazrf8d77yFpvb7pk7K2qPO+5hBO0ZcvwWthpU7uEX8LZBtaBEq/lNqFNu/wNa6KXRuJ7afaBNFKs=
X-Received: by 2002:a17:906:5296:b0:a51:b23c:13f8 with SMTP id
 c22-20020a170906529600b00a51b23c13f8mr1389039ejm.1.1712401457568; Sat, 06 Apr
 2024 04:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <17B810A24531435C.23432@lists.openembedded.org>
 <CAOj-5WAohNpyHRFFWbBkm2CWnFnfzAit4Kxm2=9WsbKcSPeb+Q@mail.gmail.com>
 <fc3346c4a626f8a5cdb5805c2ea8b666065fc86f.camel@linuxfoundation.org> <17B85E3B078DFE63.18468@lists.openembedded.org>
In-Reply-To: <17B85E3B078DFE63.18468@lists.openembedded.org>
From: Sam Liddicott <sam@liddicott.com>
Date: Sat, 6 Apr 2024 12:03:41 +0100
Message-ID: <CAOj-5WCj04cnjeNrkfF2igx6a5nxERTFhKhd02q_NTd97AzYwA@mail.gmail.com>
Subject: Re: [bitbake-devel] pseudo abort with req '/proc/self/fd/3'
To: sam@liddicott.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org, matt.cowell@nokia.com
Content-Type: multipart/alternative; boundary="0000000000009782ab06156b8884"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 06 Apr 2024 11:04:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16061

--0000000000009782ab06156b8884
Content-Type: text/plain; charset="UTF-8"

This is becoming a problem for quite a few of our developers who are able
to proceed with PSEUDO_IGNORE_PATHS:append=",/proc,/dev,/sys"

I understand that PSEUDO_IGNORE_PATHS refers to the host file system paths,
not the pseudo file system paths so how does excluding these cause a
problem?

I should add that we are also using the patch from Matt Cowell in 2019:

> From cb69146d18382f272e347338cfc5a8930f693ed6 Mon Sep 17 00:00:00 2001
> From: Matt Cowell <matt.cowell@nokia.com>
> Date: Wed, 17 Apr 2019 15:51:07 -0500
> Subject: [PATCH] pseudo_fix_path: do not expand symlinks in /proc

otherwise our recipes fail on access to /dev/fd/3 and /dev/stdout and
"files" of that nature, due to pseudo failing to properly resolve symlinks,
as discussed here:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=13288#c14

In any case, the general problem exists of how to deal with clashing
inodes. Perhaps we are more prone to this issue because we are using user
namespaces and mount namespaces to bind mount the build output dir so that
it always appears at the same path, so that we get better SSTATE caching,
maybe this makes inode clashing more likely.

Sam


On Thu, 29 Feb 2024 at 15:14, Sam Liddicott via lists.openembedded.org <sam=
liddicott.com@lists.openembedded.org> wrote:

> Won't the symlink target have its own db entry when resolved?
>
> Or if not, how should we cope with the inode clashes across different file
> systems?
>
> On Thu, 29 Feb 2024 at 10:31, Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
>
>> On Wed, 2024-02-28 at 22:56 +0000, Sam Liddicott wrote:
>> > Despite my hints I don't think it is safe to use dev_t as part of the
>> > key because I don't think it is guaranteed to be consistent across
>> > reboots or even remounts for the case where temporary file system
>> > mounts (e.g. overlayfs) might be in use for the build workspace or
>> > subdirs.
>> >
>> > (I am using bind mounting in a mount namespace during bitbake to make
>> > sure all workspaces appear as the same path in order to get better
>> > caching of sstate artifacts compile and install steps).
>> >
>> > So maybe we want to limit pseudo caching only to the workdir
>> > filesystem by default, but certainly exclude /proc /dev etc
>>
>> Unfortunately it isn't that simple. /proc/ can contain links and
>> references to other places on the system.
>>
>> Even with your example, /proc/self/fd/3 might be a file in workdir
>> which has been opened by a process and given a file descriptor. If you
>> perform an ownership/mode change on that /proc entry, pseudo does need
>> to intercept it and apply it to the file in workdir.
>>
>> So whilst /dev and /sys are perhaps arguable, we do have to look at
>> proc.
>>
>> Cheers,
>>
>> Richard
>>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15980):
> https://lists.openembedded.org/g/bitbake-devel/message/15980
> Mute This Topic: https://lists.openembedded.org/mt/104624826/7497305
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> sam@liddicott.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--0000000000009782ab06156b8884
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This is becoming a problem for quite a few of our develope=
rs who are able to proceed with PSEUDO_IGNORE_PATHS:append=3D&quot;,/proc,/=
dev,/sys&quot;<div><br></div><div>I understand that PSEUDO_IGNORE_PATHS ref=
ers to the host file system paths, not the pseudo file system paths so how =
does excluding these cause a problem?</div><div><br></div><div>I should add=
 that we are also using the patch from Matt Cowell in 2019:</div><div><br><=
/div><div>&gt; From cb69146d18382f272e347338cfc5a8930f693ed6 Mon Sep 17 00:=
00:00 2001<br>&gt; From: Matt Cowell &lt;<a href=3D"mailto:matt.cowell@noki=
a.com">matt.cowell@nokia.com</a>&gt;<br>&gt; Date: Wed, 17 Apr 2019 15:51:0=
7 -0500<br>&gt; Subject: [PATCH] pseudo_fix_path: do not expand symlinks in=
 /proc<br></div><div><br></div><div>otherwise our recipes fail on access to=
 /dev/fd/3 and /dev/stdout and &quot;files&quot; of that nature, due to pse=
udo failing to properly resolve symlinks, as discussed here:=C2=A0<a href=
=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13288#c14">https://=
bugzilla.yoctoproject.org/show_bug.cgi?id=3D13288#c14</a><br></div><div><br=
></div><div>In any case, the general problem exists of how to deal with cla=
shing inodes. Perhaps we are more prone to this issue because we are using =
user namespaces and mount namespaces to bind mount the build output dir so =
that it always appears at the same path, so that we get better SSTATE cachi=
ng, maybe this makes inode clashing more likely.</div><div><br><div>Sam</di=
v><div><br></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">On Thu, 29 Feb 2024 at 15:14, Sam Liddicott via <a h=
ref=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt;sam=3D=
<a href=3D"mailto:liddicott.com@lists.openembedded.org">liddicott.com@lists=
.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><div dir=3D"ltr">Won&#39;t the symlink target have its own=
 db entry when resolved?<div><br></div><div>Or if not, how should we cope w=
ith the inode clashes across different file systems?</div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 29 Feb 20=
24 at 10:31, Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfound=
ation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 2024=
-02-28 at 22:56 +0000, Sam Liddicott wrote:<br>
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
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15980): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15980" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15980</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/104624826/749=
7305" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/104624826/7497305</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:sam@liddicott.com" target=3D"_blan=
k">sam@liddicott.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000009782ab06156b8884--

