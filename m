Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ACDC0032E
	for <webhook@archiver.kernel.org>; Wed, 25 Oct 2023 16:50:10 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.48833.1698252602339934913
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Oct 2023 09:50:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Gapou1/z;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so4001952f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 25 Oct 2023 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698252600; x=1698857400; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q5Ce7ZcDCcuY2kW/U5DDwHN5tmWBxwz0LyLex3PJedQ=;
        b=Gapou1/zXvkSM9F6iSpo3WRpH7IvR6GVCfUJOfUAamPR/A1WjLKpZO6CaSj5WWDqG3
         xzF+fzBOVBErzTtnRhb+opnqTXviFTWuZyS+xyPqD2I8M4IxprdKPdQRHpQEq2ClkIYY
         G58TdwE1UoA3Bm6K1ZDEL3iB0D8GOJ3WMPUXMUeln+PuK26sk4PFazFtlRXemcOSwx8+
         H4wsmmzRHhc00Fk3jD4f7K+4EbYiljFnARLJaw1UWjxf0dYs2YaMhu6tXfMtSDN9zbrJ
         pQ9U6RC5qf+2IdDLwirsmcqfWg7VFtAzr+oIfl6Jxa+stBn0k/Q1NSQBtvEmPjYdf3Og
         lLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698252600; x=1698857400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5Ce7ZcDCcuY2kW/U5DDwHN5tmWBxwz0LyLex3PJedQ=;
        b=oth+4IVTt0qBeW5RutJ9JhhQps5mzpEm5cpfbaX682INpXbvnBHr7SelQ56snY9wlS
         UTCCPFx1ZYQESFPakmIImZNammTJK29DowflSdxMRJd6PNqzxXoVP8DrsDqHm/u7WcJ/
         SZcgicxDrv2gXBj/Xb2Ve4h110NXOLV+oyAGPvakVc+1rG7OGPzz0C4HgrDhOXbGPXBO
         KCgy2BbUbmCDesbCyftIvl4x4zh7xZXt3gYB27pdrneyV79x4pnpGDGSWm5ciPZZrGzw
         h6ueBP2LluJ/ohUP5msF56LnvKeiIAKZQX85uUleMd6xTdStzZJKxfZVzLMCFjtKiohx
         099Q==
X-Gm-Message-State: AOJu0Yy5QrRPg7TVDiqOktsW6pdyDDe+Vb1LBYOnA/JhLuYPiM9a+O4n
	/4pn8WSIBFTANc4iE7BEiFcXtyeW3Z3sNB4YOn0=
X-Google-Smtp-Source: AGHT+IGvqn7Q46SL97UVHfBG6bJIQmbNiFEoX++RPHgNi60aR27MluLbXeojapAzB+EFIcZJI+RtE03W9vDrfGvsv/8=
X-Received: by 2002:a05:6000:80e:b0:32d:9585:8680 with SMTP id
 bt14-20020a056000080e00b0032d95858680mr16878036wrb.4.1698252600192; Wed, 25
 Oct 2023 09:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZje+vcoFiS5rHFn1rvUzmSo-++8VchDzTktSgxKLwD7F0Acg@mail.gmail.com>
 <CAJZje+tdOZPp73THMk6pZNLyzncLQcqTRcdyN=v99dJL_=430g@mail.gmail.com>
 <b8e4f99865416ec0f1a08e2dbade7a57863af4dd.camel@linuxfoundation.org> <CAJZje+uRHeKzj7z-6QYhr9BEEZs7ybAyJQSiVxDK3r7jxnHYgA@mail.gmail.com>
In-Reply-To: <CAJZje+uRHeKzj7z-6QYhr9BEEZs7ybAyJQSiVxDK3r7jxnHYgA@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 25 Oct 2023 18:49:48 +0200
Message-ID: <CA+chaQdbk3vABipQL89O2NZqkvB_7Rxf81tzouMN8sg1LZk0wQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2: git: Add git-lfs install step
To: Desone Burns <dburns@seegrid.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org, Joseph Chafin <jchafin@seegrid.com>
Content-Type: multipart/alternative; boundary="000000000000f933b206088d3ec1"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Oct 2023 16:50:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15286

--000000000000f933b206088d3ec1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I guess you needed git lfs install to configure lfs in your gitconfig like
e.g. git-lfs postinst does in ubuntu, for details see:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14938

there is also a link to new lfs selftest, but the expected behavior is
still unknown.

