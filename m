Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com
	[209.85.213.172])
	by mail.openembedded.org (Postfix) with ESMTP id 534DE76A66
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 18:06:40 +0000 (UTC)
Received: by igxp17 with SMTP id p17so111623749igx.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 11:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=eI5OobegMBzHR53AN75g28+97NY/Y+euwLFhuJIOM7Y=;
	b=ClLQYdOvC76Aeqjic/62xFGJQ/NVQYfAXoHdx3c8TbYP7BLMgemNsFyBdQyg+PeRxh
	gwWHVcdSCbz4qE85rdszKtuJn1PWhRbGxLUSCynX+R0eLTl7StqhlQeNLHW0aM6buzDL
	hYW16aaflyZFnNFQJ08MBVBR+odKvgsX1c+L2NX902Jk6jcgwo8Ui/G9J4Rj24zZJmWw
	lBqL4pnb3pq02l9Ppi4C5lJtZbDBDzmdLZ2NtUARhUKzBq1zl5t8STLFnWakVbr+ZCur
	LJ9Q1RbQwXBuSxZMsRA+BuxWRjKdWfvZP2QzV4v0Tut+Ut6/qrpyrp//ATF7uUhLSOAo
	Wxcw==
X-Received: by 10.50.103.71 with SMTP id fu7mr31014009igb.38.1440007600927;
	Wed, 19 Aug 2015 11:06:40 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.118.150 with HTTP; Wed, 19 Aug 2015 11:06:21 -0700 (PDT)
In-Reply-To: <CABcZANnRPgVmdnE8Bn6iPn2Vm7KbyExw+ejY1aqkJ+ZZj5hGQw@mail.gmail.com>
References: <1438629643-28786-1-git-send-email-kergoth@gmail.com>
	<CABcZANnRPgVmdnE8Bn6iPn2Vm7KbyExw+ejY1aqkJ+ZZj5hGQw@mail.gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Wed, 19 Aug 2015 11:06:21 -0700
X-Google-Sender-Auth: C0h76q12lSGWtSmXrItbSxwlaIw
Message-ID: <CABcZANns=AwBB=bVyL7jfLC6YahDoX5sfxLB+Z76=kNUk2p1MA@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH] bb.build: delete tasks thoroughly
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
X-List-Received-Date: Wed, 19 Aug 2015 18:06:42 -0000
Content-Type: multipart/alternative; boundary=047d7b2e11e786fd5d051dade551

--047d7b2e11e786fd5d051dade551
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 3, 2015 at 12:21 PM, Christopher Larson <chris_larson@mentor.com
> wrote:

> On Mon, Aug 3, 2015 at 12:20 PM, Christopher Larson <kergoth@gmail.com>
> wrote:
>
>> From: Christopher Larson <chris_larson@mentor.com>
>>
>> We want addtask to be able to bring back a deleted task, but we don't
>> want its
>> previous dependencies to come back with it, so rather than marking a task
>> as
>> deleted and then skipping tasks marked as such, actually delete the task
>> and
>> its dependency information in deltask.
>>
>> While we're in that part of the code, also fix a couple 'not foo in bar'
>> instances to 'foo not in bar', which is preferred in python.
>>
>> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
>>
>
> This supercedes `[PATCH] bb.build: let addtask undo a deltask`.
>

Ping :)
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7b2e11e786fd5d051dade551
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Aug 3, 2015 at 12:21 PM, Christopher Larson <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:chris_larson@mentor.com" target=3D"_blank">chris_larson@mentor=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D=
"">On Mon, Aug 3, 2015 at 12:20 PM, Christopher Larson <span dir=3D"ltr">&l=
t;<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com<=
/a>&gt;</span> wrote:<br></span><div class=3D"gmail_extra"><div class=3D"gm=
ail_quote"><span class=3D""><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Christophe=
r Larson &lt;<a href=3D"mailto:chris_larson@mentor.com" target=3D"_blank">c=
hris_larson@mentor.com</a>&gt;<br>
<br>
We want addtask to be able to bring back a deleted task, but we don&#39;t w=
ant its<br>
previous dependencies to come back with it, so rather than marking a task a=
s<br>
deleted and then skipping tasks marked as such, actually delete the task an=
d<br>
its dependency information in deltask.<br>
<br>
While we&#39;re in that part of the code, also fix a couple &#39;not foo in=
 bar&#39;<br>
instances to &#39;foo not in bar&#39;, which is preferred in python.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com" target=3D"_blank">chris_larson@mentor.com</a>&gt;<br></blockquote><di=
v><br></div></span><div>This supercedes `[PATCH] bb.build: let addtask undo=
 a deltask`.</div></div></div></blockquote></div><br>Ping :)<br>-- <br><div=
 class=3D"gmail_signature"><div dir=3D"ltr">Christopher Larson<br>kergoth a=
t gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintaine=
r - Tslib<br>Senior Software Engineer, Mentor Graphics</div></div>
</div></div>

--047d7b2e11e786fd5d051dade551--
