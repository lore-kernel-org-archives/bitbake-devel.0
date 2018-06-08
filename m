Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.161.196])
	by mail.openembedded.org (Postfix) with ESMTP id 0F408745F2
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jun 2018 12:37:04 +0000 (UTC)
Received: by mail-yw0-f196.google.com with SMTP id p14-v6so4064942ywm.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Jun 2018 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=0tcZpcYHUtq+Pc6jTI520p9kmZOu6dPiloktsPczpRE=;
	b=kg4RCztv8WkEbpXR9YoO2ErxlgYRDu4buJLeZp/o7rgaaNLpjQXgbX40WpkRVgydVq
	NKmhwfkPNO6WTFq/TCHHVmZTW3NWy/7MIteMwW08byvvLJd7lRZ+JMaiaBH/5XmoZpY9
	jnsiF1WhLTAoj7mgwyxsFVe7P+04TORO1Bm5TZnvfI6QC6+14PgD74mA9mP6uy8ynXQq
	gchdEcWq3m7eb6xvkJ3oLkEZqH9ZVwPhsw5jIwJ6IjxuHLcFc5tsgXJs/aFaBFa3qYJS
	3BY6pBsPhGD+YhpNIepbOqS5hV3GaEBZq/xf+o9OVTEmjo3oyUZxkxMoaZFqFtlkDETh
	bleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=0tcZpcYHUtq+Pc6jTI520p9kmZOu6dPiloktsPczpRE=;
	b=D0v0aVTsoiyKHc2swWTA/St8z9j+VuyDmPDjSWlJt9/oZjbO8Ria4M54/ggTRBIP4k
	MMeqw4A6lRZibLCC7KcBy36wslbhYc3eCiUqd4tLNWaJOs/SMQdfoL3CoI+CL67HbmZK
	YJA3gqq3EwD/TsEmrezH5gFhWDql6ShFA2iMCSc6QU6Fsr2o1bheVHh/YbOJU5yOpUdj
	MmfZnYKMXn8N3LkVt34L8uiwEYYpoFHzktiQW8cVp6Ei3CzkBd7yECDqnYKjh63mZvUU
	9cDiACZV0aCRT9NFAueE/QZZnXjEvpPDfcT2tj5WLXhMzirl+afrbNMjXgmce5eHHUNH
	ANmw==
X-Gm-Message-State: APt69E0yXO0hcVwbxunnYk2+Esu39ug0bKx6EjJ3AtLD4yxSgrz3ho7Z
	B7hR9QVnxH28nAIO/w6aWh2Z9Ff4EdWrjNZ2hhg=
X-Google-Smtp-Source: ADUXVKKV6Sfk8QgepXHmPtznTM3MStSfZemucfvjmcvNjTToEeOHlAI1+lEXFUwkEJMKSCz8jKTCAxYM2YCev+gfXY4=
X-Received: by 2002:a81:2d5:: with SMTP id
	204-v6mr3212223ywc.134.1528461425849; 
	Fri, 08 Jun 2018 05:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180525134537.27659-1-matt.hoosier@gmail.com>
	<03bb3ecd46e56bc21799d56f723bc01d966230c8.camel@linuxfoundation.org>
	<CAJgxT3_8t-OKSuAvY_NJKWoiAXfs_YuTmB9S6K-MV9QBYJhh_g@mail.gmail.com>
	<f6d6f5fa735580808180883de3eed143c10d6002.camel@linuxfoundation.org>
	<CAJgxT39m+ex8F+mjaq5+zzxps7DaPO=iUu=1PO=U3SW-NWp5_Q@mail.gmail.com>
	<CAJgxT3__308KPPC9MS+xOA9ExnUgYAx6bS82RLfG41A8vk=pBg@mail.gmail.com>
	<65e369d383320a651429a9b59a8eb71c862b1d95.camel@linuxfoundation.org>
