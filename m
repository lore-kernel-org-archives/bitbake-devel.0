Return-Path: <pinganddu90@gmail.com>
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com
	[209.85.161.180])
	by mail.openembedded.org (Postfix) with ESMTP id A98927307C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Mar 2017 08:41:04 +0000 (UTC)
Received: by mail-yw0-f180.google.com with SMTP id d1so75889474ywd.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Mar 2017 00:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=EAfoNOlyYOJYsDlkpJgXfgH3cOpaRowb/LQk5auJjD8=;
	b=PozbwRemNRT0qA3ZC42bOHb4mv3y7WQlZIOdQSvPCvTKANbQ7Qm11/oXQMUMl4cYn8
	OD05mXAKOD0QFHFrd2hxEipDcnBkj06dljW23dtNUxgE61NMGuw4FZ8S5AkR2pNhmJ1w
	5RAbF2xLz31+P91xnivz0sn6fDLLBYlilpNGXjYvex6QJN8Dc8BTjqnz9Zwu0oyGGvRq
	xGN3kOVb4ER8+eIjM72SMGT1vn8rcf+2gwm0Ks3MvXd7SskZqY6WOyxhDSa7aOin1IHf
	YuztpvyVKsC7uTTbVyfsuPvpBQf8QBfMKuzfB0b32rYpNTnCPxrREsIzBLn6HUUtrNRE
	zegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=EAfoNOlyYOJYsDlkpJgXfgH3cOpaRowb/LQk5auJjD8=;
	b=uXtKEI2lbKOv8RKoJKdd7hz6jIUuesYbyVF9AGypnXqbXXFD33taVVNVFwHClg7su5
	x+pehSe4jAuZSNSiQkwjCaZ+1imwWo7x2cQXN84zc4RlzVMWhc0dFMl/yLkXJhpRjt6E
	9+m7IHxXJ4/lPqwmlbQkmK1VGVNiCPaX0GKvGzkV6QZK2J20B/76X2m2j03TyeobZe7w
	zvYD4EwhNtqIzMlSymTHXpygAKakoQiXT4KD6h9CqOuaCOopTymnRYygwRrEOs5TX5eX
	jsj/vw7BefbTn4cykNM/Vdm62bZI8eNwfllQdTcjm41oSRG4/azqSDlGycXh1lFP9LWy
	2eTA==
X-Gm-Message-State: AMke39lMsUPmjCMj5sksBtu9oUpFvucZ76QYrJ9d6VeHacm+4E9/vZ2KilKg0KYcoBICcRkyH/q6QPynQePiMw==
X-Received: by 10.37.5.207 with SMTP id 198mr877034ybf.78.1488530466109; Fri,
	03 Mar 2017 00:41:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.12.202 with HTTP; Fri, 3 Mar 2017 00:41:05 -0800 (PST)
From: Du Dengke <pinganddu90@gmail.com>
Date: Fri, 3 Mar 2017 16:41:05 +0800
Message-ID: <CAKHP1dvb0zhmV=FgYWuyMUMpLHxEX+8a=MrZ0+WyEvzKocfBtg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: bitbake-worker: where the data come from in handle_runtask?
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
X-List-Received-Date: Fri, 03 Mar 2017 08:41:06 -0000
Content-Type: multipart/alternative; boundary=001a11c05022abbb170549cf818f

--001a11c05022abbb170549cf818f
Content-Type: text/plain; charset=UTF-8

Hi bitbake-devel

In file bitbake-worker, the function handle_runtask:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fn, task, taskname, quieterrors, appends, taskdepdata, dry_run_exec =
pickle.loads(data)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

why the "pickle.loads(data)" return 7 results, before this commit:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
58f08429 (Paul Eggleton      2016-12-16 07:09:13 +1300 428)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

it returns 6 results:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fn, task, taskname, quieterrors, appends, taskdepdata = pickle.loads(data)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

where the data come from, I want to forcus on the taskdepdata.

Thanks
pad

--001a11c05022abbb170549cf818f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi bitbake-devel<div><br></div><div>In file bitbake-worker=
, the function handle_runtask:</div><div><br></div><div>~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</div><div>fn, task, taskna=
me, quieterrors, appends, taskdepdata, dry_run_exec =3D pickle.loads(data)<=
br></div><div>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~</div><div><br></div><div>why the &quot;pickle.loads(data)&quot; retu=
rn 7 results, before this commit:</div><div><br></div><div>~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</div><div>58f08429 (Paul Eggleton =C2=A0 =
=C2=A0 =C2=A02016-12-16 07:09:13 +1300 428)<br></div><div>~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</div><div><br></div><div>it returns 6 result=
s:</div><div><br></div><div>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~</div><div>fn, task, taskname, quieterrors, appends, taskdepdata =
=3D pickle.loads(data)<br></div><div>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~</div><div><br></div><div>where the data come from, I wan=
t to forcus on the taskdepdata.</div><div><br></div><div>Thanks</div><div>p=
ad</div></div>

--001a11c05022abbb170549cf818f--
