Return-Path: <mhalstead@linuxfoundation.org>
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
	[209.85.210.41])
	by mail.openembedded.org (Postfix) with ESMTP id 19B6361CD9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Mar 2020 23:58:40 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id a9so12005038otl.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Mar 2020 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=mime-version:from:date:message-id:subject:to;
	bh=Rq0sYyqzUa6ve58wf9QFme0R8HeZmQUxKqKZghBzCBs=;
	b=U5cx0/pNEnncr4fatQwFkIfgicrNZl0tjvC6z9kyzPJYmEHvLUJPpzn4cGvvZ2K/Vp
	ZSDRTomXJ9UpszClcCrE/N1kXodDQhvR2HIrGd10nTkIZ6CQR/iyX/Jt5xvMLDRbnptQ
	ktphpA+hPHyYm/VzIPZQOFTKIoswseSskpER4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=Rq0sYyqzUa6ve58wf9QFme0R8HeZmQUxKqKZghBzCBs=;
	b=jBqzbqOV1fc3Reof9hS4yCpnoSGFA762LtUMuAEVw5Do74/JD53M/EBjam9VcNg9Qb
	pfGus7shHijIzjBHEP+1gT7t/4co1oa8fp9QLusmT6osP8KJi9Bf0RGfrOfcYqegPlTj
	ZvSX6RjpB1ZrKxG3gFy/391I3XUfjqiGOor+unWsyfT4ny38EYtMajCijQCMDCrdkaQB
	MF6dRwbmBAU10+k9wUUF+LGUtxa3s68mS7FYw7UDrAoEN5ivOBVVN7O07fPvEzSNxKO3
	OnG8Q7faGmWg9hT3oauuznhmxNLcUwUpItStH95d6bMuRcbJkCKZza42kLLrdUjGSXBy
	KEVA==
X-Gm-Message-State: ANhLgQ0RYOCzJXk/P5Zulg2r3zzfP7sXil95AAawOACsCfdCyRGbpmR0
	OgI6E2UWh4RHvE8w9IxOB/RePyrXddfmm/gAvSLT3jfYrxY=
X-Google-Smtp-Source: ADFU+vuaWgTdGvwte3xYfKMHJQKAmg3AtmkhbSQgebszsBl7foyE7MTvX4gl+CdkhnwRtTLO9bnXGwslBIwcBSjzXlk=
X-Received: by 2002:a05:6830:1e25:: with SMTP id
	t5mr1367081otr.70.1584143921519; 
	Fri, 13 Mar 2020 16:58:41 -0700 (PDT)
MIME-Version: 1.0
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Fri, 13 Mar 2020 16:58:30 -0700
Message-ID: <CADfgfobNNXr9HSOiwyamzbZ4q1uc8wgD5PzobDF56cDyYui-HQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org, 
	openembedded-core <openembedded-core@lists.openembedded.org>, 
	openembedded-architecture@lists.openembedded.org, 
	openembeded-devel <Openembedded-devel@lists.openembedded.org>
Subject: Mailing list platform change March 20th
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
X-List-Received-Date: Fri, 13 Mar 2020 23:58:41 -0000
Content-Type: multipart/alternative; boundary="000000000000b7349905a0c53f33"

--000000000000b7349905a0c53f33
Content-Type: text/plain; charset="UTF-8"

We are moving our lists from Mailman to Groups.io. E-mail to lists will be
delayed during the move window. We are aiming to complete the migration
during business hours in the Pacific time zone.

A new account will be created for you on the Groups.io platform if you
don't already have one.

You can read more about the change on the wiki:
https://www.openembedded.org/wiki/GroupsMigration

If there are serious issues we will rollback the changes. We will e-mail
all lists when work is complete.

--
Michael Halstead
Linux Foundation / Yocto Project
Systems Operations Engineer

--000000000000b7349905a0c53f33
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>We are moving our lists from Mailman to=C2=A0<span cl=
ass=3D"gmail-il">Groups</span>.<span class=3D"gmail-il">io</span>. E-mail t=
o lists will be delayed during the move window. We are aiming to complete t=
he migration during business hours in the Pacific time zone.<br></div><div>=
<br></div><div>A new account will be created for you on the=C2=A0<span clas=
s=3D"gmail-il">Groups</span>.<span class=3D"gmail-il">io</span>=C2=A0platfo=
rm if you don&#39;t already have one.<br></div><div><br></div><div>You can =
read more about the change on the wiki:<br></div><a href=3D"https://www.ope=
nembedded.org/wiki/GroupsMigration">https://www.openembedded.org/wiki/Group=
sMigration</a><br><div><br></div><div>If there are serious issues we will r=
ollback the changes. We will e-mail<br>all lists when work is complete.<br>=
</div><div><br></div><div><span style=3D"color:rgb(136,136,136)">--</span><=
br style=3D"color:rgb(136,136,136)"><span style=3D"color:rgb(136,136,136)">=
Michael Halstead</span><br style=3D"color:rgb(136,136,136)"><span style=3D"=
color:rgb(136,136,136)">Linux Foundation / Yocto Project</span><br style=3D=
"color:rgb(136,136,136)"><span style=3D"color:rgb(136,136,136)">Systems Ope=
rations Engineer</span><br></div><div><br></div></div>

--000000000000b7349905a0c53f33--