On Wed, Oct 25, 2023 at 6:30=E2=80=AFPM Desone Burns <dburns@seegrid.com> w=
rote:

> My mistake regarding the format of the patch, I can reupload as a v2 with
> the formatting corrected.
>
> With regards to this patch, I was having issues pulling a git repo
> containing an LFS, the smaller files would come through but the files
> actually stored under the LFS did not make it across. In my case, I was
> attempting to pull images stored in an LFS for a plymouth splash screen.
> The `git lfs install`, as far as I understand, sets up the cloned repo to
> also download the large files. Namely, it sets up the git hooks to allow
> the download to take place. When cloning the repo without running this
> install step, the files populate the `git` directory in the following
> format:
>
> version https://git-lfs.github.com/spec/v1
> oid sha256:<File SHA>
> size 1442
>
> This instructs the LFS application to download the large file, but withou=
t
> installing the LFS download step into the git hooks, the file remains in
> this format. This is all running under the assumption that the user does
> already have git-lfs installed on their system, although it may be worth
> investigating what minimum version of the application is required for thi=
s
> to work.
>
> I would be more than willing to write a test to cover this functionality,
> is there an available Yocto repo that contains an LFS I could test agains=
t?
>
> On Wed, Oct 25, 2023 at 5:27=E2=80=AFAM Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
>
>> On Tue, 2023-10-24 at 16:27 -0400, Desone Burns wrote:
>> > When pulling a Git repo that included LFS, it was possible that
>> > the LFS download would fail with a message regarding the LFS being
>> > installed in the repo. This change runs the LFS install step prior
>> > to checkout, to ensure the download step is included in the Git
>> > hooks.
>> >
>> > Signed-off-by: Desone Burns II <dburnsii@live.com>
>> > ---
>> >  bitbake/lib/bb/fetch2/git.py | 15 ++++++++++++---
>> >  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> Firstly, the patch didn't come through correctly and has line wrapping
>> and whitespace issues which would prevent it being applied.
>>
>> I'm also very unclear which lfs issues this patch fixes. There have
>> been a few changes around lfs recently and I can't tell if this is a
>> new issue, a regression with one of the recent changes or something
>> else. Which branch/revision was the original issue seen against?
>>
>> In general we'd expect a user to have git-lfs available in advance of
>> the builds and not to download and create a local install in the repo
>> during the fetch. I'm unclear what an "lfs install" does though so
>> perhaps I don't understand that.
>>
>> The patch also doesn't change any of our tests which ideally need
>> updating to include whatever issue this patch is fixing.
>>
>> Cheers,
>>
>> Richard
>>
>>
>
> --
> Desone Burns II
> Software Engineer III
> seegrid.com <https://www.seegrid.com/>  *=E2=80=A2*  412-379-4500
> m: 623-258-7361
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15285):
> https://lists.openembedded.org/g/bitbake-devel/message/15285
> Mute This Topic: https://lists.openembedded.org/mt/102165795/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000f933b206088d3ec1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I guess you needed git lfs install to configure lfs in you=
r gitconfig like e.g. git-lfs postinst does in ubuntu, for details see:<div=
><a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14938">http=
s://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14938</a><br></div><div><br=
></div><div>there is also a link to new lfs selftest, but the expected beha=
vior is still unknown.</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Oct 25, 2023 at 6:30=E2=80=AFPM Deson=
e Burns &lt;<a href=3D"mailto:dburns@seegrid.com">dburns@seegrid.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div di=
r=3D"ltr">My mistake regarding the format of the patch, I can reupload as a=
 v2 with the formatting corrected.<div><br></div><div>With regards to this =
