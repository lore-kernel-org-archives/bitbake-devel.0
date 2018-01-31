Return-Path: <kamil.kuczaj@gmail.com>
Received: from mail-qt0-f173.google.com (mail-qt0-f173.google.com
	[209.85.216.173])
	by mail.openembedded.org (Postfix) with ESMTP id 08BCF7887A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Jan 2018 12:10:15 +0000 (UTC)
Received: by mail-qt0-f173.google.com with SMTP id x27so21444469qtm.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Jan 2018 04:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=vOTYr59P1nURYKbnn1b6gImromGKGkK8HyUqnNNwKwg=;
	b=KcI7WuRVKJaFAqg02eMfe/q88e4tR70wBZL4LayKdLTS7iKrLfMbzFkFVUAYSmDHTE
	6OoWkWzH7IV2nX9MUKNPeoaJMa0RrMZRF81CVWi9+ygkJPfnExrC975LBbDOSrajnQWQ
	MN8lREGfsLyjSrfDf0Q4tSs/ptvclFG7kJeW/neXFkKeJaIFszHmH8QSgZa5OanHUInU
	Tq1Q4uVIddzlBMJo+ZItskyIZJntlmZ6qdzcTRZ+gwP1RDtWO5aCxe7fI8VUqf/mGte5
	KpkZxvOUDjtObhhK0xJic9tvhwu3l181IgO93LUebda8dglphAtVNUT6nrl5DBkweJok
	LDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=vOTYr59P1nURYKbnn1b6gImromGKGkK8HyUqnNNwKwg=;
	b=EFn/ekwps4I2Sjm9jbJP6nsBeJBg4PR4V5cU6ZajCSrshFbzE76u7XN3lqQHhU8oNW
	2osf8dMaDNzCOE6huOKdTmfbeJaUD8wP+NSxUXBbFs+OeVoe7c/3RHy4n50RS5CQRlSL
	S/zUhTCkLiocA7aGDtRrzAqxv3JHv1S8fgeuB/pxRaawdE9UyvEGpizv3sYFb+8QXIPP
	u2cdSHs62kocIwI3BRwLj3jJ245m7ZHqv8J7UZZqvhRtE++jNSMIORQvArVrSNaQUA56
	On3C96bd7QdRA0kf8HJNYW+yXQ4Odm4Vn430p0bbGH2uJ6W11Wp48roVici1fk4mEhHS
	0YRw==
X-Gm-Message-State: AKwxyteO23SpFUx+8xIBokRdsBcZziVnZ0qxW0fOx+prqTgEzsP4LaEp
	H78Dta4fzOnOijDTbtmL6vk8b0I3YPwtHaFrrdTIr+H8
X-Google-Smtp-Source: AH8x225pipI6N+AS3VIUth8EFf+ZGjYjcmsXi7gshk1cI5mBlhJkKyYmGCUXhEKUCJiaO8WNwtP/BZ/a86Jun3tBq9M=
X-Received: by 10.200.23.47 with SMTP id w44mr53474513qtj.131.1517400616416;
	Wed, 31 Jan 2018 04:10:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.56.70 with HTTP; Wed, 31 Jan 2018 04:09:56 -0800 (PST)
From: Kamil <kamil.kuczaj@gmail.com>
Date: Wed, 31 Jan 2018 13:09:56 +0100
Message-ID: <CAFi8LkLEu0u67AYSS-nsWHSjsLf2aW76mU5vwm6kOqY=DS8sjA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Populating sysroot with 32 and 64-bit versions of libsystemd
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
X-List-Received-Date: Wed, 31 Jan 2018 12:10:16 -0000
Content-Type: multipart/alternative; boundary="f403045d6304b939aa0564115c72"

--f403045d6304b939aa0564115c72
Content-Type: text/plain; charset="UTF-8"

Hi,
I need to populate my image with another version of systemd. So far
everything has been using 64-bit versions of systemd without any problem.
However now I need to compile a legacy code which should be linked against
a 32-bit shared object libsystemd.so

I've managed to add the recipe lib32-systemd to the needed recipe and it is
being compiled successuflly. However when I am baking an image it tries to
install the lib32-systemd programs to the image where 64-bit systemd should
be installed. I just need the shared library to be installed to /usr/lib.

How can it be achieved?


Error:
do_rootfs: Multilib check error: duplicate files
multilib/lib32/lib/systemd/systemd-ac-power
rootfs/lib/systemd/systemd-ac-power is not the same



Best Regards,
Kamil

--f403045d6304b939aa0564115c72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>I need to populate my image with another version o=
f systemd. So far everything has been using 64-bit versions of systemd with=
out any problem. However now I need to compile a legacy code which should b=
e linked against a 32-bit shared object libsystemd.so</div><div><br></div><=
div>I&#39;ve managed to add the recipe lib32-systemd to the needed recipe a=
nd it is being compiled successuflly. However when I am baking an image it =
tries to install the lib32-systemd programs to the image where 64-bit syste=
md should be installed. I just need the shared library to be installed to /=
usr/lib.</div><div><br></div><div>How can it be achieved?</div><div><br></d=
iv><div><br></div><div>Error:</div><div>do_rootfs: Multilib check error: du=
plicate files<br></div><div>multilib/lib32/lib/systemd/systemd-ac-power<br>=
</div><div>rootfs/lib/systemd/systemd-ac-power is not the same<br></div><di=
v><br></div><div><br></div><div><br></div><div>Best Regards,</div><div>Kami=
l</div></div>

--f403045d6304b939aa0564115c72--