In-Reply-To: <65e369d383320a651429a9b59a8eb71c862b1d95.camel@linuxfoundation.org>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Fri, 8 Jun 2018 07:36:29 -0500
Message-ID: <CAJgxT3_UDioHqCadrXKBqJYw1GE54mgcK5DM_RB68_kCCfTdDA@mail.gmail.com>
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v5] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Fri, 08 Jun 2018 12:37:05 -0000
Content-Type: multipart/alternative; boundary="00000000000057403a056e20a815"

--00000000000057403a056e20a815
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 8, 2018 at 5:20 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Thu, 2018-06-07 at 08:47 -0500, Matt Hoosier wrote:
> > Thanks for the help getting this landed. With this change being part
> > of Bitbake, what's the procedure for attempting to get it backported
> > to the final MR of Yocto 2.2? Do I just backport it to a certain
> > maintenance branch of Bitbake (announced somehow with a prefix on the
> > git-send-email subject) and it would magically pop up out the
> > corresponding branch of poky if accepted to Bitbake?
>
> With bitbake its a case of requesting backports to the appropriate
> stable release branches, either in the form of a patch with [1.3X] in
> the subject, or just mention which revision to cherry-pick to which
> branch if it cherry-picks cleanly.
>
> I think to get back to 2.2, we'd have to backport to 1.38, 1.36, 1.34
> and 1.32. I do get nervous about patches which land in master and then
> immediately get backported across so many releases. I'm less nervous if
> the patches cleanly cherry-pick as at least the code is the same. How
> cleanly does it backport?
>
> Cheers,
>
> Richard
>
>
It's not a completely clean back-port; some of the context lines don't
match because of changes to the logic that detect when a repository uses
gitsubmodules to begin with. The actual logic changes lift pretty-much
straight in though.

I appreciate your point about being cautious when putting unproven code
straight into a branch that gets used for maintenance releases though. So I
could understand wanting to let it prove out on master for a while.
Conversely, there are no recipes in Poky that use gitsm to begin with, so I
don't know how much additional confidence would really be gained just
through time. Is that also an argument that the potential impact to the
stable branch of poky's own metadata is small?

--00000000000057403a056e20a815
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Fri, Jun 8, 2018 at 5:20 AM Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundati=
on.org</a>&gt; wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">On Thu, 2018-06-07 at 08:47 -0500, Matt Hoosier wrote:<br>
&gt; Thanks for the help getting this landed. With this change being part<b=
r>
&gt; of Bitbake, what&#39;s the procedure for attempting to get it backport=
ed<br>
&gt; to the final MR of Yocto 2.2? Do I just backport it to a certain<br>
&gt; maintenance branch of Bitbake (announced somehow with a prefix on the<=
br>
&gt; git-send-email subject) and it would magically pop up out the<br>
&gt; corresponding branch of poky if accepted to Bitbake?<br>
<br>
With bitbake its a case of requesting backports to the appropriate<br>
stable release branches, either in the form of a patch with [1.3X] in<br>
the subject, or just mention which revision to cherry-pick to which<br>
branch if it cherry-picks cleanly.<br>
<br>
I think to get back to 2.2, we&#39;d have to backport to 1.38, 1.36, 1.34<b=
r>
and 1.32. I do get nervous about patches which land in master and then <br>
immediately get backported across so many releases. I&#39;m less nervous if=
<br>
the patches cleanly cherry-pick as at least the code is the same. How<br>
cleanly does it backport?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br></blockquote><div><br></div><div>It&#39;s not a completely clean back-p=
ort; some of the context lines don&#39;t match because of changes to the lo=
gic that detect when a repository uses gitsubmodules to begin with. The act=
ual logic changes lift pretty-much straight in though.</div><div><br></div>=
<div>I appreciate your point about being cautious when putting unproven cod=
e straight into a branch that gets used for maintenance releases though. So=
 I could understand wanting to let it prove out on master for a while. Conv=
ersely, there are no recipes in Poky that use gitsm to begin with, so I don=
&#39;t know how much additional confidence would really be gained just thro=
ugh time. Is that also an argument that the potential impact to the stable =
branch of poky&#39;s own metadata is small?</div></div></div>

--00000000000057403a056e20a815--