patch, I was having issues pulling a git repo containing an LFS, the smalle=
r files would come through but the files actually stored under the LFS did =
not make it across. In my case, I was attempting to pull images stored in a=
n LFS for a plymouth splash screen. The `git lfs install`, as far as I unde=
rstand, sets up the cloned repo to also download the large files. Namely, i=
t sets up the git hooks to allow the download to take place. When cloning t=
he repo without running this install step, the files populate the `git` dir=
ectory in the following format:</div><div><br></div><div>version <a href=3D=
"https://git-lfs.github.com/spec/v1" target=3D"_blank">https://git-lfs.gith=
ub.com/spec/v1</a><br>oid sha256:&lt;File SHA&gt;<br>size 1442<br></div><di=
v><br></div><div>This instructs the LFS application to download the large f=
ile, but without installing the LFS download step into the git hooks, the f=
ile remains in this format. This is all running under the assumption that t=
he user does already have git-lfs installed on their system, although it ma=
y be worth investigating what minimum version of the application is require=
d for this to work.=C2=A0</div><div><br></div><div>I would be more than wil=
ling to write a test to cover this functionality, is there an available Yoc=
to repo that contains an LFS I could test against?</div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 25, 202=
3 at 5:27=E2=80=AFAM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@li=
nuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On T=
ue, 2023-10-24 at 16:27 -0400, Desone Burns wrote:<br>
&gt; When pulling a Git repo that included LFS, it was possible that<br>
&gt; the LFS download would fail with a message regarding the LFS being<br>
&gt; installed in the repo. This change runs the LFS install step prior<br>
&gt; to checkout, to ensure the download step is included in the Git<br>
&gt; hooks.<br>
&gt; <br>
&gt; Signed-off-by: Desone Burns II &lt;<a href=3D"mailto:dburnsii@live.com=
" target=3D"_blank">dburnsii@live.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0bitbake/lib/bb/fetch2/git.py | 15 ++++++++++++---<br>
&gt; =C2=A01 file changed, 12 insertions(+), 3 deletions(-)<br>
<br>
Firstly, the patch didn&#39;t come through correctly and has line wrapping<=
br>
and whitespace issues which would prevent it being applied.<br>
<br>
I&#39;m also very unclear which lfs issues this patch fixes. There have<br>
been a few changes around lfs recently and I can&#39;t tell if this is a<br=
>
new issue, a regression with one of the recent changes or something<br>
else. Which branch/revision was the original issue seen against?<br>
<br>
In general we&#39;d expect a user to have git-lfs available in advance of<b=
r>
the builds and not to download and create a local install in the repo<br>
during the fetch. I&#39;m unclear what an &quot;lfs install&quot; does thou=
gh so<br>
perhaps I don&#39;t understand that.<br>
<br>
The patch also doesn&#39;t change any of our tests which ideally need<br>
updating to include whatever issue this patch is fixing.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<div style=3D"height:64px">
<div style=3D"max-width:510px;max-height:64px">
<table width=3D"510" height=3D"64" style=3D"width:510px;height:64px">
<tbody>
<tr>
<td width=3D"1" style=3D"padding:8px 12px 0px 4px;vertical-align:top;width:=
1px"><img src=3D"https://hub.seegrid.com/hubfs/Brand/SeegridLogo_vert.png" =
width=3D"59.0" height=3D"62.0" style=3D"width: 59px; height: 62px;"></td>
<td width=3D"1" style=3D"border-right:2px solid rgb(0,130,210);width:2px"><=
/td>
<td style=3D"padding:4px 0px 0px 20px;vertical-align:top;line-height:22px">=
<span style=3D"color:rgb(0,130,210);font-family:Helvetica,sans-serif;font-w=
eight:bold">Desone Burns II</span><br>
<span style=3D"color:rgb(0,19,33);margin-bottom:8px;font-weight:bold;font-f=
amily:Helvetica,Arial,sans-serif;font-size:14px">Software Engineer III</spa=
n><br>
<table>
<tbody>
<tr>
<td style=3D"padding:8px 0px;margin:0px"><a href=3D"https://www.seegrid.com=
/" style=3D"color:rgb(110,110,108);font-family:Helvetica,Arial,sans-serif;f=
ont-weight:bold;font-size:13px" target=3D"_blank">seegrid.com</a> =C2=A0<b =
style=3D"color:rgb(0,130,205);font-family:Arial,Helvetica,sans-serif;font-s=
ize:10px">=E2=80=A2</b>=C2=A0
<span style=3D"color:rgb(110,110,108);font-family:Helvetica,Arial,sans-seri=
f;font-weight:bold;font-size:13px">
412-379-4500</span><br>
<span style=3D"color:rgb(0,130,205);font-family:Helvetica,Arial,sans-serif;=
font-size:11px;font-weight:bolder">m:</span>
<span style=3D"color:rgb(110,110,108);font-family:Helvetica,Arial,sans-seri=
f;font-weight:bold;font-size:13px">
623-258-7361</span></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<br>
</div>
</div>

</div></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15285): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15285" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15285</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102165795/361=
7156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/102165795/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:martin.jansa@gmail.com" target=3D"=
_blank">martin.jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000f933b206088d3ec1--

