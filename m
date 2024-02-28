Return-Path: <sam@liddicott.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF44EC5478C
	for <webhook@archiver.kernel.org>; Wed, 28 Feb 2024 15:32:34 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.16372.1709134347042146876
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Feb 2024 07:32:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@liddicott-com.20230601.gappssmtp.com header.s=20230601 header.b=ISYC8iHr;
 spf=none, err=SPF record not found (domain: liddicott.com, ip: 209.85.218.50, mailfrom: sam@liddicott.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a43fc42e697so92223666b.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Feb 2024 07:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liddicott-com.20230601.gappssmtp.com; s=20230601; t=1709134345; x=1709739145; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OP3bnfUUUcS2B0HGQ5a8OUwoxjP14dDmBa6CEJIJfyk=;
        b=ISYC8iHrZKia+UYLccNTs5yS8bFeKMopN2aP1bdEaGL6rYLMyoAel71GWrqskg3wGp
         t4N7kgcb9vGYbIQQSx1dcD2N9AC8YtBe7cwX2peI3YMkXWqGixVOryOgsBjw/1s2tVK5
         ILaL4wMNNtbjoCZsd6m0RZ5/w+CLoL0/Mm7eUQytEmBUCMsdLYrGDx1q/uGeUfBMjrIW
         pI44SzMjDcFFNpNNq/G3X0dh5zIC9WhTb1UuL3u0TmJYjRhn0FqJpvG6U9GbYv5lgQnd
         AJax66B6UccdnFwfGCK0By/AjX+ERfhEhax5/7MJdp7niMLYUBZnX4GSu/5eqPUsJI7f
         PZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709134345; x=1709739145;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OP3bnfUUUcS2B0HGQ5a8OUwoxjP14dDmBa6CEJIJfyk=;
        b=cqcbesIx7mm0T5ikGEt+ydRrquuYHz4YYJP8j3HgP5fkNCORAw27C0WPekbu8KH5Gk
         oZWC3rR2yv8oNGQlNZSZMdwnESyecj+OvATvDVMpcFTEbL8V3xtfZYGHf7fpzV+eJPQH
         QVABLluMmSuvYcQQnLKd3w8TDEJo0usiFmxQoEq1iZcoQ4SL4+JPdljtvKnzxmdMfZrS
         F+WUan8MN92JUvkNmyFgezpdARqovzwAi98joHY0Usa2W4cozlnn3TLstmjvVXX5AmdD
         LttGjpbGCZoowH04IvM6/ew9XoTOHrCjdmpXVMOKZX1nrdQMgq3p80MaPGMMZt9taAUW
         4KzA==
X-Gm-Message-State: AOJu0YyQ6/lioyNeyg2xNaXx8BcnxrBh0Y3hEITM5AyALmJZ92BHMGCC
	5jcAQTPGwk3UahWEFj5qxoI15nAN2ZWLSgnR7ZMzRmFzIyFgGMUzzrJE3VRFAmpBXmaNkrqjyMb
	wPLHlePfWcWIOSRUguzVUkfXKHjzhKbEPldb8iDGlJR1tx3j+zA==
X-Google-Smtp-Source: AGHT+IHM8F7jOCaWSlbCum0DgjXeLHvVuM/k9+X3y16isSCIkKqlnUUuoOjfYwFlsdXnKvHpMGwkjcNDw4cT9kTKHyo=
X-Received: by 2002:a17:906:228a:b0:a41:2f5e:f9b4 with SMTP id
 p10-20020a170906228a00b00a412f5ef9b4mr27989eja.59.1709134344587; Wed, 28 Feb
 2024 07:32:24 -0800 (PST)
MIME-Version: 1.0
From: Sam Liddicott <sam@liddicott.com>
Date: Wed, 28 Feb 2024 15:31:48 +0000
Message-ID: <CAOj-5WALHrqvDkVbSe4YdjF-Ad-D=Qn4DQNYAhSg5Sw3fzKxDQ@mail.gmail.com>
Subject: pseudo abort with req '/proc/self/fd/3'
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000007ba0c7061272d94a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Feb 2024 15:32:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15975

--0000000000007ba0c7061272d94a
Content-Type: text/plain; charset="UTF-8"

On a kirkstone build I just got an unexpected and reproducible do_install
abort:

| abort()ing pseudo client by server request. See
https://wiki.yoctoproject.org/wiki/Pseudo_Abort for more details on this.
... path mismatch [1 link]: ino 594677 db '/.../common/config/private' req
'/proc/self/fd/3'
A conflict with /proc is most surprising, why is that even in the pseudo
database?

Adding this line to the global config fixed it consistently:
PSEUDO_IGNORE_PATHS:append=",/proc,/dev,/sys"

But I wondered how there was a conflict, and then I looked again at the
abort message.

Is it possible that pseudo only uses inode number without the dev node as
the key?

           struct stat {
               dev_t     st_dev;         /* ID of device containing file */
               ino_t     st_ino;         /* Inode number */

I would think that only the combination of both is unique across the system.

If dev_t is not part of the key, then I suggest that all paths are ignored
that are not on the same dev_t as the workspace.

Sam

--0000000000007ba0c7061272d94a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On a kirkstone build I just got an unexpected and reproduc=
ible do_install abort:<div><br></div><div><code class=3D"gmail-code gmail-c=
ss-1o5d2cw" style=3D"font-family:SFMono-Medium,&quot;SF Mono&quot;,&quot;Se=
goe UI Mono&quot;,&quot;Roboto Mono&quot;,&quot;Ubuntu Mono&quot;,Menlo,Con=
solas,Courier,monospace;font-size:0.875em;color:rgb(23,43,77);border-style:=
none;display:inline;padding:2px 0.5ch 2px 0.5ch;overflow:auto;background-im=
age:initial;background-position:initial;background-size:initial;background-=
repeat:initial;background-origin:initial;background-clip:initial;line-heigh=
t:1.33333;letter-spacing:-0.07px">| abort()ing pseudo client by server requ=
est. See <a href=3D"https://wiki.yoctoproject.org/wiki/Pseudo_Abort">https:=
//wiki.yoctoproject.org/wiki/Pseudo_Abort</a> for more details on this.
...
path mismatch [1 link]: ino 594677 db &#39;/.../common/config/private&#39; =
req &#39;/proc/self/fd/3&#39;

</code><div>A conflict=C2=A0with=C2=A0/proc is most surprising, why is that=
 even in the pseudo database?</div></div><div><br></div><div>Adding this li=
ne to the global config fixed it consistently:</div><div>PSEUDO_IGNORE_PATH=
S:append=3D&quot;,/proc,/dev,/sys&quot;<br></div><div><br></div><div>But I =
wondered how there was a conflict, and then I looked again at the abort mes=
sage.</div><div><br></div><div>Is it possible that pseudo only uses inode n=
umber without the dev node as the key?</div><div><br></div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stat {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_t =C2=A0 =C2=A0 st_dev; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* ID of device containing file */<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ino_t =C2=A0 =C2=A0 st_ino; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* Inode number */<br></div><div><br></div><div>I would think=
 that only the combination of both is unique across the system.</div><div><=
br></div><div>If dev_t is not part of the key, then I suggest that all path=
s are ignored that are not on the same dev_t as the workspace.</div><div><b=
r></div><div>Sam</div></div>

--0000000000007ba0c7061272d94a--

