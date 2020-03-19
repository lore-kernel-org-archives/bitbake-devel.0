Return-Path: <mhalstead@linuxfoundation.org>
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
	[209.85.167.174])
	by mail.openembedded.org (Postfix) with ESMTP id 546E560FEC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Mar 2020 16:44:54 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id b17so3362178oic.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Mar 2020 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=PHT0ibg/IfCI9Z7QE6cxK1xt/RNq3J/mKnMXaMNQgDM=;
	b=FlFAC4pExC2YxCrloI+bpptOiV67xIbqj8REcdzE/eOarukLXVfMnFbCa+8mpoDDS0
	FPWOjWjZPB+SAY8gjWpyovtwjRmCgkdmeHJEEsCp0PYhb9qzC9+IKJdG11nhngxlykZP
	IfFylI9qoPXLfAEiYhWu5FdqIMybYNVH9d4Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=PHT0ibg/IfCI9Z7QE6cxK1xt/RNq3J/mKnMXaMNQgDM=;
	b=TMICATmhleaGYiOAa7hO9Lo9iffnx+h3g25NDEqwcVyhhTd5bD+ooij7W81VVdkP9Q
	8P+k/2TFxm1iy2dTGWvmG9a2bghlDxnyy09CmfJNFtEtQ3sA67dfQY7pYfbYh//z85q7
	pC3m9JRNwL8Id8mbhKgbW5gp6PPi/zQTipvuZjNB4AIUuFgBVDb/UDJPYpioEE13q+N+
	Vagr2ZbBGhnpeMa9T1aBCNWgi5ugN1CYoQ5A4ieKH8mb75puVETYd+N1O3hHsjkNpQTF
	ZOLhjySJkGxPyVAjiDs3XKvOFo+fEvrDrP4OprBIxsWgRIHEaBqYplsrd9zyRzQ7Dp4z
	B5vw==
X-Gm-Message-State: ANhLgQ260fk2e584UYDzW8sGoRUerNbL+CjqDSsoiNceCvC/3PSSTMTa
	aFNNeXYknSvFhZEX8TdSzGUGOpyij8cf5vwWI1GkTAQUQcibPw==
X-Google-Smtp-Source: ADFU+vsbozWCzHOBfG0Encl02Jiy1tH9FESgJh6BE8rNrAb81tAJhvLpjJhfAo3bEUJyO/fse8dfWAeOtuGWbFZxdvM=
X-Received: by 2002:aca:56c2:: with SMTP id k185mr2909127oib.141.1584636295002;
	Thu, 19 Mar 2020 09:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <CADfgfobNNXr9HSOiwyamzbZ4q1uc8wgD5PzobDF56cDyYui-HQ@mail.gmail.com>
In-Reply-To: <CADfgfobNNXr9HSOiwyamzbZ4q1uc8wgD5PzobDF56cDyYui-HQ@mail.gmail.com>
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Thu, 19 Mar 2020 09:44:43 -0700
Message-ID: <CADfgfoYCjVip=oc_U0TdFzOVst5U-KU+R31JhdckRv77APzQ-g@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org, 
	openembedded-core <openembedded-core@lists.openembedded.org>, 
	openembedded-architecture@lists.openembedded.org, 
	openembeded-devel <Openembedded-devel@lists.openembedded.org>
Subject: Re: Mailing list platform change March 20th
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
X-List-Received-Date: Thu, 19 Mar 2020 16:44:55 -0000
Content-Type: multipart/alternative; boundary="00000000000076507b05a137e391"

--00000000000076507b05a137e391
Content-Type: text/plain; charset="UTF-8"

Everything is proceeding smoothly and this work will continue as planned.
The migration starts at noon PDT tomorrow.

List owners please take care of all outstanding moderation in the next 24
hours to ensure a smooth transition.

Thank you,
--
Michael Halstead
Linux Foundation / Yocto Project
Systems Operations Engineer

On Fri, Mar 13, 2020 at 4:58 PM Michael Halstead <
mhalstead@linuxfoundation.org> wrote:

> We are moving our lists from Mailman to Groups.io. E-mail to lists will
> be delayed during the move window. We are aiming to complete the migration
> during business hours in the Pacific time zone.
>
> A new account will be created for you on the Groups.io platform if you
> don't already have one.
>
> You can read more about the change on the wiki:
> https://www.openembedded.org/wiki/GroupsMigration
>
> If there are serious issues we will rollback the changes. We will e-mail
> all lists when work is complete.
>
> --
> Michael Halstead
> Linux Foundation / Yocto Project
> Systems Operations Engineer
>
>

--00000000000076507b05a137e391
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Everything is proceeding smoothly and this work will conti=
nue as planned. The migration starts at noon PDT tomorrow.<div><br></div><d=
iv>List owners please take care of all outstanding moderation in the next 2=
4 hours to ensure a smooth transition.</div><div><br></div><div>Thank you,<=
/div><div>--<br>Michael Halstead<br>Linux Foundation / Yocto Project<br>Sys=
tems Operations Engineer<br></div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 13, 2020 at 4:58 PM Michael H=
alstead &lt;<a href=3D"mailto:mhalstead@linuxfoundation.org">mhalstead@linu=
xfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"ltr"><div>We are moving our lists from Mailman t=
o=C2=A0<span>Groups</span>.<span>io</span>. E-mail to lists will be delayed=
 during the move window. We are aiming to complete the migration during bus=
iness hours in the Pacific time zone.<br></div><div><br></div><div>A new ac=
count will be created for you on the=C2=A0<span>Groups</span>.<span>io</spa=
n>=C2=A0platform if you don&#39;t already have one.<br></div><div><br></div=
><div>You can read more about the change on the wiki:<br></div><a href=3D"h=
ttps://www.openembedded.org/wiki/GroupsMigration" target=3D"_blank">https:/=
/www.openembedded.org/wiki/GroupsMigration</a><br><div><br></div><div>If th=
ere are serious issues we will rollback the changes. We will e-mail<br>all =
lists when work is complete.<br></div><div><br></div><div><span style=3D"co=
lor:rgb(136,136,136)">--</span><br style=3D"color:rgb(136,136,136)"><span s=
tyle=3D"color:rgb(136,136,136)">Michael Halstead</span><br style=3D"color:r=
gb(136,136,136)"><span style=3D"color:rgb(136,136,136)">Linux Foundation / =
Yocto Project</span><br style=3D"color:rgb(136,136,136)"><span style=3D"col=
or:rgb(136,136,136)">Systems Operations Engineer</span><br></div><div><br><=
/div></div>
</blockquote></div>

--00000000000076507b05a137e391--
