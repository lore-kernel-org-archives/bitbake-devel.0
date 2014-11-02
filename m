Return-Path: <ross.burton@intel.com>
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com
	[209.85.192.54])
	by mail.openembedded.org (Postfix) with ESMTP id 045BB65C87
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  2 Nov 2014 21:01:01 +0000 (UTC)
Received: by mail-qg0-f54.google.com with SMTP id q108so7787016qgd.41
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 02 Nov 2014 13:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=b3yhYrsg7ewvPFotqltcbykNbIJyWn9i67DEWyxgeQc=;
	b=hnTrMZqezaJQc9RDVv0bF0ZZcVkbAzO0pcq8a2J6uEkq43i7fKJHS+zksikgZlPqDN
	BlHV88X/z6/lTu5D8dGE81GYzf9DIiH9rGOtIn7xm4Dp3+9MlsTIe8jyq39nFYScZ/e3
	pnvrPza/SufpJkIUvBGhm2Ro8Y0kAWMzZOGfoO5vlbpsib+OUNvfBdD1fz8fNVP8vDSu
	sgZbO8D2MBAC+4jZYkWHVKe2FGExZWG67SRZixZaxMmJd60dUsrxuTvatmEP9UX9BpT4
	erV47Oag1WCrwiq2BcWxWSMNScT2/JIGqxM3GFBPTHmlCteh/TAf+BeN3WHqLflKkiN5
	N5ng==
X-Gm-Message-State: ALoCoQkcHAO0LVBzveWOgquofZbRAo2B7H7p6QuRTkdcGin3fcioQdLDj99sSQv0RuE0gZ6q1unm
X-Received: by 10.229.224.201 with SMTP id ip9mr58593677qcb.5.1414962062166;
	Sun, 02 Nov 2014 13:01:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.98.213 with HTTP; Sun, 2 Nov 2014 13:00:41 -0800 (PST)
In-Reply-To: <1414430843-27307-1-git-send-email-ben.shelton@ni.com>
References: <1414430843-27307-1-git-send-email-ben.shelton@ni.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Sun, 2 Nov 2014 21:00:41 +0000
Message-ID: <CAJTo0LbVu4NGfLMOPqV1uSfnL3QLS0=cZCcAd-9ScxxxvTY8zw@mail.gmail.com>
To: Ben Shelton <ben.shelton@ni.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] prserv: don't wait until exit to sync
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
X-List-Received-Date: Sun, 02 Nov 2014 21:01:04 -0000
Content-Type: multipart/alternative; boundary=001a1135ef1e1625350506e6874b

--001a1135ef1e1625350506e6874b
Content-Type: text/plain; charset=UTF-8

On 27 October 2014 17:27, Ben Shelton <ben.shelton@ni.com> wrote:

> In the commit 'prserv: Ensure data is committed', the PR server moved to
> only committing transactions to the database when the PR server is
> stopped.  This improves performance, but it means that if the machine
> running the PR server loses power unexpectedly or if the PR server
> process gets SIGKILL, the uncommitted package revision data is lost.
>
> To fix this issue, sync the database periodically, once per 30 seconds
> by default, if it has been marked as dirty.  To be safe, continue to
> sync the database at exit regardless of its status.
>

This appears to be causing random problems for me where bitbake will
timeout attempting to access the PR database, my hunch is that it's
blocking on disk I/O.  Are there any tricks we can do with sqlite to reduce
the overhead of committing? (assuming that sqlite isn't causing a full
filesystem sync).

Ross

--001a1135ef1e1625350506e6874b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 27 October 2014 17:27, Ben Shelton <span dir=3D"ltr">&lt;<a href=3D"mail=
to:ben.shelton@ni.com" target=3D"_blank">ben.shelton@ni.com</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div id=3D":2ac" class=3D"a3s" sty=
le=3D"overflow:hidden">In the commit &#39;prserv: Ensure data is committed&=
#39;, the PR server moved to<br>
only committing transactions to the database when the PR server is<br>
stopped.=C2=A0 This improves performance, but it means that if the machine<=
br>
running the PR server loses power unexpectedly or if the PR server<br>
process gets SIGKILL, the uncommitted package revision data is lost.<br>
<br>
To fix this issue, <span class=3D"il">sync</span> the database periodically=
, once per 30 seconds<br>
by default, if it has been marked as dirty.=C2=A0 To be safe, continue to<b=
r>
<span class=3D"il">sync</span> the database at exit regardless of its statu=
s.</div></blockquote></div><br>This appears to be causing random problems f=
or me where bitbake will timeout attempting to access the PR database, my h=
unch is that it&#39;s blocking on disk I/O.=C2=A0 Are there any tricks we c=
an do with sqlite to reduce the overhead of committing? (assuming that sqli=
te isn&#39;t causing a full filesystem sync).</div><div class=3D"gmail_extr=
a"><br></div><div class=3D"gmail_extra">Ross</div></div>

--001a1135ef1e1625350506e6874b--
