Return-Path: <sidebranch.openembedded@gmail.com>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
	[209.85.214.181])
	by mail.openembedded.org (Postfix) with ESMTP id 613AD608A6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2013 14:47:01 +0000 (UTC)
Received: by mail-ob0-f181.google.com with SMTP id dn14so3643432obc.26
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2013 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=svmgHs/kfXmPw5+qAryFwIU8lFAmGUPWCqW9oGVgPIQ=;
	b=pMWciRCOSpO0PwX2YByZ6iBRpEVHS/ITywA/HS1HRLa0IbfDp30QgTnUPotWpPUcmu
	S2XvB0GijhxOqKW5uNAirvRagSnzdPG8TcbFkoj04RpihqB19MVjZ/Qxa6ls74atv8ze
	u1DjT8vdBrGvTNhuWQ5+02lrYe00b+u2NhYFyBZoRKQyhIiUL0dFQMq/5aRVx5sS28Pr
	kuGdz9nlMdh2yyvxjf/AdFZsQgWxvtjJ9ZYVeouTXR5lHhHfmATpAitBJO/JA71OtNGY
	xD0itsG1GpI9ppbGvrHPvbSl1gCN2Cy3TmKe1IdO/PsB4C9IR+HDmLGH+YHGeg0QxzLH
	xplg==
MIME-Version: 1.0
X-Received: by 10.60.131.3 with SMTP id oi3mr1438852oeb.104.1377182820723;
	Thu, 22 Aug 2013 07:47:00 -0700 (PDT)
Received: by 10.76.1.194 with HTTP; Thu, 22 Aug 2013 07:47:00 -0700 (PDT)
In-Reply-To: <1376644859-11034-1-git-send-email-nicolas.dechesne@linaro.org>
References: <1376644859-11034-1-git-send-email-nicolas.dechesne@linaro.org>
Date: Thu, 22 Aug 2013 16:47:00 +0200
Message-ID: <CAMvUbCxhEEyp5dCZjN0fidBJxxgX55CXL88ErL5u5bkz1rOdEQ@mail.gmail.com>
From: Leon Woestenberg <sidebranch.openembedded@gmail.com>
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Cc: bitbake-devel@lists.openembedded.org, patches@linaro.org
Subject: Re: [RFC PATCH] build.py: create symlink for run.do_xxx scripts
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
X-List-Received-Date: Thu, 22 Aug 2013 14:47:02 -0000
Content-Type: multipart/alternative; boundary=089e01183b9cd1f2a204e48a5c59

--089e01183b9cd1f2a204e48a5c59
Content-Type: text/plain; charset=ISO-8859-1

Hello Nicolas,

On Fri, Aug 16, 2013 at 11:20 AM, Nicolas Dechesne <
nicolas.dechesne@linaro.org> wrote:

> The 'courtesy' symlink for log.do_xxx are quite useful when debugging, so
> with this commit, we now get similar 'courtesy' symlink for run.do_xxx
> scripts.
>
> Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> ---
>

At least I can +1 on the debugging helpfulness, I would like this feature
to be in bitbake.

As it's a courtesy link only, the chosen approach seems good to me.

Regards,

Leon.

--089e01183b9cd1f2a204e48a5c59
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hello Nicolas,<br><br></div><di=
v class=3D"gmail_extra"><div class=3D"gmail_quote">On Fri, Aug 16, 2013 at =
11:20 AM, Nicolas Dechesne <span dir=3D"ltr">&lt;<a href=3D"mailto:nicolas.=
dechesne@linaro.org" target=3D"_blank">nicolas.dechesne@linaro.org</a>&gt;<=
/span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">The &#39;courtesy&#39; symlink for log.do_xx=
x are quite useful when debugging, so<br>
with this commit, we now get similar &#39;courtesy&#39; symlink for run.do_=
xxx<br>
scripts.<br>
<br>
Signed-off-by: Nicolas Dechesne &lt;<a href=3D"mailto:nicolas.dechesne@lina=
ro.org" target=3D"_blank">nicolas.dechesne@linaro.org</a>&gt;<br>
---<br>
</blockquote><br></div>At least I can +1 on the debugging helpfulness, I wo=
uld like this feature to be in bitbake.<br><br></div><div class=3D"gmail_ex=
tra">As it&#39;s a courtesy link only, the chosen approach seems good to me=
.<br>
<br>Regards,<br><br>Leon.<br></div></div>

--089e01183b9cd1f2a204e48a5c59--
