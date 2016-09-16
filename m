Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id AA51360107
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 20:04:21 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id 2so7691632oif.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=uxxM66tP162jfV31lnctlu1Y4L6WwYLb9O9yylqYElA=;
	b=YTIac9xOllsAcrZuxA7T/TYq+RZH1Y8hjunE6o2EaIP8b3U5kjS2KHWcQeluQOO+v8
	6LW6MjJiT4ARw+p2+0obtd0+oIzSIFhcW8lXnEtSo2eFrEMWzeOEolH52cTtHoqg0988
	2eYk0YgKjj17ZWDoydbmublKs4AHHbV0VagpbaHqzJ4GY87ZJSGacumfL2k4PAao8ab9
	f5q0t6V07EdqbbQ77RPBo45VHURPpAnP825MHslOUucPeuaWw8BXNvilL9rI0o4NtcU3
	3wPmOsVQiFMcmpb83pdzSgeGvWry0wRVQdujZrHnO5wyy8Q1rB18tQ/141xz3UxRXak3
	zWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=uxxM66tP162jfV31lnctlu1Y4L6WwYLb9O9yylqYElA=;
	b=YUimVs/o6HQG7T0nUaCZsYolZDXb/xe46VDEXozVgdO2F2fN436LDtx1Hx8CmZt2QU
	g20ToUc+ufmNvPw7b3NkZVMwe4YjdzZjXhSkRKRPEmbCl3cypp4frpQ+hLNqPpl5JJBx
	DvAWSpNJQS/NS6LZh8vtS4hiE6nU6Sq7prlGtPL0a3FEXd5RbSa2qOPAOszqZjTpOGvL
	D9f6aKT+jJ7iVVQZoLjPb1TKExKbFuHxEDgAbBuTFicqng6ZaG+6iw+3U50Z999yxCtY
	rDZ4OfYWqxdjFsjWL8jCp11NFkSjk4rr3dDxlhqTwIOBiRXleNWskV5e1MqMfTmLAe3d
	qgyQ==
X-Gm-Message-State: AE9vXwP/dGbLOW07QQ5nRt3G4RzVR6kRT6nGBAhhbPe4cV3vu/QiVlQXI10/Mh/05Hh9ySqlZI6uTQ6PxbkNFg==
X-Received: by 10.202.5.4 with SMTP id 4mr15629558oif.31.1474056262047; Fri,
	16 Sep 2016 13:04:22 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Fri, 16 Sep 2016 13:04:01 -0700 (PDT)
In-Reply-To: <CABcZANkJmsD1OfPDu0B1nnLBxH+U8S5O2h5pzXDSij3gdG3aoA@mail.gmail.com>
References: <1474056041-11200-1-git-send-email-kergoth@gmail.com>
	<CABcZANkJmsD1OfPDu0B1nnLBxH+U8S5O2h5pzXDSij3gdG3aoA@mail.gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Fri, 16 Sep 2016 13:04:01 -0700
X-Google-Sender-Auth: iHaGfMpAx3hx2g-ETxZam9ZRqNY
Message-ID: <CABcZANmG8-=EZOs9hpC27CJHxEBx3-ncOdkgtPiEZ2fdJWN7EQ@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH] bb.build: in _exec_task, catch errors from TaskStarted
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
X-List-Received-Date: Fri, 16 Sep 2016 20:04:21 -0000
Content-Type: multipart/alternative; boundary=94eb2c18d092e0e2c0053ca577f4

--94eb2c18d092e0e2c0053ca577f4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2016 at 1:01 PM, Christopher Larson <chris_larson@mentor.co=
m
> wrote:

> On Fri, Sep 16, 2016 at 1:00 PM, Christopher Larson <kergoth@gmail.com>
> wrote:
>
>> From: Christopher Larson <chris_larson@mentor.com>
>>
>> We want any exceptions raised by the TaskStarted event handlers to be
>> caught
>> rather than unconditionally hitting the exception formatting + traceback
>> in
>> exec_task, otherwise we can't cleanly exit the task with a nice message
>> from
>> such a handler.
>>
>> This is done via a separate try/catch block, to avoid firing TaskFailed
>> if all
>> the TaskStarted event handlers didn't complete, otherwise the bitbake UI=
s
>> get
>> unhappy.
>>
>> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
>>
>
> This supercedes 'bb.build: in _exec_task, catch BBHandledException=E2=80=
=99.
>

Sigh, copy/paste error. This supercedes 'bb.build: in _exec_task, move
TaskStarted into try/except=E2=80=99. We want this and the BBHandledExcepti=
on patch
both applied. I=E2=80=99ll just send a v2 to avoid confusion :)
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--94eb2c18d092e0e2c0053ca577f4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Sep 16, 2016 at 1:01 PM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:chris_larson@mentor.com" target=3D"_blank">chris_larson@me=
ntor.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex"><span class=3D"gmail-"=
><div class=3D"gmail_quote">On Fri, Sep 16, 2016 at 1:00 PM, Christopher La=
rson <span dir=3D"ltr">&lt;<a href=3D"mailto:kergoth@gmail.com" target=3D"_=
blank">kergoth@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-lef=
t-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div>Fro=
m: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor.com" target=
=3D"_blank">chris_larson@mentor.com</a>&gt;<br>
<br>
We want any exceptions raised by the TaskStarted event handlers to be caugh=
t<br>
rather than unconditionally hitting the exception formatting + traceback in=
<br>
exec_task, otherwise we can&#39;t cleanly exit the task with a nice message=
 from<br>
such a handler.<br>
<br>
This is done via a separate try/catch block, to avoid firing TaskFailed if =
all<br>
the TaskStarted event handlers didn&#39;t complete, otherwise the bitbake U=
Is get<br>
unhappy.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com" target=3D"_blank">chris_larson@mentor.com</a>&gt;</div></blockquote><=
/div><br></span>This supercedes &#39;bb.build: in _exec_task, catch BBHandl=
edException=E2=80=99.<br></blockquote><div><br></div><div>Sigh, copy/paste =
error. This supercedes &#39;bb.build: in _exec_task, move TaskStarted into =
try/except=E2=80=99. We want this and the BBHandledException patch both app=
lied. I=E2=80=99ll just send a v2 to avoid confusion :)</div></div>-- <br><=
div class=3D"gmail_signature"><div dir=3D"ltr">Christopher Larson<br>kergot=
h at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Mainta=
iner - Tslib<br>Senior Software Engineer, Mentor Graphics</div></div>
</div></div>

--94eb2c18d092e0e2c0053ca577f4--
