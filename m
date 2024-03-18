Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FABC54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 15:33:15 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web11.47694.1710775990645310813
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Mar 2024 08:33:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=d8mQccqf;
 spf=pass (domain: gmail.com, ip: 209.85.128.171, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60a0a54869bso41055837b3.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710775990; x=1711380790; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A9Uawt83oqIfcA/uOnpB7VypO3rruSlVsD7BL7AF9y4=;
        b=d8mQccqfe500ToaOWMbNPOcUm9OX4KOzNF5T9k+H/db7e6SL37ccCrvT68CiJxuAvv
         VhAkVd8bUMiN5NqA6d/fIeeQo/WfJsg8yHGMRqf4BJlsrLYrcefRhHI6jA/moswrZJNU
         oc6t6UWmTnwuo9dPVvxAAw4UsXxVcd57O/38/eJfbUEo2fhNhKbJTZ+M3Hm1jRHlFJm5
         W8TuMIQyv9F+Lej421O8Pyj+qnz3IjYvPH+3mK5Lopx2KlBRlt+Jedj1nxA1YaQ+7D8r
         rXMragoAgF7rpLGyRnx0rhnQZrUwuIOZ8S5Jg8plLGEqHWBa2GwFab6TcEtzgbMJTiJl
         EOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710775990; x=1711380790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9Uawt83oqIfcA/uOnpB7VypO3rruSlVsD7BL7AF9y4=;
        b=n+2fjtDY7Seh/MN2iqof7SNN3g2jKVk0adwRDzLtdaz10FJdeSl/LIONN1zs+9AE4h
         dEcJ6ec3/UgsgQpzTHEUkP0lGMEgKWVNKUTmKfGhNZxzk1PKJIoB8jGOZk5ulKRskPMj
         AdJ9xSmiCGBQuSbfsvt7NUo3+an5/QkwSxEU9BBxoMkOirdauj6dZIA4hxJgqKJhwRv/
         G9oK6utF/0DeMA6gwShZvNQ0fSHflkVfk5Mv1IPN+TJNgetMGs3b7XL90+bx6+FLI2Hl
         HfyoKszVFf3fy1ppQMi5pouIQ6XRwtgtg9UA/GcGfBuSesEE88/tkohp35Rp9zDAtsUn
         KYXw==
X-Forwarded-Encrypted: i=1; AJvYcCVAwJbJtS1s+ue5ya9dnwotzvYxYG1ehhrzvzBmMdsXhiBeGCjCAds6fDmT9QGT/0/HfZG8iSgxjQSQ2huGtQ+59jQ3xmf7onhLTaE7VgGzLv67KXM=
X-Gm-Message-State: AOJu0YyuASheD3Ov8VLfTBb4rZHRsSrQby8mXENFHmw4ID2Wfm4AtoxG
	wvu8BsPdS4r/Wo8YuWEuz5v893q+LAsIOMz4F6wmflCoHjrTgz3OJfDsjJX8Mu+rlCD65EbUD1B
	WCnr7RmlYwSt3t9toty+TwHm3g4OLaeOHvuU=
X-Google-Smtp-Source: AGHT+IHr0aS3x1OcV/D47vYumlGlk/DmuHVpvpmZZExImvCPpajTdQD4+QHWyt1vr2UnRcjfsvB5ODqeye1Izd9DjOk=
X-Received: by 2002:a0d:ff02:0:b0:610:c644:4b78 with SMTP id
 p2-20020a0dff02000000b00610c6444b78mr2257335ywf.16.1710775989589; Mon, 18 Mar
 2024 08:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <99f6d56b-8013-4255-bd96-5a66bb9130f4@bootlin.com> <CAMSfU+6=j7mzh0_WtRh5D-QNotqcwjEGMbYjqomaYRLs6G1LEg@mail.gmail.com>
In-Reply-To: <CAMSfU+6=j7mzh0_WtRh5D-QNotqcwjEGMbYjqomaYRLs6G1LEg@mail.gmail.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Mon, 18 Mar 2024 08:32:58 -0700
Message-ID: <CANx9H-BkB++OFjmGCYguHGLnP6ukrMCULkxGks-yPma_wfe2KA@mail.gmail.com>
Subject: Re: [bitbake-devel] How to turn a poky patch into a bitbake one?
To: Yoann Congal <yoann.congal@smile.fr>
Cc: michael.opdenacker@bootlin.com, 
	BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000265d3a0613f113bc"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 15:33:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16005

--000000000000265d3a0613f113bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:17=E2=80=AFAM Yoann Congal <yoann.congal@smile.fr=
> wrote:

>
>
> Le lun. 18 mars 2024 =C3=A0 15:41, Michael Opdenacker via
> lists.openembedded.org <michael.opdenacker=3D
> bootlin.com@lists.openembedded.org> a =C3=A9crit :
>
>> Greetings,
>>
>> For testing convenience, I made BitBake changes directly in the Poky tre=
e.
>>
>> Before I re-apply my changes to a BitBake tree before submitting them,
>> in a very manual way (like removing "bitbake/"  in the paths in my
>> generated patches), would you have a nicer way to turn my changes under
>> Poky's "bitbake/" subdirectory into a proper pathset for BitBake?
>>
>> Git tips appreciated. I guess I'm not the first one to do this :-}
>>
>
> FWIW, I do:
> * patch/test/commit in poky
> * git format-patch
> * patchtest
> * and then, I have repos for contribution (splitted poky : oe-core,
> meta-yocto, yocto-docs, bitbake, ...). Those repos are set up with
> git-configs to set the correct recipient and [tag][PATCH] when
> git-send-email.
> To import in the bitbake repo, I'd use "git am -p2 <patch from poky.git>"
>
> I've tried to use combo-layer for this but never found the right process.
>

I have used some of the hints in:
https://stackoverflow.com/questions/16526321/how-to-apply-a-git-patch-to-a-=
file-with-a-different-name-and-path

Although it's been a couple months since I was doing bitbake work so my
brain forgot the commands (and history didn't find them either).


>
>
>> Cheers
>> Michael.
>>
>> --
>> Michael Opdenacker, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com
>>
>>
>>
>>
>>
>
> --
> Yoann Congal
> Smile ECS - Tech expert
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16004):
> https://lists.openembedded.org/g/bitbake-devel/message/16004
> Mute This Topic: https://lists.openembedded.org/mt/105004317/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000265d3a0613f113bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 18, 2024 at 8:17=E2=80=AF=
AM Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr">yoann.congal@s=
mile.fr</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0lun. 18 mars 2024 =C3=
=A0=C2=A015:41, Michael Opdenacker via <a href=3D"http://lists.openembedded=
.org" target=3D"_blank">lists.openembedded.org</a> &lt;michael.opdenacker=
=3D<a href=3D"mailto:bootlin.com@lists.openembedded.org" target=3D"_blank">=
bootlin.com@lists.openembedded.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Greetings,<br>
<br>
For testing convenience, I made BitBake changes directly in the Poky tree.<=
br>
<br>
Before I re-apply my changes to a BitBake tree before submitting them, <br>
in a very manual way (like removing &quot;bitbake/&quot;=C2=A0 in the paths=
 in my <br>
generated patches), would you have a nicer way to turn my changes under <br=
>
Poky&#39;s &quot;bitbake/&quot; subdirectory into a proper pathset for BitB=
ake?<br>
<br>
Git tips appreciated. I guess I&#39;m not the first one to do this :-}<br><=
/blockquote><div><br></div><div>FWIW, I do:</div><div>* patch/test/commit i=
n poky</div><div>* git format-patch</div><div>* patchtest</div><div>* and t=
hen, I have repos for contribution (splitted poky : oe-core, meta-yocto, yo=
cto-docs, bitbake, ...). Those repos are set up with git-configs to set the=
 correct recipient and [tag][PATCH] when git-send-email.</div><div>To impor=
t in the bitbake repo, I&#39;d use &quot;git am -p2 &lt;patch from poky.git=
&gt;&quot;<br></div><div><br></div><div>I&#39;ve tried to use combo-layer f=
or this but never found the right process.<br></div></div></div></blockquot=
e><div><br></div><div>I have used some of the hints in:</div><div><a href=
=3D"https://stackoverflow.com/questions/16526321/how-to-apply-a-git-patch-t=
o-a-file-with-a-different-name-and-path">https://stackoverflow.com/question=
s/16526321/how-to-apply-a-git-patch-to-a-file-with-a-different-name-and-pat=
h</a></div><div><br></div><div>Although it&#39;s been a couple months since=
 I was doing bitbake work so my brain forgot the commands (and history didn=
&#39;t find them either).</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Cheers<br>
Michael.<br>
<br>
-- <br>
Michael Opdenacker, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><font face=3D"Raleway, regular">Yoann Congal</font><div><font face=3D"R=
aleway, regular">Smile ECS - Tech expert<br></font></div></div></div></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16004): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16004" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16004</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/105004317/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/105004317/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000265d3a0613f113bc--

